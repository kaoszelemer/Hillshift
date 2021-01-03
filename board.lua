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
    "forest1", "forest2", "forest3", "forest4", "mountain1","mountain2","mountain3","mountain4",
    "field1", "field2","field3","field4","lake1","lake2","lake3","lake4"
}


function board:load()

    boardGrid = {}
    
            for i = 1, maxRow do
        
                boardGrid[i] = {}
                
        
                    for j = 1, maxCol do 
                        boardGrid[i][j] = {
    
                            id = "R" .. i .. "C" .. j,
                            num = i,
                            x = i*64,
                            y = j*64, 
                            type = love.math.random(1, #boardType)
    
                        }                    
                        
                    end
    
            end

    boardPicture = love.graphics.newImage("/graphics/tileset3.png") -- placeholder tileset

   
    local tilesetW, tilesetH = boardPicture:getWidth(), boardPicture:getHeight()

    quadTable = {
 
    forestQuad1 = love.graphics.newQuad(0, 0, tileW, tileH, tilesetW, tilesetH),
    forestQuad2 = love.graphics.newQuad(64, 0, tileW, tileH, tilesetW, tilesetH),
    forestQuad3 = love.graphics.newQuad(128, 0, tileW, tileH, tilesetW, tilesetH),
    forestQuad4 = love.graphics.newQuad(192, 0, tileW, tileH, tilesetW, tilesetH),
    fieldQuad1 = love.graphics.newQuad(256, 0, tileW, tileH, tilesetW, tilesetH),
    fieldQuad2 = love.graphics.newQuad(320, 0, tileW, tileH, tilesetW, tilesetH),
    fieldQuad3 = love.graphics.newQuad(384, 0, tileW, tileH, tilesetW, tilesetH),
    fieldQuad4 = love.graphics.newQuad(448, 0, tileW, tileH, tilesetW, tilesetH),
    mountQuad1 = love.graphics.newQuad(0, 64, tileW, tileH, tilesetW, tilesetH),
    mountQuad2 = love.graphics.newQuad(64, 64, tileW, tileH, tilesetW, tilesetH),
    mountQuad3 = love.graphics.newQuad(128, 64, tileW, tileH, tilesetW, tilesetH),
    mountQuad4 = love.graphics.newQuad(192, 64, tileW, tileH, tilesetW, tilesetH),
    lakeQuad1 = love.graphics.newQuad(256, 64, tileW, tileH, tilesetW, tilesetH),
    lakeQuad2 = love.graphics.newQuad(320, 64, tileW, tileH, tilesetW, tilesetH),
    lakeQuad3 = love.graphics.newQuad(384, 64, tileW, tileH, tilesetW, tilesetH),    
    lakeQuad4 = love.graphics.newQuad(448, 64, tileW, tileH, tilesetW, tilesetH),
   
    
    }

end

function board:update(dt)
end

function board:draw()
   
    love.graphics.setColor(1,1,1)
 
    for i=1, #boardGrid do
		for j=1, #boardGrid[i] do
			if boardGrid[i][j].type == 1 then
                love.graphics.draw(boardPicture, quadTable.forestQuad1, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 2 then
                love.graphics.draw(boardPicture, quadTable.forestQuad2, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 3 then
                love.graphics.draw(boardPicture, quadTable.forestQuad3, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 4 then
                love.graphics.draw(boardPicture, quadTable.forestQuad4, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 5 then
                love.graphics.draw(boardPicture, quadTable.mountQuad1, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 6 then
                love.graphics.draw(boardPicture, quadTable.mountQuad2, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 7 then
                love.graphics.draw(boardPicture, quadTable.mountQuad3, boardGrid[i][j].x, boardGrid[i][j].y) 
            elseif boardGrid[i][j].type == 8 then
                love.graphics.draw(boardPicture, quadTable.mountQuad4, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 9 then
                love.graphics.draw(boardPicture, quadTable.fieldQuad1, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 10 then
                love.graphics.draw(boardPicture, quadTable.fieldQuad2, boardGrid[i][j].x, boardGrid[i][j].y) 
            elseif boardGrid[i][j].type == 11 then
                love.graphics.draw(boardPicture, quadTable.fieldQuad3, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 12 then
                love.graphics.draw(boardPicture, quadTable.fieldQuad4, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 13 then
                love.graphics.draw(boardPicture, quadTable.lakeQuad1, boardGrid[i][j].x, boardGrid[i][j].y) 
            elseif boardGrid[i][j].type == 14 then
                love.graphics.draw(boardPicture, quadTable.lakeQuad2, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 15 then
                love.graphics.draw(boardPicture, quadTable.lakeQuad3, boardGrid[i][j].x, boardGrid[i][j].y)
            elseif boardGrid[i][j].type == 16 then
                love.graphics.draw(boardPicture, quadTable.lakeQuad4, boardGrid[i][j].x, boardGrid[i][j].y)             
			end
		end
	end


 --for debugging
 
 --print a table

for k, v in pairs(boardGrid) do
    print(k, v)
end
 



end

