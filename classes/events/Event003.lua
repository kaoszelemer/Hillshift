local Event003 = Event:extend("Event003")

function Event003:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event003image.png"),
        "Blessing",
        3,
        "... Kifli blesses you...",
        "ALL characters\n+1AT",
        1
    )
end


function Event003:drawEventStuff()
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

function Event003:eventFunction()



    for _, currentChar in ipairs(playerOne.characters) do
        currentChar.baseAttack = currentChar.baseAttack + 1
    end

    for _, currentChar in ipairs(playerTwo.characters) do
        currentChar.baseAttack = currentChar.baseAttack + 1
    end



end
    

return Event003