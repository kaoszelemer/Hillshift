local Event015 = Event:extend("Event015")

function Event015:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Alchemistry",
        15,
        "... that wasn't placebo ...",
        "RND Cells \nare poisoned",
        0
    )
end


function Event015:drawEventStuff()
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

function Event015:eventFunction()

    for x = 1, (randomFunction(1, 100, "event15")) do
        table.insert(sequenceBufferTable, {
            name = "AlchemistryEvent",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()

                rndCellX = randomFunction(1, 10, "event15")
                rndCellY = randomFunction(1, 10, "event15")
                if not boardGrid[rndCellX][rndCellY].isPoisoned then 
                    boardGrid[rndCellX][rndCellY].isPoisoned = true
                    boardGrid[rndCellX][rndCellY].poisoningTurn = turnCounter
                end
            end
        })
    end


end
    

return Event015