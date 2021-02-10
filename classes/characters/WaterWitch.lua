local WaterWitch = Character:extend("WaterWitch")

function WaterWitch:init(parentPlayer)
    Character.init(self, 10, 4, 1, 9, love.graphics.newImage("/graphics/waterwitch.png"), 
                love.graphics.newImage("/graphics/waterwitchhover.png"), 
                love.graphics.newImage("/graphics/waterwitchsink.png"), 
                love.graphics.newImage("/graphics/waterwitchsinkhover.png"), 
                parentPlayer, 1, 1, 0, 0, 0, false)
end

function WaterWitch:spell(targetCell)

    if self.actionPoints ~= 0 then
            if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
            or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
            or (targetCell.y == self.y and targetCell.x == self.x) then   
                self.actionPoints = self.actionPoints - 1
         

                if not boardGrid[targetCell.x][targetCell.y]:instanceOf(Desert) then
                        boardGrid[targetCell.x][targetCell.y] = Lake(targetCell.x, targetCell.y)
                elseif boardGrid[targetCell.x][targetCell.y]:instanceOf(Desert) then
                    boardGrid[targetCell.x][targetCell.y] = Swamp(targetCell.x, targetCell.y)
                end
                
                
                if boardGrid[targetCell.x][targetCell.y]:instanceOf(Lake) then
                    local randomWaterSpreadX = love.math.random(0,1)
                    local randomWaterSpreadY = love.math.random(0,1)

                      

                        if love.math.random() < 0.25 then boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY] = Lake(targetCell.x + randomWaterSpreadX, targetCell.y + randomWaterSpreadY) end
                        if love.math.random() < 0.25 then boardGrid[targetCell.x - randomWaterSpreadX][targetCell.y + randomWaterSpreadY] = Lake(targetCell.x - randomWaterSpreadX, targetCell.y + randomWaterSpreadY) end
                        if love.math.random() < 0.25 then boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y - randomWaterSpreadY] = Lake(targetCell.x + randomWaterSpreadX, targetCell.y - randomWaterSpreadY) end
                        if love.math.random() < 0.25 then boardGrid[targetCell.x - randomWaterSpreadX][targetCell.y - randomWaterSpreadY] = Lake(targetCell.x - randomWaterSpreadX, targetCell.y - randomWaterSpreadY) end
                        if love.math.random() < 0.33 then boardGrid[targetCell.x][targetCell.y - randomWaterSpreadY] = Lake(targetCell.x + randomWaterSpreadX, targetCell.y - randomWaterSpreadY) end
                        if love.math.random() < 0.33 then boardGrid[targetCell.x][targetCell.y + randomWaterSpreadY] = Lake(targetCell.x - randomWaterSpreadX, targetCell.y - randomWaterSpreadY) end

                end
                
                
            end
        
    end


end


   
return WaterWitch