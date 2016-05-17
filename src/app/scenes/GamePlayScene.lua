--[[
     游戏的主要打斗场景
     分为三层:
      1 场景底层放置背景地图和可移动单位，以及血条，弹出的文字信息等，
      2 再上一层layer接受玩家外部的手势输入
--]]
local GamePlayScene = class("GamePlayScene", function() 
      return display.newPhysicsScene("GamePlayScene")
	end)
RedQueen = require("app.Module.RedQueen")
function GamePlayScene:ctor()
  
  self.world=self:getPhysicsWorld()--物理世界
  self.world:setGravity(cc.p(0,0))--设置物理世界的重力
  self.world:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)--显示辅助线

  --添加物理边界,物理边界需要Node或Node的子类传递
  local wallBox = display.newNode()
  wallBox:setAnchorPoint(cc.p(0.5,0.5))
  wallBox:setPhysicsBody(
           cc.PhysicsBody:createEdgeBox(cc.size(display.width, display.height))
          )
  wallBox:pos(display.cx, display.cy)
  self:addChild(wallBox)

	self.hero=nil
	self.touchLayer=nil
--添加背景大地图
  self.backGround=display.newSprite(SceneConfig.levelBackGroundBG[GameRunningData.currentLevel])
                :setAnchorPoint(cc.p(0,0))
                :pos(0, 0)
                :addTo(self)
 --添加最底层
 self:init()
 --添加触摸层
 self:addTouchLayer()
end
--[[
   初始化英雄，小怪，敌将
--]]
function GamePlayScene:init()
   self.hero=Hero.new()
           :initWithHeroName(GameRunningData.ChoosedHeroName)
           :pos(200,230)
           :addTo(self)
           :idle()
   self.hero.bg=self.backGround--hero有bg的引用

   -- self.sodier1=Sodier.new()
   --              :initWithSodierName("bb1")
   --              :pos(500, 200)
   --              :addTo(self.backGround)
   --              :setAttackTarget(self.hero) --设置攻击对象
   -- self.sodier1.bg=self.backGround  
   -- self.sodier1:responseMSG({type=Sodier.MessageType.close_hero})  
   RedQueen.bg=self.backGround
   RedQueen.attack_target=self.hero

   scheduler.scheduleGlobal(handler(self,GamePlayScene.informQueen), 0.1) --调度器里将战场情况反馈个redqueen

   --监听物理世界的碰撞
    local onContactBegin = function(event)
     print("ShapeA:"..GameUtils.getModuleOfNode(event:getShapeA():getBody():getNode())._name)
     print("ShapeB:"..GameUtils.getModuleOfNode(event:getShapeB():getBody():getNode())._name)
     return true
    end
    self.physics_listener = cc.EventListenerPhysicsContact:create()
    self.physics_listener:registerScriptHandler(onContactBegin,cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    local dispatch = cc.Director:getInstance():getEventDispatcher()
    dispatch:addEventListenerWithSceneGraphPriority(self.physics_listener,self)
end 
--[[
   将触摸层加入到场景里
--]]
function GamePlayScene:addTouchLayer()
	self.touchLayer=touchLayer.new()
	self.touchLayer:addTo(self)
  self.touchLayer.hero=self.hero 
  --touchLayer里有一个hero的引用，用于touchLayer向hero发送消息让hero执行命令
end
--[[
    游戏场景将当前情形数据告诉红桃皇后
--]]
function GamePlayScene:informQueen()
   RedQueen:thinking()
end
return GamePlayScene