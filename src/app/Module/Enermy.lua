--[[
     敌将
--]]

local Enermy
Enermy = GameUtils.createObjectByClone(Person)
--接下来扩展Enermy的属性和方法

--[[
    使用new方法创建一个Enermy对象
--]]
function Enermy.new()
	local re = GameUtils.createObjectByClone(Enermy)
	return re 
end
--[[
    使用init来初始化一个Hero对象,init方法中回去英雄的配置文件中读取信息用于初始化英雄对象
    @param: name:敌将的名字
--]]
function Enermy:init(name)
   assert(type(name) == "string","Enermy.lua:line 13: params should be a string")
end
return Enermy