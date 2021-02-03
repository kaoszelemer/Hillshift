local Event011 = Event:extend("Event011")

function Event011:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event001image.png"),
        "Purity",
        11,
        "... use handcrafted soap only ...",
        "ALL Cells are unpoisoned",
        1
    )
end


function Event011:drawEventStuff()
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

function Event011:eventFunction()


    for x = 1, 10 do
        for y = 1, 10 do

            boardGrid[x][y].isPoisoned = false           

        end
    end


end
    

return Event011