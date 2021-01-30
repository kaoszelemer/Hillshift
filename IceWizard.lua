local IceWizard = Character:extend("IceWizard")
    function IceWizard:init(parentPlayer)
        Character.init(self, 8, 5, 0, 3, love.graphics.newImage("/graphics/icewizard.png"), 
                    love.graphics.newImage("/graphics/icewizardhover.png"), parentPlayer)
    end

function IceWizard:spell(targetCell)

    if      (targetCell.x == self.x and targetCell.y == self.y - 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then


            if boardGrid[self.x][self.y - 1]:instanceOf(Lake) then boardGrid[self.x][self.y - 1] = Ice(self.x, self.y - 1) end
            if boardGrid[self.x - 1][self.y - 1]:instanceOf(Lake) then boardGrid[self.x - 1][self.y - 1] = Ice(self.x - 1, self.y - 1) end
            if boardGrid[self.x + 1][self.y - 1]:instanceOf(Lake) then boardGrid[self.x + 1][self.y - 1] = Ice(self.x + 1, self.y - 1)end
        
            boardGrid[self.x][self.y - 1].isFrozen = true
            boardGrid[self.x - 1][self.y - 1].isFrozen = true
            boardGrid[self.x + 1][self.y - 1].isFrozen = true

            if boardGrid[self.x][self.y - 1].isOnFire then boardGrid[self.x][self.y - 1].isOnFire = false end
            if boardGrid[self.x - 1][self.y - 1].isOnFire then boardGrid[self.x - 1][self.y - 1].isOnFire = false end 
            if boardGrid[self.x + 1][self.y - 1].isOnFire then boardGrid[self.x + 1][self.y - 1].isOnFire = false end

            


        
    else self.isInSpellState = false
    end

    if      (targetCell.x == self.x and targetCell.y == self.y + 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) then

        if boardGrid[self.x][self.y + 1]:instanceOf(Lake) then boardGrid[self.x][self.y + 1] = Ice(self.x, self.y + 1) end
        if boardGrid[self.x - 1][self.y + 1]:instanceOf(Lake) then boardGrid[self.x - 1][self.y + 1] = Ice(self.x - 1, self.y + 1) end
        if boardGrid[self.x + 1][self.y + 1]:instanceOf(Lake) then boardGrid[self.x + 1][self.y + 1] = Ice(self.x + 1, self.y + 1) end
        

        boardGrid[self.x][self.y + 1].isFrozen = true
        boardGrid[self.x - 1][self.y + 1].isFrozen = true
        boardGrid[self.x + 1][self.y + 1].isFrozen = true

        if boardGrid[self.x][self.y + 1].isOnFire then boardGrid[self.x][self.y + 1].isOnFire = false end
        if boardGrid[self.x - 1][self.y + 1].isOnFire then boardGrid[self.x - 1][self.y + 1].isOnFire = false end
        if boardGrid[self.x + 1][self.y + 1].isOnFire then boardGrid[self.x + 1][self.y + 1].isOnFire = false end

       
    else self.isInSpellState = false
    end
end


return IceWizard