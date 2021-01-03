-- HillShift - project started: 2021.01.01

--require

require ('board')
require ('char_foldmano')
require ('char_harcos')
require ('char_jegvarazslo')
require ('char_legelemental')
require ('char_meregkevero')
require ('char_tuzmagus')

--valtozok
width = 1280
height = 720
offsetX = 15
offsetY = 15
font = love.graphics.newFont(32)

love.graphics.setFont(font)

function love.load()
 
    --board betoltese
    board:load()
 
 
    --karakterek betoltese
    char_foldmano:load()
    char_harcos:load()
    char_jegvarazslo:load()
    char_legelemental:load()
    char_meregkevero:load()
    char_tuzmagus:load()


    
    --beallitasok
    love.window.setTitle("HillShift")
    love.graphics.setBackgroundColor(0,0,0)
    love.window.setMode(width,height)

end

function love.update(dt)
   
    --tabla update
    board:update(dt)



    --karakter update
    char_foldmano:update(dt)
    char_harcos:update(dt)
    char_jegvarazslo:update(dt)
    char_legelemental:update(dt)
    char_meregkevero:update(dt)
    char_tuzmagus:update(dt)
    

  

end

function love.draw()
   --board draw
   board:draw()


    --karakter draw PLAYER 1
    char_foldmano:draw()
    char_harcos:draw()
    char_jegvarazslo:draw()
    char_legelemental:draw()
    char_meregkevero:draw()
    char_tuzmagus:draw()
    
 
end

