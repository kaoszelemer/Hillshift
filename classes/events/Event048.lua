local Event048 = Event:extend("Event048")

function Event048:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Chaotic Chaos",
        48,
        "... Kaosz Elemer is the greatest ...",
        "RND Poison, \nRND Fire, \nRND Freeze",
        1
    )
end


function Event048:drawEventStuff()
if self.enableDraw then
        love.graphics.setFont(statFont)
        love.graphics.draw(self.image, width / 4 + offsetX + 56, height / 4 + offsetY + 90)
        love.graphics.print(self.name, width / 4 + offsetX + 56, height / 4 + offsetY + 26)
        love.graphics.print(self.id, width / 4 + offsetX + 270, height / 4 + offsetY + 26)
        love.graphics.print(self.flavorText, width / 4 + offsetX + 38, height / 4 + offsetY + 276)
        love.graphics.print(self.text, width / 4 + offsetX + 166, height / 4 + offsetY + 104)
        love.graphics.setFont(actionMenuFont)
end

end

function Event048:eventFunction()


    for i = 1, 16 do
        table.insert(sequenceBufferTable, {
            name = "chaoticchaoseventfirstmodifier",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()
                rndCellX = love.math.random(1, 10)
                rndCellY = love.math.random(1, 10)
                if not boardGrid[rndCellX][rndCellY].isPoisoned then
                    boardGrid[rndCellX][rndCellY].isPoisoned = true
                    boardGrid[rndCellX][rndCellY].poisoningTurn = turnCounter
                end
            end
        })
    end
    for i = 1, 16 do
        table.insert(sequenceBufferTable, {
            name = "chaoticchaoseventsecondmodifier",
            duration = 1,
            sequenceTime = love.timer.getTime(),
            action = function()
                    rndCellX = love.math.random(1, 10)
                    rndCellY = love.math.random(1, 10)
                    if boardGrid[rndCellX][rndCellY]:instanceOf(Lake) then
                         boardGrid[rndCellX][rndCellY] = Ice(rndCellX, rndCellY) 
                         boardGrid[rndCellX][rndCellY].isInstanced = true
                        end
                    if not boardGrid[rndCellX][rndCellY].isFrozen then
                        boardGrid[rndCellX][rndCellY].isFrozen = true
                        boardGrid[rndCellX][rndCellY].freezeTurn = turnCounter
                    end
            end
        })

    end
    for i = 1, 16 do
        table.insert(sequenceBufferTable, {
            name = "chaoticchaoseventthirdmodifier",
            duration = 1.5,
            sequenceTime = love.timer.getTime(),
            action = function()

                rndCellX = love.math.random(1, 10)
                rndCellY = love.math.random(1, 10)
                if boardGrid[rndCellX][rndCellY].isFrozen then boardGrid[rndCellX][rndCellY].isFrozen = false end  
                if boardGrid[rndCellX][rndCellY]:instanceOf(Lake) then 
                    table.insert(sequenceBufferTable, {
                        name = "CellsareSteaming",
                        duration = 0.1,
                        sequenceTime = love.timer.getTime(),
                        action = function()
                            boardGrid[rndCellX][rndCellY].isSteaming = true
                        end
                    }) 
                    table.insert(sequenceBufferTable, {
                        name = "CellsareFields",
                        duration = 0.1,
                        sequenceTime = love.timer.getTime(),
                        action = function()
                            boardGrid[rndCellX][rndCellY] = Field(rndCellX, rndCellY) 
                        end
                    }) 
                end
                if boardGrid[rndCellX][rndCellY]:instanceOf(Ice) then
                    table.insert(sequenceBufferTable, {
                        name = "CellsareSteaming",
                        duration = 0.1,
                        sequenceTime = love.timer.getTime(),
                        action = function()
                            boardGrid[rndCellX][rndCellY].isSteaming = true
                        end
                    }) 
                    table.insert(sequenceBufferTable, {
                        name = "CellsareLakes",
                        duration = 0.1,
                        sequenceTime = love.timer.getTime(),
                        action = function()
                            boardGrid[rndCellX][rndCellY] = Lake(rndCellX, rndCellY)                            
                        end
                    }) 
                end
                if boardGrid[rndCellX][rndCellY]:instanceOf(Forest) then 
                    boardGrid[rndCellX][rndCellY] = BurntField(rndCellX, rndCellY) 
                    boardGrid[rndCellX][rndCellY].burntFieldTimer = turnCounter
                    boardGrid[rndCellX][rndCellY].isBurntField = true
                end
                if boardGrid[rndCellX][rndCellY]:instanceOf(Desert) then 
                    boardGrid[rndCellX][rndCellY] = GlassMount(rndCellX, rndCellY)
                    boardGrid[rndCellX][rndCellY].isInstanced = true
                end
                if not boardGrid[rndCellX][rndCellY].isOnFire and not boardGrid[rndCellX][rndCellY]:instanceOf(BurntField) and not boardGrid[rndCellX][rndCellY]:instanceOf(GlassMount) and not boardGrid[rndCellX][rndCellY]:instanceOf(Lake) then 
                    boardGrid[rndCellX][rndCellY].isOnFire = true 
                    boardGrid[rndCellX][rndCellY].fireTurn = turnCounter
                end
            end
        })

    end

    Cell:resetParticleDrawing()


end
    

return Event048