local Event046 = Event:extend("Event046")

function Event046:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "The Burning",
        46,
        "... the smell of napalm ...",
        "ALL forests are \nBurnt fields",
        1
    )
end


function Event046:drawEventStuff()
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

function Event046:eventFunction()


   for x = 1, 10 do
        for y = 1, 10 do
            table.insert(sequenceBufferTable, {
                name = "theBurningevent",
                duration = 0.3,
                sequenceTime = love.timer.getTime(),
                action = function()
                    if boardGrid[x][y]:instanceOf(Forest) then boardGrid[x][y] = BurntField(x, y) end
                    if boardGrid[x][y]:instanceOf(BurntField) then 
                        boardGrid[x][y].burntFieldTimer = turnCounter 
                        boardGrid[x][y].isBurntField = true
                    end
                end
            })
        end
    end


end
    

return Event046