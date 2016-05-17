--[[
        英雄配置文件
        date:2016.4.26 10.29
        author:cgz
--]]

module("PersonConfig",package.seeall)
--英雄
HeroInit={
	machao={
  _name="machao",           
  _type=1,           
	_speed=20,         
	_blood=2000,         
	_attackDamage=50,
   --技能效果分为damage(伤害),save(治疗),riseAttack(提升攻击伤害),rush(前冲),效果值为数值
  _spellsEffect={"damage","damage","damage","damage"}, --效果
  _spellsValue={150,200,250,400}, --效果值
  _spellsCD={4,8,16,30},--技能cd
  spellIcons={"spells_icon9.png","spells_icon7.png","spells_icon2.png","spells_icon1.png"},
  _initpng="#machao_idle0.png",
	_spriteRes={          
	  attack={png="machao_attack.png",plist="machao_attack.plist",length=8},
	  attacked={png="machao_attacked.png"},
	  combat_idle={png="machao_combat.png",plist="machao_combat.plist",length=4},
    idle={png="machao_idle.png",plist="machao_idle.plist",length=4},
    run={png="machao_run.png",plist="machao_run.plist",length=8},
    rush={png="machao_rush.png"},
    spells={
        {png="machao_spell1.png",plist="machao_spell1.plist",length=8},--之后需要在里边添加技能碰撞检测包围盒rect，用来设置
        {png="machao_spell2.png",plist="machao_spell2.plist",length=14},
        {png="machao_spell3.png",plist="machao_spell3.plist",length=4},
        {png="machao_spell4.png",plist="machao_spell4.plist",length=10}}
	 },

	},
	xiaoqiao={
      _name="xiaoqiao",
      _type=1,
      _speed=20,
      _blood=2000,
      _attackDamage=40,
      _spellsEffect={"damage","damage","save","damage"}, --效果
      _spellsValue={150,250,100,450}, --效果值
      _spellsCD={4,8,12,35},--技能cd
      spellIcons={"spells_icon13.png","spells_icon14.png","spells_icon16.png","spells_icon6.png"},
      _initpng="#xiaoqiao_idle0.png",
      _spriteRes={
       attack={png="xiaoqiao_attack.png",plist="xiaoqiao_attack.plist",length=8},
       attacked={png="xiaoqiao_attacked.png"},
       combat_idle={png="xiaoqiao_combat.png",plist="xiaoqiao_combat.plist",length=4},
       idle={png="xiaoqiao_idle.png",plist="xiaoqiao_idle.plist",length=4},
       run={png="xiaoqiao_run.png",plist="xiaoqiao_run.plist",length=8},
       spells={
        {png="xiaoqiao_spell1.png",plist="xiaoqiao_spell1.plist",length=6},--之后需要在里边添加技能碰撞检测包围盒rect，用来设置技能打击范围
        {png="xiaoqiao_spell2.png",plist="xiaoqiao_spell2.plist",length=8},
        {png="xiaoqiao_spell3.png",plist="xiaoqiao_spell3.plist",length=8},
        {png="xiaoqiao_spell4.png",plist="xiaoqiao_spell4.plist",length=14}
       },
      },
	},
	huangzhong={
      _name="huangzhong",
      _type=1,
      _speed=25,
      _blood=1800,
      _attackDamage=45,
      _spellsEffect={"damage","damage","damage","damage"}, --效果
      _spellsValue={140,300,300,500}, --效果值
      _spellsCD={4,8,12,35},--技能cd
      spellIcons={"spells_icon11.png","spells_icon19.png","spells_icon17.png","spells_icon12.png"},
      _initpng="#huangzhong_idle0.png",
      _spriteRes={
       attack={png="huangzhong_attack.png",plist="huangzhong_attack.plist",length=8},
       attacked={png="huangzhong_attacked.png"},
       combat_idle={png="huangzhong_combat.png",plist="huangzhong_combat.plist",length=4},
       idle={png="huangzhong_idle.png",plist="huangzhong_idle.plist",length=4},
       run={png="huangzhong_run.png",plist="huangzhong_run.plist",length=8},
       spells={
        {png="huangzhong_spell1.png",plist="huangzhong_spell1.plist",length=8},
        {png="huangzhong_spell2.png",plist="huangzhong_spell2.plist",length=12},
        {png="huangzhong_spell3.png",plist="huangzhong_spell3.plist",length=14},
        {png="huangzhong_spell4.png",plist="huangzhong_spell4.plist",length=16}
       },
      },
	},
} --end HeroInit

--武将
EnermyInit={
    sunshangxiang={             --孙尚香
      _name="sunshangxiang",
      _type=2,
      _speed=10,
      _blood=3000,
      _attackDamage=60,
      _spellsEffect={"damage","damage"}, --效果
      _spellsValue={300,400}, --效果值
      _spellsCD={8,10},--技能cd
      _initpng="#sunshangxiang_combat0.png",
      _spriteRes={
       attack={png="sunshangxiang_attack.png",plist="sunshangxiang_attack.plist",length=7},
       attacked={png="sunshangxiang_attacked.png"},
       combat_idle={png="sunshangxiang_combat.png",plist="sunshangxiang_combat.plist",length=4},
       run={png="sunshangxiang_run.png",plist="sunshangxiang_run.plist",length=8},
       spells={
        {png="sunshangxiang_spell1.png",plist="sunshangxiang_spell1.plist",length=8},
        {png="sunshangxiang_spell2.png",plist="sunshangxiang_spell2.plist",length=10},
       },
      },
  },
      zhangfei={             --张飞
      _name="zhangfei",
      _type=2,
      _speed=10,
      _blood=4000,
      _attackDamage=50,
      _spellsEffect={"damage","riseAttack"}, --效果
      _spellsValue={200,100}, --效果值
      _spellsCD={8,60},--技能cd
      _initpng="#zhangfei_combat0.png",
      _spriteRes={
       attack={png="zhangfei_attack.png",plist="zhangfei_attack.plist",length=8},
       attacked={png="zhangfei_attacked.png"},
       combat_idle={png="zhangfei_combat.png",plist="zhangfei_combat.plist",length=4},
       run={png="zhangfei_run.png",plist="zhangfei_run.plist",length=8},
       spells={
        {png="zhangfei_spell1.png",plist="zhangfei_spell1.plist",length=10},
        {png="zhangfei_spell2.png",plist="zhangfei_spell2.plist",length=8},
       },
      },
  },
      sunnuban={             --孙鲁班
      _name="sunnuban",
      _type=2,
      _speed=10,
      _blood=4000,
      _attackDamage=60,
      _spellsEffect={"damage","damage"}, --效果
      _spellsValue={210,300}, --效果值
      _spellsCD={8,10},--技能cd
      _initpng="#sunnuban_combat0.png",
      _spriteRes={
       attack={png="sunnuban_attack.png",plist="sunnuban_attack.plist",length=8},
       attacked={png="sunnuban_attacked.png"},
       combat_idle={png="sunnuban_combat.png",plist="sunnuban_combat.plist",length=4},
       run={png="sunnuban_run.png",plist="sunnuban_run.plist",length=8},
       spells={
        {png="sunnuban_spell1.png",plist="sunnuban_spell1.plist",length=10},
        {png="sunnuban_spell2.png",plist="sunnuban_spell2.plist",length=8},
       },
      },
  },
      sunquan={             --孙权
      _name="sunquan",
      _type=2,
      _speed=10,
      _blood=3000,
      _attackDamage=65,
      _spellsEffect={"damage","damage"}, --效果
      _spellsValue={220,300}, --效果值
      _spellsCD={8,10},--技能cd
      _initpng="#sunquan_combat0.png",
      _spriteRes={
       attack={png="sunquan_attack.png",plist="sunquan_attack.plist",length=8},
       attacked={png="sunquan_attacked.png"},
       combat_idle={png="sunquan_combat.png",plist="sunquan_combat.plist",length=4},
       run={png="sunquan_run.png",plist="sunquan_run.plist",length=8},
       spells={
        {png="sunquan_spell1.png",plist="sunquan_spell1.plist",length=8},
        {png="sunquan_spell2.png",plist="sunquan_spell2.plist",length=8},
       },
      },
  },

    huangyueying={             --黄月英
      _name="huangyueying",
      _type=2,
      _speed=10,
      _blood=3000,
      _attackDamage=65,
      _spellsEffect={"damage","damage"}, --效果
      _spellsValue={220,400}, --效果值
      _spellsCD={8,10},--技能cd
      _initpng="#huangyueying_combat0.png",
      _spriteRes={
       attack={png="huangyueying_attack.png",plist="huangyueying_attack.plist",length=8},
       attacked={png="huangyueying_attacked.png"},
       combat_idle={png="huangyueying_combat.png",plist="huangyueying_combat.plist",length=4},
       run={png="huangyueying_run.png",plist="huangyueying_run.plist",length=8},
       spells={
        {png="huangyueying_spell1.png",plist="huangyueying_spell1.plist",length=8},
        {png="huangyueying_spell2.png",plist="huangyueying_spell2.plist",length=8},
       },
      },
  },
    guanyu={                     --关羽
      _name="guanyu",
      _type=2,
      _speed=10,
      _blood=4000,
      _attackDamage=75,
      _spellsEffect={"damage","damage"}, --效果
      _spellsValue={300,400}, --效果值
      _spellsCD={8,10},--技能cd
      _initpng="#guanyu_combat0.png",
      _spriteRes={
       attack={png="guanyu_attack.png",plist="guanyu_attack.plist",length=8},
       attacked={png="guanyu_attacked.png"},
       combat_idle={png="guanyu_combat.png",plist="guanyu_combat.plist",length=4},
       run={png="guanyu_run.png",plist="guanyu_run.plist",length=8},
       --rush={png=""},
       spells={
        {png="guanyu_spell1.png",plist="guanyu_spell1.plist",length=8},
        {png="guanyu_spell2.png",plist="guanyu_spell2.plist",length=6},
       },
      },
  },
    lvbu={             --吕布
      _name="lvbu",
      _type=2,
      _speed=10,
      _blood=4500,
      _attackDamage=100,
      _spellsEffect={"damage","rush","damage","damage"}, --效果
      _spellsValue={200,200,400,600}, --效果值
      _spellsCD={8,10,10,30},--技能cd
      _initpng="#lvbu_combat0.png",
      _spriteRes={
       attack={png="lvbu_attack.png",plist="lvbu_attack.plist",length=8},
       attacked={png="lvbu_attacked.png"},
       combat_idle={png="lvbu_combat.png",plist="lvbu_combat.plist",length=4},
       rush={png="lvbu_rush.png"},
       run={png="lvbu_run.png",plist="lvbu_run.plist",length=8},
       spells={
        {png="lvbu_spell1.png",plist="lvbu_spell1.plist",length=8},
        {png="lvbu_spell2.png",plist="lvbu_spell2.plist",length=8},
        {png="lvbu_spell3.png",plist="lvbu_spell3.plist",length=8},
        {png="lvbu_spell4.png",plist="lvbu_spell4.plist",length=8}
       },
      },
  },

} --end EnermyInit

--士兵
SodierInit={
     bb1={             --步兵1
      _name="bb1",
      _type=3,
      _speed=8,
      _blood=500,
      _attackDamage=40,
      _initpng="#bb1_combat0.png",
      _spriteRes={
       attack={png="bb1_attack.png",plist="bb1_attack.plist",length=8},
       attacked={png="bb1_attacked.png"},
       combat={png="bb1_combat.png",plist="bb1_combat.plist",length=4},
       run={png="bb1_run.png",plist="bb1_run.plist",length=8},
      },
  },
     bb2={             --步兵2
      _name="bb2",
      _type=3,
      _speed=8,
      _blood=500,
      _attackDamage=40,
      _initpng="#bb2_combat0.png",
      _spriteRes={
       attack={png="bb2_attack.png",plist="bb2_attack.plist",length=8},
       attacked={png="bb2_attacked.png"},
       combat={png="bb2_combat.png",plist="bb2_combat.plist",length=4},
       run={png="bb2_run.png",plist="bb2_run.plist",length=8},
      },
  },

     bb3={             --步兵3
      _name="bb3",
      _type=3,
      _speed=8,
      _blood=500,
      _attackDamage=40,
      _initpng="#bb3_combat0.png",
      _spriteRes={
       attack={png="bb3_attack.png",plist="bb3_attack.plist",length=8},
       attacked={png="bb3_attacked.png"},
       combat={png="bb3_combat.png",plist="bb3_combat.plist",length=4},
       run={png="bb3_run.png",plist="bb3_run.plist",length=8},
      },
  },
     bb4={             --步兵4
      _name="bb4",
      _type=3,
      _speed=8,
      _blood=1000,
      _attackDamage=40,
      _initpng="#bb4_combat.png",
      _spriteRes={
       attack={png="bb4_attack.png",plist="bb4_attack.plist",length=8},
       attacked={png="bb4_attacked.png"},
       combat={png="bb4_combat.png",plist="bb4_combat.plist",length=8},
       run={png="bb4_run.png",plist="bb4_run.plist",length=8},
      },
  },
   
}--end SodierInit

--[[
   该接口根据角色类型和名称获取其对应的初始化配置信息
    @prama: type [1,2,3] 1表示主角英雄，2表示敌将NPC，3表示士兵
    @prama: name   角色名称
--]]
function getPersonInfoTableByNameAndType(_type,name)
   --参数检查
  if type(_type) ~= "number" then
    assert(false,"function param:type is not a number")
    return 
  end
  if type(name) ~="string" then
    assert(false,"function param:name is not a string")
    return 
  end
  
 local t_1=nil  --1级表
 local t_2_name = name  --2级表名
 local re = nil --用于返回

 if _type == 1 then
   t_1=HeroInit
 elseif _type == 2 then
   t_1=EnermyInit 
 elseif _type == 3 then
   t_1=SodierInit
 end

 re=t_1[t_2_name]
 assert(re,"cannot get table by the params")
 return re 
end