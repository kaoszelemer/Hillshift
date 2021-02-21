local Event051 = Event:extend("Event051")

function Event051:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Swampity Swamp",
        51,
        "... ogres live here ...",
        "All lakes are \nSwamps",
        1
    )
end


function Event051:drawEventStuff()
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

function Event051:eventFunction()

   for x = 1, 10 do
        for y = 1, 10 do
            table.insert(sequenceBufferTable, {
                name = "swampityswampevent",
                duration = 0.3,
                sequenceTime = love.timer.getTime(),
                action = function()
                    if boardGrid[x][y]:instanceOf(Lake) then boardGrid[x][y] = Swamp(x, y) end
                end
            })

        end
    end


end
    

return Event051