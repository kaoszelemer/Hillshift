char_foldmano = {}

local baseHP = 6
local baseDefense = 6
local baseAttack = 6
local stepPoints = 1
local actionPoints = 1
local stepsDone = false
local actionDone = false





function char_foldmano:load()
    self.x , self.y = boardGrid[5][1].x, boardGrid[5][1].y
    self.screenX = self.x * tileW + tileW / 2 - offsetX
    self.screenY = self.y * tileH + tileH / 2 - offsetY

    self.isHovered = false
    self.isSelected = false
    

end

function char_foldmano:update(dt)
end

function char_foldmano:draw()
    -- statuszok alapján eldöntöm a karakterek színét
    if self.isHovered then 
        love.graphics.setColor(hoverColor)

    else  
        love.graphics.setColor(charColor)
    end
  
    if self.isSelected then
    
        love.graphics.setColor(selectedColor)
    
    elseif self.isHovered == true then
        love.graphics.setColor(hoverColor)
    end

    --kirajzolom a karaktert
        love.graphics.print("F", self.screenX, self.screenY)

    --visszaállítom a színt eredetire
        love.graphics.setColor(charColor)
end