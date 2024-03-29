local Character = class("Character")

function Character:init(maxHP, baseHP, baseDefense, baseAttack, id, image, idleAnimImage, imageHover, sinkImage, sinkImageHover, parentPlayer, actionPoints, stepPoints, infoText, defenseCounter, defenseState)
    self.maxHP = maxHP
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
    self.turnAttackModifier = 0
    self.turnDefenseModifier = 0
    self.infoText = infoText

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
        Graveyard = true,
        Shrine = true,
        Prison = true,
        Volcano = true,
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





    -- SPEECH BUBLES


    for _, currentChar in ipairs(activePlayer.characters) do
        if currentChar.nextSpeakTime == nil or currentChar.nextSpeakTime < love.timer.getTime() then
            if currentChar.nextSpeakTime ~= nil then
                local text = getTextForSpeech()
                currentChar.currentSpeech = text
                currentChar.isSpeaking = true
                currentChar.lastSpeakTime = love.timer.getTime()
              --  print("[SEQUENCE]: "..currentChar.name.." says ".."'"..text.."'")
            end
            currentChar.nextSpeakTime = randomForCosmetics:random(30,240)  + love.timer.getTime()

        end
    end
    for _, currentChar in ipairs(inactivePlayer.characters) do
        if currentChar.nextSpeakTime == nil or currentChar.nextSpeakTime < love.timer.getTime() then
            if currentChar.nextSpeakTime ~= nil then
                local text = getTextForSpeech()
                currentChar.currentSpeech = text
                currentChar.isSpeaking = true
                currentChar.lastSpeakTime = love.timer.getTime()
             --   print("[SEQUENCE]: "..currentChar.name.." says ".."'"..text.."'")
            end
            currentChar.nextSpeakTime = randomForCosmetics:random(30,240)  + love.timer.getTime()
        end
    end


    -- ANIMATION UPDATES

    attackAnimation:update(dt)
    spellIconAnimation:update(dt)
    attackIconAnimation:update(dt)
    infoIconAnimation:update(dt)
    moveIconAnimation:update(dt)

end

function Character:draw()
    local x = self.x * tileW + offsetX
    local y = self.y * tileH + offsetY

   --[[  if     boardGrid[self.x][self.y]:instanceOf(Lake) then love.graphics.draw(self.sinkImage, x, y)
    elseif boardGrid[self.x][self.y]:instanceOf(Lake) and self.isHovered then love.graphics.draw(self.sinkImageHover, x, y)
    elseif self.isHovered == true then love.graphics.draw(self.imageHover, x, y)
    else   love.graphics.draw(self.image, x, y)
    end ]]
    local mx, my = mouseX, mouseY

    self.animation:draw(self.idleAnimImage, x,y)


    if gameState.state == gameState.states.selectCharacterAction then
        local x = selectedChar.x * tileW + offsetX
        local y = selectedChar.y * tileH + offsetY


        if mx > x and my > y and mx < x + (tileW - tileW / 2) and my > y + (tileH - tileH / 2) and selectedChar.actionPoints ~= 0 then
            isSpellIconAnimationPlaying = true
            spellIconAnimation:draw(spellIconAnimationImage, x - 16, y + (tileH - tileH / 2) - 16)

        else isSpellIconAnimationPlaying = false
             spellIconAnimation:gotoFrame(1)
             spellIconAnimation:resume()
        end

        if mx > x and mx < x + tileW / 2 and  my > y and my < y + tileH / 2 and selectedChar.actionPoints ~= 0 then
            isAttackIconAnimationPlaying = true
            attackIconAnimation:draw(attackIconAnimationImage, x - 16, y + (tileH - tileH / 2) - 48)

        else isAttackIconAnimationPlaying = false
             attackIconAnimation:gotoFrame(1)
             attackIconAnimation:resume()
        end

        if mx > x + tileW / 2 and mx < x + tileW and my > y and my < y + tileH / 2 and selectedChar.stepPoints ~= 0 then
            isMoveIconAnimationPlaying = true
            moveIconAnimation:draw(moveIconAnimationImage, x + 16, y + (tileH - tileH / 2) - 48)

        else isMoveIconAnimationPlaying = false
             moveIconAnimation:gotoFrame(1)
             moveIconAnimation:resume()
        end

        if mx > x + tileW / 2 and mx < x + tileW and my < y + tileH and my > y + tileH / 2 then
            isInfoIconAnimationPlaying = true
            infoIconAnimation:draw(infoIconAnimationImage, x + 16, y + (tileH - tileH / 2) - 16)

        else isInfoIconAnimationPlaying = false
             infoIconAnimation:gotoFrame(1)
             infoIconAnimation:resume()
        end

        if isInfoIconAnimationPlaying ~= true then
            love.graphics.draw(infoIcon, x + (tileW - tileW / 2), y + (tileH - tileH / 2))

        end


        if gameState.state == gameState.states.selectCharacterAction then

            if selectedChar.actionPoints ~= 0 and isAttackIconAnimationPlaying ~= true then
                love.graphics.draw(attackIcon, x, y)
            end


            if selectedChar.stepPoints ~= 0 and isMoveIconAnimationPlaying ~= true then
                love.graphics.draw(moveIcon, x + (tileW - tileW / 2), y)
            end

            if selectedChar.actionPoints ~= 0 and isSpellIconAnimationPlaying ~= true then
                love.graphics.draw(spellIcon, x, y + (tileH - tileH / 2))
            end
        end

    end

end

function Character:drawSpeechBubbles()

                for index, currentChar in ipairs(activePlayer.characters) do

                    if currentChar.isSpeaking and gameState.state ~= gameState.states.selectCharacterAction then

                        currentChar.speakTimer = love.timer.getTime()
                        local duration = 4
                        local textWidth = littleFont:getWidth(currentChar.currentSpeech)

                        love.graphics.setFont(littleFont)

                        love.graphics.rectangle("fill", (currentChar.x * tileW + (tileW / 4) - tileW / 8) + offsetX, (currentChar.y * tileH) + offsetY, textWidth + 5 , 17)
                        love.graphics.setColor(selectedColor)
                        love.graphics.print(currentChar.currentSpeech, (currentChar.x * tileW + (tileW / 4)) + offsetX, (currentChar.y * tileH) + offsetY)
                        love.graphics.setFont(statFont)
                        love.graphics.setColor(charColor)
                --        print(love.timer.getTime() - currentChar.lastSpeakTime, duration)

                        if love.timer.getTime() - currentChar.lastSpeakTime > duration then
                            currentChar.isSpeaking = false
                        end

                    end

                end

                for index, currentChar in ipairs(inactivePlayer.characters) do

                    if currentChar.isSpeaking and gameState.state ~= gameState.states.selectCharacterAction  then

                        currentChar.speakTimer = love.timer.getTime()
                        local duration = 4
                        local textWidth = littleFont:getWidth(currentChar.currentSpeech)

                        love.graphics.setFont(littleFont)

                        love.graphics.rectangle("fill", (currentChar.x * tileW + (tileW / 4) - tileW / 8) + offsetX, (currentChar.y * tileH) + offsetY, textWidth * 1.2 , 17)
                        love.graphics.setColor(selectedColor)
                        love.graphics.print(currentChar.currentSpeech, (currentChar.x * tileW + (tileW / 4)) + offsetX, (currentChar.y * tileH) + offsetY)
                        love.graphics.setFont(statFont)
                        love.graphics.setColor(charColor)

                        if love.timer.getTime() - currentChar.lastSpeakTime > duration then
                            currentChar.isSpeaking = false
                        end

                    end



                end

end

function Character:drawCancelButton()

            if gameState.state == gameState.states.selectMoveTargetCell or gameState.state == gameState.states.selectAttackTargetCharacter or gameState.state == gameState.states.selectSpellTargetArea then
               -- isCancelButton = true
               cancelButtonAnimation:draw(cancelButtonAnimationImage, (selectedChar.x * tileW + offsetX) , (selectedChar.y * tileH + offsetY))

            end

end

function Character:drawHealthBar()



    for _, currentChar in ipairs(activePlayer.characters) do

            local healthBarMaxWidth = 0.75
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
            local healthBarMaxWidth = 0.75
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
                            boardGrid[(self.x + ox)][self.y + oy].isAttackable = true
                        elseif self.x + ox <= 10 and self.x + ox > 0 and self.y + oy <= 10 and self.y + oy > 0  then
                            boardGrid[(self.x + ox)][self.y + oy].isAttackable = false
                    end
                end
            end
        end


        if selectedChar and selectedChar == currentChar and gameState.state == gameState.states.selectSpellTargetArea and self.actionPoints ~= 0 then

            if self.id == 9 then --GEOGNOME, WATERHAG
                if self.y + 1 < 11 and pointerOnBottomSide then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
                if self.y - 1 > 0 and pointerOnTopSide then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
                if self.x + 1 < 11 and pointerOnRightSide then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
                if self.x - 1 > 0 and pointerOnLeftSide then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
            end

            if self.id == 1  then
                for x = -1, 1 do
                    for y = -1, 1 do
                        if self.x + x <= 10 and self.x + x > 0 and self.y + y <= 10 and self.y + y > 0 then
                            if x ~= 0 or y ~= 0 then
                                love.graphics.draw(validSpellImage, (self.x + x) * tileW + offsetX, (self.y + y) * tileH + offsetY)
                            end
                        end
                    end
                end
            end


            if self.id == 5 then -- DRUID
                if self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
                if self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
                if self.x + 1 < 11 then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
                if self.x - 1 > 0 then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
            end

        if self.id == 3 or self.id == 4 then --AIRELEMENTAL, ICEWIZARD
            if self.x - 1 > 0 and self.y - 1 > 0  and (pointerOnTopSide or pointerOnTopLeftSide or pointerOnTopRightSide) then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 and (pointerOnBottomSide or pointerOnBottomRightSide or pointerOnBottomLeftSide) then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 and (pointerOnTopSide  or pointerOnTopLeftSide or pointerOnTopRightSide) then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y + 1 < 11 and (pointerOnBottomSide or pointerOnBottomRightSide or pointerOnBottomLeftSide) then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.y - 1 > 0 and (pointerOnTopSide or pointerOnTopLeftSide or pointerOnTopRightSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.y + 1 < 11 and (pointerOnBottomSide or pointerOnBottomRightSide or pointerOnBottomLeftSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
        end

        if self.id == 2 then -- ALCHEMIST
            if self.x - 1 > 0 and self.y - 1 > 0 and pointerOnTopLeftSide then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 and pointerOnBottomLeftSide then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 and pointerOnTopRightSide then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y + 1 < 11 and pointerOnBottomRightSide then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x - 2 > 0 and self.y - 2 > 0 and pointerOnTopLeftSide then love.graphics.draw(validSpellImage, (self.x - 2) * tileW + offsetX, (self.y - 2) * tileH + offsetY) end
            if self.x - 2 > 0 and self.y + 2 < 11 and pointerOnBottomLeftSide then love.graphics.draw(validSpellImage, (self.x - 2) * tileW + offsetX, (self.y + 2) * tileH + offsetY) end
            if self.x + 2 < 11 and self.y - 2 > 0 and pointerOnTopRightSide then love.graphics.draw(validSpellImage, (self.x + 2) * tileW + offsetX, (self.y - 2) * tileH + offsetY) end
            if self.x + 2 < 11 and self.y + 2 < 11 and pointerOnBottomRightSide then love.graphics.draw(validSpellImage, (self.x + 2) * tileW + offsetX, (self.y + 2) * tileH + offsetY) end
        end

        if self.id == 6 then -- FIREMAGE
            if self.x - 1 > 0 and self.y - 1 > 0 and (pointerOnTopSide or pointerOnTopLeftSide or pointerOnTopRightSide) then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 and (pointerOnBottomSide or pointerOnBottomLeftSide or pointerOnBottomRightSide) then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 and (pointerOnTopSide  or pointerOnTopLeftSide or pointerOnTopRightSide) then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y + 1 < 11 and (pointerOnBottomSide  or pointerOnBottomLeftSide or pointerOnBottomRightSide) then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
        end

        if self.id == 7 then -- THUNDERSHAMAN
            if self.y + 1 < 11 and (pointerOnBottomSide or pointerOnTopSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.y - 1 > 0 and (pointerOnBottomSide or pointerOnTopSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and (pointerOnLeftSide or pointerOnRightSide) then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
            if self.x - 1 > 0  and (pointerOnLeftSide or pointerOnRightSide) then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
            if self.y + 2 < 11 and (pointerOnBottomSide or pointerOnTopSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 2) * tileH + offsetY) end
            if self.y - 2 > 0 and (pointerOnBottomSide or pointerOnTopSide) then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 2) * tileH + offsetY) end
            if self.x + 2 < 11  and (pointerOnLeftSide or pointerOnRightSide) then love.graphics.draw(validSpellImage, (self.x + 2) * tileW + offsetX, (self.y) * tileH + offsetY) end
            if self.x - 2 > 0  and (pointerOnLeftSide or pointerOnRightSide) then love.graphics.draw(validSpellImage, (self.x - 2) * tileW + offsetX, (self.y) * tileH + offsetY) end
        end

        if self.id == 8 then -- SANDWITCH
            if self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
        end

        if self.id == 11 then -- ARCHMAGER
            for x = -3, 3 do
                for y = -3, 3 do
                    if self.x + x <= 10 and self.x + x > 0 and self.y + y <=10 and self.y + y > 0 then
                        if (y == 3 or y == -3) or (x == 3 or x == -3) then
                            love.graphics.draw(validSpellImage, (self.x + x) * tileW + offsetX, (self.y + y) * tileH + offsetY)
                        end
                    end
                end
            end
        end

        if self.id == 12 then --DRAGONDIVINER
            for oy = -2, 2 do
                if oy ~= 0 then
                    if self.y + oy > 0 and self.y + oy <= 10 then
                        love.graphics.draw(validSpellImage, self.x * tileW + offsetX, (self.y + oy) * tileH + offsetY)
                    end
                end
            end

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

                        --[[ if gameState.state == gameState.states.selectCharacterAction and self.actionPoints == 0 then
                            gameState:changeState(gameState.states.selectCharacter)
                            return
                        end ]]
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


                        --[[ if gameState.state == gameState.states.selectCharacterAction and self.actionPoints == 0 then
                        gameState:changeState(gameState.states.selectCharacter)
                        end ]]
                        return
            end

            -- JOBB ALSÓ NEGYED - INFO

            if mx > cx + tileW / 2 and mx < cx + tileW and my < cy + tileH and my > cy + tileH / 2 then

                drawInfoAboutCharacter(self)

            end


    end
    --[[ if mx ~= cx and my ~= cy then
        gameState:changeState(gameState.states.selectCharacter)
    end
     ]]
    self.drawBattle = false
end

function Character:damage(char, dmg)


    
    soundEngine:playSFX("playrandomsound")
    screenShake(0.2, 1)
    if dmg > 15 then
        soundEngine:playSFX(criticalHitSound)
    end
    
    char.baseHP = char.baseHP - dmg

            boardGrid[char.x][char.y].drawDamageOnBoard = true
            boardGrid[char.x][char.y]:damageOnBoard("-"..dmg.."HP")
    

            if char.baseHP <= 0 then
                char:kill()
            end

    

end

function Character:move(cx, cy, oldx, oldy)

    gameState:changeState(gameState.states.waitingState)

    if self.stepPoints ~= 0 then

        if self.x ~= nil and self.y ~= nil then
            boardGrid[self.x][self.y].isOccupied = false
            boardGrid[self.x][self.y].occupiedBy = nil
        end


            local arriveX = self.x
            local arriveY = self.y



            self.x = oldx
            self.y = oldy

            --networking

            soundEngine:playSFX(stepSound)


            if boardGrid[arriveX][arriveY]:instanceOf(Ice) then

                flux.to(self, 0.5, { x = cx, y = cy}):ease("quadin")


                table.insert(sequenceBufferTable, {
                    name = "occupyingCell",
                    duration = 0.6,
                    sequenceTime = love.timer.getTime(),
                    action = function()


                        if self.x >= 10 then self.x = 10 end
                        if self.x <= 0 then self.x = 1 end
                        if self.y >= 10 then self.y = 10 end
                        if self.y <= 0 then self.y = 1 end
                        boardGrid[cx][cy].isOccupied = true
                        boardGrid[cx][cy].occupiedBy = self
                        boardGrid[cx][cy]:onEntry(self, arriveX, arriveY)

                        if boardGrid[cx][cy]:instanceOf(Ice) ~= true then
                            self.stepPoints = 0
                          --  gameState:changeState(gameState.states.selectCharacter)
                        end

                    end})
               return
            end



            flux.to(self, 0.5, { x = cx, y = cy}):ease("quadin")

            table.insert(sequenceBufferTable, {
                name = "occupyingCell",
                duration = 0.6,
                sequenceTime = love.timer.getTime(),
                action = function()


                    if self.x >= 10 then self.x = 10 end
                    if self.x <= 0 then self.x = 1 end
                    if self.y >= 10 then self.y = 10 end
                    if self.y <= 0 then self.y = 1 end


                    boardGrid[cx][cy]:onEntry(self, arriveX, arriveY)
                    boardGrid[cx][cy].isOccupied = true
                    boardGrid[cx][cy].occupiedBy = self
                    if self.actionPoints > 0  or self.stepPoints > 0 then
                        selectedChar = self
                        gameState:changeState(gameState.states.selectCharacterAction)
                    else

                        selectedChar = self
                        gameState:changeState(gameState.states.selectCharacter)
                    end


                end})



                    self.stepPoints = self.stepPoints - 1


    end

    print("RND STATE IN MOVE: "..love.math.getRandomState())





end

function Character:freeMove(cx, cy, oldx, oldy)
 --   gameState:changeState(gameState.states.waitingState)


        if self.x ~= nil and self.y ~= nil then
            boardGrid[self.x][self.y].isOccupied = false
            boardGrid[self.x][self.y].occupiedBy = nil
        end


            local arriveX = self.x
            local arriveY = self.y

            self.x = oldx
            self.y = oldy


            soundEngine:playSFX(stepSound)

            flux.to(self, 0.5, { x = cx, y = cy}):ease("quadin")


            table.insert(sequenceBufferTable, {
                name = "occupyingCell",
                duration = 0.6,
                sequenceTime = love.timer.getTime(),
                action = function()


                    if self.x >= 10 then self.x = 10 end
                    if self.x <= 0 then self.x = 1 end
                    if self.y >= 10 then self.y = 10 end
                    if self.y <= 0 then self.y = 1 end

                    boardGrid[cx][cy]:onEntry(self, arriveX, arriveY)
                    boardGrid[cx][cy].isOccupied = true
                    boardGrid[cx][cy].occupiedBy = self
                    if self.actionPoints > 0  or self.stepPoints > 0 then

                        gameState:changeState(gameState.states.selectCharacterAction)
                    else

                        selectedChar = self
                        gameState:changeState(gameState.states.selectCharacter)
                    end

                end})


    print("RND STATE IN MOVE: "..love.math.getRandomState())
end


function Character:kill()


    soundEngine:playSFX(deathSound)

    boardGrid[self.x][self.y] = Graveyard(self.x, self.y)


    for index, currentChar in ipairs(self.parentPlayer.characters) do
        if self == currentChar and self.parentPlayer == playerOne and #deadPool.playerOne <= 1 then
            boardGrid[self.x][self.y].isOccupied = false
            currentChar.isPoisoned = false
            table.insert(deadPool.playerOne, currentChar)
            table.remove(self.parentPlayer.characters, index)
        elseif self == currentChar and self.parentPlayer == playerOne then
            table.remove(self.parentPlayer.characters, index)
        end
        if self == currentChar and self.parentPlayer == playerTwo and #deadPool.playerTwo <= 1 then
            boardGrid[self.x][self.y].isOccupied = false
            currentChar.isPoisoned = false
            table.insert(deadPool.playerTwo, currentChar)
            table.remove(self.parentPlayer.characters, index)
        elseif self == currentChar and self.parentPlayer == playerTwo then
            table.remove(self.parentPlayer.characters, index)
        end


    end

    if turnCounter < 20 and not isSuddenDeath then

        if isSuddenDeath ~= true then
            if #playerOne.characters < 4  and playerOne.prisonCount == 0 then
                print("spawning prison for PLAYER ONE")


                banner("PRISON", "A PRISON HAS SPAWNED", "you can free your first dead character", love.timer.getTime(), 5)


                spawnPrison(playerOne)
            end

            if #playerTwo.characters < 4 and playerTwo.prisonCount == 0 then
                print("spawning prison for PLAYER TWO")
                banner("PRISON", "A PRISON HAS SPAWNED", "you can free your first dead character", love.timer.getTime(), 5)
                spawnPrison(playerTwo)
            end

            if #playerOne.characters == 2 and #playerTwo.characters == 4 then
                print("spawning chest for activeplayer")
                spawnChestPlayerOne()
            end

            if #playerTwo.characters == 2 and #playerOne.characters == 4 then
                print("spawning chest for inactiveplayer")
                spawnChestPlayerTwo()
            end
        end

    end


end

function Character:attack(enemy, nw)

  
   
        if (isGameServer or (isGameClient ~= true and isGameServer ~= true)) then
            self.diceRoll = randomFunction(1, 6, "diceroll", "diceroll")
       end
     
       
       if isGameClient then 
           table.insert(sequenceBufferTable, {
               name = "AttackEnemyCharacter",
               duration = 0.6,
               sequenceTime = love.timer.getTime(),
               action = function()
                   self.diceRoll = RANDOMNUMBER
                   print("RANDOMNUMBER"..RANDOMNUMBER)
               end})
       end



    table.insert(sequenceBufferTable, {
        name = "AttackEnemyCharacter",
        duration = 0.1,
        sequenceTime = love.timer.getTime(),
        action = function()
            if (gameState.state == gameState.states.selectAttackTargetCharacter or nw ) and self.actionPoints ~= 0 then
                gameState:changeState(gameState.states.waitingState)
         
                    if self.diceRoll == 6 then
                        soundEngine:playSFX(niceRollSound)
                    elseif self.diceRoll == 1 then
                        soundEngine:playSFX(hahaSound)

                    end

                    if boardGrid[self.x][self.y].isPoisoned then
                        self.turnAttackModifier = self.turnAttackModifier - 3
                        self.turnDefenseModifier = self.turnDefenseModifier - 1
                    end

                    if boardGrid[enemy.x][enemy.y].isPoisoned then
                        enemy.turnAttackModifier = enemy.turnAttackModifier - 3
                        enemy.turnDefenseModifier = enemy.turnDefenseModifier - 1
                    end

                    self.rolledAttack = self.baseAttack + self.diceRoll + boardGrid[self.x][self.y].attackModifier + self.turnAttackModifier
                    damage = math.max(0, self.rolledAttack - (enemy.baseDefense + boardGrid[enemy.x][enemy.y].defenseModifier + enemy.turnDefenseModifier))
              

               
                    enableDrawAttack(self, enemy)
                    enemy:damage(enemy, damage)
       


                self.actionPoints = self.actionPoints - 1
                enemy = nil
            end



            soundEngine:playSFX(knifeSound)




            table.insert(sequenceBufferTable, {
                name = "resetingAttackState",
                duration = 3.2,
                sequenceTime = love.timer.getTime(),
                action = function()
                    selectedChar = self
                    if self.actionPoints > 0  or self.stepPoints > 0 then
                        selectedChar = self
                        gameState:changeState(gameState.states.selectCharacterAction)
                    else

                        selectedChar = self
                        gameState:changeState(gameState.states.selectCharacter)
                    end




                end})
            
          
        end})

end


function Character:spell(targetCell)
end


return Character