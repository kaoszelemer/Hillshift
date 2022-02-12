local Event022 = Event:extend("Event022")

function Event022:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Start Over",
        22,
        "... tabula rasa ...",
        "ALL characters go \nback to starting \nposition",
        1
    )
end


function Event022:drawEventStuff()
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

function Event022:eventFunction()

  for i, currentChar in ipairs(playerOne.characters) do
    if     i == 1 then currentChar:move(5, 2, currentChar.x, currentChar.y)
    elseif i == 2 then currentChar:move(5, 3, currentChar.x, currentChar.y)
    elseif i == 3 then currentChar:move(6, 2, currentChar.x, currentChar.y)
    elseif i == 4 then currentChar:move(6, 3, currentChar.x, currentChar.y)
    end
    currentChar.stepPoints = 2
  end

for i, currentChar in ipairs(playerTwo.characters) do
    if     i == 1 then currentChar:move(5, 8, currentChar.x, currentChar.y)
    elseif i == 2 then currentChar:move(5, 9, currentChar.x, currentChar.y)
    elseif i == 3 then currentChar:move(6, 8, currentChar.x, currentChar.y)
    elseif i == 4 then currentChar:move(6, 9, currentChar.x, currentChar.y)
    end
    currentChar.stepPoints = 2
end

end
    

return Event022