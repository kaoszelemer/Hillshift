local Cell = class("Cell")

function Cell:init(x, y, isWalkable, quad, attackModifier, defenseModifier)
    self.x = x
    self.y = y
    self.isWalkable = isWalkable
    self.quad = quad
    self.attackModifier = attackModifier
    self.defenseModifier = defenseModifier
end

function Cell:click()
    
   -- if not selectedChar then return end -- ha nincs selectedChar akkor le se fut a egész

    if selectedChar and selectedChar.isInStepState and selectedChar.isWalkable[self.class.name] and not self.isOccupied then
        if self.x + 1 < 11 and (self.x == selectedChar.x + 1 and self.y == selectedChar.y) then
            selectedChar:move(self.x, self.y)
        
        elseif self.x - 1 > 0 and  (self.x == selectedChar.x - 1 and self.y == selectedChar.y) then 
            selectedChar:move(self.x, self.y)
        
        elseif self.y + 1 < 11 and  (self.x == selectedChar.x and self.y == selectedChar.y + 1) then 
            selectedChar:move(self.x, self.y)
        
        elseif self.y - 1 > 0 and (self.x == selectedChar.x and self.y == selectedChar.y - 1) then 
            selectedChar:move(self.x, self.y)
        
        elseif (self.x + 1 < 11 and self.y + 1 < 11) and (self.x == selectedChar.x + 1 and self.y == selectedChar.y + 1) then
            selectedChar:move(self.x, self.y) 
        
        elseif self.x - 1 > 0 and self.y - 1 > 0 and (self.x == selectedChar.x - 1 and self.y == selectedChar.y - 1) then
            selectedChar:move(self.x, self.y)
            
        elseif self.x + 1 < 11 and self.y - 1 > 0 and (self.x == selectedChar.x + 1 and self.y == selectedChar.y - 1) then 
            selectedChar:move(self.x, self.y)
        
        elseif self.x - 1 > 0 and self.y + 1 < 11 and (self.x == selectedChar.x - 1 and self.y == selectedChar.y + 1) then 
            selectedChar:move(self.x, self.y)
        end
        
        board:resetAllCharacterStates(playerOne, playerTwo)
    end

    if selectedChar and selectedChar.isInSpellState and self.occupiedBy ~= selectedChar then

        selectedChar:spell(self)
        selectedChar.isInSpellState = false

    end




end



return Cell