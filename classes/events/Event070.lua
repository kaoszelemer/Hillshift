local Event070 = Event:extend("Event070")

function Event070:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Energy Boost",
        70,
        "... Blue Cow gives you wings ...",
        "YOUR RND Char +1SP, +1AP",
        1
    )
end


function Event070:drawEventStuff()
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

function Event070:eventFunction()

    local randomChar = randomFunction(1, #activePlayer.characters, "event70", "events")


    for i, currentChar in ipairs(activePlayer.characters) do
        if i == randomChar then
            currentChar.stepPoints = currentChar.stepPoints + 1
            currentChar.actionPoints = currentChar.actionPoints + 1

        end
    end



end
    

return Event070