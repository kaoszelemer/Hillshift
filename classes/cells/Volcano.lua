local Volcano = Cell:extend("Volcano")

function Volcano:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(384, 64, tileW, tileH, tilesetW, tilesetH),
        0,
        0,
        1000)
end




function Volcano:boom(bx, by)

    local d = 0.3
  
   
  
    

    
   
    soundEngine:playSFX(eruptionSound)
  --  screenShake(1, 1)
--[[ 
    for x = -1, 1 do
        for y = -1, 1 do
            if by + y > 0 and by - y <= 10 and bx + x <= 10 and bx - x > 0 then

                if  x ~= 0 or y ~= 0 then

                    local tc = boardGrid[bx + x][by + y]

                    table.insert(sequenceBufferTable, {
                        name = "ArmageddonEvent",
                        duration = 0.1,
                        sequenceTime = love.timer.getTime(),
                        action = function()
        
                            if not tc:instanceOf(BurntField) then
                                tc.isOnFire = true
                            end
        
                            if tc:instanceOf(Lake) then 
                                table.insert(sequenceBufferTable, {
                                    name = "CellsareSteaming",
                                    duration = 0.1,
                                    sequenceTime = love.timer.getTime(),
                                    action = function()
                                        tc.isSteaming = true
                                    end
                                }) 
                                table.insert(sequenceBufferTable, {
                                    name = "CellsAreFields",
                                    duration = 25,
                                    sequenceTime = love.timer.getTime(),
                                    action = function()
                                        tc = Field(tc.x, tc.y)
                                        tc.isInstanced = true
                                        print("FILD")
                                    end
                                }) 
                            end
        
                            if tc:instanceOf(Ice) then
                                table.insert(sequenceBufferTable, {
                                    name = "CellsareSteaming",
                                    duration = 0.1,
                                    sequenceTime = love.timer.getTime(),
                                    action = function()
                                        tc.isSteaming = true
                                    end
                                }) 
                                table.insert(sequenceBufferTable, {
                                    name = "CellsareSteaming",
                                    duration = 1.5,
                                    sequenceTime = love.timer.getTime(),
                                    action = function()
                                        tc = Lake(tc.x, tc.y) 
                                        tc.isInstanced = true
                                    end
                                }) 
                            end
                            
                            if tc:instanceOf(Forest) then 
                                tc = BurntField(tc.x, tc.y)
                                tc.isInstanced = true
                                tc.isBurntField = true
                                tc.burntFieldTimer = turnCounter
                            end
        
                            if tc:instanceOf(Desert) then 
                                tc = GlassMount(tc.x, tc.y)
                                tc.isInstanced = true
                            end
        
                            tc.fireTurn = turnCounter
                          
                        end
                    })
                  
                end

            end
        end
    end

    boardGrid[bx][by] = Mount(bx, by)
    boardGrid[bx][by].isInstanced = true
    boardGrid[bx][by].isErupting = true
    boardGrid[bx][by].eruptionTimer = love.timer.getTime()
    isVolcanoOnBoard = false

    table.insert(sequenceBufferTable, {
        name = "resetParticleDrawing",
        duration = 0.5,
        sequenceTime = love.timer.getTime(),
        action = function()

            Cell:resetParticleDrawing()

        end}) ]]


  







    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if bx - 1 > 0 then

               
                boardGrid[bx - 1][by].isOnFire = true
                boardGrid[bx - 1][by].fireTurn = turnCounter
                if  boardGrid[bx - 1][by].isOccupied then
                    boardGrid[bx - 1][by].occupiedBy.baseHP = boardGrid[bx - 1][by].occupiedBy.baseHP - 5
                    boardGrid[bx - 1][by].drawDamageOnBoard = true
                    boardGrid[bx - 1][by]:damageOnBoard(5)
                end

                table.insert(sequenceBufferTable, {
                    name = "ArmageddonEvent",
                    duration = 0.1,
                    sequenceTime = love.timer.getTime(),
                    action = function()
    
                        if not boardGrid[bx - 1][by]:instanceOf(BurntField) then
                            boardGrid[bx - 1][by].isOnFire = true
                        end
    
                        if boardGrid[bx - 1][by]:instanceOf(Lake) then 
                            table.insert(sequenceBufferTable, {
                                name = "CellsareSteaming",
                                duration = 0.1,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    boardGrid[bx - 1][by].isSteaming = true
                                end
                            }) 
                            table.insert(sequenceBufferTable, {
                                name = "CellsAreFields",
                                duration = 1.5,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    boardGrid[bx - 1][by] = Field(bx -1, by)
                                    boardGrid[bx - 1][by].isInstanced = true
                                end
                            }) 
                        end
    
                        if boardGrid[bx - 1][by]:instanceOf(Ice) then
                            table.insert(sequenceBufferTable, {
                                name = "CellsareSteaming",
                                duration = 0.1,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    boardGrid[bx - 1][by].isSteaming = true
                                end
                            }) 
                            table.insert(sequenceBufferTable, {
                                name = "CellsareSteaming",
                                duration = 1.5,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    boardGrid[bx - 1][by] = Lake(bx -1, by) 
                                    boardGrid[bx - 1][by].isInstanced = true
                                end
                            }) 
                        end
                        
                        if boardGrid[bx - 1][by]:instanceOf(Forest) then 
                            boardGrid[bx - 1][by] = BurntField(bx -1, by)
                            boardGrid[bx - 1][by].isInstanced = true
                            boardGrid[bx - 1][by].isBurntField = true
                            boardGrid[bx - 1][by].burntFieldTimer = turnCounter
                        end
    
                        if boardGrid[bx - 1][by]:instanceOf(Desert) then 
                            boardGrid[bx - 1][by] = GlassMount(bx -1, by)
                            boardGrid[bx - 1][by].isInstanced = true
                        end
    
                        boardGrid[bx - 1][by].fireTurn = turnCounter
                      
                    end
                })
                Cell:resetParticleDrawing()

            end

        end})

    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if bx + 1 <= 10 then   
                boardGrid[bx + 1][by].isOnFire = true
                boardGrid[bx + 1][by].fireTurn = turnCounter
                if  boardGrid[bx + 1][by].isOccupied then
                    boardGrid[bx + 1][by].occupiedBy.baseHP = boardGrid[bx + 1][by].occupiedBy.baseHP - 5
                    boardGrid[bx + 1][by].drawDamageOnBoard = true
                    boardGrid[bx + 1][by]:damageOnBoard(5)
                end

                table.insert(sequenceBufferTable, {
                    name = "ArmageddonEvent",
                    duration = 0.1,
                    sequenceTime = love.timer.getTime(),
                    action = function()
    
                        if not boardGrid[bx + 1][by]:instanceOf(BurntField) then
                            boardGrid[bx + 1][by].isOnFire = true
                        end
    
                        if boardGrid[bx + 1][by]:instanceOf(Lake) then 
                            table.insert(sequenceBufferTable, {
                                name = "CellsareSteaming",
                                duration = 0.1,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    boardGrid[bx + 1][by].isSteaming = true
                                end
                            }) 
                            table.insert(sequenceBufferTable, {
                                name = "CellsAreFields",
                                duration = 1.5,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    boardGrid[bx + 1][by] = Field(bx + 1, by)
                                    boardGrid[bx + 1][by].isInstanced = true
                                end
                            }) 
                        end
    
                        if boardGrid[bx + 1][by]:instanceOf(Ice) then
                            table.insert(sequenceBufferTable, {
                                name = "CellsareSteaming",
                                duration = 0.1,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    boardGrid[bx + 1][by].isSteaming = true
                                end
                            }) 
                            table.insert(sequenceBufferTable, {
                                name = "CellsareSteaming",
                                duration = 1.5,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    boardGrid[bx + 1][by] = Lake(bx + 1, by) 
                                    boardGrid[bx + 1][by].isInstanced = true
                                end
                            }) 
                        end
                        
                        if boardGrid[bx + 1][by]:instanceOf(Forest) then 
                            boardGrid[bx + 1][by] = BurntField(bx + 1, by)
                            boardGrid[bx + 1][by].isInstanced = true
                            boardGrid[bx + 1][by].isBurntField = true
                            boardGrid[bx + 1][by].burntFieldTimer = turnCounter
                        end
    
                        if boardGrid[bx + 1][by]:instanceOf(Desert) then 
                            boardGrid[bx + 1][by] = GlassMount(bx + 1, by)
                            boardGrid[bx + 1][by].isInstanced = true
                        end
    
                        boardGrid[bx + 1][by].fireTurn = turnCounter
                      
                    end
                })
                Cell:resetParticleDrawing()
            end

        end})

    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if bx - 1 > 0 and by - 1 > 0 then  
                boardGrid[bx - 1][by - 1].isOnFire = true
                boardGrid[bx - 1][by - 1].fireTurn = turnCounter
                if  boardGrid[bx - 1][by - 1].isOccupied then
                    boardGrid[bx - 1][by - 1].occupiedBy.baseHP = boardGrid[bx - 1][by - 1].occupiedBy.baseHP - 5
                    boardGrid[bx - 1][by - 1].drawDamageOnBoard = true
                    boardGrid[bx - 1][by - 1]:damageOnBoard(5)
                end
            end

            table.insert(sequenceBufferTable, {
                name = "ArmageddonEvent",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()

                    if not boardGrid[bx - 1][by - 1]:instanceOf(BurntField) then
                        boardGrid[bx - 1][by - 1].isOnFire = true
                    end

                    if boardGrid[bx - 1][by - 1]:instanceOf(Lake) then 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx - 1][by - 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreFields",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx - 1][by - 1] = Field(bx - 1, by - 1)
                                boardGrid[bx - 1][by - 1].isInstanced = true
                            end
                        }) 
                    end

                    if boardGrid[bx - 1][by - 1]:instanceOf(Ice) then
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx - 1][by - 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx - 1][by - 1] = Lake(bx - 1, by - 1) 
                                boardGrid[bx - 1][by - 1].isInstanced = true
                            end
                        }) 
                    end
                    
                    if boardGrid[bx - 1][by - 1]:instanceOf(Forest) then 
                        boardGrid[bx - 1][by - 1] = BurntField(bx - 1, by - 1)
                        boardGrid[bx - 1][by - 1].isInstanced = true
                        boardGrid[bx - 1][by - 1].isBurntField = true
                        boardGrid[bx - 1][by - 1].burntFieldTimer = turnCounter
                    end

                    if boardGrid[bx - 1][by - 1]:instanceOf(Desert) then 
                        boardGrid[bx - 1][by - 1] = GlassMount(bx - 1, by - 1)
                        boardGrid[bx - 1][by - 1].isInstanced = true
                    end

                    boardGrid[bx - 1][by - 1].fireTurn = turnCounter
                  
                end
            })
            Cell:resetParticleDrawing()

        end})


    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()


            if bx + 1 <= 10 and  by - 1 > 0 then   
                boardGrid[bx + 1][by - 1].isOnFire = true
                boardGrid[bx + 1][by - 1].fireTurn = turnCounter
                if  boardGrid[bx + 1][by - 1].isOccupied then
                    boardGrid[bx + 1][by - 1].occupiedBy.baseHP = boardGrid[bx + 1][by - 1].occupiedBy.baseHP - 5
                    boardGrid[bx + 1][by - 1].drawDamageOnBoard = true
                    boardGrid[bx + 1][by - 1]:damageOnBoard(5)
                end
            end
            table.insert(sequenceBufferTable, {
                name = "ArmageddonEvent",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()

                    if not boardGrid[bx + 1][by - 1]:instanceOf(BurntField) then
                        boardGrid[bx + 1][by - 1].isOnFire = true
                    end

                    if boardGrid[bx + 1][by - 1]:instanceOf(Lake) then 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx + 1][by - 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreFields",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx + 1][by - 1] = Field(bx + 1, by - 1)
                                boardGrid[bx + 1][by - 1].isInstanced = true
                            end
                        }) 
                    end

                    if boardGrid[bx + 1][by - 1]:instanceOf(Ice) then
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx + 1][by - 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx + 1][by - 1] = Lake(bx + 1, by - 1) 
                                boardGrid[bx + 1][by - 1].isInstanced = true
                            end
                        }) 
                    end
                    
                    if boardGrid[bx + 1][by - 1]:instanceOf(Forest) then 
                        boardGrid[bx + 1][by - 1] = BurntField(bx + 1, by - 1)
                        boardGrid[bx + 1][by - 1].isInstanced = true
                        boardGrid[bx + 1][by - 1].isBurntField = true
                        boardGrid[bx + 1][by - 1].burntFieldTimer = turnCounter
                    end

                    if boardGrid[bx + 1][by - 1]:instanceOf(Desert) then 
                        boardGrid[bx + 1][by - 1] = GlassMount(bx + 1, by - 1)
                        boardGrid[bx + 1][by - 1].isInstanced = true
                    end

                    boardGrid[bx + 1][by - 1].fireTurn = turnCounter
                  
                end
            })
            Cell:resetParticleDrawing()
        end})


    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if bx - 1 > 0 and by + 1 <= 10 then   
                boardGrid[bx - 1][by + 1].isOnFire = true
                boardGrid[bx - 1][by + 1].fireTurn = turnCounter
                if  boardGrid[bx - 1][by + 1].isOccupied then
                    boardGrid[bx - 1][by + 1].occupiedBy.baseHP = boardGrid[bx - 1][by + 1].occupiedBy.baseHP - 5
                    boardGrid[bx - 1][by + 1].drawDamageOnBoard = true
                    boardGrid[bx - 1][by + 1]:damageOnBoard(5)
                end
            end

            table.insert(sequenceBufferTable, {
                name = "ArmageddonEvent",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()

                    if not boardGrid[bx - 1][by + 1]:instanceOf(BurntField) then
                        boardGrid[bx - 1][by + 1].isOnFire = true
                    end

                    if boardGrid[bx - 1][by + 1]:instanceOf(Lake) then 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx - 1][by + 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreFields",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx - 1][by + 1] = Field(bx - 1, by + 1)
                                boardGrid[bx - 1][by + 1].isInstanced = true
                            end
                        }) 
                    end

                    if boardGrid[bx - 1][by + 1]:instanceOf(Ice) then
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx - 1][by + 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx - 1][by + 1] = Lake(bx - 1, by + 1) 
                                boardGrid[bx - 1][by + 1].isInstanced = true
                            end
                        }) 
                    end
                    
                    if boardGrid[bx - 1][by + 1]:instanceOf(Forest) then 
                        boardGrid[bx - 1][by + 1] = BurntField(bx - 1, by + 1)
                        boardGrid[bx - 1][by + 1].isInstanced = true
                        boardGrid[bx - 1][by + 1].isBurntField = true
                        boardGrid[bx - 1][by + 1].burntFieldTimer = turnCounter
                    end

                    if boardGrid[bx - 1][by + 1]:instanceOf(Desert) then 
                        boardGrid[bx - 1][by + 1] = GlassMount(bx - 1, by + 1)
                        boardGrid[bx - 1][by + 1].isInstanced = true
                    end

                    boardGrid[bx - 1][by + 1].fireTurn = turnCounter
                  
                end
            })
            Cell:resetParticleDrawing()

        end})

    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if  bx + 1 <= 10 and by + 1 <= 10 then   
                boardGrid[bx + 1][by + 1].isOnFire = true
                boardGrid[bx + 1][by + 1].fireTurn = turnCounter
                if  boardGrid[bx + 1][by+1].isOccupied then
                    boardGrid[bx + 1][by+1].occupiedBy.baseHP = boardGrid[bx - 1][by+1].occupiedBy.baseHP - 5
                    boardGrid[bx + 1][by + 1].drawDamageOnBoard = true
                    boardGrid[bx + 1][by+1]:damageOnBoard(5)
                end
            end

            table.insert(sequenceBufferTable, {
                name = "ArmageddonEvent",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()

                    if not boardGrid[bx + 1][by + 1]:instanceOf(BurntField) then
                        boardGrid[bx + 1][by + 1].isOnFire = true
                    end

                    if boardGrid[bx + 1][by + 1]:instanceOf(Lake) then 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx + 1][by + 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreFields",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx + 1][by + 1] = Field(bx + 1, by + 1)
                                boardGrid[bx + 1][by + 1].isInstanced = true
                            end
                        }) 
                    end

                    if boardGrid[bx + 1][by + 1]:instanceOf(Ice) then
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx + 1][by + 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx + 1][by + 1] = Lake(bx + 1, by + 1) 
                                boardGrid[bx + 1][by + 1].isInstanced = true
                            end
                        }) 
                    end
                    
                    if boardGrid[bx + 1][by + 1]:instanceOf(Forest) then 
                        boardGrid[bx + 1][by + 1] = BurntField(bx + 1, by + 1)
                        boardGrid[bx + 1][by + 1].isInstanced = true
                        boardGrid[bx + 1][by + 1].isBurntField = true
                        boardGrid[bx + 1][by + 1].burntFieldTimer = turnCounter
                    end

                    if boardGrid[bx + 1][by + 1]:instanceOf(Desert) then 
                        boardGrid[bx + 1][by + 1] = GlassMount(bx + 1, by + 1)
                        boardGrid[bx + 1][by + 1].isInstanced = true
                    end

                    boardGrid[bx + 1][by + 1].fireTurn = turnCounter
                  
                end
            })
            Cell:resetParticleDrawing()

        end})

    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if by + 1 <= 10 then   
                boardGrid[bx][by + 1].isOnFire = true
                boardGrid[bx][by + 1].fireTurn = turnCounter
                if  boardGrid[bx][by + 1].isOccupied then
                    boardGrid[bx][by + 1].occupiedBy.baseHP = boardGrid[bx][by + 1].occupiedBy.baseHP - 5
                    boardGrid[bx][by + 1].drawDamageOnBoard = true
                    boardGrid[bx][by + 1]:damageOnBoard(5)
                end
            end

            table.insert(sequenceBufferTable, {
                name = "ArmageddonEvent",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()

                    if not boardGrid[bx][by + 1]:instanceOf(BurntField) then
                        boardGrid[bx][by + 1].isOnFire = true
                    end

                    if boardGrid[bx][by + 1]:instanceOf(Lake) then 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx][by + 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreFields",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx][by + 1] = Field(bx, by + 1)
                                boardGrid[bx][by + 1].isInstanced = true
                            end
                        }) 
                    end

                    if boardGrid[bx][by + 1]:instanceOf(Ice) then
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx][by + 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx][by + 1] = Lake(bx, by + 1) 
                                boardGrid[bx][by + 1].isInstanced = true
                            end
                        }) 
                    end
                    
                    if boardGrid[bx][by + 1]:instanceOf(Forest) then 
                        boardGrid[bx][by + 1] = BurntField(bx, by + 1)
                        boardGrid[bx][by + 1].isInstanced = true
                        boardGrid[bx][by + 1].isBurntField = true
                        boardGrid[bx][by + 1].burntFieldTimer = turnCounter
                    end

                    if boardGrid[bx][by + 1]:instanceOf(Desert) then 
                        boardGrid[bx][by + 1] = GlassMount(bx, by + 1)
                        boardGrid[bx][by + 1].isInstanced = true
                    end

                    boardGrid[bx][by + 1].fireTurn = turnCounter
                  
                end
            })
            Cell:resetParticleDrawing()

        end})

    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if by - 1 > 0 then   
                boardGrid[bx][by - 1].isOnFire = true
                boardGrid[bx][by - 1].fireTurn = turnCounter
                if  boardGrid[bx][by - 1].isOccupied then
                    boardGrid[bx][by - 1].occupiedBy.baseHP = boardGrid[bx][by - 1].occupiedBy.baseHP - 5
                    boardGrid[bx][by - 1].drawDamageOnBoard = true
                    boardGrid[bx][by - 1]:damageOnBoard(5)
                end
            end

            table.insert(sequenceBufferTable, {
                name = "ArmageddonEvent",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()

                    if not boardGrid[bx][by - 1]:instanceOf(BurntField) then
                        boardGrid[bx][by - 1].isOnFire = true
                    end

                    if boardGrid[bx][by - 1]:instanceOf(Lake) then 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx][by - 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreFields",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx][by - 1] = Field(bx, by - 1)
                                boardGrid[bx][by - 1].isInstanced = true
                            end
                        }) 
                    end

                    if boardGrid[bx][by - 1]:instanceOf(Ice) then
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx][by - 1].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[bx][by - 1] = Lake(bx, by - 1) 
                                boardGrid[bx][by - 1].isInstanced = true
                            end
                        }) 
                    end
                    
                    if boardGrid[bx][by - 1]:instanceOf(Forest) then 
                        boardGrid[bx][by - 1] = BurntField(bx, by - 1)
                        boardGrid[bx][by - 1].isInstanced = true
                        boardGrid[bx][by - 1].isBurntField = true
                        boardGrid[bx][by - 1].burntFieldTimer = turnCounter
                    end

                    if boardGrid[bx][by - 1]:instanceOf(Desert) then 
                        boardGrid[bx][by - 1] = GlassMount(bx, by - 1)
                        boardGrid[bx][by - 1].isInstanced = true
                    end

                    boardGrid[bx][by - 1].fireTurn = turnCounter
                  
                end
            })
            Cell:resetParticleDrawing()

        end})
   
        boardGrid[bx][by] = Mount(bx, by)
        boardGrid[bx][by].isInstanced = true
        boardGrid[bx][by].isErupting = true
        boardGrid[bx][by].eruptionTimer = love.timer.getTime()
        isVolcanoOnBoard = false
    
   
end


return Volcano