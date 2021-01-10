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
            if     playerOne[i].isHovered then playerOne[i].isSelected = true
                   selectedCharacter = playerOne[i]

            elseif playerOne[i].isSelected and playerOne[i].stepPoints ~= 0 then 


                    local cellMousePositionX = math.floor(mouseX / tileW)
                    local cellMousePositionY = math.floor(mouseY / tileH)

                    if cellMousePositionX > 10 then cellMousePositionX = 10
                    end

                    if cellMousePositionY < 1 then cellMousePositionY = 1
                    end

                    if  boardGrid[cellMousePositionX][cellMousePositionY].isOccupied == false 
                    and boardGrid[cellMousePositionX][cellMousePositionY].isWalkable == true then
                
                    moveCharacterOnBoard(selectedCharacter, cellMousePositionX, cellMousePositionY)
                    playerOne[i].isSelected = false

                    playerOne[i].stepPoints = playerOne[i].stepPoints - 1
                    end


                
            else   playerOne[i].isSelected = false                       
            end        
    end

    for i = 1, 4 do
        if     playerTwo[i].isHovered then playerTwo[i].isSelected = true
               selectedCharacter = playerTwo[i]

        elseif playerTwo[i].isSelected and playerTwo[i].stepPoints ~= 0 then 

                local cellMousePositionX = math.floor(mouseX / tileW)
                local cellMousePositionY = math.floor(mouseY / tileH)

                if cellMousePositionX > 10 then cellMousePositionX = 10
                end

                if cellMousePositionY < 1 then cellMousePositionY = 1
                end

                if  boardGrid[cellMousePositionX][cellMousePositionY].isOccupied == false 
                and boardGrid[cellMousePositionX][cellMousePositionY].isWalkable == true 
                then

                moveCharacterOnBoard(selectedCharacter, cellMousePositionX, cellMousePositionY)
                playerTwo[i].isSelected = false

                playerTwo[i].stepPoints = playerTwo[i].stepPoints - 1
                end
            
        else   playerTwo[i].isSelected = false                        
        end        
end
   

 

end
