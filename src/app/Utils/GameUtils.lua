--[[
  该模块主要定义了用于游戏的常用的工具方法
  date:2016.4.25 7.15
  author:cgz
--]]
module("GameUtils",package.seeall)

--[[
    通过拷贝一个表的内容来创建对象表
--]]
function createObjectByClone(parent)
	local re
	if type(parent) == "table" then
		re={}
		for k,v in pairs(parent) do
			re[k]=v
		end
    else 
    	assert(false,"module:GameUtils:createObjectByClone's param parent is not table ")
	end
	return re 
end

--[[
    打印一个表的信息
--]]
function printTable(t)
	for k,v in pairs(t) do
		print(k,v)
	end
end
--[[
   加载人物资源列表
   @param t_name: 人物资源列表
--]]
function addSpriteFramesByTable(t_name)
  for k,v in pairs(t_name) do
    if type(v) == "table" then
    	if v.png ~= nil then
    		if v.plist == nil  then
    			cc.Director:getInstance():getTextureCache():addImage(v.png)
    			--print(v.png)
    		else
               display.addSpriteFrames(v.plist,v.png) --如果plist文件有问题，会触发addSpriteFrames()中的the value type isn't Type::Map错误
               --print(v.png .." "..v.plist)
    		end
    	else
    		for i,_v in ipairs(v) do
    		    display.addSpriteFrames(_v.plist, _v.png)
    			--print(_v.png.." ".._v.plist)
    		end
    	end
    end
  end
end
--[[
     求两点的距离
     @
--]]
function distance(p1, p2)
  return math.sqrt((p1.x-p2.x)^2+(p1.y-p2.y)^2)
end
--[[
    求节点对应的模型
--]]
function getModuleOfNode(_node)
  return _node._module
end