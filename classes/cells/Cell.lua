local Cell = class("Cell")

function Cell:init(x, y, isWalkable, quad, attackModifier, defenseModifier, HP)
    self.x = x
    self.y = y
    self.isWalkable = isWalkable
    self.quad = quad
    self.attackModifier = attackModifier
    self.defenseModifier = defenseModifier
    self.HP = HP
    self.poisoningTurn = 0
    self.fireTurn = 0
    self.freezeTurn = 0
    self.burntFieldTimer = 0
    self.drawLightning = 0
end



function Cell:moveSelectedCharIfValidOffset(ox, oy)
    
    if ((selectedChar.x + ox <= 10 and selectedChar.x + ox >= 1) and (self.x == selectedChar.x + ox and self.y == selectedChar.y + oy)) or
       ((selectedChar.y + oy <= 10 and selectedChar.y + oy >= 1) and (self.y == selectedChar.y + oy and self.y == selectedChar.y + oy)) then
            if selectedChar.x + ox == self.x and
                selectedChar.y + oy == self.y then
                   

                    selectedChar:move(selectedChar.x + ox, selectedChar.y + oy, selectedChar.x, selectedChar.y)
                gameState:changeState(gameState.states.selectCharacter)

                table.insert(sequenceBufferTable, {
                    name = "glassfactoryevent",
                    duration = 0.7,
                    sequenceTime = love.timer.getTime(),
                    action = function()
                        if boardGrid[selectedChar.x][selectedChar.y]:instanceOf(Ice) then
                            self:iceSlide(selectedChar)
                        end
                     end
                })
              --[[   if boardGrid[selectedChar.x][selectedChar.y]:instanceOf(Ice) == false then
                    selectedChar.actionPoints = selectedChar.actionPoints + 1
                end ]]
                
            end
    end
      
end

function Cell:iceSlide(selectedChar)
end


function Cell:drawLightningOnBoard()
    for x = 1, 10 do
        for y = 1, 10 do
            if boardGrid[x][y].drawLightning == true then
                love.graphics.draw(lightningImage, boardGrid[x][y].x * tileW + offsetX, boardGrid[x][y].y * tileH + offsetY)
                love.graphics.setColor(selectedColor)
                love.graphics.setFont(font)
                if boardGrid[x][y]:instanceOf(Lake) and boardGrid[x][y].isOccupied then
                    love.graphics.print("-3", boardGrid[x][y].x * tileW + offsetX + 8, boardGrid[x][y].y * tileH + offsetY + 8)
                elseif boardGrid[x][y].isOccupied then
                    love.graphics.print("-1", boardGrid[x][y].x * tileW + offsetX + 8, boardGrid[x][y].y * tileH + offsetY + 8)
                end
                love.graphics.setColor(charColor)
                love.graphics.setFont(statFont)
            end
        end
    end


end


function Cell:click()


    if gameState.state == gameState.states.selectMoveTargetCell and selectedChar.isWalkable[self.class.name] and not self.isOccupied then
        for x = -1, 1 do
            for y = -1, 1 do
               if x ~= 0 or y ~= 0 then 
                
                    self:moveSelectedCharIfValidOffset(x, y)
                end
            end
        end   

    
    end
    if selectedChar and self.occupiedBy ~= selectedChar and gameState.state == gameState.states.selectSpellTargetArea then
            selectedChar:spell(self)
    end

end

function Cell:onEntry(character)

    if not character.hasItem then
        if self.isChest then
            player = character.parentPlayer
            character.hasItem = true
            Item:pickUpItem(character, player)
            self.isChest = false
            chestCounter = chestCounter - 1
        end
    end

end



return Cell