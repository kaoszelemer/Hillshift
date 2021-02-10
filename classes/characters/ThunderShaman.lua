local ThunderShaman = Character:extend("ThunderShaman")
function ThunderShaman:init(parentPlayer)
    Character.init(self, 7, 5, 1, 7, 
    love.graphics.newImage("/graphics/thundershaman.png"),            
    love.graphics.newImage("/graphics/thundershamanhover.png"),
    love.graphics.newImage("/graphics/thundershamansink.png"), 
    love.graphics.newImage("/graphics/thundershamansinkhover.png"), 
    parentPlayer, 1, 1)
end

function ThunderShaman:spell(targetCell)
    if self.actionPoints ~= 0 then
    
        if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y - 2)) or
            (targetCell.x == self.x and (targetCell.y == self.y + 1 or targetCell.y == self.y + 2)) then
            for i = 1, #activePlayer.characters do
                if self.y - 1 > 0 then
                    boardGrid[self.x][self.y - 1].drawLightning = true
                    lightningTimer = love.timer.getTime()
                        if boardGrid[self.x][self.y - 1]:instanceOf(Lake) then
                            if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y - 1 then
                                activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                            end
                        else
                            if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y - 1 then
                                activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                            end
                        end

                        if boardGrid[self.x][self.y - 1].isPoisoned and boardGrid[self.x][self.y - 1].isFrozen then
                            boardGrid[self.x][self.y - 1] = MagicForest(self.x, self.y - 1)
                        end
                    
                        if boardGrid[self.x][self.y - 1].isPoisoned and boardGrid[self.x][self.y - 1].isOnFire then
                            boardGrid[self.x][self.y - 1] = MagicForest(self.x, self.y - 1)
                        end
                end
                
                if self.y - 2 > 0 then
                    boardGrid[self.x][self.y - 1].drawLightning = true
                    boardGrid[self.x][self.y - 2].drawLightning = true
                    lightningTimer = love.timer.getTime()

                    if boardGrid[self.x][self.y - 1]:instanceOf(Lake) then
                        if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y - 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y - 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end

                    if boardGrid[self.x][self.y - 2]:instanceOf(Lake) then
                        if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y - 2 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y - 2 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end
                    if boardGrid[self.x][self.y - 1].isPoisoned and boardGrid[self.x][self.y - 1].isFrozen then
                        boardGrid[self.x][self.y - 1] = MagicForest(self.x, self.y - 1)
                    end
                    if boardGrid[self.x][self.y - 2].isPoisoned and boardGrid[self.x][self.y - 2].isFrozen then
                        boardGrid[self.x][self.y - 2] = MagicForest(self.x, self.y - 2)
                    end
                    if boardGrid[self.x][self.y - 1].isPoisoned and boardGrid[self.x][self.y - 1].isOnFire then
                        boardGrid[self.x][self.y - 1] = MagicForest(self.x, self.y - 1)
                    end
                    if boardGrid[self.x][self.y - 2].isPoisoned and boardGrid[self.x][self.y - 2].isOnFire then
                        boardGrid[self.x][self.y - 2] = MagicForest(self.x, self.y - 2)
                    end


                end

                if self.y + 1 <= 10 then
                    boardGrid[self.x][self.y + 1].drawLightning = true
                    lightningTimer = love.timer.getTime()

                    if boardGrid[self.x][self.y + 1]:instanceOf(Lake) then
                        if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y + 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y + 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end

                    if boardGrid[self.x][self.y + 1].isPoisoned and boardGrid[self.x][self.y + 1].isFrozen then
                        boardGrid[self.x][self.y + 1] = MagicForest(self.x, self.y + 1)
                    end
                    if boardGrid[self.x][self.y + 1].isPoisoned and boardGrid[self.x][self.y + 1].isOnFire then
                        boardGrid[self.x][self.y + 1] = MagicForest(self.x, self.y + 1)
                    end
                end

                if self.y + 2 <= 10 then
                    boardGrid[self.x][self.y + 1].drawLightning = true
                    boardGrid[self.x][self.y + 2].drawLightning = true
                    lightningTimer = love.timer.getTime()

                    if boardGrid[self.x][self.y + 1]:instanceOf(Lake) then
                        if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y + 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y + 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end
                    
                    if boardGrid[self.x][self.y + 2]:instanceOf(Lake) then
                        if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y + 2 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].x == self.x and activePlayer.characters[i].y == self.y + 2 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end
                
                    if boardGrid[self.x][self.y + 1].isPoisoned and boardGrid[self.x][self.y + 1].isFrozen then
                        boardGrid[self.x][self.y + 1] = MagicForest(self.x, self.y + 1)
                    end
                    if boardGrid[self.x][self.y + 2].isPoisoned and boardGrid[self.x][self.y + 2].isFrozen then
                        boardGrid[self.x][self.y + 2] = MagicForest(self.x, self.y + 2)
                    end
                    if boardGrid[self.x][self.y + 1].isPoisoned and boardGrid[self.x][self.y + 1].isOnFire then
                        boardGrid[self.x][self.y + 1] = MagicForest(self.x, self.y + 1)
                    end
                    if boardGrid[self.x][self.y + 2].isPoisoned and boardGrid[self.x][self.y + 2].isOnFire then
                        boardGrid[self.x][self.y + 2] = MagicForest(self.x, self.y + 2)
                    end
                end
            end
            -----------------------------------------------------------------------------------------INNEN INAKTIVPLAYER

            for i = 1, #inactivePlayer.characters do
                if self.y - 1 > 0 then
                    boardGrid[self.x][self.y - 1].drawLightning = true
                    lightningTimer = love.timer.getTime()

                        if boardGrid[self.x][self.y - 1]:instanceOf(Lake) then
                            if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y - 1 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                            end
                        else
                            if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y - 1 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                            end
                        end
                        if boardGrid[self.x][self.y - 1].isPoisoned and boardGrid[self.x][self.y - 1].isFrozen then
                            boardGrid[self.x][self.y - 1] = MagicForest(self.x, self.y - 1)
                        end
                        if boardGrid[self.x][self.y - 1].isPoisoned and boardGrid[self.x][self.y - 1].isOnFire then
                            boardGrid[self.x][self.y - 1] = MagicForest(self.x, self.y - 1)
                        end
                end
                
                if self.y - 2 > 0 then
                    boardGrid[self.x][self.y - 1].drawLightning = true
                    boardGrid[self.x][self.y - 2].drawLightning = true
                    lightningTimer = love.timer.getTime()

                    if boardGrid[self.x][self.y - 1]:instanceOf(Lake) then
                        if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y - 1 then
                            inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                        end
                    else
                        if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y - 1 then
                            inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                        end
                    end

                    if boardGrid[self.x][self.y - 2]:instanceOf(Lake) then
                        if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y - 2 then
                            inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                        end
                    else
                        if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y - 2 then
                            inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                        end
                    end

                    if boardGrid[self.x][self.y - 1].isPoisoned and boardGrid[self.x][self.y - 1].isFrozen then
                        boardGrid[self.x][self.y - 1] = MagicForest(self.x, self.y - 1)
                    end
                    if boardGrid[self.x][self.y - 2].isPoisoned and boardGrid[self.x][self.y - 2].isFrozen then
                        boardGrid[self.x][self.y - 2] = MagicForest(self.x, self.y - 2)
                    end
                    if boardGrid[self.x][self.y - 1].isPoisoned and boardGrid[self.x][self.y - 1].isOnFire then
                        boardGrid[self.x][self.y - 1] = MagicForest(self.x, self.y - 1)
                    end
                    if boardGrid[self.x][self.y - 2].isPoisoned and boardGrid[self.x][self.y - 2].isOnFire then
                        boardGrid[self.x][self.y - 2] = MagicForest(self.x, self.y - 2)
                    end
                end

                if self.y + 1 <= 10 then
                    boardGrid[self.x][self.y + 1].drawLightning = true
                    lightningTimer = love.timer.getTime()

                    if boardGrid[self.x][self.y + 1]:instanceOf(Lake) then
                        if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y + 1 then
                            inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                        end
                    else
                        if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y + 1 then
                            inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                        end
                    end
                    if boardGrid[self.x][self.y + 1].isPoisoned and boardGrid[self.x][self.y + 1].isFrozen then
                        boardGrid[self.x][self.y + 1] = MagicForest(self.x, self.y + 1)
                    end
                    if boardGrid[self.x][self.y + 1].isPoisoned and boardGrid[self.x][self.y + 1].isOnFire then
                        boardGrid[self.x][self.y + 1] = MagicForest(self.x, self.y + 1)
                    end
                end

                if self.y + 2 <= 10 then
                    boardGrid[self.x][self.y + 1].drawLightning = true
                    boardGrid[self.x][self.y + 2].drawLightning = true
                    lightningTimer = love.timer.getTime()


                    if boardGrid[self.x][self.y + 1]:instanceOf(Lake) then
                        if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y + 1 then
                            inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                        end
                    else
                        if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y + 1 then
                            inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                        end
                    end
                    if boardGrid[self.x][self.y + 2]:instanceOf(Lake) then
                        if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y + 2 then
                            inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                        end
                    else
                        if inactivePlayer.characters[i].x == self.x and inactivePlayer.characters[i].y == self.y + 2 then
                            inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                        end
                    end
                    if boardGrid[self.x][self.y + 1].isPoisoned and boardGrid[self.x][self.y + 1].isFrozen then
                        boardGrid[self.x][self.y + 1] = MagicForest(self.x, self.y + 1)
                    end
                    if boardGrid[self.x][self.y + 2].isPoisoned and boardGrid[self.x][self.y + 2].isFrozen then
                        boardGrid[self.x][self.y + 2] = MagicForest(self.x, self.y + 2)
                    end
                    if boardGrid[self.x][self.y + 1].isPoisoned and boardGrid[self.x][self.y + 1].isOnFire then
                        boardGrid[self.x][self.y + 1] = MagicForest(self.x, self.y + 1)
                    end
                    if boardGrid[self.x][self.y + 2].isPoisoned and boardGrid[self.x][self.y + 2].isOnFire then
                        boardGrid[self.x][self.y + 2] = MagicForest(self.x, self.y + 2)
                    end
                end
            end
    -------------------------------------------------
            self.isInSpellState = false
        else self.isInSpellState = false                       
        end


    if  (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x - 2)) or
        (targetCell.y == self.y and (targetCell.x == self.x + 1 or targetCell.x == self.x + 2)) then
            for i = 1, #activePlayer.characters do
                if self.x - 1 > 0 then
                    boardGrid[self.x - 1][self.y].drawLightning = true
                    lightningTimer = love.timer.getTime()

                    if boardGrid[self.x - 1][self.y]:instanceOf(Lake) then
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x - 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x - 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end
                    if boardGrid[self.x - 1][self.y].isPoisoned and boardGrid[self.x - 1][self.y].isFrozen then
                        boardGrid[self.x - 1][self.y] = MagicForest(self.x - 1, self.y)
                    end
                    if boardGrid[self.x - 1][self.y].isPoisoned and boardGrid[self.x - 1][self.y].isOnFire then
                        boardGrid[self.x - 1][self.y] = MagicForest(self.x - 1, self.y)
                    end
                end
            
                if self.x - 2 > 0 then
                    boardGrid[self.x - 1][self.y].drawLightning = true
                    boardGrid[self.x - 2][self.y].drawLightning = true
                    lightningTimer = love.timer.getTime()


                    if boardGrid[self.x - 1][self.y]:instanceOf(Lake) then
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x - 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x - 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end
                    if boardGrid[self.x - 2][self.y]:instanceOf(Lake) then
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x - 2 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x - 2 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end         
                    if boardGrid[self.x - 1][self.y].isPoisoned and boardGrid[self.x - 1][self.y].isFrozen then
                        boardGrid[self.x - 1][self.y] = MagicForest(self.x - 1, self.y)
                    end
                    if boardGrid[self.x - 2][self.y].isPoisoned and boardGrid[self.x - 2][self.y].isFrozen then
                        boardGrid[self.x - 2][self.y] = MagicForest(self.x - 2, self.y)
                    end
                    if boardGrid[self.x - 1][self.y].isPoisoned and boardGrid[self.x - 1][self.y].isOnFire then
                        boardGrid[self.x - 1][self.y] = MagicForest(self.x - 1, self.y)
                    end
                    if boardGrid[self.x - 2][self.y].isPoisoned and boardGrid[self.x - 2][self.y].isOnFire then
                        boardGrid[self.x - 2][self.y] = MagicForest(self.x - 2, self.y)
                    end
                end

                if self.x + 1 <= 10 then
                    boardGrid[self.x + 1][self.y].drawLightning = true
                    lightningTimer = love.timer.getTime()

                    if boardGrid[self.x + 1][self.y]:instanceOf(Lake) then
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x + 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x + 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end
                    if boardGrid[self.x + 1][self.y].isPoisoned and boardGrid[self.x + 1][self.y].isFrozen then
                        boardGrid[self.x + 1][self.y] = MagicForest(self.x + 1, self.y)
                    end
                    if boardGrid[self.x + 1][self.y].isPoisoned and boardGrid[self.x + 1][self.y].isOnFire then
                        boardGrid[self.x + 1][self.y] = MagicForest(self.x + 1, self.y)
                    end
                end

                if self.x + 2 <= 10 then
                    boardGrid[self.x + 1][self.y].drawLightning = true
                    boardGrid[self.x + 2][self.y].drawLightning = true
                    lightningTimer = love.timer.getTime()

                    if boardGrid[self.x + 1][self.y]:instanceOf(Lake) then
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x + 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x + 1 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end
                    if boardGrid[self.x + 2][self.y]:instanceOf(Lake) then
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x + 2 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 3
                        end
                    else
                        if activePlayer.characters[i].y == self.y and activePlayer.characters[i].x == self.x + 2 then
                            activePlayer.characters[i].baseHP = activePlayer.characters[i].baseHP - 1
                        end
                    end
                    if boardGrid[self.x + 1][self.y].isPoisoned and boardGrid[self.x + 1][self.y].isFrozen then
                        boardGrid[self.x + 1][self.y] = MagicForest(self.x + 1, self.y)
                    end
                    if boardGrid[self.x + 2][self.y].isPoisoned and boardGrid[self.x + 2][self.y].isFrozen then
                        boardGrid[self.x + 2][self.y] = MagicForest(self.x + 2, self.y)
                    end
                    if boardGrid[self.x + 1][self.y].isPoisoned and boardGrid[self.x + 1][self.y].isOnFire then
                        boardGrid[self.x + 1][self.y] = MagicForest(self.x + 1, self.y)
                    end
                    if boardGrid[self.x + 2][self.y].isPoisoned and boardGrid[self.x + 2][self.y].isOnFire then
                        boardGrid[self.x + 2][self.y] = MagicForest(self.x + 2, self.y)
                    end
                end

                -----------------------------------------INNEN INAKTIVPLAYER
                for i = 1, #inactivePlayer.characters do
                    if self.x - 1 > 0 then
                        boardGrid[self.x - 1][self.y].drawLightning = true
                        lightningTimer = love.timer.getTime()

                        if boardGrid[self.x - 1][self.y]:instanceOf(Lake) then
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x - 1 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                            end
                        else
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x - 1 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                            end
                        end
                        if boardGrid[self.x - 1][self.y].isPoisoned and boardGrid[self.x - 1][self.y].isFrozen then
                            boardGrid[self.x - 1][self.y] = MagicForest(self.x - 1, self.y)
                        end
                        if boardGrid[self.x - 1][self.y].isPoisoned and boardGrid[self.x - 1][self.y].isOnFire then
                            boardGrid[self.x - 1][self.y] = MagicForest(self.x - 1, self.y)
                        end
                    end
                
                    if self.x - 2 > 0 then
                        boardGrid[self.x - 1][self.y].drawLightning = true
                        boardGrid[self.x - 2][self.y].drawLightning = true
                        lightningTimer = love.timer.getTime()

                        if boardGrid[self.x - 1][self.y]:instanceOf(Lake) then
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x - 1 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                            end
                        else
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x - 1 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                            end
                        end
                        if boardGrid[self.x - 2][self.y]:instanceOf(Lake) then
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x - 2 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                            end
                        else
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x - 2 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                            end
                        end         
                        if boardGrid[self.x - 1][self.y].isPoisoned and boardGrid[self.x - 1][self.y].isFrozen then
                            boardGrid[self.x - 1][self.y] = MagicForest(self.x - 1, self.y)
                        end
                        if boardGrid[self.x - 2][self.y].isPoisoned and boardGrid[self.x - 2][self.y].isFrozen then
                            boardGrid[self.x - 2][self.y] = MagicForest(self.x - 2, self.y)
                        end
                        if boardGrid[self.x - 1][self.y].isPoisoned and boardGrid[self.x - 1][self.y].isOnFire then
                            boardGrid[self.x - 1][self.y] = MagicForest(self.x - 1, self.y)
                        end
                        if boardGrid[self.x - 2][self.y].isPoisoned and boardGrid[self.x - 2][self.y].isOnFire then
                            boardGrid[self.x - 2][self.y] = MagicForest(self.x - 2, self.y)
                        end
                    end
    
                    if self.x + 1 <= 10 then
                        boardGrid[self.x + 1][self.y].drawLightning = true
                        lightningTimer = love.timer.getTime()

                        if boardGrid[self.x + 1][self.y]:instanceOf(Lake) then
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x + 1 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                            end
                        else
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x + 1 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                            end
                        end
                        if boardGrid[self.x + 1][self.y].isPoisoned and boardGrid[self.x + 1][self.y].isFrozen then
                            boardGrid[self.x + 1][self.y] = MagicForest(self.x + 1, self.y)
                        end
                        if boardGrid[self.x + 1][self.y].isPoisoned and boardGrid[self.x + 1][self.y].isOnFire then
                            boardGrid[self.x + 1][self.y] = MagicForest(self.x + 1, self.y)
                        end
                    end
    
                    if self.x + 2 <= 10 then
                        boardGrid[self.x + 1][self.y].drawLightning = true
                        boardGrid[self.x + 2][self.y].drawLightning = true
                        lightningTimer = love.timer.getTime()

                        if boardGrid[self.x + 1][self.y]:instanceOf(Lake) then
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x + 1 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                            end
                        else
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x + 1 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                            end
                        end
                        if boardGrid[self.x + 2][self.y]:instanceOf(Lake) then
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x + 2 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 3
                            end
                        else
                            if inactivePlayer.characters[i].y == self.y and inactivePlayer.characters[i].x == self.x + 2 then
                                inactivePlayer.characters[i].baseHP = inactivePlayer.characters[i].baseHP - 1
                            end
                        end
                        if boardGrid[self.x + 1][self.y].isPoisoned and boardGrid[self.x + 1][self.y].isFrozen then
                            boardGrid[self.x + 1][self.y] = MagicForest(self.x + 1, self.y)
                        end
                        if boardGrid[self.x + 2][self.y].isPoisoned and boardGrid[self.x + 2][self.y].isFrozen then
                            boardGrid[self.x + 2][self.y] = MagicForest(self.x + 2, self.y)
                        end
                        if boardGrid[self.x + 1][self.y].isPoisoned and boardGrid[self.x + 1][self.y].isOnFire then
                            boardGrid[self.x + 1][self.y] = MagicForest(self.x + 1, self.y)
                        end
                        if boardGrid[self.x + 2][self.y].isPoisoned and boardGrid[self.x + 2][self.y].isOnFire then
                            boardGrid[self.x + 2][self.y] = MagicForest(self.x + 2, self.y)
                        end
                    end
                end
        self.isInSpellState = false
        end
        

        else self.isInSpellState = false                       
        end

        end


        self.actionPoints = self.actionPoints - 1
    
end

function ThunderShaman:drawSpellDamage(targetCell)
end


return ThunderShaman