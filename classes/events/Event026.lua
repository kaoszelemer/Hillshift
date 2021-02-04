local Event026 = Event:extend("Event026")

function Event026:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Dehydration",
        26,
        "... my throat is like sand ...",
        "All Lakes are Fields",
        1
    )
end


function Event026:drawEventStuff()
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

function Event026:eventFunction()


    for x = 1, 10 do
        for y = 1,10 do
            if boardGrid[x][y]:instanceOf(Lake) then boardGrid[x][y] = Field(x, y) end
        end
    end


end
    

return Event026