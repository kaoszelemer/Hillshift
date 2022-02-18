local Event062 = Event:extend("Event062")

function Event062:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "Enemy Refrigerator",
        62,
        "... the light is coming from the cold ...",
        "ENEMY Characters Cells are Frozen",
        1
    )
end


function Event062:drawEventStuff()
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

function Event062:eventFunction()


    for _, currentChar in ipairs(inactivePlayer.characters) do
        table.insert(sequenceBufferTable, {
            name = "glassfactoryevent",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                
                Freeze:apply(currentChar.x, currentChar.y)
              
            end
        })
    end

    Cell:resetParticleDrawing()

end
    

return Event062