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


        for y = 1, (love.math.random(1,100)) do
            rndCellX = love.math.random(1, 10)
            rndCellY = love.math.random(1, 10)
            if not boardGrid[rndCellX][rndCellY].isOnFire then boardGrid[rndCellX][rndCellY].isOnFire = true end
                if boardGrid[rndCellX][rndCellY]:instanceOf(Lake) then boardGrid[rndCellX][rndCellY] = Field(rndCellX, rndCellY) end
                if boardGrid[rndCellX][rndCellY]:instanceOf(Ice) then boardGrid[rndCellX][rndCellY] = Lake(rndCellX, rndCellY) end
                if boardGrid[rndCellX][rndCellY]:instanceOf(Forest) then 
                    boardGrid[rndCellX][rndCellY] = BurntField(rndCellX, rndCellY)
                    boardGrid[rndCellX][rndCellY].isBurntField = true
                    boardGrid[rndCellX][rndCellY].burntFieldTimer = turnCounter
                end
                if boardGrid[rndCellX][rndCellY]:instanceOf(Desert) then boardGrid[rndCellX][rndCellY] = GlassMount(rndCellX, rndCellY) end
    
                boardGrid[rndCellX][rndCellY].fireTurn = turnCounter
        end


end
    

return Event018