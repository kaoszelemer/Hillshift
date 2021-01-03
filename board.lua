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

---type-ok
boardType = {
    "forest", "mount", "lake", "field"
}

boardPicture = love.graphics.newImage("/graphics/tileset3.png") -- placeholder tileset
   
local tilesetW, tilesetH = boardPicture:getWidth(), boardPicture:getHeight()

quadTable = {

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

function board:load()

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
                        local quadSort = quadTable[cellTypeString]

                       

                        boardGrid[i][j].quad = quadSort[love.math.random(#quadSort)]
                        
                        

                    end
    
            end






 
end

function board:update(dt)
end

function board:draw()
   
    love.graphics.setColor(1,1,1)
    

   

    for i=1, #boardGrid do
        for j=1, #boardGrid[i] do 
            local currentCell = boardGrid[i][j] 
            local currentType = boardType[currentCell.type] 
                
            love.graphics.draw(boardPicture, currentCell.quad, currentCell.x*tileW, currentCell.y*tileH)
            
            
          --  love.graphics.print(currentCell.x .. "," .. currentCell.y, currentCell.x*tileW, currentCell.y*tileH)
		end
	end


 --for debugging
 
 --print a table

--for k, v in pairs(boardGrid) do
 --   print(k, v)
--end
 
-- a boardgridben az R1C5, R1C6 az starters


end

