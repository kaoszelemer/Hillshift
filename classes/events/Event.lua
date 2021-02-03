local Event = class("Event")

function Event:init(image, name, id, flavorText, text, isGood)

    self.image = image
    self.name = name
    self.id = id
    self.flavorText = flavorText
    self.text = text
    self.isGood = isGood
end

function Event:initEventTable()

    table.insert(eventTable, Event001())

end

function Event:enableEvent()

    enableEvent = true

end

function Event:confirmEventWithClick()

    for index, event in ipairs(eventTable) do
        if event.enableDraw == true then
          event:eventFunction()
          event.enableDraw = false

        end
    end

  enableEvent = false

  




end

function Event:getNextEventID()

    local nextEventID = 1 -- love.math.random(1, események száma)
    return nextEventID

end

function Event:drawCurrentEvent()

    self.nextEventID = self:getNextEventID()

    if enableEvent then
        love.graphics.draw(eventBackgroundImage, width / 4 + offsetX, height / 4 + offsetY)
    

    for index, event in ipairs(eventTable) do

        if self.nextEventID == index then

            currentEvent = event
            currentEvent.enableDraw = true
            currentEvent:drawEventStuff()

        end

    end

    end


end




return Event