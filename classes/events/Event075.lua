local Event075 = Event:extend("Event075")

function Event075:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Next Turn",
        75,
        "... right now? ...",
        "Next turn inititated.",
        1
    )
end


function Event075:drawEventStuff()
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

function Event075:eventFunction()
    table.insert(sequenceBufferTable, {
        name = "glassfactoryevent",
        duration = 0.3,
        sequenceTime = love.timer.getTime(),
        action = function()
            endTurn()    
        end
    })
end
    

return Event075