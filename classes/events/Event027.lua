local Event027 = Event:extend("Event027")

function Event027:init()
    Event.init(self,
        love.graphics.newImage("/graphics/Event014image.png"),
        "BrokenFaceBoying",
        27,
        "... odaig kuszott ...",
        "One of YOUR \nCharacter moves\nY+2 or Y-2",
        1
    )
end


function Event027:drawEventStuff()
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

function Event027:eventFunction()

    if activePlayer == playerOne then
        local randomChar = randomFunction(1,#activePlayer.characters, "event27")

        for i, currentChar in ipairs(activePlayer.characters) do

            if i == randomChar then
                

                if currentChar.y + 2 <= 10 and not boardGrid[currentChar.x][currentChar.y + 2].isOccupied then 
                    
                    currentChar.stepPoints = currentChar.stepPoints + 1
                    currentChar:move(currentChar.x, currentChar.y + 2, currentChar.x, currentChar.y)
                    

                elseif currentChar.y + 1 <= 10 and not boardGrid[currentChar.x][currentChar.y + 1].isOccupied then 
                    
                    currentChar.stepPoints = currentChar.stepPoints + 1
                    currentChar:move(currentChar.x, currentChar.y + 1, currentChar.x, currentChar.y)

                end
            end
                
        end

    else

        for i, currentChar in ipairs(activePlayer.characters) do

            if i == randomChar then
               
                if currentChar.y - 2 > 0 and not boardGrid[currentChar.x][currentChar.y - 2].isOccupied  then 
                    currentChar.stepPoints = currentChar.stepPoints + 1
                    currentChar:move(currentChar.x, currentChar.y - 2, currentChar.x, currentChar.y)
                elseif currentChar.y - 1 > 0 and not boardGrid[currentChar.x][currentChar.y - 1].isOccupied then 
                    currentChar.stepPoints = currentChar.stepPoints + 1
                    currentChar:move(currentChar.x, currentChar.y - 1, currentChar.x, currentChar.y)
                end
            end

        end

    end

end
    

return Event027