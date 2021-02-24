local Event035 = Event:extend("Event035")

function Event035:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Little Foresting",
        35,
        "... i like the shadow of trees ...",
        "10 RND Cells are Forest",
        1
    )
end


function Event035:drawEventStuff()
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

function Event035:eventFunction()


    for x = 1, 10  do
        table.insert(sequenceBufferTable, {
            name = "litforestingevent",
            duration = 0.3,
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
    

return Event035