local Cell = class("Cell")

function Cell:init(x, y, isWalkable, quad, attackModifier, defenseModifier, HP, infoText, name)
    self.x = x
    self.y = y
    self.isWalkable = isWalkable
    self.quad = quad
    self.attackModifier = attackModifier
    self.defenseModifier = defenseModifier
    self.HP = HP
    self.infoText = infoText
    self.name = name


    self.poisoningTurn = 0
    self.fireTurn = 0
    self.freezeTurn = 0
    self.burntFieldTimer = 0
    self.drawLightning = 0
    self.turnAttackModifier = 0
    self.turnDefenseModifier = 0
    
end

function Cell:updateHover(mX, mY)
    local  mouseCellCoordinateX = math.floor((mX / tileW) - offsetX / tileW) 
    local  mouseCellCoordinateY = math.floor((mY / tileH) - offsetY / tileH)

    if  mouseCellCoordinateX == self.x and mouseCellCoordinateY == self.y then
        self.isHovered = true
    else
        self.isHovered = false
    end
end

function Cell:update(dt)

    --tween

    for x = 1, 10 do
        for y = 1, 10 do
            if boardGrid[x][y].drawDamageOnBoard == true then
             dmgTween:update(dt)
              
            end
        end
    end

    --animations

    ghostAnimation:update(dt)
    eruptionAnimation:update(dt)



end


function Cell:drawGhostAnim()

    local duration = 1
    
    for x = 1,10 do
        for y = 1, 10 do

            if boardGrid[x][y].drawGhost then

                if love.timer.getTime() - boardGrid[x][y].ghostTimer <= duration then
               
                    ghostAnimation:draw(ghostAnimationImage, x * tileW + offsetX, y * tileH + offsetY)

                end
            
            end
        end
    end

   
end

function Cell:drawVolcanoAnim()

    local duration = 1
   
    for x = 1,10 do
        for y = 1, 10 do

            if boardGrid[x][y].isErupting then

                 if love.timer.getTime() - boardGrid[x][y].eruptionTimer <= duration then
               
                     eruptionAnimation:draw(eruptionAnimationImage, (x * tileW + offsetX) - tileW, (y * tileH + offsetY) - tileH)

                 end
            
          end

        end
    end

   
end

function Cell:moveSelectedCharIfValidOffset(ox, oy)
    
    if ((selectedChar.x + ox <= 10 and selectedChar.x + ox >= 1) and (self.x == selectedChar.x + ox and self.y == selectedChar.y + oy)) or
       ((selectedChar.y + oy <= 10 and selectedChar.y + oy >= 1) and (self.y == selectedChar.y + oy and self.y == selectedChar.y + oy)) then
            if selectedChar.x + ox == self.x and
                selectedChar.y + oy == self.y then

                           
                    if isGameServer then
                        local cp = {selectedChar.id, self.x, self.y, selectedChar.x, selectedChar.y}
                        server:sendToAll("servercharacterpositionchanging", cp)
                    end

                    if isGameClient then
                        local cp = {selectedChar.id, self.x, self.y, selectedChar.x, selectedChar.y}
                        client:send("clientcharacterpositionchanging", cp)
                    end
                   

                    selectedChar:move(selectedChar.x + ox, selectedChar.y + oy, selectedChar.x, selectedChar.y)
              
            else

                gameState:changeState(gameState.states.selectCharacter)

            end
    end
      
end

function Cell:iceSlide(selectedChar)
end

function Cell:spawnParticlesWhenInstanced()
    for x = 1, 10 do
        for y = 1, 10 do
            local cell = boardGrid[x][y]
            local x = ((cell.x) * tileW + offsetX) + tileW / 2
            local y = (cell.y * tileH + offsetY) + tileH / 2

            if cell.isInstanced then
                if cell:instanceOf(Mount) then
                    love.graphics.draw(rockParticleSystem, x, y) 
                    rockParticleSystem:emit(200)
             
                end
                
                if cell:instanceOf(Forest) or cell:instanceOf(Field) then
                    love.graphics.draw(forestFieldParticleSystem, x, y) 
                    forestFieldParticleSystem:emit(200)
                 
                end

                if cell:instanceOf(Lake) then
                    love.graphics.draw(waterParticleSystem, x, y) 
                    waterParticleSystem:emit(2000)
                  
                end

                if cell:instanceOf(Desert) then
                    love.graphics.draw(desertParticleSystem, x, y) 
                    desertParticleSystem:emit(200)
              
                end

                if cell:instanceOf(Ice) then
                    love.graphics.draw(iceParticleSystem, x, y) 
                    desertParticleSystem:emit(200)
                 
                end

                if cell:instanceOf(GlassMount) then
                    love.graphics.draw(glassParticleSystem, x, y) 
                    glassParticleSystem:emit(200)
               
                end

                if cell:instanceOf(MagicForest) then
                    love.graphics.draw(magicParticleSystem, x + 5, y + 5) 
                    desertParticleSystem:emit(32000)
                    love.graphics.draw(magicParticleSystem, x - 5, y - 5) 
                    desertParticleSystem:emit(200)
                    love.graphics.draw(magicParticleSystem, x, y) 
                    desertParticleSystem:emit(200)
                    desertParticleSystem:emit(200)
               
                end

            end
            --- OTHER PARTICLES
            if cell.isBurntField then
                    
                            
                burntFieldParticleSystem:emit(29) 
                love.graphics.setBlendMode("add")
                love.graphics.draw(burntFieldParticleSystem, x + tileW / 2 ,y + tileH)
                love.graphics.setBlendMode("alpha")


            end

            if cell.isSteaming then
                steamParticleSystem:emit(516)
                love.graphics.setBlendMode("add")
                love.graphics.draw(steamParticleSystem, x + tileW / 2, y + tileH / 2)
                love.graphics.setBlendMode("alpha")

            end

            if cell.isSmoking then
                smokeParticleSystem:emit(54)
              love.graphics.setBlendMode("add")
                love.graphics.draw(smokeParticleSystem, x , y + tileW - (tileW / 4))
              love.graphics.setBlendMode("alpha")
            end

            


        end
    end

end


function Cell:drawLightningOnBoard()
    for x = 1, 10 do
        for y = 1, 10 do
            if boardGrid[x][y].drawLightning == true then
                love.graphics.draw(lightningImage, boardGrid[x][y].x * tileW + offsetX, boardGrid[x][y].y * tileH + offsetY)
            end
        end
    end


end

function Cell:damageOnBoard(dmg)

 
    for x = 1, 10 do
        for y = 1, 10 do
            if boardGrid[x][y].drawDamageOnBoard == true then

                dmgToDraw = { x=(x * tileW + offsetX), y = y * tileH + offsetY, text = dmg }
                dmgTween = tween.new(10, dmgToDraw, {y= dmgToDraw.y - tileH / 2}, 'outSine')
                boardGrid[x][y].drawDamageTime = love.timer.getTime()


                
              
            end
        end
    end

end

function Cell:drawDamageOnBoard()

    for x = 1, 10 do
        for y = 1, 10 do
            if boardGrid[x][y].drawDamageOnBoard == true then
               
                local duration = 2
                if love.timer.getTime() - boardGrid[x][y].drawDamageTime <= duration then
                    print(love.timer.getTime() - boardGrid[x][y].drawDamageTime)
                    love.graphics.setColor(yellowColor)
                    love.graphics.setFont(font)
                    love.graphics.print("KOLBASZ", 1, 1)
                    love.graphics.print(dmgToDraw.text, dmgToDraw.x + 1, dmgToDraw.y - 1)
                    love.graphics.setColor(charColor)
                
                    love.graphics.setColor(selectedColor)
                    love.graphics.setFont(font)
                    love.graphics.print(dmgToDraw.text, dmgToDraw.x, dmgToDraw.y)
                    love.graphics.setColor(charColor)
                else
                    boardGrid[x][y].drawDamageOnBoard = false
                    gameState:changeState(gameState.states.selectCharacter)

                end
                
            end
                        
        end
    end





end

function Cell:drawFireParticles()
    for x = 1, 10 do
        for y = 1, 10 do
            local cell = boardGrid[x][y]
            if cell.isOnFire then
                    local x = (cell.x * tileW + offsetX) + tileW / 2
                    local y = (cell.y * tileH + offsetY) + tileH / 2
                    love.graphics.draw(fireParticleSystem, x, y)
                    fireParticleSystem:emit(3)
            end
        end
    end


end

function Cell:drawPrisonCell()
    for x = 1, 10 do
        for y = 1, 10 do

           local cell = boardGrid[x][y]

            if cell.isPrison then
                love.graphics.draw(prisonImage, cell.x * tileW + offsetX, cell.y * tileH + offsetY)
            end

        end
    end

end

function Cell:click()

    if self.isOccupied then

        if self:instanceOf(Volcano) then
            return
        end

        if gameState.state ~= gameState.states.selectMoveTargetCell and gameState.state ~= gameState.states.selectAttackTargetCharacter and gameState.state ~= gameState.states.selectSpellTargetArea then

            if gameState.state == gameState.states.selectCharacter and self.occupiedBy.parentPlayer == activePlayer and (self.occupiedBy.stepPoints ~= 0 or self.occupiedBy.actionPoints ~= 0) then
                    selectedChar = self.occupiedBy
                    selectedChar.isActionMenuDrawn = true
                    gameState:changeState(gameState.states.selectCharacterAction)
                return
            end
            if gameState.state == gameState.states.selectCharacterAction and self.occupiedBy.parentPlayer == activePlayer and self.occupiedBy ~= selectedChar then
                    selectedChar = self.occupiedBy

                    selectedChar.isActionMenuDrawn = true
                    gameState:changeState(gameState.states.selectCharacterAction)
                    return
            end

        end
        
        if selectedChar and selectedChar.parentPlayer ~= self.occupiedBy.parentPlayer and gameState.state == gameState.states.selectAttackTargetCharacter then
            if  (self.occupiedBy.x + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.occupiedBy.x + 1][self.occupiedBy.y] and boardGrid[self.occupiedBy.x][self.occupiedBy.y]:instanceOf(Lake) == false )  or
                (self.occupiedBy.x - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.occupiedBy.x - 1][self.occupiedBy.y] and boardGrid[self.occupiedBy.x][self.occupiedBy.y]:instanceOf(Lake) == false )   or
                (self.occupiedBy.y + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.occupiedBy.x][self.occupiedBy.y + 1] and boardGrid[self.occupiedBy.x][self.occupiedBy.y]:instanceOf(Lake) == false )   or
                (self.occupiedBy.y - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.occupiedBy.x][self.occupiedBy.y - 1] and boardGrid[self.occupiedBy.x][self.occupiedBy.y]:instanceOf(Lake) == false )    or
                (self.occupiedBy.x + 1 <= 10 and self.occupiedBy.y + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.occupiedBy.x + 1][self.occupiedBy.y + 1] and boardGrid[self.occupiedBy.x][self.occupiedBy.y]:instanceOf(Lake) == false )  or
                (self.occupiedBy.x - 1 > 0 and self.occupiedBy.y + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.occupiedBy.x - 1][self.occupiedBy.y + 1] and boardGrid[self.occupiedBy.x][self.occupiedBy.y]:instanceOf(Lake) == false )  or
                (self.occupiedBy.x + 1 <= 10 and self.occupiedBy.y - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.occupiedBy.x + 1][self.occupiedBy.y - 1] and boardGrid[self.occupiedBy.x][self.occupiedBy.y]:instanceOf(Lake) == false ) or
                (self.occupiedBy.x - 1 > 0 and self.occupiedBy.y - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.occupiedBy.x - 1][self.occupiedBy.y - 1] and boardGrid[self.occupiedBy.x][self.occupiedBy.y]:instanceOf(Lake) == false ) then
                    if isGameServer then
                        local cp = {self.occupiedBy.id, selectedChar.id}
                        server:sendToAll("server_attack", cp)
                    end
                    if isGameClient then
                        local cp = {self.occupiedBy.id, selectedChar.id}
                        client:send("client_attack", cp)
                    end
                        selectedChar:attack(self.occupiedBy)
            return
            end
        end

        if gameState.state == gameState.states.selectCharacterAction and (selectedChar.stepPoints ~= 0 or selectedChar.actionPoints ~= 0) and selectedChar.parentPlayer == self.occupiedBy.parentPlayer then
                selectedChar:chooseActionMenu(mouseX, mouseY)
                return
        end

    end




    if gameState.state == gameState.states.selectCharacterAction then
        
        if self.isOccupied ~= true then
            
            selectedChar = nil
            gameState:changeState(gameState.states.selectCharacter)

        end
    return

    end

    if gameState.state == gameState.states.selectAttackTargetCharacter then

        local x = math.floor((mouseX / tileW) - offsetX / tileW)
        local y = math.floor((mouseY / tileH) - offsetY / tileH)
        
      
       
        if boardGrid[x][y].isAttackable ~= true and (selectedChar.x ~= x or selectedChar.y ~= y) then
          
            
            gameState:changeState(gameState.states.selectCharacterAction)
        
        end
     return 

    end


    if gameState.state == gameState.states.selectMoveTargetCell and selectedChar.isWalkable[self.class.name] and not self.isOccupied then


        for x = -1, 1 do
            for y = -1, 1 do
               if x ~= 0 or y ~= 0 then 
                   
                    self:moveSelectedCharIfValidOffset(x, y)
                end
            end
        end   

    return
    end

    if selectedChar and self.occupiedBy ~= selectedChar and gameState.state == gameState.states.selectSpellTargetArea then
        
        if isGameServer then
            local ssend = {}
            ssend[1] = self.x
            ssend[2] = self.y
            ssend[3] = selectedChar.id

                if selectedChar.id == 2 then

                    local direction

                    if pointerOnTopLeftSide then 
                        direction = "tl"
                    elseif pointerOnTopRightSide then
                        direction = "tr"
                    elseif pointerOnBottomRightSide then
                        direction = "br"
                    elseif pointerOnBottomLeftSide then
                        direction = "bl"
                    end
                
                    ssend[4] = direction
                
                end

                if selectedChar.id == 7 then

                    if ((self.x == selectedChar.x + 1 or self.x == selectedChar.x - 1) or  (self.x == selectedChar.x + 2 or self.x == selectedChar.x - 2) and (self.y == selectedChar.y)) or
                        ((self.y == selectedChar.y + 1 or self.y == selectedChar.y - 1) or  (self.y == selectedChar.y + 2 or self.y == selectedChar.x - 2) and (self.x == selectedChar.x)) then
                            
                            server:sendToAll("server_characterspell", ssend)
       
                    end
    
                elseif selectedChar.id ~= 2 then
    
              
                            if (self.x == selectedChar.x + 1 or self.x == selectedChar.x - 1) or (self.y == selectedChar.y + 1 or self.y == selectedChar.y - 1) then
                                server:sendToAll("server_characterspell", ssend)
                            
                            end

                else
              
                            if ((self.x == selectedChar.x + 1 or self.x == selectedChar.x - 1) or (self.x == selectedChar.x + 2 or self.x == selectedChar.x - 2)) and
                               ((self.y == selectedChar.y + 1 or self.y == selectedChar.y - 1) or (self.y == selectedChar.y + 2 or self.y == selectedChar.y - 2)) then
                                selectedChar:spell(self)
                                server:sendToAll("server_characterspell", ssend)
                     
                            end
                      
                 end
       
        end
        
        if isGameClient then
                local clsend = {}
                clsend[1] = self.x
                clsend[2] = self.y
                clsend[3] = selectedChar.id
                if selectedChar.id == 2 then
                    local direction
                    if pointerOnTopLeftSide then 
                        direction = "tl"
                    elseif pointerOnTopRightSide then
                        direction = "tr"
                    elseif pointerOnBottomRightSide then
                        direction = "br"
                    elseif pointerOnBottomLeftSide then
                        direction = "bl"
                    end
                
                    clsend[4] = direction
                
                end


                if selectedChar.id == 7 then

                    if ((self.x == selectedChar.x + 1 or self.x == selectedChar.x - 1) or  (self.x == selectedChar.x + 2 or self.x == selectedChar.x - 2) and (self.y == selectedChar.y)) or
                        ((self.y == selectedChar.y + 1 or self.y == selectedChar.y - 1) or  (self.y == selectedChar.y + 2 or self.y == selectedChar.x - 2) and (self.x == selectedChar.x)) then
                            
                            client:send("client_characterspell", clsend)

                    end
    
            
    
                elseif selectedChar.id ~= 2 then
    
              
                            if (self.x == selectedChar.x + 1 or self.x == selectedChar.x - 1) or (self.y == selectedChar.y + 1 or self.y == selectedChar.y - 1) then
                                client:send("client_characterspell", clsend)
       
                            
                            end
                
    
                   
                else
    
              
                            if ((self.x == selectedChar.x + 1 or self.x == selectedChar.x - 1) or (self.x == selectedChar.x + 2 or self.x == selectedChar.x - 2)) and
                               ((self.y == selectedChar.y + 1 or self.y == selectedChar.y - 1) or (self.y == selectedChar.y + 2 or self.y == selectedChar.y - 2)) then
                                selectedChar:spell(self)
                                client:send("client_characterspell", clsend)
                            
                            end
                    
                 end
                
               
        end

      


            if selectedChar.id == 7 then

                if ((self.x == selectedChar.x + 1 or self.x == selectedChar.x - 1) or  (self.x == selectedChar.x + 2 or self.x == selectedChar.x - 2) and (self.y == selectedChar.y)) or
                    ((self.y == selectedChar.y + 1 or self.y == selectedChar.y - 1) or  (self.y == selectedChar.y + 2 or self.y == selectedChar.x - 2) and (self.x == selectedChar.x)) then
                        
                        selectedChar:spell(self)
                
                else
                    gameState:changeState(gameState.states.selectCharacterAction)
                
                
                end

        

            elseif selectedChar.id ~= 2 then

          
                        if (self.x == selectedChar.x + 1 or self.x == selectedChar.x - 1) or (self.y == selectedChar.y + 1 or self.y == selectedChar.y - 1) then
                            selectedChar:spell(self)
                        
                        else
                            gameState:changeState(gameState.states.selectCharacterAction)
                        
                        
                        end
            

               
            else

          
                        if ((self.x == selectedChar.x + 1 or self.x == selectedChar.x - 1) or (self.x == selectedChar.x + 2 or self.x == selectedChar.x - 2)) and
                           ((self.y == selectedChar.y + 1 or self.y == selectedChar.y - 1) or (self.y == selectedChar.y + 2 or self.y == selectedChar.y - 2)) then
                            selectedChar:spell(self)
                            
                        else
                            gameState:changeState(gameState.states.selectCharacterAction)
                           
                        
                        end
                    
             end

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


    if self.isPrison then
         

                       if character.parentPlayer == playerOne and self.x == 8 and self.y == 3 then

                            table.insert(sequenceBufferTable, {
                                name = "startingCellwasOccupiedSoMovingToanotherPosition",
                                duration = 0.3,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    deadPool.playerOne[1].x = randomFunction(1, 10, "cell:onentry prison")
                                    deadPool.playerOne[1].y = randomFunction(1, 10, "cell:onentry prison")
                                    if boardGrid[deadPool.playerOne[1].x][deadPool.playerOne[1].y].isOccupied then
                                        deadPool.playerOne[1].x = 1
                                        deadPool.playerOne[1].y = 1
                                    end
                                    deadPool.playerOne[1].baseHP = math.floor((deadPool.playerOne[1].maxHP / 100) * 60)
                                    deadPool.playerOne[1].actionPoints = 0
                                    deadPool.playerOne[1].stepPoints = 0
                                    table.insert(character.parentPlayer.characters, deadPool.playerOne[1])
                                    table.remove(deadPool.playerOne)
                                end
                            })

                             self.isPrison = false

                        end

                
                    

                       if character.parentPlayer == playerTwo and self.x == 3 and self.y == 8 then

                        local currentChar = deadPool.playerTwo[1]

                            table.insert(sequenceBufferTable, {
                                name = "startingCellwasOccupiedSoMovingToanotherPosition",
                                duration = 0.3,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    currentChar.x = randomFunction(1, 10, "cell:onentry prison")
                                    currentChar.y = randomFunction(1, 10, "cell:onentry prison")
                                    if boardGrid[currentChar.x][currentChar.y].isOccupied then
                                        currentChar.x = 1
                                        currentChar.y = 1
                                    end
                                    currentChar.baseHP = math.floor((currentChar.maxHP / 100) * 60)
                                    currentChar.actionPoints = 0
                                    currentChar.stepPoints = 0
                                    table.insert(character.parentPlayer.characters, currentChar)
                                    table.remove(deadPool.playerTwo)
                                end
                            })

                             self.isPrison = false
                        end
                 

               
                
            
    end


  



    if self.isOnFire then
        local fireDamage = 5
        for index, currentChar in ipairs(activePlayer.characters) do
            if currentChar == selectedChar then
                currentChar:damage(currentChar, fireDamage)
            end

        end

        for index, currentChar in ipairs(inactivePlayer.characters) do
            if currentChar == selectedChar then
                currentChar:damage(currentChar, fireDamage)
            end

        end
    end

    if self.isPoisoned then

        local poisonDamage = 3

        for index, currentChar in ipairs(activePlayer.characters) do
            if currentChar == selectedChar and currentChar.isPoisoned ~= true then
                
                currentChar.isPoisoned = true
                currentChar.poisoningTurn = turnCounter
                currentChar:damage(currentChar, 3)
            end
        end
    
            for index, currentChar in ipairs(inactivePlayer.characters) do
                if currentChar == selectedChar and currentChar.isPoisoned ~= true then
                 
                    currentChar.isPoisoned = true
                    currentChar.poisoningTurn = turnCounter
                    currentChar:damage(currentChar, 3)
                end
            end
        end
    








end

function Cell:resetParticleDrawing()
    table.insert(sequenceBufferTable, {
        name = "resetParticleDrawing",
        duration = 0.1,
        sequenceTime = love.timer.getTime(),
        action = function()

            for x = 1, 10 do
                for y = 1, 10 do
                    boardGrid[x][y].isInstanced = false
                end
            end
        end
    })
end



return Cell