--[[
    当手机退出键，或者键盘esc键被点击，该 退出提示 布景层被弹出
--]]

local quitLayer = class("quitLayer", function() 
      return display.newColorLayer(cc.c4b(0, 0, 0, 0))
	end)

function quitLayer:ctor()

end

return quitLayer