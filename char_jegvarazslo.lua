char_jegvarazslo = {}

local baseHP = 6
local baseDefense = 6
local baseAttack = 6
local stepPoints = 1
local actionPoints = 1
local stepsDone = false
local actionDone = false


function char_jegvarazslo:load()
    self.x , self.y = boardGrid[5][2].x, boardGrid[6][2].y

end

function char_jegvarazslo:update(dt)
end

function char_jegvarazslo:draw()
    love.graphics.print("J", self.x * tileW + tileW / 2 - offsetX, self.y * tileH + tileH / 2 - offsetY)
end