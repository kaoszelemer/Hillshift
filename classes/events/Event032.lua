local Event032 = Event:extend("Event032")

function Event032:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Little Flooding",
        32,
        "... a little water would be nice ...",
        "10 RND Cells\nare Lakes",
        1
    )
end


function Event032:drawEventStuff()
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

function Event032:eventFunction()


    for x = 1, 10  do
        table.insert(sequenceBufferTable, {
        name = "littlefloodingevent",
        duration = 0.3,
        sequenceTime = love.timer.getTime(),
        action = function()
            rndCellX = randomFunction(1, 10, "event32")
            rndCellY = randomFunction(1, 10, "event32")

                boardGrid[rndCellX][rndCellY] = Lake(rndCellX, rndCellY)
                boardGrid[rndCellX][rndCellY].isInstanced = true
        end
    })
    end

    Cell:resetParticleDrawing()

end
    

return Event032