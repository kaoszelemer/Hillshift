board = {}

local i = 1
local j = 1
local boardPicture
local forestQuad
local mountQuad
local lakeQuad
local fieldQuad
local type

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
   
        --1: név 2: sorszám 3: x1 4: y1 5:x2 6:y2, 7:típus

    boardfelosztas = {


    {
        id = "", 
        num, 
        x, 
        y, 
        type= ""
    }
    }



    love.graphics.setColor(1,1,1)


   for i = 1,9 do
        love.graphics.line( i*(0+(width/10)), 0, i*(0+(width/10)),height)
        love.graphics.line( 0, i*(0+(height/10)), width, i*(0+(height/10)))
            
        for j = 1,244 do
                love.graphics.draw(boardPicture, forestQuad, i*(width/10)+j+16, i*(height/10)+j+16)
        -- egy tizedeig tolti ki, aztan 2-3, aztan 4-5
                j = j + 15
        
        end
    
        i = i+1
    
    end

    --proba quad rajzolas
--love.graphics.draw(boardPicture,forestQuad,100,100)
--love.graphics.draw(boardPicture,mountQuad,200,200)
--love.graphics.draw(boardPicture,lakeQuad,100,200)
--love.graphics.draw(boardPicture,fieldQuad,200,100)

--quadokkal ki kell tolteni a letrehozott boardot, a vonalak koordinatai alapjan

end