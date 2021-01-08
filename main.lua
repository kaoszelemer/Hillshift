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
--karakterek valtozoi
charColor = {1, 1, 1}
hoverColor = {0, 0, 1}
selectedColor = {1, 0, 0}
charH = 32
charW = 32
--eger es egyeb interakciok valtozoi
mouseX, mouseY = love.mouse.getPosition()
--betutipus beállítása
love.graphics.setFont(font)

function love.load()
    --board betoltese
    board:load()
    
    --beallitasok
    love.window.setTitle("HillShift")
    love.graphics.setBackgroundColor(0,0,0)
    love.window.setMode(width,height)
    love.mouse.setVisible(true)
end

function love.update(dt)
    
    mouseX, mouseY = love.mouse.getPosition()
    board:update(dt) 

end

function love.draw()
    board:draw()
    love.graphics.setColor(charColor)
    love.graphics.print("x", mouseX, mouseY)
end

function love.mousereleased(x, y, button, istouch, presses)

    -- rögzítsük az adatot a játékosokban, hogy az egér felengedéssel kijelöltük-e őket éppen
  
    for i = 1, 4 do
 
        if playerOne[i].isHovered then
            playerOne[i].isSelected = true  
        else
            playerOne[i].isSelected = false                          
        end
                
    end
    
      -- nézzünk meg minden cellát, és amelyik fölött épp elengedjük az egérgombot, tehát épp azt hoverezzük
    
    for index, rows in ipairs(boardGrid) do
        for _, cell in ipairs(rows) do 
            if cell.isHovered == true and cell.isOccupied == false then
                -- ha nincs rajta karakter akkor oda tudjuk mozgatni azt amelyik ki van jelölve
               
                moveCharactersOnBoard(playerOne, 1,1)
            end
      
        end   


    end



    for i = 1, 4 do
 
        if playerTwo[i].isHovered then
            playerTwo[i].isSelected = true  
        else
            playerTwo[i].isSelected = false                          
        end
                
    end
    
      -- nézzünk meg minden cellát, és amelyik fölött épp elengedjük az egérgombot, tehát épp azt hoverezzük
    
    for index, rows in ipairs(boardGrid) do
        for _, cell in ipairs(rows) do 
            if cell.isHovered == true and cell.isOccupied == false then

                -- ha nincs rajta karakter akkor oda tudjuk mozgatni azt amelyik ki van jelölve
                moveCharactersOnBoard(playerTwo, 1,1)
            end
      
        end   


    end

    

end
