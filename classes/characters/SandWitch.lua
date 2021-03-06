local SandWitch = Character:extend("SandWitch")
    function SandWitch:init(parentPlayer)
        Character.init(self, 40, 40, 3, 12, 8, love.graphics.newImage("/graphics/hillshifthag.png"), 
                    love.graphics.newImage("/graphics/hillshifthaganim.png"), 
                    love.graphics.newImage("/graphics/hillshifthaghover.png"), 
                    love.graphics.newImage("/graphics/hillshifthagsink.png"), 
                    love.graphics.newImage("/graphics/hillshifthagsinkhover.png"), 
                    parentPlayer, 1, 1)
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
                            else
                                boardGrid[self.x][self.y - 1] = Desert(self.x, self.y - 1)
                                boardGrid[self.x][self.y - 1].isInstanced = true
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
                            else
                                boardGrid[self.x][self.y + 1] = Desert(self.x, self.y + 1)
                                boardGrid[self.x][self.y + 1].isInstanced = true
                            end
                        end
                    })

                end
                

            gameState:changeState(gameState.states.selectCharacter)

        end
    end
    table.insert(sequenceBufferTable, {
        name = "resetSpellDrawing",
        duration = 1,
        sequenceTime = love.timer.getTime(),
        action = function()

            self.drawSpellLeft = false
            self.drawSpellRight = false
            Cell:resetParticleDrawing()
        end
    })

    end
    
return SandWitch