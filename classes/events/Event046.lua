local Event046 = Event:extend("Event046")

function Event046:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Longevity",
        46,
        "... now it will take longer, or not? ...",
        "10*HP, 2*DF, 10AT",
        1
    )
end


function Event046:drawEventStuff()
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

function Event046:eventFunction()


    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar.baseHP = currentChar.baseHP * 10
        if currentChar.baseAttack <= 0 then
            currentChar.baseAttack = 1
        end

        if currentChar.baseDefense <= 0 then
            currentChar.baseDefense = 1
        end

        currentChar.baseAttack = 10
        currentChar.baseDefense = currentChar.baseDefense * 2
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar.baseHP = currentChar.baseHP * 10
        if currentChar.baseAttack <= 0 then
            currentChar.baseAttack = 1
        end

        if currentChar.baseDefense <= 0 then
            currentChar.baseDefense = 1
        end

        currentChar.baseAttack = 10
        currentChar.baseDefense = currentChar.baseDefense * 2
      
    end


end
    

return Event046