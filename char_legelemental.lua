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

    love.graphics.print("L",char_legelemental.x,char_legelemental.y)
end