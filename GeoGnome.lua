local GeoGnome = Character:extend("GeoGnome")

function GeoGnome:init(parentPlayer)
    Character.init(self, 10, 6, 0, 1, love.graphics.newImage("/graphics/geognome.png"), 
                love.graphics.newImage("/graphics/geognomehover.png"), parentPlayer)
end

function GeoGnome:spell(targetCell)

   
        if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
        or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
        or (targetCell.y == self.y and targetCell.x == self.x) then
                if boardGrid[targetCell.x][targetCell.y].isOccupied then
                    setOccupied = true
                end

                boardGrid[targetCell.x][targetCell.y] = Mount(targetCell.x, targetCell.y)
                
                if setOccupied then
                    boardGrid[targetCell.x][targetCell.y].isOccupied = true
                    setOccupied = false
                end      
        end

end


   
return GeoGnome