local Alchemist = Character:extend("Alchemist")
function Alchemist:init(parentPlayer)
    Character.init(self, 6, 4, 3, 2, love.graphics.newImage("/graphics/alchemist.png"), 
                love.graphics.newImage("/graphics/alchemisthover.png"), parentPlayer)
end

function Alchemist:spell(targetCell)
        --lefele 1. mezo balra
        if      (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x - 2 and targetCell.y == self.y - 2) then
    
                boardGrid[self.x - 1][self.y - 1].isPoisoned = true
                boardGrid[self.x - 2][self.y - 2].isPoisoned = true

        else self.isInSpellState = false
        end
        ---felfele 1. mezo
        if      (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x + 2 and targetCell.y == self.y - 2) then
    
            boardGrid[self.x + 1][self.y - 1].isPoisoned = true
            boardGrid[self.x + 2][self.y - 2].isPoisoned = true

        else self.isInSpellState = false
        end

        if      (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or (targetCell.x == self.x - 2 and targetCell.y == self.y + 2) then
    
            boardGrid[self.x - 1][self.y + 1].isPoisoned = true
            boardGrid[self.x - 2][self.y + 2].isPoisoned = true

        else self.isInSpellState = false
        end

        if      (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) or (targetCell.x == self.x + 2 and targetCell.y == self.y + 2) then

            boardGrid[self.x + 1][self.y + 1].isPoisoned = true
            boardGrid[self.x + 2][self.y + 2].isPoisoned = true

        else self.isInSpellState = false
        end

end

 
return Alchemist