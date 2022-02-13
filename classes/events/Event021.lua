local Event021 = Event:extend("Event021")

function Event021:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "It's a kinda",
        21,
        "... magiiiiiiiic ...",
        "A few Forests are Magic Forests",
        1
    )
end


function Event021:drawEventStuff()
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

function Event021:eventFunction()


    for x = 1, 100 do
        table.insert(sequenceBufferTable, {
            name = "magicForestEvent",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()

                local chance = randomFunction(nil, nil, "event21")
                rndCellX = randomFunction(1, 10, "event21")
                rndCellY = randomFunction(1, 10, "event21")
                if chance < 0.2 and boardGrid[rndCellX][rndCellY]:instanceOf(Forest) then
                     boardGrid[rndCellX][rndCellY] = MagicForest(rndCellX, rndCellY)
                     boardGrid[rndCellX][rndCellY].isInstanced = true
                end
            end
        })
    end

    Cell:resetParticleDrawing()

end
    

return Event021