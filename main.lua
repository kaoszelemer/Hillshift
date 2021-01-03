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

charColor = {1, 1, 1}
hoverColor = {0, 0, 1}
selectedColor = {1, 0, 0}
charH = 32
charW = 32


local mouseX, mouseY

function love.mousereleased(x, y, button, istouch, presses)
    
    if char_foldmano.isHovered then

        char_foldmano.isSelected = true
else
        char_foldmano.isSelected = false
end

end

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
    
    mouseX, mouseY = love.mouse.getPosition()
    

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
 
    love.graphics.setColor(charColor)
 
    --board draw
   board:draw()

 
    if  mouseX > char_foldmano.screenX and mouseX < char_foldmano.screenX + charW and
        mouseY > char_foldmano.screenY and mouseY < char_foldmano.screenY + charH then

            char_foldmano.isHovered = true
    else
            char_foldmano.isHovered = false
    end

  

    --karakter draw PLAYER 1
    char_foldmano:draw()
    char_harcos:draw()
    char_jegvarazslo:draw()
    char_legelemental:draw()
    char_meregkevero:draw()
    char_tuzmagus:draw()
    

    
end


