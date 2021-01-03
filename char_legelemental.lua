char_legelemental = {}

local baseHP = 6
local baseDefense = 6
local baseAttack = 6
local stepPoints = 1
local actionPoints = 1
local stepsDone = false
local actionDone = false


function char_legelemental:load()
    self.x , self.y = boardGrid[5][9].x, boardGrid[5][9].y

end

function char_legelemental:update(dt)
end

function char_legelemental:draw()
    love.graphics.setColor(charColor) 

    love.graphics.print("L", self.x * tileW + tileW / 2 - offsetX, self.y * tileH + tileH / 2 - offsetY)
end