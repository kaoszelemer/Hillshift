local Event047 = Event:extend("Event047")

function Event047:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Quickness",
        47,
        "... you should finish this ...",
        "ALL Characters -5HP",
        1
    )
end


function Event047:drawEventStuff()
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

function Event047:eventFunction()


    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar:damage(currentChar, 5)
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar:damage(currentChar, 5)
    end


end
    

return Event047