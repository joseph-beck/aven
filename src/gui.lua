local Player = require("player")
 
local GUI = {}

function GUI:load()
    self.coins = {}
    self.coins.img = love.graphics.newImage("assets/coin/1.png")
    self.coins.width = self.coins.img:getWidth()
    self.coins.height = self.coins.img:getHeight()
    self.coins.scale = 3
    self.coins.x = 50
    self.coins.y = 100

    self.hearts = {}
    self.hearts.img = love.graphics.newImage("assets/hearts/1.png")
    self.hearts.width = self.coins.img:getWidth()
    self.hearts.height = self.coins.img:getHeight()
    self.hearts.scale = 3
    self.hearts.x = 50
    self.hearts.y = 30
    self.hearts.spacing = self.hearts.width * self.hearts.scale + 30

    self.font = love.graphics.newFont("assets/font/alagard.ttf", 36)
end

function GUI:update(dt)

end

function GUI:draw()
    self:displayCoins()
    self:displayCoinText()
    self:displayHearts()
end

function GUI:displayCoins()
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.draw(self.coins.img, self.coins.x + 2, self.coins.y + 2, 0, self.coins.scale, self.coins.scale)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.coins.img, self.coins.x, self.coins.y, 0, self.coins.scale, self.coins.scale)
end

function GUI:displayCoinText()
    love.graphics.setFont(self.font)

    local x = self.coins.x + self.coins.width * self.coins.scale
    local y = self.coins.y + self.coins.height / 2 * self.coins.scale - self.font:getHeight() / 2

    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.print(" : "..Player.coins, x + 2, y + 2)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(" : "..Player.coins, x, y)
end

function GUI:displayHearts()
    for i = 1, Player.health.current do 
        local x = self.hearts.x + self.hearts.spacing * (i - 1)

        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.draw(self.hearts.img, x + 2, self.hearts.y + 2, 0, self.hearts.scale, self.hearts.scale)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(self.hearts.img, x, self.hearts.y, 0, self.hearts.scale, self.hearts.scale)
    end
end

return GUI