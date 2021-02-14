local Alchemist = Character:extend("Alchemist")
function Alchemist:init(parentPlayer)
    Character.init(self, 12, 3, 3, 2, love.graphics.newImage("/graphics/alchemist.png"), 
                love.graphics.newImage("/graphics/alchemisthover.png"),
                love.graphics.newImage("/graphics/alchemistsink.png"),
                love.graphics.newImage("/graphics/alchemistsinkhover.png"),

                parentPlayer, 1, 1, 0, 0, 0, false)
end

function Alchemist:poisonBoardGrid(targetCell)
      
                if pointerOnTopLeftSide then 
                        if self.x - 1 > 0 and self.y - 1 > 0 then boardGrid[self.x - 1][self.y - 1].isPoisoned = true end
                        if self.x - 2 > 0 and self.y - 2 > 0 then boardGrid[self.x - 2][self.y - 2].isPoisoned = true end
                elseif pointerOnTopRightSide then
                        if self.x + 1 <= 10 and self.y - 1 > 0 then boardGrid[self.x + 1][self.y - 1].isPoisoned = true end
                        if self.x + 2 <= 10 and self.y - 2 > 0 then boardGrid[self.x + 2][self.y - 2].isPoisoned = true end
                elseif pointerOnBottomLeftSide then
                        if self.x - 1 > 0 and self.y + 1 <= 10 then boardGrid[self.x - 1][self.y + 1].isPoisoned = true end
                        if self.x - 2 > 0 and self.y + 2 <= 10 then boardGrid[self.x - 2][self.y + 2].isPoisoned = true end
                elseif pointerOnBottomRightSide then
                        if self.x + 1 <= 10 and self.y + 1 <= 10 then boardGrid[self.x + 1][self.y + 1].isPoisoned = true end
                        if self.x + 2 <= 10 and self.y + 2 <= 10 then boardGrid[self.x + 2][self.y + 2].isPoisoned = true end
                end

end

function Alchemist:spell(targetCell)
        if self.actionPoints ~= 0 then
                self:poisonBoardGrid(targetCell)
                self.actionPoints = self.actionPoints - 1
        else self.isInSpellState = false
        end

end

return Alchemist