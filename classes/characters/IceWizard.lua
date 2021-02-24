local IceWizard = Character:extend("IceWizard")
    function IceWizard:init(parentPlayer)
        Character.init(self, 90, 5, 21, 3, love.graphics.newImage("/graphics/icewizard.png"), 
                    love.graphics.newImage("/graphics/icewizardanim.png"),
                    love.graphics.newImage("/graphics/icewizardhover.png"), 
                    love.graphics.newImage("/graphics/icewizardsink.png"), 
                    love.graphics.newImage("/graphics/icewizardsinkhover.png"), 
                    parentPlayer, 1, 1, 0, 0, 0, false)
    end

    function IceWizard:update(dt)
        self.animation:update(dt)
        iceWizardSpellAnimation:update(dt)
    end

    function IceWizard:drawSpellAnimation()

        local duration = 0.5
    
    
        if self.drawSpellTop then
          
         
            local ox = self.aST.x
            local oy = self.aST.y
            local nx = self.aST.nx
            local ny = self.aST.ny
            if love.timer.getTime() - self.spellTime <= duration then
                iceWizardSpellAnimation:draw(iceWizardSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
            end
        end
    
    
        if self.drawSpellTL then
            
    
        local ox = self.asTL.x
        local oy = self.asTL.y
        local nx = self.asTL.nx
        local ny = self.asTL.ny
            if love.timer.getTime() - self.spellTime <= duration then
                iceWizardSpellAnimation:draw(iceWizardSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
            end
        end
    
        if self.drawSpellTR then
            
            local ox = self.asTR.x
            local oy = self.asTR.y
            local nx = self.asTR.nx
            local ny = self.asTR.ny
                if love.timer.getTime() - self.spellTime <= duration then
                    iceWizardSpellAnimation:draw(iceWizardSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
                end
        end
    
       
    
    
        if self.drawSpellBottom then
    
           
            
    
            local ox = self.aSB.x
            local oy = self.aSB.y
            local nx = self.aSB.nx
            local ny = self.aSB.ny
            if love.timer.getTime() - self.spellTime <= duration then
                iceWizardSpellAnimation:draw(iceWizardSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
               
            end
        end
    
    
        if self.drawSpellBL then
    
            
    
            local ox = self.asBL.x
            local oy = self.asBL.y
            local nx = self.asBL.nx
            local ny = self.asBL.ny
                if love.timer.getTime() - self.spellTime <= duration then
                    iceWizardSpellAnimation:draw(iceWizardSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
                end
    
        end
    
        if self.drawSpellBR then
    
    
    
            local ox = self.asBR.x
            local oy = self.asBR.y
            local nx = self.asBR.nx
            local ny = self.asBR.ny
                if love.timer.getTime() - self.spellTime <= duration then
                    iceWizardSpellAnimation:draw(iceWizardSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
                end
    
                
        end
    
        
    
    end

function IceWizard:spell(targetCell)

    if self.actionPoints ~= 0 then
    if      (targetCell.x == self.x and targetCell.y == self.y - 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then
        self.actionPoints = self.actionPoints - 1

        if self.y - 1 > 0 then

            self.drawSpellTop = true
            self.aST = {x = self.x, y = self.y, nx = (self.x), ny = (self.y - 1)}
            local nx = self.aST.nx
            local ny = self.aST.ny
            self.spellTime = love.timer.getTime()
            flux.to(self.aST, 0.5, {x = nx, y = ny}):ease("expoout")

            table.insert(sequenceBufferTable, {
                name = "IceMageSpellTopCell",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()
          
                    boardGrid[self.x][self.y - 1].isFrozen = true
                    if boardGrid[self.x][self.y - 1]:instanceOf(Lake) then 
                        boardGrid[self.x][self.y - 1] = Ice(self.x, self.y - 1) 
                        boardGrid[self.x][self.y - 1].isInstanced = true
                    end
                    boardGrid[self.x][self.y - 1].freezeTurn = turnCounter
                    if boardGrid[self.x][self.y - 1].isOnFire then boardGrid[self.x][self.y - 1].isOnFire = false end
                end
            })

        end

        if self.x - 1 > 0 and self.y - 1 > 0 then

            self.drawSpellTL = true
            self.asTL = {x = self.x, y = self.y, nx = (self.x - 1), ny = (self.y - 1)}
            local nx = self.asTL.nx
            local ny = self.asTL.ny
            self.spellTime = love.timer.getTime()
            flux.to(self.asTL, 0.5, {x = nx, y = ny}):ease("expoout")

            table.insert(sequenceBufferTable, {
                name = "IceMageSpellTopLeftCell",
                duration = 0.2,
                sequenceTime = love.timer.getTime(),
                action = function()
                    boardGrid[self.x - 1][self.y - 1].isFrozen = true
                    if boardGrid[self.x - 1][self.y - 1]:instanceOf(Lake) then 
                        
                        boardGrid[self.x - 1][self.y - 1] = Ice(self.x - 1, self.y - 1) 
                        boardGrid[self.x - 1][self.y - 1].isInstanced = true
                    end
                    boardGrid[self.x - 1][self.y - 1].freezeTurn = turnCounter
                    if boardGrid[self.x - 1][self.y - 1].isOnFire then boardGrid[self.x - 1][self.y - 1].isOnFire = false end 
                end
            })

        end
         
        if self.x + 1 <= 10 and self.y - 1 > 0 then

            self.drawSpellTR = true
            self.asTR = {x = self.x, y = self.y, nx = (self.x + 1), ny = (self.y - 1)}
            local nx = self.asTR.nx
            local ny = self.asTR.ny
            self.spellTime = love.timer.getTime()
            flux.to(self.asTR, 0.5, {x = nx, y = ny}):ease("expoout")

            table.insert(sequenceBufferTable, {
                name = "IceMageSpellTopRightCell",
                duration = 0.3,
                sequenceTime = love.timer.getTime(),
                action = function()

                        boardGrid[self.x + 1][self.y - 1].isFrozen = true
                    if  boardGrid[self.x + 1][self.y - 1]:instanceOf(Lake) then 
                             boardGrid[self.x + 1][self.y - 1] = Ice(self.x + 1, self.y - 1) 
                             boardGrid[self.x + 1][self.y - 1].isInstanced = true
                    
                    end  
                        boardGrid[self.x + 1][self.y - 1].freezeTurn = turnCounter
                    if  boardGrid[self.x + 1][self.y - 1].isOnFire then boardGrid[self.x + 1][self.y - 1].isOnFire = false end
                end
            })

        end


        
        gameState:changeState(gameState.states.selectCharacter)
        end

    if      (targetCell.x == self.x and targetCell.y == self.y + 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y + 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y + 1) then
        self.actionPoints = self.actionPoints - 1

        if self.y + 1 <= 10 then

            self.drawSpellBottom = true
            self.aSB = {x = self.x, y = self.y, nx = (self.x), ny = (self.y + 1)}
            local nx = self.aSB.nx
            local ny = self.aSB.ny
            self.spellTime = love.timer.getTime()
            flux.to(self.aSB, 0.5, {x = nx, y = ny}):ease("expoout")

            table.insert(sequenceBufferTable, {
                name = "IceMageSpellBottomCell",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()
                    boardGrid[self.x][self.y + 1].isFrozen = true
                    if boardGrid[self.x][self.y + 1]:instanceOf(Lake) then
                         boardGrid[self.x][self.y + 1] = Ice(self.x, self.y + 1)
                         boardGrid[self.x][self.y + 1].isInstanced = true
                        end
                    boardGrid[self.x][self.y + 1].freezeTurn = turnCounter
                    if boardGrid[self.x][self.y + 1].isOnFire then boardGrid[self.x][self.y + 1].isOnFire = false end
                end
            })
        end

        if self.x - 1 > 0 and self.y + 1 <= 10 then

            self.drawSpellBL = true
            self.asBL = {x = self.x, y = self.y, nx = (self.x - 1), ny = (self.y + 1)}
            local nx = self.asBL.nx
            local ny = self.asBL.ny
            self.spellTime = love.timer.getTime()
            flux.to(self.asBL, 0.5, {x = nx, y = ny}):ease("expoout")

            table.insert(sequenceBufferTable, {
                name = "IceMageSpellBottomLeftCell",
                duration = 0.2,
                sequenceTime = love.timer.getTime(),
                action = function()
                    boardGrid[self.x - 1][self.y + 1].isFrozen = true
                    if boardGrid[self.x - 1][self.y + 1]:instanceOf(Lake) then
                         boardGrid[self.x - 1][self.y + 1] = Ice(self.x - 1, self.y + 1) 
                         boardGrid[self.x - 1][self.y + 1].isInstanced = true
                        end
                    boardGrid[self.x - 1][self.y + 1].freezeTurn = turnCounter
                    if boardGrid[self.x - 1][self.y + 1].isOnFire then boardGrid[self.x - 1][self.y + 1].isOnFire = false end 
                end
            })
        end
         
        if self.x + 1 <= 10 and self. y + 1 <= 10 then

            self.drawSpellBR = true
            self.asBR = {x = self.x, y = self.y, nx = (self.x + 1), ny = (self.y + 1)}
            local nx = self.asBR.nx
            local ny = self.asBR.ny
            self.spellTime = love.timer.getTime()
            flux.to(self.asBR, 0.5, {x = nx, y = ny}):ease("expoout")

            table.insert(sequenceBufferTable, {
                name = "IceMageSpellBottomLeftCell",
                duration = 0.3,
                sequenceTime = love.timer.getTime(),
                action = function()
                    boardGrid[self.x + 1][self.y + 1].isFrozen = true
                    if  boardGrid[self.x + 1][self.y + 1]:instanceOf(Lake) then
                         boardGrid[self.x + 1][self.y + 1] = Ice(self.x + 1, self.y + 1)
                         boardGrid[self.x + 1][self.y + 1].isInstanced = true
                    end  
                    boardGrid[self.x + 1][self.y + 1].freezeTurn = turnCounter
                    if  boardGrid[self.x + 1][self.y + 1].isOnFire then boardGrid[self.x + 1][self.y + 1].isOnFire = false end
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

            self.drawSpellTop = false
            self.drawSpellBottom = false

            self.drawSpellTL = false
            self.drawSpellTR = false
            
            self.drawSpellBR = false
            self.drawSpellBL = false
           
        end
    })
    Cell:resetParticleDrawing()
end


return IceWizard