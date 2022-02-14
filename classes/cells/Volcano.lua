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
        1000,
        "its gonna erupt in a few turns\nsetting everything around it on Fire\nA wonderful spectacle",
        "Volcano")
end




function Volcano:boom(bx, by)

   


            local d = 0.3

      
            
        soundEngine:playSFX(eruptionSound)
        boardGrid[bx][by].isErupting = true
        boardGrid[bx][by].eruptionTimer = love.timer.getTime()

            for x = -1, 1 do
                for y = -1, 1 do
                    if x ~= 0 or y ~= 0 then
                        table.insert(sequenceBufferTable, {
                            name = "vulkar_boomstart",
                            duration = 0,
                            sequenceTime = love.timer.getTime(),
                            action = function()

                               
                                
                               

                                local targetCell = boardGrid[bx + x][by + y]

                            

                                       

                                        if not targetCell:instanceOf(BurntField) or targetCell.isFrozen ~= true then
                                            boardGrid[bx + x][by + y].isOnFire = true
                                            boardGrid[bx + x][by + y].fireTurn = turnCounter
                                        end
                                
                                
                                    table.insert(sequenceBufferTable, {
                                        name = "vulkarunfreeze",
                                        duration = 2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                            if targetCell.isFrozen then
                                                boardGrid[bx + x][by + y].isFrozen = false
                                            end
                                    end})
                                    
                                    table.insert(sequenceBufferTable, {
                                        name = "vulkarsteam",
                                        duration = 2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                            if targetCell:instanceOf(Lake) then
                                                boardGrid[bx + x][by + y].isSteaming = true
                                            end
                                        end})

                                    table.insert(sequenceBufferTable, {
                                        name = "vulkarlake2field",
                                        duration = 2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                            if targetCell:instanceOf(Lake) then
                                                boardGrid[bx + x][by + y] = Field(bx + x, by + y)
                                                boardGrid[bx + x][by + y].isInstanced = true
                                            end
                                        end})
                                        
                                        

                                    table.insert(sequenceBufferTable, {
                                        name = "vulkarburntfield",
                                        duration = 2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                            if targetCell:instanceOf(Forest) then
                                                boardGrid[bx + x][by + y] = BurntField(bx + x, by + y)
                                                boardGrid[bx + x][by + y].isInstanced = true
                                            end
                                        end})

                                    table.insert(sequenceBufferTable, {
                                        name = "vulkarglass",
                                        duration = 2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                            if targetCell:instanceOf(Desert) then
                                                boardGrid[bx + x][by + y] = GlassMount(bx + x, by + y)
                                                boardGrid[bx + x][by + y].isInstanced = true
                                            end
                                        end})

                                    table.insert(sequenceBufferTable, {
                                        name = "vulkarice2lake",
                                        duration = 2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()

                                            if targetCell:instanceOf(Ice) then
                                                boardGrid[bx + x][by + y] = Lake(bx + x, by + y)
                                                boardGrid[bx + x][by + y].isInstanced = true
                                            end
                                        end})

                                    table.insert(sequenceBufferTable, {
                                        name = "vulkardamage",
                                        duration = 2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                            if targetCell.isOccupied then
                                                targetCell.occupiedBy:damage(targetCell.occupiedBy, 5)
                                                boardGrid[bx + x][by + y].isInstanced = true
                                            end
                                        end})

                                    table.insert(sequenceBufferTable, {
                                        name = "vulkarkiajszik",
                                        duration = 2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                           
                                                boardGrid[bx][by] = Mount(bx, by)
                                                boardGrid[bx][by].isInstanced = true
                                                isVolcanoOnBoard = false
                                        end})

                                    


                            end})

                        
                            
                    
                    end
                end
            end

            table.insert(sequenceBufferTable, {
                name = "resetparticledraw",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()
                    Cell:resetParticleDrawing()
                    gameState:changeState(gameState.states.selectCharacter)
                end})
     
end


return Volcano