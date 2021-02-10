local Alchemist = Character:extend("Alchemist")
function Alchemist:init(parentPlayer)
    Character.init(self, 12, 3, 3, 2, love.graphics.newImage("/graphics/alchemist.png"), 
                love.graphics.newImage("/graphics/alchemisthover.png"),
                love.graphics.newImage("/graphics/alchemistsink.png"),
                love.graphics.newImage("/graphics/alchemistsinkhover.png"),

                parentPlayer, 1, 1, 0, 0, 0, false)
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
                boardGrid[self.x - 1][self.y - 1].poisoningTurn = turnCounter
                boardGrid[self.x - 2][self.y - 2].poisoningTurn = turnCounter

                boardGrid[self.x - 1][self.y - 1].attackModifier = boardGrid[self.x - 1][self.y - 1].attackModifier - 1
                boardGrid[self.x - 2][self.y - 2].attackModifier = boardGrid[self.x - 2][self.y - 2].attackModifier - 1
                boardGrid[self.x - 1][self.y - 1].defenseModifier = boardGrid[self.x - 1][self.y - 1].defenseModifier - 2
                boardGrid[self.x - 2][self.y - 2].defenseModifier = boardGrid[self.x - 2][self.y - 2].defenseModifier - 2

        elseif (self.x - 1 > 0 and self.y - 1 > 0) and (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) then
                self.actionPoints = self.actionPoints - 1

                
                boardGrid[self.x - 1][self.y - 1].isPoisoned = true
                boardGrid[self.x - 1][self.y - 1].attackModifier = boardGrid[self.x - 1][self.y - 1].attackModifier - 1
                boardGrid[self.x - 1][self.y - 1].defenseModifier = boardGrid[self.x - 1][self.y - 1].defenseModifier - 2
                boardGrid[self.x - 1][self.y - 1].poisoningTurn = turnCounter


        else self.isInSpellState = false
        end
        ---felfele 1. mezo
        if  (self.x + 1 <= 10 and self.x + 2 <= 10) and (self.y - 1 > 0 and self.y - 2 > 0) and    
            (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) or 
            (targetCell.x == self.x + 2 and targetCell.y == self.y - 2) then
                self.actionPoints = self.actionPoints - 1


                boardGrid[self.x + 1][self.y - 1].isPoisoned = true
                boardGrid[self.x + 2][self.y - 2].isPoisoned = true
                boardGrid[self.x + 1][self.y - 1].attackModifier = boardGrid[self.x + 1][self.y - 1].attackModifier - 1
                boardGrid[self.x + 2][self.y - 2].attackModifier = boardGrid[self.x + 2][self.y - 2].attackModifier - 1
                boardGrid[self.x + 1][self.y - 1].defenseModifier = boardGrid[self.x + 1][self.y - 1].defenseModifier - 2
                boardGrid[self.x + 2][self.y - 2].defenseModifier = boardGrid[self.x + 2][self.y - 2].defenseModifier - 2

                boardGrid[self.x + 1][self.y - 1].poisoningTurn = turnCounter
                boardGrid[self.x + 2][self.y - 2].poisoningTurn = turnCounter


        elseif (self.x + 1 <= 10 and self.y - 1 > 0) and (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then
                
                boardGrid[self.x + 1][self.y - 1].isPoisoned = true
                boardGrid[self.x + 1][self.y - 1].attackModifier = boardGrid[self.x - 1][self.y - 1].attackModifier - 1
                boardGrid[self.x + 1][self.y - 1].defenseModifier = boardGrid[self.x - 1][self.y - 1].defenseModifier - 2
                boardGrid[self.x + 1][self.y - 1].poisoningTurn = turnCounter


        else self.isInSpellState = false
        end
--------
        if  (self.x - 1 > 0 and self.x - 2 > 0) and (self.y + 1 <= 10 and self.y + 2 <= 10) and
            (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or
            (targetCell.x == self.x - 2 and targetCell.y == self.y + 2) then
                self.actionPoints = self.actionPoints - 1


                boardGrid[self.x - 1][self.y + 1].isPoisoned = true
                boardGrid[self.x - 2][self.y + 2].isPoisoned = true
                boardGrid[self.x - 1][self.y + 1].attackModifier = boardGrid[self.x - 1][self.y + 1].attackModifier - 1
                boardGrid[self.x - 2][self.y + 2].attackModifier = boardGrid[self.x - 2][self.y + 2].attackModifier - 1
                boardGrid[self.x - 1][self.y + 1].defenseModifier = boardGrid[self.x - 1][self.y + 1].defenseModifier - 2
                boardGrid[self.x - 2][self.y + 2].defenseModifier = boardGrid[self.x - 2][self.y + 2].defenseModifier - 2
                boardGrid[self.x - 1][self.y + 1].poisoningTurn = turnCounter
                boardGrid[self.x - 2][self.y + 2].poisoningTurn = turnCounter


        elseif (self.x - 1 > 0 and self.y + 1 <= 10) and (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) then
                self.actionPoints = self.actionPoints - 1


                boardGrid[self.x - 1][self.y + 1].isPoisoned = true
                boardGrid[self.x - 1][self.y + 1].attackModifier = boardGrid[self.x - 1][self.y + 1].attackModifier - 1
                boardGrid[self.x - 1][self.y + 1].defenseModifier = boardGrid[self.x - 1][self.y + 1].defenseModifier - 2
            
                boardGrid[self.x - 1][self.y + 1].poisoningTurn = turnCounter


        else self.isInSpellState = false
        end
----------
        if  (self.x + 1 <= 10 and self.x + 2 <= 10) and (self.y + 1 <= 10 and self.y + 2 <= 10) and
            (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) or 
            (targetCell.x == self.x + 2 and targetCell.y == self.y + 2) then
                self.actionPoints = self.actionPoints - 1


                boardGrid[self.x + 1][self.y + 1].isPoisoned = true
                boardGrid[self.x + 2][self.y + 2].isPoisoned = true
                boardGrid[self.x + 1][self.y + 1].attackModifier = boardGrid[self.x + 1][self.y + 1].attackModifier - 1
                boardGrid[self.x + 2][self.y + 2].attackModifier = boardGrid[self.x + 2][self.y + 2].attackModifier - 1
                boardGrid[self.x + 1][self.y + 1].defenseModifier = boardGrid[self.x + 1][self.y + 1].defenseModifier - 2
                boardGrid[self.x + 2][self.y + 2].defenseModifier = boardGrid[self.x + 2][self.y + 2].defenseModifier - 2
             
                boardGrid[self.x + 1][self.y + 1].poisoningTurn = turnCounter
                boardGrid[self.x + 2][self.y + 2].poisoningTurn = turnCounter


        elseif (self.x + 1 <= 10 and self.y + 1 <= 10) and (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) then
                self.actionPoints = self.actionPoints - 1

                
                boardGrid[self.x + 1][self.y + 1].isPoisoned = true
                boardGrid[self.x + 1][self.y + 1].attackModifier = boardGrid[self.x + 1][self.y + 1].attackModifier - 1
                boardGrid[self.x + 1][self.y + 1].defenseModifier = boardGrid[self.x + 1][self.y + 1].defenseModifier - 2
                boardGrid[self.x + 1][self.y + 1].poisoningTurn = turnCounter

        else self.isInSpellState = false
        end

    end
    
end

 
return Alchemist