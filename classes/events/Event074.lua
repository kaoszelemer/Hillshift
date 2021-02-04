local Event074 = Event:extend("Event074")

function Event074:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "North Pole",
        74,
        "... santa is coming to town ...",
        "60 RND Cells are ICE",
        1
    )
end


function Event074:drawEventStuff()
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

function Event074:eventFunction()


   
    for x = 1, 10  do
        for y = 1,10 do

                rndCellX = love.math.random(1, 10)
                rndCellY = love.math.random(1, 10)

                boardGrid[rndCellX][rndCellY] = Ice(rndCellX, rndCellY)
        end
    end
end
    

return Event074