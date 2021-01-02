board = {}

local i = 1
local j = 1
local boardPicture
local forestQuad
local mountQuad
local lakeQuad
local fieldQuad
local type



----------board felosztás

        --1: név 2: sorszám 3: x1 4: y1 5:x2 6:y2, 7:típus

        boardGrid = {


            
                id = "", 
                num=0, 
                x=0, 
                y=0, 
                type= ""
            
            }
        
        for i = 1,10 do
            
            table.insert(boardGrid, 1, "R" .. i .. "C" .. j)
            table.insert(boardGrid, 2, i)
            table.insert(boardGrid, 3, i)
            table.insert(boardGrid, 4, i)
            table.insert(boardGrid, 5, "forest")    

                for j = 1,10 do 
                    
                    boardRow = {}

                end

        end





function board:load()

    boardPicture = love.graphics.newImage("/graphics/tileset.png") -- placeholder tileset
    forestQuad = love.graphics.newQuad(25, 0, 16, 16, boardPicture:getWidth(), boardPicture:getHeight())
    mountQuad = love.graphics.newQuad(0, 16, 16, 16, boardPicture:getWidth(), boardPicture:getHeight())
    lakeQuad = love.graphics.newQuad(48, 8, 16, 16, boardPicture:getWidth(), boardPicture:getHeight())
    fieldQuad = love.graphics.newQuad(40, 24, 16, 16, boardPicture:getWidth(), boardPicture:getHeight())

end

function board:update(dt)
end

function board:draw()
   
    love.graphics.setColor(1,1,1)
print (boardGrid)


end