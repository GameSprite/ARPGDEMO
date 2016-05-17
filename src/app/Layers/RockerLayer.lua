local RockerLayer=class("RockerLayer", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
 end)

tagDirection={
  start=0,
	right=1,
	left=2,
	up=3,
	down=4,
	stop=5
}

function RockerLayer:ctor()

    self.move=-1 --遥感位置
    Radius=0  --遥感活动范围半径
    bgPs = {} --遥感初始位置

    self:init()
    self:addTouch()
end
--[[
    添加了摇杆的背景图片和摇杆
    author:cgz
--]]
function RockerLayer:init()
  local bg = display.newSprite("yaogan_1.png") --摇杆底部背景
             :setScale(1.4)
   bg:setPosition(bg:getContentSize().width/2+40,bg:getContentSize().height/2+40)
             :addTo(self)

   Roker = display.newSprite("yaogan_2.png")
             :setPosition(bg:getPosition())
             :addTo(self)
   Radius=bg:getContentSize().width/2
   bgPs.x=bg:getPositionX()
   bgPs.y=bg:getPositionY()
   self.move=tagDirection.stop 
end
--[[ 
    求两点的距离
--]]
function RockerLayer:distance(p1, p2)
	return GameUtils.distance(p1, p2)
end
--[[
   求俩点的与x轴形成的cos值
--]]
function RockerLayer:cosR(p1, p2)
	return (p1.x-p2.x)/(self:distance(p1,p2))
end
--[[
     根据角度修改move
--]]
function RockerLayer:RokerDirection(p,angle)
 if p.y>=bgPs.y then
  	if math.radian2angle(angle)<=45 then
  		self.move=tagDirection.right
  		--print("right~~~~~~~")
  	end
  	if  math.radian2angle(angle)>45 and math.radian2angle(angle)<135 then
  		self.move=tagDirection.up
  		--print("up~~~~~~~")
  	end
  	if math.radian2angle(angle)>=135 and math.radian2angle(angle)<180 then
  		self.move=tagDirection.left
  		--print("left~~~~~~~")
  	end
  end
  if p.y<bgPs.y then
  	if math.radian2angle(angle)<45 then
  		self.move=tagDirection.right
  		--print("right~~~~~~~")
  	end
  	if math.radian2angle(angle)>=45 and math.radian2angle(angle)<135 then
  		self.move=tagDirection.down
  		--print("down~~~~~~~")
  	end
  	if math.radian2angle(angle)>=135 and math.radian2angle(angle)<180 then
  		--print("left~~~~~~~")
  		self.move=tagDirection.left
  	end
  end
end
--[[
   添加监听事件
--]]
function RockerLayer:addTouch()
	local function touchBegan(location,event)

		local p = location:getLocation()
		if self:distance(p,bgPs)<Radius then
			return true
		end

		return false
	end
   	local function touchMoved(location,event)
		local  p = location:getLocation()
	  	angle=math.acos(self:cosR(p, bgPs))
        self:RokerDirection(p, angle)
		if self:distance(p,bgPs)<=Radius then
			Roker:setPosition(p)
		end
		if self:distance(p,bgPs)>Radius then
			local x = Radius*math.cos(angle)
			local y = Radius*math.sin(angle)
			if (p.x>bgPs.x) and(p.y>bgPs.y) then
				Roker:setPosition(bgPs.x+x,bgPs.y+y)
			end
			if (p.x<bgPs.x) and(p.y>bgPs.y) then
				Roker:setPosition(bgPs.x+x,bgPs.y+y)
			end
			if  (p.x<bgPs.x) and(p.y<bgPs.y) then
				Roker:setPosition(bgPs.x+x,bgPs.y-y)
			end
			if  (p.x>bgPs.x) and(p.y<bgPs.y) then
				Roker:setPosition(bgPs.x+x,bgPs.y-y)
			end
		end
	end
    local function touchended(location,event)
	   self.move=tagDirection.start
	   Roker:setPosition(bgPs)
    end

    local dispatch = cc.Director:getInstance():getEventDispatcher()
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(touchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(touchMoved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(touchended,cc.Handler.EVENT_TOUCH_ENDED)
    dispatch:addEventListenerWithSceneGraphPriority(listener, self)
end

return RockerLayer



