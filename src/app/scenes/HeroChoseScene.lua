--[[
    该场景是英雄选择场景
--]]
local HeroChoseScene = class("HeroChoseScene", function()
	  return display.newScene("HeroChoseScene")
	end)
 function HeroChoseScene:ctor()
     self:init()
 end
 function HeroChoseScene:init( )
 	--加载人物选择背景音乐
 	audio.preloadMusic("heroChoose.mp3")
 	audio.playMusic("heroChoose.mp3", true)
 	--显示人物选择卡片
   --获取三个人物的纹理名称数组
   self.pics= SceneConfig.gameLoadSceneRCList.heroChoosePics
 	 --马超
 	 local heroBtn1 = cc.ui.UIPushButton.new({normal=self.pics[1]}) --UIPushButton的ContentSize是（0，0）
 	       heroBtn1:pos(display.width/6,display.top+display.height/2)
 	               :setName("machao")
 				   :onButtonClicked(HeroChoseScene.chooseClicked)
 	               :addTo(self)
 	               :runAction(cc.MoveTo:create(1, cc.p(display.width/6,display.cy)))
 	 --小乔
 	 local heroBtn2 = cc.ui.UIPushButton.new({normal=self.pics[2]})
 	       heroBtn2:pos(display.width/2,display.bottom-display.height/2)
 	               :setName("xiaoqiao")
 	               :onButtonClicked(HeroChoseScene.chooseClicked)
  	               :addTo(self)	               
 	               :runAction(cc.MoveTo:create(1, cc.p(display.width/2,display.cy)))

 	 --黄忠
 	 local heroBtn3 = cc.ui.UIPushButton.new({normal=self.pics[3]})
 	       heroBtn3:pos(display.width*5/6, display.top+display.height/2)
 	               :setName("huangzhong")
 	               :onButtonClicked(HeroChoseScene.chooseClicked)
  	               :addTo(self)	               
 	               :runAction(cc.MoveTo:create(1, cc.p(display.width*5/6,display.cy)))
 	 --添加键盘监听
 	 self:addKeyListener()

 end
--[[
     英雄按钮点击后触发
--]]
 function HeroChoseScene.chooseClicked(event) 
   GameRunningData.ChoosedHeroName = event.target:getName()
   GameRunningData.currentLevel = 1
   --释放三张人物选择卡片的纹理
   local pics=event.target:getParent().pics
   for i=1,#pics do
        cc.SpriteFrameCache:getInstance():removeSpriteFrameByName(pics[i])
   end
   --停止和释放背景音乐资源
   audio.stopMusic(true)
   --进入第一关的加载界面
   local level1_loadingScene = PreGamePLayScene.new()
   display.replaceScene(level1_loadingScene)
 end
--[[
    该函数添加键盘监听，呼出退出游戏提示界面  
--]]
 function HeroChoseScene:addKeyListener()
    self:setKeypadEnabled(true)
    self:addNodeEventListener(cc.KEYPAD_EVENT,function(event) 
    	   if event.key == "back" then
    	   	 print("do you want to leave ")
    	   	 --弹出提示退出layer
    	   end
     	end)
 end
 return HeroChoseScene