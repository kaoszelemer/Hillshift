char_foldmano = {}

local baseHP = 6
local baseDefense = 6
local baseAttack = 6
local stepPoints = 1
local actionPoints = 1
local stepsDone = false
local actionDone = false


function char_foldmano:load()
    self.x , self.y = boardGrid[5][10].x, boardGrid[5][10].y
    print (self.x, self.y)
end

function char_foldmano:update(dt)
end

function char_foldmano:draw()
    --meg kell rajzolni a playert addig a placeholder egy szoveg: "F"
    love.graphics.print("F",char_foldmano.x * tileW + tileW / 2,char_foldmano.y * tileH + tileH / 2)
end