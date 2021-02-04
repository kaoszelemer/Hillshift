local Event008 = Event:extend("Event008")

function Event008:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event003image.png"),
        "Chaotic Blessing",
        8,
        "... now fight ...",
        "ALL Characters +2AT +2DF",
        1
    )
end


function Event008:drawEventStuff()
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

function Event008:eventFunction()

   
    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar.baseAttack = currentChar.baseAttack + 2
        currentChar.baseDefense = currentChar.baseDefense + 2

    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar.baseAttack = currentChar.baseAttack + 2
        currentChar.baseDefense = currentChar.baseDefense + 2

    end



end
    

return Event008