local SandWitch = Character:extend("SandWitch")
    function SandWitch:init(parentPlayer)
        Character.init(self, 8, 3, 1, 8, love.graphics.newImage("/graphics/hillshifthag.png"), 
                    love.graphics.newImage("/graphics/hillshifthaghover.png"), 
                    love.graphics.newImage("/graphics/hillshifthagsink.png"), 
                    love.graphics.newImage("/graphics/hillshifthagsinkhover.png"), 
                    parentPlayer, 1, 1, 0, 0, 0, false)
    end

    function SandWitch:spell(targetCell)
        if self.actionPoints ~= 0 then
        
        if targetCell.x == self.x + 1 or targetCell.x == self.x - 1 then
            self.actionPoints = self.actionPoints - 1
            

            if self.x - 1 > 0 then

    
                   if boardGrid[self.x - 1][self.y]:instanceOf(Mount) then 
                    boardGrid[self.x - 1][self.y] = Desert(self.x - 1, self.y)
                   end
      
            end
            
            if self.x + 1 <= 10 then

                if boardGrid[self.x + 1][self.y]:instanceOf(Mount) then 
                    boardGrid[self.x + 1][self.y] = Desert(self.x + 1, self.y)
                end

            end

             self.isInSpellState = false

        else self.isInSpellState = false                       
        end
    end
    end
    
return SandWitch