local Event048 = Event:extend("Event048")

function Event048:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Chaotic Chaos",
        48,
        "... Kaosz Elemer is the greatest ...",
        "RND Poison, RND Fire, RND Freeze",
        1
    )
end


function Event048:drawEventStuff()
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

function Event048:eventFunction()


    for i = 1, 16 do
        table.insert(sequenceBufferTable, {
            name = "chaoticchaoseventfirstmodifier",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()
                rndCellX = randomFunction(1, 10, "event48")
                rndCellY = randomFunction(1, 10, "event48")
                if not boardGrid[rndCellX][rndCellY].isPoisoned then
                    Poison:apply(rndCellX, rndCellY)
                end
            end
        })
    end
    for i = 1, 16 do
        table.insert(sequenceBufferTable, {
            name = "chaoticchaoseventsecondmodifier",
            duration = 1,
            sequenceTime = love.timer.getTime(),
            action = function()
                    rndCellX = randomFunction(1, 10, "event48")
                    rndCellY = randomFunction(1, 10, "event48")
                    if not boardGrid[rndCellX][rndCellY].isFrozen then
                        
                        Freeze:apply(rndCellX, rndCellY)
                    end
            end
        })

    end
    for i = 1, 16 do
        table.insert(sequenceBufferTable, {
            name = "chaoticchaoseventthirdmodifier",
            duration = 1.5,
            sequenceTime = love.timer.getTime(),
            action = function()

                
                if not boardGrid[rndCellX][rndCellY].isOnFire then
                    Burn:apply(rndCellX, rndCellY)
                end
            end
        })

    end

    Cell:resetParticleDrawing()


end
    

return Event048