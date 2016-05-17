--[[
    玩家选择的角色
--]]
local Hero

 Hero=GameUtils.createObjectByClone(Person)
 --接下来定义Hero对象能够接收的消息
 Hero.MessageType={
                --由触摸层发过来的消息
  stand=1,
  move_left=2,
  move_right=3,
  move_up=4,
  move_down=5,
  attack=6,
  cast_spell1=7, --释放技能
  cast_spell2=8,
  cast_spell3=9,
  cast_spell4=10,
                --以下是被攻击时由攻击者发过来的消息
  loseBlood=11, --此类技能效果为掉血，还可以扩展击退，减速，冻结，沉默等技能效果
                
}
--[[
    使用new方法创建一个Hero的对象
--]]
function Hero.new()
    local re=GameUtils.createObjectByClone(Hero)
    return re 
end
--[[
    使用init来初始化一个Hero对象,init方法中回去英雄的配置文件中读取信息用于初始化英雄对象
    @param: name:英雄的名字
--]]
function Hero:initWithHeroName(name)
   assert(type(name) == "string","Hero.lua:line 13: params should be a string")
   --获取创建资源表
   local heroInfoTB = PersonConfig.getPersonInfoTableByNameAndType(1,name)--获取英雄配置信息
    --GameUtils.addSpriteFramesByTable(heroInfoTB._spriteRes) --测试结束后删掉
   self._name=heroInfoTB._name
   self._type=heroInfoTB._type
   self._speed=heroInfoTB._speed
   self._blood=heroInfoTB._blood
   self._attackDamage=heroInfoTB._attackDamage
   self._sprite=display.newSprite(heroInfoTB._initpng)
   self._sprite._module = self 
   --添加影子
   local shandow= display.newSprite("shandow.png",150,300-(self._sprite:getContentSize().height/2)*1.5+20)
                :addTo(self._sprite)
   --初始化受击rect
     --需要实际测量

    --初始化各个动画的帧长度
    self.sp1Length=heroInfoTB._spriteRes.spells[1].length
    self.sp2Length=heroInfoTB._spriteRes.spells[2].length
    self.sp3Length=heroInfoTB._spriteRes.spells[3].length
    self.sp4Length=heroInfoTB._spriteRes.spells[4].length
    self.runLength=heroInfoTB._spriteRes.run.length
    self.idleLength=heroInfoTB._spriteRes.idle.length
    self.attackLength=heroInfoTB._spriteRes.attack.length
    self.combatLength=heroInfoTB._spriteRes.combat_idle.length 
    --初始化各个动作
  
    self.runAnimation=display.newAnimation(display.newFrames(name.."_run%d.png", 0,self.runLength),0.1):retain()
    self.idleAnimation=display.newAnimation(display.newFrames(name.."_idle%d.png", 0, self.idleLength),0.25):retain()
    self.combatAnimation=display.newAnimation(display.newFrames(name.."_combat%d.png", 0, self.combatLength),0.05):retain()
    self.attackAnimation=display.newAnimation(display.newFrames(name.."_attack%d.png", 0, self.attackLength),0.05):retain()
    self.attackedAnimation=display.newAnimation({display.newSprite(name.."_attacked.png"):getSpriteFrame()},0.2):retain()
    self.spell1Animation=display.newAnimation(display.newFrames(name.."_spell1_%d.png", 0, self.sp1Length), 0.1):retain()
    self.spell2Animation=display.newAnimation(display.newFrames(name.."_spell2_%d.png", 0, self.sp2Length), 0.1):retain()
    self.spell3Animation=display.newAnimation(display.newFrames(name.."_spell3_%d.png", 0, self.sp3Length), 0.1):retain()
    self.spell4Animation=display.newAnimation(display.newFrames(name.."_spell4_%d.png", 0, self.sp4Length), 0.1):retain()
 
    self:addStateMachine()

    self:addAttackedBox()

    self.canMove=false --是否可以移动
    self.moveAreaRect=SceneConfig.activeRect[GameRunningData.currentLevel]--可移动范围
  return self
end
--[[
   受击检测碰撞盒
--]]
function Hero:addAttackedBox()
  self._attackedBox = cc.PhysicsBody:createBox(cc.size(100, 120),cc.PhysicsMaterial(0.1,0.5,0.5),cc.p(0,0))
  self._attackedBox:setMass(0.1)
  self._attackedBox:getFirstShape():setTag(1) --获取第一个形状也就是受击形状，设置Tag为1
  self._attackedBox:setGroup(-1)

  self._attackedBox:setCategoryBitmask(0xffffffff)
  self._attackedBox:setCollisionBitmask(0x00000000)
  self._attackedBox:setContactTestBitmask(0xffffffff)

  self._sprite:setPhysicsBody(self._attackedBox)
end
--[[
   设置攻击检测碰撞盒
   @param width:长方形shape的宽度
          height:长方形shape的高度
          offset:vec2类型，偏移位置
--]]
function Hero:setAttackBox(width,height,offset)
  local dir = self._sprite:getScaleX() --获取方向正数朝右，负数朝左边
  if dir < 0 then
    dir = -1
  else
    dir = 1
  end
   self._attackBox=cc.PhysicsShapeBox:create(cc.size(width,height),cc.PhysicsMaterial(0.1,0.5,0.5),cc.p(dir*offset.x,offset.y))
   self._attackBox:setTag(2) 
   self._attackBox:setGroup(1)

   self._attackBox:setCategoryBitmask(0xffffffff)--设置类别掩码
   self._attackBox:setCollisionBitmask(0x00000000) --设置碰撞测试掩码 无法碰撞
   self._attackBox:setContactTestBitmask(0xffffffff) --设置接触测试掩码 能够接触，同一个刚体上的形状不会发生碰撞和接触
   
   self._sprite:getPhysicsBody():addShape(self._attackBox)
end
--[[
   移除攻击检测碰撞盒
--]]
function Hero:removeAttackBox( )
  self._sprite:getPhysicsBody():removeShape(2)
end
--[[
    设置Hero对象的精灵在游戏界面上的位置
    @param:_x x坐标
    @param:_y y坐标
--]]
function Hero:pos(_x, _y)
  self._sprite:pos(_x, _y)
  return self 
end
--[[
    获取英雄在背景精灵上的位置
--]]
function Hero:getPosInBG()
  local world_pos=self:getPos()
  return self.bg:convertToNodeSpaceAR(world_pos)
end
--[[
    将Hero对象的精灵加入到一个节点的节点上
    @_node 父节点
--]]
function Hero:addTo(_node)
  self._sprite:addTo(_node)
  return self 
end

function Hero:doEvent(event)
  if self.fm:canDoEvent(event) then
    self.fm:doEvent(event)
  end
end
--[[
    给Hero对象添加状态机机制
--]]

function Hero:addStateMachine()
  self.fm={}
  cc.GameObject.extend(self.fm):addComponent("components.behavior.StateMachine")
                               :exportMethods()
  self.fm:setupState({
    initial="idle",
    events={
      {name="idle",from={"run","combat"},to="idle"},
      {name="combat",from={"spell_1","spell_2","spell_3","spell_4","attack"},to="combat"},
      {name="move",from={"combat","idle"},to="run"},
      {name="atk",from={"idle","run"},to="attack"},
      {name="atked",from={"idle","run","attack","spell_1","spell_2","spell_3","spell_4","combat"},to="attacked"},
      {name="sp1",from={"idle","run"},to="spell_1"},
      {name="sp2",from={"idle","run"},to="spell_2"},
      {name="sp3",from={"idle","run"},to="spell_3"},
      {name="sp4",from={"idle","run"},to="spell_4"},
    },
    callbacks={
      onenteridle=function()
         self:idle()
      end,
      onenterattack=function()
         self:attack()
      end,
      onleaveattack=function ( )
        self:removeAttackBox() --移除攻击包围盒
      end,
      onenterattacked=function()
         self:attacked()   
      end,
      onenterrun=function()
         self.canMove=true
         self:run()
      end,
      onleaverun=function()
         self.canMove=false
      end,
      onenterspell_1=function()
         self:spell_1()
      end,
      onenterspell_2=function()
         self:spell_2()
      end,
      onenterspell_3=function()
         self:spell_3()
      end,
      onenterspell_4=function()
         self:spell_4()
      end,
      onentercombat=function()
        self:combat()
      end
    },
    })
end
--[[
   让Hero的对象作为受众去响应消息,在这个方法里，会综合英雄当前所处的状态和消息来判断下一步的行为,英雄状态的改变全部从
   该函数进入和处理
   @param:message table数组类型，具有以下字段
    没有value字段，说明是触摸层传来的消息
    message={
      {
      type="cast_spell1", --释放技能1
      }
    }
    有value字段，说明是敌方单位传过来的消息
     message={
     {
      type="loseBlood",
      value=200
     }
    }
--]]
function Hero:responseMSG(message)
  assert(type(message)=="table","Hero.lua:line 84:Hero:responseMSG():param message is not a table")
  local bgPosition -- 背景图片相对于屏幕的位置
  local heroPosition --人物在屏幕上的位置
  local pointByBG  --人物坐标相对于背景精灵的坐标
  local left_bounds --人物在背景上的左边界线
  local right_bounds --人物在背景上的右边界线
  local up_bounds --人物上边线
  local down_bounds --人物下边线

   if message.type>1 and message.type <6 then --设计移动操作
       bgPosition={}
       bgPosition.x,bgPosition.y=self.bg:getPosition()
       heroPosition=self:getPos()
       pointByBG = self.bg:convertToNodeSpaceAR(heroPosition) 
       left_bounds=0
       right_bounds=2048
       up_bounds=self.moveAreaRect.y+self.moveAreaRect.height
       down_bounds=self.moveAreaRect.y
   end


  if message.type == Hero.MessageType.move_left then --向左
    self._sprite:setScaleX(-1)
    self:doEvent("move")

    if self.canMove then
      if pointByBG.x <= left_bounds then --人物在背景上的相对位置在左边界线左侧时无法移动
        return 
      end
      if heroPosition.x>960/3 or (bgPosition.x == 0 and heroPosition.x<=960/3 ) then
        --只有人物向左移动
        self._sprite:moveBy(0.1, -self._speed, 0)
        elseif bgPosition.x>-self._speed and bgPosition.x<0 then
          --背景+人 联合移动
          local call1=cc.CallFunc:create(function() 
              --self.bg:moveBy(-bgPosition.x/self._speed,-bgPosition.x, 0) --背景右移
              self.bg:moveTo(-bgPosition.x/self._speed*0.1, 0, 0)
           end)
          local call2=cc.CallFunc:create(function() 
              self.bg:setPositionX(0)
              self._sprite:moveBy((self._speed+bgPosition.x)/self._speed*0.1,-(self._speed+bgPosition.x), 0) --人左移
           end)
           self._sprite:runAction(cc.Sequence:create(call1,cc.DelayTime:create((self._speed+bgPosition.x)/self._speed*0.1),call2))

        elseif (bgPosition.x>=960-2048 and bgPosition.x<=-self._speed) and heroPosition.x<=960/3 then
           self.bg:moveBy(0.1, self._speed,0) --背景右移
         else
          self.bg:setPositionX(0)
      end
    end

elseif message.type== Hero.MessageType.move_right then  --向右
     self._sprite:setScaleX(1)
     self:doEvent("move")

    if self.canMove then
      
      if pointByBG.x >= right_bounds then --人物在背景上的相对位置在右边界线右侧时无法移动
        return 
      end
      
      if heroPosition.x<960*2/3 or (bgPosition.x==960-2048 and heroPosition.x>=960*2/3) then
        --只有人物向右移动
        self._sprite:moveBy(0.1, self._speed, 0)
        elseif bgPosition.x>960-2048 and bgPosition.x<960-2048+self._speed then
          local call1=cc.CallFunc:create(function() 
            --self.bg:moveBy(bgPosition.x-(960-2048)/self._speed,(960-2048)-bgPosition.x, 0) --背景左移
            self.bg:moveTo(bgPosition.x-(960-2048)/self._speed*0.1, -1088,0)
          end)
          local call2=cc.CallFunc:create(function() 
            self.bg:setPositionX(-1088)
            self._sprite:moveBy((self._speed+(960-2048-bgPosition.x))/self._speed*0.1, (self._speed+(960-2048-bgPosition.x)), 0)--人右移
          end)
          self._sprite:runAction(cc.Sequence:create(call1,cc.DelayTime:create((self._speed+(960-2048-bgPosition.x))/self._speed*0.1),call2))
        elseif (bgPosition.x>=960-2048+self._speed and bgPosition.x<=0) and heroPosition.x>=960*2/3 then
          self.bg:moveBy(0.1, -self._speed, 0) --背景左移
        else
          self.bg:setPositionX(-1088)
      end
    end
        
elseif message.type == Hero.MessageType.move_up then
      self:doEvent("move")

      if self.canMove then
        if heroPosition.y<up_bounds then
          self._sprite:moveBy(0.1,0,self._speed)
        end
      end

elseif message.type == Hero.MessageType.move_down then
      self:doEvent("move")

      if self.canMove then
        if heroPosition.y>down_bounds then
           self._sprite:moveBy(0.1, 0, -self._speed)
        end
      end
end

  if message.type == Hero.MessageType.stand then
     self:doEvent("idle")
    elseif message.type == Hero.MessageType.attack then
     self:doEvent("atk")
    elseif message.type == Hero.MessageType.cast_spell1 then
     self:doEvent("sp1")
    elseif message.type == Hero.MessageType.cast_spell2 then
     self:doEvent("sp2")
    elseif message.type == Hero.MessageType.cast_spell3 then
     self:doEvent("sp3")
    elseif message.type == Hero.MessageType.cast_spell4 then
     self:doEvent("sp4")
  end
end
 --奔跑
function Hero:run()
 self._sprite:stopAllActions()
 self._sprite:playAnimationForever(self.runAnimation, 0)
end
 --站立
function Hero:idle()
  self._sprite:stopAllActions()
  self._sprite:playAnimationForever(self.idleAnimation, 0)
  return self 
end
--普通攻击
function Hero:attack()
  self._sprite:stopAllActions()
  self._sprite:playAnimationForever(self.attackAnimation, 0)
  --设置攻击包围盒
  self:setAttackBox(80, 120,cc.p(40,0))
  --等待动画播放完毕
  local delay=cc.DelayTime:create(0.05*self.attackLength)
  local call_2=cc.CallFunc:create(function() 
     self:doEvent("combat")
    end)
   self._sprite:runAction(cc.Sequence:create(delay,call_2))
  return self 
end
-- xxx攻击时开启攻击处理，离开后关闭攻击处理 xxx-----
--受击
function Hero:attacked()
  self._sprite:stopAllActions()
  self._sprite:playAnimationForever(self.attackedAnimation, 0)
  --被击退
  local scale_x=self._sprite:getScaleX()
  local call_1=cc.CallFunc:create(function()
       self._sprite:moveBy(0.15,-50*scale_x, 0)
   end)
  --状态转移到combat
  local call_2=cc.CallFunc:create(function() 
       self:doEvent("combat")
    end)
  self._sprite:runAction(cc.Sequence:create(call_1,call_2))
  return self 
end
--攻击后休整
function Hero:combat()
  self._sprite:stopAllActions()
  self._sprite:playAnimationForever(self.combatAnimation, 0)
  --等待动画播放完毕
  local delay=cc.DelayTime:create(0.05*self.combatLength)
  local call_2=cc.CallFunc:create(function() 
     self:doEvent("idle")
    end)
   self._sprite:runAction(cc.Sequence:create(delay,call_2))
   return self 
end
--释放技能1
function Hero:spell_1()
  self._sprite:stopAllActions()
  self._sprite:playAnimationForever(self.spell1Animation, 0)
  --等待动画播放完毕
  local delay=cc.DelayTime:create(self.sp1Length*0.1)
  local call_2=cc.CallFunc:create(function() 
     self:doEvent("combat")
    end)
  self._sprite:runAction(cc.Sequence:create(delay,call_2))
  return self 
end
--释放技能2
function Hero:spell_2()
  self._sprite:stopAllActions()
  self._sprite:playAnimationForever(self.spell2Animation, 0)
  --等待动画播放完毕
  local delay=cc.DelayTime:create(self.sp2Length*0.1)
  local call_2=cc.CallFunc:create(function() 
     self:doEvent("combat")
    end)
  self._sprite:runAction(cc.Sequence:create(delay,call_2))  
  return self 
end
--释放技能3
function Hero:spell_3()
  self._sprite:stopAllActions()
  self._sprite:playAnimationForever(self.spell3Animation, 0)
  --等待动画播放完毕
  local delay=cc.DelayTime:create(self.sp3Length*0.1)
  local call_2=cc.CallFunc:create(function() 
     self:doEvent("combat")
    end)
  self._sprite:runAction(cc.Sequence:create(delay,call_2))
  return self 
end
--释放技能4
function Hero:spell_4()
  self._sprite:stopAllActions()
  self._sprite:playAnimationForever(self.spell4Animation, 0)
  --等待动画播放完毕
  local delay=cc.DelayTime:create(self.sp1Length*0.1)
  local call_2=cc.CallFunc:create(function() 
     self:doEvent("combat")
    end)
  self._sprite:runAction(cc.Sequence:create(delay,call_2))
  return self 
end
--[[
   该函数通过伤害类型进行伤害检查和判断
--]]
function Hero:damageProcess()
end

function Hero:attackedProcess()
end

return Hero 