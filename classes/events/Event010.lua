local Event010 = Event:extend("Event010")

function Event010:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event010image.png"),
        "Bad Luck",
        10,
        "... sorry, i had to do this ...",
        "ENEMY Characters +1AT",
        0
    )
end


function Event010:drawEventStuff()
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

function Event010:eventFunction()


    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar.baseAttack = currentChar.baseAttack + 1  
    end



end
    

return Event010