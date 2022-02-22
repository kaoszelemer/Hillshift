local SandWitch = Character:extend("SandWitch")
    function SandWitch:init(parentPlayer)
        Character.init(self, 40, 40, 3, 12, 8, love.graphics.newImage("/graphics/hillshifthag.png"), 
                    love.graphics.newImage("/graphics/hillshifthaganim.png"), 
                    love.graphics.newImage("/graphics/hillshifthaghover.png"), 
                    love.graphics.newImage("/graphics/hillshifthagsink.png"), 
                    love.graphics.newImage("/graphics/hillshifthagsinkhover.png"), 
                    parentPlayer, 1, 1,
                    "INFO ABOUT SANDWITCH:\n\nThe Sandwitch throws sand\nsand creates Desert tiles\nand deserts gives -DE. Sand can make lakes\ninto swamps what gives -AT ")
    end

    function SandWitch:update(dt)
        self.animation:update(dt)
        sandWitchSpellAnimation:update(dt)
    end

function SandWitch:drawSpellAnimation()
 
    
    
    local duration = 0.5
        
        if self.drawSpellLeft then
            if love.timer.getTime() - self.spellTime <= duration then
                    if  self.x - 1 > 0 then 
                        local ox = self.aSL.x
                        local oy = self.aSL.y
                        local nx = self.aSL.nx
                        local ny = self.aSL.ny
                        sandWitchSpellAnimation:draw(sandWitchSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
                    end
            end
        end



        if self.drawSpellRight then
            if love.timer.getTime() - self.spellTime <= duration then
                        local ox = self.aSR.x
                        local oy = self.aSR.y
                        local nx = self.aSR.nx
                        local ny = self.aSR.ny
                    if self.x + 1 <= 10 then 
                        sandWitchSpellAnimation:draw(sandWitchSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
                    end
            end
        end
end


function SandWitch:spell(targetCell)

    if (targetCell.y == self.y + 1 or targetCell.y == self.y - 1) and targetCell.x == self.x then

        gameState:changeState(gameState.states.waitingState)
        
            if self.actionPoints ~= 0 then
            
                if targetCell.y == self.y + 1 or targetCell.y == self.y - 1 then
                    self.actionPoints = self.actionPoints - 1
                    

                    if self.y - 1 > 0 then
                        self.drawSpellLeft = true
                        self.aSL = {x = self.x, y = self.y, nx = (self.x), ny = (self.y - 1)}
                        local nx = self.aSL.nx
                        local ny = self.aSL.ny
                        self.spellTime = love.timer.getTime()
                        flux.to(self.aSL, 0.5, {x = nx, y = ny}):ease("expoout")
                        table.insert(sequenceBufferTable, {
                            name = "SandWitchLeftCell",
                            duration = 0.2,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                if boardGrid[self.x][self.y - 1]:instanceOf(Lake) then
                                    boardGrid[self.x][self.y - 1] = Swamp(self.x, self.y - 1)
                                        for index, currentChar in ipairs (activePlayer.characters) do
                                            if currentChar.x == self.x and currentChar.y == self.y + 1 then
                                                if currentChar.stepPoints == 1 then
                                                    currentChar.stepPoints = currentChar.stepPoints - 1
                                                elseif currentChar.stepPoints == 2 then
                                                    currentChar.stepPoints = currentChar.stepPoints - 2
                                                end
                                            end
                                        end
                                    
                                    
                                else
                                    boardGrid[self.x][self.y - 1] = Desert(self.x, self.y - 1)
                                    boardGrid[self.x][self.y - 1].isInstanced = true
                                    
                                        for index, currentChar in ipairs (activePlayer.characters) do
                                            if currentChar.x == self.x and currentChar.y == self.y - 1 then
                                                if currentChar.stepPoints ~= 0 then
                                                    currentChar.stepPoints = currentChar.stepPoints - 1
                                                end
                                            end
                                        end
                                    
                                end
                            end
                        })
            
                    end
                    
                    if self.y + 1 <= 10 then
                        self.drawSpellRight = true
                        self.aSR = {x = self.x, y = self.y, nx = (self.x), ny = (self.y + 1)}
                        local nx = self.aSR.nx
                        local ny = self.aSR.ny
                        self.spellTime = love.timer.getTime()
                        flux.to(self.aSR, 0.5, {x = nx, y = ny}):ease("expoout")
                        table.insert(sequenceBufferTable, {
                            name = "SandWitchRightCell",
                            duration = 0.4,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                if boardGrid[self.x][self.y + 1]:instanceOf(Lake) then
                                    boardGrid[self.x][self.y + 1] = Swamp(self.x, self.y + 1)
                                        for index, currentChar in ipairs (activePlayer.characters) do
                                            if currentChar.x == self.x and currentChar.y == self.y + 1 then
                                                if currentChar.stepPoints == 1 then
                                                    currentChar.stepPoints = currentChar.stepPoints - 1
                                                elseif currentChar.stepPoints == 2 then
                                                    currentChar.stepPoints = currentChar.stepPoints - 2
                                                end
                                            end
                                        end
                                    
                                else
                                    boardGrid[self.x][self.y + 1] = Desert(self.x, self.y + 1)
                                    boardGrid[self.x][self.y + 1].isInstanced = true
                                
                                    
                                        for index, currentChar in ipairs (activePlayer.characters) do
                                            if currentChar.x == self.x and currentChar.y == self.y + 1 then
                                                if currentChar.stepPoints ~= 0 then
                                                    currentChar.stepPoints = currentChar.stepPoints - 1
                                                end
                                            end
                                        end
                                
                                end
                            end
                        })

                    end
                    

                
            
            end
        end
        table.insert(sequenceBufferTable, {
            name = "resetSpellDrawing",
            duration = 2,
            sequenceTime = love.timer.getTime(),
            action = function()

                self.drawSpellLeft = false
                self.drawSpellRight = false
                Cell:resetParticleDrawing()
                if self.actionPoints > 0  or self.stepPoints > 0 then
                    selectedChar = self
                    gameState:changeState(gameState.states.selectCharacterAction)
                else
            
                    selectedChar = nil
                    gameState:changeState(gameState.states.selectCharacter)
                end
            
            end
        })
        
        soundEngine:playSFX(desertSound)

    

        end
    end
    
return SandWitch