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


local function clickSelectCharacter(player)
    for i = 1, 4 do
        if  player[i].isHovered then   -- ha az akciomenu nincs kirajzolva és a karakter felett vagyok és klikkelek akkor
            player[i].isSelected = true -- az adott karakter selected lesz
            selectedCharacter = player[i] -- az adott karakter lesz a selectedPlayer
            selectedCharacter.isActionMenuDrawn = true
            player[i].drawBattle = false

            -- engedély az akciómenü rajzoláshoz a selectedPlayer esetén
        else player[i].isSelected = false            -- egyébként deszelektálom az összes karaktert
            player[i].isActionMenuDrawn = false -- akciómenü eltűnik az összes karakternél
            player[i].isInStepState = false
            player[i].isInAttackState = false
            player[i].drawDamage = false
            player[i].drawDice = false
        end
    end     
end

local function clickChooseAction(player)
    for i = 1, 4 do
        if  player[i].isActionMenuDrawn and player[i].isHovered and player[i].isSelected and player[i].isInAttackState == false
        and player[i].isInSpellState == false and player[i].isInDefenseState == false then
            player[i].isChoosing = true 
            choosingCharacter = player[i]
            chooseAction(choosingCharacter)
            choosingCharacter.drawBattle = false
            player[i].isActionMenuDrawn = false
        else player[i].isActionMenuDrawn = false
            player[i].isInAttackState = false
            player[i].isInStepState = false
            player[i].isInSpellState = false
            player[i].isInDefenseState = false
        end
    end
end

local function clickMoveCharacter(player)
    for i = 1, 4 do
        --egyébként ha bármelyik játékos kiválasztva és nem 0 a lépéspontja akkor
        if  player[i].isInStepState and player[i].stepPoints ~= 0 and (player[i].isInDefenseState == false or player[i].isDefending == false) then
            player[i].isMoving = true
            movingCharacter = player[i]
            movingCharacter.drawBattle = false
            --feltételek hogy ne tudjunk kimenni a pályáról és kikattintani  
            --cellMousePositiont 1 és 10 közé limitálja
            cellMousePositionX = math.min(math.max(cellMousePositionX, 1), 10)
            cellMousePositionY = math.min(math.max(cellMousePositionY, 1), 10)   
            if  boardGrid[cellMousePositionX][cellMousePositionY].isOccupied == false and boardGrid[cellMousePositionX][cellMousePositionY].isWalkable == true then
                -- akkor meghívom a movecharacters fv-t(kiválasztott karaktr, egérX, egérY)
                moveCharacterOnBoard(movingCharacter, cellMousePositionX, cellMousePositionY)
                -- deszelektálom a karaktert
                movingCharacter.isSelected = false
                -- levonok a lépéspontjaiból egyet
                movingCharacter.stepPoints = movingCharacter.stepPoints - 1
                -- nincs lépésmódban
                movingCharacter.isInStepState = false 
            end 
        player[i].isSelected = false  
        else player[i].isInStepState = false
        end
    end
end

local function clickAttackCharacter(player, enemyPlayer)
    for i = 1, 4 do
        if player[i].isInAttackState and player[i].actionPoints ~= 0 and (player[i].isDefending == false or player[i].isInDefenseState == false) then
            player[i].isAttacking = true
            attackingCharacter = player[i]     
            local clickedCell =  boardGrid[cellMousePositionX][cellMousePositionY] 
                --itt még lehetne még egy feltétel hogy a másik karakter playere van-e ott (?)
                if  clickedCell.isOccupied and clickedCell.occupiedBy.parentPlayer ~= attackingCharacter.parentPlayer then
                    local enemy = getEnemyCharacter(attackingCharacter, enemyPlayer, cellMousePositionX, cellMousePositionY)
                    if enemy ~= nil then
                    attackingCharacter.drawBattle = true
                    attack(attackingCharacter, enemy)
                    attackingCharacter.isSelected = false
                    attackingCharacter.actionPoints = attackingCharacter.actionPoints - 1
                    attackingCharacter.isInAttackState = false
                    enemy = nil
                    end
                end
                attackingCharacter.isInAttackState = false
                
        else player.isInAttackState = false
        end
    end
end

local function clickDefenseCharacter(player)
    for i = 1,4 do
        if player[i].isInDefenseState and player[i].actionPoints ~= 0 and player[i].isHovered then
           player[i].isDefending = true
           defendingCharacter = player[i]
           defendingCharacter.baseDefense = defendingCharacter.baseDefense + 2
           defendingCharacter.actionPoints = 0
           defendingCharacter.stepPoints = 0
           defendingCharacter.drawActionMenu = false
           defendingCharacter.isInDefenseState = false
           player[i].isSelected = false
        else player[i].isInDefenseState = false
        end
    end
end

local function clickSpell(player)
    local mX = cellMousePositionX
    local mY = cellMousePositionY
   
    
    for i = 1,4 do 
        local hillShiftingCharacter = player[i]    
                if hillShiftingCharacter.isInSpellState and hillShiftingCharacter.actionPoints ~= 0 and (hillShiftingCharacter.isDefending == false or hillShiftingCharacter.isInDefenseState) == false then
                    spell(hillShiftingCharacter, mX,  mY)
                    hillShiftingCharacter.actionPoints = hillShiftingCharacter.actionPoints - 1
                    hillShiftingCharacter.isInSpellState = false
                else hillShiftingCharacter.isInSpellState = false
                end
                
            end

        

end

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

    -- PLAYER ONE
    clickSpell(playerOne)
    clickDefenseCharacter(playerOne)
    clickAttackCharacter(playerOne, playerTwo)
    clickMoveCharacter(playerOne)
    clickChooseAction(playerOne)
    clickSelectCharacter(playerOne)
            



    -- PLAYER TWO
    clickSpell(playerTwo)
    clickDefenseCharacter(playerOne)
    clickAttackCharacter(playerTwo, playerOne) 
    clickMoveCharacter(playerTwo)  
    clickChooseAction(playerTwo)
    clickSelectCharacter(playerTwo)  

end
