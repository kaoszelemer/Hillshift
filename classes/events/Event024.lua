local Event024 = Event:extend("Event024")

function Event024:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Nasty Wormhole",
        24,
        "... where you are? ...",
        "enemy RND Char \nteleports to RND Cell",
        1
    )
end


function Event024:drawEventStuff()
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

function Event024:eventFunction()

    local randomChar = love.math.random(1, #inactivePlayer.characters)

    for index, currentChar in ipairs(inactivePlayer.characters) do
        if randomChar == index then
                local rndCellX = love.math.random(1,10)
                local rndCellY = love.math.random(1,10)
            if not boardGrid[rndCellX][rndCellY].isOccupied then
                currentChar.stepPoints = currentChar.stepPoints + 1
                currentChar:move(rndCellX, rndCellY)
            end
        end
    end


end
    

return Event024