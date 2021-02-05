local Event068 = Event:extend("Event068")

function Event068:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Fear",
        68,
        "... i want mommy ...",
        "Your Characters 0AP",
        1
    )
end


function Event068:drawEventStuff()
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

function Event068:eventFunction()


    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar.actionPoints = 0
    end


end
    

return Event068