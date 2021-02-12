local IceWizard = Character:extend("IceWizard")
    function IceWizard:init(parentPlayer)
        Character.init(self, 11, 3, 2, 3, love.graphics.newImage("/graphics/icewizard.png"), 
                    love.graphics.newImage("/graphics/icewizardhover.png"), 
                    love.graphics.newImage("/graphics/icewizardsink.png"), 
                    love.graphics.newImage("/graphics/icewizardsinkhover.png"), 
                    parentPlayer, 1, 1, 0, 0, 0, false)
    end

function IceWizard:spell(targetCell)

    if self.actionPoints ~= 0 then
    if      (targetCell.x == self.x and targetCell.y == self.y - 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then
        self.actionPoints = self.actionPoints - 1

        if self.y - 1 > 0 then

          
               boardGrid[self.x][self.y - 1].isFrozen = true
               if boardGrid[self.x][self.y - 1]:instanceOf(Lake) then boardGrid[self.x][self.y - 1] = Ice(self.x, self.y - 1) end
               boardGrid[self.x][self.y - 1].freezeTurn = turnCounter
            if boardGrid[self.x][self.y - 1].isOnFire then boardGrid[self.x][self.y - 1].isOnFire = false end

        end

        if self.x - 1 > 0 and self.y - 1 > 0 then
           
               boardGrid[self.x - 1][self.y - 1].isFrozen = true
               if boardGrid[self.x - 1][self.y - 1]:instanceOf(Lake) then boardGrid[self.x - 1][self.y - 1] = Ice(self.x - 1, self.y - 1) end
               boardGrid[self.x - 1][self.y - 1].freezeTurn = turnCounter
            if boardGrid[self.x - 1][self.y - 1].isOnFire then boardGrid[self.x - 1][self.y - 1].isOnFire = false end 

        end
         
        if self.x + 1 <= 10 and self.y - 1 > 0 then

                boardGrid[self.x + 1][self.y - 1].isFrozen = true
                if  boardGrid[self.x + 1][self.y - 1]:instanceOf(Lake) then boardGrid[self.x + 1][self.y - 1] = Ice(self.x + 1, self.y - 1) end  
                boardGrid[self.x + 1][self.y - 1].freezeTurn = turnCounter
            if  boardGrid[self.x + 1][self.y - 1].isOnFire then boardGrid[self.x + 1][self.y - 1].isOnFire = false end

        end


        
    else self.isInSpellState = false
    end

    if      (targetCell.x == self.x and targetCell.y == self.y + 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) then
        self.actionPoints = self.actionPoints - 1

        if self.y + 1 <= 10 then

               boardGrid[self.x][self.y + 1].isFrozen = true
               if boardGrid[self.x][self.y + 1]:instanceOf(Lake) then boardGrid[self.x][self.y + 1] = Ice(self.x, self.y + 1) end
               boardGrid[self.x][self.y + 1].freezeTurn = turnCounter
            if boardGrid[self.x][self.y + 1].isOnFire then boardGrid[self.x][self.y + 1].isOnFire = false end

        end

        if self.x - 1 > 0 and self.y + 1 <= 10 then
           
               boardGrid[self.x - 1][self.y + 1].isFrozen = true
               if boardGrid[self.x - 1][self.y + 1]:instanceOf(Lake) then boardGrid[self.x - 1][self.y + 1] = Ice(self.x - 1, self.y + 1) end
               boardGrid[self.x - 1][self.y + 1].freezeTurn = turnCounter
            if boardGrid[self.x - 1][self.y + 1].isOnFire then boardGrid[self.x - 1][self.y + 1].isOnFire = false end 

        end
         
        if self.x + 1 <= 10 and self. y + 1 <= 10 then

                boardGrid[self.x + 1][self.y + 1].isFrozen = true
                if  boardGrid[self.x + 1][self.y + 1]:instanceOf(Lake) then boardGrid[self.x + 1][self.y + 1] = Ice(self.x + 1, self.y + 1) end  
                boardGrid[self.x + 1][self.y + 1].freezeTurn = turnCounter
            if  boardGrid[self.x + 1][self.y + 1].isOnFire then boardGrid[self.x + 1][self.y + 1].isOnFire = false end

        end
       
    else self.isInSpellState = false
    end
    end

end


return IceWizard