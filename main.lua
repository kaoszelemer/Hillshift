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
cellOccupiedColor = {1, 192 / 255, 203 / 255}
hoverColor = {0, 0, 1}
selectedColor = {1, 0, 0}
charH = 32
charW = 32
--eger es egyeb interakciok valtozoi
mouseX, mouseY = love.mouse.getPosition()
--betutipus beállítása
love.graphics.setFont(font)
--kepek betoltese
mouseArrow = love.graphics.newImage("/graphics/mousearrow.png")

function love.load()
    --board betoltese
    board:load()
    
    --beallitasok
    love.window.setTitle("HillShift")
    love.graphics.setBackgroundColor(0,0,0)
    love.window.setMode(width,height)
    love.mouse.setVisible(false)
end

function love.update(dt)
    
    mouseX, mouseY = love.mouse.getPosition()
    board:update(dt)

end

function love.draw()
    board:draw()
    love.graphics.setColor(charColor)
    love.graphics.draw(mouseArrow, mouseX - 8, mouseY - 8)
end

function love.mousereleased(x, y, button, istouch, presses)

    -- rögzítsük az adatot a játékosokban, hogy az egér felengedéssel kijelöltük-e őket éppen
    
    for i = 1, 4 do
 
            if playerOne[i].isHovered then
                playerOne[i].isSelected = true
                selectedCharacter = playerOne[i]  
            else
                playerOne[i].isSelected = false                          
            end
                    
            
    
    end
        
    

        -- nézzünk meg minden cellát, és amelyik fölött épp elengedjük az egérgombot, tehát épp azt hoverezzük
        
            local cellMousePositionX = math.floor(mouseX / tileW)
            local cellMousePositionY = math.floor(mouseY / tileH)

            if boardGrid[cellMousePositionX][cellMousePositionY].isOccupied == false then

            moveCharactersOnBoard(selectedCharacter, cellMousePositionX, cellMousePositionY)
            end 


    --     for index, rows in ipairs(boardGrid) do
    --         for _, cell in ipairs(rows) do 
                
    --             --print(boardGrid[1][1].isHovered)
    --             if playerOne[i].isHovered and cell.isHovered and cell.isOccupied == false then
    --                 -- ha nincs rajta karakter akkor oda tudjuk mozgatni azt amelyik ki van jelölve
    --                 moveCharactersOnBoard(playerOne, 1,1)
    --                -- moveCharactersOnBoard(playerOne, 1,1)
    --             elseif playerOne[i].isSelected and cell.isHovered and cell.isOccupied then
                   
                
    --             end
        
    --         end   


    --     end

   
    -- end
    -- for i = 1, 4 do
 
    --     if playerTwo[i].isHovered then
    --         playerTwo[i].isSelected = true  
    --     else
    --         playerTwo[i].isSelected = false                          
    --     end
                
    -- end
    
    --   -- nézzünk meg minden cellát, és amelyik fölött épp elengedjük az egérgombot, tehát épp azt hoverezzük
    
    -- for index, rows in ipairs(boardGrid) do
    --     for _, cell in ipairs(rows) do 
    --         if cell.isHovered == true and cell.isOccupied == false then

    --             -- ha nincs rajta karakter akkor oda tudjuk mozgatni azt amelyik ki van jelölve
    --             moveCharactersOnBoard(playerTwo, 1,1)
    --         end
      
    --     end   


    -- end

    

end
