local Event031 = Event:extend("Event031")

function Event031:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Great Earthquake",
        31,
        "... we are in Japan ...",
        "30 RND Cells are\nMount",
        1
    )
end


function Event031:drawEventStuff()
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

function Event031:eventFunction()


    for x = 1, 30  do
        table.insert(sequenceBufferTable, {
        name = "bigEarthQuakeEvent",
        duration = 0.1,
        sequenceTime = love.timer.getTime(),
        action = function()

            rndCellX = randomFunction(1, 10, "event31")
            rndCellY = randomFunction(1, 10, "event31")

                boardGrid[rndCellX][rndCellY] = Mount(rndCellX, rndCellY)
                boardGrid[rndCellX][rndCellY].isInstanced = true
        end
    })
     
    end

    Cell:resetParticleDrawing()

end
    

return Event031