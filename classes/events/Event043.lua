local Event043 = Event:extend("Event043")

function Event043:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Better Chance",
        43,
        "... do not open lootboxes ...",
        "ALL Characters +1DF mod, +2AT mod",
        1
    )
end


function Event043:drawEventStuff()
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

function Event043:eventFunction()


            for _, currentChar in ipairs(activePlayer.characters) do
                    boardGrid[currentChar.x][currentChar.y].attackModifier = boardGrid[currentChar.x][currentChar.y].attackModifier + 2
                    boardGrid[currentChar.x][currentChar.y].defenseModifier = boardGrid[currentChar.x][currentChar.y].defenseModifier + 1
            end
            for _, currentChar in ipairs(inactivePlayer.characters) do
                    boardGrid[currentChar.x][currentChar.y].attackModifier = boardGrid[currentChar.x][currentChar.y].attackModifier + 2
                    boardGrid[currentChar.x][currentChar.y].defenseModifier = boardGrid[currentChar.x][currentChar.y].defenseModifier + 1
            end


end
    

return Event043