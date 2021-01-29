local FireMage = Character:extend("FireMage")
    function FireMage:init(parentPlayer)
        Character.init(self, 12, 4, 1, 6, love.graphics.newImage("/graphics/firemage.png"), 
                    love.graphics.newImage("/graphics/firemagehover.png"), parentPlayer)
    end

    function FireMage:spell(targetCell)

        if      (targetCell.x == self.x and targetCell.y == self.y - 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then
    
         
                boardGrid[self.x - 1][self.y - 1].isOnFire = true
                boardGrid[self.x + 1][self.y - 1].isOnFire = true

                if boardGrid[self.x - 1][self.y - 1]:instanceOf(Field) and boardGrid[self.x - 1][self.y - 1].isFrozen then boardGrid[self.x - 1][self.y - 1] = Lake(self.x - 1, self.y - 1) end
                if boardGrid[self.x + 1][self.y - 1]:instanceOf(Field) and boardGrid[self.x + 1][self.y - 1].isFrozen then boardGrid[self.x + 1][self.y - 1] = Lake(self.x + 1, self.y - 1) end
    
    
                if boardGrid[self.x - 1][self.y - 1].isFrozen then boardGrid[self.x - 1][self.y - 1].isFrozen = false end 
                if boardGrid[self.x + 1][self.y - 1].isFrozen then boardGrid[self.x + 1][self.y - 1].isFrozen = false end
    
                if boardGrid[self.x - 1][self.y - 1]:instanceOf(Lake) then boardGrid[self.x - 1][self.y - 1] = Field(self.x - 1, self.y - 1) end
                if boardGrid[self.x + 1][self.y - 1]:instanceOf(Lake) then boardGrid[self.x + 1][self.y - 1] = Field(self.x + 1, self.y - 1)end
    
                if boardGrid[self.x - 1][self.y - 1]:instanceOf(Ice) then boardGrid[self.x - 1][self.y - 1] = Lake(self.x - 1, self.y - 1) end
                if boardGrid[self.x + 1][self.y - 1]:instanceOf(Ice) then boardGrid[self.x + 1][self.y - 1] = Lake(self.x + 1, self.y - 1)end
            
          

        else self.isInSpellState = false
        end
    
        if      (targetCell.x == self.x and targetCell.y == self.y + 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) then
    
                boardGrid[self.x - 1][self.y + 1].isOnFire = true
                boardGrid[self.x + 1][self.y + 1].isOnFire = true

                if boardGrid[self.x - 1][self.y + 1]:instanceOf(Field) and boardGrid[self.x - 1][self.y + 1].isFrozen then boardGrid[self.x - 1][self.y + 1] = Lake(self.x - 1, self.y + 1) end
                if boardGrid[self.x + 1][self.y + 1]:instanceOf(Field) and boardGrid[self.x + 1][self.y + 1].isFrozen then boardGrid[self.x + 1][self.y + 1] = Lake(self.x + 1, self.y + 1)end

    
                if boardGrid[self.x - 1][self.y + 1].isFrozen then boardGrid[self.x - 1][self.y + 1].isFrozen = false end 
                if boardGrid[self.x + 1][self.y + 1].isFrozen then boardGrid[self.x + 1][self.y + 1].isFrozen = false end
    
                if boardGrid[self.x - 1][self.y + 1]:instanceOf(Lake) then boardGrid[self.x - 1][self.y + 1] = Field(self.x - 1, self.y + 1) end
                if boardGrid[self.x + 1][self.y + 1]:instanceOf(Lake) then boardGrid[self.x + 1][self.y + 1] = Field(self.x + 1, self.y + 1)end

                if boardGrid[self.x - 1][self.y + 1]:instanceOf(Ice) then boardGrid[self.x - 1][self.y + 1] = Lake(self.x - 1, self.y + 1) end
                if boardGrid[self.x + 1][self.y + 1]:instanceOf(Ice) then boardGrid[self.x + 1][self.y + 1] = Lake(self.x + 1, self.y + 1)end

            
        else self.isInSpellState = false
        end
    end
   
return FireMage