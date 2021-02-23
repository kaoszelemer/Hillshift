local Event053 = Event:extend("Event053")

function Event053:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Backfire",
        53,
        "... my hands ...",
        "YOUR Characters Cells \nare on Fire",
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
        table.insert(sequenceBufferTable, {
            name = "glassfactoryevent",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                boardGrid[currentChar.x][currentChar.y].isOnFire = true
                boardGrid[currentChar.x][currentChar.y].fireTurn = turnCounter
                if boardGrid[currentChar.x][currentChar.y]:instanceOf(Forest) then
                    boardGrid[currentChar.x][currentChar.y] = BurntField(currentChar.x, currentChar.y)
                    boardGrid[currentChar.x][currentChar.y].isBurntField = true
                    boardGrid[currentChar.x][currentChar.y].burntFieldTimer = turnCounter
                end
                if boardGrid[currentChar.x][currentChar.y]:instanceOf(Lake) then
                    boardGrid[currentChar.x][currentChar.y] = Field(currentChar.x, currentChar.y)
                end
                if boardGrid[currentChar.x][currentChar.y]:instanceOf(Ice) then
                    boardGrid[currentChar.x][currentChar.y] = Lake(currentChar.x, currentChar.y)
                end
                if boardGrid[currentChar.x][currentChar.y]:instanceOf(Desert) then
                    boardGrid[currentChar.x][currentChar.y] = GlassMount(currentChar.x, currentChar.y)
                    boardGrid[currentChar.x][currentChar.y].isInstanced = true
                end
            end
        })

    end
    Cell:resetParticleDrawing()

end
    

return Event053