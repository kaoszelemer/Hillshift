local Druid = Character:extend("Druid")
    function Druid:init(parentPlayer)
        Character.init(self, 45, 45, 3, 12, 5, love.graphics.newImage("/graphics/druid.png"),
                    love.graphics.newImage("/graphics/druidanim.png"),
                    love.graphics.newImage("/graphics/druidhover.png"), 
                    love.graphics.newImage("/graphics/druidsink.png"), 
                    love.graphics.newImage("/graphics/druidsinkhover.png"), 
                    parentPlayer, 1, 1)
    end
    function Druid:update(dt)
        self.animation:update(dt)
        druidSpellAnimation:update(dt)
    end
 
    function Druid:drawSpellAnimation()

        local duration = 0.5
    
    
        if self.drawSpellTop then
            if love.timer.getTime() - self.spellTime <= duration then
                if self.y - 1 > 0 then 
                    druidSpellAnimation:draw(druidSpellAnimationImage, ((self.x) * tileW + offsetX) + tileW / 4, ((self.y - 1)* tileH + offsetY) + tileH / 4)
                end
            end
        end
    
        if self.drawSpellLeft then
            if love.timer.getTime() - self.spellTime <= duration then
                    if  self.x - 1 > 0 then 
                            druidSpellAnimation:draw(druidSpellAnimationImage, ((self.x - 1) * tileW + offsetX) + tileW / 4, ((self.y)* tileH + offsetY) + tileH / 4)
                    end
            end
        end
    
    
    
        if self.drawSpellRight then
            if love.timer.getTime() - self.spellTime <= duration then
                    if self.x + 1 <= 10 then 
                            druidSpellAnimation:draw(druidSpellAnimationImage, ((self.x + 1) * tileW + offsetX) + tileW / 4, ((self.y)* tileH + offsetY) + tileH / 4)
                    end
            end
        end
    
        if self.drawSpellBottom then
            if love.timer.getTime() - self.spellTime <= duration then
                    if self.y + 1 <= 10 then 
                            druidSpellAnimation:draw(druidSpellAnimationImage, ((self.x) * tileW + offsetX) + tileW / 4, ((self.y + 1 )* tileH + offsetY) + tileH / 4)
                    end
            end  
        end
    
        
    
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
            self.actionPoints = self.actionPoints - 1


            if self.y - 1 > 0 then
                self.drawSpellTop = true
                self.spellTime = love.timer.getTime()
                if boardGrid[self.x][self.y - 1].isOnFire == true then  burnFirstCell = true end
                if boardGrid[self.x][self.y - 1].isPoisoned == true then poisonFirstCell = true end
                if boardGrid[self.x][self.y - 1].isFrozen == true then freezeFirstCell = true end
               
                table.insert(sequenceBufferTable, {
                    name = "DruidSpellTopCell",
                    duration = 0.1,
                    sequenceTime = love.timer.getTime(),
                    action = function()

                        boardGrid[self.x][self.y - 1] = Forest(self.x, self.y - 1)
                        boardGrid[self.x][self.y - 1].isInstanced = true
                      
            
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
                })
            end
            
            if self.y + 1 <= 10 then
                self.drawSpellBottom = true
                self.spellTime = love.timer.getTime()
                if boardGrid[self.x][self.y + 1].isOnFire == true then  burnSecondCell = true end
                if boardGrid[self.x][self.y + 1].isPoisoned == true then poisonSecondCell = true end
                if boardGrid[self.x][self.y + 1].isFrozen == true then freezeSecondCell = true end


                table.insert(sequenceBufferTable, {
                    name = "DruidSpellBottomCell",
                    duration = 0.2,
                    sequenceTime = love.timer.getTime(),
                    action = function()

                        boardGrid[self.x][self.y + 1] = Forest(self.x, self.y + 1)
                        boardGrid[self.x][self.y + 1].isInstanced = true
               
                    
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
            })
      
            end

            if self.x - 1 > 0 then
                self.drawSpellLeft = true
                self.spellTime = love.timer.getTime()
                if boardGrid[self.x - 1][self.y].isOnFire == true then  burnThirdCell = true end
                if boardGrid[self.x - 1][self.y].isPoisoned == true then poisonThirdCell = true end
                if boardGrid[self.x - 1][self.y].isFrozen == true then freezeThirdCell = true end
               
                table.insert(sequenceBufferTable, {
                    name = "DruidSpellLeftCell",
                    duration = 0.3,
                    sequenceTime = love.timer.getTime(),
                    action = function()

                        boardGrid[self.x - 1][self.y] = Forest(self.x - 1, self.y)
                        boardGrid[self.x - 1][self.y].isInstanced = true
               
            
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
            })
            end

            if self.x + 1 <= 10 then
                self.drawSpellRight = true
                self.spellTime = love.timer.getTime()
                if boardGrid[self.x + 1][self.y].isOnFire == true then  burnFourthCell = true end
                if boardGrid[self.x + 1][self.y].isPoisoned == true then poisonFourthCell = true end
                if boardGrid[self.x + 1][self.y].isFrozen == true then freezeFourthCell = true end

                table.insert(sequenceBufferTable, {
                    name = "DruidSpellRightCell",
                    duration = 0.4,
                    sequenceTime = love.timer.getTime(),
                    action = function()

                         boardGrid[self.x + 1][self.y] = Forest(self.x + 1, self.y)
                         boardGrid[self.x + 1][self.y].isInstanced = true

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
        })

        

    
            
            end
            gameState:changeState(gameState.states.selectCharacter)
            Cell:resetParticleDrawing()
        end
    end
    end
    
return Druid