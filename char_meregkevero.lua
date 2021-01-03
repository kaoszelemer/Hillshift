char_meregkevero = {}

local baseHP = 6
local baseDefense = 6
local baseAttack = 6
local stepPoints = 1
local actionPoints = 1
local stepsDone = false
local actionDone = false


function char_meregkevero:load()
    self.x , self.y = boardGrid[4][9].x, boardGrid[4][9].y

end

function char_meregkevero:update(dt)
end

function char_meregkevero:draw()
    --meg kell rajzolni a playert addig a placeholder egy szoveg: "F"
    love.graphics.print("M",char_meregkevero.x,char_meregkevero.y)
end