local WaterHag = Character:extend("WaterHag")

function WaterHag:init(parentPlayer)
    Character.init(self, 13, 3, 2, 9, love.graphics.newImage("/graphics/waterwitch.png"), 
                love.graphics.newImage("/graphics/waterwitchhover.png"), 
                love.graphics.newImage("/graphics/waterwitchsink.png"), 
                love.graphics.newImage("/graphics/waterwitchsinkhover.png"), 
                parentPlayer, 1, 1, 0, 0, 0, false)
end

function WaterHag:spell(targetCell)

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

                    if targetCell.x + randomWaterSpreadX <= 10 and targetCell.x - randomWaterSpreadX > 0 and
                       targetCell.y + randomWaterSpreadY <= 10 and targetCell.y - randomWaterSpreadY > 0 then                 

                        if love.math.random() < 0.25 then boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY] = Lake(targetCell.x + randomWaterSpreadX, targetCell.y + randomWaterSpreadY) end
                        if love.math.random() < 0.25 then boardGrid[targetCell.x - randomWaterSpreadX][targetCell.y + randomWaterSpreadY] = Lake(targetCell.x - randomWaterSpreadX, targetCell.y + randomWaterSpreadY) end
                        if love.math.random() < 0.25 then boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y - randomWaterSpreadY] = Lake(targetCell.x + randomWaterSpreadX, targetCell.y - randomWaterSpreadY) end
                        if love.math.random() < 0.25 then boardGrid[targetCell.x - randomWaterSpreadX][targetCell.y - randomWaterSpreadY] = Lake(targetCell.x - randomWaterSpreadX, targetCell.y - randomWaterSpreadY) end
                        if love.math.random() < 0.33 then boardGrid[targetCell.x][targetCell.y - randomWaterSpreadY] = Lake(targetCell.x, targetCell.y - randomWaterSpreadY) end
                        if love.math.random() < 0.33 then boardGrid[targetCell.x][targetCell.y + randomWaterSpreadY] = Lake(targetCell.x, targetCell.y + randomWaterSpreadY) end
                        if love.math.random() < 0.33 then boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y] = Lake(targetCell.x + randomWaterSpreadX, targetCell.y) end
                        if love.math.random() < 0.33 then boardGrid[targetCell.x - randomWaterSpreadX][targetCell.y] = Lake(targetCell.x - randomWaterSpreadX, targetCell.y) end
                    end
                end
                
                
            end
        
    end


end


   
return WaterHag