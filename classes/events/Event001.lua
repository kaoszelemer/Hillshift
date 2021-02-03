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


local function eventFunction()

    for x = 1, 10 do
        for y = 1, 10 do

            boardGrid[x][y].isOnFire = true

        end
    end




end
    

return Event001