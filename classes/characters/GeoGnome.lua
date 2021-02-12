local GeoGnome = Character:extend("GeoGnome")

function GeoGnome:init(parentPlayer)
    Character.init(self, 14, 3, 1, 1, love.graphics.newImage("/graphics/geognome.png"), 
                love.graphics.newImage("/graphics/geognomehover.png"), 
                love.graphics.newImage("/graphics/geognomesink.png"), 
                love.graphics.newImage("/graphics/geognomesinkhover.png"), 
                parentPlayer, 1, 1, 0, 0, 0, false)
end

function GeoGnome:spell(targetCell)

    if self.actionPoints ~= 0 then
            if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
            or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
            or (targetCell.y == self.y and targetCell.x == self.x) then   
                self.actionPoints = self.actionPoints - 1
         

                    boardGrid[targetCell.x][targetCell.y] = Mount(targetCell.x, targetCell.y)

            end
        
    end


end


   
return GeoGnome