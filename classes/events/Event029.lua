local Event029 = Event:extend("Event029")

function Event029:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event029image.png"),
        "Little Earthquake",
        29,
        "... we are in China ...",
        "20 RND Cells are Mount",
        1
    )
end


function Event029:drawEventStuff()
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

function Event029:eventFunction()


    for _, currentChar in ipairs(activePlayer.characters) do
        local rndCellX = love.math.random(1,10)
        local rndCellY = love.math.random(1,10)
        currentChar.stepPoints = currentChar.stepPoints + 1
        currentChar:move(rndCellX, rndCellY)
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        local rndCellX = love.math.random(1,10)
        local rndCellY = love.math.random(1,10)
        currentChar.stepPoints = currentChar.stepPoints + 1
        currentChar:move(rndCellX, rndCellY)
    end


end
    

return Event029