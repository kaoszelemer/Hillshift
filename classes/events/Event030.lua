local Event030 = Event:extend("Event030")

function Event030:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Medium Earthquake",
        30,
        "... we are in Fiji ...",
        "20 RND Cells are Mount",
        1
    )
end


function Event030:drawEventStuff()
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

function Event030:eventFunction()


    for x = 1, 20  do
        table.insert(sequenceBufferTable, {
        name = "mediumEarthQuakeEvent",
        duration = 0.1,
        sequenceTime = love.timer.getTime(),
        action = function()

            rndCellX = randomFunction(1, 10, "event30", "boardgrid")
            rndCellY = randomFunction(1, 10, "event30", "boardgrid")

                boardGrid[rndCellX][rndCellY] = Mount(rndCellX, rndCellY)
                boardGrid[rndCellX][rndCellY].isInstanced = true
        end
    })
   
    end

    Cell:resetParticleDrawing()

end
    

return Event030