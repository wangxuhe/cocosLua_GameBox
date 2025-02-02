-- 战斗场景
local Hero = require("app.Demo_ZombieShoot.UI.battle.Hero")
local UIBattle_Map = require("app.Demo_ZombieShoot.UI.battle.UIBattle_Map")
local UIBattle_Main = require("app.Demo_ZombieShoot.UI.battle.UIBattle_Main")
local UIBattle_Control = require("app.Demo_ZombieShoot.UI.battle.UIBattle_Control")

local BattleScene = class("BattleScene", function()
    return cc.Scene:create()
end)

function BattleScene:ctor()
    self._root = nil 
    self._mainUI = nil              -- 主界面UI
    self._controlUI = nil           -- 控制UI
    self._mapUI = nil               -- 地图UI
    self._heroUI = nil              -- 英雄

    self:_initUI() 
    
end 

function BattleScene:_initUI()
    self._root = cc.CSLoader:createNode("csd/UIBattle.csb")
    self:addChild(self._root)

    -- 创建主界面UI
    local panelMain = ccui.Helper:seekNodeByName(self._root, "Panel_Main")
    self._mainUI = UIBattle_Main.new(panelMain, self)
    -- 创建控制UI
    local controlNode = ccui.Helper:seekNodeByName(self._root, "Node_Control")
    self._controlUI = UIBattle_Control.new(controlNode, self)
    -- 创建地图UI
    self._mapUI = UIBattle_Map.new(self)
    -- 创建英雄
    self._heroUI = Hero.new(self)
    self._heroUI:CreateHero()
end 

-- 获取英雄节点
function BattleScene:getHeroUI()
    return self._heroUI 
end 

-- 获取地图节点
function BattleScene:getMapUI()
    return self._mapUI
end 

return BattleScene