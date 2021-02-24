local Event001 = Event:extend("Event001")

function Event001:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event001image.png"),
        "Armageddon",
        1,
        "... burn, burn, burn ...",
        "All cellls are on \nfire.",
        0
    )
end


function Event001:drawEventStuff()
if self.enableDraw then
        love.graphics.setFont(statFont)
        love.graphics.draw(self.image, width / 4 + offsetX + 76, height / 4 + offsetY + 110)
        love.graphics.print(self.name, width / 4 + offsetX + 56, height / 4 + offsetY + 26)
        love.graphics.print(self.id, width / 4 + offsetX + 270, height / 4 + offsetY + 26)
        love.graphics.print(self.flavorText, width / 4 + offsetX + 38, height / 4 + offsetY + 276)
        love.graphics.print(self.text, width / 4 + offsetX + 166, height / 4 + offsetY + 104)
        love.graphics.setFont(actionMenuFont)
end

end

function Event001:eventFunction()

    for x = 1, 10 do
        for y = 1, 10 do
            table.insert(sequenceBufferTable, {
                name = "ArmageddonEvent",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()

                    if not boardGrid[x][y]:instanceOf(BurntField) then
                        boardGrid[x][y].isOnFire = true
                    end

                    if boardGrid[x][y]:instanceOf(Lake) then 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[x][y].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsAreFields",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[x][y] = Field(x, y)
                            end
                        }) 
                    end

                    if boardGrid[x][y]:instanceOf(Ice) then
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 0.1,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[x][y].isSteaming = true
                            end
                        }) 
                        table.insert(sequenceBufferTable, {
                            name = "CellsareSteaming",
                            duration = 1.5,
                            sequenceTime = love.timer.getTime(),
                            action = function()
                                boardGrid[x][y] = Lake(x, y) 
                            end
                        }) 
                    end
                    
                    if boardGrid[x][y]:instanceOf(Forest) then 
                        boardGrid[x][y] = BurntField(x, y)
                        boardGrid[x][y].isBurntField = true
                        boardGrid[x][y].burntFieldTimer = turnCounter
                    end

                    if boardGrid[x][y]:instanceOf(Desert) then 
                        boardGrid[x][y] = GlassMount(x, y)
                        boardGrid[x][y].isInstanced = true
                    end

                    boardGrid[x][y].fireTurn = turnCounter

                end
            })
        end
    end
    Cell:resetParticleDrawing()
end
    

return Event001