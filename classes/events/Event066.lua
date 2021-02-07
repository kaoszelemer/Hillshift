local Event066 = Event:extend("Event066")

function Event066:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Enemy Peaseants Holiday",
        66,
        "... reapers digest ...",
        "ENEMY Characters Cells \nare Fields",
        1
    )
end


function Event066:drawEventStuff()
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

function Event066:eventFunction()


    for _, currentChar in ipairs(inactivePlayer.characters) do
        boardGrid[currentChar.x][currentChar.y] = Field(currentChar.x, currentChar.y)
    end


end
    

return Event066