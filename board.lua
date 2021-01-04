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
boardPicture = love.graphics.newImage("/graphics/tileset3.png") -- placeholder tileset
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
--3. a charactertípusok definiálása a quadokból

charQuadTable = {} --ki kell tolteni a karakterek quadjaival (egy karakter 32x32px)


function board:load()

playerOne = {}
playerTwo = {}


for i = 1,4 do

    local characterCopy = {}
  
    
    for key, value in pairs(characters.geognome) do
        
        characterCopy[key] = value  -- ez ugyanaz mintha azt irtam volna hogy charactercCopy.baseHP = 6 
        
    end
    
    
    table.insert(playerOne, characterCopy)


end    

for i = 1,4 do

    local characterCopy = {}
  
    
    for key, value in pairs(characters.geognome) do
        
        characterCopy[key] = value  -- ez ugyanaz mintha azt irtam volna hogy charactercCopy.baseHP = 6 
        
    end
    
    table.insert(playerTwo, characterCopy)

end

    --karakterek inicializáslálsálsa
-- 1. karakter pozicio
-- 2. milyen karakter
for index, currentChar in ipairs(playerOne) do


    if     index == 1 then currentChar.x , currentChar.y = 5 , 1
    elseif index == 2 then currentChar.x , currentChar.y = 6 , 1
    elseif index == 3 then currentChar.x , currentChar.y = 5 , 2
    elseif index == 4 then currentChar.x , currentChar.y = 6 , 2

    end



    currentChar.screenX = currentChar.x * tileW + tileW / 2 - offsetX
    currentChar.screenY = currentChar.y * tileH + tileH / 2 - offsetY
    currentChar.type = love.math.random(1,6)
    currentChar.isHovered = false
    currentChar.isSelected = false
    currentChar.stepsDone = false
    currentChar.actionDone = false


end

for index, currentChar in ipairs(playerTwo) do


    if     index == 1 then currentChar.x , currentChar.y = 5 , 9
    elseif index == 2 then currentChar.x , currentChar.y = 6 , 9
    elseif index == 3 then currentChar.x , currentChar.y = 5 , 10
    elseif index == 4 then currentChar.x , currentChar.y = 6 , 10

    end



    currentChar.screenX = currentChar.x * tileW + tileW / 2 - offsetX
    currentChar.screenY = currentChar.y * tileH + tileH / 2 - offsetY
    currentChar.type = love.math.random(1,6)
    currentChar.isHovered = false
    currentChar.isSelected = false
    currentChar.stepsDone = false
    currentChar.actionDone = false
   
end

   

    --     -- statuszok alapján eldöntöm a karakterek színét
    --     if self.isHovered then 
    --         love.graphics.setColor(hoverColor)
    
    --     else  
    --         love.graphics.setColor(charColor)
    --     end
      
    --     if self.isSelected then
        
    --         love.graphics.setColor(selectedColor)
        
    --     elseif self.isHovered == true then
    --         love.graphics.setColor(hoverColor)
    --     end
    
    --     --kirajzolom a karaktert
    --         love.graphics.print("F", self.screenX, self.screenY)
    
    --     --visszaállítom a színt eredetire
    --         love.graphics.setColor(charColor)


    boardGrid = {}
    
            for i = 1, maxRow do
        
                boardGrid[i] = {}
                
        
                    for j = 1, maxCol do 
                        --start mezők beállítása
                        if  i == 5 and j == 1 or 
                            i == 5 and j == 2 or
                            i == 6 and j == 1 or
                            i == 6 and j == 2 or
                            i == 5 and j == 9 or
                            i == 6 and j == 9 or
                            i == 5 and j == 10 or
                            i == 6 and j == 10 then

                            selectedType = 4   
                        -- egyébként legyen random
                        else
                            
                            selectedType = love.math.random(1, #boardType)

                        end
                        -- a mezők adatai itt kerülnek be a táblázatba
                        boardGrid[i][j] = {
    
                            id = "R" .. i .. "C" .. j,
                            num = i,
                            x = i,
                            y = j, 
                            type = selectedType,
    
                        }                     
                        
                        local cellType = boardGrid[i][j].type
                        local cellTypeString = boardType[cellType]
                        local quadSort = cellQuadTable[cellTypeString]

                       

                        boardGrid[i][j].quad = quadSort[love.math.random(#quadSort)]
                        
                        

                    end
    
            end

end

function board:update(dt)

end

function board:draw()
   
  
    for i=1, #boardGrid do
        for j=1, #boardGrid[i] do 
            
            --random cellák változói
            local currentCell = boardGrid[i][j] 
            local currentType = boardType[currentCell.type] 
        
            
            love.graphics.draw(boardPicture, currentCell.quad, currentCell.x*tileW, currentCell.y*tileH)
            
         --- itt lehet láthatóvá tenni, hogy melyik cella, milyen indexxel rendelkezik
          --  love.graphics.print(currentCell.x .. "," .. currentCell.y, currentCell.x*tileW, currentCell.y*tileH)
		end
	end

for index, currentChar in ipairs(playerOne) do
    if playerOne[index].type == 1 then
    love.graphics.print("G", playerOne[index].screenX, playerOne[index].screenY)
    elseif playerOne[index].type == 2 then 
    love.graphics.print("F", playerOne[index].screenX, playerOne[index].screenY)
    elseif playerOne[index].type == 3 then 
    love.graphics.print("I", playerOne[index].screenX, playerOne[index].screenY)
    elseif playerOne[index].type == 4 then 
    love.graphics.print("E", playerOne[index].screenX, playerOne[index].screenY)
    elseif playerOne[index].type == 5 then 
    love.graphics.print("A", playerOne[index].screenX, playerOne[index].screenY)
    elseif playerOne[index].type == 6 then 
    love.graphics.print("T", playerOne[index].screenX, playerOne[index].screenY)
    end
end

for index, currentChar in ipairs(playerTwo) do
    if playerTwo[index].type == 1 then
    love.graphics.print("G", playerTwo[index].screenX, playerTwo[index].screenY)
    elseif playerTwo[index].type == 2 then 
    love.graphics.print("F", playerTwo[index].screenX, playerTwo[index].screenY)
    elseif playerTwo[index].type == 3 then 
    love.graphics.print("I", playerTwo[index].screenX, playerTwo[index].screenY)
    elseif playerTwo[index].type == 4 then 
    love.graphics.print("E", playerTwo[index].screenX, playerTwo[index].screenY)
    elseif playerTwo[index].type == 5 then 
    love.graphics.print("A", playerTwo[index].screenX, playerTwo[index].screenY)
    elseif playerTwo[index].type == 6 then 
    love.graphics.print("T", playerTwo[index].screenX, playerTwo[index].screenY)
    end

end


 --for debugging
 
 --print a table

-- for k, v in pairs(characterCopy) do
--    print(k, v)
-- end
 
-- a boardgridben az R1C5, R1C6 az starters


end

