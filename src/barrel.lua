local Barrel = {}
Barrel.__index = Barrel
local ActiveBarrels = {}

function Barrel.new(x, y)
    local instance = setmetatable({}, Barrel)

    instance.x = x
    instance.y = y
    instance.r = 0

    instance.img = love.graphics.newImage("assets/barrel/1.png")
    instance.width = instance.img:getWidth()
    instance.height = instance.img:getHeight()

    instance.physics = {}
    instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "dynamic")
    instance.physics.shape = love.physics.newRectangleShape(instance.width, instance.height)
    instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
    instance.physics.body:setMass(25)

    table.insert(ActiveBarrels, instance)
end

function Barrel:update(dt)
    self:syncPhysics()
end

function Barrel:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()
    self.r = self.physics.body:getAngle()
end

function Barrel:draw()
    love.graphics.draw(self.img, self.x, self.y, self.r, self.scaleX, 1, self.width / 2, self.height / 2 - 1)
end

function Barrel.loadAll()
    for i, instance in ipairs(ActiveBarrels) do
        instance:load()
    end
end

function Barrel.removeAll()
    for i, v in ipairs(ActiveBarrels) do
        v.physics.body:destroy()
    end

    ActiveBarrels = {}
end

function Barrel.updateAll(dt)
    for i, instance in ipairs(ActiveBarrels) do
        instance:update(dt)
    end
end

function Barrel.drawAll()
    for i, instance in ipairs(ActiveBarrels) do
        instance:draw()
    end
end

return Barrel