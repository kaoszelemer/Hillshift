local Event017 = Event:extend("Event017")

function Event017:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Mushroom DNA",
        17,
        "... everywhere i step, there is a tree ...",
        "RND cells are Forests",
        1
    )
end


function Event017:drawEventStuff()
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

function Event017:eventFunction()


    for x = 1, (love.math.random(1, 100)) do
        table.insert(sequenceBufferTable, {
            name = "MushroomDNAEvent",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()

                rndCellX = love.math.random(1, 10)
                rndCellY = love.math.random(1, 10)
                boardGrid[rndCellX][rndCellY] = Forest(rndCellX, rndCellY)
                boardGrid[rndCellX][rndCellY].isInstanced = true
            end
        })
     
    end
    Cell:resetParticleDrawing()


end
    

return Event017