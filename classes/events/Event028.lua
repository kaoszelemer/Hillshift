local Event028 = Event:extend("Event028")

function Event028:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Arieling",
        28,
        "... your teammate got a proper sorting ...",
        "Enemy has 0 SP \nand 0 AP next turn",
        1
    )
end


function Event028:drawEventStuff()
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

function Event028:eventFunction()


    for _, currentChar in ipairs(inactivePlayer.characters) do
       currentChar.actionPointModify = true
       currentChar.actionPointModifier = -1
       currentChar.stepPointModify = true
       currentChar.stepPointModifier = -1
    end


end
    

return Event028