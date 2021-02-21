local Event040 = Event:extend("Event040")

function Event040:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Great Deforesting",
        40,
        "... global warming is a lie, said everyone ...",
        "30 RND Cells are Fields",
        1
    )
end


function Event040:drawEventStuff()
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

function Event040:eventFunction()


    for x = 1, 30 do
        table.insert(sequenceBufferTable, {
            name = "mediumfloodingevent",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                rndCellX = love.math.random(1, 10)
                rndCellY = love.math.random(1, 10)

                boardGrid[rndCellX][rndCellY] = Field(rndCellX, rndCellY)
            end
        })
    end

end
    

return Event040