local Event056 = Event:extend("Event056")

function Event056:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event056image.png"),
        "Pool Building",
        56,
        "... we gonna need some rubber boots ...",
        "YOUR Characters Cells are Lakes",
        1
    )
end


function Event056:drawEventStuff()
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

function Event056:eventFunction()


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
    

return Event056