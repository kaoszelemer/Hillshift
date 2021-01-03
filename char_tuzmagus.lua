char_tuzmagus = {}

local baseHP = 6
local baseDefense = 6
local baseAttack = 6
local stepPoints = 1
local actionPoints = 1
local stepsDone = false
local actionDone = false


function char_tuzmagus:load()
    self.x , self.y = boardGrid[6][9].x, boardGrid[6][9].y

end

function char_tuzmagus:update(dt)
end

function char_tuzmagus:draw()
    love.graphics.print("T", self.x * tileW + tileW / 2 - offsetX, self.y * tileH + tileH / 2 - offsetY)
end