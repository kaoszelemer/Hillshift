local Event034 = Event:extend("Event034")

function Event034:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Great Flooding",
        34,
        "... no, i said thats enough water ...",
        "30 RND Cells are Lake",
        1
    )
end


function Event034:drawEventStuff()
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

function Event034:eventFunction()


 
    for x = 1, 30  do
        table.insert(sequenceBufferTable, {
            name = "greatfloodingevent",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                rndCellX = randomFunction(1, 10, "event34", "boardgrid")
                rndCellY = randomFunction(1, 10, "event34", "boardgrid")

                boardGrid[rndCellX][rndCellY] = Lake(rndCellX, rndCellY)
                boardGrid[rndCellX][rndCellY].isInstanced = true
            end
        })
    end

    Cell:resetParticleDrawing()

end
    

return Event034