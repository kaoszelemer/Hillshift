local Event012 = Event:extend("Event012")

function Event012:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event001image.png"),
        "Great Weakening",
        12,
        "... now you can't flex ...",
        "ALL Characters -2DF",
        0
    )
end


function Event012:drawEventStuff()
if self.enableDraw then
        love.graphics.setFont(statFont)
        love.graphics.draw(self.image, width / 4 + offsetX + 76, height / 4 + offsetY + 110)
        love.graphics.print(self.name, width / 4 + offsetX + 56, height / 4 + offsetY + 26)
        love.graphics.print(self.id, width / 4 + offsetX + 270, height / 4 + offsetY + 26)
        love.graphics.print(self.flavorText, width / 4 + offsetX + 38, height / 4 + offsetY + 276)
        love.graphics.print(self.text, width / 4 + offsetX + 166, height / 4 + offsetY + 104)
        love.graphics.setFont(actionMenuFont)
end

end

function Event012:eventFunction()


    for _, currentChar in ipairs(playerOne.characters) do

        currentChar.baseDefense = currentChar.baseDefense - 2
    end

    for _, currentChar in ipairs(playerTwo.characters) do

        currentChar.baseDefense = currentChar.baseDefense - 2
    end


end
    

return Event012