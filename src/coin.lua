local Player = require("player")

local Coin = {}
Coin.__index = Coin
local ActiveCoins = {}

function Coin.new(x, y)
    local instance = setmetatable({}, Coin)

    instance.x = x
    instance.y = y
    instance.img = love.graphics.newImage("assets/coin/1.png")
    instance.width = instance.img:getWidth()
    instance.height = instance.img:getHeight()
    instance.scaleX = 1
    --instance.randomTimeOffset = math.random(0, 100)
    instance.toBeRemoved = false

    instance.physics = {}
    instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "static")
    instance.physics.shape = love.physics.newRectangleShape(instance.width, instance.height)
    instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
    instance.physics.fixture:setSensor(true)

    table.insert(ActiveCoins, instance)
end

function Coin:load()
    self:loadAssets()
end

function Coin:loadAssets()
    self.animation = {timer = 0, rate = 0.1}
    self.animation.coin = {total = 14, current = 1, img = {}}

    for i = 1, self.animation.coin.total do
        self.animation.coin.img[i] = love.graphics.newImage("assets/coin/"..i..".png")
    end

    self.animation.draw = self.animation.coin.img[2]
end

function Coin:update(dt)
    --self:spin(dt)
    self:animate(dt)
    self:checkRemove()
end

--function Coin:spin(dt)
--    self.scaleX = math.sin(love.timer.getTime() * 2 + self.randomTimeOffset)
--end

function Coin:checkRemove()
    if self.toBeRemoved then
        self:remove()
    end
end

function Coin:remove()
    for i, instance in ipairs(ActiveCoins) do
        if instance == self then
            Player:incrementCoins()
            self.physics.body:destroy()
            table.remove(ActiveCoins, i)
        end
    end
end

function Coin:animate(dt)
    self.animation.timer = self.animation.timer + dt
    if self.animation.timer > self.animation.rate then
        self.animation.timer = 0
        self:setNewFrame()
    end
end

function Coin:setNewFrame()
    local anim = self.animation.coin
    
    if anim.current < anim.total then
        anim.current = anim.current + 1
    else
        anim.current = 1
    end

    self.animation.draw = anim.img[anim.current]
end

function Coin:draw()
    love.graphics.draw(self.animation.draw, self.x, self.y, 0, self.scaleX, 1, self.width / 2, self.height / 2)
end

function Coin.loadAll()
    for i, instance in ipairs(ActiveCoins) do
        instance:load()
    end
end

function Coin.updateAll(dt)
    for i, instance in ipairs(ActiveCoins) do
        instance:update(dt)
    end
end

function Coin.drawAll()
    for i, instance in ipairs(ActiveCoins) do
        instance:draw()
    end
end

function Coin.beginContact(a, b, collision)
    for i, instance in  ipairs(ActiveCoins) do
        if a == instance.physics.fixture or b == instance.physics.fixture then
            if a == Player.physics.fixture or b == Player.physics.fixture then
                instance.toBeRemoved = true
                return true
            end
        end
    end
end

return Coin