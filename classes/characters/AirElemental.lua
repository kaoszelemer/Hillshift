local AirElemental = Character:extend("AirElemental")
function AirElemental:init(parentPlayer)
    Character.init(self, 50, 50, 3, 10, 4, love.graphics.newImage("/graphics/airelemental.png"), 
                love.graphics.newImage("/graphics/airelementalanim.png"), 
                love.graphics.newImage("/graphics/airelementalhover.png"), 
                love.graphics.newImage("/graphics/airelementalsink.png"),
                love.graphics.newImage("/graphics/airelementalsinkhover.png"),
                parentPlayer, 1, 1, 
                "INFO ABOUT AIRELEMENTAL:\n\nThe AirElemental can blow people,\nfire and sand what spreads randomly,\nbut people always move\nwhen blown.")
end


function AirElemental:update(dt)
    self.animation:update(dt)
    airElementalSpellAnimation:update(dt)
end

function AirElemental:drawSpellAnimation()

    local duration = 0.5


    if self.drawSpellTop then
      
     
        local ox = self.aST.x
        local oy = self.aST.y
        local nx = self.aST.nx
        local ny = self.aST.ny
        if love.timer.getTime() - self.spellTime <= duration then
            airElementalSpellAnimation:draw(airElementalSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
        end
    end


    if self.drawSpellTL then
        

    local ox = self.asTL.x
    local oy = self.asTL.y
    local nx = self.asTL.nx
    local ny = self.asTL.ny
        if love.timer.getTime() - self.spellTime <= duration then
            airElementalSpellAnimation:draw(airElementalSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
        end
    end

    if self.drawSpellTR then
        
        local ox = self.asTR.x
        local oy = self.asTR.y
        local nx = self.asTR.nx
        local ny = self.asTR.ny
            if love.timer.getTime() - self.spellTime <= duration then
                airElementalSpellAnimation:draw(airElementalSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
            end
    end

   


    if self.drawSpellBottom then

       
        

        local ox = self.aSB.x
        local oy = self.aSB.y
        local nx = self.aSB.nx
        local ny = self.aSB.ny
        if love.timer.getTime() - self.spellTime <= duration then
            airElementalSpellAnimation:draw(airElementalSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
           
        end
    end


    if self.drawSpellBL then

        

        local ox = self.asBL.x
        local oy = self.asBL.y
        local nx = self.asBL.nx
        local ny = self.asBL.ny
            if love.timer.getTime() - self.spellTime <= duration then
                airElementalSpellAnimation:draw(airElementalSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
            end

    end

    if self.drawSpellBR then



        local ox = self.asBR.x
        local oy = self.asBR.y
        local nx = self.asBR.nx
        local ny = self.asBR.ny
            if love.timer.getTime() - self.spellTime <= duration then
                airElementalSpellAnimation:draw(airElementalSpellAnimationImage, (ox * tileW + offsetX) + tileW / 4, (oy * tileH + offsetY) + tileH / 4)
            end

            
    end

    

end


function AirElemental:blowCharacter(targetCell, tcx, tcy, ox, oy)
    table.insert(sequenceBufferTable, {
        name = "AirElementalblowCharacter",
        duration = 0.3,
        sequenceTime = love.timer.getTime(),
        action = function()

            local spreadX = 0
            local spreadY = 0
                                            
            if self.x + tcx > 0 and self.x + tcx <= 10 and self.y + tcy > 0 and self.y + tcy <= 10 and boardGrid[self.x + tcx][self.y + tcy].isOccupied then

                if self.x == boardGrid[self.x + tcx][self.y + tcy].occupiedBy.x then
                    spreadX = 0
                end

                if self.x > boardGrid[self.x + tcx][self.y + tcy].occupiedBy.x then
                    spreadX = -2
                end

                if self.x < boardGrid[self.x + tcx][self.y + tcy].occupiedBy.x then
                    spreadX = 2
                end

                if self.y > boardGrid[self.x + tcx][self.y + tcy].occupiedBy.y then
                    spreadY = -2
                end

                if self.y < boardGrid[self.x + tcx][self.y + tcy].occupiedBy.y then
                    spreadY = 2
                end

                if (self.x + spreadX <= 10 and self.x + spreadX > 0) and (self.y + spreadY <= 10 and self.y + spreadY > 0) then
            
                    if not boardGrid[self.x +spreadX][self.y + spreadY].isOccupied then
                        boardGrid[self.x + tcx][self.y + tcy].occupiedBy.stepPoints = boardGrid[self.x + tcx][self.y + tcy].occupiedBy.stepPoints + 1
                        boardGrid[self.x + tcx][self.y + tcy].occupiedBy:move(self.x + spreadX, self.y + spreadY, self.x + tcx, self.y + tcy)
                    end
                end
            
            end
     end
    })

end

function AirElemental:clearPoison(targetCell, tcx, tcy)
    table.insert(sequenceBufferTable, {
        name = "AirElementalclearPoison",
        duration = 0.1,
        sequenceTime = love.timer.getTime(),
        action = function()
            if (self.x + tcx <= 10 and self.x + tcx > 0) and (self.y + tcy <= 10 and self.y + tcy > 0) then
                if boardGrid[self.x + tcx][self.y + tcy].isPoisoned then boardGrid[self.x + tcx][self.y + tcy].isPoisoned = false end
            end
        end
    })

end

function AirElemental:blowFire(targetCell, tcx, tcy)

print(chanceOfBurning)
    table.insert(sequenceBufferTable, {
        name = "AirElementalblowFire",
        duration = 0.2,
        sequenceTime = love.timer.getTime(),
        action = function()

          

            local fx = 0
            local fy = 0
            
                if (self.x + fx + tcx <= 10 and self.x + fx + tcx > 0) and (self.y + fy + tcy <= 10 and self.y + fy + tcy > 0) then

                    if self.x == boardGrid[self.x + tcx][self.y + tcy].x then
                        fx = 0
                    end

                    if self.x > boardGrid[self.x + tcx][self.y + tcy].x then
                        fx = -1
                    end

                    if self.x < boardGrid[self.x + tcx][self.y + tcy].x then
                        fx = 1
                    end

                    if self.y > boardGrid[self.x + tcx][self.y + tcy].y then
                        fy = -1
                    end

                    if self.y < boardGrid[self.x + tcx][self.y + tcy].y then
                        fy = 1
                    end
                end
        

            if (self.x + fx + tcx <= 10 and self.x + fx + tcx > 0) and (self.y + fy + tcy <= 10 and self.y + fy + tcy > 0) then


                if boardGrid[self.x + tcx][self.y + tcy].isOnFire then 
                    
                    if not boardGrid[self.x + fx + tcx][self.y + fy + tcy]:instanceOf(Lake) then
                        boardGrid[self.x + fx + tcx][self.y + fy + tcy].isOnFire = true
                        boardGrid[self.x + fx + tcx][self.y + fy + tcy].fireTurn = turnCounter
                    end
                
                    if boardGrid[self.x + fx + tcx][self.y + fy + tcy]:instanceOf(Desert) then
                        boardGrid[self.x + fx + tcx][self.y + fy + tcy] = GlassMount(self.x + fx + tcx, self.y + fy + tcy) 
                        boardGrid[self.x + fx + tcx][self.y + fy + tcy].isInstanced = true
                    end

                    if boardGrid[self.x + fx + tcx][self.y + fy + tcy]:instanceOf(Lake) then
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreSteaming",
                            duration = 0.01,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + fx + tcx][self.y + fy + tcy].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreLakes",
                            duration = 0.6,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + fx + tcx][self.y + fy + tcy] = Field(self.x + fx + tcx, self.y + fy + tcy) 
                            end
                        }) 
                    end
                    if boardGrid[self.x + fx + tcx][self.y + fy + tcy]:instanceOf(Ice) then
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreSteaming",
                            duration = 0.01,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + fx + tcx][self.y + fy + tcy].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreSteaming",
                            duration = 0.6,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + fx + tcx][self.y + fy + tcy] = Lake(self.x + fx + tcx, self.y + fy + tcy) 
                            end
                        }) 
                        boardGrid[self.x + fx + tcx][self.y + fy + tcy].isInstanced = true
                    end
                end

            end
        end
    })

end

function AirElemental:blowSand(targetCell, tcx, tcy)
    table.insert(sequenceBufferTable, {
        name = "AirElementalblowSand",
        duration = 0.2,
        sequenceTime = love.timer.getTime(),
        action = function()
            local spreadX = 0
            local spreadY = 0

            if (self.x + spreadY + tcx <= 10 and self.x + spreadX + tcx > 0) and (self.y + spreadY + tcy <= 10 and self.y + spreadY + tcy > 0) then


                if self.x == boardGrid[self.x + tcx][self.y + tcy].x then
                    spreadX = 0
                end

                if self.x > boardGrid[self.x + tcx][self.y + tcy].x then
                    spreadX = -1
                end

                if self.x < boardGrid[self.x + tcx][self.y + tcy].x then
                    spreadX = 1
                end

                if self.y > boardGrid[self.x + tcx][self.y + tcy].y then
                    spreadY = -1
                end

                if self.y < boardGrid[self.x + tcx][self.y + tcy].y then
                    spreadY = 1
                end


                if boardGrid[self.x + tcx][self.y + tcy]:instanceOf(Desert) then 

                    if boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy]:instanceOf(Lake) then
                        boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy] = Swamp(self.x + spreadX + tcx, self.y + spreadY + tcy) 
                    end

                    if not boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy].isOnFire and not boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy]:instanceOf(Swamp) then 
                        boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy] = Desert(self.x + spreadX + tcx, self.y + spreadY + tcy)
                        boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy].isInstanced = true
                    end

                    if boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy].isOnFire then
                        boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy] = GlassMount(self.x + spreadX + tcx, self.y + spreadY + tcy) 
                        boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy].isInstanced = true
                    end

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
                    Cell:resetParticleDrawing()
                end
            })

        end

    })
end


function AirElemental:spell(targetCell)

    local spreadX = 0
    local spreadY = 0
    local chanceOfBurning = love.math.random()
 
    if self.actionPoints ~= 0 then

        for tcx = -1, 1 do
           
            
                if tcy ~= 0 then
                 
                    
                    --if (targetCell.x == self.x and targetCell.y == self.y + tcy) or (targetCell.x == self.x + tcx and targetCell.y == self.y + tcy) then
                    if (self.x + tcx <= 10 or self.x + tcx > 0) and (self.y + 1 <= 10 or self.y - 1 > 0) then
                        tcy = -1
                        if targetCell.y < self.y then  
                            
                            self:blowCharacter(targetCell, tcx, tcy)
                            print(chanceOfBurning)
                            self:blowFire(targetCell, tcx, tcy, etc)
                            self:blowSand(targetCell, tcx, tcy)
                            self:clearPoison(targetCell, tcx, tcy)
                        
                            if tcx == 0 and tcy < 0 then
                                self.drawSpellTop = true
                                self.aST = {x = self.x, y = self.y, nx = (self.x), ny = (self.y - 1)}
                                local nx = self.aST.nx
                                local ny = self.aST.ny
                                self.spellTime = love.timer.getTime()
                                flux.to(self.aST, 0.5, {x = nx, y = ny}):ease("expoout")
                            elseif tcx == -1 and tcy < 0 then
                                self.drawSpellTL = true
                                self.asTL = {x = self.x, y = self.y, nx = (self.x - 1), ny = (self.y - 1)}
                                local nx = self.asTL.nx
                                local ny = self.asTL.ny
                                self.spellTime = love.timer.getTime()
                                flux.to(self.asTL, 0.5, {x = nx, y = ny}):ease("expoout")
                            elseif tcx == 1 and tcy < 0 then
                                self.drawSpellTR = true
                                self.asTR = {x = self.x, y = self.y, nx = (self.x + 1), ny = (self.y - 1)}
                                local nx = self.asTR.nx
                                local ny = self.asTR.ny
                                self.spellTime = love.timer.getTime()
                                flux.to(self.asTR, 0.5, {x = nx, y = ny}):ease("expoout")
                            end
                        end
                            
            
                      
                        if targetCell.y > self.y then
                         tcy = 1
                            self:blowCharacter(targetCell, tcx, tcy)
                            self:blowFire(targetCell, tcx, tcy)
                            self:blowSand(targetCell, tcx, tcy)
                            self:clearPoison(targetCell, tcx, tcy)

                            if (self.x + tcx <= 10 or self.x + tcx > 0) and (self.y + tcy <= 10 or self.y + tcy > 0) then 
                                if tcx == 0 and tcy > 0 then
                                    self.drawSpellBottom = true
                                    self.aSB = {x = self.x, y = self.y, nx = (self.x), ny = (self.y + 1)}
                                    local nx = self.aSB.nx
                                    local ny = self.aSB.ny
                                    self.spellTime = love.timer.getTime()
                                    flux.to(self.aSB, 0.5, {x = nx, y = ny}):ease("expoout")
                                elseif tcx == -1 and tcy > 0 then
                                    self.drawSpellBL = true
                                    self.asBL = {x = self.x, y = self.y, nx = (self.x - 1), ny = (self.y + 1)}
                                    local nx = self.asBL.nx
                                    local ny = self.asBL.ny
                                    self.spellTime = love.timer.getTime()
                                    flux.to(self.asBL, 0.5, {x = nx, y = ny}):ease("expoout")
                                elseif tcx == 1 and tcy > 0 then
                                    self.drawSpellBR = true
                                    self.asBR = {x = self.x, y = self.y, nx = (self.x + 1), ny = (self.y + 1)}
                                    local nx = self.asBR.nx
                                    local ny = self.asBR.ny
                                    self.spellTime = love.timer.getTime()
                                    flux.to(self.asBR, 0.5, {x = nx, y = ny}):ease("expoout")
                                end
                                

                            end
                            
                        end
                    end
             
                end
            end
        
        
        self.actionPoints = self.actionPoints - 1
        gameState:changeState(gameState.states.selectCharacter)
    end

    print("RND STATE AFTER SPELL AirE: "..love.math.getRandomState())


end
    
return AirElemental