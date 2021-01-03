char_harcos = {}

local baseHP = 6
local baseDefense = 6
local baseAttack = 6
local stepPoints = 1
local actionPoints = 1
local stepsDone = false
local actionDone = false


function char_harcos:load()
    self.x , self.y = boardGrid[6][10].x, boardGrid[6][10].y

end

function char_harcos:update(dt)
end

function char_harcos:draw()
    --meg kell rajzolni a playert addig a placeholder egy szoveg: "F"
    love.graphics.print("H",char_harcos.x,char_harcos.y)
end