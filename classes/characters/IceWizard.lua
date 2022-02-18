local IceWizard = Character:extend("IceWizard")
    function IceWizard:init(parentPlayer)
        Character.init(self, 45, 45, 3, 10, 3, love.graphics.newImage("/graphics/icewizard.png"), 
                    love.graphics.newImage("/graphics/icewizardanim.png"),
                    love.graphics.newImage("/graphics/icewizardhover.png"), 
                    love.graphics.newImage("/graphics/icewizardsink.png"), 
                    love.graphics.newImage("/graphics/icewizardsinkhover.png"), 
                    parentPlayer, 1, 1,
                    "INFO ABOUT ICEWIZARD:\n\nThe Icewizard can freeze\npeople, lakes. Frozen people can't move\nnext turn, Frozen lakes can be\niceskated, Ice cancels fire")
    end

    function IceWizard:update(dt)
        self.animation:update(dt)
        iceWizardSpellAnimation:update(dt)
    end



function IceWizard:spell(targetCell)
    gameState:changeState(gameState.states.waitingState)
    if self.actionPoints ~= 0 then
  
        self.actionPoints = self.actionPoints - 1
    
        local y

         
                if targetCell.y > self.y then
                    y = 1
                    
                elseif targetCell.y < self.y then
                  
                    y = -1
                  
                end
            
                    
                    if self.x - 1 > 0 and self.x + 1 <= 10 and self.y + y > 0 and self.y + y <= 10 then
                        
                  
                               
                                    if y == 1 then
                                   
                                        animate(iceWizardSpellAnimation, iceWizardSpellAnimationImage, (self.x + 2) * tileW + offsetX, (self.y + 2) * tileH + offsetY, 1.2, math.rad(180)) 
                                      
                                    end
                                    if y == -1 then
                                    
                                        animate(iceWizardSpellAnimation, iceWizardSpellAnimationImage, (self.x - 1) * tileW + offsetX, (self.y -1) * tileH + offsetY, 1.2)  
                                    end
                                    


                                    for x = -1, 1 do
                                        Freeze:apply(self.x + x, self.y + y)
                                    end

                    end
        
    end
    table.insert(sequenceBufferTable, {
        name = "resetSpellDrawing",
        duration = 2,
        sequenceTime = love.timer.getTime(),
        action = function()

            self.drawSpellTop = false
            self.drawSpellBottom = false
        
            selectedChar = self
            gameState:changeState(gameState.states.selectCharacter)
    
            Cell:resetParticleDrawing()
        end
    })
    
    soundEngine:playSFX(iceSound)
 

end


return IceWizard