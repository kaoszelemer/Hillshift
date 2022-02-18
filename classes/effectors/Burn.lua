local Burn = Effector:extend("Burn")

function Burn:init(x, y, name)
    Effector.init(
        self, 
        x, 
        y, 
        "Burn"
        )

end

function Burn:apply(x, y)

    Effector:apply(x, y)
    
    if boardGrid[x][y]:instanceOf(Lake) ~= true and boardGrid[x][y]:instanceOf(Volcano) ~= true then
        boardGrid[x][y].isOnFire = true
        boardGrid[x][y].fireTurn = turnCounter
    end

    if boardGrid[x][y].isOccupied then
        
        boardGrid[x][y].occupiedBy:damage(boardGrid[x][y].occupiedBy, 5)
        
        
    end


    if boardGrid[x][y]:instanceOf(Lake) then
        soundEngine:playSFX(steamSound)
        table.insert(sequenceBufferTable, {
            name = "TopLeftCellisSteaming",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()

                boardGrid[x][y].isSteaming = true
                
            end
        })
        table.insert(sequenceBufferTable, {
            name = "TopLeftCellisField",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()
                boardGrid[x][y] = Field(x, y)
            end
        })
        boardGrid[x][y].isOnFire = false
    end

    if boardGrid[x][y]:instanceOf(Field) and boardGrid[x][y].isFrozen then
        soundEngine:playSFX(steamSound)
        table.insert(sequenceBufferTable, {
            name = "TopLeftCellisSteaming",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()
                boardGrid[x][y].isSteaming = true
                
            end
        }) 
        table.insert(sequenceBufferTable, {
            name = "TopLeftCellisLake",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()
                boardGrid[x][y] = Lake(x, y)
            end
        })

        boardGrid[x][y].isFrozen = false
    end

    if boardGrid[x][y]:instanceOf(Ice) then 
        soundEngine:playSFX(steamSound)
        table.insert(sequenceBufferTable, {
        name = "TopLeftCellisSteaming",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()
                boardGrid[x][y].isSteaming = true
            
            end
        })
        table.insert(sequenceBufferTable, {
            name = "TopLeftCellisLake",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()
                boardGrid[x][y] = Lake(x, y)
            end
        })
        boardGrid[x][y].isOnFire = false
    end

    if boardGrid[x][y]:instanceOf(Desert) then 
        boardGrid[x][y] = GlassMount(x, y)
        boardGrid[x][y].isInstanced = true
        boardGrid[x][y].isOnFire = false
    end

    if boardGrid[x][y].isFrozen then 
        boardGrid[x][y].isFrozen = false
        boardGrid[x][y].isOnFire = false 
    end 


end

return Burn