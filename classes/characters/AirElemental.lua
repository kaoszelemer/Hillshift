local AirElemental = Character:extend("AirElemental")
function AirElemental:init(parentPlayer)
    Character.init(self, 9, 4, 1, 4, love.graphics.newImage("/graphics/airelemental.png"), 
                love.graphics.newImage("/graphics/airelementalhover.png"), 
                love.graphics.newImage("/graphics/airelementalsink.png"),
                love.graphics.newImage("/graphics/airelementalsinkhover.png"),
                parentPlayer, 1, 1, 0, 0, 0, false)
end

function AirElemental:spell(targetCell)
    local chanceOfBurning = love.math.random()
    local fireSpread = 1

    if  chanceOfBurning < 0.75 then
        fireSpread = 2
    end

    if self.actionPoints ~= 0 then
  ------------------------------------------------------------------------------------------------------------------------
                                                -- Karaktertől képernyő teteje felé

    if (targetCell.x == self.x and targetCell.y == self.y - 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then
        self.actionPoints = self.actionPoints - 1
                if (self.y - 2 > 0) and boardGrid[self.x][self.y - 1].isOccupied and not boardGrid[self.x][self.y - 2].isOccupied then
                        boardGrid[self.x][self.y - 1].occupiedBy.stepPoints = boardGrid[self.x][self.y - 1].occupiedBy.stepPoints + 1
                        boardGrid[self.x][self.y - 1].occupiedBy:move(self.x, self.y - 2)
                        
                end
        
                if (self.x - 2 > 0 and self.y - 2 > 0) and boardGrid[self.x - 1][self.y - 1].isOccupied and not boardGrid[self.x - 2][self.y - 2].isOccupied then
                        boardGrid[self.x - 1][self.y - 1].occupiedBy.stepPoints = boardGrid[self.x - 1][self.y - 1].occupiedBy.stepPoints + 1
                        boardGrid[self.x - 1][self.y - 1].occupiedBy:move(self.x - 2, self.y - 2)
                        
                end

                if (self.x + 2 <= 10 and self.y - 2 > 0) and boardGrid[self.x + 1][self.y - 1].isOccupied and not boardGrid[self.x + 2][self.y - 2].isOccupied then
                        boardGrid[self.x + 1][self.y - 1].occupiedBy.stepPoints = boardGrid[self.x + 1][self.y - 1].occupiedBy.stepPoints + 1
                        boardGrid[self.x + 1][self.y - 1].occupiedBy:move(self.x + 2, self.y - 2)
                     
                end
  

        if boardGrid[self.x][self.y - 1].isPoisoned then boardGrid[self.x][self.y - 1].isPoisoned = false end
        if boardGrid[self.x - 1][self.y - 1].isPoisoned then boardGrid[self.x - 1][self.y - 1].isPoisoned = false end
        if boardGrid[self.x + 1][self.y - 1].isPoisoned then boardGrid[self.x + 1][self.y - 1].isPoisoned = false end

        if self.y - fireSpread > 0 then
            if boardGrid[self.x][self.y - 1].isOnFire then 
                if not boardGrid[self.x][self.y - fireSpread]:instanceOf(Lake) then
                    boardGrid[self.x][self.y - fireSpread].isOnFire = true
                end
                if boardGrid[self.x][self.y - fireSpread]:instanceOf(Lake) then
                    boardGrid[self.x][self.y - fireSpread] = Field(self.x, self.y - fireSpread) 
                end
                if boardGrid[self.x][self.y - fireSpread]:instanceOf(Ice) then
                    boardGrid[self.x][self.y - fireSpread] = Lake(self.x, self.y - fireSpread) 
                end
            end
        end


        if self.x - fireSpread > 0 and self.y - fireSpread > 0 then
            if boardGrid[self.x - 1][self.y - 1].isOnFire then
                if not boardGrid[self.x - fireSpread][self.y - fireSpread]:instanceOf(Lake) then 
                    boardGrid[self.x - fireSpread][self.y - fireSpread].isOnFire = true
                end
                if boardGrid[self.x - fireSpread][self.y - fireSpread]:instanceOf(Lake) then 
                    boardGrid[self.x - fireSpread][self.y - fireSpread] = Field(self.x - fireSpread, self.y - fireSpread) 
                end 
                if boardGrid[self.x - fireSpread][self.y - fireSpread]:instanceOf(Ice) then 
                    boardGrid[self.x - fireSpread][self.y - fireSpread] = Lake(self.x - fireSpread, self.y - fireSpread) 
                end 
            end
        end

        if self.x + fireSpread <= 10 and self.y - fireSpread > 0 then
            if boardGrid[self.x + 1][self.y - 1].isOnFire then
                if not boardGrid[self.x + fireSpread][self.y - fireSpread]:instanceOf(Lake) then
                    boardGrid[self.x + fireSpread][self.y - fireSpread].isOnFire = true
                end 
                if boardGrid[self.x + fireSpread][self.y - fireSpread]:instanceOf(Lake) then 
                    boardGrid[self.x + fireSpread][self.y - fireSpread] = Field(self.x + fireSpread, self.y - fireSpread)
                end
                if boardGrid[self.x + fireSpread][self.y - fireSpread]:instanceOf(Ice) then 
                    boardGrid[self.x + fireSpread][self.y - fireSpread] = Lake(self.x + fireSpread, self.y - fireSpread)
                end
            end
        end



    else self.isInSpellState = false
    end

   ------------------------------------------------------------------------------------------------------------------------
                                            -- karaktertől a képernyő alja felé


    if (targetCell.x == self.x and targetCell.y == self.y + 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) then
        self.actionPoints = self.actionPoints - 1
                if (self.y + 2 <= 10) and boardGrid[self.x][self.y + 1].isOccupied and not boardGrid[self.x][self.y + 2].isOccupied then
                    boardGrid[self.x][self.y + 1].occupiedBy.stepPoints = boardGrid[self.x][self.y + 1].occupiedBy.stepPoints + 1
                    boardGrid[self.x][self.y + 1].occupiedBy:move(self.x, self.y + 2)
                    
                end
        
                if (self.x - 2 > 0 and self.y + 2 <= 10) and boardGrid[self.x - 1][self.y + 1].isOccupied and not boardGrid[self.x - 2][self.y + 2].isOccupied then
                    boardGrid[self.x - 1][self.y + 1].occupiedBy.stepPoints = boardGrid[self.x - 1][self.y + 1].occupiedBy.stepPoints + 1
                    boardGrid[self.x - 1][self.y + 1].occupiedBy:move(self.x - 2, self.y + 2)
                    
                end

                if (self.x + 2 <= 10 and self.y + 2 <= 10) and boardGrid[self.x + 1][self.y + 1].isOccupied and not boardGrid[self.x + 2][self.y + 2].isOccupied then
                    boardGrid[self.x + 1][self.y + 1].occupiedBy.stepPoints = boardGrid[self.x + 1][self.y + 1].occupiedBy.stepPoints + 1
                    boardGrid[self.x + 1][self.y + 1].occupiedBy:move(self.x + 2, self.y + 2)
                end


        if boardGrid[self.x][self.y + 1].isPoisoned then boardGrid[self.x][self.y + 1].isPoisoned = false end
        if boardGrid[self.x - 1][self.y + 1].isPoisoned then boardGrid[self.x - 1][self.y + 1].isPoisoned = false end
        if boardGrid[self.x + 1][self.y + 1].isPoisoned then boardGrid[self.x + 1][self.y + 1].isPoisoned = false end
        
        if self.y + fireSpread <= 10 then
            if boardGrid[self.x][self.y + 1].isOnFire then 
                if not boardGrid[self.x][self.y + fireSpread]:instanceOf(Lake) then
                    boardGrid[self.x][self.y + fireSpread].isOnFire = true
                end
                if boardGrid[self.x][self.y + fireSpread]:instanceOf(Lake) then
                    boardGrid[self.x][self.y + fireSpread] = Field(self.x, self.y + fireSpread) 
                end
                if boardGrid[self.x][self.y + fireSpread]:instanceOf(Ice) then
                    boardGrid[self.x][self.y + fireSpread] = Lake(self.x, self.y + fireSpread) 
                end
            end
        end

        if self.x - fireSpread > 0 and self.y + fireSpread <= 10 then
            if boardGrid[self.x - 1][self.y + 1].isOnFire then
                if not boardGrid[self.x - fireSpread][self.y + fireSpread]:instanceOf(Lake) then 
                    boardGrid[self.x - fireSpread][self.y + fireSpread].isOnFire = true
                end
                if boardGrid[self.x - fireSpread][self.y + fireSpread]:instanceOf(Lake) then 
                    boardGrid[self.x - fireSpread][self.y + fireSpread] = Field(self.x - fireSpread, self.y + fireSpread) 
                end 
                if boardGrid[self.x - fireSpread][self.y + fireSpread]:instanceOf(Ice) then 
                    boardGrid[self.x - fireSpread][self.y + fireSpread] = Lake(self.x - fireSpread, self.y + fireSpread) 
                end 
            end
        end

        if self.x + fireSpread <= 10 and self.y + fireSpread <= 10 then
            if boardGrid[self.x + 1][self.y + 1].isOnFire then
                if not boardGrid[self.x + fireSpread][self.y + fireSpread]:instanceOf(Lake) then
                    boardGrid[self.x + fireSpread][self.y + fireSpread].isOnFire = true
                end 
                if boardGrid[self.x + fireSpread][self.y + fireSpread]:instanceOf(Lake) then 
                    boardGrid[self.x + fireSpread][self.y + fireSpread] = Field(self.x + fireSpread, self.y + fireSpread)
                end
                if boardGrid[self.x + fireSpread][self.y + fireSpread]:instanceOf(Ice) then 
                    boardGrid[self.x + fireSpread][self.y + fireSpread] = Lake(self.x + fireSpread, self.y + fireSpread)
                end
            end
        end

    else self.isInSpellState = false
    end
    end

end
    
return AirElemental