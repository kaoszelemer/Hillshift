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



function FireMage:drawSpellAnimation()

    local duration = 0.5

    if self.drawSpellTL then
    local ox = self.ftTL.x
    local oy = self.ftTL.y
    local nx = self.ftTL.nx
    local ny = self.ftTL.ny
        if love.timer.getTime() - self.spellTime <= duration then
            fireSpellAnimation:draw(fireSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
        end
    end

    if self.drawSpellTR then
        local ox = self.ftTR.x
        local oy = self.ftTR.y
        local nx = self.ftTR.nx
        local ny = self.ftTR.ny
            if love.timer.getTime() - self.spellTime <= duration then
                fireSpellAnimation:draw(fireSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
            end
    end

    if self.drawSpellBL then
        local ox = self.ftBL.x
        local oy = self.ftBL.y
        local nx = self.ftBL.nx
        local ny = self.ftBL.ny
            if love.timer.getTime() - self.spellTime <= duration then
                fireSpellAnimation:draw(fireSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
            end
    end

    if self.drawSpellBR then
        local ox = self.ftBR.x
        local oy = self.ftBR.y
        local nx = self.ftBR.nx
        local ny = self.ftBR.ny
            if love.timer.getTime() - self.spellTime <= duration then
                fireSpellAnimation:draw(fireSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
            end
    end

end


function FireMage:spell(targetCell)


    

    gameState:changeState(gameState.states.waitingState)


    local spellDamage = 5

    if self.actionPoints ~= 0 then
     
        if  (targetCell.x == self.x and targetCell.y == self.y - 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then
            self.actionPoints = self.actionPoints - 1

            if self.x - 1 > 0 and self.y - 1 > 0 then

                    self.drawSpellTL = true
                    self.ftTL = {x = self.x, y = self.y, nx = (self.x - 1), ny = (self.y - 1)}
                    local nx = self.ftTL.nx
                    local ny = self.ftTL.ny
                    self.spellTime = love.timer.getTime()
                    flux.to(self.ftTL, 0.5, {x = nx, y = ny}):ease("expoout")

                    soundEngine:playSFX(fireBallSound)
                    
                table.insert(sequenceBufferTable, {
                    name = "FireMageSpellTopLeftCell",
                    duration = 0.2,
                    sequenceTime = love.timer.getTime(),
                    action = function()

                        Burn:apply(self.x - 1, self.y - 1)
             
                        self.drawSpellTL = false
                    end
                })
                
            end

            if self.x + 1 <= 10 and self.y - 1 > 0 then

                self.drawSpellTR = true
                self.ftTR = {x = self.x, y = self.y, nx = (self.x + 1), ny = (self.y - 1)}
                local nx = self.ftTR.nx
                local ny = self.ftTR.ny
                self.spellTime = love.timer.getTime()
                flux.to(self.ftTR, 0.5, {x = nx, y = ny}):ease("expoout")

            

                table.insert(sequenceBufferTable, {
                    name = "FireMageSpellTopRightCell",
                    duration = 0.4,
                    sequenceTime = love.timer.getTime(),
                    action = function()

                        Burn:apply(self.x + 1, self.y - 1)
                        self.drawSpellTR = false
                       
                    end})

            end
            
            gameState:changeState(gameState.states.selectCharacter)
            

        end

        if  (targetCell.x == self.x and targetCell.y == self.y + 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) then
            self.actionPoints = self.actionPoints - 1

            if self.x - 1 > 0 and self.y + 1 <= 10 then

                self.drawSpellBL = true
                self.ftBL = {x = self.x, y = self.y, nx = (self.x - 1), ny = (self.y + 1)}
                local nx = self.ftBL.nx
                local ny = self.ftBL.ny
                self.spellTime = love.timer.getTime()
                flux.to(self.ftBL, 0.5, {x = nx, y = ny}):ease("expoout")
                soundEngine:playSFX(fireBallSound)
                table.insert(sequenceBufferTable, {
                    name = "FireMageSpellBottomLeftCell",
                    duration = 0.2,
                    sequenceTime = love.timer.getTime(),
                    action = function()

                        Burn:apply(self.x - 1, self.y + 1)
                        self.drawSpellBL = false
                    end
                })
                        
            end


            if self.x + 1 <= 10 and self.y + 1 <= 10 then

                self.drawSpellBR = true
                self.ftBR = {x = self.x, y = self.y, nx = (self.x + 1), ny = (self.y + 1)}
                local nx = self.ftBR.nx
                local ny = self.ftBR.ny
                self.spellTime = love.timer.getTime()
                flux.to(self.ftBR, 0.5, {x = nx, y = ny}):ease("expoout")

                soundEngine:playSFX(fireBallSound)

                table.insert(sequenceBufferTable, {
                    name = "FireMageSpellBottomRightCell",
                    duration = 0.4,
                    sequenceTime = love.timer.getTime(),
                    action = function()
                        Burn:apply(self.x + 1, self.y + 1)
                        self.drawSpellBR = false
                    end
                })
        
            end

            table.insert(sequenceBufferTable, {
                name = "resetdamagedraw",
                duration = 1,
                sequenceTime = love.timer.getTime(),
                action = function()
                    for x = 1, 10 do
                        for y = 1, 10 do
                            boardGrid[x][y].drawDamageOnBoard = false
                        end
                    end

                end
            })
            table.insert(sequenceBufferTable, {
                name = "firemageResetState",
                duration = 2,
                sequenceTime = love.timer.getTime(),
                action = function()

                    selectedChar = self
                 gameState:changeState(gameState.states.selectCharacter)
               
                    Cell:resetParticleDrawing()
                
            
                end})
            end
   
end




end
   
return FireMage