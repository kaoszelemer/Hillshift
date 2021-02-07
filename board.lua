board = {}

tileW = 64
tileH = 64
local maxRow = 10
local maxCol = 10

---Típustáblák definiálása
cellType = {
    Forest, Mount, Lake, Field
}
--tileset
boardPicture = love.graphics.newImage("/graphics/tileset4.png")
--icons
attackIcon = love.graphics.newImage("graphics/attackicon.png")
moveIcon = love.graphics.newImage("graphics/moveicon.png")
spellIcon = love.graphics.newImage("graphics/spellicon.png")
defenseIcon = love.graphics.newImage("graphics/shieldicon.png")
fireIcon = love.graphics.newImage("graphics/fireicon.png")
frozenIcon = love.graphics.newImage("graphics/frozenicon.png")
poisonIcon = love.graphics.newImage("graphics/poisonicon.png")
defendedCellIcon = love.graphics.newImage("graphics/defendedcellicon.png")
--borders
frozenGridBorder = love.graphics.newImage("graphics/frozenborder.png")
poisonGridBorder = love.graphics.newImage("graphics/poisonborder.png")
fireGridBorder = love.graphics.newImage("graphics/fireborder.png")
--validMove images
validAttackImage = love.graphics.newImage("graphics/validattack.png")
validStepImage = love.graphics.newImage("graphics/validstep.png")
validSpellImage = love.graphics.newImage("graphics/validspell.png")
--Endturn button
endTurnButtonImage = love.graphics.newImage("graphics/endturnbutton.png")
endTurnButtonClickedImage = love.graphics.newImage("graphics/endturnbuttonclicked.png")
--Event UI
eventBackgroundImage = love.graphics.newImage("/graphics/eventbackground.png")
eventWarningImage = love.graphics.newImage("/graphics/eventbanner.png")




--1a. a tileset változói
tilesetW, tilesetH = boardPicture:getWidth(), boardPicture:getHeight()
--2, a cella típusuk definiálása a quadokból   
cellQuadTable = {

    forest = {
        
        love.graphics.newQuad(0, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(64, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(128, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(192, 0, tileW, tileH, tilesetW, tilesetH)
    },

    field = {
        love.graphics.newQuad(256, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(320, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(384, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(448, 0, tileW, tileH, tilesetW, tilesetH)
    },

    mount = {
        love.graphics.newQuad(0, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(64, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(128, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(192, 64, tileW, tileH, tilesetW, tilesetH)
    },

    lake = {
        love.graphics.newQuad(256, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(320, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(384, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(448, 64, tileW, tileH, tilesetW, tilesetH)
    },
}

local function initPlayerDeck(player)

    table.insert(player.characters, GeoGnome(player))
    table.insert(player.characters, AirElemental(player))
    table.insert(player.characters, Alchemist(player))
    table.insert(player.characters, FireMage(player))
    table.insert(player.characters, Druid(player))
    table.insert(player.characters, IceWizard(player))
    

    while #player.characters ~= 4 do     
        local cardNumber = love.math.random(1, #player.characters)
        table.remove(player.characters, cardNumber)
    end

end

local function testBoardForOccupy(activeplayer, inactiveplayer)

    for x = 1, 10 do
        for y = 1, 10 do

            for index, currentChar in ipairs(activeplayer.characters) do
                if boardGrid[x][y].x == currentChar.x and boardGrid[x][y].y == currentChar.y then
                        boardGrid[x][y].isOccupied = true
                        boardGrid[x][y].occupiedBy = currentChar
                end
            end


            for index, currentChar in ipairs(inactiveplayer.characters) do
                if boardGrid[x][y].x == currentChar.x and boardGrid[x][y].y == currentChar.y then
                    boardGrid[x][y].isOccupied = true
                    boardGrid[x][y].occupiedBy = currentChar
                end
            end


            
        end
    end


end

function getDiceRoll()
   local diceRoll = love.math.random(1, 6)
   return diceRoll
end

local function drawCharactersOnBoard(player)
    -- státuszok alapján beállítom a színeket
    for _, currentChar in ipairs(player.characters) do
     currentChar:draw()
    end

end


local function drawStatsOnSideBarPlayerOne(playerone)
    local pxp = width / 6



    love.graphics.setFont(littleFont)

    for _, currentChar in ipairs(playerone.characters) do
        for i = 1, #playerone.characters do  


            for _, row in ipairs(boardGrid) do
                for _, cell in ipairs(row) do
                    if cell.isOccupied and cell.occupiedBy == playerone.characters[i] then
                        if cell.isPoisoned then
                            love.graphics.draw(poisonIcon, pxp - 128, (i * 100) + 12)
                            love.graphics.setColor(selectedColor)
                            love.graphics.print("-3 DF, -1 AT", pxp - 200, (i * 100) + 24)
                            love.graphics.setColor(charColor)
                        end
                        if cell.isFrozen then
                            love.graphics.draw(frozenIcon, pxp - 128, (i * 100) + 44)
                            love.graphics.setColor(selectedColor)
                            love.graphics.print("0 SP NEXT TURN", pxp - 200, i * 100 + 56)
                            love.graphics.setColor(charColor)
                        end
                        if cell.isOnFire then
                            love.graphics.draw(fireIcon, pxp - 128, (i * 100) + 76)
                            love.graphics.setColor(selectedColor)
                            love.graphics.print("-2 HP TURN END", pxp - 200, i * 100 + 88)
                            love.graphics.setColor(charColor)
                        end

                        love.graphics.draw(boardPicture, cell.quad, pxp - 96, i * 108)

                        if cell:instanceOf(Lake) then
                            love.graphics.setColor(selectedColor)
                            love.graphics.print("0 AP NEXT TURN", pxp - 200, 10 + (i * 128))
                            love.graphics.setColor(charColor)
                        end

                        if cell:instanceOf(Mount) then
                            love.graphics.setColor(greenColor)
                            love.graphics.print("+1 AT", pxp + 35, 85 + (i * 100))
                            love.graphics.setColor(charColor)
                        end

                        if cell:instanceOf(Forest) then
                            love.graphics.setColor(greenColor)
                            love.graphics.print("+1 DF", pxp + 35, 70 + (i * 100))
                            love.graphics.setColor(charColor)
                        end

                        if cell:instanceOf(BurntField) then
                            love.graphics.setColor(selectedColor)
                            love.graphics.draw(fireIcon, pxp - 128, (i * 100) + 76)
                            love.graphics.print("-1HP TURN END", pxp - 200, 10 + (i * 128))
                            love.graphics.setColor(charColor)
                        end


                    end

                end
            end



    love.graphics.setColor(charColor)
    love.graphics.setFont(statFont)
    if inactivePlayer == playerone then 
        love.graphics.print(playerone.name, pxp, 50)
    end
       
                if activePlayer == playerone then
                    love.graphics.print(playerone.name .. " - IT'S YOUR TURN", pxp, 50)
                    love.graphics.setLineWidth(2)
                    love.graphics.setColor(charColor)
                    love.graphics.rectangle("line", pxp - 128, 10 + i * 100, 210, 128)
                    love.graphics.setColor(charColor)
                    love.graphics.setLineWidth(1)
                    love.graphics.print("PLAYER ONE'S TURN  -  TURN: #" .. turnCounter, (width / 2) - 100, 10)

                 --[[    love.graphics.setLineWidth(2)
                    love.graphics.setColor(charColor)
                    love.graphics.rectangle("line", pxp - 96, i * 108, 64, 64)
                    love.graphics.setColor(charColor)
                    love.graphics.setLineWidth(1) ]]
                    
                    love.graphics.setFont(pointFont)
                    love.graphics.print("SP: " ..  playerone.characters[i].stepPoints, pxp - 112, 64 + i * 110)
                    love.graphics.print("AP: " ..  playerone.characters[i].actionPoints, pxp - 52, 64 + i * 110)
                    love.graphics.setFont(statFont)
                end



                love.graphics.draw(playerone.characters[i].image, pxp - 96, i * 108)

                love.graphics.print(playerone.characters[i].name, pxp, 10 + i * 100)

                if playerone.characters[i].baseHP <= 3 then
                    love.graphics.setColor(selectedColor)
                 love.graphics.print("HP: " ..  playerone.characters[i].baseHP .. "!!!", pxp, 55 + i * 100)
                    love.graphics.setColor(charColor)
                else
                love.graphics.print("HP: " ..  playerone.characters[i].baseHP, pxp, 55 + i * 100)
                end
                love.graphics.print("DF: " ..  playerone.characters[i].baseDefense, pxp, 70 + i * 100)
                love.graphics.print("AT: " ..  playerone.characters[i].baseAttack, pxp, 85 + i * 100)
               -- love.graphics.print("x: " ..  playerone.characters[i].x .. "y: " ..  playerone.characters[i].y, 200, 90 + i * 100)

              --  if      playerone.characters[i].isSelected then love.graphics.print("Selected", 200, 70 + i * 100)
              --  elseif  playerone.characters[i].isHovered then love.graphics.print("Hovered", 200, 70 + i * 100)
              --  end
               --[[  if  playerone.characters[i].isInAttackState then love.graphics.print("ATTACK MODE", (width / 2) - 200, 10)
                elseif  playerone.characters[i].isInStepState then love.graphics.print("STEP MODE", (width / 2) - 200, 10)
                elseif  playerone.characters[i].isInSpellState then love.graphics.print("SPELL MODE", (width / 2) - 200, 10)
                elseif  playerone.characters[i].isInDefenseState then love.graphics.print("DEFENSE MODE", (width / 2) - 200, 10)   
                end ]]
               

            end
        end



     
    love.graphics.setFont(font)
end

local function drawStatsOnSideBarPlayerTwo(playertwo)
    local pxp = width / 6 * 4.6
    love.graphics.setFont(littleFont)
    
    for index, value in ipairs(playertwo.characters) do
        for i = 1, #playertwo.characters do


                for _, row in ipairs(boardGrid) do
                    for _, cell in ipairs(row) do

                        if cell.isOccupied and cell.occupiedBy == playertwo.characters[i] then
                            if cell.isPoisoned then
                                love.graphics.draw(poisonIcon, pxp + 192, (i * 100) + 12)
                                love.graphics.setColor(selectedColor)
                                love.graphics.print("-3 DF, -1 AT", pxp + 228, i * 100 + 24)
                                love.graphics.setColor(charColor)
                            end
                            if cell.isFrozen then
                                love.graphics.draw(frozenIcon, pxp + 192, (i * 100) + 44)
                                love.graphics.setColor(selectedColor)
                                love.graphics.print("0 SP NEXT TURN", pxp + 228, i * 100 + 56)
                                love.graphics.setColor(charColor)
                            end
                            if cell.isOnFire then
                                love.graphics.draw(fireIcon, pxp + 192, (i * 100) + 76)
                                love.graphics.setColor(selectedColor)
                                love.graphics.print("-2 HP TURN END", pxp + 228, i * 100 + 88)
                                love.graphics.setColor(charColor)
                            end

                            love.graphics.draw(boardPicture, cell.quad, pxp + 84, i * 110)

                            if cell:instanceOf(Lake) then
                                love.graphics.setColor(selectedColor)
                                love.graphics.print("0 AP NEXT TURN", pxp, 10 + (i * 128))
                                love.graphics.setColor(charColor)
                            end
                          
                            if cell:instanceOf(Mount) then
                                love.graphics.setColor(greenColor)
                                love.graphics.print("+1 AT", pxp + 35, 85 + (i * 100))
                                love.graphics.setColor(charColor)
                            end

                            if cell:instanceOf(Forest) then
                                love.graphics.setColor(greenColor)
                                love.graphics.print("+1 DF", pxp + 35, 70 + (i * 100))
                                love.graphics.setColor(charColor)
                            end

                            if cell:instanceOf(BurntField) then
                                love.graphics.setColor(selectedColor)
                                love.graphics.draw(fireIcon, pxp + 192, (i * 100) + 76)
                                love.graphics.print("-1 HP TURN END", pxp + 228, i * 100 + 88)
                                love.graphics.setColor(charColor)
                            end


                        end
                    







                    end
                end

            love.graphics.setColor(charColor)
            love.graphics.setFont(statFont)
            if inactivePlayer == playertwo then
                love.graphics.print(playertwo.name, pxp, 50)
            end
                
                        if activePlayer == playertwo then
                            love.graphics.print(playertwo.name .. " - IT'S YOUR TURN", pxp, 50)
                            love.graphics.setLineWidth(2)
                            love.graphics.setColor(charColor)
                            love.graphics.rectangle("line", pxp - 10, 10 + i * 100, 200, 128)
                            love.graphics.setColor(charColor)
                            love.graphics.setLineWidth(1)
                            love.graphics.print("PLAYER TWO'S TURN  -  TURN: #" .. turnCounter, (width / 2) - 100, 10)

                        --[[   love.graphics.setLineWidth(2)
                            love.graphics.setColor(charColor)
                            love.graphics.rectangle("line", pxp + 128, i * 108, 64, 64)
                            love.graphics.setColor(charColor)
                            love.graphics.setLineWidth(1)
        ]]
                            love.graphics.setFont(pointFont)
                            love.graphics.print("SP: " ..  playertwo.characters[i].stepPoints, pxp + 72, 64 + i * 110)
                            love.graphics.print("AP: " ..  playertwo.characters[i].actionPoints, pxp + 128, 64 + i * 110)
                            love.graphics.setFont(statFont)
            
                        end

                        love.graphics.draw(playertwo.characters[i].image, pxp + 84, 10 + i * 108)
                

                        love.graphics.print( playertwo.characters[i].name, pxp, 10 + i * 100)

                        if playertwo.characters[i].baseHP <= 3 then
                            love.graphics.setColor(selectedColor)
                         love.graphics.print("HP: " ..  playertwo.characters[i].baseHP .. "!!!", pxp, 55 + i * 100)
                            love.graphics.setColor(charColor)
                        else
                        love.graphics.print("HP: " ..  playertwo.characters[i].baseHP, pxp, 55 + i * 100)
                        end
                        love.graphics.print("DF: " ..  playertwo.characters[i].baseDefense, pxp, 70 + i * 100)
                        love.graphics.print("AT: " ..  playertwo.characters[i].baseAttack, pxp, 85 + i * 100)
                        --[[ love.graphics.print("x: " ..  playertwo.characters[i].x .. "y: " ..  playertwo.characters[i].y, 1000, 90 + i * 120)
                        
                        if      playertwo.characters[i].isSelected then love.graphics.print("Selected", 1000, 70 + i * 120)
                        elseif  playertwo.characters[i].isHovered then love.graphics.print("Hovered", 1000, 70 + i * 120)
                        end ]]
                        --[[ if  playertwo.characters[i].isInAttackState then love.graphics.print("ATTACK MODE", (width / 2 ) + 200, 10)
                        elseif  playertwo.characters[i].isInStepState then love.graphics.print("STEP MODE", (width / 2 ) + 200, 10)
                        end ]]
                        
                        love.graphics.setFont(statFont)


            end
        end
    love.graphics.setFont(font)
end


function drawPossibleDamageOnEnemyCharacter()
    local attacker
    local enemy
  
        for _, currentChar in ipairs(activePlayer.characters) do

            if currentChar.isInAttackState then
                attacker = currentChar
            end

        end

        for _, currentChar in ipairs(inactivePlayer.characters) do

            if currentChar.isHovered then
                enemy = currentChar
            end

        end

            if enemy ~= nil and attacker ~= nil then
                
            local minDamage = math.max(0, (1 + attacker.baseAttack + attacker.turnAttackModifier + boardGrid[attacker.x][attacker.y].attackModifier) - (enemy.baseDefense + boardGrid[enemy.x][enemy.y].defenseModifier + enemy.turnDefenseModifier))
            local maxDamage = math.max(0, (6 + attacker.baseAttack + attacker.turnAttackModifier + boardGrid[attacker.x][attacker.y].attackModifier) - (enemy.baseDefense + boardGrid[enemy.x][enemy.y].defenseModifier + enemy.turnDefenseModifier))

          
                love.graphics.setFont(pointFont)
                love.graphics.rectangle("fill", (enemy.x * tileW + (tileW / 4)) + offsetX, (enemy.y * tileH) + (tileH / 4) + offsetY, 40, 18)
                love.graphics.setColor(selectedColor)
                love.graphics.print(minDamage .. " - " .. maxDamage, (enemy.x * tileW + (tileW / 4)) + offsetX, (enemy.y * tileH) + (tileH / 4) + offsetY)
                love.graphics.setFont(statFont)
                love.graphics.setColor(charColor)
            end

end

function board:resetAllCharacterStates(playerone, playertwo)

    for _, currentChar in ipairs(playerone.characters) do
        currentChar.isSelected = false
        currentChar.isActionMenuDrawn = false
        currentChar.isInStepState = false
        currentChar.isInAttackState = false
      --  currentChar.isInDefenseState = false
        currentChar.isInSpellState = false
    end

    for _, currentChar in ipairs(playertwo.characters) do
        currentChar.isSelected = false
        currentChar.isActionMenuDrawn = false
        currentChar.isInStepState = false
        currentChar.isInAttackState = false
        currentChar.isInSpellState = false
      --  currentChar.isInDefenseState = false
    end

    selectedChar = nil

end

local function initBoardgrid()
    for x = 1, maxRow do boardGrid[x] = {}
        for y = 1, maxCol do 
            --start mezők beállítása  
            if      x == 5 and y == 1 or x == 5 and y == 2 or
                    x == 6 and y == 1 or x == 6 and y == 2 or
                    x == 5 and y == 9 or x == 6 and y == 9 or
                    x == 5 and y == 10 or x == 6 and y == 10 then 
                    
                    selectedType = 4
            -- egyébként legyen random
            else    selectedType = love.math.random(1, #cellType)           
            end
            -- a mezők adatai itt kerülnek be a táblázatba
            if      selectedType == 1 then boardGrid[x][y] = Forest(x, y)
            elseif  selectedType == 2 then boardGrid[x][y] = Mount(x, y) 
            elseif  selectedType == 3 then boardGrid[x][y] = Lake(x, y)    
            elseif  selectedType == 4 then boardGrid[x][y] = Field(x, y)
            end

        end
    end
end

local function moveCharactersToStartingPosition()
    for i, currentChar in ipairs(playerOne.characters) do
        if     i == 1 then currentChar:move(5, 1)
        elseif i == 2 then currentChar:move(5, 2)
        elseif i == 3 then currentChar:move(6, 1)
        elseif i == 4 then currentChar:move(6, 2)
        end
        currentChar.stepPoints = 1
    end

    for i, currentChar in ipairs(playerTwo.characters) do
        if     i == 1 then currentChar:move(5, 9)
        elseif i == 2 then currentChar:move(5, 10)
        elseif i == 3 then currentChar:move(6, 9)
        elseif i == 4 then currentChar:move(6, 10)
        end
        currentChar.stepPoints = 1
    end
end

local function drawRectanglesIfHoveredOrOccupied()
      
  -- kirajzolom a táblát
  for i=1, #boardGrid do
    for j=1, #boardGrid[i] do
        local currentCell = boardGrid[i][j] 
        local currentTileX = (currentCell.x) * tileW
        local currentTileY = (currentCell.y) * tileH

        if boardGrid[i][j].isHovered == true then
        love.graphics.setLineWidth(8)
        love.graphics.setColor(hoverColor)
        love.graphics.rectangle("line", currentTileX + offsetX , currentTileY + offsetY, tileW, tileH)
        love.graphics.setColor(charColor)
        love.graphics.setLineWidth(1)
        end

        if boardGrid[i][j].isOccupied == true and boardGrid[i][j].occupiedBy and boardGrid[i][j].occupiedBy.parentPlayer == activePlayer then
            love.graphics.setLineWidth(3)
            love.graphics.setColor(charColor)
            love.graphics.rectangle("line", currentTileX + offsetX, currentTileY + offsetY, tileW, tileH)
            love.graphics.setColor(charColor)
            love.graphics.setLineWidth(1)
        end
       
        end
    end
end

local function drawBoardGrid()
    for x = 1, 10 do
        for y = 1, 10 do 
            local cell = boardGrid[x][y]
            love.graphics.draw(boardPicture, cell.quad, cell.x * tileW + offsetX, cell.y * tileH  + offsetY)
            if cell.isOnFire then love.graphics.draw(fireGridBorder, cell.x * tileW + offsetX, cell.y * tileH + offsetY) end
            if cell.isPoisoned then love.graphics.draw(poisonGridBorder, cell.x * tileW + offsetX, cell.y * tileH + offsetY) end
            if cell.isFrozen then love.graphics.draw(frozenGridBorder, cell.x * tileW + offsetX, cell.y * tileH + offsetY) end
        end
    end
end


local function drawEndTurnButton()


    love.graphics.draw(endTurnButtonImage, width / 2 + 200, 10)

   if isEndTurnButtonClicked then
    love.graphics.draw(endTurnButtonClickedImage, width / 2 + 200, 10) 
   end
   

end

local function drawWarningForNextEvent()

    if eventTurnCounter >= nextTurnBeforeEvent - 2 then
        love.graphics.setFont(statFont)
        love.graphics.draw(eventWarningImage, width / 2 - 64, 30)
    end

end


local function drawEventOnBoard()

        Event:drawCurrentEvent()
end



function drawEventOnBackground()
        Event001:drawEventStuff()
end

function enableDrawAttack(character, enemy)

    drawAttack = true
    drawnAttackingCharacter = character
    drawnEnemyCharacter = enemy

    timerStart = love.timer.getTime()
    timerStop = 10

end

function drawAttackOnBoard()
    --- tablanak kene kirajzolni
    if drawAttack then
        local enemy = drawnEnemyCharacter
        local character = drawnAttackingCharacter
        if enemy ~= nil then
            love.graphics.setColor(charColor)
            love.graphics.setFont(statFont)
            love.graphics.print("---****------ BATTLE COMMENCES ----****--------", 10, 600)
            love.graphics.print(character.name .. " attacked " .. enemy.name, 10, 620)
            love.graphics.print(character.name .. " AT is: " .. character.baseAttack .. " + Dice: " .. character.diceRoll .. " + CM: " .. boardGrid[character.x][character.y].attackModifier .. "+ TAM: " .. character.turnAttackModifier .. " = " .. character.baseAttack + character.diceRoll + boardGrid[character.x][character.y].attackModifier + character.turnAttackModifier, 10,640)
            love.graphics.print(enemy.name .. " DF is: " .. enemy.baseDefense .. " + CM: " .. boardGrid[enemy.x][enemy.y].defenseModifier .. "+ TDM: " .. enemy.turnDefenseModifier .. " = " .. enemy.baseDefense +  boardGrid[enemy.x][enemy.y].defenseModifier + enemy.turnDefenseModifier, 10, 660)
            love.graphics.print("Battle: "  .. character.rolledAttack .. " AT - " .. enemy.baseDefense + enemy.turnDefenseModifier + boardGrid[enemy.x][enemy.y].defenseModifier .. " DF" , 10, 680)
            love.graphics.print(character.name .. " obliterated " .. enemy.name .. " with " .. damage .. " damage.", 10, 700)
            love.graphics.print(enemy.name .. " remaining HP: " .. enemy.baseHP, 10, 720)
            love.graphics.print("------------*END OF THE BATTLE*-------------", 10, 740)
            love.graphics.setFont(font)
            love.graphics.setColor(selectedColor)
            love.graphics.print("-" .. damage, (enemy.x * tileW + (tileW / 4)) + offsetX, (enemy.y * tileH) + (tileH / 4) + offsetY)
            love.graphics.setColor(charColor)
        end
    end

end


function board:load()

    playerOne = {

        name = "Player One",
        characters = {}

    }

    playerTwo = {

        name = "Player Two",
        characters = {}

    }

    initPlayerDeck(playerOne)
    initPlayerDeck(playerTwo)
    boardGrid = {}        
    initBoardgrid()
    moveCharactersToStartingPosition()

end

function board:update(dt)

    if drawAttack and love.timer.getTime() - timerStart >= timerStop then
        drawAttack = false
    end

    testBoardForOccupy(activePlayer, inactivePlayer)

end

function board:draw()
    

    --drawModifier()
    drawBoardGrid()
    drawEndTurnButton()
    drawCharactersOnBoard(playerOne)
    drawCharactersOnBoard(playerTwo)
    Character:drawValidIcons()
    drawPossibleDamageOnEnemyCharacter()
    drawStatsOnSideBarPlayerOne(playerOne)
    drawStatsOnSideBarPlayerTwo(playerTwo)
    drawRectanglesIfHoveredOrOccupied()
    drawAttackOnBoard()


    -----EVENT RAJZOLÁS
    drawEventOnBoard()
    drawEventOnBackground()
    drawWarningForNextEvent()

 
    -- for debugging:
    -- itt lehet láthatóvá tenni, hogy melyik cella, milyen indexxel rendelkezik
    -- love.graphics.print(currentCell.x .. "," .. currentCell.y, currentCell.x*tileW, currentCell.y*tileH)

end

 --for debugging
 
 --print a table

-- for k, v in pairs(characterCopy) do
--    print(k, v)
-- end

-- for k, v in ipairs(playerOne) do
--     for a, b in pairs(v) do 
--        print(a, b)
--     end
--        print(k, v)
   
--    end