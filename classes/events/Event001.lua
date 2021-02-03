local Event001 = Event:extend("Event001")

function Event001:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event001image.png"),
        "Armageddon",
        1,
        "... burn, burn, burn ...",
        "All cellls are on fire.",
        0
    )
end


function Event001:drawEventStuff()
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

function Event001:eventFunction()



    for x = 1, 10 do
        for y = 1, 10 do

            boardGrid[x][y].isOnFire = true
            fireTurn = turnCounter
           

        end
    end



end
    

return Event001