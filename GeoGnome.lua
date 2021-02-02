local GeoGnome = Character:extend("GeoGnome")

function GeoGnome:init(parentPlayer)
    Character.init(self, 10, 6, 0, 1, love.graphics.newImage("/graphics/geognome.png"), 
                love.graphics.newImage("/graphics/geognomehover.png"), parentPlayer, 1, 1)
end

function GeoGnome:spell(targetCell)

    if self.actionPoints ~= 0 then
            if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
            or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
            or (targetCell.y == self.y and targetCell.x == self.x) then            

                    boardGrid[targetCell.x][targetCell.y] = Mount(targetCell.x, targetCell.y)

            end
        
        self.actionPoints = self.actionPoints - 1
    end


end


   
return GeoGnome