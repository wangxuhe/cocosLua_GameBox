local winSize = cc.Director:getInstance():getWinSize()

local GlobalUtil = cc.exports.GlobalUtil
GlobalUtil = {
	--
}

-- @func:创建触摸屏蔽层
-- @param: _size 大小
-- @param: _opacity 层级
cc.exports.newLayerColor = function(_size,_opacity)
	local width = _size.width or winSize.width
	local height = _size.height or winSize.height
	local opactiy = _opacity or 255

	local layer = cc.LayerColor:create(cc.c4b(0,0,0,opactiy),width,height)

	local function onTouchBegan(touch, event)
		return true
	end
	local function onTouchEnded(touch, event)
		--
	end 
	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	-- 设置触摸吞噬
	listener:setSwallowTouches(true)

	local eventDispatcher = layer:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

	return layer
end

-- @func:触摸注册事件
-- @param: node 注册节点
-- @param: callback 回调接口
-- @param: event 事件类型,可为nil，默认：ccui.TouchEventType.ended
-- @param: 按钮按下缩放，可为nil，默认：-0.1
cc.exports.BindTouchEvent = function(register,callback,event,zoomScale)
	assert(not tolua.isnull(register), "Error:BindTouchEvent register inValid")

	zoomScale = zoomScale or -0.1
	event = event or ccui.TouchEventType.ended
	local callFunc = function(sender, eventType)
		if eventType == ccui.TouchEventType.began then 
			AudioEngine.playEffect("res/sound/click.wav", false)
		end 

		if event == ccui.TouchEventType.ended then 
			callback(sender, eventType)
		end 
	end 
	register:addTouchEventListener(callFunc)
	register:setPressedActionEnabled(true)
	register:setZoomScale(zoomScale)
end

-- @function: 切换场景
-- @param: _transition 可参考：display.SCENE_TRANSITIONS
-- @param: _time 过渡时间，以秒为单位
cc.exports.ChangeScene = function(_scene, _transition, _time)
	if tolua.isnull(_scene) then 
		error("ERROR: ChangeScene the param _scene is nil")
		return 
	end 

	local runScene = cc.Director:getInstance():getRunningScene()
	runScene:stopAllActions()
	runScene:pause()

	-- 运行场景
	display.runScene(_scene, _transition, _time)
end 

cc.exports.MsgTip = function(_content, _bgRes)
	local root = cc.CSLoader:createNode("res/csd/UIMsgTip.csb")
	local size = root:getContentSize()
    root:setPosition(cc.p((winSize.width-size.width)/2, (winSize.height-size.height)/2))
	local _panel = root:getChildByName("Panel")
	cc.Director:getInstance():getRunningScene():addChild(root, 1000) 

	if _bgRes ~= nil then 
        _panel:getChildByName("Image_1"):setTexture(_bgRes)
    end 
    _panel:getChildByName("Text_1"):setString(_content)
	
	--
	local delay = cc.DelayTime:create(1)
	local fadeout = cc.FadeOut:create(1)
	local move = cc.MoveBy:create(1, cc.p(0, winSize.height))
	-- 动作由慢到快
    local move_ease_out = cc.EaseSineIn:create(move)
	local spawn = cc.Spawn:create(move_ease_out, fadeout)
    local callback = cc.CallFunc:create(function()
        root:removeFromParent()
    end)
    local action = cc.Sequence:create(delay, spawn, callback)
	_panel:runAction(action)
end 

return GlobalUtil
