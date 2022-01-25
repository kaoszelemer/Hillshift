local Event037 = Event:extend("Event037")

function Event037:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Great Foresting",
        37,
        "... would we ever find the way out? ...",
        "30 RND Cells are Forest",
        1
    )
end


function Event037:drawEventStuff()
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

function Event037:eventFunction()



    for x = 1, 30  do
        table.insert(sequenceBufferTable, {
            name = "mediumfloodingevent",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                rndCellX = randomFunction(1, 10, "event37")
                rndCellY = randomFunction(1, 10, "event37")

                boardGrid[rndCellX][rndCellY] = Forest(rndCellX, rndCellY)
                boardGrid[rndCellX][rndCellY].isInstanced = true

            end
        })
    end
    Cell:resetParticleDrawing()


end
    

return Event037