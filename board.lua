board = {}

tileW = 64
tileH = 64
local i = 1
local j = 1
local maxRow = 10
local maxCol = 10
local boardPicture
local forestQuad
local mountQuad
local lakeQuad
local fieldQuad
local type

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

        if     index == 1 then currentChar.x , currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        elseif index == 2 then currentChar.x , currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        elseif index == 3 then currentChar.x , currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        elseif index == 4 then currentChar.x , currentChar.y = initCoordinates[index][1], initCoordinates[index][2]
        end

        currentChar.screenX = currentChar.x * tileW + tileW / 2 - offsetX
        currentChar.screenY = currentChar.y * tileH + tileH / 2 - offsetY
        -- adok nekik kezdőváltozókat
        currentChar.isHovered = false
        currentChar.isSelected = false
        currentChar.stepsDone = false
        currentChar.actionDone = false
    end
end

local function selectCharacterOnBoard(characterHover) 
    --   mielott kirajzolom a karaktert meghatarozom a statuszat az alapjan hogy az egerem milyen pozícióban van    
    for index, currentChar in ipairs(characterHover) do
        if  mouseX > characterHover[index].screenX and mouseX < characterHover[index].screenX + charW and
            mouseY > characterHover[index].screenY and mouseY < characterHover[index].screenY + charH then
            characterHover[index].isHovered = true
        else
            characterHover[index].isHovered = false
        end
    end
end

local function gridTestMouse(board)

    for index, rows in ipairs(board) do
        for _, cell in ipairs(rows) do -- _alulvonás azt jelenti hogy változó ami nem kell
    
            if  mouseX > cell.x * tileW - tileW and mouseX < cell.x * tileW - tileW  + tileW and
                mouseY > cell.y * tileW - tileW and mouseY < cell.y * tileW - tileW  + tileH then
                cell.isHovered = true
                print(cell.x .. "," .. cell.y)
                print(mouseX,mouseY)
            else
                cell.isHovered = false
            end     
        end
    end
end





local function drawCharactersOnBoard(drawPlayer)
    -- státuszok alapján beállítom a színeket
    for index, currentChar in ipairs(drawPlayer) do

        if      drawPlayer[index].isHovered then love.graphics.setColor(hoverColor)
        else    love.graphics.setColor(charColor)
        end
    
        if      drawPlayer[index].isSelected then love.graphics.setColor(selectedColor)
        elseif  drawPlayer[index].isHovered == true then love.graphics.setColor(hoverColor)
        end

        love.graphics.print(drawPlayer[index].name:sub(0, 1), drawPlayer[index].screenX, drawPlayer[index].screenY)
    
    end    
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
                        i == 5 and j == 10 or i == 6 and j == 10 then selectedType = 4   
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
                    isWalkable = true
                    
                }                     
                
                if selectedType == 3 then
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
    gridTestMouse(boardGrid)  
end

function board:draw()
  -- kirajzolom a táblát
    for i=1, #boardGrid do
        for j=1, #boardGrid[i] do 
            --random cellák változói
            local currentCell = boardGrid[i][j] 
            local currentType = boardType[currentCell.type] 
            love.graphics.draw(boardPicture, currentCell.quad, currentCell.x*tileW, currentCell.y*tileH)     
        -- itt lehet láthatóvá tenni, hogy melyik cella, milyen indexxel rendelkezik
         love.graphics.print(currentCell.x .. "," .. currentCell.y, currentCell.x*tileW, currentCell.y*tileH)
        end
    end

    

    drawCharactersOnBoard(playerOne)
    drawCharactersOnBoard(playerTwo)

  

   

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