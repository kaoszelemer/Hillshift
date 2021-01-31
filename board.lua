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
--borders
frozenGridBorder = love.graphics.newImage("graphics/frozenborder.png")
poisonGridBorder = love.graphics.newImage("graphics/poisonborder.png")
fireGridBorder = love.graphics.newImage("graphics/fireborder.png")
--validMove images
validAttackImage = love.graphics.newImage("graphics/validattack.png")
validStepImage = love.graphics.newImage("graphics/validstep.png")
validSpellImage = love.graphics.newImage("graphics/validspell.png")
--
endTurnButtonImage = love.graphics.newImage("graphics/endturnbutton.png")
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


    love.graphics.setColor(charColor)
    love.graphics.setFont(statFont)
    love.graphics.print(playerone.name, 200, 50)
        for index, value in ipairs(playerone.characters) do
            for i = 1, #playerone.characters do        
                love.graphics.print(playerone.characters[i].name, 200, 10 + i * 100)
                love.graphics.print("SP: " ..  playerone.characters[i].stepPoints, 200, 25 + i * 100)
                love.graphics.print("AP: " ..  playerone.characters[i].actionPoints, 200, 40 + i * 100)
                love.graphics.print("HP: " ..  playerone.characters[i].baseHP, 200, 55 + i * 100)
                love.graphics.print("DF: " ..  playerone.characters[i].baseDefense, 200, 70 + i * 100)
                love.graphics.print("AT: " ..  playerone.characters[i].baseAttack, 200, 85 + i * 100)
               -- love.graphics.print("x: " ..  playerone.characters[i].x .. "y: " ..  playerone.characters[i].y, 200, 90 + i * 100)

              --  if      playerone.characters[i].isSelected then love.graphics.print("Selected", 200, 70 + i * 100)
              --  elseif  playerone.characters[i].isHovered then love.graphics.print("Hovered", 200, 70 + i * 100)
              --  end
               --[[  if  playerone.characters[i].isInAttackState then love.graphics.print("ATTACK MODE", (width / 2) - 200, 10)
                elseif  playerone.characters[i].isInStepState then love.graphics.print("STEP MODE", (width / 2) - 200, 10)
                elseif  playerone.characters[i].isInSpellState then love.graphics.print("SPELL MODE", (width / 2) - 200, 10)
                elseif  playerone.characters[i].isInDefenseState then love.graphics.print("DEFENSE MODE", (width / 2) - 200, 10)   
                end ]]
                if playerone == activePlayer then
                    love.graphics.print("PLAYER ONE'S TURN", (width / 2) - 200, 750)
                end
            end
        end
    love.graphics.setFont(font)
end

local function drawStatsOnSideBarPlayerTwo(playertwo)

    love.graphics.setColor(charColor)
    love.graphics.setFont(statFont)
    love.graphics.print(playertwo.name, 1000, 50)
        for index, value in ipairs(playertwo.characters) do
            for i = 1, #playertwo.characters do
                
                love.graphics.print( playertwo.characters[i].name, 1000, 10 + i * 100)
                love.graphics.print("SP: " ..  playertwo.characters[i].stepPoints, 1000, 25 + i * 100)
                love.graphics.print("AP: " ..  playertwo.characters[i].actionPoints, 1000, 40 + i * 100)
                love.graphics.print("HP: " ..  playertwo.characters[i].baseHP, 1000, 55 + i * 100)
                love.graphics.print("DF: " ..  playertwo.characters[i].baseDefense, 1000, 70 + i * 100)
                love.graphics.print("AT: " ..  playertwo.characters[i].baseAttack, 1000, 85 + i * 100)
                --[[ love.graphics.print("x: " ..  playertwo.characters[i].x .. "y: " ..  playertwo.characters[i].y, 1000, 90 + i * 120)
                
                if      playertwo.characters[i].isSelected then love.graphics.print("Selected", 1000, 70 + i * 120)
                elseif  playertwo.characters[i].isHovered then love.graphics.print("Hovered", 1000, 70 + i * 120)
                end ]]
                --[[ if  playertwo.characters[i].isInAttackState then love.graphics.print("ATTACK MODE", (width / 2 ) + 200, 10)
                elseif  playertwo.characters[i].isInStepState then love.graphics.print("STEP MODE", (width / 2 ) + 200, 10)
                end ]]
                if playertwo == activePlayer then
                    love.graphics.print("PLAYER TWO'S TURN", (width / 2) - 200, 750)
                end
            end
        end
    love.graphics.setFont(font)
end

function board:resetAllCharacterStates(playerone, playertwo)

    for _, currentChar in ipairs(playerone.characters) do
        currentChar.isSelected = false
        currentChar.isActionMenuDrawn = false
        currentChar.isInStepState = false
        currentChar.isInAttackState = false
        currentChar.isInDefenseState = false
        currentChar.isInSpellState = false
        currentChar.drawDice = false
    end

    for _, currentChar in ipairs(playertwo.characters) do
        currentChar.isSelected = false
        currentChar.isActionMenuDrawn = false
        currentChar.isInStepState = false
        currentChar.isInAttackState = false
        currentChar.isInSpellState = false
        currentChar.isInDefenseState = false
        currentChar.drawDice = false 
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

        if boardGrid[i][j].isOccupied == true then
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

 
    love.graphics.draw(endTurnButtonImage, 10, 500)

end

function enableDrawAttack(character, enemy)

    drawAttack = true
    drawnAttackingCharacter = character
    drawnEnemyCharacter = enemy

    timerStart = love.timer.getTime()
    timerStop = 3

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
            love.graphics.print(character.name .. " AT is: " .. character.baseAttack .. " + Dice: " .. character.diceRoll .. " + CM: " .. boardGrid[character.x][character.y].attackModifier , 10,640)
            love.graphics.print(enemy.name .. " DF is: " .. enemy.baseDefense .. " + CM: " .. boardGrid[enemy.x][enemy.y].defenseModifier , 10, 660)
            love.graphics.print("Battle: "  .. character.rolledAttack .. " AT - " .. enemy.baseDefense .. " DF" , 10, 680)
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

end

function board:draw()
    

    --drawModifier()
    drawBoardGrid()
    drawEndTurnButton()
    drawCharactersOnBoard(playerOne)
    drawCharactersOnBoard(playerTwo) 
    drawStatsOnSideBarPlayerOne(playerOne)
    drawStatsOnSideBarPlayerTwo(playerTwo)
    drawRectanglesIfHoveredOrOccupied()
    drawAttackOnBoard()
  

 
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