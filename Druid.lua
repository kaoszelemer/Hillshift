local Druid = Character:extend("Druid")
    function Druid:init(parentPlayer)
        Character.init(self, 6, 4, 3, 5, love.graphics.newImage("/graphics/druid.png"), 
                    love.graphics.newImage("/graphics/druidhover.png"), parentPlayer)
    end

    function Druid:spell(targetCell)
        local occupyFirstCell
        local occupySecondCell
        local occupyThirdCell
        local occupyFourthCell
        
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

        if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
        or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
        or (targetCell.y == self.y and targetCell.x == self.x) then


                if boardGrid[self.x][self.y - 1].isOccupied == true then  occupyFirstCell = true end
                if boardGrid[self.x][self.y + 1].isOccupied == true then  occupySecondCell = true end
                if boardGrid[self.x - 1][self.y].isOccupied == true then  occupyThirdCell = true end
                if boardGrid[self.x + 1][self.y].isOccupied == true then  occupyFourthCell = true end

                if boardGrid[self.x][self.y - 1].isOnFire == true then  burnFirstCell = true end
                if boardGrid[self.x][self.y + 1].isOnFire == true then  burnSecondCell = true end
                if boardGrid[self.x - 1][self.y].isOnFire == true then  burnThirdCell = true end
                if boardGrid[self.x + 1][self.y].isOnFire == true then  burnFourthCell = true end

                if boardGrid[self.x][self.y - 1].isPoisoned == true then poisonFirstCell = true end
                if boardGrid[self.x][self.y + 1].isPoisoned == true then poisonSecondCell = true end
                if boardGrid[self.x - 1][self.y].isPoisoned == true then poisonThirdCell = true end
                if boardGrid[self.x + 1][self.y].isPoisoned == true then poisonFourthCell = true end

                if boardGrid[self.x][self.y - 1].isFrozen == true then freezeFirstCell = true end
                if boardGrid[self.x][self.y + 1].isFrozen == true then freezeSecondCell = true end
                if boardGrid[self.x - 1][self.y].isFrozen == true then freezeThirdCell = true end
                if boardGrid[self.x + 1][self.y].isFrozen == true then freezeFourthCell = true end

            
                    boardGrid[self.x][self.y - 1] = Forest(self.x, self.y - 1)
                    boardGrid[self.x][self.y + 1] = Forest(self.x, self.y + 1)
                    boardGrid[self.x - 1][self.y] = Forest(self.x - 1, self.y)
                    boardGrid[self.x + 1][self.y] = Forest(self.x + 1, self.y)                




                    
                    if occupyFirstCell == true then 
                        boardGrid[self.x][self.y - 1].isOccupied = true
                        occupyFirstCell = false 
                    end
                    if occupySecondCell == true then 
                        boardGrid[self.x][self.y + 1].isOccupied = true
                        occupySecondCell = false 
                    end
                    if occupyThirdCell == true then 
                        boardGrid[self.x - 1][self.y].isOccupied = true
                        occupyThirdCell = false
                    end
                    if occupyFourthCell == true then 
                        boardGrid[self.x + 1][self.y].isOccupied = true
                        occupyFourthCell = false 
                    end
                    



                if burnFirstCell == true then 
                    boardGrid[self.x][self.y - 1].isOnFire = true
                    burnFirstCell = false 
                end
                if burnSecondCell == true then 
                    boardGrid[self.x][self.y + 1].isOnFire = true
                    burnSecondCell = false 
                end
                if burnThirdCell == true then 
                    boardGrid[self.x - 1][self.y].isOnFire = true
                    burnThirdCell = false
                end
                if burnFourthCell == true then 
                    boardGrid[self.x + 1][self.y].isOnFire = true
                    burnFourthCell = false 
                end
                
                if poisonFirstCell == true then
                    boardGrid[self.x][self.y - 1].isPoisoned = true
                    poisonFirstCell = false
                    end
                if poisonSecondCell == true then
                    boardGrid[self.x][self.y + 1].isPoisoned = true
                    poisonSecondCell = false
                    end
                if poisonThirdCell == true then
                    boardGrid[self.x - 1][self.y].isPoisoned = true
                    poisonThirdCell = false
                    end
                if poisonFourthCell == true then
                    boardGrid[self.x + 1][self.y].isPoisoned = true
                    poisonFourthCell = false
                    end
                
                if freezeFirstCell == true then
                    boardGrid[self.x][self.y - 1].isFrozen = true
                    freezeFirstCell = false 
                    end
                if freezeSecondCell == true then
                    boardGrid[self.x][self.y + 1].isFrozen = true 
                    freezeSecondCell = false
                    end
                if freezeThirdCell == true then
                    boardGrid[self.x - 1][self.y].isFrozen = true 
                    freezeThirdCell = false
                    end
                if freezeFourthCell == true then      
                    boardGrid[self.x + 1][self.y].isFrozen = true 
                    freezeFourthCell = false
                end


            

            self.isInSpellState = false


        else self.isInSpellState = false                       
        end
    
    end
    
return Druid