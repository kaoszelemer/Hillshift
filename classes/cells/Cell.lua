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
    self.turnAttackModifier = 0
    self.turnDefenseModifier = 0
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
                    screenShake(0.05, 1)
                end
                
                if cell:instanceOf(Forest) or cell:instanceOf(Field) then
                    love.graphics.draw(forestFieldParticleSystem, x, y) 
                    forestFieldParticleSystem:emit(200)
                    screenShake(0.05, 1)
                end

                if cell:instanceOf(Lake) then
                    love.graphics.draw(waterParticleSystem, x, y) 
                    waterParticleSystem:emit(2000)
                    screenShake(0.05, 1)
                end

                if cell:instanceOf(Desert) then
                    love.graphics.draw(desertParticleSystem, x, y) 
                    desertParticleSystem:emit(200)
                    screenShake(0.05, 1)
                end

                if cell:instanceOf(Ice) then
                    love.graphics.draw(iceParticleSystem, x, y) 
                    desertParticleSystem:emit(200)
                    screenShake(0.05, 1)
                end

                if cell:instanceOf(GlassMount) then
                    love.graphics.draw(glassParticleSystem, x, y) 
                    glassParticleSystem:emit(200)
                    screenShake(0.05, 1)
                end

                if cell:instanceOf(MagicForest) then
                    love.graphics.draw(magicParticleSystem, x + 5, y + 5) 
                    desertParticleSystem:emit(32000)
                    love.graphics.draw(magicParticleSystem, x - 5, y - 5) 
                    desertParticleSystem:emit(200)
                    love.graphics.draw(magicParticleSystem, x, y) 
                    desertParticleSystem:emit(200)
                    desertParticleSystem:emit(200)
                    screenShake(0.05, 1)
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

            


        end
    end

end


function Cell:drawLightningOnBoard()
    for x = 1, 10 do
        for y = 1, 10 do
            if boardGrid[x][y].drawLightning == true then
                love.graphics.draw(lightningImage, boardGrid[x][y].x * tileW + offsetX, boardGrid[x][y].y * tileH + offsetY)
                love.graphics.setColor(selectedColor)
                love.graphics.setFont(font)
                if boardGrid[x][y]:instanceOf(Lake) and boardGrid[x][y].isOccupied then
                    love.graphics.print("-20", boardGrid[x][y].x * tileW + offsetX + 8, boardGrid[x][y].y * tileH + offsetY + 8)
                elseif boardGrid[x][y].isOccupied then
                    love.graphics.print("-10", boardGrid[x][y].x * tileW + offsetX + 8, boardGrid[x][y].y * tileH + offsetY + 8)
                end
                love.graphics.setColor(charColor)
                love.graphics.setFont(statFont)
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

            print("Cell:click - spell serverside")
            server:sendToAll("server_characterspell", ssend)
        end

        
        if isGameClient then
                local clsend = {}
                clsend[1] = self.x
                clsend[2] = self.y
                clsend[3] = selectedChar.id
                print("cell:click - spell client side")

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



                client:send("client_characterspell", clsend)
        end


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


    if self.isPrison then
                    for index, currentChar in ipairs(deadPool) do

                        if character.parentPlayer == currentChar.parentPlayer then

                            table.insert(sequenceBufferTable, {
                                name = "startingCellwasOccupiedSoMovingToanotherPosition",
                                duration = 0.3,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                                    currentChar.x = love.math.random(1, 10)
                                    currentChar.y = love.math.random(1, 10)
                                    if boardGrid[currentChar.x][currentChar.y].isOccupied then
                                        currentChar.x = 1
                                        currentChar.y = 1
                                    end
                                    currentChar.baseHP = math.floor((currentChar.maxHP / 100) * 60)
                                    table.insert(character.parentPlayer.characters, currentChar)
                                end
                            })

                             self.isPrison = false

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