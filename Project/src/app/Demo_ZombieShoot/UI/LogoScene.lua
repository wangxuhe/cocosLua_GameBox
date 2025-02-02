-- 闪屏页面 

local LogoScene = class("LogoScene", function()
    return cc.Scene:create()
end) 

function LogoScene:ctor()
    local function onNodeEvent(event)
        if event == "enter" then
            self:init()
        end
    end

    self:registerScriptHandler(onNodeEvent)
end 

function LogoScene:init()
    -- 创建logo
    local logoSprite = cc.Sprite:create(Res.LOGO)
    if not logoSprite then 
        return 
    end 

    logoSprite:setPosition(display.cx,display.cy)
    self:addChild(logoSprite)

    -- 动作相关
    local act1 = cc.FadeIn:create(0.5)
    local act2 = cc.FadeOut:create(0.5)
    local act3 = cc.CallFunc:create(function(sender)
        -- 启动Lua垃圾回收器
    end)
    local act4 = cc.CallFunc:create(function()
        -- 进入登录场景
        local mainScene = require("app.Demo_ZombieShoot.UI.MainScene"):create()
        cc.Director:getInstance():replaceScene(mainScene)
    end)
    local action = cc.Sequence:create(act1, act2, act3, act4)
    logoSprite:runAction(action)
end 

return LogoScene 
