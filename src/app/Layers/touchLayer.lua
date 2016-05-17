--[[
     游戏的战斗场景 GamePlayScene中最上层的一层接受用户触摸的layer，里边放置摇杆layer)
     和技能槽node(屏幕右下方)，以及暂停、设置按钮(两者都在右上方)
--]]
local touchLayer = class("touchLayer", function() 
      return display.newLayer()
	end)
scheduler=require("framework.scheduler")

function touchLayer:ctor()
  self.hero=nil --touchLayer有hero的引用
  self:init()
end

function touchLayer:init()
  --添加摇杆
  self.rocker = RockerLayer.new()
               :addTo(self)

  --添加从csb文件添加技能槽
   local spellsNode=cc.uiloader:load("SpellNode.csb")
                    :addTo(self)
   local attack_btn=spellsNode:getChildByName("attack")
   local spell_btn1=spellsNode:getChildByName("spell_circle_1"):getChildByName("spell_btn1")
   local spell_btn2=spellsNode:getChildByName("spell_circle_2"):getChildByName("spell_btn2")
   local spell_btn3=spellsNode:getChildByName("spell_circle_3"):getChildByName("spell_btn3")
   local spell_btn4=spellsNode:getChildByName("spell_circle_4"):getChildByName("spell_btn4") 
   --对技能按钮的位置做微调
   local cur_posx=spell_btn1:getPositionX()
   spell_btn1:setPositionX(cur_posx+1.2)
   spell_btn2:setPositionX(cur_posx+1.2)
   spell_btn3:setPositionX(cur_posx+1.2)
   spell_btn4:setPositionX(cur_posx+1.2)
   --给4个技能按钮加载技能图片
  local spellsIcons=PersonConfig.getPersonInfoTableByNameAndType(1,GameRunningData.ChoosedHeroName).spellIcons
   spell_btn1:loadTextureNormal(spellsIcons[1],1)
   spell_btn2:loadTextureNormal(spellsIcons[2],1)
   spell_btn3:loadTextureNormal(spellsIcons[3],1)
   spell_btn4:loadTextureNormal(spellsIcons[4],1)
   --设置技能按钮回调
   attack_btn:addClickEventListener(function()
     --向hero的引用发送"普通攻击的消息"消息
       self.hero:responseMSG({type=Hero.MessageType.attack})
    end)
   spell_btn1:addClickEventListener(function()
     self.hero:responseMSG({type=Hero.MessageType.cast_spell1})
    end)
   spell_btn2:addClickEventListener(function()
     self.hero:responseMSG({type=Hero.MessageType.cast_spell2})
    end)
   spell_btn3:addClickEventListener(function()
     self.hero:responseMSG({type=Hero.MessageType.cast_spell3})
    end)
   spell_btn4:addClickEventListener(function()
     self.hero:responseMSG({type=Hero.MessageType.cast_spell4})
    end)

  --监听触摸控件的状态
  scheduler.scheduleGlobal(handler(self, touchLayer.monitor), 0.1)
end      
--[[
   监测方向
--]]
function touchLayer:monitor()
 self.direction=self.rocker.move
  if self.direction==5 then --初始状态是5
    return 
  end
    if self.direction==0 then
      self.hero:responseMSG({type=Hero.MessageType.stand})
    elseif self.direction==1 then
     self.hero:responseMSG({type=Hero.MessageType.move_right})
    elseif self.direction == 2 then
     self.hero:responseMSG({type=Hero.MessageType.move_left})
    elseif self.direction == 3 then
     self.hero:responseMSG({type=Hero.MessageType.move_up})
    elseif self.direction == 4 then
     self.hero:responseMSG({type=Hero.MessageType.move_down})
  end
end
return touchLayer