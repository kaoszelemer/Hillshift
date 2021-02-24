local FireMage = Character:extend("FireMage")
    function FireMage:init(parentPlayer)
        Character.init(self, 100, 5, 20, 6, love.graphics.newImage("/graphics/firemage.png"), 
                    love.graphics.newImage("/graphics/firemageanim.png"),
                    love.graphics.newImage("/graphics/firemagehover.png"), 
                    love.graphics.newImage("/graphics/firemagesink.png"), 
                    love.graphics.newImage("/graphics/firemagesinkhover.png"), 
                    parentPlayer, 1, 1, 0, 0, 0, false)
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


   
   


    if self.actionPoints ~= 0 then
       --[[  self.ftTL = {}
        self.ftTR = {}
        self.ftBL = {}
        self.ftBR = {} ]]
    if  (targetCell.x == self.x and targetCell.y == self.y - 1) or (targetCell.x == self.x - 1 and targetCell.y == self.y - 1) or (targetCell.x == self.x + 1 and targetCell.y == self.y - 1) then
        self.actionPoints = self.actionPoints - 1

        if self.x - 1 > 0 and self.y - 1 > 0 then

                self.drawSpellTL = true
                self.ftTL = {x = self.x, y = self.y, nx = (self.x - 1), ny = (self.y - 1)}
                local nx = self.ftTL.nx
                local ny = self.ftTL.ny
                self.spellTime = love.timer.getTime()
                flux.to(self.ftTL, 0.5, {x = nx, y = ny}):ease("expoout")
                

            table.insert(sequenceBufferTable, {
                name = "FireMageSpellTopLeftCell",
                duration = 0.2,
                sequenceTime = love.timer.getTime(),
                action = function()

                    
                    boardGrid[self.x - 1][self.y - 1].isOnFire = true
                    boardGrid[self.x - 1][self.y - 1].fireTurn = turnCounter

                    if boardGrid[self.x - 1][self.y - 1]:instanceOf(Lake) then
                        table.insert(sequenceBufferTable, {
                            name = "TopLeftCellisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y - 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "TopLeftCellisField",
                            duration = 0.4,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y - 1] = Field(self.x - 1, self.y - 1)
                            end
                        })
                        boardGrid[self.x - 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x - 1][self.y - 1]:instanceOf(Field) and boardGrid[self.x - 1][self.y - 1].isFrozen then
                        table.insert(sequenceBufferTable, {
                            name = "TopLeftCellisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y - 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "TopLeftCellisLake",
                            duration = 0.4,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y - 1] = Lake(self.x - 1, self.y - 1)
                            end
                        })

                        boardGrid[self.x - 1][self.y - 1].isFrozen = false
                    end

                    if boardGrid[self.x - 1][self.y - 1]:instanceOf(Ice) then 
                        table.insert(sequenceBufferTable, {
                        name = "TopLeftCellisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y - 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "TopLeftCellisLake",
                            duration = 0.4,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y - 1] = Lake(self.x - 1, self.y - 1)
                            end
                        })
                        boardGrid[self.x - 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x - 1][self.y - 1]:instanceOf(Desert) then 
                        boardGrid[self.x - 1][self.y - 1] = GlassMount(self.x - 1, self.y - 1)
                        boardGrid[self.x - 1][self.y - 1].isInstanced = true
                        boardGrid[self.x - 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x - 1][self.y - 1].isFrozen then 
                        boardGrid[self.x - 1][self.y - 1].isFrozen = false
                        boardGrid[self.x - 1][self.y - 1].isOnFire = false 
                    end 
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

                    boardGrid[self.x + 1][self.y - 1].isOnFire = true
                    boardGrid[self.x + 1][self.y - 1].fireTurn = turnCounter

                    if boardGrid[self.x + 1][self.y - 1]:instanceOf(Lake) then 
                        table.insert(sequenceBufferTable, {
                            name = "TopRightCellisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y - 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "TopRightCellisField",
                            duration = 0.4,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y - 1] = Field(self.x + 1, self.y - 1)
                            end
                        })
                        boardGrid[self.x + 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x + 1][self.y - 1]:instanceOf(Field) and boardGrid[self.x + 1][self.y - 1].isFrozen then 
                        table.insert(sequenceBufferTable, {
                            name = "TopRightCellisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y - 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "TopRightCellisLake",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y - 1] = Lake(self.x + 1, self.y - 1)
                            end
                        })
                        boardGrid[self.x + 1][self.y - 1].isFrozen = false
                    end

                    if boardGrid[self.x + 1][self.y - 1]:instanceOf(Ice) then
                        table.insert(sequenceBufferTable, {
                            name = "TopRightCellisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y - 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "TopRightCellisLake",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y - 1] = Lake(self.x + 1, self.y - 1)
                            end
                        })
                        boardGrid[self.x + 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x + 1][self.y - 1]:instanceOf(Desert) then 
                        boardGrid[self.x + 1][self.y - 1] = GlassMount(self.x + 1, self.y - 1)
                        boardGrid[self.x + 1][self.y - 1].isInstanced = true
                        boardGrid[self.x + 1][self.y - 1].isOnFire = false
                    end

                    if boardGrid[self.x + 1][self.y - 1].isFrozen then 
                        boardGrid[self.x + 1][self.y - 1].isFrozen = false 
                        boardGrid[self.x + 1][self.y - 1].isOnFire = false 
                    end
                    self.drawSpellTR = false
                end
            })

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

            table.insert(sequenceBufferTable, {
                name = "FireMageSpellBottomLeftCell",
                duration = 0.2,
                sequenceTime = love.timer.getTime(),
                action = function()

                    boardGrid[self.x - 1][self.y + 1].isOnFire = true
                    boardGrid[self.x - 1][self.y + 1].fireTurn = turnCounter

                
                    if  boardGrid[self.x - 1][self.y + 1]:instanceOf(Lake) then
                        table.insert(sequenceBufferTable, {
                            name = "BottomLeftisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y + 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "BottomLeftlisLake",
                            duration = 0.4,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y + 1] = Field(self.x - 1, self.y + 1)
                            end
                        })
                        boardGrid[self.x - 1][self.y + 1].isOnFire = false
                    end

                    if  boardGrid[self.x - 1][self.y + 1]:instanceOf(Field) and boardGrid[self.x - 1][self.y + 1].isFrozen then 
                        table.insert(sequenceBufferTable, {
                            name = "BottomLeftisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y + 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "BottomLeftisLake",
                            duration = 0.4,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y + 1] = Lake(self.x - 1, self.y + 1)
                            end
                        })
                        boardGrid[self.x - 1][self.y + 1].isFrozen = false
                    end


                    if  boardGrid[self.x - 1][self.y + 1]:instanceOf(Ice) then 
                        table.insert(sequenceBufferTable, {
                            name = "BottomLeftisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y + 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "BottomLeftisLake",
                            duration = 0.4,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x - 1][self.y + 1] = Lake(self.x - 1, self.y + 1)
                            end
                        })
                        boardGrid[self.x - 1][self.y + 1].isOnFire = false
                    end

                    if  boardGrid[self.x - 1][self.y + 1]:instanceOf(Desert) then 
                        boardGrid[self.x - 1][self.y + 1] = GlassMount(self.x - 1, self.y + 1)
                        boardGrid[self.x - 1][self.y + 1].isInstanced = true
                        boardGrid[self.x - 1][self.y + 1].isOnFire = false
                    end

                    if  boardGrid[self.x - 1][self.y + 1].isFrozen then
                        boardGrid[self.x - 1][self.y + 1].isFrozen = false 
                        boardGrid[self.x - 1][self.y + 1].isOnFire = false 
                    end 
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

            table.insert(sequenceBufferTable, {
                name = "FireMageSpellBottomRightCell",
                duration = 0.4,
                sequenceTime = love.timer.getTime(),
                action = function()
                    boardGrid[self.x + 1][self.y + 1].isOnFire = true
                    boardGrid[self.x + 1][self.y + 1].fireTurn = turnCounter

                    
                    if boardGrid[self.x + 1][self.y + 1]:instanceOf(Lake) then 
                        table.insert(sequenceBufferTable, {
                            name = "BottomRightCellisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y + 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "BottomRightCellisLake",
                            duration = 0.4,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y + 1] = Field(self.x + 1, self.y + 1)
                            end
                        })
                        boardGrid[self.x + 1][self.y + 1].isOnFire = false
                    end
                    
                    if boardGrid[self.x + 1][self.y + 1]:instanceOf(Field) and boardGrid[self.x + 1][self.y + 1].isFrozen then
                        table.insert(sequenceBufferTable, {
                            name = "BottomRightCellisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y + 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "BottomRightCellisLake",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y + 1] = Lake(self.x + 1, self.y + 1)
                            end
                        })
                        boardGrid[self.x + 1][self.y + 1].isFrozen = false
                    end

                    if boardGrid[self.x + 1][self.y + 1]:instanceOf(Ice) then 
                        table.insert(sequenceBufferTable, {
                            name = "BottomRightCellisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y + 1].isSteaming = true
                            end
                        })
                        table.insert(sequenceBufferTable, {
                            name = "BottomRightCellisSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[self.x + 1][self.y + 1] = Lake(self.x + 1, self.y + 1)
                            end
                        })
                        boardGrid[self.x + 1][self.y + 1].isOnFire = false
                    end

                    if boardGrid[self.x + 1][self.y + 1]:instanceOf(Desert) then 
                        boardGrid[self.x + 1][self.y + 1] = GlassMount(self.x + 1, self.y + 1)
                        boardGrid[self.x + 1][self.y + 1].isInstanced = true
                        boardGrid[self.x + 1][self.y + 1].isOnFire = false
                    end

                    if boardGrid[self.x + 1][self.y + 1].isFrozen then 
                        boardGrid[self.x + 1][self.y + 1].isFrozen = false 
                        boardGrid[self.x + 1][self.y + 1].isOnFire = false 
                    end
                    self.drawSpellBR = false
                end
            })
    
        end

        gameState:changeState(gameState.states.selectCharacter)        
        
    end
end

end
   
return FireMage