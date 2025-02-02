-- 说明页面
local EliminateAbout = class("EliminateAbout", function()
    return cc.LayerColor:create(cc.c4b(0,0,0,150), display.width, display.height)
end) 

function EliminateAbout:ctor()
    local root = cc.CSLoader:createNode("res/eliminate/csd/EliminateAbout.csb")
    root:setPosition(0,0)
    self:addChild(root)

    local sureBtn = root:getChildByName("Image_TitleBg")
    sureBtn:setTouchEnabled(true)
    sureBtn:addTouchEventListener(function(sender, eventType)
        if eventType ~= ccui.TouchEventType.ended then 
            return 
        end 
        self:removeFromParent()
    end)

    -- 添加触摸事件
    self:registerScriptHandler(handler(self, self.onNodeEvent))
end 

function EliminateAbout:onNodeEvent(event)
    local function onTouchBegan(sender, event)
        return true 
    end 

    local function onTouchEnded(sender, event)
        -- do something
    end 

	if event == "enter" then
        local listener = cc.EventListenerTouchOneByOne:create()
        -- 避免透点
		listener:setSwallowTouches(true)
        listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
        listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)

		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
	elseif event == "exit" then
		local eventDispatcher = self:getEventDispatcher()
		eventDispatcher:removeEventListenersForTarget(self)
	end
end

return EliminateAbout 
