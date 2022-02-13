local Event049 = Event:extend("Event049")

function Event049:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Coordinate Geometry",
        49,
        "... was that an X or a Y ...",
        "Character coordinates are switched",
        1
    )
end


function Event049:drawEventStuff()
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

function Event049:eventFunction()


    for _, currentChar in ipairs(activePlayer.characters) do
        table.insert(sequenceBufferTable, {
            name = "coordinategeometryfirstcharacter",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()
                currentChar.stepPoints = currentChar.stepPoints + 1
                currentChar:move(currentChar.y, currentChar.x, currentChar.x, currentChar.y)
            end
        })
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        table.insert(sequenceBufferTable, {
            name = "coordinategeometrysecondcharacter",
            duration = 1,
            sequenceTime = love.timer.getTime(),
            action = function()
                currentChar.stepPoints = currentChar.stepPoints + 1
                currentChar:move(currentChar.y, currentChar.x, currentChar.x, currentChar.y)
            end
        })
    end


end
    

return Event049