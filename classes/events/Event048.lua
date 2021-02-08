local Event048 = Event:extend("Event048")

function Event048:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Chaotic Chaos",
        48,
        "... Kaosz Elemer is the greatest ...",
        "RND Poison, \nRND Fire, \nRND Freeze",
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


    for i = 1, 8 do
            rndCellX = love.math.random(1, 10)
            rndCellY = love.math.random(1, 10)
            if not boardGrid[rndCellX][rndCellY].isPoisoned then
                boardGrid[rndCellX][rndCellY].isPoisoned = true
                boardGrid[rndCellX][rndCellY].poisoningTurn = turnCounter
            end
    end
    for i = 1, 8 do
            rndCellX = love.math.random(1, 10)
            rndCellY = love.math.random(1, 10)
            if boardGrid[rndCellX][rndCellY]:instanceOf(Lake) then boardGrid[rndCellX][rndCellY] = Ice(rndCellX, rndCellY) end
            if not boardGrid[rndCellX][rndCellY].isFrozen then
                boardGrid[rndCellX][rndCellY].isFrozen = true
                boardGrid[rndCellX][rndCellY].freezeTurn = turnCounter
            end
    end
    for i = 1, 8 do
            rndCellX = love.math.random(1, 10)
            rndCellY = love.math.random(1, 10)
            if boardGrid[rndCellX][rndCellY].isFrozen then boardGrid[rndCellX][rndCellY].isFrozen = false end  
            if boardGrid[rndCellX][rndCellY]:instanceOf(Lake) then boardGrid[rndCellX][rndCellY] = Field(rndCellX, rndCellY) end
            if boardGrid[rndCellX][rndCellY]:instanceOf(Ice) then boardGrid[rndCellX][rndCellY] = Lake(rndCellX, rndCellY) end
            if boardGrid[rndCellX][rndCellY]:instanceOf(Forest) then boardGrid[rndCellX][rndCellY] = BurntField(rndCellX, rndCellY) end
            if not boardGrid[rndCellX][rndCellY].isOnFire then 
                boardGrid[rndCellX][rndCellY].isOnFire = true 
                boardGrid[rndCellX][rndCellY].burntFieldTimer = turnCounter
                boardGrid[rndCellX][rndCellY].fireTurn = turnCounter
            end
    end




end
    

return Event048