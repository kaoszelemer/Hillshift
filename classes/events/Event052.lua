local Event052 = Event:extend("Event052")

function Event052:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Excitement",
        52,
        "... hard work paid out ...",
        "One more Event is near",
        1
    )
end


function Event052:drawEventStuff()
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

function Event052:eventFunction()

 stepCounter = 0
    


end
    

return Event052