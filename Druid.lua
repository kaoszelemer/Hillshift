local Druid = Character:extend("Druid")
    function Druid:init(parentPlayer)
        Character.init(self, 6, 4, 3, 5, love.graphics.newImage("/graphics/druid.png"), 
                    love.graphics.newImage("/graphics/druidhover.png"), parentPlayer)
    end

    function Druid:spell(targetCell)

        if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
        or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
        or (targetCell.y == self.y and targetCell.x == self.x) then
                boardGrid[targetCell.x][targetCell.y] = Forest(targetCell.x, targetCell.y)                
        end
    
    end
    
return Druid