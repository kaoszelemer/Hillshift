local Event033 = Event:extend("Event033")

function Event033:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Medium Flooding",
        33,
        "... that's too much water ...",
        "20 RND Cells\nare Lake",
        1
    )
end


function Event033:drawEventStuff()
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

function Event033:eventFunction()



    for x = 1, 20  do
        table.insert(sequenceBufferTable, {
            name = "mediumfloodingevent",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                rndCellX = love.math.random(1, 10)
                rndCellY = love.math.random(1, 10)

                boardGrid[rndCellX][rndCellY] = Lake(rndCellX, rndCellY)
            end
        })
    end


end
    

return Event033