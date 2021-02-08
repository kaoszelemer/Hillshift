local Event072 = Event:extend("Event072")

function Event072:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Timeslip",
        72,
        "... never understood timezones ...",
        "ALL Cell modifiers \n-1 Turn",
        1
    )
end


function Event072:drawEventStuff()
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

function Event072:eventFunction()

    for x = 1, 10 do
        for y = 1, 10 do

            boardGrid[x][y].fireTurn = boardGrid[x][y].fireTurn - 1
            boardGrid[x][y].poisoningTurn =  boardGrid[x][y].poisoningTurn - 1
            boardGrid[x][y].freezeTurn = boardGrid[x][y].freezeTurn - 1
        end
    end

end
    

return Event072