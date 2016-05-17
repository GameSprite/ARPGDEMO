
require("config")
require("cocos.init")
require("framework.init")
require("app.Data.ClassManager")
local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    cc.FileUtils:getInstance():addSearchPath("res/GameLoadScene")
    cc.FileUtils:getInstance():addSearchPath("res/Heros")
    cc.FileUtils:getInstance():addSearchPath("res/Effects")
    cc.FileUtils:getInstance():addSearchPath("res/levelLoadScene")
    cc.FileUtils:getInstance():addSearchPath("res/heroChooseScene")
    cc.FileUtils:getInstance():addSearchPath("res/fonts")
    cc.FileUtils:getInstance():addSearchPath("res/Enermy")
    cc.FileUtils:getInstance():addSearchPath("res/sodier")
    cc.FileUtils:getInstance():addSearchPath("res/PlayScene")
    self:enterScene("GameLoadScene")
  --self:enterScene("testScene")

end

return MyApp
