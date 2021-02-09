local Event063 = Event:extend("Event063")

function Event063:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Enemy Pool Building",
        63,
        "... you'll need rubber boots ...",
        "ENEMY Characters Cells \nare Lakes",
        1
    )
end


function Event063:drawEventStuff()
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

function Event063:eventFunction()


    for _, currentChar in ipairs(inactivePlayer.characters) do
        boardGrid[currentChar.x][currentChar.y] = Lake(currentChar.x, currentChar.y)
    end


end
    

return Event063