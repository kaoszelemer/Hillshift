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


function Character:drawHealthBar()

    

    for _, currentChar in ipairs(activePlayer.characters) do
            local healthBarMaxWidth = 3
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
            local healthBarMaxWidth = 3
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
                print(drawnAttackingCharacter.y)
                attackAnimation:draw(attackAnimationImage, drawnAttackingCharacter.x * tileW + offsetX, (drawnAttackingCharacter.y * tileH + offsetY) + tileH)
                self.drawAttackAnimBottom = false
            end

            if self.drawAttackAnimTop then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) + tileW / 2, (drawnAttackingCharacter.y * tileH + offsetY), math.pi, 1, 1, tileW / 2, tileH / 2)
                self.drawAttackAnimTop = false
            end

            if self.drawAttackAnimLeft then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) - tileW / 2, (drawnAttackingCharacter.y * tileH + offsetY) + (tileH / 2), math.pi / 2, 1, 1, tileW / 2, tileH / 2)
                self.drawAttackAnimLeft = false
            end

            if self.drawAttackAnimRight then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) + (tileW + tileW / 2), (drawnAttackingCharacter.y * tileH + offsetY) + (tileH / 2), math.pi * 1.5, 1, 1, tileW / 2, tileH / 2)
                self.drawAttackAnimRight = false
            end

            if self.drawAttackAnimTopRight then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) + (tileW + tileW / 2), (drawnAttackingCharacter.y * tileH + offsetY), math.pi * 1.25, 1, 1, tileW / 2, tileH / 2)
                self.drawAttackAnimTopRight = false
            end

            if self.drawAttackAnimTopLeft then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX), (drawnAttackingCharacter.y * tileH + offsetY), math.pi * 0.75, 1, 1, tileW / 2, tileH / 2)
                self.drawAttackAnimTopLeft = false
            end

            if self.drawAttackAnimBottomLeft then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) - tileW / 2, (drawnAttackingCharacter.y * tileH + offsetY) + (tileH), math.pi * 0.25, 1, 1, tileW / 2, tileH / 2)
                self.drawAttackAnimBottomLeft = false
            end

            if self.drawAttackAnimBottomRight then
                attackAnimation:draw(attackAnimationImage, (drawnAttackingCharacter.x * tileW + offsetX) + (tileW), (drawnAttackingCharacter.y * tileH + offsetY) + (tileH), math.pi * 1.75, 1, 1, tileW / 2, tileH / 2)
                self.drawAttackAnimBottomRight = false
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
            if self.x + 1 < 11 then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
            if self.x - 1 > 0 then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
        end
        end

    end


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
 
    if self.parentPlayer == activePlayer and gameState.state ~= gameState.states.selectSpellTargetArea then

        if selectedChar and self ~= selectedChar then
            selectedChar.isActionMenuDrawn = false
            selectedChar = nil
            gameState:changeState(gameState.states.selectCharacter)
            return
        end

        if gameState.state == gameState.states.selectCharacterAction then
            selectedChar:chooseActionMenu(mX, mY)
            return
        end

        if gameState.state == gameState.states.selectCharacter then
            selectedChar = self
            selectedChar.isActionMenuDrawn = true
            gameState:changeState(gameState.states.selectCharacterAction)
            return
        end
      
    end



end

function Character:chooseActionMenu(mx, my)
    local cx = self.x * tileW + offsetX
    local cy = self.y * tileH + offsetY

    if gameState.state == gameState.states.selectCharacterAction then
        -- BAl FELSO NEGYED - ATTACK STATE
        if  mx > cx and mx < cx + tileW / 2 and  my > cy and my < cy + tileH / 2 and self.actionPoints ~= 0 then
                gameState:changeState(gameState.states.selectAttackTargetCharacter)
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
                return
        end
    else    
                gameState:changeState(gameState.states.selectCharacter)
                return
                
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
            print(self.x, cx, self.y, cy)
            if oldx == nil then oldx = 1 end
            if oldy == nil then oldy = 1 end
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
            table.remove(self.parentPlayer.characters, index)
        end   
    end

end

function Character:attack(enemy)
    table.insert(sequenceBufferTable, {
        name = "AttackEnemyCharacter",
        duration = 0.1,
        sequenceTime = love.timer.getTime(),
        action = function()
            if gameState.state == gameState.states.selectAttackTargetCharacter and self.actionPoints ~= 0 then
                local dr = getDiceRoll()
                self.diceRoll = dr
                self.rolledAttack = self.baseAttack + dr + boardGrid[self.x][self.y].attackModifier + self.turnAttackModifier
                damage = math.max(0, self.rolledAttack - (enemy.baseDefense + boardGrid[enemy.x][enemy.y].defenseModifier + enemy.turnDefenseModifier))

                self.enableDivineDice = false

                if damage == 0 then
                    self.enableDivineDice = true
                    self.divineDiceRoll = love.math.random(1, 6)
                    if self.divineDiceRoll > 3 then
                        damage = damage + 1
                    end

                    if self.divineDiceRoll == 6 then
                        damage = damage + 1
                    end
                
                end

                enemy.baseHP = enemy.baseHP - damage
                if enemy.baseHP <= 0 then enemy:kill() end
                enableDrawAttack(self, enemy)
                self.actionPoints = self.actionPoints - 1
                enemy = nil
            end
        end
    })
end


function Character:spell(targetCell)
end




return Character