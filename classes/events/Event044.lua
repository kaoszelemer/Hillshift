local Event044 = Event:extend("Event044")

function Event044:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Friendly Wormholes",
        44,
        "... zip-zap 4x ...",
        "YOUR Characters teleports to RND Cell",
        1
    )
end


function Event044:drawEventStuff()
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

function Event044:eventFunction()


    for _, currentChar in ipairs(activePlayer.characters) do
            local rndCellX = randomFunction(1,10, "event44", "boardgrid")
            local rndCellY = randomFunction(1,10, "event44", "boardgrid")
            if not boardGrid[rndCellX][rndCellY].isOccupied then

            currentChar.stepPoints = currentChar.stepPoints + 1
            currentChar:move(rndCellX, rndCellY, currentChar.x, currentChar.y)
        end
    end


end
    

return Event044