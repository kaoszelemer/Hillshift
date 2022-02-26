local Event005 = Event:extend("Event005")

function Event005:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event005image.png"),
        "Desertification",
        5,
        "... sandwitch is the greatest joke...",
        "RND Cells are Deserts",
        0
    )
end


function Event005:drawEventStuff()
if self.enableDraw then
        love.graphics.setFont(statFont)
        love.graphics.draw(self.image, width / 4 + offsetX + 76, height / 4 + offsetY + 110)
        love.graphics.print(self.name, width / 4 + offsetX + 56, height / 4 + offsetY + 26)
        love.graphics.print(self.id, width / 4 + offsetX + 270, height / 4 + offsetY + 26)
        love.graphics.print(self.flavorText, width / 4 + offsetX + 38, height / 4 + offsetY + 276)
        love.graphics.print(self.text, width / 4 + offsetX + 166, height / 4 + offsetY + 104)
        love.graphics.setFont(actionMenuFont)
end

end

function Event005:eventFunction()

    for x = 1, (randomFunction(1, 100, "armageddon event", turnCounter, self.id, #activePlayer.characters, #inactivePlayer.characters)) do
        table.insert(sequenceBufferTable, {
            name = "DesertificationEvent",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()

                rndCellX = randomFunction(1, 10, "armageddon evenet", turnCounter, x, #activePlayer.characters, inactivePlayer.characters)
                rndCellY = randomFunction(1, 10, "armageddon eveent", rndCellX, turnCounter, x, #activePlayer.characters)
                if boardGrid[rndCellX][rndCellY]:instanceOf(Lake) then boardGrid[rndCellX][rndCellY] = Swamp(rndCellX, rndCellY)
                elseif boardGrid[rndCellX][rndCellY].isOnFire then
                     boardGrid[rndCellX][rndCellY] = GlassMount(rndCellX, rndCellY)
                     boardGrid[rndCellX][rndCellY].isInstanced = true             
                else boardGrid[rndCellX][rndCellY] = Desert(rndCellX, rndCellY)
                    boardGrid[rndCellX][rndCellY].isInstanced = true
                end
                
            end
        })
    end

    Cell:resetParticleDrawing()


end
    

return Event005