local FireMage = Character:extend("FireMage")
    function FireMage:init(parentPlayer)
        Character.init(self, 50, 50, 3, 10, 6, love.graphics.newImage("/graphics/firemage.png"), 
                    love.graphics.newImage("/graphics/firemageanim.png"),
                    love.graphics.newImage("/graphics/firemagehover.png"), 
                    love.graphics.newImage("/graphics/firemagesink.png"), 
                    love.graphics.newImage("/graphics/firemagesinkhover.png"), 
                    parentPlayer, 1, 1,
                    "INFO ABOUT FIREMAGE:\n\nThe FireMage can shoot fireballs.\nFire burns down forests,\nevaporates water, melts ice and sand. \nAlso people tend to not like \nwhen they're on fire.")
    end

function FireMage:update(dt)
    self.animation:update(dt)
    fireSpellAnimation:update(dt)

end

 


function FireMage:spell(targetCell)

    if targetCell.y ~= self.y and (targetCell.x ~= self.x - 1 or targetCell.x ~= self.x + 1) then
        self.timesHit = 0

            gameState:changeState(gameState.states.waitingState)

            local y
            local spellDamage = 5

            if self.actionPoints ~= 0 then
                self.actionPoints = self.actionPoints - 1
                
                for x = -1, 1 do
                    if x ~= 0 then

                        if self.y < targetCell.y then

                            self.topSpell = true
                            y = 1
                            

                                
                                        table.insert(sequenceBufferTable, {
                                            name = "fireballanim2",
                                            duration = 0.5,
                                            sequenceTime = love.timer.getTime(),
                                            action = function()
                    
                                                local flx = {x = (self.x * tileW + offsetX), y = (self.y * tileH + offsetY), nx = ((self.x + x) * tileW + offsetX) + tileW / 2, ny = ((self.y + y) * tileH + offsetY) + tileH / 2, ea = "expoout"}
                                                soundEngine:playSFX(fireBallSound)
                                            
                                                animate(fireSpellAnimation, fireSpellAnimationImage, flx.x + tileW / 2, flx.y + tileH / 2, 0.3, math.rad(315), flx )
                                            end})

                                

                            
                        

                        
                                    table.insert(sequenceBufferTable, {
                                        name = "fireballanim2",
                                        duration = 0.5,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                            local flx = {x = (self.x * tileW + offsetX), y = (self.y * tileH + offsetY), nx = ((self.x + x) * tileW + offsetX) + tileW / 2, ny = ((self.y + y) * tileH + offsetY) + tileH / 2, ea = "expoout"}
                                        -- soundEngine:playSFX(fireBallSound)
                                            animate(fireSpellAnimation, fireSpellAnimationImage, flx.x, flx.y, 0.3, math.rad(45), flx )
                                        end})

                        

                        end


                        if self.y > targetCell.y then

                            y = -1
                            self.bottomSpell = true

                            local flx = {x = (self.x * tileW + offsetX), y = (self.y * tileH + offsetY), nx = ((self.x + x) * tileW + offsetX) + tileW / 2, ny = ((self.y + y) * tileH + offsetY) + tileH / 2, ea = "expoout"}
                            

                        
                                table.insert(sequenceBufferTable, {
                                    name = "fireballanim2",
                                    duration = 0.5,
                                    sequenceTime = love.timer.getTime(),
                                    action = function()
                                --     soundEngine:playSFX(fireBallSound)
                                        animate(fireSpellAnimation, fireSpellAnimationImage, flx.x + tileW / 2, flx.y + tileH / 2, 0.5, math.rad(225), flx )

                                    end})
                        

                    

                                table.insert(sequenceBufferTable, {
                                    name = "fireballanim2-botttom",
                                    duration = 0.3,
                                    sequenceTime = love.timer.getTime(),
                                    action = function()
                                        soundEngine:playSFX(fireBallSound)
                                        local flx = {x = (self.x * tileW + offsetX), y = (self.y * tileH + offsetY), nx = ((self.x + x) * tileW + offsetX) + tileW / 2, ny = ((self.y + y) * tileH + offsetY) + tileH / 2, ea = "expoout"}
                                        animate(fireSpellAnimation, fireSpellAnimationImage, flx.x, flx.y, 0.5, math.rad(135), flx )

                                    end})

                        

                        end

            
            
                        if self.topSpell  then

                            if self.x + x > 0 and self.x + x <= 10 and self.y + y <= 10 then
                            
                                Burn:apply(self.x + x, self.y + y)
                                if boardGrid[self.x + x][self.y + x].isOccupied then
                                    self.timesHit = self.timesHit + 2
                                end
                                    
                            end

                        end

                        if self.bottomSpell then
                    
                            if self.x + x > 0 and self.x + x <= 10 and self.y + y > 0 then

                                Burn:apply(self.x + x, self.y + y)
                                if boardGrid[self.x + x][self.y + x].isOccupied then
                                    self.timesHit = self.timesHit + 2
                                end
                                
                            end

                        end


                        table.insert(sequenceBufferTable, {
                            name = "firemageResetState",
                            duration = 1.7,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                               
                                if self.timesHit == 2 then
                                    soundEngine:playSFX(doubledamageSound)
                                end
                                self.topSpell = false
                                self.bottomSpell = false
                                if self.actionPoints > 0  or self.stepPoints > 0 then
                                    selectedChar = self
                                    gameState:changeState(gameState.states.selectCharacterAction)
                                else
                            
                                    selectedChar = self
                                    gameState:changeState(gameState.states.selectCharacter)
                                end
                        
                                Cell:resetParticleDrawing()
                            
                        
                            end})



                    end
                    
                end






        
        end


    end

end
   
return FireMage