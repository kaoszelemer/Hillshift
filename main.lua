-- HillShift - project started: 2021.01.01

--require

require ('board')
require ('characters')


--valtozok
--altalanos valtozok
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



love.graphics.setFont(font)

function love.load()
 
    --board betoltese
    board:load()
 
 
    --karakterek betoltese



    
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

    

  

end

function love.draw()
 
    love.graphics.setColor(charColor)
 
    --board draw
   board:draw()

   
 
    --mielott kirajzolom a karaktert meghatarozom a statuszat az alapjan hogy az egerem milyen pozícióban van
    -- if  mouseX > c.screenX and mouseX < char_foldmano.screenX + charW and
    --     mouseY > char_foldmano.screenY and mouseY < char_foldmano.screenY + charH then

    --         char_foldmano.isHovered = true
    -- else
    --         char_foldmano.isHovered = false
    -- end


    --karakter draw PLAYER 1

    

    
end

-- ez ellenorzi h felengedtem az egeret

function love.mousereleased(x, y, button, istouch, presses)
    
    if char_foldmano.isHovered then
            
            char_foldmano.isSelected = true
    else
            char_foldmano.isSelected = false
    end

end
