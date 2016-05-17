 --[[ 
     该场景是游戏刚进入时的加载场景
 --]]
local GameLoadScene = class("GameLoadScene", function()
    return display.newScene("GameLoadScene")
end)

function GameLoadScene:ctor()
    self:init()
end
--全局变量
local sword_desPos  --剑形进度条的结束位置

--[[
     加载本界面需要资源
     date:2016.4.22 20:24
     author:cgz
--]]
function GameLoadScene:init()
   local bg1 = display.newSprite("GameLoadScene/load_bg1.png", display.cx, display.cy)
             : addTo(self)
   --底板 bg2
   local bg2 = display.newSprite("GameLoadScene/load_bg2.png", display.cx, display.cy)
   --模板 stencil
   local stencil = display.newSprite("GameLoadScene/cloud_stencil.png", display.cx, display.cy)
   --clippingNode
   local clipnode = cc.ClippingNode:create()
                 :pos(0, 0)
                 :setStencil(stencil) 
                 :addChild(bg2)
                 :setInverted(false)
                 :setAlphaThreshold(0.01)
                 :addTo(self)
    --模板扩大动画
    stencil:runAction(cc.ScaleTo:create(4,30))
    --添加剑形精灵，模拟进度条
    local sword_progress = display.newSprite("GameLoadScene/sword.png")
           sword_progress:pos(display.left+sword_progress:getContentSize().width/2, 100)
                         :setOpacity(200)
                         :addTo(self,3)
    sword_desPos = cc.p(display.right-sword_progress:getContentSize().width/2,100)
    --加载资源
    sword_progress:runAction(cc.Sequence:create(cc.MoveTo:create(4, sword_desPos),cc.CallFunc:create(function() 
          self:displayOthers()
      end)))

    self:loadResource()
 
end
--[[
     加载游戏背景音乐、音效、英雄选择界面图片
     date:2016.4.22 20:28
     author:cgz
--]]
function GameLoadScene:loadResource()
  --加载背景音乐
    audio.preloadMusic(SceneConfig.gameLoadSceneRCList.backMusic)
    audio.playMusic(SceneConfig.gameLoadSceneRCList.backMusic,true)
  --加载音效
    for i,v in ipairs(SceneConfig.gameLoadSceneRCList.effectSound) do
      audio.preloadSound(v)
    end
  --加载人物选择界面的三张大纹理
   for i,v in ipairs(SceneConfig.gameLoadSceneRCList.heroChoosePics) do
      cc.Director:getInstance():getTextureCache():addImage(v)
   end
end
--[[
     弹出其他游戏属性，游戏名称、进入游戏按钮
     date:2016.4.26 9:13
     author:cgz
--]]
function GameLoadScene:displayOthers()
  -- 开始按钮
    local enterBtn = cc.ui.UIPushButton.new({normal="enterGameBtn.png"})
                 :pos(display.cx, display.bottom-100)
         enterBtn:onButtonClicked(function() 
                       enterBtn:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.2, 1.2),cc.ScaleTo:create(0.1,1,1),
                      cc.CallFunc:create(
                        function() 
                           --进入英雄选择界面
                          display.replaceScene(HeroChoseScene.new())
                        end
                      )))
                  end)
                 :addTo(self)
     enterBtn:runAction(cc.MoveTo:create(1,cc.p(display.cx,display.bottom+100)))
  --游戏名称label
  --[[
      铜 186,110,64 
 18K金 234,199,135 
 24K金 218,178,115 
 未精练的金 255,180,66 
 黄金 242,192,86 
 石墨 87,33,77 
 铁 118,119,120 
 铅锡锑合金 250,250,250 
 银 233,233,216 
 钠 250,250,250 
 废白铁罐 229,223,206 
 不锈钢 128,128,126
 磨亮的不锈钢 220,220,220 
 锡 220,223,227
  --]]
  local gameNameLabel=display.newTTFLabel({text="Demo",font="caoshu.ttf",size=130,color=cc.c3b(255, 0, 0),align = cc.ui.TEXT_ALIGN_CENTER})
        gameNameLabel:pos(display.cx, display.cy+150)
                     :addTo(self)
end

return GameLoadScene

