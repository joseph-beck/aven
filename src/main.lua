love.graphics.setDefaultFilter("nearest", "nearest")

local Background = require("background")
local Player = require("player")
local Coin = require("coin")
local GUI = require("gui")
local Spike = require("spike")
local Barrel = require("barrel")
local Camera = require("camera")
local Map = require("map")

function love.load()
    Map:load()
    Background:load()
    GUI:load()
    Player:load()
end

function love.update(dt)
    Map:update(dt)
    Player:update(dt)

    Coin.updateAll(dt)
    Spike.updateAll(dt)
    Barrel.updateAll(dt)

    GUI:update(dt)
    Camera:setPosition(Player.x, 0)
    Background:update(dt)
end

function love.draw()
	Background:draw()
    
	Camera:apply()

    Player:draw()

    Coin.drawAll()
    Spike.drawAll()
    Barrel.drawAll()

	Camera:clear()

    Map:draw()
    GUI:draw()
end

function beginContact(a, b, collision)
    if Coin.beginContact(a, b, collision) then return end
    if Spike.beginContact(a, b, collision) then return end
    Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end