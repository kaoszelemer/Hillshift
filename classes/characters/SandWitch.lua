local SandWitch = Character:extend("SandWitch")
    function SandWitch:init(parentPlayer)
        Character.init(self, 11, 3, 1, 8, love.graphics.newImage("/graphics/hillshifthag.png"), 
                    love.graphics.newImage("/graphics/hillshifthaganim.png"), 
                    love.graphics.newImage("/graphics/hillshifthaghover.png"), 
                    love.graphics.newImage("/graphics/hillshifthagsink.png"), 
                    love.graphics.newImage("/graphics/hillshifthagsinkhover.png"), 
                    parentPlayer, 1, 1, 0, 0, 0, false)
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
        
            if targetCell.x == self.x + 1 or targetCell.x == self.x - 1 then
                self.actionPoints = self.actionPoints - 1
                

                if self.x - 1 > 0 then
                    self.drawSpellLeft = true
                    self.aSL = {x = self.x, y = self.y, nx = (self.x - 1), ny = (self.y)}
                    local nx = self.aSL.nx
                    local ny = self.aSL.ny
                    self.spellTime = love.timer.getTime()
                    flux.to(self.aSL, 0.5, {x = nx, y = ny}):ease("expoout")
                    table.insert(sequenceBufferTable, {
                        name = "SandWitchLeftCell",
                        duration = 0.2,
                        sequenceTime = love.timer.getTime(),
                        action = function()

                            if boardGrid[self.x - 1][self.y]:instanceOf(Mount) then 
                                boardGrid[self.x - 1][self.y] = Desert(self.x - 1, self.y)
                            end
                        end
                    })
        
                end
                
                if self.x + 1 <= 10 then
                    self.drawSpellRight = true
                    self.aSR = {x = self.x, y = self.y, nx = (self.x + 1), ny = (self.y)}
                    local nx = self.aSR.nx
                    local ny = self.aSR.ny
                    self.spellTime = love.timer.getTime()
                    flux.to(self.aSR, 0.5, {x = nx, y = ny}):ease("expoout")
                    table.insert(sequenceBufferTable, {
                        name = "SandWitchRightCell",
                        duration = 0.4,
                        sequenceTime = love.timer.getTime(),
                        action = function()

                            if boardGrid[self.x + 1][self.y]:instanceOf(Mount) then 
                                boardGrid[self.x + 1][self.y] = Desert(self.x + 1, self.y)
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

        end
    })

    end
    
return SandWitch