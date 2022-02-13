local Event009 = Event:extend("Event009")

function Event009:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event009image.png"),
        "Starvation",
        9,
        "... gimme a burger ...",
        "ALL Characters -1DF",
        1
    )
end


function Event009:drawEventStuff()
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

function Event009:eventFunction()


    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar.baseDefense = currentChar.baseDefense - 1  
    end
    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar.baseDefense = currentChar.baseDefense - 1  
    end



end
    

return Event009