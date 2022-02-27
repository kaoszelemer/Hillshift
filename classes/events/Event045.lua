local Event045 = Event:extend("Event045")

function Event045:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Nasty Wormholes",
        45,
        "... couldn't you find a more disgusting name ...",
        "ENEMY Characters teleports to RND Cell",
        1
    )
end


function Event045:drawEventStuff()
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

function Event045:eventFunction()


    for _, currentChar in ipairs(inactivePlayer.characters) do
            local rndCellX = randomFunction(1,10, "event45", "boardgrid")
            local rndCellY = randomFunction(1,10, "event45", "boardgrid")
            if not boardGrid[rndCellX][rndCellY].isOccupied then
            currentChar.stepPoints = currentChar.stepPoints + 1
            currentChar:move(rndCellX, rndCellY, currentChar.x, currentChar.y)
        end
    end


end
    

return Event045