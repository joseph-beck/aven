love.graphics.setDefaultFilter("nearest", "nearest")

local STI = require("sti")
local Background = require("background")
local Player = require("player")
local Coin = require("coin")
local GUI = require("gui")
local Spike = require("spike")
local Barrel = require("barrel")
local Camera = require("camera")
local Map = require("map")

function love.load()
    -- player sprite https://rvros.itch.io/animated-pixel-hero
    -- map tiles https://trixelized.itch.io/starstring-fields
    -- coin sprite https://untiedgames.itch.io/super-pixel-objects-sample
    -- font https://www.dafont.com/alagard.font

    Map:load()

    Background:load()

    GUI:load()

    Player:load()

    Coin.loadAll()
end

function love.update(dt)
    --World:update(dt)
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

	-- if problems with drawing map behind player occur draw map here

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
end

function beginContact(a, b, collision)
    if Coin.beginContact(a, b, collision) then return end
    if Spike.beginContact(a, b, collision) then return end
    Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end