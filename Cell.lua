local Cell = class("Cell")

function Cell:init(x, y, isWalkable, quad, attackModifier, defenseModifier)
    self.x = x
    self.y = y
    self.isWalkable = isWalkable
    self.quad = quad
    self.attackModifier = attackModifier
    self.defenseModifier = defenseModifier
end

function Cell:moveSelectedCharIfValidOffset(ox, oy)

    if ((selectedChar.x + ox <= 10 and selectedChar.x + ox > 0) and (self.x == selectedChar.x + ox and self.y == selectedChar.y + oy)) or
       ((selectedChar.y + oy <= 10 and selectedChar.y + oy > 0) and (self.y == selectedChar.y + oy and self.y == selectedChar.y + oy)) then
        selectedChar:move(self.x, self.y)
    end
      
end


function Cell:click()
    
 

   -- if not selectedChar then return end -- ha nincs selectedChar akkor le se fut a egész

    if selectedChar and selectedChar.isInStepState and selectedChar.isWalkable[self.class.name] and not self.isOccupied then
        for x = -1, 1 do
            for y = -1, 1 do
                if x ~= 0 or y ~= 0 then 
                    self:moveSelectedCharIfValidOffset(x, y)
                end
            end
        end
        
        board:resetAllCharacterStates(playerOne, playerTwo)
    end

    if selectedChar and selectedChar.isInSpellState and self.occupiedBy ~= selectedChar then

        selectedChar:spell(self)
        selectedChar.isInSpellState = false

    end




end




return Cell