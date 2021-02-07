local Event071 = Event:extend("Event071")

function Event071:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Energy Loss",
        71,
        "... Blue Cow breaks your wings ...",
        "YOUR RND Char \n-1SP, -1AP",
        1
    )
end


function Event071:drawEventStuff()
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

function Event071:eventFunction()
 local randomChar = love.math.random(1, #activePlayer.characters)

    for i, currentChar in ipairs(activePlayer.characters) do
        if i == randomChar then
            if currentChar.stepPoints ~= 0 then
                currentChar.stepPoints = currentChar.stepPoints - 1
            end
            if currentChar.actionPoints ~= 0 then
            currentChar.actionPoints = currentChar.actionPoints - 1
            end

        end
    end


end
    

return Event071