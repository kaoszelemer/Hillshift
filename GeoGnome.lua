local GeoGnome = Character:extend("GeoGnome")

function GeoGnome:init(parentPlayer)
    Character.init(self, 10, 6, 0, 1, love.graphics.newImage("/graphics/geognome.png"), 
                love.graphics.newImage("/graphics/geognomehover.png"), parentPlayer, 1, 1)
end

function GeoGnome:spell(targetCell)
    local occupyFirstCell
    local occupySecondCell
    local occupyThirdCell
    local occupyFourthCell

    if self.actionPoints ~= 0 then
            if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
            or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
            or (targetCell.y == self.y and targetCell.x == self.x) then
                
                    if self.y - 1 >= 1 and boardGrid[self.x][self.y - 1].isOccupied then occupyFirstCell = true end
                    if self.y + 1 <= 10 and boardGrid[self.x][self.y + 1].isOccupied then occupySecondCell = true end
                    if self.x + 1 <= 10 and boardGrid[self.x + 1][self.y].isOccupied then occupyThirdCell = true end
                    if self.x - 1 >= 1 and boardGrid[self.x - 1][self.y].isOccupied then occupyFourthCell = true end
                    

                    boardGrid[targetCell.x][targetCell.y] = Mount(targetCell.x, targetCell.y)
                    
                    if self.y - 1 >= 1 and occupyFirstCell then
                        boardGrid[self.x][self.y - 1].isOccupied = true
                        occupyFirstCell = false
                    end

                    if self.y + 1 <= 10 and occupySecondCell then
                        boardGrid[self.x][self.y + 1].isOccupied = true
                        occupySecondCell = false
                    end

                    if self.x + 1 <= 10 and occupyThirdCell then
                        boardGrid[self.x + 1][self.y].isOccupied = true
                        occupyThirdCell = false
                    end

                    if self.x - 1 >= 1 and occupyFourthCell then
                        boardGrid[self.x - 1][self.y].isOccupied = true
                        occupyFourthCell = false
                    end

            end
        
        self.actionPoints = self.actionPoints - 1
    end


end


   
return GeoGnome