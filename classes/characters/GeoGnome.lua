local GeoGnome = Character:extend("GeoGnome")

function GeoGnome:init(parentPlayer)
    Character.init(self, 55, 55, 4, 9, 1, love.graphics.newImage("/graphics/geognome.png"), 
                love.graphics.newImage("/graphics/geognomeanim.png"), 
                love.graphics.newImage("/graphics/geognomehover.png"), 
                love.graphics.newImage("/graphics/geognomesink.png"), 
                love.graphics.newImage("/graphics/geognomesinkhover.png"), 
                parentPlayer, 1, 1,
                "INFO ABOUT GEOGNOME:\n\nThe GeoGnome can make other\ntiles into mountains\nMountains give +AT\nMountains cancel all modifiers\n")
end

function GeoGnome:update(dt)
    self.animation:update(dt)
    geoGnomeSpellAnimation:update(dt)
end

function GeoGnome:drawSpellAnimation()

    local duration = 0.5


    if self.drawSpellAnim then
        if love.timer.getTime() - self.spellTime <= duration then

            for x = -1, 1 do
                for y = -1, 1 do
                    if x ~= 0 or y ~= 0 then
                        geoGnomeSpellAnimation:draw(geoGnomeSpellAnimationImage, ((self.x + x) * tileW + offsetX) + tileW / 4, ((self.y + y) * tileH + offsetY) + tileH / 4)
                    end
                end
            end

        end
    end

    

end


function GeoGnome:spell(targetCell)
        gameState:changeState(gameState.states.waitingState)

        if self.actionPoints ~= 0 then
       --[[      table.insert(sequenceBufferTable, {
                name = "GeoGnomeSpel damage",
                duration = 1,
                sequenceTime = love.timer.getTime(),
                action = function() ]]

            self.actionPoints = self.actionPoints - 1
            soundEngine:playSFX(mountSound)

            self.drawSpellAnim = true
            self.spellTime = love.timer.getTime()
           self.timesHit = 0


                    for x = -1, 1 do
                        for y = -1, 1 do
                            table.insert(sequenceBufferTable, {
                                name = "GeoGnomeSpel",
                                duration = 0.2,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                            if self.x + x <= 10 and self.x + x > 0 and self.y + y <= 10 and self.y + y > 0 then
                                if x ~= 0 or y ~= 0 then
                                    
                                    if boardGrid[self.x + x][self.y + y].isOccupied then
                                        boardGrid[self.x + x][self.y + y].occupiedBy:damage(boardGrid[self.x + x][self.y + y].occupiedBy, 5)
                                     --   print(boardGrid[self.x + x][self.y + y].isOccupied)
                                     self.timesHit = self.timesHit + 1
                                     
                                    end

                                    print(self.timesHit)
                                    
                                    table.insert(sequenceBufferTable, {
                                        name = "GeoGnomeSpel damage",
                                        duration = 1,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                            boardGrid[self.x + x][self.y + y] = Mount(self.x + x, self.y + y)
                                            boardGrid[self.x + x][self.y + y].isInstanced = true
                                        end})
                                        
                                   
                          
                                           
                                            
                                end  
                            end
                        end})
                
                        end
                    end
                



        end

     
        table.insert(sequenceBufferTable, {
            name = "geognomeResetState",
            duration = 1,
            sequenceTime = love.timer.getTime(),
            action = function()

                if self.timesHit == 2 then
                    soundEngine:playSFX(doubledamageSound)
                    elseif self.timesHit == 3  then
                        soundEngine:playSFX(tripledamageSound)
                    elseif self.timesHit == 4 then
                        soundEngine:playSFX(quadripledamageSound)
                    elseif self.timesHit == 5 then
                        soundEngine:playSFX(quintipledamageSound)
                    elseif self.timesHit == 6 then
                        soundEngine:playSFX(sextupledamageSound)
                    elseif self.timesHit == 7 then
                        soundEngine:playSFX(ultramegabrutalSound)
                end

                if self.actionPoints > 0  or self.stepPoints > 0 then
                    selectedChar = self
                    gameState:changeState(gameState.states.selectCharacterAction)
                else
             
                    selectedChar = self
                    gameState:changeState(gameState.states.selectCharacter)
                end
                self.timesHit = 0
                Cell:resetParticleDrawing()
             
        
            end})


end


   
return GeoGnome