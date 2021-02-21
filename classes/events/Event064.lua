local Event064 = Event:extend("Event064")

function Event064:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Enemy Hill Shifting",
        64,
        "... where do that name came from ...",
        "ENEMY Characters Cells \nare Mounts",
        1
    )
end


function Event064:drawEventStuff()
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

function Event064:eventFunction()


    for _, currentChar in ipairs(inactivePlayer.characters) do
        table.insert(sequenceBufferTable, {
            name = "glassfactoryevent",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                boardGrid[currentChar.x][currentChar.y] = Mount(currentChar.x, currentChar.y)
            end
        })
    end


end
    

return Event064