local Event001 = Event:extend("Event001")

function Event001:init(x, y)
    Event.init(self,
        love.graphics.newImage("eventbackgroundimage.png"),
        love.graphics.newImage("event001image.png"),
        "Armageddon",
        1,
        "... burn, burn, burn ...",
        "All cellls are on fire.",
        0
    )
end

function drawEventOnBoard()

    love.graphics.draw(self.backgroundImage, width / 2 - offsetX / 2, height / 2 - offsetY / 2)
    love.graphics.draw(self.image, (width / 2 - offsetX / 2) + 76, (height / 2 - offsetY / 2) + 110)
    love.graphics.print(self.name, (width / 2 - offsetX / 2) + 56, (height / 2 - offsetY / 2) + 26)
    love.graphics.print(self.id, (width / 2 - offsetX / 2) + 270, (height / 2 - offsetY / 2) + 26)
    love.graphics.print(self.flavorText, (width / 2 - offsetX / 2) + 38, (height / 2 - offsetY / 2) + 276)
    love.graphics.print(self.text, (width / 2 - offsetX / 2) + 166, (height / 2 - offsetY / 2) + 104 )

end

function confirmEventWithClick(mx, my)

    if  mx > (width / 2 - offsetX / 2) + 302 and mx < (width / 2 - offsetX / 2) + 250 and
            my > (height / 2 - offsetY / 2) + 310 and my < ((width / 2 - offsetX / 2) + 260) then
       
        self:burnAllCells()
        isDrawEventOnBoard = false

    end

end

local function burnAllCells()

    for x = 1, 10 do
        for y = 1, 10 do

            boardGrid[x][y].isOnFire = true

        end
    end




end
    

return Event001