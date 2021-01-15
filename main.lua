-- HillShift - project started: 2021.01.01

--require
require ('board')
require ('characters')
--valtozok
--altalanos valtozok
width = 1280
height = 800
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
--kiszámolom az egér és tile relációt X és Y tengelyen

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
    cellMousePositionX = math.floor((mouseX / tileW) - offsetX / tileW) 
    cellMousePositionY = math.floor((mouseY / tileH) - offsetY / tileH)    
    for i = 1, 4 do

        if playerOne[i].isInAttackState and playerOne[i].actionPoints ~= 0 then
            playerOne[i].isAttacking = true
            attackingCharacter = playerOne[i]       
                --itt még lehetne még egy feltétel hogy a másik karakter playere van-e ott (?)
                if  boardGrid[cellMousePositionX][cellMousePositionY].isOccupied then
                    enemy = getEnemyCharacter(playerTwo, cellMousePositionX, cellMousePositionY)
                    attack(attackingCharacter, enemy)
                    attackingCharacter.isSelected = false
                    attackingCharacter.actionPoints = attackingCharacter.actionPoints - 1
                    attackingCharacter.isInAttackState = false
                end
                attackingCharacter.isInAttackState = false
        else playerOne[i].isInAttackState = false
        end
    


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
                 playerOne[i].drawDamage = false
                 playerOne[i].drawDice = false
            end

    end

    -- innen player TWO

    for i = 1, 4 do

        if playerTwo[i].isInAttackState and playerTwo[i].actionPoints ~= 0 then
            playerTwo[i].isAttacking = true
            attackingCharacter = playerTwo[i]       
                --itt még lehetne még egy feltétel hogy a másik karakter playere van-e ott (?)
                if  boardGrid[cellMousePositionX][cellMousePositionY].isOccupied then
                    local enemy = getEnemyCharacter(playerOne, cellMousePositionX, cellMousePositionY)
                    attack(attackingCharacter, enemy)
                    attackingCharacter.isSelected = false
                    attackingCharacter.actionPoints = attackingCharacter.actionPoints - 1
                    attackingCharacter.isInAttackState = false
                end
                attackingCharacter.isInAttackState = false
        else playerTwo[i].isInAttackState = false
        end
    


        --egyébként ha bármelyik játékos kiválasztva és nem 0 a lépéspontja akkor
        if  playerTwo[i].isInStepState and playerTwo[i].stepPoints ~= 0 then
            playerTwo[i].isMoving = true
            movingCharacter = playerTwo[i]
        
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
        
        playerTwo[i].isSelected = false
        
        else
        playerTwo[i].isInStepState = false
        end

            if playerTwo[i].isActionMenuDrawn and playerTwo[i].isHovered and playerTwo[i].isSelected then
                playerTwo[i].isChoosing = true 
                choosingCharacter = playerTwo[i]
                chooseAction(choosingCharacter)
            else playerTwo[i].isActionMenuDrawn = false
                playerTwo[i].isInAttackState = false
                playerTwo[i].isInStepState = false
            end


            if  playerTwo[i].isHovered then   -- ha az akciomenu nincs kirajzolva és a karakter felett vagyok és klikkelek akkor
                playerTwo[i].isSelected = true  -- az adott karakter selected lesz
                selectedCharacter = playerTwo[i] -- az adott karakter lesz a selectedPlayer
                selectedCharacter.isActionMenuDrawn = true -- engedély az akciómenü rajzoláshoz a selectedPlayer esetén
            else playerTwo[i].isSelected = false            -- egyébként deszelektálom az összes karaktert
                 playerTwo[i].isActionMenuDrawn = false -- akciómenü eltűnik az összes karakternél
                 playerTwo[i].isInStepState = false
                 playerTwo[i].isInAttackState = false
                 playerTwo[i].drawDamage = false
                 playerTwo[i].drawDice = false
            end

    end
   

end
