board = {}

tileW = 64
tileH = 64
local maxRow = 10
local maxCol = 10

---Típustáblák definiálása
boardType = {
    "forest", "mount", "lake", "field"
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
--1a. a tileset változói
local tilesetW, tilesetH = boardPicture:getWidth(), boardPicture:getHeight()
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

local function initPlayerDeck(player, initCoordinates)
    --létrehozok egy táblát 6 lappal amit kiosztok a karaktereknek

    table.insert(player.characters, GeoGnome(4, 7))
    table.insert(player.characters, GeoGnome(2, 6))
    


    
    --amig a playertable hossza nem 4 kiveszek 2 lapot
   --[[  while #playerTable ~= 4 do     
        local cardNumber = love.math.random(1, #playerTable)
        table.remove(playerTable, cardNumber)
    end ]]

    -- beallítom a kezdőpozíciókat
    --[[ for index, currentChar in ipairs(player.characters) do

        if     index == 1 then currentChar.x, currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        elseif index == 2 then currentChar.x, currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        elseif index == 3 then currentChar.x, currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        elseif index == 4 then currentChar.x, currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        end

        


        currentChar.screenX = (currentChar.x * tileW) + offsetX --eredetileg a currentcharhoz hozzaadta a tilW felét
        currentChar.screenY = (currentChar.y * tileH) + offsetY
        -- adok nekik kezdőváltozókat
        currentChar.isHovered = false
        currentChar.isSelected = false
        currentChar.stepsDone = false
        currentChar.actionDone = false
        currentChar.isActionMenuDrawn = false
        currentChar.parentPlayer = playerTable
    end ]]
end

local function initBoard()

    for index, row in ipairs(boardGrid) do
        for _, cell in ipairs(row) do
           cell.isOccupied = false
           cell.occupiedBy = nil
           cell.isAttackable = false
        end
    end

end

local function gridTestMouse(board)

    for index, rows in ipairs(board) do
        for _, cell in ipairs(rows) do -- _alulvonás azt jelenti hogy változó ami nem kell
            --itt mouseX az eger ponotos helye, cell.x pedig a cellakoordinata
    
            if  mouseX > (cell.x * tileW) + offsetX and mouseX < ((cell.x * tileW) + tileW) + offsetX and
                mouseY > (cell.y * tileH) + offsetY and mouseY < ((cell.y * tileH) + tileH) + offsetY then
                cell.isHovered = true
                --for bugfixing purposes, egeret viszonyitani a cellakhoz
                --print(cell.x .. "," .. cell.y)
                --print(mouseX,mouseY)
            else
                cell.isHovered = false
            end
        end
    end
end

local function updateCharacterPosition(player)


    for index, currentChar in ipairs(player) do
       currentChar.screenX = (currentChar.x * tileW) + offsetX
       currentChar.screenY = (currentChar.y * tileH) + offsetY
    end
   
   end

--[[ local function selectCharacterOnBoard(player) 
    
    for index, currentChar in ipairs(player.characters) do
       currentChar:updateHover()
    end
end ]]





function chooseAction(character)
    for index, rows in ipairs(boardGrid) do
        for _, cell in ipairs(rows) do 

                
        end
    end         
   
       

end

function attack(character, enemy)
    -- kiszámolom a karakterem attackját 
    character.drawDice = true
    local dr = getDiceRoll()
    character.diceRoll = dr

    character.attack = character.baseAttack + dr
    -- kiszámolom a foglalt cellán álló karakter defense-ét
    -- kiszámolom a kettő összegét és levonok annyit a foglalt cellán álló karakter HP-jából
    damage = math.max(0, character.attack - enemy.baseDefense) -- 0 és a másik paramtérer közül választom kia  nagyobt
    enemy.baseHP = enemy.baseHP - damage
    enemy.drawDamage = true
    character.drawBattle = true
    --debug
    print("---****--- CSATA ----****----")
    print(character.name .. " attacked " .. enemy.name)
    print(character.name .. " AT is: " .. character.baseAttack .. " + Dice: " .. character.diceRoll)
    print(enemy.name .. " DF is: " .. enemy.baseDefense)
    print("Battle: "  .. character.attack .. " AT - " .. enemy.baseDefense .. " DF" )
    print(character.name .. " obliterated " .. enemy.name .. " with " .. damage .. " damage.")
    print(enemy.name .. " remaining HP: " .. enemy.baseHP)
    print("------------*HS*-------------")
    

end

function spell(character, mX, mY)
    -- board tipusok 1 - erdo 2- folyo 3- hefy 4- field
    --geognome
    if character.id == 1 then    
        if      mX == character.x and (mY == character.y - 1 or mY == character.y + 1) then
                boardGrid[mX][mY].type = 3
                boardGrid[mX][mY].isWalkable = true
                boardGrid[mX][mY].quad = cellQuadTable.lake[love.math.random(1,4)]
                if boardGrid[mX][mY].isOnFire then boardGrid[mX][mY].isOnFire = false end             
                if boardGrid[mX][mY].isPoisoned then boardGrid[mX][mY].isPoisoned = false end           
                if boardGrid[mX][mY].isFrozen then boardGrid[mX][mY].isFrozen = false end    
        elseif  mY == character.y and (mX == character.x - 1 or mX == character.x + 1) then
                boardGrid[mX][mY].type = 3
                boardGrid[mX][mY].isWalkable = true
                boardGrid[mX][mY].quad = cellQuadTable.lake[love.math.random(1,4)]
                if boardGrid[mX][mY].isOnFire then boardGrid[mX][mY].isOnFire = false end             
                if boardGrid[mX][mY].isPoisoned then boardGrid[mX][mY].isPoisoned = false end           
                if boardGrid[mX][mY].isFrozen then boardGrid[mX][mY].isFrozen = false end     
        elseif  mY == character.y and mX == character.x then
                boardGrid[mX][mY].type = 3
                boardGrid[mX][mY].quad = cellQuadTable.lake[love.math.random(1,4)]
                if boardGrid[mX][mY].isOnFire then boardGrid[mX][mY].isOnFire = false end             
                if boardGrid[mX][mY].isPoisoned then boardGrid[mX][mY].isPoisoned = false end           
                if boardGrid[mX][mY].isFrozen then boardGrid[mX][mY].isFrozen = false end                   
        else character.isInSpellState = false
        end
    else character.isInSpellState = false
    end
    
    --druid
    if character.id == 2 then
        if      mX == character.x and (mY == character.y - 1 or mY == character.y + 1) then
            boardGrid[mX][mY].type = 1
            boardGrid[mX][mY].isWalkable = true
            boardGrid[mX][mY].quad = cellQuadTable.forest[love.math.random(1,4)]
            if boardGrid[mX][mY].isPoisoned then boardGrid[mX][mY].isPoisoned = false end        
        elseif  mY == character.y and (mX == character.x - 1 or mX == character.x + 1) then
            boardGrid[mX][mY].type = 1
            boardGrid[mX][mY].isWalkable = true
            boardGrid[mX][mY].quad = cellQuadTable.forest[love.math.random(1,4)]
            if boardGrid[mX][mY].isPoisoned then boardGrid[mX][mY].isPoisoned = false end  
        elseif  mY == character.y and mX == character.x then
            boardGrid[mX][mY].type = 1
            boardGrid[mX][mY].isWalkable = true
            boardGrid[mX][mY].quad = cellQuadTable.forest[love.math.random(1,4)] 
            if boardGrid[mX][mY].isPoisoned then boardGrid[mX][mY].isPoisoned = false end        
        else character.isInSpellState = false
        end
   
    else character.isInSpellState = false
    end
    --icewizard
    if character.id == 3 then

            if      mX == character.x - 1 and (mY == character.y - 1 or mY == character.y + 1) then  
                boardGrid[mX][mY].isFrozen = true
                if boardGrid[mX][mY].isOnFire then boardGrid[mX][mY].isOnFire = false end
                if boardGrid[mX][mY].type == 2 then boardGrid[mX][mY].isWalkable = true  end

            elseif mX == character.x + 1 and (mY == character.y - 1 or mY == character.y + 1)  then
                boardGrid[mX][mY].isFrozen = true
                if boardGrid[mX][mY].isOnFire then boardGrid[mX][mY].isOnFire = false 
                end
                if boardGrid[mX][mY].type == 2 then boardGrid[mX][mY].isWalkable = true
                end
            elseif mX == character.x and (mY == character.y - 1 or mY == character.y + 1) then     
                boardGrid[mX][mY].isFrozen = true
                if boardGrid[mX][mY].isOnFire then boardGrid[mX][mY].isOnFire = false 
                end
                if boardGrid[mX][mY].type == 2 then boardGrid[mX][mY].isWalkable = true
                end
            else character.isInSpellState = false
            end
    else character.isInSpellState = false
    end
    --airelemental
    if character.id == 4 then 
        if      mX == character.x - 1 and (mY == character.y - 1 or mY == character.y + 1) then
            if boardGrid[mX][mY].isPoisoned then boardGrid[mX][mY].isPoisoned = false  end
            if boardGrid[mX][mY].isOnFire then boardGrid[mX - 1][(mY + love.math.random(0,1))].isOnFire = true end

        elseif mX == character.x + 1 and (mY == character.y - 1 or mY == character.y + 1)  then
            if boardGrid[mX][mY].isPoisoned then boardGrid[mX][mY].isPoisoned = false  end
            if boardGrid[mX][mY].isOnFire then boardGrid[mX + 1][(mY + love.math.random(0,1))].isOnFire = true end

        elseif mX == character.x and (mY == character.y -1 or mY == character.y + 1) then
            if boardGrid[mX][mY].isPoisoned then boardGrid[mX][mY].isPoisoned = false  end
            if boardGrid[mX][mY].isOnFire then boardGrid[mX][(mY + love.math.random(0,1))].isOnFire = true end
        else character.isInSpellState = false
        end
    end
    --alchemist
    if character.id == 5 then
            if      mX == character.x - 1 and (mY == character.y - 1 or mY == character.y + 1) then  
                boardGrid[mX][mY].isPoisoned = true

            elseif mX == character.x + 1 and (mY == character.y - 1 or mY == character.y + 1)  then
                boardGrid[mX][mY].isPoisoned = true

            elseif  mX == character.x - 2 and (mY == character.y - 2 or mY == character.y + 2) then  
                    boardGrid[mX][mY].isPoisoned = true

            elseif mX == character.x + 2 and (mY == character.y - 2 or mY == character.y + 2)  then
                    boardGrid[mX][mY].isPoisoned = true   
            else character.isInSpellState = false
            end
    else character.isInSpellState = false
    end
    --firemage
    if character.id == 6 then 
        if      mX == character.x - 1 and (mY == character.y - 1 or mY == character.y + 1) then  
            boardGrid[mX][mY].isOnFire = true
            if boardGrid[mX][mY].isFrozen then 
                boardGrid[mX][mY].isFrozen = false 
                boardGrid[mX][mY].isOnFire = false
                boardGrid[mX][mY].type = 2
                boardGrid[mX][mY].quad = cellQuadTable.mount[love.math.random(1,4)]
                boardGrid[mX][mY].isWalkable = false
            elseif boardGrid[mX][mY].type == 2 then
                    boardGrid[mX][mY].isOnFire = false
                    boardGrid[mX][mY].quad = cellQuadTable.field[love.math.random(1,4)]
                    boardGrid[mX][mY].type = 1
                    boardGrid[mX][mY].isWalkable = true
                
            end

        elseif mX == character.x + 1 and (mY == character.y - 1 or mY == character.y + 1)  then
            boardGrid[mX][mY].isOnFire = true
            if boardGrid[mX][mY].isFrozen then 
                boardGrid[mX][mY].isFrozen = false
                boardGrid[mX][mY].isOnFire = false
                boardGrid[mX][mY].type = 2
                boardGrid[mX][mY].quad = cellQuadTable.mount[love.math.random(1,4)]
                boardGrid[mX][mY].isWalkable = false
            elseif boardGrid[mX][mY].type == 2 then
                    boardGrid[mX][mY].isOnFire = false
                    boardGrid[mX][mY].quad = cellQuadTable.field[love.math.random(1,4)]
                    boardGrid[mX][mY].type = 1
                    boardGrid[mX][mY].isWalkable = true
            end
        else character.isInSpellState = false
        end
    else character.isInSpellState = false
    end  
end


function testCharactersOnCell(player)  


    for _, currentChar in ipairs(player) do    
        boardGrid[currentChar.x][currentChar.y].isOccupied = true
        boardGrid[currentChar.x][currentChar.y].occupiedBy = currentChar
    end

  
    

end

function getDiceRoll()
   local diceRoll = love.math.random(1, 6)
   return diceRoll
end

function getEnemyCharacter(character, enemy, mX, mY)

    for i = 1,4 do
       if  (mX <= character.x + 1 and mX >= character.x - 1 and mY <= character.y + 1 and mY >= character.y - 1) 
        and (enemy[i].x == mX and enemy[i].y == mY) then
            local enemyCharacter = enemy[i]
            return enemyCharacter
        else
            character.isSelected = false
        end 
    end

end

local function drawCharactersOnBoard(player)
    -- státuszok alapján beállítom a színeket

    for _, currentChar in ipairs(player.characters) do
        currentChar:draw()
    end
    --[[  for index, currentChar in ipairs(player) do

        if      currentChar.isHovered then
                love.graphics.draw(currentChar.imageHover, currentChar.screenX, currentChar.screenY)
                --love.graphics.rectangle("line", (currentChar.x * tileW) + offsetX, (currentChar.y * tileH) + offsetY, tileW / 2, tileH / 2)
                --love.graphics.rectangle("line", ((currentChar.x * tileW) + tileW / 2) + offsetX, (currentChar.y * tileH) + offsetY, tileW / 2, tileH / 2)
        else    love.graphics.draw(currentChar.image, currentChar.screenX, currentChar.screenY)
        end
    
      
    end ]]

end

local function drawStatsOnSideBarPlayerOne(player)


    love.graphics.setColor(charColor)
    love.graphics.setFont(statFont)
    love.graphics.print("PLAYER ONE", 200, 50)
        for index, value in ipairs(player) do
            for i = 1, #player do        
                love.graphics.print(player[i].name, 200, 10 + i * 100)
                love.graphics.print("SP: " .. player[i].stepPoints, 200, 25 + i * 100)
                love.graphics.print("AP: " .. player[i].actionPoints, 200, 40 + i * 100)
                love.graphics.print("HP: " .. player[i].baseHP, 200, 55 + i * 100)
                love.graphics.print("DF: " .. player[i].baseDefense, 200, 70 + i * 100)
                love.graphics.print("AT: " .. player[i].baseAttack, 200, 85 + i * 100)
               -- love.graphics.print("x: " .. player[i].x .. "y: " .. player[i].y, 200, 90 + i * 100)

              --  if     player[i].isSelected then love.graphics.print("Selected", 200, 70 + i * 100)
              --  elseif player[i].isHovered then love.graphics.print("Hovered", 200, 70 + i * 100)
              --  end
                if player[i].isInAttackState then love.graphics.print("ATTACK MODE", (width / 2) - 200, 10)
                elseif player[i].isInStepState then love.graphics.print("STEP MODE", (width / 2) - 200, 10)
                elseif player[i].isInSpellState then love.graphics.print("SPELL MODE", (width / 2) - 200, 10)
                elseif player[i].isInDefenseState then love.graphics.print("DEFENSE MODE", (width / 2) - 200, 10)   
                end
            end
        end
    love.graphics.setFont(font)
end

local function drawStatsOnSideBarPlayerTwo(player)

    love.graphics.setColor(charColor)
    love.graphics.setFont(statFont)
    love.graphics.print("PLAYER TWO", 1000, 50)
        for index, value in ipairs(player) do
            for i = 1, #player do
                
                love.graphics.print(player[i].name, 1000, 10 + i * 100)
                love.graphics.print("SP: " .. player[i].stepPoints, 1000, 25 + i * 100)
                love.graphics.print("AP: " .. player[i].actionPoints, 1000, 40 + i * 100)
                love.graphics.print("HP: " .. player[i].baseHP, 1000, 55 + i * 100)
                love.graphics.print("DF: " .. player[i].baseDefense, 1000, 70 + i * 100)
                love.graphics.print("AT: " .. player[i].baseAttack, 1000, 85 + i * 100)
                --[[ love.graphics.print("x: " .. player[i].x .. "y: " .. player[i].y, 1000, 90 + i * 120)
                
                if     player[i].isSelected then love.graphics.print("Selected", 1000, 70 + i * 120)
                elseif player[i].isHovered then love.graphics.print("Hovered", 1000, 70 + i * 120)
                end ]]
                if player[i].isInAttackState then love.graphics.print("ATTACK MODE", (width / 2 ) + 200, 10)
                elseif player[i].isInStepState then love.graphics.print("STEP MODE", (width / 2 ) + 200, 10)
                end 
            end
        end
    love.graphics.setFont(font)
end


local function drawDamage(player)

    for i = 1, #player do
        if player[i].drawDamage == true then
            love.graphics.setColor(selectedColor)
            love.graphics.setFont(font)            
                    love.graphics.print("-" .. damage, player[i].screenX + tileW / 4, player[i].screenY + tileH / 4)
            love.graphics.setColor(charColor)
            love.graphics.setFont(statFont)
          
        end
    end


end

local function drawBattleOnSidebar(player, enemyPlayer)
   
        for i = 1, 4 do
            if player[i].drawBattle then
            character = player[i]
                            
                            local enemy = getEnemyCharacter(character, enemyPlayer, cellMousePositionX, cellMousePositionY)
                            if enemy ~= nil then
                            love.graphics.setFont(statFont)
                            love.graphics.print("---****------ BATTLE COMMENCES ----****--------", 10, 600)
                            love.graphics.print(character.name .. " attacked " .. enemy.name, 10, 620)
                            love.graphics.print(character.name .. " AT is: " .. character.baseAttack .. " + Dice: " .. character.diceRoll, 10,640)
                            love.graphics.print(enemy.name .. " DF is: " .. enemy.baseDefense, 10, 660)
                            love.graphics.print("Battle: "  .. character.attack .. " AT - " .. enemy.baseDefense .. " DF" , 10, 680)
                            love.graphics.print(character.name .. " obliterated " .. enemy.name .. " with " .. damage .. " damage.", 10, 700)
                            love.graphics.print(enemy.name .. " remaining HP: " .. enemy.baseHP, 10, 720)
                            love.graphics.print("------------*END OF THE BATTLE*-------------", 10, 740)
                            love.graphics.setFont(font)
                            end

                    
                    
                
            end
        end
     
end



local function drawModifier()
    for index, rows in ipairs(boardGrid) do
        for _, cell in ipairs(rows) do
            if cell.isOnFire then love.graphics.draw(fireGridBorder, cell.x * tileW + offsetX, cell.y * tileH + offsetY) end
            if cell.isPoisoned then love.graphics.draw(poisonGridBorder, cell.x * tileW + offsetX, cell.y * tileH + offsetY) end
            if cell.isFrozen then love.graphics.draw(frozenGridBorder, cell.x * tileW + offsetX, cell.y * tileH + offsetY) end
        end
    end
end

local function drawValidAction(player, enemyPlayer)
    for i = 1,4 do
       
                local currentChar = player[i]
                local enemyChar = enemyPlayer
                local drawX = currentChar.x
                local drawY = currentChar.y
            
               
                    if currentChar.isInStepState then
                            if currentChar.x + 1 < 11 and boardGrid[(currentChar.x + 1)][currentChar.y].isWalkable and boardGrid[(currentChar.x + 1)][currentChar.y].isOccupied == false then love.graphics.draw(validStepImage, (currentChar.x + 1) * tileW + offsetX, currentChar.y  * tileH + offsetY) end
                            if currentChar.x - 1 > 0 and boardGrid[(currentChar.x -1)][currentChar.y].isWalkable and boardGrid[(currentChar.x -1)][currentChar.y].isOccupied == false then  love.graphics.draw(validStepImage, (currentChar.x - 1) * tileW + offsetX, currentChar.y  * tileH + offsetY) end
                            if currentChar.y + 1 < 11 and boardGrid[currentChar.x][(currentChar.y + 1)].isWalkable and boardGrid[currentChar.x][(currentChar.y + 1)].isOccupied == false then   love.graphics.draw(validStepImage, currentChar.x * tileW + offsetX, (currentChar.y + 1)  * tileH + offsetY) end
                            if currentChar.y - 1 > 0 and boardGrid[currentChar.x][(currentChar.y - 1)].isWalkable  and boardGrid[currentChar.x][(currentChar.y - 1)].isOccupied == false then  love.graphics.draw(validStepImage, currentChar.x * tileW + offsetX, (drawY - 1)  * tileH + offsetY) end
                            if currentChar.x + 1 < 11 and currentChar.y + 1 < 11 and boardGrid[(currentChar.x + 1)][currentChar.y + 1].isWalkable and boardGrid[(currentChar.x + 1)][currentChar.y + 1].isOccupied == false then love.graphics.draw(validStepImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end
                            if currentChar.x - 1 > 0 and currentChar.y - 1 > 0 and boardGrid[(currentChar.x - 1)][currentChar.y - 1].isWalkable and boardGrid[(currentChar.x - 1)][currentChar.y - 1].isOccupied == false then  love.graphics.draw(validStepImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end    
                            if currentChar.x + 1 < 11 and currentChar.y - 1 > 0 and boardGrid[(currentChar.x + 1)][currentChar.y - 1].isWalkable and boardGrid[(currentChar.x + 1)][currentChar.y - 1].isOccupied == false then love.graphics.draw(validStepImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                            if currentChar.x - 1 > 0 and currentChar.y + 1 < 11 and boardGrid[(currentChar.x - 1)][currentChar.y + 1].isWalkable and boardGrid[(currentChar.x - 1)][currentChar.y + 1].isOccupied == false then  love.graphics.draw(validStepImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end                    
                

                    elseif currentChar.isInAttackState then
                        if currentChar.x + 1 < 11 and boardGrid[(currentChar.x + 1)][currentChar.y].isOccupied and boardGrid[(currentChar.x + 1)][currentChar.y].occupiedBy.parentPlayer ~= currentChar.parentPlayer then love.graphics.draw(validAttackImage, (currentChar.x + 1) * tileW + offsetX, currentChar.y  * tileH + offsetY) end
                        if currentChar.x - 1 > 0 and boardGrid[(currentChar.x -1)][currentChar.y].isOccupied and boardGrid[(currentChar.x -1)][currentChar.y].occupiedBy.parentPlayer ~= currentChar.parentPlayer  then love.graphics.draw(validAttackImage, (currentChar.x - 1) * tileW + offsetX, currentChar.y  * tileH + offsetY) end
                        if currentChar.y + 1 < 11 and boardGrid[currentChar.x][(currentChar.y + 1)].isOccupied and boardGrid[currentChar.x][(currentChar.y + 1)].occupiedBy.parentPlayer ~= currentChar.parentPlayer then love.graphics.draw(validAttackImage, currentChar.x * tileW + offsetX, (currentChar.y + 1)  * tileH + offsetY) end
                        if currentChar.y - 1 > 0 and boardGrid[currentChar.x][(currentChar.y - 1)].isOccupied and boardGrid[currentChar.x][(currentChar.y - 1)].occupiedBy.parentPlayer ~= currentChar.parentPlayer then  love.graphics.draw(validAttackImage, currentChar.x * tileW + offsetX, (currentChar.y - 1)  * tileH + offsetY)  end
                        if currentChar.x + 1 < 11 and currentChar.y + 1 < 11 and boardGrid[(currentChar.x + 1)][currentChar.y + 1].isOccupied and boardGrid[(currentChar.x + 1)][currentChar.y + 1].occupiedBy.parentPlayer ~= currentChar.parentPlayer then love.graphics.draw(validAttackImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end
                        if currentChar.x - 1 > 0 and currentChar.y - 1 > 0 and boardGrid[(currentChar.x - 1)][currentChar.y - 1].isOccupied and boardGrid[(currentChar.x - 1)][currentChar.y - 1].occupiedBy.parentPlayer ~= currentChar.parentPlayer then love.graphics.draw(validAttackImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                        if currentChar.x + 1 < 11 and currentChar.y - 1 > 0 and boardGrid[(currentChar.x + 1)][currentChar.y - 1].isOccupied and boardGrid[(currentChar.x + 1)][currentChar.y - 1].occupiedBy.parentPlayer ~= currentChar.parentPlayer then love.graphics.draw(validAttackImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                        if currentChar.x - 1 > 0 and currentChar.y + 1 < 11 and boardGrid[(currentChar.x - 1)][currentChar.y + 1].isOccupied and boardGrid[(currentChar.x - 1)][currentChar.y + 1].occupiedBy.parentPlayer ~= currentChar.parentPlayer then love.graphics.draw(validAttackImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end  
                    

                    elseif currentChar.isInSpellState then
                        if currentChar.id == 1 or currentChar.id == 2 then
                            if currentChar.y + 1 < 11 then love.graphics.draw(validSpellImage, (currentChar.x) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end
                            if currentChar.y - 1 > 0 then love.graphics.draw(validSpellImage, (currentChar.x) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                            if currentChar.x + 1 < 11 then love.graphics.draw(validSpellImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y) * tileH + offsetY) end
                            if currentChar.x - 1 > 0 then love.graphics.draw(validSpellImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y) * tileH + offsetY) end
                            love.graphics.draw(validSpellImage, (currentChar.x) * tileW + offsetX, (currentChar.y) * tileH + offsetY)
                        end
    
                        if currentChar.id == 3 or currentChar.id == 4 then
                            if currentChar.x - 1 > 0 and currentChar.y - 1 > 0 then love.graphics.draw(validSpellImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                            if currentChar.x - 1 > 0 and currentChar.y + 1 < 11 then love.graphics.draw(validSpellImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end
                            if currentChar.x + 1 < 11 and currentChar.y - 1 > 0 then love.graphics.draw(validSpellImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                            if currentChar.x + 1 < 11 and currentChar.y + 1 < 11 then love.graphics.draw(validSpellImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end
                            if currentChar.y - 1 > 0 then love.graphics.draw(validSpellImage, (currentChar.x) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                            if currentChar.y + 1 < 11 then love.graphics.draw(validSpellImage, (currentChar.x) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end
                        end

                        if currentChar.id == 5 then
                            if currentChar.x - 1 > 0 and currentChar.y - 1 > 0 then love.graphics.draw(validSpellImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                            if currentChar.x - 1 > 0 and currentChar.y + 1 < 11 then love.graphics.draw(validSpellImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end
                            if currentChar.x + 1 < 11 and currentChar.y - 1 > 0 then love.graphics.draw(validSpellImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                            if currentChar.x + 1 < 11 and currentChar.y + 1 < 11 then love.graphics.draw(validSpellImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end
                            if currentChar.x - 2 > 0 and currentChar.y - 2 > 0 then love.graphics.draw(validSpellImage, (currentChar.x - 2) * tileW + offsetX, (currentChar.y - 2) * tileH + offsetY) end
                            if currentChar.x - 2 > 0 and currentChar.y + 2 < 11 then love.graphics.draw(validSpellImage, (currentChar.x - 2) * tileW + offsetX, (currentChar.y + 2) * tileH + offsetY) end
                            if currentChar.x + 2 < 11 and currentChar.y - 2 > 0 then love.graphics.draw(validSpellImage, (currentChar.x + 2) * tileW + offsetX, (currentChar.y - 2) * tileH + offsetY) end
                            if currentChar.x + 2 < 11 and currentChar.y + 2 < 11 then love.graphics.draw(validSpellImage, (currentChar.x + 2) * tileW + offsetX, (currentChar.y + 2) * tileH + offsetY) end
                        end

                        if currentChar.id == 6 then
                            if currentChar.x - 1 > 0 and currentChar.y - 1 > 0 then love.graphics.draw(validSpellImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                            if currentChar.x - 1 > 0 and currentChar.y + 1 < 11 then love.graphics.draw(validSpellImage, (currentChar.x - 1) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end
                            if currentChar.x + 1 < 11 and currentChar.y - 1 > 0 then love.graphics.draw(validSpellImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y - 1) * tileH + offsetY) end
                            if currentChar.x + 1 < 11 and currentChar.y + 1 < 11 then love.graphics.draw(validSpellImage, (currentChar.x + 1) * tileW + offsetX, (currentChar.y + 1) * tileH + offsetY) end
                        end

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

    }

    -- létrehozom a kezdőpozíciók tábláját

    local initPlayerCoordinatesPlayerOne = {{5,1},{5,2},{6,1},{6,2}}
    local initPlayerCoordinatesPlayerTwo = {{5,9},{5,10},{6,9},{6,10}}

 initPlayerDeck(playerOne, initPlayerCoordinatesPlayerOne)
  --  initPlayerDeck(playerTwo, initPlayerCoordinatesPlayerTwo)


    boardGrid = {}
        
        for i = 1, maxRow do boardGrid[i] = {}
            for j = 1, maxCol do 
                --start mezők beállítása
                if      i == 5 and j == 1 or i == 5 and j == 2 or
                        i == 6 and j == 1 or i == 6 and j == 2 or
                        i == 5 and j == 9 or i == 6 and j == 9 or
                        i == 5 and j == 10 or i == 6 and j == 10 then 
                            selectedType = 4
                -- egyébként legyen random
                else    selectedType = love.math.random(1, #boardType)
                end
                -- a mezők adatai itt kerülnek be a táblázatba
                boardGrid[i][j] = {

                    id = "R" .. i .. "C" .. j,
                    num = i,
                    x = i,
                    y = j, 
                    type = selectedType,
                    isWalkable = true,
                    isOccupied = false,
                
                    
                    
                }                     
                
                if selectedType == 2 then
                    boardGrid[i][j].isWalkable = false
                end

                local cellType = boardGrid[i][j].type
                local cellTypeString = boardType[cellType]
                local quadSort = cellQuadTable[cellTypeString]
                boardGrid[i][j].quad = quadSort[love.math.random(#quadSort)]
            end
        end

end

function board:update(dt)
 --   selectCharacterOnBoard(playerOne)
 --   selectCharacterOnBoard(playerTwo)
    updateCharacterPosition(playerOne)
    updateCharacterPosition(playerTwo)
    gridTestMouse(boardGrid)
    initBoard()
    testCharactersOnCell(playerOne)
    testCharactersOnCell(playerTwo)

    

end

function board:draw()
  
  -- kirajzolom a táblát
    for i=1, #boardGrid do
        for j=1, #boardGrid[i] do 
           
            --random cellák változói
            local currentCell = boardGrid[i][j] 
            local currentType = boardType[currentCell.type]
            local currentTileX = (currentCell.x) * tileW
            local currentTileY = (currentCell.y) * tileH


            if boardGrid[i][j].isHovered == true then
            love.graphics.setLineWidth(3)
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

           
           
            love.graphics.draw(boardPicture, currentCell.quad, currentTileX + offsetX, currentTileY + offsetY)
            
        
            
        -- itt lehet láthatóvá tenni, hogy melyik cella, milyen indexxel rendelkezik
        -- love.graphics.print(currentCell.x .. "," .. currentCell.y, currentCell.x*tileW, currentCell.y*tileH)


        end
    end

    
    --drawModifier()
    drawCharactersOnBoard(playerOne)
   -- drawCharactersOnBoard(playerTwo)
  --  drawActionMenu(playerOne)
   --[[ drawActionMenu(playerTwo)
    drawValidAction(playerOne, playerTwo)
    drawValidAction(playerTwo, playerOne)

    drawStatsOnSideBarPlayerOne(playerOne)
    drawStatsOnSideBarPlayerTwo(playerTwo)
    drawDamage(playerOne)
    drawDamage(playerTwo)
    drawBattleOnSidebar(playerOne, playerTwo)
    drawBattleOnSidebar(playerTwo, playerOne) ]]
    

   

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