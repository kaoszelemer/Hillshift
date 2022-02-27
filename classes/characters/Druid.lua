local Druid = Character:extend("Druid")
    function Druid:init(parentPlayer)
        Character.init(self, 45, 45, 3, 12, 5, love.graphics.newImage("/graphics/druid.png"),
                    love.graphics.newImage("/graphics/druidanim.png"),
                    love.graphics.newImage("/graphics/druidhover.png"), 
                    love.graphics.newImage("/graphics/druidsink.png"), 
                    love.graphics.newImage("/graphics/druidsinkhover.png"), 
                    parentPlayer, 1, 1,
                    "INFO ABOUT DRUID:\n\nThe Druid can make any tiles\nto forests. The thick and dark forests give plus defense.\nThe newly grown forests dont cancel modifiers.")
    end
    function Druid:update(dt)
        self.animation:update(dt)
        druidSpellAnimation:update(dt)
    end
 
    function Druid:drawSpellAnimation()

    
        for x = -1, 1 do
            for y = -1, 1 do
                if (x == 0 and y ~=0) or (x ~= 0 and y == 0) then

                    if self.drawSpell then
                        
                            if self.y + y > 0 and self.y + y <= 10 and self.x + x > 0 and self.y + y <= 10 then
                                animate(druidSpellAnimation, druidSpellAnimationImage, ((self.x + x) * tileW + offsetX) + tileW / 4, ((self.y + y) * tileH + offsetY) + tileH / 4, 1)
                            end
                       
                    end


                end
            end
        end
    
    
    end
 

function Druid:spell(targetCell)

        gameState:changeState(gameState.states.waitingState)
               
        if self.actionPoints ~= 0 then
            if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) or
            (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1)) or
            (targetCell.y == self.y and targetCell.x == self.x) then

                self.actionPoints = self.actionPoints - 1
                self.drawSpell = true
                self.timesHit = 0

                for x = -1, 1 do
                    for y = -1, 1 do
                        if (x == 0 and y ~=0) or (x ~= 0 and y == 0) then
                            table.insert(sequenceBufferTable, {
                                name = "druid spellhit",
                                duration = 1,
                                sequenceTime = love.timer.getTime(),
                                action = function()


                                    if boardGrid[self.x + x][self.y + y].isOccupied and boardGrid[self.x + x][self.y + y].occupiedBy.parentPlayer ~= self.parentPlayer and boardGrid[self.x + x][self.y + y]:instanceOf(Volcano) ~= true then
                                        boardGrid[self.x + x][self.y + y].occupiedBy:damage(boardGrid[self.x + x][self.y + y].occupiedBy, 6)
                                        self.timesHit = self.timesHit + 1
                                    end
                                end})
                            boardGrid[self.x + x][self.y + y] = Forest(self.x + x, self.y + y)
                            boardGrid[self.x + x][self.y + y].isInstanced = true
                            
                        end
                    end
                end

            end

            

                table.insert(sequenceBufferTable, {
                    name = "druidResetState",
                    duration = 2,
                    sequenceTime = love.timer.getTime(),
                    action = function()

                        if self.timesHit == 2 then
                            soundEngine:playSFX(doubledamageSound)
                            elseif self.timesHit == 3  then
                                soundEngine:playSFX(tripledamageSound)
                            elseif self.timesHit == 4 then
                                soundEngine:playSFX(quadripledamageSound)
                        end
                        

                        self.timesHit = 0

                        if self.actionPoints > 0  or self.stepPoints > 0 then
                            selectedChar = self
                            gameState:changeState(gameState.states.selectCharacterAction)
                        else
                    
                            selectedChar = self
                            gameState:changeState(gameState.states.selectCharacter)
                        end
                    
                     self.drawSpell = false
                                    Cell:resetParticleDrawing()
                
                    end})
            end

   
end
    
return Druid