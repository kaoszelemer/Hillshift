local Druid = Character:extend("Druid")
    function Druid:init(parentPlayer)
        Character.init(self, 8, 4, 2, 5, love.graphics.newImage("/graphics/druid.png"), 
                    love.graphics.newImage("/graphics/druidhover.png"), parentPlayer, 1, 1)
    end

    function Druid:spell(targetCell)
        if self.actionPoints ~= 0 then
        
        local burnFirstCell
        local burnSecondCell
        local burnThirdCell
        local burnFourthCell

        local poisonFirstCell
        local poisonSecondCell
        local poisonThirdCell
        local poisonFourthCell

        local freezeFirstCell
        local freezeSecondCell
        local freezeThirdCell
        local freezeFourthCell

        if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) or
           (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1)) or
           (targetCell.y == self.y and targetCell.x == self.x) then

            if self.y - 1 > 0 then

                if boardGrid[self.x][self.y - 1].isOnFire == true then  burnFirstCell = true end
                if boardGrid[self.x][self.y - 1].isPoisoned == true then poisonFirstCell = true end
                if boardGrid[self.x][self.y - 1].isFrozen == true then freezeFirstCell = true end
               
                    boardGrid[self.x][self.y - 1] = Forest(self.x, self.y - 1)
                      
            
                if burnFirstCell == true then 
                    boardGrid[self.x][self.y - 1].isOnFire = true
                    burnFirstCell = false 
                end
                       
                if poisonFirstCell == true then
                    boardGrid[self.x][self.y - 1].isPoisoned = true
                    poisonFirstCell = false
                end
                             
                if freezeFirstCell == true then
                    boardGrid[self.x][self.y - 1].isFrozen = true
                    freezeFirstCell = false 
                end
            end
            
            if self.y + 1 <= 10 then

                if boardGrid[self.x][self.y + 1].isOnFire == true then  burnSecondCell = true end
                if boardGrid[self.x][self.y + 1].isPoisoned == true then poisonSecondCell = true end
                if boardGrid[self.x][self.y + 1].isFrozen == true then freezeSecondCell = true end
               
                    boardGrid[self.x][self.y + 1] = Forest(self.x, self.y + 1)
                      
              
            
                if burnSecondCell == true then 
                    boardGrid[self.x][self.y + 1].isOnFire = true
                    burnSecondCell = false 
                end
                       
                if poisonSecondCell == true then
                    boardGrid[self.x][self.y + 1].isPoisoned = true
                    poisonSecondCell = false
                end
                             
                if freezeSecondCell == true then
                    boardGrid[self.x][self.y + 1].isFrozen = true
                    freezeSecondCell = false 
                end
            end

            if self.x - 1 > 0 then

                if boardGrid[self.x - 1][self.y].isOnFire == true then  burnThirdCell = true end
                if boardGrid[self.x - 1][self.y].isPoisoned == true then poisonThirdCell = true end
                if boardGrid[self.x - 1][self.y].isFrozen == true then freezeThirdCell = true end
               
                    boardGrid[self.x - 1][self.y] = Forest(self.x - 1, self.y)
                      
              
            
                if burnThirdCell == true then 
                    boardGrid[self.x - 1][self.y].isOnFire = true
                    burnThirdCell = false 
                end
                       
                if poisonThirdCell == true then
                    boardGrid[self.x - 1][self.y].isPoisoned = true
                    poisonThirdCell = false
                end
                             
                if freezeThirdCell == true then
                    boardGrid[self.x - 1][self.y].isFrozen = true
                    freezeThirdCell = false 
                end
            end

            if self.x + 1 <= 10 then

                if boardGrid[self.x + 1][self.y].isOnFire == true then  burnFourthCell = true end
                if boardGrid[self.x + 1][self.y].isPoisoned == true then poisonFourthCell = true end
                if boardGrid[self.x + 1][self.y].isFrozen == true then freezeFourthCell = true end
               
                    boardGrid[self.x + 1][self.y] = Forest(self.x + 1, self.y)
            
                if burnFourthCell == true then 
                    boardGrid[self.x + 1][self.y].isOnFire = true
                    burnFourthCell = false 
                end
                       
                if poisonFourthCell == true then
                    boardGrid[self.x + 1][self.y].isPoisoned = true
                    poisonFourthCell = false
                end
                             
                if freezeFourthCell == true then
                    boardGrid[self.x + 1][self.y].isFrozen = true
                    freezeFourthCell = false 
                end
            
            end
            self.isInSpellState = false

        else self.isInSpellState = false                       
        end
    end
    self.actionPoints = self.actionPoints - 1
    end
    
return Druid