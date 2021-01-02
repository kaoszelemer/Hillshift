char_tuzmagus = {}

local baseHP = 6
local baseDefense = 6
local baseAttack = 6
local stepPoints = 1
local actionPoints = 1
local stepsDone = false
local actionDone = false


function char_tuzmagus:load()
    self.x = 450
    self.y = 600
end

function char_tuzmagus:update(dt)
end

function char_tuzmagus:draw()
    --meg kell rajzolni a playert addig a placeholder egy szoveg: "F"
    love.graphics.print("T",char_tuzmagus.x,char_tuzmagus.y)
end