local Event020 = Event:extend("Event020")

function Event020:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Ice Skate Park",
        20,
        "... i never knew how to do that ...",
        "ALL Lakes are ICE",
        1
    )
end


function Event020:drawEventStuff()
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

function Event020:eventFunction()

    for x = 1, 10 do
        for y = 1,10 do
            table.insert(sequenceBufferTable, {
                name = "DesertificationEvent",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()
            
                    if boardGrid[x][y]:instanceOf(Lake) then boardGrid[x][y] = Ice(x, y) end
                end
            })
        end
    end
    


end
    

return Event020