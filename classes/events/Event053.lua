local Event053 = Event:extend("Event053")

function Event053:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Backfire",
        53,
        "... my hands ...",
        "YOUR Characters Cells are on Fire",
        1
    )
end


function Event053:drawEventStuff()
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

function Event053:eventFunction()


    for _, currentChar in ipairs(activePlayer.characters) do
        boardGrid[currentChar.x][currentChar.y].isOnFire = true
        fireTurn = turnCounter
    end


end
    

return Event053