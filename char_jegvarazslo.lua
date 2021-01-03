char_jegvarazslo = {}

local baseHP = 6
local baseDefense = 6
local baseAttack = 6
local stepPoints = 1
local actionPoints = 1
local stepsDone = false
local actionDone = false


function char_jegvarazslo:load()
    self.x , self.y = boardGrid[4][10].x, boardGrid[4][10].y

end

function char_jegvarazslo:update(dt)
end

function char_jegvarazslo:draw()
    love.graphics.print("J",char_jegvarazslo.x,char_jegvarazslo.y)
end