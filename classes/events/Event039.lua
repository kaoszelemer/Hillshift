local Event039 = Event:extend("Event039")

function Event039:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Medium Deforesting",
        39,
        "... they will grow back don't worry ...",
        "20 RND Cells are Fields",
        1
    )
end


function Event039:drawEventStuff()
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

function Event039:eventFunction()


  
    for x = 1, 20 do
        table.insert(sequenceBufferTable, {
            name = "mediumdeforestingevent",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                rndCellX = randomFunction(1, 10, "event39", "boardgrid")
                rndCellY = randomFunction(1, 10, "event39", "boardgrid")

                boardGrid[rndCellX][rndCellY] = Field(rndCellX, rndCellY)
                boardGrid[rndCellX][rndCellY].isInstanced = true
            end
        })
    end

    Cell:resetParticleDrawing()
end
    

return Event039