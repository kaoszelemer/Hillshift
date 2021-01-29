local AirElemental = Character:extend("AirElemental")
function AirElemental:init(parentPlayer)
    Character.init(self, 7, 4, 2, 4, love.graphics.newImage("/graphics/airelemental.png"), 
                love.graphics.newImage("/graphics/airelementalhover.png"), parentPlayer)
end

function AirElemental:spell(targetCell)   

    if      (targetCell.x == self.x and targetCell.y == self.y - 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then

        if boardGrid[self.x][self.y - 1].isOccupied and not boardGrid[self.x][self.y - 2].occupiedBy then
            boardGrid[self.x][self.y - 1].occupiedBy:move(self.x, self.y - 2)
        end

        if boardGrid[self.x - 1][self.y - 1].isOccupied and not boardGrid[self.x - 2][self.y - 2].occupiedBy then
            boardGrid[self.x - 1][self.y - 1].occupiedBy:move(self.x - 2, self.y - 2)
        end

        if boardGrid[self.x + 1][self.y - 1].isOccupied and not boardGrid[self.x - 2][self.y - 2].occupiedBy then
            boardGrid[self.x + 1][self.y - 1].occupiedBy:move(self.x + 2, self.y - 2)
        end

        if boardGrid[self.x][self.y - 1].isPoisoned then boardGrid[self.x][self.y - 1].isPoisoned = false end
        if boardGrid[self.x - 1][self.y - 1].isPoisoned then boardGrid[self.x - 1][self.y - 1].isPoisoned = false end
        if boardGrid[self.x + 1][self.y - 1].isPoisoned then boardGrid[self.x + 1][self.y - 1].isPoisoned = false end

        local fireSpread = love.math.random(0, 2)

        if boardGrid[self.x][self.y - 1].isOnFire then boardGrid[self.x][self.y - fireSpread].isOnFire = true end
        if boardGrid[self.x - 1][self.y - 1].isOnFire then boardGrid[self.x - 2][self.y - fireSpread].isOnFire = true end
        if boardGrid[self.x + 1][self.y - 1].isOnFire then boardGrid[self.x + 2][self.y - fireSpread].isOnFire = true end




    else self.isInSpellState = false
    end

    if      (targetCell.x == self.x and targetCell.y == self.y + 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) then

        if boardGrid[self.x][self.y + 1].isOccupied and not boardGrid[self.x][self.y + 2].occupiedBy then
            boardGrid[self.x][self.y + 1].occupiedBy:move(self.x, self.y + 2)
        end

        if boardGrid[self.x - 1][self.y + 1].isOccupied and not boardGrid[self.x - 2][self.y + 2].occupiedBy then
            boardGrid[self.x - 1][self.y + 1].occupiedBy:move(self.x - 2, self.y + 2)
        end

        if boardGrid[self.x + 1][self.y + 1].isOccupied and not boardGrid[self.x - 2][self.y + 2].occupiedBy then
            boardGrid[self.x + 1][self.y + 1].occupiedBy:move(self.x + 2, self.y + 2)
        end

        if boardGrid[self.x][self.y + 1].isPoisoned then boardGrid[self.x][self.y + 1].isPoisoned = false end
        if boardGrid[self.x - 1][self.y + 1].isPoisoned then boardGrid[self.x - 1][self.y + 1].isPoisoned = false end
        if boardGrid[self.x + 1][self.y + 1].isPoisoned then boardGrid[self.x + 1][self.y + 1].isPoisoned = false end

        local fireSpread = love.math.random(0, 2)

        if boardGrid[self.x][self.y + 1].isOnFire then boardGrid[self.x][self.y + fireSpread].isOnFire = true end
        if boardGrid[self.x - 1][self.y + 1].isOnFire then boardGrid[self.x - 2][self.y + fireSpread].isOnFire = true end
        if boardGrid[self.x + 1][self.y + 1].isOnFire then boardGrid[self.x + 2][self.y + fireSpread].isOnFire = true end

    else self.isInSpellState = false
    end


end
    
return AirElemental