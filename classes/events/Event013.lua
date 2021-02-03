local Event013 = Event:extend("Event013")

function Event013:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event001image.png"),
        "Sickness",
        13,
        "... thats like 2020 ...",
        "ALL Characters -2HP",
        0
    )
end


function Event013:drawEventStuff()
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

function Event013:eventFunction()


    for _, currentChar in ipairs(playerOne.characters) do

        currentChar.baseHP = currentChar.baseHP - 2
    end

    for _, currentChar in ipairs(playerTwo.characters) do

        currentChar.baseHP = currentChar.baseHP - 2
    end


end
    

return Event013