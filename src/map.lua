local Map = {}

local STI = require("sti")
local Spike = require("spike")
local Barrel = require("barrel")
local Coin = require("coin")
local Camera = require("camera")

function Map:load()
    Map = STI("map/dev-scene.lua",  {"box2d"})
    World = love.physics.newWorld(0, 2000)
    World:setCallbacks(beginContact, endContact)
    Map:box2d_init(World)
    Map.layers.solid.visible = false
    Map.layers.entity.visible = false
    MapWidth = Map.layers.ground.width * 16

    self:spawnEntities()
end

function Map:update(dt)
    World:update(dt)
end

function Map:draw()
    Map:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)
end

function Map:spawnEntities()
    for i,v in ipairs(Map.layers.entity.objects) do
        if v.class == "spike" then
            Spike.new(v.x + v.width / 2, v.y + v.height / 2)
        elseif v.class == "barrel" then
            Barrel.new(v.x + v.width / 2, v.y + v.height / 2)
        elseif v.class == "coin" then
            print("test3")
            Coin.new(v.x, v.y)
        end
    end
end

return Map