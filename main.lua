love.graphics.setDefaultFilter("nearest", "nearest")

local Background = require("src/background")
local Player = require("src/player")
local Coin = require("src/coin")
local GUI = require("src/gui")
local Spike = require("src/spike")
local Barrel = require("src/barrel")
local Camera = require("src/camera")
local Map = require("src/map")

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
    --Map:draw()
    
	Camera:apply()

    Player:draw()

    Coin.drawAll()
    Spike.drawAll()
    Barrel.drawAll()

	Camera:clear()

    Map:draw()
    GUI:draw()
end

function love.keypressed(key)
    Player:jump(key)

    if key == 'escape' then
        love.event.quit()
    end
end

function beginContact(a, b, collision)
    if Coin.beginContact(a, b, collision) then return end
    if Spike.beginContact(a, b, collision) then return end
    Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end