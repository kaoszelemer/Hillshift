local Cell = class("Cell")

function Cell:init(x, y, isWalkable, quad)
    self.x = x
    self.y = y
    self.isWalkable = isWalkable
    self.quad = quad
end

function Cell:click()

       --valami itt még nem jó meg kell nézni az OOP előtti szabályt a mozgáshoz
        if selectedChar.isInStepState and not self.isOccupied then
            if self.x + 1 < 11 and selectedChar.isWalkable[boardGrid[(self.x + 1)][self.y].class.name] and not boardGrid[(self.x + 1)][self.y].isOccupied then
                selectedChar:move(self.x + 1, self.y)
            
            elseif self.x - 1 > 0 and selectedChar.isWalkable[boardGrid[self.x - 1][self.y].class.name] and not boardGrid[self.x - 1][self.y].isOccupied then 
                selectedChar:move(self.x - 1, self.y)
            
            elseif self.y + 1 < 11 and selectedChar.isWalkable[boardGrid[(self.x)][self.y + 1].class.name] and not boardGrid[self.x][(self.y + 1)].isOccupied then 
                selectedChar:move(self.x, self.y + 1)
            
            elseif self.y - 1 > 0 and selectedChar.isWalkable[boardGrid[self.x][self.y - 1].class.name] and not boardGrid[self.x][(self.y - 1)].isOccupied then 
                selectedChar:move(self.x, self.y - 1)
            
            elseif self.x + 1 < 11 and self.y + 1 < 11 and selectedChar.isWalkable[boardGrid[(self.x + 1)][self.y + 1].class.name] and not boardGrid[(self.x + 1)][self.y + 1].isOccupied  then
                selectedChar:move(self.x + 1, self.y + 1) 
            
            elseif self.x - 1 > 0 and self.y - 1 > 0 and selectedChar.isWalkable[boardGrid[(self.x - 1)][self.y - 1].class.name]  and not boardGrid[(self.x - 1)][self.y - 1].isOccupied then
                selectedChar:move(self.x - 1, self.y - 1)
               
            elseif self.x + 1 < 11 and self.y - 1 > 0 and selectedChar.isWalkable[boardGrid[(self.x + 1)][self.y - 1].class.name] and not boardGrid[(self.x + 1)][self.y - 1].isOccupied then 
                selectedChar:move(self.x + 1, self.y - 1)
            
            elseif self.x - 1 > 0 and self.y + 1 < 11 and selectedChar.isWalkable[boardGrid[(self.x - 1)][self.y + 1].class.name] and not boardGrid[(self.x - 1)][self.y + 1].isOccupied then 
                selectedChar:move(self.x - 1, self.y + 1)
            end
            
            -- ide kell hogy ha tobb a cell.x-em mint 2 akkor deszelektál

            board:resetAllCharacterStates(playerOne, playerTwo)
        end

end



return Cell