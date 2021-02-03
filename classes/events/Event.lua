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
    table.insert(eventTable, Event002())
    table.insert(eventTable, Event003())
    table.insert(eventTable, Event004())
    table.insert(eventTable, Event005())
    table.insert(eventTable, Event006())
    table.insert(eventTable, Event007())
    table.insert(eventTable, Event008())
    table.insert(eventTable, Event009())
    table.insert(eventTable, Event010())
    table.insert(eventTable, Event011())
    table.insert(eventTable, Event012())
    table.insert(eventTable, Event013())
    table.insert(eventTable, Event014())




end

function Event:enableEvent()

    enableEvent = true
    self.nextEventID = self:getNextEventID()


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

    local nextEventID = love.math.random(1, #eventTable)
    return nextEventID

end

function Event:drawCurrentEvent()
  

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