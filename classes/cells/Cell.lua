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
    if ((selectedChar.x + ox <= 10 and selectedChar.x + ox >= 1) and (self.x == selectedChar.x + ox and self.y == selectedChar.y + oy)) or
       ((selectedChar.y + oy <= 10 and selectedChar.y + oy >= 1) and (self.y == selectedChar.y + oy and self.y == selectedChar.y + oy)) then
            if selectedChar.x + ox == self.x and
                selectedChar.y + oy == self.y then
                selectedChar:move(self.x, self.y)
                stepCounter = stepCounter + 1
                if stepCounter == 6 then stepCounter = 1 end
            end
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

                    eventDice = getDiceRoll()
                    print(stepCounter .. "-" .. eventDice)
                    if stepCounter == eventDice then
                        Event:enableEvent()
                        stepCounter = -10
                    end
        
        board:resetAllCharacterStates(playerOne, playerTwo)
    end

    if selectedChar and selectedChar.isInSpellState and self.occupiedBy ~= selectedChar then

        selectedChar:spell(self)
        selectedChar.isInSpellState = false

    end




end




return Cell