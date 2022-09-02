local Background = {}

function Background:load()
    self.layerOne = love.graphics.newImage("assets/background/background-1.png")
    self.layerTwo = love.graphics.newImage("assets/background/background-1.png")
    self.layerThree = love.graphics.newImage("assets/background/background-1.png")
end

function Background:update(dt)

end

function Background:draw()
    love.graphics.draw(self.layerOne)
end

return Background