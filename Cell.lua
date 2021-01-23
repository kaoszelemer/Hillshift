local Cell = class("Cell")

function Cell:init(x, y, isWalkable, quad)
    self.x = x
    self.y = y
    self.isWalkable = isWalkable
    self.quad = quad
end

function Cell:click()

        if type(selectedChar) == 'table' and selectedChar.isInStepState and not self.isOccupied then
            if self.x + 1 < 11 and (self.x == selectedChar.x + 1 and self.y == selectedChar.y) and selectedChar.isWalkable[boardGrid[(self.x + 1)][self.y].class.name] and not boardGrid[(self.x + 1)][self.y].isOccupied then
                selectedChar:move(self.x, self.y)
            
            elseif self.x - 1 > 0 and  (self.x == selectedChar.x - 1 and self.y == selectedChar.y) and selectedChar.isWalkable[boardGrid[self.x - 1][self.y].class.name] and not boardGrid[self.x - 1][self.y].isOccupied then 
                selectedChar:move(self.x, self.y)
            
            elseif self.y + 1 < 11 and  (self.x == selectedChar.x and self.y == selectedChar.y + 1) and selectedChar.isWalkable[boardGrid[(self.x)][self.y + 1].class.name] and not boardGrid[self.x][(self.y + 1)].isOccupied then 
                selectedChar:move(self.x, self.y)
            
            elseif self.y - 1 > 0 and (self.x == selectedChar.x and self.y == selectedChar.y - 1) and selectedChar.isWalkable[boardGrid[self.x][self.y - 1].class.name] and not boardGrid[self.x][(self.y - 1)].isOccupied then 
                selectedChar:move(self.x, self.y )
            
            elseif (self.x + 1 < 11 and self.y + 1 < 11) and (self.x == selectedChar.x + 1 and self.y == selectedChar.y + 1) and selectedChar.isWalkable[boardGrid[(self.x + 1)][self.y + 1].class.name] and not boardGrid[(self.x + 1)][self.y + 1].isOccupied  then
                selectedChar:move(self.x, self.y) 
            
            elseif self.x - 1 > 0 and self.y - 1 > 0 and (self.x == selectedChar.x - 1 and self.y == selectedChar.y - 1) and selectedChar.isWalkable[boardGrid[(self.x - 1)][self.y - 1].class.name]  and not boardGrid[(self.x - 1)][self.y - 1].isOccupied then
                selectedChar:move(self.x, self.y)
               
            elseif self.x + 1 < 11 and self.y - 1 > 0 and (self.x == selectedChar.x + 1 and self.y == selectedChar.y - 1) and selectedChar.isWalkable[boardGrid[(self.x + 1)][self.y - 1].class.name] and not boardGrid[(self.x + 1)][self.y - 1].isOccupied then 
                selectedChar:move(self.x, self.y)
            
            elseif self.x - 1 > 0 and self.y + 1 < 11 and (self.x == selectedChar.x - 1 and self.y == selectedChar.y + 1) and selectedChar.isWalkable[boardGrid[(self.x - 1)][self.y + 1].class.name] and not boardGrid[(self.x - 1)][self.y + 1].isOccupied then 
                selectedChar:move(self.x, self.y)
            end
            

            board:resetAllCharacterStates(playerOne, playerTwo)
        end

end



return Cell