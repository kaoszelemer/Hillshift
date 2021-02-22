local Event004 = Event:extend("Event004")

function Event004:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event004image.png"),
        "World Peace",
        4,
        "...Gandhi would be proud...",
        "YOUR characters\n+10HP",
        1
    )
end


function Event004:drawEventStuff()
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

function Event004:eventFunction()



    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar.baseHP = currentChar.baseHP + 10
    end




end
    

return Event004