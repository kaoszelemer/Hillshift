local Alchemist = Character:extend("Alchemist")
function Alchemist:init(parentPlayer)
    Character.init(self, 12, 4, 2, 2, love.graphics.newImage("/graphics/alchemist.png"), 
                love.graphics.newImage("/graphics/alchemisthover.png"), parentPlayer, 1, 1, 0, 0)
end

function Alchemist:spell(targetCell)

    if self.actionPoints ~= 0 then
            --lefele 1. mezo balra
        if  (self.x - 1 > 0 and self.x - 2 > 0) and (self.y - 1 > 0 and self.y - 2 > 0) and 
            (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or 
            (targetCell.x == self.x - 2 and targetCell.y == self.y - 2) then
                self.actionPoints = self.actionPoints - 1

            
                boardGrid[self.x - 1][self.y - 1].isPoisoned = true
                boardGrid[self.x - 2][self.y - 2].isPoisoned = true
                poisoningTurn = turnCounter

        elseif (self.x - 1 > 0 and self.y - 1 > 0) and (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) then
                self.actionPoints = self.actionPoints - 1

                
                boardGrid[self.x - 1][self.y - 1].isPoisoned = true
                poisoningTurn = turnCounter


        else self.isInSpellState = false
        end
        ---felfele 1. mezo
        if  (self.x + 1 <= 10 and self.x + 2 <= 10) and (self.y - 1 > 0 and self.y - 2 > 0) and    
            (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) or 
            (targetCell.x == self.x + 2 and targetCell.y == self.y - 2) then
                self.actionPoints = self.actionPoints - 1


                boardGrid[self.x + 1][self.y - 1].isPoisoned = true
                boardGrid[self.x + 2][self.y - 2].isPoisoned = true
                poisoningTurn = turnCounter


        elseif (self.x + 1 <= 10 and self.y - 1 > 0) and (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then
                
                boardGrid[self.x + 1][self.y - 1].isPoisoned = true
                poisoningTurn = turnCounter


        else self.isInSpellState = false
        end
--------
        if  (self.x - 1 > 0 and self.x - 2 > 0) and (self.y + 1 <= 10 and self.y + 2 <= 10) and
            (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or
            (targetCell.x == self.x - 2 and targetCell.y == self.y + 2) then
                self.actionPoints = self.actionPoints - 1


                boardGrid[self.x - 1][self.y + 1].isPoisoned = true
                boardGrid[self.x - 2][self.y + 2].isPoisoned = true
                poisoningTurn = turnCounter


        elseif (self.x - 1 > 0 and self.y + 1 <= 10) and (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) then
                self.actionPoints = self.actionPoints - 1


                boardGrid[self.x - 1][self.y + 1].isPoisoned = true
                poisoningTurn = turnCounter


        else self.isInSpellState = false
        end
----------
        if  (self.x + 1 <= 10 and self.x + 2 <= 10) and (self.y + 1 <= 10 and self.y + 2 <= 10) and
            (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) or 
            (targetCell.x == self.x + 2 and targetCell.y == self.y + 2) then
                self.actionPoints = self.actionPoints - 1


                boardGrid[self.x + 1][self.y + 1].isPoisoned = true
                boardGrid[self.x + 2][self.y + 2].isPoisoned = true
                poisoningTurn = turnCounter


        elseif (self.x + 1 <= 10 and self.y + 1 <= 10) and (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) then
                self.actionPoints = self.actionPoints - 1

                
                boardGrid[self.x + 1][self.y + 1].isPoisoned = true
                poisoningTurn = turnCounter

        else self.isInSpellState = false
        end

    end
    
end

 
return Alchemist