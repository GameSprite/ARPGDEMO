--[[
    游戏关卡开始前的预加载场景
--]]
local PreGamePLayScene = class("PreGamePLayScene", function ( ... )
	return display.newScene("PreGamePLayScene")
end)

function PreGamePLayScene:ctor()
	self.level=GameRunningData.currentLevel
	self.heroName=GameRunningData.ChoosedHeroName
	self.enermyName=SceneConfig.enermyNames[self.level]
	self:init()
	self:preLoadResource()
end

function PreGamePLayScene:init()
 --    local bgName=SceneConfig.levelLoadSceneRCList.backGroundPic[self.level]
	-- --加载背景图片
 --   local bg = display.newSprite(bgName,display.cx,display.cy)
 --          :addTo(self)
  
   self:loadEffect("loadman1.plist","loadman1.png",1,5)
end 
--[[
    播放加载小特效
    @param:
       plistfile:序列帧大图的配置文件名
       picturefile:材质图片名
       start:起始值
       length:帧数
--]]
function PreGamePLayScene:loadEffect(plistfile,picturefile,begin,length)
    display.addSpriteFrames(plistfile,picturefile)
    local sp_name="#"..string.sub(picturefile,1,#picturefile-4).."_1.png"
    local fr_patten=string.sub(picturefile,1,#picturefile-4).."_%d.png"
    local loadman= display.newSprite(sp_name,display.right-100, display.bottom+100)
                  :setScaleX(0.7)
                  :setScaleY(0.7)
                  :addTo(self)
    local frames = display.newFrames(fr_patten, begin,length)
    local animation = display.newAnimation(frames, 0.1)
    loadman:playAnimationForever(animation, 0)

    local loadLabel =display.newTTFLabel({text="加载中...",font="fanxinkai.ttf",size=30,color=cc.c3b(255, 215, 0),align=cc.TEXT_ALIGNMENT_CENTER})
                     :pos(display.cx, display.bottom+100)
                     :addTo(self)
    local blin=cc.RepeatForever:create(cc.Blink:create(1,1))
    loadLabel:runAction(blin)
end
--[[
    加载接下来的打斗关卡需要的资源
--]]
function PreGamePLayScene:preLoadResource()
   --加载资源
    --加载背景音乐
    local musicName=SceneConfig.levelLoadSceneRCList.backMusic[self.level]
    audio.preloadMusic(musicName)
    --播放
    audio.playMusic(musicName, true)	
    --加载所选英雄的资源
    local heroInfoTB = PersonConfig.getPersonInfoTableByNameAndType(1,self.heroName)--获取英雄配置信息
    GameUtils.addSpriteFramesByTable(heroInfoTB._spriteRes)
    --加载敌将的资源
    local enermyTB = PersonConfig.getPersonInfoTableByNameAndType(2,self.enermyName)
    GameUtils.addSpriteFramesByTable(enermyTB._spriteRes)
    --加载小兵的资源
     --获取小兵配置(类型和数量)
     local sodierTB=SceneConfig.sodiersConfig[self.level]
     --根据小兵配置加载资源
     for i,v in ipairs(sodierTB) do
       --计算该种类兵种共投放多少个
       local sodier_nums = 0
       for j=1,3 do
         sodier_nums=sodier_nums+v[j]
       end

     	if sodier_nums>0 then
     		--获取小兵资源
     	  local src_tb=PersonConfig.getPersonInfoTableByNameAndType(3,"bb"..i)
            --加载
     	  GameUtils.addSpriteFramesByTable(src_tb._spriteRes)
     	end

     end
    --加载技能资源
     --加载技能图标
     local spellIconTB=SceneConfig.levelLoadSceneRCList.spellIcons
     display.addSpriteFrames(spellIconTB.plist, spellIconTB.png)
     --加载技能效果sprite sheet
   --延迟
   local delay=cc.DelayTime:create(3)
   local callfunc=cc.CallFunc:create(PreGamePLayScene.toNextScene)
   --跳转
   self:runAction(cc.Sequence:create(delay,callfunc))

end
function PreGamePLayScene:toNextScene()
	 local playScene = GamePlayScene.new()
	 display.replaceScene(playScene)
end

return PreGamePLayScene