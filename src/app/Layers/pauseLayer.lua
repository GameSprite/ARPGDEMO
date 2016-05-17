--[[
    暂停按钮被点击后，弹出暂停 布景层
--]]
local pauseLayer = class("pauseLayer", function() 
      return display.newColorLayer(cc.c4b(0, 0, 0, 0))
	end)
function pauseLayer:ctor()
	
end
return pauseLayer