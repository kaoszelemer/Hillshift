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
    --[[ table.insert(eventTable, Event002())
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
    --table.insert(eventTable, Event015())
    table.insert(eventTable, Event016())
    table.insert(eventTable, Event017())
    table.insert(eventTable, Event018())
    table.insert(eventTable, Event019())
    table.insert(eventTable, Event020())
    table.insert(eventTable, Event021())
    table.insert(eventTable, Event022())
    table.insert(eventTable, Event023())
    table.insert(eventTable, Event024())
    table.insert(eventTable, Event025())
    table.insert(eventTable, Event026())
    table.insert(eventTable, Event027())
    table.insert(eventTable, Event028())
    table.insert(eventTable, Event029())
    table.insert(eventTable, Event030())
    table.insert(eventTable, Event031())
    table.insert(eventTable, Event032())
    table.insert(eventTable, Event033())
    table.insert(eventTable, Event034())
    table.insert(eventTable, Event035())
    table.insert(eventTable, Event036())
    table.insert(eventTable, Event037())
    table.insert(eventTable, Event038())
    table.insert(eventTable, Event039())
    table.insert(eventTable, Event040())
    table.insert(eventTable, Event041())
    table.insert(eventTable, Event042())
    table.insert(eventTable, Event043())
    table.insert(eventTable, Event044())
    table.insert(eventTable, Event045())
    table.insert(eventTable, Event046())
    table.insert(eventTable, Event047())
    table.insert(eventTable, Event048())
    table.insert(eventTable, Event049())
    table.insert(eventTable, Event050())
    --table.insert(eventTable, Event051())
    --table.insert(eventTable, Event052())
    table.insert(eventTable, Event053())
    table.insert(eventTable, Event054())
    table.insert(eventTable, Event055())
    table.insert(eventTable, Event056())
    table.insert(eventTable, Event057())
    table.insert(eventTable, Event058())
    table.insert(eventTable, Event059())
    table.insert(eventTable, Event061())
    table.insert(eventTable, Event062())
    table.insert(eventTable, Event063())
    table.insert(eventTable, Event064())
    table.insert(eventTable, Event065())
    table.insert(eventTable, Event066())
    table.insert(eventTable, Event067())
    table.insert(eventTable, Event068())
    table.insert(eventTable, Event069())
    table.insert(eventTable, Event071())
    table.insert(eventTable, Event072())
    table.insert(eventTable, Event073())
    table.insert(eventTable, Event074())
    table.insert(eventTable, Event075()) ]]
    
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
  eventTurnCounter = 0

  




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