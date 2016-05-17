--[[
     敌军士兵
--]]
local Sodier
Sodier=GameUtils.createObjectByClone(Person)
--给Sodier添加自有的属性和方法

Sodier.MessageType={
  close_hero=1, --接近英雄
  attack_hero=2,--攻击英雄
  drop_blood=3, --掉血
  hit_back=4,   --被击后退
}

--[[
    使用new()方法创建一个Sodier对象
    @param: type [1,2,3,4] 4种士兵种类
--]]
function Sodier.new()
	local re=GameUtils.createObjectByClone(Sodier)
    return re 
end
--[[
    根据士兵的名字[bb1,bb2,bb3,bb4]来初始化士兵
--]]
function Sodier:initWithSodierName(name)
	local SodierInitTB = PersonConfig.getPersonInfoTableByNameAndType(3,name)
	self._name=SodierInitTB._name
	self._type=SodierInitTB._type
	self._speed=SodierInitTB._speed
	self._blood=SodierInitTB._blood
	self._attackDamage=SodierInitTB._attackDamage
	self._sprite=display.newSprite(SodierInitTB._initpng)
  self._sprite._module = self 
  self._attackTarget=nil --士兵的攻击目标(对象的引用)
	--影子
	local shandow= display.newSprite("shandow.png",150,300-(self._sprite:getContentSize().height/2)*1.5+20)
	:addTo(self._sprite)
	--动作
	self.Sodier_runAnimation=display.newAnimation(display.newFrames(name .. "_run%d.png",0,8),0.1):retain()
	self.Sodier_attackAnimation=display.newAnimation(display.newFrames(name .. "_attack%d.png",0,8),0.1):retain()
	self.Sodier_combatAnimation=display.newAnimation(display.newFrames(name.."_combat%d.png",0,4),0.1):retain()
	self.Sodier_attackedAnimaton=display.newAnimation({display.newSprite(name.."_attacked.png"):getSpriteFrame()},0.2):retain()
	
  self.bg=nil --士兵所在背景
  self.close_action=nil --士兵接近目标的动作
  self:addStateMachine()
  self:addAttackedBox()
	return self
end
--[[
   添加受击碰撞检测盒
--]]

function Sodier:addAttackedBox()
  self._attackedBox = cc.PhysicsBody:createBox(cc.size(80, 100),cc.PhysicsMaterial(0.1,0.5,0.5),cc.p(18,-20))
  self._attackedBox:setMass(0.1)
  self._attackedBox:setGroup(-1) --受击组别 和英雄一样都设为-1，防止碰撞

  self._attackedBox:setCategoryBitmask(0xffffffff)--设置类别掩码
  self._attackedBox:setCollisionBitmask(0x00000000) --设置碰撞测试掩码 无法碰撞
  self._attackedBox:setContactTestBitmask(0xffffffff) --设置接触测试掩码 能够接触，同一个刚体上的形状不会发生碰撞和接触
  
  self._sprite:setPhysicsBody(self._attackedBox)
end
--[[
    设置攻击碰撞检测盒
--]]
function Sodier:setAttackBox(width, height, offset)
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
    通过该方法给士兵设置攻击对象
--]]
function Sodier:setAttackTarget(target)
  self._attackTarget = target 
  return self 
end
function Sodier:pos(x, y)
	self._sprite:pos(x,y)
  return self
end
function Sodier:addTo(taget)
	self._sprite:addTo(taget)
	return self
end
function Sodier:setScaleX(x)
  self._sprite:setScaleX(x)
  return self 
end
function Sodier:doEvent(event)
  if self.fm:canDoEvent(event) then
    self.fm:doEvent(event)
  end
end
--[[
   给士兵添加状态机
--]]
function Sodier:addStateMachine()
	self.fm={}
	cc.GameObject.extend(self.fm):addComponent("components.behavior.StateMachine")
	                             :exportMethods()
	self.fm:setupState({
        initial="idle",
        events={
          {name="idle",from={"run","attack","attacked"},to="idle"},
          {name="run",from={"idle","attack","attacked"},to="run"},
          {name="attack",from={"run","idle","attacked"},to="attack"},
          {name="attacked",from={"run","idle","attack"},to="attacked"}
        },
        callbacks={
          onenteridle=function() 
            self._sprite:stopAllActions()
            self._sprite:playAnimationForever(self.Sodier_combatAnimation)
          end,
          onenterrun=function()
            self._sprite:stopAllActions()
            self._sprite:playAnimationForever(self.Sodier_runAnimation)
          end,

          onenterattack=function()
            self._sprite:stopAllActions()
            self._sprite:playAnimationForever(self.Sodier_attackAnimation)
          end,
  
          onenterattacked=function()
            self._sprite:stopAllActions()
            self._sprite:playAnimationForever(self.Sodier_attackedAnimaton)
          end,
    }
		})
end
--[[
   对传过来的消息进行处理
--]]
function Sodier:responseMSG(msg)
  if msg.type==Sodier.MessageType.close_hero then
     self:closeTarget()
    elseif msg.type==Sodier.MessageType.attack_hero then
     self:attackTarget()
    elseif msg.type==Sodier.MessageType.drop_blood then
        --掉血
    elseif msg.type==Sodier.MessageType.hit_back then
       --被击后退
  end
end
--[[
   士兵接近目标
--]]
function Sodier:closeTarget() --士兵接近攻击目标
  if not self._attackTarget.fm:getState() == "run" then
    return 
  end
  local target_pos=self._attackTarget:getPosInBG()
  local sodier_pos=self:getPos()
  --当距离超过100像素后开始追击
  if GameUtils.distance(target_pos,sodier_pos) < 100 then
    return 
  end
  self:doEvent("run")
  --获取（背景上的）目标位置
  self._sprite:stopAction(self.close_action)
  self.close_action = nil
  local delt_x = 0
  local delt_y = 0 --士兵最后与目标的距离 
  --改变小兵的朝向，默认是向右
  if target_pos.x <= sodier_pos.x then --目标在士兵左边
    self:setScaleX(-1)
    delt_x = 80
  else                                 --目标在士兵右边
    self:setScaleX(1)
    delt_x = -80
  end
  --随机选择y轴方向上的距离
  math.randomseed(os.clock())
  local loc = math.random(1,3)
  if loc == 1 then
    delt_x=delt_x*1.2
    delt_y=20
  elseif loc == 2 then
    delt_x=delt_x*1.3
    delt_y=0
  else
    delt_x=delt_x*1.4
    delt_y=-20
  end
  self.close_action = cc.MoveTo:create(GameUtils.distance(sodier_pos,target_pos)/self._speed*0.1, cc.p(target_pos.x+delt_x,target_pos.y+delt_y))
  self._sprite:runAction(self.close_action)
end
--[[
     士兵攻击目标
--]]
function Sodier:attackTarget()
  print("士兵攻击目标")
end
--[[
     士兵掉血
--]]
function Sodier:dropBlood()
  print("士兵掉血")
end
--[[
     士兵被击退
--]]
function Sodier:hitBack()
    print("士兵被击退")
end
return Sodier