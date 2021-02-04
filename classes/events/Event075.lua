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
    turnCounter = turnCounter + 1
    oldPlayer = activePlayer
    activePlayer = inactivePlayer
    inactivePlayer = oldPlayer
    local burnCell

        ----------- EZ TÖRTÉNIK A BOARDDAL ------------------
    for index, row in ipairs(boardGrid) do
        for _, cell in ipairs(row) do

            if cell.isPoisoned and turnCounter - poisoningTurn == 3 then
                cell.isPoisoned = false
                cell.defenseModifier = cell.defenseModifier + 3
                cell.attackModifier = cell.attackModifier + 1
            end

            if cell.isOnFire and turnCounter - fireTurn == 3 then
               cell.isOnFire = false
            end

            if cell.isFrozen and turnCounter - freezeTurn == 3 then
                cell.isFrozen = false
            end
        
            if cell.isOnFire and cell:instanceOf(Forest) then
                if boardGrid[cell.x][cell.y].isOnFire then burnCell = true end
                boardGrid[cell.x][cell.y] = Field(cell.x, cell.y)
                if burnCell then boardGrid[cell.x][cell.y].isOnFire = true end
            end

        end
    end
  
        ----------- EZ TÖRTÉNIK AZ INAKTÍVPLAYERREL (MERT Ő VOLT A RÉGI JÁTÉKOS) ------------------

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar.stepPoints = 1
        currentChar.actionPoints = 1
        if currentChar.stepPointModify then 
            currentChar.stepPoints = currentChar.stepPoints + currentChar.stepPointModifier 
            currentChar.stepPointModify = false
        end
        if currentChar.actionPointModify then 
            currentChar.actionPoints = currentChar.actionPoints + currentChar.actionPointModifier 
            currentChar.actionPointModify = false
        end
        local cell = boardGrid[currentChar.x][currentChar.y]

        if cell.isFrozen then
            currentChar.stepPoints = 0
        elseif cell.isOnFire then
            currentChar.baseHP = currentChar.baseHP - 2
        elseif cell.isPoisoned then
            cell.defenseModifier = cell.defenseModifier - 3
            cell.attackModifier = cell.attackModifier - 1
        elseif cell:instanceOf(Lake) then
            currentChar.actionPoints = 0
        end
        if currentChar.baseHP <= 0 then currentChar:kill() end
      
    end


            ----------- EZ TÖRTÉNIK AZ AKTÍVPLAYERREL MERT Ő AZ ÚJ JÁTÉKOS ------------------


    for _, currentChar in ipairs(activePlayer.characters) do
        if currentChar.stepPointModify then 
            currentChar.stepPoints = currentChar.stepPoints + currentChar.stepPointModifier 
            currentChar.stepPointModify = false
        end
        if currentChar.actionPointModify then 
            currentChar.actionPoints = currentChar.actionPoints + currentChar.actionPointModifier 
            currentChar.actionPointModify = false
        end
        local cell = boardGrid[currentChar.x][currentChar.y]
        if cell.isFrozen then
            currentChar.stepPoints = 0
        elseif cell.isOnFire then
            currentChar.baseHP = currentChar.baseHP - 2
        elseif cell.isPoisoned then
            cell.defenseModifier = cell.defenseModifier - 3
            cell.attackModifier  = cell.attackModifier - 1
        elseif cell:instanceOf(Lake) then
            currentChar.actionPoints = 0
        end

        if currentChar.baseHP <= 0 then currentChar:kill() end

        board:resetAllCharacterStates(activePlayer, inactivePlayer)

    end

    


end
    

return Event075