local Event025 = Event:extend("Event025")

function Event025:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Deforesting",
        25,
        "... chop-chop ...",
        "ALL Forests are\nFields",
        1
    )
end


function Event025:drawEventStuff()
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

function Event025:eventFunction()


    for x = 1, 10 do
        for y = 1,10 do
            table.insert(sequenceBufferTable, {
                name = "deforestingEventActivePlayer",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()
                    rndCellX = love.math.random(1, 10)
                    rndCellY = love.math.random(1, 10)
                    if boardGrid[x][y]:instanceOf(Forest) then 
                        boardGrid[x][y] = Field(x, y) 
                        boardGrid[x][y].isInstanced = true
                    end
                end
            })
        end
    end
    Cell:resetParticleDrawing()

end
    

return Event025