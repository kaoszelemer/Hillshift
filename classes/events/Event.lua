local Event = class("Event")

function Event:init(x, y, backgroundImage, image, name, id, flavorText, text, isGood)
    self.x = x
    self.y = y
    self.backgroundImage = backgroundImage
    self.image = image
    self.name = name
    self.id = id
    self.flavorText = flavorText
    text = text
    self.isGood = isGood
end

local function getEventID()
end



function drawEventOnBoard()

    love.graphics.draw(self.backgroundImage, width / 2 - offsetX / 2, height / 2 - offsetY / 2)
    love.graphics.draw(self.image, (width / 2 - offsetX / 2) + 76, (height / 2 - offsetY / 2) + 110)
    love.graphics.print(self.name, (width / 2 - offsetX / 2) + 56, (height / 2 - offsetY / 2) + 26)
    love.graphics.print(self.id, (width / 2 - offsetX / 2) + 270, (height / 2 - offsetY / 2) + 26)
    love.graphics.print(self.flavorText, (width / 2 - offsetX / 2) + 38, (height / 2 - offsetY / 2) + 276)
    love.graphics.print(self.text, (width / 2 - offsetX / 2) + 166, (height / 2 - offsetY / 2) + 104 )

end

function confirmEventWithClick(mx, my)

    if  mx > (width / 2 - offsetX / 2) + 302 and mx < (width / 2 - offsetX / 2) + 250 and
            my > (height / 2 - offsetY / 2) + 310 and my < ((width / 2 - offsetX / 2) + 260) then
       
        self:eventFunction()
        isDrawEventOnBoard = false
        stepCounter = 0

    end

end


return Event