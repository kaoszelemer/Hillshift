local Event027 = Event:extend("Event027")

function Event027:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "BrokenFaceBoying",
        27,
        "... odaig kuszott ...",
        "One of YOUR \nCharacter moves\nY+2",
        1
    )
end


function Event027:drawEventStuff()
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

function Event027:eventFunction()


    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar.baseAttack = currentChar.baseAttack + 3
        currentChar.baseDefense = currentChar.baseDefense + 2
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar.baseAttack = currentChar.baseAttack + 3
        currentChar.baseDefense = currentChar.baseDefense + 2
    end


end
    

return Event027