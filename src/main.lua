local STI = require("sti")

require("background")
require("player")
require("coin")
require("gui")

love.graphics.setDefaultFilter("nearest", "nearest")

function love.load()
    -- player sprite https://rvros.itch.io/animated-pixel-hero
    -- map tiles https://trixelized.itch.io/starstring-fields
    -- coin sprite https://untiedgames.itch.io/super-pixel-objects-sample
    -- font https://www.dafont.com/alagard.font

    Map = STI("map/dev-scene.lua",  {"box2d"})
    World = love.physics.newWorld(0, 0)
    World:setCallbacks(beginContact, endContact)
    Map:box2d_init(World)
    Map.layers.solid.visible = false

    Background:load()
    GUI:load()
    Player:load()

    Coin.new(300, 250)
    Coin.new(500, 250)
    Coin.new(600, 200)

    Coin.loadAll()
end

function love.update(dt)
    World:update(dt)

    Player:update(dt)

    Coin.updateAll(dt)

    GUI:update(dt)

    Background:update(dt)
end

function love.draw()
	Background:draw()

	--Map:draw(0, -8, 2, 2)

	love.graphics.push()

	love.graphics.scale(2,2) 
    Player:draw()
    Coin.drawAll()

	love.graphics.pop() 

    Map:draw(0, -8, 2, 2)
    GUI:draw()
end

function love.keypressed(key)
    Player:jump(key)
end

function beginContact(a, b, collision)
    if Coin:beginContact(a, b, collision) then return end
    Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end