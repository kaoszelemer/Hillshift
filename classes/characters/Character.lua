local Character = class("Character")

function Character:init(baseHP, baseDefense, baseAttack, id, image, idleAnimImage, imageHover, sinkImage, sinkImageHover, parentPlayer, actionPoints, stepPoints, turnAttackModifier, turnDefenseModifier, defenseCounter, defenseState)
    self.baseHP = baseHP
    self.baseDefense = baseDefense
    self.baseAttack = baseAttack
    self.id = id
    self.image = image
    self.idleAnimImage = idleAnimImage
    self.imageHover = imageHover
    self.sinkImage = sinkImage
    self.sinkImageHover = sinkImageHover
    self.parentPlayer = parentPlayer
    self.actionPoints = actionPoints
    self.stepPoints = stepPoints
    self.turnAttackModifier = turnAttackModifier
    self.turnDefenseModifier = turnDefenseModifier
    self.defenseCounter = defenseCounter
    self.defenseState = defenseState
    self.isWalkable = {
        Forest = true,
        Mount = true,
        Field = true,
        Ice = true,
        BurntField = true,
        MagicForest = true,
        Desert = true,
        Swamp = true,
        GlassMount = true,
    }

   

end

function Character:load()

   

end

function Character:update(dt)

    if drawAttack and love.timer.getTime() - timerStart >= timerStop then
        drawAttack = false
    end

    if drawAttackAnim and love.timer.getTime() - animTimer >= animStop then
        drawAttackAnim = false
    end

    attackAnimation:update(dt)
    
end

function Character:draw()
    local x = self.x * tileW + offsetX
    local y = self.y * tileH + offsetY
    
   --[[  if     boardGrid[self.x][self.y]:instanceOf(Lake) then love.graphics.draw(self.sinkImage, x, y)
    elseif boardGrid[self.x][self.y]:instanceOf(Lake) and self.isHovered then love.graphics.draw(self.sinkImageHover, x, y)
    elseif self.isHovered == true then love.graphics.draw(self.imageHover, x, y)
    else   love.graphics.draw(self.image, x, y)
    end ]]
    
    self.animation:draw(self.idleAnimImage, x,y)
    
    if gameState.state == gameState.states.selectCharacterAction then
        local x = selectedChar.x * tileW + offsetX
        local y = selectedChar.y * tileH + offsetY
        if selectedChar.actionPoints ~= 0 then love.graphics.draw(attackIcon, x, y) end
        if selectedChar.stepPoints ~= 0 then love.graphics.draw(moveIcon, x + (tileW - tileW / 2), y) end
        if selectedChar.actionPoints ~= 0 then love.graphics.draw(spellIcon, x, y + (tileH - tileH / 2)) end
    end

end

function Character:drawCancelButton()
            
            if gameState.state == gameState.states.selectMoveTargetCell or gameState.state == gameState.states.selectAttackTargetCharacter or gameState.state == gameState.states.selectSpellTargetArea then
                isCancelButton = true
                love.graphics.draw(cancelButtonImage, (selectedChar.x * tileW + offsetX) + tileW / 6, (selectedChar.y * tileH + offsetY) + tileH / 6)
            end

end

function Character:drawHealthBar()

    

    for _, currentChar in ipairs(activePlayer.characters) do
            local healthBarMaxWidth = 0.3
            local healthBarWidth = healthBarMaxWidth * currentChar.baseHP
            love.graphics.setColor(charColor)
            love.graphics.rectangle("line", 5 + currentChar.x * tileW + offsetX, currentChar.y * tileH + offsetY, healthBarWidth + 1, 8)

            if healthBarWidth < 10 then
                love.graphics.setColor(selectedColor)
                love.graphics.rectangle("fill", 6 + currentChar.x * tileW + offsetX, currentChar.y * tileH + offsetY, healthBarWidth, 7)
                love.graphics.setColor(charColor)
            else 
                love.graphics.setColor(greenColor)
                love.graphics.rectangle("fill", 6 + currentChar.x * tileW + offsetX, currentChar.y * tileH + offsetY, healthBarWidth, 7)
                love.graphics.setColor(charColor) 
            end
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
            local healthBarMaxWidth = 0.3
            local healthBarWidth = healthBarMaxWidth * currentChar.baseHP
            love.graphics.setColor(charColor)
            love.graphics.rectangle("line", 5 + currentChar.x * tileW + offsetX, currentChar.y * tileH + offsetY, healthBarWidth + 1, 8)
            if healthBarWidth < 10 then
                love.graphics.setColor(selectedColor)
                love.graphics.rectangle("fill", 6 + currentChar.x * tileW + offsetX, currentChar.y * tileH + offsetY, healthBarWidth, 7)
                love.graphics.setColor(charColor)
            else
                love.graphics.setColor(greenColor)
                love.graphics.rectangle("fill", 6 + currentChar.x * tileW + offsetX, currentChar.y * tileH + offsetY, healthBarWidth, 7)
                love.graphics.setColor(charColor) 
            end
    end

    


end

function Character:drawAttackAnimation()
    if drawAttackAnim then 

            if drawnAttackingCharacter.x == drawnEnemyCharacter.x and drawnAttackingCharacter.y + 1 == drawnEnemyCharacter.y  then
                self.drawAttackAnimBottom = true
            end

            if drawnAttackingCharacter.x == drawnEnemyCharacter.x and drawnAttackingCharacter.y - 1 == drawnEnemyCharacter.y  then
                self.drawAttackAnimTop = true
            end

            if drawnAttackingCharacter.x == drawnEnemyCharacter.x + 1 and drawnAttackingCharacter.y == drawnEnemyCharacter.y  then
                self.drawAttackAnimLeft = true
            end

            if drawnAttackingCharacter.x == drawnEnemyCharacter.x - 1 and drawnAttackingCharacter.y == drawnEnemyCharacter.y  then
                self.drawAttackAnimRight = true
            end

            if drawnAttackingCharacter.x == drawnEnemyCharacter.x - 1 and drawnAttackingCharacter.y - 1 == drawnEnemyCharacter.y  then
                self.drawAttackAnimTopRight = true
            end

            if drawnAttackingCharacter.x == drawnEnemyCharacter.x + 1 and drawnAttackingCharacter.y - 1 == drawnEnemyCharacter.y  then
                self.drawAttackAnimTopLeft = true
            end

            if drawnAttackingCharacter.x == drawnEnemyCharacter.x - 1 and drawnAttackingCharacter.y + 1 == drawnEnemyCharacter.y  then
                self.drawAttackAnimBottomRight = true
            end

            if drawnAttackingCharacter.x == drawnEnemyCharacter.x + 1 and drawnAttackingCharacter.y + 1 == drawnEnemyCharacter.y  then
                self.drawAttackAnimBottomLeft = true
            end

            if self.drawAttackAnimBottom then
                attackAnimation:draw(attackAnimationImage, drawnAttackingCharacter.x * tileW + offsetX, (drawnAttackingCharacter.y * tileH + offsetY) + tileH)
                love.graphics.draw(bloodParticleSystem, (drawnEnemyCharacter.x * tileW + offsetX) + tileW / 2, (drawnEnemyCharacter.y * tileH + offsetY) + tileH / 2) 
                bloodParticleSystem:emit(2000)
                self.drawAttackAnimBottom = false
            end

            if self.drawAttackAnimTop then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) + tileW / 2, (drawnAttackingCharacter.y * tileH + offsetY), math.pi, 1, 1, tileW / 2, tileH / 2)
                love.graphics.draw(bloodParticleSystem, (drawnEnemyCharacter.x * tileW + offsetX) + tileW / 2, (drawnEnemyCharacter.y * tileH + offsetY) + tileH / 2) 
                bloodParticleSystem:emit(2000)
                self.drawAttackAnimTop = false
            end

            if self.drawAttackAnimLeft then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) - tileW / 2, (drawnAttackingCharacter.y * tileH + offsetY) + (tileH / 2), math.pi / 2, 1, 1, tileW / 2, tileH / 2)
                 love.graphics.draw(bloodParticleSystem, (drawnEnemyCharacter.x * tileW + offsetX) + tileW / 2, (drawnEnemyCharacter.y * tileH + offsetY) + tileH / 2) 
                bloodParticleSystem:emit(2000)
                self.drawAttackAnimLeft = false
            end

            if self.drawAttackAnimRight then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) + (tileW + tileW / 2), (drawnAttackingCharacter.y * tileH + offsetY) + (tileH / 2), math.pi * 1.5, 1, 1, tileW / 2, tileH / 2)
                 love.graphics.draw(bloodParticleSystem, (drawnEnemyCharacter.x * tileW + offsetX) + tileW / 2, (drawnEnemyCharacter.y * tileH + offsetY) + tileH / 2) 
                bloodParticleSystem:emit(2000)
                self.drawAttackAnimRight = false
            end

            if self.drawAttackAnimTopRight then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) + (tileW + tileW / 2), (drawnAttackingCharacter.y * tileH + offsetY), math.pi * 1.25, 1, 1, tileW / 2, tileH / 2)
                 love.graphics.draw(bloodParticleSystem, (drawnEnemyCharacter.x * tileW + offsetX) + tileW / 2, (drawnEnemyCharacter.y * tileH + offsetY) + tileH / 2) 
                bloodParticleSystem:emit(2000)
                self.drawAttackAnimTopRight = false
            end

            if self.drawAttackAnimTopLeft then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX), (drawnAttackingCharacter.y * tileH + offsetY), math.pi * 0.75, 1, 1, tileW / 2, tileH / 2)
                 love.graphics.draw(bloodParticleSystem, (drawnEnemyCharacter.x * tileW + offsetX) + tileW / 2, (drawnEnemyCharacter.y * tileH + offsetY) + tileH / 2) 
                bloodParticleSystem:emit(2000)
                self.drawAttackAnimTopLeft = false
            end

            if self.drawAttackAnimBottomLeft then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) - tileW / 2, (drawnAttackingCharacter.y * tileH + offsetY) + (tileH), math.pi * 0.25, 1, 1, tileW / 2, tileH / 2)
                 love.graphics.draw(bloodParticleSystem, (drawnEnemyCharacter.x * tileW + offsetX) + tileW / 2, (drawnEnemyCharacter.y * tileH + offsetY) + tileH / 2) 
                bloodParticleSystem:emit(2000)
                self.drawAttackAnimBottomLeft = false
            end

            if self.drawAttackAnimBottomRight then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) + (tileW), (drawnAttackingCharacter.y * tileH + offsetY) + (tileH), math.pi * 1.75, 1, 1, tileW / 2, tileH / 2)
                 love.graphics.draw(bloodParticleSystem, (drawnEnemyCharacter.x * tileW + offsetX) + tileW / 2, (drawnEnemyCharacter.y * tileH + offsetY) + tileH / 2) 
                bloodParticleSystem:emit(2000)
                self.drawAttackAnimBottomRight = false
            end


    end

end

function Character:drawParticles()
 
        if selectedChar and selectedChar.drawParticlesLeft then
            local x = ((selectedChar.x - 1) * tileW + offsetX) + tileW / 2
            local y = (selectedChar.y * tileH + offsetY) + tileH / 2
            if selectedChar:instanceOf(GeoGnome) then 
                love.graphics.draw(rockParticleSystem, x, y) 
                rockParticleSystem:emit(2000)
            end
        end
   

        if selectedChar and selectedChar.drawParticlesRight then
            local x = ((selectedChar.x + 1) * tileW + offsetX) + tileW / 2
            local y = (selectedChar.y * tileH + offsetY) + tileH / 2
            if selectedChar:instanceOf(GeoGnome) then 
                love.graphics.draw(rockParticleSystem, x, y) 
                rockParticleSystem:emit(2000)
            end
        end

        if selectedChar and selectedChar.drawParticlesTop then
            local x = ((selectedChar.x) * tileW + offsetX) + tileW / 2
            local y = ((selectedChar.y - 1) * tileH + offsetY) + tileH / 2
            if selectedChar:instanceOf(GeoGnome) then 
                love.graphics.draw(rockParticleSystem, x, y) 
                rockParticleSystem:emit(2000)
            end
        end

        if selectedChar and selectedChar.drawParticlesBottom then
            local x = ((selectedChar.x) * tileW + offsetX) + tileW / 2
            local y = ((selectedChar.y + 1) * tileH + offsetY) + tileH / 2
            if selectedChar:instanceOf(GeoGnome) then 
                love.graphics.draw(rockParticleSystem, x, y) 
                rockParticleSystem:emit(2000)
            end
        end

        if selectedChar and selectedChar.drawParticlesTL then
            local x = ((selectedChar.x - 1) * tileW + offsetX) + tileW / 2
            local y = ((selectedChar.y - 1) * tileH + offsetY) + tileH / 2
            if selectedChar:instanceOf(GeoGnome) then 
                love.graphics.draw(rockParticleSystem, x, y) 
                rockParticleSystem:emit(2000)
            end
        end

        if selectedChar and selectedChar.drawParticlesTR then
            local x = ((selectedChar.x + 1) * tileW + offsetX) + tileW / 2
            local y = ((selectedChar.y - 1) * tileH + offsetY) + tileH / 2
            if selectedChar:instanceOf(GeoGnome) then 
                love.graphics.draw(rockParticleSystem, x, y) 
                rockParticleSystem:emit(2000)
            end
        end

        if selectedChar and selectedChar.drawParticlesBL then
            local x = ((selectedChar.x - 1) * tileW + offsetX) + tileW / 2
            local y = ((selectedChar.y + 1) * tileH + offsetY) + tileH / 2
            if selectedChar:instanceOf(GeoGnome) then 
                love.graphics.draw(rockParticleSystem, x, y) 
                rockParticleSystem:emit(2000)
            end
        end

        if selectedChar and selectedChar.drawParticlesBR then
            local x = ((selectedChar.x + 1) * tileW + offsetX) + tileW / 2
            local y = ((selectedChar.y + 1) * tileH + offsetY) + tileH / 2
            if selectedChar:instanceOf(GeoGnome) then 
                love.graphics.draw(rockParticleSystem, x, y) 
                rockParticleSystem:emit(2000)
            end
        end

end

function Character:drawValidIcons()

    for _, currentChar in ipairs(activePlayer.characters) do
        local self = currentChar
        if selectedChar and selectedChar == currentChar and gameState.state == gameState.states.selectMoveTargetCell and self.stepPoints ~= 0 then
            for ox = -1, 1 do
                for oy = -1, 1 do 
                    if self.x + ox <= 10 and self.x + ox > 0 and self.y + oy <=10 and self.y + oy > 0 
                    and self.isWalkable[boardGrid[(self.x + ox)][self.y + oy].class.name] and not boardGrid[(self.x + ox)][self.y + oy].isOccupied then

                        love.graphics.draw(validStepImage, (self.x + ox) * tileW + offsetX, (self.y + oy) * tileH + offsetY)

                    end
                end
            end
      
        end

    
        if selectedChar and selectedChar == currentChar and gameState.state == gameState.states.selectAttackTargetCharacter and self.actionPoints ~= 0 then
            for ox = -1, 1 do
                for oy = -1, 1 do
                    if self.x + ox <= 10 and self.x + ox > 0 and self.y + oy <= 10 and self.y + oy > 0 and boardGrid[(self.x + ox)][self.y + oy]:instanceOf(Lake) == false 
                        and boardGrid[(self.x + ox)][self.y + oy].isOccupied and boardGrid[(self.x + ox)][self.y + oy].occupiedBy and boardGrid[(self.x + ox)][self.y + oy].occupiedBy.parentPlayer ~= self.parentPlayer  then 
                            
                            love.graphics.draw(validAttackImage, (self.x + ox) * tileW + offsetX, (self.y + oy)  * tileH + offsetY) 
  
                    end
                end
            end
        end
    
      
        if selectedChar and selectedChar == currentChar and gameState.state == gameState.states.selectSpellTargetArea and self.actionPoints ~= 0 then
            
            if self.id == 1 or self.id == 9 then
                if self.y + 1 < 11 and pointerOnBottomSide then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
                if self.y - 1 > 0 and pointerOnTopSide then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
                if self.x + 1 < 11 and pointerOnRightSide then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
                if self.x - 1 > 0 and pointerOnLeftSide then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
            end

            if self.id == 5 then
                if self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
                if self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
                if self.x + 1 < 11 then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
                if self.x - 1 > 0 then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
            end
    
        if self.id == 3 or self.id == 4 then
            if self.x - 1 > 0 and self.y - 1 > 0  and (pointerOnTopSide or pointerOnTopLeftSide or pointerOnTopRightSide) then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 and (pointerOnBottomSide or pointerOnBottomRightSide or pointerOnBottomLeftSide) then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 and (pointerOnTopSide  or pointerOnTopLeftSide or pointerOnTopRightSide) then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y + 1 < 11 and (pointerOnBottomSide or pointerOnBottomRightSide or pointerOnBottomLeftSide) then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.y - 1 > 0 and (pointerOnTopSide or pointerOnTopLeftSide or pointerOnTopRightSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.y + 1 < 11 and (pointerOnBottomSide or pointerOnBottomRightSide or pointerOnBottomLeftSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
        end
    
        if self.id == 2 then
            if self.x - 1 > 0 and self.y - 1 > 0 and pointerOnTopLeftSide then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 and pointerOnBottomLeftSide then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 and pointerOnTopRightSide then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y + 1 < 11 and pointerOnBottomRightSide then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x - 2 > 0 and self.y - 2 > 0 and pointerOnTopLeftSide then love.graphics.draw(validSpellImage, (self.x - 2) * tileW + offsetX, (self.y - 2) * tileH + offsetY) end
            if self.x - 2 > 0 and self.y + 2 < 11 and pointerOnBottomLeftSide then love.graphics.draw(validSpellImage, (self.x - 2) * tileW + offsetX, (self.y + 2) * tileH + offsetY) end
            if self.x + 2 < 11 and self.y - 2 > 0 and pointerOnTopRightSide then love.graphics.draw(validSpellImage, (self.x + 2) * tileW + offsetX, (self.y - 2) * tileH + offsetY) end
            if self.x + 2 < 11 and self.y + 2 < 11 and pointerOnBottomRightSide then love.graphics.draw(validSpellImage, (self.x + 2) * tileW + offsetX, (self.y + 2) * tileH + offsetY) end
        end
    
        if self.id == 6 then
            if self.x - 1 > 0 and self.y - 1 > 0 and (pointerOnTopSide or pointerOnTopLeftSide or pointerOnTopRightSide) then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 and (pointerOnBottomSide or pointerOnBottomLeftSide or pointerOnBottomRightSide) then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 and (pointerOnTopSide  or pointerOnTopLeftSide or pointerOnTopRightSide) then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y + 1 < 11 and (pointerOnBottomSide  or pointerOnBottomLeftSide or pointerOnBottomRightSide) then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
        end
    
        if self.id == 7 then
            if self.y + 1 < 11 and (pointerOnBottomSide or pointerOnTopSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.y - 1 > 0 and (pointerOnBottomSide or pointerOnTopSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and (pointerOnLeftSide or pointerOnRightSide) then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
            if self.x - 1 > 0  and (pointerOnLeftSide or pointerOnRightSide) then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
            if self.y + 2 < 11 and (pointerOnBottomSide or pointerOnTopSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 2) * tileH + offsetY) end
            if self.y - 2 > 0 and (pointerOnBottomSide or pointerOnTopSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 2) * tileH + offsetY) end
            if self.x + 2 < 11  and (pointerOnLeftSide or pointerOnRightSide) then love.graphics.draw(validSpellImage, (self.x + 2) * tileW + offsetX, (self.y) * tileH + offsetY) end
            if self.x - 2 > 0  and (pointerOnLeftSide or pointerOnRightSide) then love.graphics.draw(validSpellImage, (self.x - 2) * tileW + offsetX, (self.y) * tileH + offsetY) end
        end

        if self.id == 8 then
            if self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
        end
        end

    end


end

function Character:drawSpellAnimation()
end



function Character:updateHover(mX, mY)
    local  mouseCellCoordinateX = math.floor((mX / tileW) - offsetX / tileW) 
    local  mouseCellCoordinateY = math.floor((mY / tileH) - offsetY / tileH)
    if  mouseCellCoordinateX == self.x and mouseCellCoordinateY == self.y then
        self.isHovered = true
    else
        self.isHovered = false
    end
end

function Character:enablePossibleDamageDraw()

    local attacker
    local enemy
  
        
        attacker = selectedChar
        


        for _, currentChar in ipairs(inactivePlayer.characters) do

            if currentChar.isHovered then
                enemy = currentChar
            end

        end

        if enemy ~= nil then
           isPossibleDamageDrawn = true
        end


end

function Character:click(mX, mY)

    if gameState.state == gameState.states.selectCharacter and self.parentPlayer == activePlayer and (self.stepPoints ~= 0 or self.actionPoints ~= 0) then
        selectedChar = self
        selectedChar.isActionMenuDrawn = true
        gameState:changeState(gameState.states.selectCharacterAction)
        return
    end

    if selectedChar and selectedChar.parentPlayer ~= self.parentPlayer and gameState.state == gameState.states.selectAttackTargetCharacter then
        if  (self.x + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x + 1][self.y] and boardGrid[self.x][self.y]:instanceOf(Lake) == false )  or
            (self.x - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x - 1][self.y] and boardGrid[self.x][self.y]:instanceOf(Lake) == false )   or
            (self.y + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x][self.y + 1] and boardGrid[self.x][self.y]:instanceOf(Lake) == false )   or
            (self.y - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x][self.y - 1] and boardGrid[self.x][self.y]:instanceOf(Lake) == false )    or
            (self.x + 1 <= 10 and self.y + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x + 1][self.y + 1] and boardGrid[self.x][self.y]:instanceOf(Lake) == false )  or
            (self.x - 1 > 0 and self.y + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x - 1][self.y + 1] and boardGrid[self.x][self.y]:instanceOf(Lake) == false )  or
            (self.x + 1 <= 10 and self.y - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x + 1][self.y - 1] and boardGrid[self.x][self.y]:instanceOf(Lake) == false ) or
            (self.x - 1 > 0 and self.y - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x - 1][self.y - 1] and boardGrid[self.x][self.y]:instanceOf(Lake) == false ) then
            selectedChar:attack(self)
        end
    end
 
  

    if gameState.state == gameState.states.selectCharacterAction and (selectedChar.stepPoints ~= 0 or selectedChar.actionPoints ~= 0) then
        selectedChar:chooseActionMenu(mX, mY)
        return
    end

end

function Character:chooseActionMenu(mx, my)
    local cx = self.x * tileW + offsetX
    local cy = self.y * tileH + offsetY

    

    if gameState.state == gameState.states.selectCharacterAction and self.actionPoints == 0 and self.stepPoints == 0 then
        gameState:changeState(gameState.states.selectCharacter)
    return
        
    elseif gameState.state == gameState.states.selectCharacterAction then
        -- BAl FELSO NEGYED - ATTACK STATE
        if  mx > cx and mx < cx + tileW / 2 and  my > cy and my < cy + tileH / 2 and self.actionPoints ~= 0 then
                gameState:changeState(gameState.states.selectAttackTargetCharacter)

                    if gameState.state == gameState.states.selectCharacterAction and self.actionPoints == 0 then
                        gameState:changeState(gameState.states.selectCharacter)
                        return
                    end
            return   
        end
        -- JOBB FELSÖ NEGYED - STEP STATE                       
        if  mx > cx + tileW / 2 and mx < cx + tileW and my > cy and my < cy + tileH / 2 and self.stepPoints ~= 0 then

               
                gameState:changeState(gameState.states.selectMoveTargetCell)
                return
               
        end
        -- BAL ALSO NEGYED - SPELL STATE
        if   mx > cx and mx < cx + tileW / 2 and my > cy + (tileH / 2) and my < cy + tileH and self.actionPoints ~= 0 then
                gameState:changeState(gameState.states.selectSpellTargetArea)
             

                    if gameState.state == gameState.states.selectCharacterAction and self.actionPoints == 0 then
                    gameState:changeState(gameState.states.selectCharacter)
                    end
                    return
        end
  
    end
    if mx ~= cx and my ~= cy then
        gameState:changeState(gameState.states.selectCharacter)
    end
    
    self.drawBattle = false
end
        
    

function Character:move(cx, cy, oldx, oldy)
    


    if self.stepPoints ~= 0 then
        if self.x and self.y then
            boardGrid[self.x][self.y].isOccupied = false
            boardGrid[self.x][self.y].occupiedBy = nil
        end
     
            
            local arriveX = self.x
            local arriveY = self.y
            if oldx == nil then oldx = 5 end
            if oldy == nil then oldy = 5 end
            self.x = oldx
            self.y = oldy
        
            flux.to(self, 0.5, { x = cx, y = cy}):ease("quadin")
            table.insert(sequenceBufferTable, {
                name = "occupyingCell",
                duration = 0.4,
                sequenceTime = love.timer.getTime(),
                action = function()

            
                    if self.x >= 10 then self.x = 10 end
                    if self.x <= 0 then self.x = 1 end
                    if self.y >= 10 then self.y = 10 end
                    if self.y <= 0 then self.y = 1 end
                
                    boardGrid[cx][cy]:onEntry(self, arriveX, arriveY)
                    boardGrid[cx][cy].isOccupied = true
                    boardGrid[cx][cy].occupiedBy = self
                end})

                    self.stepPoints = self.stepPoints - 1
               
    end
   
end



function Character:kill()
 
    for index, currentChar in ipairs(self.parentPlayer.characters) do
        if self == currentChar then
            boardGrid[self.x][self.y].isOccupied = false
            table.insert(deadPool, currentChar)
            table.remove(self.parentPlayer.characters, index)
        end   
    end

    if #playerOne.characters == 3 and #playerTwo.characters == 4 then  
        print("spawning prison for activeplayer")
        spawnPrison(playerOne)
    end

    if #playerTwo.characters == 3 and #playerOne.characters == 4 then
        print("spawning prison for inactiveplayer")
        spawnPrison(playerTwo)
    end


end

function Character:attack(enemy)
    table.insert(sequenceBufferTable, {
        name = "AttackEnemyCharacter",
        duration = 0.1,
        sequenceTime = love.timer.getTime(),
        action = function()
            if gameState.state == gameState.states.selectAttackTargetCharacter and self.actionPoints ~= 0 then
                enableDrawAttack(self, enemy)
                local dr = getDiceRoll()
                self.diceRoll = dr
                self.rolledAttack = self.baseAttack + dr + boardGrid[self.x][self.y].attackModifier + self.turnAttackModifier
                damage = math.max(0, self.rolledAttack - (enemy.baseDefense + boardGrid[enemy.x][enemy.y].defenseModifier + enemy.turnDefenseModifier))

                enemy.baseHP = enemy.baseHP - damage
                if enemy.baseHP <= 0 then enemy:kill() end
                
                self.actionPoints = self.actionPoints - 1
                enemy = nil
            end
            table.insert(sequenceBufferTable, {
                name = "resetingAttackState",
                duration = 1.4,
                sequenceTime = love.timer.getTime(),
                action = function()
                    gameState:changeState(gameState.states.selectCharacter)
                end
            })
        end
    })
   
end


function Character:spell(targetCell)
end




return Character