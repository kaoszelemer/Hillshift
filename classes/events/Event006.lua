local Event006 = Event:extend("Event006")

function Event006:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event006image.png"),
        "Ice Age",
        6,
        "... brr, i'm freezing ...",
        "RND Cell are Frozen,\nall fires are out",
        0
    )
end


function Event006:drawEventStuff()
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

function Event006:eventFunction()

   

    for x = 1, 40 do
            rndCellX = love.math.random(1, 10)
            rndCellY = love.math.random(1, 10)
            
            if boardGrid[rndCellX][rndCellY]:instanceOf(Lake) then 
                boardGrid[rndCellX][rndCellY] = Ice(rndCellX, rndCellY) 
                boardGrid[rndCellX][rndCellY].isInstanced = true
            end

            if not boardGrid[rndCellX][rndCellY].isFrozen then 
                boardGrid[rndCellX][rndCellY].isFrozen = true
                boardGrid[rndCellX][rndCellY].freezeTurn = turnCounter
            end

            if boardGrid[rndCellX][rndCellY]:instanceOf(Ice) then
                boardGrid[rndCellX][rndCellY].isFrozen = false
            end
    end


    for x = 1, 10 do
        for y = 1, 10 do
            boardGrid[x][y].isOnFire = false
        end
    end

    Cell:resetParticleDrawing()


end
    

return Event006