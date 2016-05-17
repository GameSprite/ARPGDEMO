--[[
     Person作为Hero,Enermy,Sodier的原型
--]]

local Person={
    _name="",           --名称
    _type=-1,           -- 1 表示英雄 2 表示敌将 3 表示小兵
	  _speed=0,           --人物移动速度
	  _blood=0,           --人物血量
	  _attackDamage=0,    --普通攻击伤害 
	  _sprite=nil,        --人物对应在界面上的精灵
	  _attackBox=nil,    --攻击时的碰撞检测包围盒
	  _attackedBox=nil   --被攻击碰撞检测包围盒
}

function Person:setBlood(num)
  self._blood=num 
  if self._blood <= 0 then
  	--死亡
  	print("人物死亡")
  end
end
function Person:getPos()
  local x,y=self._sprite:getPosition()
  return cc.p(x,y)
end

return Person
