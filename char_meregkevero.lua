char_meregkevero = {}

local baseHP = 6
local baseDefense = 6
local baseAttack = 6
local stepPoints = 1
local actionPoints = 1
local stepsDone = false
local actionDone = false


function char_meregkevero:load()
    self.x , self.y = boardGrid[5][10].x, boardGrid[5][10].y

end

function char_meregkevero:update(dt)
end

function char_meregkevero:draw()  
    love.graphics.print("M", self.x * tileW + tileW / 2 - offsetX, self.y * tileH + tileH / 2 - offsetY)
end