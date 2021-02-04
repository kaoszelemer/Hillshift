local Event022 = Event:extend("Event022")

function Event022:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event022image.png"),
        "Start Over",
        22,
        "... tabula rasa ...",
        "First turn again",
        1
    )
end


function Event022:drawEventStuff()
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

function Event022:eventFunction()


  turnCounter = 0
  stepCounter = stepCounter - nextTurnBeforeEvent
  fireTurn = 0
  freezeTurn = 0
  poisoningTurn = 0

  for _, currentChar in ipairs(activePlayer.characters) do
    currentChar.stepPoints = currentChar.stepPoints + 1
    if currentChar.id == 1 then
      currentChar:move(5, 1)
    end
    if currentChar.id == 2 then
      currentChar:move(5, 2)
    end
    if currentChar.id == 3 then
      currentChar:move(6, 1)
    end
    if currentChar.id == 4 then
      currentChar:move(6, 2)
    end

end

for _, currentChar in ipairs(inactivePlayer.characters) do
    currentChar.stepPoints = currentChar.stepPoints + 1

    if currentChar.id == 1 then
      currentChar:move(5, 9)
    end
    if currentChar.id == 2 then
      currentChar:move(5, 10)
    end
    if currentChar.id == 3 then
      currentChar:move(6, 9)
    end
    if currentChar.id == 4 then
      currentChar:move(6, 10)
    end
end

for x = 1, 10 do
  for y = 1,10 do
      if boardGrid[x][y].isPoisoned then boardGrid[x][y].isPoisoned = false end
        boardGrid[x][y].isOnFire then boardGrid[x][y].isOnFire = false end
        boardGrid[x][y].isFrozen then boardGrid[x][y].isFrozen = false end
         

      
  end
end
  
  

    



end
    

return Event022