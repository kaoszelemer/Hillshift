local Event067 = Event:extend("Event067")

function Event067:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Landslide",
        67,
        "... tony howk's pro slider ...",
        "Mounts are Fields",
        1
    )
end


function Event067:drawEventStuff()
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

function Event067:eventFunction()

    for x = 1, 10 do
        for y = 1, 10 do
            table.insert(sequenceBufferTable, {
                name = "glassfactoryevent",
                duration = 0.3,
                sequenceTime = love.timer.getTime(),
                action = function()
                    if boardGrid[x][y]:instanceOf(Mount) then 
                        boardGrid[x][y] = Field(x, y) 
                        boardGrid[x][y].isInstanced = true
                    end
                end
            })

        end
    end

  Cell:resetParticleDrawing()


end
    

return Event067