local Event050 = Event:extend("Event050")

function Event050:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "420",
        50,
        "... you like that you little hippie ...",
        "ALL Characters 0 AT",
        1
    )
end


function Event050:drawEventStuff()
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

function Event050:eventFunction()


    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar.baseAttack = 0
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar.baseAttack = 0
    end


end
    

return Event050