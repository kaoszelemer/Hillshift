local Cell = class("Cell")

function Cell:init(x, y, isWalkable, quad)
    self.x = x
    self.y = y
    self.isWalkable = isWalkable
    self.quad = quad
end

function Cell:click()
        if selectedChar.isInStepState and not self.isOccupied then
            

            selectedChar:move(self.x, self.y)
            board:resetAllCharacterStates(playerOne, playerTwo)
        end

end



return Cell