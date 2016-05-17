--[[
       场景配置文件
       date:2016.4.22 20:32
       author:cgz
--]]
module("SceneConfig",package.seeall)
 gameLoadSceneRCList={
   backMusic="load_backMusic.mp3",
   --将人物选择界面的资源也加载进来
   heroChoosePics={ 
      "machao.png",
      "xiaoqiao.png",
      "huangzhong.png",
    },
   --以下是游戏中需要的声音特效列表
   effectSound={
    "MYARROW.mp3","man_sound11.wav","woman_sound10.wav",
	"arrowAttack.wav","man_sound12.wav","woman_sound11.wav",
	"arrowSpell1.wav","man_sound13.wav","woman_sound12.wav",
	"arrowSpell2.wav","man_sound14.wav","woman_sound13.wav",
	"arrowSpell3.WAV","man_sound15.wav","woman_sound14.wav",
	"backBlood.mp3","man_sound2.wav","woman_sound15.wav",
	"cleaveBroadSword.wav","man_sound3.wav","woman_sound16.wav",
	"gaoshanliushui.m4a","man_sound4.wav","woman_sound2.wav",
	"goDie.mp3","man_sound5.wav	","woman_sound3.wav",
	"man_sound8.wav","woman_sound4.wav",
	"man_sound9.wav","woman_sound5.wav",
	"swordAttack.wav","woman_sound6.wav",
	"tianxiawushuang.mp3","woman_sound7.wav",
	"level_fail.mp3","tigerGrowl.wav","woman_sound8.wav",
	"level_win.mp3","tigerRoar.wav","woman_sound9.wav",
	"man_sound1.wav","waveNormalSword.wav",
	"man_sound10.wav","woman_sound1.wav",
   }
}
  --以下是关卡进入前的加载页面需要资源
levelLoadSceneRCList={
	backMusic={
	   "levelLoadbgm1.mp3", --第1，5关
     "levelLoadbgm2.mp3", --第2，6关
     "levelLoadbgm3.mp3", --第3，7关
     "levelLoadbgm4.mp3", --第4，8关
     },
  backGroundPic={
      "level_sunshangxiang.jpg",
      "level_zhangfei.jpg",
      "level_sunnuban.jpg",
      "level_sunquan.jpg",
      "level_huangyueying.jpg",
      "level_guanyu.jpg",
      "level_lvbu.jpg",
     },
   spellIcons={
   png="spells_icon.png",
   plist="spells_icon.plist"
 }
}
  --以下是各关卡的背景大地图
levelBackGroundBG={
 "bg1.png",
 "bg2.png",
 "bg3.png",
 "bg4.png",
 "bg5.png",
 "bg6.png",
 "bg7.png",
  
}
--以下是各关卡敌人的名字
enermyNames={
  "sunshangxiang",
  "zhangfei",
  "sunnuban",
  "sunquan",
  "huangyueying",
  "guanyu",
  "lvbu"
}
 --以下是各关卡小兵的配置
 sodiersConfig={
  {{1,0,0},{0,0,0},{0,0,0},{0,0,0}}, --bb1 第一节2个, bb3 第一节3个
  {{3,0,0},{0,2,0},{1,3,0},{0,0,0}},  --
  {{2,2,2},{2,1,2},{3,0,0},{0,0,0}},  --
  {{1,2,3},{3,2,1},{2,2,2},{1,1,1}},  --
  {{2,2,2},{1,1,1},{0,1,1},{0,3,3}},
  {{2,2,2},{2,2,2},{2,2,2},{2,2,2}},
  {{1,1,2},{2,2,1},{1,1,1},{1,1,1}}
}

--以下是个关卡的活动rect
activeRect={
  cc.rect(20,100,2008,205),
  cc.rect(20,100,2008,205),
  cc.rect(20,100,2008,205),
  cc.rect(20,100,2008,205),
  cc.rect(20,100,2008,205),
  cc.rect(20,100,2008,205),
  cc.rect(20,100,2008,205),
}

