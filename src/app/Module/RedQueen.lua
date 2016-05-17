--RedQueen 红桃皇后，用于管理士兵，敌将的出生，靠近，攻击行为
local RedQueen={}
local sodierInfoTB= SceneConfig.sodiersConfig
RedQueen.bg = nil

--初始化RedQueen.sodier_deploynumTB
 RedQueen.attack_target = nil --攻击目标
 RedQueen.enermy = nil  --敌将
 RedQueen.active_sodier ={} --被激活的士兵

 RedQueen.sodier_deploy_section=0 --士兵投放阶段[1,2,3]
 --[[
	 分阶段部署士兵
	 @param: section 阶段值[1,2,3]
 --]]
 function RedQueen:deploy(section) 
  local sodier_n1 = sodierInfoTB[GameRunningData.currentLevel][1][section]
  local sodier_n2 = sodierInfoTB[GameRunningData.currentLevel][2][section]
  local sodier_n3 = sodierInfoTB[GameRunningData.currentLevel][3][section]
  local sodier_n4 = sodierInfoTB[GameRunningData.currentLevel][4][section]

  local sodiers_num={sodier_n1,sodier_n2,sodier_n3,sodier_n4} 
  for i=1,4 do --4类
  	for j=1,sodiers_num[i] do
  		local s = Sodier.new()
  		         :initWithSodierName("bb"..i)
               :addTo(self.bg)
         local index=(i-1)*4+j
         local  delt_x = 50
         local delt_y = 100
         local origin_x = 700+(section-1)*550
         local origin_y = 180
         local _x=origin_x+(math.floor(index/2))*delt_x
         local _y=origin_y+(index%2)*delt_y
         s._sprite:pos(_x, _y)
         s._sprite:setLocalZOrder(4-index%2)
         s:setScaleX(-1)
         s:setAttackTarget(self.attack_target)
         table.insert(self.active_sodier,s)
  	end
  end
 end
--[[
    红桃皇后判断当前形势，做出应对
--]]
function RedQueen:thinking( ... )
   self:think_sodiers_deploy()
   self:think_sodiers_closeToTarget()
end
--[[
    思考1：士兵部署
--]]
function RedQueen:think_sodiers_deploy( ... )
  --这样子玩家就可以拉怪了
  local heroPosInBg = self.attack_target:getPosInBG()
  if heroPosInBg.x >= 200 and self.sodier_deploy_section == 0 then
    self.sodier_deploy_section = 1
    self:deploy(1)
  elseif heroPosInBg.x >= 883 and self.sodier_deploy_section == 1 then
    self.sodier_deploy_section = 2
    self:deploy(2)
  elseif heroPosInBg.x >= 1566 and self.sodier_deploy_section == 2 then
    self.sodier_deploy_section = 3
    self:deploy(3)
  end
end
--[[
    思考2：让激活的士兵朝目标移动
--]]
function RedQueen:think_sodiers_closeToTarget( ... )
  for k,v in pairs(self.active_sodier) do
    v:closeTarget()
  end
end

return RedQueen