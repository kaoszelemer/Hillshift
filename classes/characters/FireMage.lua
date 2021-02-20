local FireMage = Character:extend("FireMage")
    function FireMage:init(parentPlayer)
        Character.init(self, 12, 2, 3, 6, love.graphics.newImage("/graphics/firemage.png"), 
                    love.graphics.newImage("/graphics/druidanim.png"),
                    love.graphics.newImage("/graphics/firemagehover.png"), 
                    love.graphics.newImage("/graphics/firemagesink.png"), 
                    love.graphics.newImage("/graphics/firemagesinkhover.png"), 
                    parentPlayer, 1, 1, 0, 0, 0, false)
    end

    function FireMage:update(dt)
        self.animation:update(dt)
    end


function FireMage:spell(targetCell)

   


    if self.actionPoints ~= 0 then
    if  (targetCell.x == self.x and targetCell.y == self.y - 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then
        self.actionPoints = self.actionPoints - 1

        if self.x - 1 > 0 and self.y - 1 > 0 then
        
            table.insert(sequenceBufferTable, {
                name = "FireMageSpellTopLeftCell",
                duration = 0.2,
                sequenceTime = love.timer.getTime(),
                action = function()

                    boardGrid[self.x - 1][self.y - 1].isOnFire = true
                    boardGrid[self.x - 1][self.y - 1].fireTurn = turnCounter

                    if boardGrid[self.x - 1][self.y - 1]:instanceOf(Lake) then
                        boardGrid[self.x - 1][self.y - 1] = Field(self.x - 1, self.y - 1)
                        boardGrid[self.x - 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x - 1][self.y - 1]:instanceOf(Field) and boardGrid[self.x - 1][self.y - 1].isFrozen then 
                        boardGrid[self.x - 1][self.y - 1] = Lake(self.x - 1, self.y - 1)
                        boardGrid[self.x - 1][self.y - 1].isFrozen = false
                    end

                    if boardGrid[self.x - 1][self.y - 1]:instanceOf(Ice) then 
                        boardGrid[self.x - 1][self.y - 1] = Lake(self.x - 1, self.y - 1)
                        boardGrid[self.x - 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x - 1][self.y - 1]:instanceOf(Desert) then 
                        boardGrid[self.x - 1][self.y - 1] = GlassMount(self.x - 1, self.y - 1)
                        boardGrid[self.x - 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x - 1][self.y - 1].isFrozen then 
                        boardGrid[self.x - 1][self.y - 1].isFrozen = false
                        boardGrid[self.x - 1][self.y - 1].isOnFire = false 
                    end 
                end
            })

        end

        if self.x + 1 <= 10 and self.y - 1 > 0 then
            table.insert(sequenceBufferTable, {
                name = "FireMageSpellTopRightCell",
                duration = 0.4,
                sequenceTime = love.timer.getTime(),
                action = function()

                    boardGrid[self.x + 1][self.y - 1].isOnFire = true
                    boardGrid[self.x + 1][self.y - 1].fireTurn = turnCounter

                    if boardGrid[self.x + 1][self.y - 1]:instanceOf(Lake) then 
                        boardGrid[self.x + 1][self.y - 1] = Field(self.x + 1, self.y - 1)
                        boardGrid[self.x + 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x + 1][self.y - 1]:instanceOf(Field) and boardGrid[self.x + 1][self.y - 1].isFrozen then 
                        boardGrid[self.x + 1][self.y - 1] = Lake(self.x + 1, self.y - 1)
                        boardGrid[self.x + 1][self.y - 1].isFrozen = false
                    end

                    if boardGrid[self.x + 1][self.y - 1]:instanceOf(Ice) then 
                        boardGrid[self.x + 1][self.y - 1] = Lake(self.x + 1, self.y - 1)
                        boardGrid[self.x + 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x + 1][self.y - 1]:instanceOf(Desert) then 
                        boardGrid[self.x + 1][self.y - 1] = GlassMount(self.x + 1, self.y - 1)
                        boardGrid[self.x + 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x + 1][self.y - 1].isFrozen then 
                        boardGrid[self.x + 1][self.y - 1].isFrozen = false 
                        boardGrid[self.x + 1][self.y - 1].isOnFire = false 
                    end
                end
            })

        end
        
        gameState:changeState(gameState.states.selectCharacter)
        

    end

    if  (targetCell.x == self.x and targetCell.y == self.y + 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) then
        self.actionPoints = self.actionPoints - 1

        if self.x - 1 > 0 and self.y + 1 <= 10 then
            table.insert(sequenceBufferTable, {
                name = "FireMageSpellBottomLeftCell",
                duration = 0.2,
                sequenceTime = love.timer.getTime(),
                action = function()

                    boardGrid[self.x - 1][self.y + 1].isOnFire = true
                    boardGrid[self.x - 1][self.y + 1].fireTurn = turnCounter

                
                    if  boardGrid[self.x - 1][self.y + 1]:instanceOf(Lake) then
                        boardGrid[self.x - 1][self.y + 1] = Field(self.x - 1, self.y + 1)
                        boardGrid[self.x - 1][self.y + 1].isOnFire = false
                    end

                    if  boardGrid[self.x - 1][self.y + 1]:instanceOf(Field) and boardGrid[self.x - 1][self.y + 1].isFrozen then 
                        boardGrid[self.x - 1][self.y + 1] = Lake(self.x - 1, self.y + 1)
                        boardGrid[self.x - 1][self.y + 1].isFrozen = false
                    end


                    if  boardGrid[self.x - 1][self.y + 1]:instanceOf(Ice) then 
                        boardGrid[self.x - 1][self.y + 1] = Lake(self.x - 1, self.y + 1)
                        boardGrid[self.x - 1][self.y + 1].isOnFire = false
                    end

                    if  boardGrid[self.x - 1][self.y + 1]:instanceOf(Desert) then 
                        boardGrid[self.x - 1][self.y + 1] = GlassMount(self.x - 1, self.y + 1)
                        boardGrid[self.x - 1][self.y + 1].isOnFire = false
                    end

                    if  boardGrid[self.x - 1][self.y + 1].isFrozen then
                        boardGrid[self.x - 1][self.y + 1].isFrozen = false 
                        boardGrid[self.x - 1][self.y + 1].isOnFire = false 
                    end 
                end
            })
                    
        end


        if self.x + 1 <= 10 and self.y + 1 <= 10 then 
            table.insert(sequenceBufferTable, {
                name = "FireMageSpellBottomRightCell",
                duration = 0.4,
                sequenceTime = love.timer.getTime(),
                action = function()
                    boardGrid[self.x + 1][self.y + 1].isOnFire = true
                    boardGrid[self.x + 1][self.y + 1].fireTurn = turnCounter

                    
                    if boardGrid[self.x + 1][self.y + 1]:instanceOf(Lake) then 
                        boardGrid[self.x + 1][self.y + 1] = Field(self.x + 1, self.y + 1)
                        boardGrid[self.x + 1][self.y + 1].isOnFire = false
                    end
                    
                    if boardGrid[self.x + 1][self.y + 1]:instanceOf(Field) and boardGrid[self.x + 1][self.y + 1].isFrozen then 
                        boardGrid[self.x + 1][self.y + 1] = Lake(self.x + 1, self.y + 1)
                        boardGrid[self.x + 1][self.y + 1].isFrozen = false
                    end

                    if boardGrid[self.x + 1][self.y + 1]:instanceOf(Ice) then 
                        boardGrid[self.x + 1][self.y + 1] = Lake(self.x + 1, self.y + 1)
                        boardGrid[self.x + 1][self.y + 1].isOnFire = false
                    end

                    if boardGrid[self.x + 1][self.y + 1]:instanceOf(Desert) then 
                        boardGrid[self.x + 1][self.y + 1] = GlassMount(self.x + 1, self.y + 1)
                        boardGrid[self.x + 1][self.y + 1].isOnFire = false
                    end

                    if boardGrid[self.x + 1][self.y + 1].isFrozen then 
                        boardGrid[self.x + 1][self.y + 1].isFrozen = false 
                        boardGrid[self.x + 1][self.y + 1].isOnFire = false 
                    end
                end
            })
    
        end

        gameState:changeState(gameState.states.selectCharacter)        
        
    end
end

end
   
return FireMage