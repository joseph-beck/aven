local Map = {}

local STI = require("libraries/sti")
local Spike = require("spike")
local Barrel = require("barrel")
local Coin = require("coin")
local Camera = require("camera")
local Player = require("player")

function Map:load()
    self.currentLevel = 1

    World = love.physics.newWorld(0, 2000)
    World:setCallbacks(beginContact, endContact)
    
    self:init()
end

function Map:init()
    self.level = STI("map/"..self.currentLevel..".lua",  {"box2d"})

    self.level:box2d_init(World)
    self.level.layers.solid.visible = false
    self.level.layers.entity.visible = false

    MapWidth = self.level.layers.ground.width * 16

    self:spawnEntities()
    Coin.loadAll()
end

function Map:change(increment)
    self:clean()

    self.currentLevel = self.currentLevel + increment

    self:init()

    Player:resetPosition()
end

function Map:clean()
    self.level:box2d_removeLayer("solid")
    Coin.removeAll()
    Spike.removeAll()
    Barrel.removeAll()
end

function Map:update(dt)
    if Player.x > MapWidth - 6 then
        self:change(1) 
    elseif Player.x < 0 then
        self:change(-1)
    end

    

    World:update(dt)
end

function Map:draw()
    Map.level:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)
end

function Map:spawnEntities()
    for i,v in ipairs(self.level.layers.entity.objects) do
        if v.class == "spike" then
            Spike.new(v.x + v.width / 2, v.y + v.height / 2)
        elseif v.class == "barrel" then
            Barrel.new(v.x + v.width / 2, v.y + v.height / 2)
        elseif v.class == "coin" then
            Coin.new(v.x, v.y)
        end
    end
end

return Map