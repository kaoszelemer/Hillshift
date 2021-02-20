local ThunderShaman = Character:extend("ThunderShaman")
function ThunderShaman:init(parentPlayer)
    Character.init(self, 10, 4, 2, 7, 
    love.graphics.newImage("/graphics/thundershamananim.png"),            
    love.graphics.newImage("/graphics/thundershamanhover.png"),
    love.graphics.newImage("/graphics/thundershamansink.png"), 
    love.graphics.newImage("/graphics/thundershamansinkhover.png"), 
    parentPlayer, 1, 1)
end

function ThunderShaman:update(dt)
    self.animation:update(dt)
end

function ThunderShaman:spell(targetCell)
    if self.actionPoints ~= 0 then
    
        if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y - 2)) or
            (targetCell.x == self.x and (targetCell.y == self.y + 1 or targetCell.y == self.y + 2)) then
                self.actionPoints = self.actionPoints - 1

                for oY = -2, 2 do
                    if oY ~= 0 then
                        if self.y + oY > 0 and self.y + oY <= 10 then
                            table.insert(sequenceBufferTable, {
                                name = "ThunderShamanSpellUpAndDown",
                                duration = 0.2,
                                sequenceTime = love.timer.getTime(),
                                action = function()
            
                                    boardGrid[self.x][self.y + oY].drawLightning = true
                                    lightningTimer = love.timer.getTime()
                                    if boardGrid[self.x][self.y + oY]:instanceOf(Lake) and boardGrid[self.x][self.y + oY].isOccupied then
                                        boardGrid[self.x][self.y + oY].occupiedBy.baseHP = boardGrid[self.x][self.y + oY].occupiedBy.baseHP - 3
                                    elseif boardGrid[self.x][self.y + oY].isOccupied then
                                        boardGrid[self.x][self.y + oY].occupiedBy.baseHP = boardGrid[self.x][self.y + oY].occupiedBy.baseHP - 1
                                    end
                                    
                                    if boardGrid[self.x][self.y + oY]:instanceOf(Mount) then
                                        boardGrid[self.x][self.y + oY].HP = boardGrid[self.x][self.y + oY].HP - 1
                                        if boardGrid[self.x][self.y + oY].HP <= 0 then boardGrid[self.x][self.y + oY] = Desert(self.x, self.y + oY) end
                                    end


            
                                    if boardGrid[self.x][self.y + oY].isPoisoned and boardGrid[self.x][self.y + oY].isFrozen then
                                        boardGrid[self.x][self.y + oY] = MagicForest(self.x, self.y + oY)
                                        magicForestTimer = turnCounter
                                    end
                                
                                    if boardGrid[self.x][self.y + oY].isPoisoned and boardGrid[self.x][self.y + oY].isOnFire then
                                        boardGrid[self.x][self.y + oY] = MagicForest(self.x, self.y + oY)
                                        magicForestTimer = turnCounter
                                    end
                                    if boardGrid[self.x][self.y + oY].isOccupied and boardGrid[self.x][self.y + oY].occupiedBy.baseHP <= 0 then boardGrid[self.x][self.y + oY].occupiedBy:kill() end
                                end
                            })
                        end
                    end
                end
                
        end
    -------------------------------------------------
    gameState:changeState(gameState.states.selectCharacter)
        end


        if  (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x - 2)) or
            (targetCell.y == self.y and (targetCell.x == self.x + 1 or targetCell.x == self.x + 2)) then
                self.actionPoints = self.actionPoints - 1
            
                
            for oX = -2, 2 do
                if oX ~= 0 then
                    if self.x + oX > 0 and self.x + oX <= 10 then
                        table.insert(sequenceBufferTable, {
                            name = "ThunderShamanSpellLeftAndRight",
                            duration = 0.2,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + oX][self.y].drawLightning = true
                                lightningTimer = love.timer.getTime()
                                if boardGrid[self.x + oX][self.y]:instanceOf(Lake) and boardGrid[self.x + oX][self.y].isOccupied then
                            
                                    boardGrid[self.x + oX][self.y].occupiedBy.baseHP = boardGrid[self.x + oX][self.y].occupiedBy.baseHP - 3
                                elseif boardGrid[self.x + oX][self.y].isOccupied then
                                    boardGrid[self.x + oX][self.y].occupiedBy.baseHP = boardGrid[self.x + oX][self.y].occupiedBy.baseHP - 1
                                end
                
                                if boardGrid[self.x + oX][self.y]:instanceOf(Mount) then
                                    boardGrid[self.x + oX][self.y].HP = boardGrid[self.x + oX][self.y].HP - 1
                                    if boardGrid[self.x + oX][self.y].HP <= 0 then boardGrid[self.x + oX][self.y] = Desert(self.x + oX, self.y) end
                                end

                                if boardGrid[self.x + oX][self.y].isPoisoned and boardGrid[self.x + oX][self.y].isFrozen then
                                    boardGrid[self.x + oX][self.y] = MagicForest(self.x + oX, self.y)
                                    magicForestTimer = turnCounter
                                end
                            
                                if boardGrid[self.x + oX][self.y].isPoisoned and boardGrid[self.x + oX][self.y].isOnFire then
                                    boardGrid[self.x + oX][self.y] = MagicForest(self.x + oX, self.y)
                                    magicForestTimer = turnCounter
                                end
                                if boardGrid[self.x + oX][self.y].isOccupied and boardGrid[self.x + oX][self.y].occupiedBy.baseHP <= 0 then boardGrid[self.x + oX][self.y].occupiedBy:kill() end
                            end
                        })
                    end
                end
            end
                
       

        
            gameState:changeState(gameState.states.selectCharacter)
        end

     


     
    
end

function ThunderShaman:drawSpellDamage(targetCell)
end


return ThunderShaman