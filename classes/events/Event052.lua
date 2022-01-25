local Event052 = Event:extend("Event052")

function Event052:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Glass Factory",
        52,
        "... i live here ...",
        "RND Cells are\nGlass Mounts",
        1
    )
end


function Event052:drawEventStuff()
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

function Event052:eventFunction()

    for x = 1, (randomFunction(1, 40, "event52")) do
        table.insert(sequenceBufferTable, {
            name = "glassfactoryevent",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                rndCellX = randomFunction(1, 10, "event52")
                rndCellY = randomFunction(1, 10, "event52")
                boardGrid[rndCellX][rndCellY] = GlassMount(rndCellX, rndCellY)
                boardGrid[rndCellX][rndCellY].isInstanced = true
            end
        })
    end

    Cell:resetParticleDrawing()
end
    

return Event052