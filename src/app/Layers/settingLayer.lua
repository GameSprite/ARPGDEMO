--[[
    当游戏中的设置按钮被点击，该设置 布景层被弹出
--]]

local settingLayer = class("settingLayer", function() 
        return display.newColorLayer(cc.c4b(0, 0, 0, 0))
	end)

function settingLayer:ctor()
end

return settingLayer