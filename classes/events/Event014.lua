local Event014 = Event:extend("Event014")

function Event014:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event014image.png"),
        "Teleport",
        14,
        "... when you drink so much ...",
        "ALL Characters teleports to RND Cell",
        1
    )
end


function Event014:drawEventStuff()
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

function Event014:eventFunction()


    for _, currentChar in ipairs(activePlayer.characters) do
        table.insert(sequenceBufferTable, {
            name = "TelePortEventActivePlayer",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()

                local rndCellX = randomFunction(1,10, "event14")
                local rndCellY = randomFunction(1,10, "event14")
                if not boardGrid[rndCellX][rndCellY].isOccupied then
                    currentChar.stepPoints = currentChar.stepPoints + 1
                    currentChar:move(rndCellX, rndCellY, currentChar.x, currentChar.y)
                end
            end
        })
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        table.insert(sequenceBufferTable, {
            name = "TelePortEventinActivePlayer",
            duration = 1,
            sequenceTime = love.timer.getTime(),
            action = function()
                local rndCellX = randomFunction(1,10, "event14")
                local rndCellY = randomFunction(1,10, "event14")
                if not boardGrid[rndCellX][rndCellY].isOccupied then
                        currentChar.stepPoints = currentChar.stepPoints + 1
                        currentChar:move(rndCellX, rndCellY, currentChar.x, currentChar.y)
                end
            end
        })
    end


end
    

return Event014