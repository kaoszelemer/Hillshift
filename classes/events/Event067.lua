local Event067 = Event:extend("Event067")

function Event067:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Landslide",
        67,
        "... tony howk's pro slider ...",
        "all Cells are Mounts",
        1
    )
end


function Event067:drawEventStuff()
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

function Event067:eventFunction()
local newX
local newY
    for x = 1, 10 do
        for y = 1, 10 do
            oldx = boardGrid[x][y].x

            boardGrid[x][y] = Mount(x, y)

        end
    end

  


end
    

return Event067