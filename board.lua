board = {}

tileW = 64
tileH = 64
local maxRow = 10
local maxCol = 10

---Típustáblák definiálása
boardType = {
    "forest", "mount", "lake", "field"
}
--Quadtáblák definiálása
--1. a tileset betöltése
boardPicture = love.graphics.newImage("/graphics/tileset4.png")  -- placeholder tileset
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

local function initPlayerDeck(playerTable, initCoordinates)
    --létrehozok egy táblát 6 lappal amit kiosztok a karaktereknek
    for index, currentChar in ipairs (characters) do local characterCopy = {}
        for key, value in pairs(currentChar) do characterCopy[key] = value  -- ez ugyanaz mintha azt irtam volna hogy charactercCopy.baseHP = 6 
        end
        table.insert(playerTable, characterCopy)
    end
    --amig a playertable hossza nem 4 kiveszek 2 lapot
    while #playerTable ~= 4 do     
        local cardNumber = love.math.random(1, #playerTable)
        table.remove(playerTable, cardNumber)
    end
    -- beallítom a kezdőpozíciókat
    for index, currentChar in ipairs(playerTable) do

        if     index == 1 then currentChar.x, currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        elseif index == 2 then currentChar.x, currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        elseif index == 3 then currentChar.x, currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        elseif index == 4 then currentChar.x, currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        end

        -- itt még fura az offset?
        currentChar.screenX = (currentChar.x * tileW) + offsetX --eredetileg a currentcharhoz hozzaadta a tilW felét
        currentChar.screenY = (currentChar.y * tileH) + offsetY
        -- adok nekik kezdőváltozókat
        currentChar.isHovered = false
        currentChar.isSelected = false
        currentChar.stepsDone = false
        currentChar.actionDone = false
        currentChar.isActionMenuDrawn = false
    end
end

local function initBoard()

    for index, row in ipairs(boardGrid) do
        for _, cell in ipairs(row) do
           cell.isOccupied = false
        end
    end

end


local function selectCharacterOnBoard(character) 
    --   mielott kirajzolom a karaktert meghatarozom a statuszat az alapjan hogy az egerem milyen pozícióban van 
    --  ezt offsetelem screenX és screenY valtozoban
    for index, currentChar in ipairs(character) do
        if  mouseX > (character[index].screenX) and mouseX < ((character[index].screenX) + tileW) and
            mouseY > (character[index].screenY) and mouseY < ((character[index].screenY) + tileH) then
            character[index].isHovered = true
        else
            character[index].isHovered = false
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

function chooseAction(character)
   print("choose action lefutott")
    for index, rows in ipairs(boardGrid) do
        for _, cell in ipairs(rows) do 
            if  mouseX > (cell.x * tileW) + offsetX and mouseX < ((cell.x * tileW) + tileW / 2) + offsetX and
                mouseY > (cell.y * tileH) + offsetY and mouseY < ((cell.y * tileH) + tileH / 2) + offsetY then
                 character.isInAttackState = true
                 character.isActionMenuDrawn = false
                 character.isInStepState = false

            end

                                  --1  * 32   64  + 18  80     ---  64  96 - --80 és 96                         
                if   mouseX > ((cell.x * tileW) + tileW / 2) + offsetX and mouseX < ((cell.x * tileW) + tileW) + offsetX and
                                  --1  * 32   64   és  
                     mouseY > (cell.y * tileH) + offsetY and mouseY < ((cell.y * tileH) + tileH / 2 + offsetY) then
                     character.isInStepState = true
                     character.isActionMenuDrawn = false
                     character.isInAttackState = false
            end
        end
    end         
   
       

end

local function drawActionMenu(player)
    for i = 1,4 do
        if player[i].isActionMenuDrawn == true then
            love.graphics.setColor(charColor)
            love.graphics.setFont(actionMenuFont)
            love.graphics.print("A", player[i].screenX, player[i].screenY)
            love.graphics.print("S", player[i].screenX + (tileW - 20), player[i].screenY)
            love.graphics.setColor(charColor)
            love.graphics.setFont(statFont)
        end
    end
end


function moveCharacterOnBoard(character, mX, mY)  
          
        if      mX == character.x + 1 then character.x = mX
        elseif  mX == character.x - 1 then character.x = mX
        elseif  mX >= character.x + 1 then character.isSelected = false
        elseif  mX <= character.x - 1 then character.isSelected = false 
      else    
            
            character.x = mX
      end

      if      mY == character.y + 1 then character.y = mY
        elseif  mY == character.y - 1 then character.y = mY
        elseif  mY >= character.y + 1 then character.isSelected = false
        elseif  mY <= character.y - 1 then character.isSelected = false  
     
            
            character.y = mY
        end
     

end

function testCharactersOnCell(player)

      
    for _, currentChar in ipairs(player) do
    
        boardGrid[currentChar.x][currentChar.y].isOccupied = true
       
          
    end
   
    

end


local function drawCharactersOnBoard(player)
    -- státuszok alapján beállítom a színeket

     for index, currentChar in ipairs(player) do

        if      currentChar.isHovered then
                love.graphics.draw(currentChar.imageHover, currentChar.screenX, currentChar.screenY)
                love.graphics.rectangle("line", (currentChar.x * tileW) + offsetX, (currentChar.y * tileH) + offsetY, tileW / 2, tileH / 2)
                love.graphics.rectangle("line", ((currentChar.x * tileW) + tileW / 2) + offsetX, (currentChar.y * tileH) + offsetY, tileW / 2, tileH / 2)
        else    love.graphics.draw(currentChar.image, currentChar.screenX, currentChar.screenY)
        end
    
      
    end

end

local function drawStatsOnSideBarPlayerOne(player)


    love.graphics.setColor(charColor)
    love.graphics.setFont(statFont)
    love.graphics.print("PLAYER ONE", 200, 50)
        for index, value in ipairs(player) do
            for i = 1, #player do        
                love.graphics.print(player[i].name, 200, 10 + i * 100)
                love.graphics.print("SP: " .. player[i].stepPoints, 200, 30 + i * 100)
                love.graphics.print("AP: " .. player[i].actionPoints, 200, 50 + i * 100)
                love.graphics.print("x: " .. player[i].x .. "y: " .. player[i].y, 200, 90 + i * 100)
                if     player[i].isSelected then love.graphics.print("Selected", 200, 70 + i * 100)
                elseif player[i].isHovered then love.graphics.print("Hovered", 200, 70 + i * 100)
                end
                if player[i].isInAttackState then love.graphics.print("ATTACK", 200, 110 + i * 100)
                elseif player[i].isInStepState then love.graphics.print("STEP", 200, 130 + i * 100)
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
                
                love.graphics.print(player[i].name, 1000, 10 + i * 120)
                love.graphics.print("SP: " .. player[i].stepPoints, 1000, 30 + i * 120)
                love.graphics.print("AP: " .. player[i].actionPoints, 1000, 50 + i * 120)
                love.graphics.print("x: " .. player[i].x .. "y: " .. player[i].y, 1000, 90 + i * 120)
                if     player[i].isSelected then love.graphics.print("Selected", 1000, 70 + i * 120)
                elseif player[i].isHovered then love.graphics.print("Hovered", 1000, 70 + i * 120)
                end
                if player[i].isInAttackState then love.graphics.print("ATTACK", 500, 10)
                elseif player[i].isInStepState then love.graphics.print("STEP", 500, 10)
                end 
            end
        end
    love.graphics.setFont(font)
end


function board:load()

    playerOne = {}
    playerTwo = {}

    -- létrehozom a kezdőpozíciók tábláját

    local initPlayerCoordinatesPlayerOne = {{5,1},{5,2},{6,1},{6,2}}
    local initPlayerCoordinatesPlayerTwo = {{5,9},{5,10},{6,9},{6,10}}

    initPlayerDeck(playerOne, initPlayerCoordinatesPlayerOne)
    initPlayerDeck(playerTwo, initPlayerCoordinatesPlayerTwo)


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
    selectCharacterOnBoard(playerOne)
    selectCharacterOnBoard(playerTwo)
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

    

    drawCharactersOnBoard(playerOne)
    drawCharactersOnBoard(playerTwo)
    drawActionMenu(playerOne)
    drawActionMenu(playerTwo)


    drawStatsOnSideBarPlayerOne(playerOne)
    drawStatsOnSideBarPlayerTwo(playerTwo)
  

   

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