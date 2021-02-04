local Event005 = Event:extend("Event005")

function Event005:init()
    Event.init(self,
        love.graphics.newImage("/graphics/event005image.png"),
        "Sudden Death",
        5,
        "... sometimes it's too quick ...",
        "RND enemy HP is 1",
        0
    )
end


function Event005:drawEventStuff()
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

function Event005:eventFunction()

    local randomEnemyIndex = love.math.random(1, #inactivePlayer.characters)

    for index, currentChar in ipairs(inactivePlayer.characters) do

        if index == randomEnemyIndex then
            currentChar.baseHP = 1
        end

    end




end
    

return Event005