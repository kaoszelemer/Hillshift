local Event002 = Event:extend("Event002")

function Event002:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event002image.png"),
        "Divine Heal",
        2,
        "i love Ancsigorl",
        "All characters +5HP",
        1
    )
end


function Event002:drawEventStuff()
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

function Event002:eventFunction()



    for _, currentChar in ipairs(playerOne.characters) do
        currentChar.baseHP = currentChar.baseHP + 5
    end

    for _, currentChar in ipairs(playerTwo.characters) do
        currentChar.baseHP = currentChar.baseHP + 5
    end



end
    

return Event002