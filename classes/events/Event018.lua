local Event018 = Event:extend("Event018")

function Event018:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Flamethrower",
        18,
        "... MWHAHAHAHA ...",
        "RND Cells are on fire",
        0
    )
end


function Event018:drawEventStuff()
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

function Event018:eventFunction()


        for y = 1, (randomFunction(1,100, "event18")) do
            table.insert(sequenceBufferTable, {
                name = "FlameThroWErEvent",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()
    
                    local rndCellX = randomFunction(1, 10, "event18")
                    local rndCellY = randomFunction(1, 10, "event18")
                    if not boardGrid[rndCellX][rndCellY].isOnFire then Burn:apply(rndCellX, rndCellY) end

                        
                end})
        end

        Cell:resetParticleDrawing()
end
    

return Event018