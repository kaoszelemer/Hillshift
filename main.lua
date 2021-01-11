-- HillShift - project started: 2021.01.01

--require
require ('board')
require ('characters')
--valtozok
--altalanos valtozok
width = 1280
height = 720
numberOfTiles = 10
offsetX = math.floor(width / 2 - (tileW * numberOfTiles / 2)  - tileW)
offsetY = math.floor(height / 2 - (tileH * numberOfTiles / 2) - tileH)

statFont = love.graphics.newFont(12)
actionMenuFont = love.graphics.newFont(24)


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
font = love.graphics.newFont(32)
love.graphics.setFont(font)
statFont = love.graphics.newFont(12)

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
    love.graphics.draw(mouseArrow, mouseX, mouseY)
end

function love.mousereleased(x, y, button, istouch, presses)
    -- kiszámolom az egér és tile relációt X és Y tengelyen
    cellMousePositionX = math.floor((mouseX / tileW) - offsetX / tileW) 
    cellMousePositionY = math.floor((mouseY / tileH) - offsetY / tileH) 
    
    for i = 1, 4 do

        --egyébként ha bármelyik játékos kiválasztva és nem 0 a lépéspontja akkor
        if  playerOne[i].isInStepState and playerOne[i].stepPoints ~= 0 then
            playerOne[i].isMoving = true
            movingCharacter = playerOne[i]
        
        --feltételek hogy ne tudjunk kimenni a pályáról és kikattintani
        
        -- cellMousePositiont 1 és 10 közé limitálja
        cellMousePositionX = math.min(math.max(cellMousePositionX, 1), 10)
        cellMousePositionY = math.min(math.max(cellMousePositionY, 1), 10)
        
        --jarhato e a mezo, es foglalt-e
        
        -- ha foglalt e mező és járható
            if  boardGrid[cellMousePositionX][cellMousePositionY].isOccupied == false
                and boardGrid[cellMousePositionX][cellMousePositionY].isWalkable == true
            then
                -- akkor meghívom a movecharacters fv-t(kiválasztott karaktr, egérX, egérY)
                moveCharacterOnBoard(movingCharacter, cellMousePositionX, cellMousePositionY)
                -- deszelektálom a karaktert
                movingCharacter.isSelected = false
                -- levonok a lépéspontjaiból egyet
                movingCharacter.stepPoints = movingCharacter.stepPoints - 1
                -- nincs lépésmódban
                movingCharacter.isInStepState = false 
            end
        
        playerOne[i].isSelected = false
        
        else
        playerOne[i].isInStepState = false
        end

            if playerOne[i].isActionMenuDrawn and playerOne[i].isHovered and playerOne[i].isSelected then
                playerOne[i].isChoosing = true 
                choosingCharacter = playerOne[i]
                chooseAction(choosingCharacter)
            else playerOne[i].isActionMenuDrawn = false
                playerOne[i].isInAttackState = false
                playerOne[i].isInStepState = false
            end


            if  playerOne[i].isHovered then   -- ha az akciomenu nincs kirajzolva és a karakter felett vagyok és klikkelek akkor
                playerOne[i].isSelected = true  -- az adott karakter selected lesz
                selectedCharacter = playerOne[i] -- az adott karakter lesz a selectedPlayer
                selectedCharacter.isActionMenuDrawn = true -- engedély az akciómenü rajzoláshoz a selectedPlayer esetén
            else playerOne[i].isSelected = false            -- egyébként deszelektálom az összes karaktert
                 playerOne[i].isActionMenuDrawn = false -- akciómenü eltűnik az összes karakternél
                 playerOne[i].isInStepState = false
                 playerOne[i].isInAttackState = false
            end

             

 --[[  
            if playerOne[i].isInAttackState and playerOne[i].actionPoints ~= 0 then
                print("in attack state")
                playerOne[i].isSelected = false
                    --[[ playerOne[i].isAttacking = true
                    attackingCharacter = playerOne[i]
                    attackingCharacter.isActionMenuDrawn = false
                    print("itt fog lefutni az attakfüggvény")
                    attackingCharacter.isInAttackState = false ]]
      --          playerOne[i].isInAttackState = false
            --[[ else   playerOne[i].isSelected = false           -- ha bárhova klikkelek ami a fenti logikáknak nem felel meg és klikkelek akkor deszelektálom a karaktert
                   playerOne[i].isActionMenuDrawn = false   ]]   
        --    end       ]] 
    end

    for i = 1, 4 do
        if     playerTwo[i].isHovered then playerTwo[i].isSelected = true
               selectedCharacter = playerTwo[i]

        elseif playerTwo[i].isSelected and playerTwo[i].stepPoints ~= 0 then 

                local cellMousePositionX = math.floor((mouseX / tileW) - offsetX / tileW)
                local cellMousePositionY = math.floor((mouseY / tileH) - offsetY / tileH)

                if cellMousePositionX >= 10 then cellMousePositionX = 10
                end

                if cellMousePositionY <= 1 then cellMousePositionY = 1
                end

                if  boardGrid[cellMousePositionX][cellMousePositionY].isOccupied == false 
                and boardGrid[cellMousePositionX][cellMousePositionY].isWalkable == true then
                   

                moveCharacterOnBoard(selectedCharacter, cellMousePositionX, cellMousePositionY)
                playerTwo[i].isSelected = false

                playerTwo[i].stepPoints = playerTwo[i].stepPoints - 1
                end
            
        else   playerTwo[i].isSelected = false                        
        end        
    end
   

end
