board = {}

tileW = 64
tileH = 64

local maxRow = 10
local maxCol = 10

---Típustáblák definiálása
cellType = {
    Forest, Mount, Lake, Field
}
hillShiftLogoImage = love.graphics.newImage("/graphics/hillshiftlogo.png")
--tileset
boardPicture = love.graphics.newImage("/graphics/tileset4.png")
tilesetW, tilesetH = boardPicture:getWidth(), boardPicture:getHeight()
prisonImage = love.graphics.newImage("/graphics/prison.png")
--icons
attackIcon = love.graphics.newImage("graphics/attackicon.png")
moveIcon = love.graphics.newImage("graphics/moveicon.png")
spellIcon = love.graphics.newImage("graphics/spellicon.png")
defenseIcon = love.graphics.newImage("graphics/shieldicon.png")
fireIcon = love.graphics.newImage("graphics/fireicon.png")
frozenIcon = love.graphics.newImage("graphics/frozenicon.png")
poisonIcon = love.graphics.newImage("graphics/poisonicon.png")
defendedCellIcon = love.graphics.newImage("graphics/defendedcellicon.png")
--borders
frozenGridBorder = love.graphics.newImage("graphics/frozenborder.png")
poisonGridBorder = love.graphics.newImage("graphics/poisonborder.png")
fireGridBorder = love.graphics.newImage("graphics/fireborder.png")


--validMove images
validAttackImage = love.graphics.newImage("graphics/validattack.png")
validStepImage = love.graphics.newImage("graphics/validstep.png")
validSpellImage = love.graphics.newImage("graphics/validspell.png")
--button images
endTurnButtonImage = love.graphics.newImage("graphics/endturnbutton.png")
endTurnButtonClickedImage = love.graphics.newImage("graphics/endturnbuttonclicked.png")
cancelButtonImage = love.graphics.newImage("graphics/cancelbutton.png")
--Backgrounds
eventBackgroundImage = love.graphics.newImage("/graphics/eventbackground.png")
eventWarningImage = love.graphics.newImage("/graphics/eventbanner.png")
sideBarBackGround = love.graphics.newImage("/graphics/sidebarbackground.png")
sideBarBackGroundWithZeroActionPointsImage = love.graphics.newImage("/graphics/sidebarbackgroundwithzeroactionpoints.png")

--Cell drawables
lightningImage = love.graphics.newImage("/graphics/lightning.png")
chestImage = love.graphics.newImage("graphics/chest.png")

--Dice images and quad
diceImage = love.graphics.newImage("/graphics/dicequad.png")
divineDiceImage = love.graphics.newImage("/graphics/divinedicequad.png")
local diceQuadWidth = 384
diceOne = love.graphics.newQuad(0, 0, tileW, tileH, diceQuadWidth, tileH) 
diceTwo = love.graphics.newQuad(64, 0, tileW, tileH, diceQuadWidth, tileH) 
diceThree = love.graphics.newQuad(128, 0, tileW, tileH, diceQuadWidth, tileH) 
diceFour = love.graphics.newQuad(192, 0, tileW, tileH, diceQuadWidth, tileH) 
diceFive = love.graphics.newQuad(256, 0, tileW, tileH, diceQuadWidth, tileH) 
diceSix = love.graphics.newQuad(320, 0, tileW, tileH,  diceQuadWidth, tileH) 

--Counter
chestCounter = 0

--1a. a tileset változói
--2, a cella típusuk definiálása a quadokból   
cellQuadTable = {

    forest = {
        
        love.graphics.newQuad(0, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(64, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(128, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(192, 0, tileW, tileH, tilesetW, tilesetH)
    },

    field = {
        love.graphics.newQuad(256, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(320, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(384, 0, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(448, 0, tileW, tileH, tilesetW, tilesetH)
    },

    mount = {
        love.graphics.newQuad(0, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(64, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(128, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(192, 64, tileW, tileH, tilesetW, tilesetH)
    },

    lake = {
        love.graphics.newQuad(256, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(320, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(384, 64, tileW, tileH, tilesetW, tilesetH),
        love.graphics.newQuad(448, 64, tileW, tileH, tilesetW, tilesetH)
    },
}

local function initPlayerDeck(player)

    --[[ if isDebug then debugHillShift(player)
    else ]]

        -- FULL DECK
        table.insert(player.characters, GeoGnome(player))
        table.insert(player.characters, AirElemental(player))
        table.insert(player.characters, Alchemist(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, Druid(player))
        table.insert(player.characters, IceWizard(player))
        table.insert(player.characters, ThunderShaman(player))
        table.insert(player.characters, SandWitch(player))
        table.insert(player.characters, WaterHag(player))

        --- ONLY ONE CHARACTER
--[[ 
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player)) ]]

        --AIR POISON FIRE SAND INTERACTIONS

        --[[ table.insert(player.characters, SandWitch(player))
        table.insert(player.characters, SandWitch(player))
        table.insert(player.characters, SandWitch(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, Alchemist(player))
        table.insert(player.characters, Alchemist(player))
        table.insert(player.characters, Alchemist(player))
        table.insert(player.characters, AirElemental(player))
        table.insert(player.characters, AirElemental(player))
        table.insert(player.characters, AirElemental(player)) ]]


        -- DRUID FIRE ICE
        --[[ table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, FireMage(player))
        table.insert(player.characters, Druid(player))
        table.insert(player.characters, Druid(player))
        table.insert(player.characters, Druid(player))
        table.insert(player.characters, Druid(player))
        table.insert(player.characters, IceWizard(player))
        table.insert(player.characters, IceWizard(player))
        table.insert(player.characters, IceWizard(player))
        table.insert(player.characters, IceWizard(player)) ]]

        while #player.characters ~= 4 do     
            local cardNumber = love.math.random(1, #player.characters)
            table.remove(player.characters, cardNumber)
        end

       
    

end

local function testBoardForOccupy(activeplayer, inactiveplayer)

    for x = 1, 10 do
        for y = 1, 10 do

            for index, currentChar in ipairs(activeplayer.characters) do
                if boardGrid[x][y].x == currentChar.x and boardGrid[x][y].y == currentChar.y then
                        boardGrid[x][y].isOccupied = true
                        boardGrid[x][y].occupiedBy = currentChar
                end
            end


            for index, currentChar in ipairs(inactiveplayer.characters) do
                if boardGrid[x][y].x == currentChar.x and boardGrid[x][y].y == currentChar.y then
                    boardGrid[x][y].isOccupied = true
                    boardGrid[x][y].occupiedBy = currentChar
                end
            end


            
        end
    end


end

function getDiceRoll()
   local diceRoll = love.math.random(1, 6)
   return diceRoll
end

local function drawCharactersOnBoard(player)
    -- státuszok alapján beállítom a színeket
    for _, currentChar in ipairs(player.characters) do
     currentChar:draw()
    end

end


local function drawStatsOnSideBarPlayerOne(playerone)
 
    for i, currentChar in ipairs(playerone.characters) do

        local sideBarX = 10
        local sideBarY = (i * 150) - 80

        if currentChar.actionPoints == 0 and currentChar.stepPoints == 0 then
            love.graphics.draw(sideBarBackGroundWithZeroActionPointsImage, sideBarX, sideBarY)
        else
            love.graphics.draw(sideBarBackGround, sideBarX, sideBarY)
        end
  

        for _, row in ipairs(boardGrid) do
            for _, cell in ipairs(row) do

                if cell.isOccupied and cell.occupiedBy == currentChar then



                    love.graphics.draw(boardPicture, cell.quad, sideBarX + 48, sideBarY + 64)


                    love.graphics.setFont(littleFont)
                    local modifierX = sideBarX + 172
                    if cell.isPoisoned then
                        love.graphics.draw(poisonIcon, modifierX, sideBarY + 36)
                        love.graphics.setColor(selectedColor)
                        love.graphics.print(currentChar.turnDefenseModifier.." DF\n"..currentChar.turnAttackModifier.."AT", modifierX + 36, sideBarY + 39)
                        love.graphics.setColor(charColor)
                    end
                    if cell.isFrozen then
                        love.graphics.draw(frozenIcon, modifierX, sideBarY + 70)
                        love.graphics.setColor(selectedColor)
                        love.graphics.print("  0 SP\nNext Turn", modifierX + 36, sideBarY + 75)
                        love.graphics.setColor(charColor)
                    end
                    if cell.isOnFire then
                        love.graphics.draw(fireIcon, modifierX, sideBarY + 70)
                        love.graphics.setColor(selectedColor)
                        love.graphics.print(" -10 HP\nNext Turn", modifierX + 36, sideBarY + 75)
                        love.graphics.setColor(charColor)
                    end

                 

                    if cell:instanceOf(Lake) then
                        love.graphics.setColor(selectedColor)
                        love.graphics.print("0 AP NEXT TURN", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(Mount) then
                        love.graphics.setColor(darkgreenColor)
                        love.graphics.print("+"..cell.attackModifier.." ATTACK", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(Forest) then
                        love.graphics.setColor(darkgreenColor)
                        love.graphics.print("+"..cell.defenseModifier.." DEFENSE", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(BurntField) then
                        love.graphics.setColor(selectedColor)
                        love.graphics.print("-7HP TURN END", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(GlassMount) then
                        love.graphics.setColor(darkgreenColor)
                        love.graphics.print("+"..cell.attackModifier.." AT +"..cell.defenseModifier.." DF", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(Desert) then
                        love.graphics.setColor(selectedColor)
                        love.graphics.print(cell.attackModifier.." ATTACK", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(MagicForest) then
                        love.graphics.setColor(darkgreenColor)
                        love.graphics.print("+1SP TURN END", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(Swamp) then
                        love.graphics.setColor(selectedColor)
                        love.graphics.print(cell.defenseModifier.." DEFENSE", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end



                end
            end
        end

      
            
        love.graphics.setColor(charColor)
        love.graphics.setFont(statFont)

        love.graphics.draw(currentChar.image, sideBarX + 48, sideBarY + 64)

        love.graphics.setFont(pointFont)
        love.graphics.setColor(purpleColor)
        love.graphics.print(currentChar.name, sideBarX + 48, sideBarY + 33)
        love.graphics.setColor(purpleColor)
        love.graphics.setFont(statFont)

        love.graphics.print(" DF: " ..  currentChar.baseDefense, sideBarX + tileW + 52, sideBarY + tileH + 20)
        love.graphics.print(" AT: " ..  currentChar.baseAttack, sideBarX + tileW + 52, sideBarY + tileH)

        local minHealthBarHeight = 1.2
        love.graphics.rectangle("line", sideBarX + tileW + 51, sideBarY + tileH + 40, currentChar.baseHP * minHealthBarHeight + 1, 18)

        if currentChar.baseHP <= 18 then
            love.graphics.setColor(selectedColor)
            love.graphics.rectangle("fill", sideBarX + tileW + 52, sideBarY + tileH + 41, currentChar.baseHP * minHealthBarHeight, 17)
            love.graphics.setColor(charColor)
        else
            love.graphics.setColor(greenColor)
            love.graphics.rectangle("fill", sideBarX + tileW + 52, sideBarY + tileH + 41, currentChar.baseHP * minHealthBarHeight, 17)
            love.graphics.setColor(charColor)
        end

        if currentChar.baseHP <= 18 then
            love.graphics.setColor(selectedColor)
            love.graphics.print(" HP: " ..  currentChar.baseHP .. "!!!", sideBarX + tileW + 52, sideBarY + tileH + 40)
            love.graphics.setColor(charColor)
        else
            love.graphics.setColor(purpleColor)
            love.graphics.print(" HP: " ..  currentChar.baseHP, sideBarX + tileW + 52, sideBarY + tileH + 40)
            love.graphics.setColor(charColor)
        end


        if activePlayer == playerone then 
            love.graphics.print(playerone.name, sideBarX + 32, 64)
        end

        if activePlayer == playerone then
            love.graphics.print("                - IT'S YOUR TURN", sideBarX + 32, 64)
            love.graphics.setColor(charColor)
            love.graphics.print("PLAYER ONE'S TURN  -  TURN: #" .. turnCounter, (width / 2) - 100, height - 60)
            if currentChar.stepPoints ~= 0 then love.graphics.print(currentChar.stepPoints.."SP", sideBarX + 48, sideBarY + 112) end
            if currentChar.actionPoints ~= 0 then love.graphics.print(currentChar.actionPoints.."AP", sideBarX + 88, sideBarY + 112) end
        end

       

        if currentChar.hasItem and currentChar.drawCurrentItem then
            love.graphics.draw(currentChar.ownedItem.itemIcon, sideBarX + tileW + 94, sideBarY + tileH + 5)
        end

    end
 
    love.graphics.setFont(font)
end




local function drawStatsOnSideBarPlayerTwo(playertwo)
    for i, currentChar in ipairs(playertwo.characters) do

        local sideBarX = 960
        local sideBarY = (i * 150) - 80

        if currentChar.actionPoints == 0 and currentChar.stepPoints == 0 then
            love.graphics.draw(sideBarBackGroundWithZeroActionPointsImage, sideBarX, sideBarY)
        else
            love.graphics.draw(sideBarBackGround, sideBarX, sideBarY)
        end

        for _, row in ipairs(boardGrid) do
            for _, cell in ipairs(row) do

                if cell.isOccupied and cell.occupiedBy == currentChar then



                    love.graphics.draw(boardPicture, cell.quad, sideBarX + 48, sideBarY + 64)


                    love.graphics.setFont(littleFont)
                    local modifierX = sideBarX + 172
                    if cell.isPoisoned then
                        love.graphics.draw(poisonIcon, modifierX, sideBarY + 36)
                        love.graphics.setColor(selectedColor)
                        love.graphics.print(currentChar.turnDefenseModifier.." DF\n"..currentChar.turnAttackModifier.."AT", modifierX + 36, sideBarY + 39)
                        love.graphics.setColor(charColor)
                    end
                    if cell.isFrozen then
                        love.graphics.draw(frozenIcon, modifierX, sideBarY + 70)
                        love.graphics.setColor(selectedColor)
                        love.graphics.print("  0 SP\nNext Turn", modifierX + 36, sideBarY + 75)
                        love.graphics.setColor(charColor)
                    end
                    if cell.isOnFire then
                        love.graphics.draw(fireIcon, modifierX, sideBarY + 70)
                        love.graphics.setColor(selectedColor)
                        love.graphics.print(" -10 HP\nNext Turn", modifierX + 36, sideBarY + 75)
                        love.graphics.setColor(charColor)
                    end

                 

                    if cell:instanceOf(Lake) then
                        love.graphics.setColor(selectedColor)
                        love.graphics.print("0 AP Next Turn", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(Mount) then
                        love.graphics.setColor(darkgreenColor)
                        love.graphics.print("+"..cell.attackModifier.." ATTACK", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(Forest) then
                        love.graphics.setColor(darkgreenColor)
                        love.graphics.print("+"..cell.defenseModifier.." DEFENSE", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(BurntField) then
                        love.graphics.setColor(selectedColor)
                        love.graphics.print("-7HP Turn End", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(GlassMount) then
                        love.graphics.setColor(darkgreenColor)
                        love.graphics.print("+"..cell.attackModifier.." AT +"..cell.defenseModifier.."DF", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(Desert) then
                        love.graphics.setColor(selectedColor)
                        love.graphics.print(cell.attackModifier.." ATTACK", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(MagicForest) then
                        love.graphics.setColor(darkgreenColor)
                        love.graphics.print("+1SP Turn End", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end

                    if cell:instanceOf(Swamp) then
                        love.graphics.setColor(selectedColor)
                        love.graphics.print(cell.defenseModifier.." DEFENSE", modifierX + 36, sideBarY + 110)
                        love.graphics.setColor(charColor)
                    end



                end
            end
        end

      
            
        love.graphics.setColor(charColor)
        love.graphics.setFont(statFont)

        love.graphics.draw(currentChar.image, sideBarX + 48, sideBarY + 64)

        love.graphics.setFont(pointFont)
        love.graphics.setColor(purpleColor)
        love.graphics.print(currentChar.name, sideBarX + 48, sideBarY + 33)
        love.graphics.setColor(purpleColor)
        love.graphics.setFont(statFont)

        love.graphics.print(" DF: " ..  currentChar.baseDefense, sideBarX + tileW + 52, sideBarY + tileH + 20)
        love.graphics.print(" AT: " ..  currentChar.baseAttack, sideBarX + tileW + 52, sideBarY + tileH)

        local minHealthBarHeight = 1.2
        love.graphics.rectangle("line", sideBarX + tileW + 51, sideBarY + tileH + 40, currentChar.baseHP * minHealthBarHeight + 1, 18)

        if currentChar.baseHP <= 18 then
            love.graphics.setColor(selectedColor)
            love.graphics.rectangle("fill", sideBarX + tileW + 52, sideBarY + tileH + 41, currentChar.baseHP * minHealthBarHeight, 17)
            love.graphics.setColor(charColor)
        else
            love.graphics.setColor(greenColor)
            love.graphics.rectangle("fill", sideBarX + tileW + 52, sideBarY + tileH + 41, currentChar.baseHP * minHealthBarHeight, 17)
            love.graphics.setColor(charColor)
        end

        if currentChar.baseHP <= 18 then
            love.graphics.setColor(selectedColor)
            love.graphics.print(" HP: " ..  currentChar.baseHP .. "!!!", sideBarX + tileW + 52, sideBarY + tileH + 40)
            love.graphics.setColor(charColor)
        else
            love.graphics.setColor(purpleColor)
            love.graphics.print(" HP: " ..  currentChar.baseHP, sideBarX + tileW + 52, sideBarY + tileH + 40)
            love.graphics.setColor(charColor)
        end


        if activePlayer == playertwo then 
            love.graphics.print(playertwo.name, sideBarX + 32, 64)
        end

        if activePlayer == playertwo then
            love.graphics.print("                - IT'S YOUR TURN", sideBarX + 32, 64)
            love.graphics.setColor(charColor)
            love.graphics.print("PLAYER TWO'S TURN  -  TURN: #" .. turnCounter, (width / 2) - 100, height - 60)
            if currentChar.stepPoints ~= 0 then love.graphics.print(currentChar.stepPoints.."SP", sideBarX + 48, sideBarY + 112) end
            if currentChar.actionPoints ~= 0 then love.graphics.print(currentChar.actionPoints.."AP", sideBarX + 88, sideBarY + 112) end
        end

       

        if currentChar.hasItem and currentChar.drawCurrentItem then
            love.graphics.draw(currentChar.ownedItem.itemIcon, sideBarX + tileW + 94, sideBarY + tileH + 5)
        end

    end
 
    love.graphics.setFont(font)
end

local function drawDebugInfo()


   -- love.graphics.print("x: " ..  currentChar.x .. "y: " ..  currentChar.y, 200, 90 + i * 100)

              --  if      currentChar.isSelected then love.graphics.print("Selected", 200, 70 + i * 100)
              --  elseif  currentChar.isHovered then love.graphics.print("Hovered", 200, 70 + i * 100)
              --  end
               --[[  if  currentChar.isInAttackState then love.graphics.print("ATTACK MODE", (width / 2) - 200, 10)
                elseif  currentChar.isInStepState then love.graphics.print("STEP MODE", (width / 2) - 200, 10)
                elseif  currentChar.isInSpellState then love.graphics.print("SPELL MODE", (width / 2) - 200, 10)
                elseif  currentChar.isInDefenseState then love.graphics.print("DEFENSE MODE", (width / 2) - 200, 10)   
                end ]]

end


function drawPossibleDamageOnEnemyCharacter()
    local attacker
    local enemy
    if selectedChar and gameState.state == gameState.states.selectAttackTargetCharacter then

                attacker = selectedChar
      

        for _, currentChar in ipairs(inactivePlayer.characters) do

            if currentChar.isHovered then
                enemy = currentChar
            end

        end

            if enemy ~= nil and attacker ~= nil then

                if boardGrid[enemy.x][enemy.y].isPoisoned then
                    enemy.turnAttackModifierPP = -3
                    enemy.turnDefenseModifierPP = -1
                else
                    enemy.turnAttackModifierPP = 0
                    enemy.turnDefenseModifierPP = 0
                end

                if boardGrid[attacker.x][attacker.y].isPoisoned then
                    attacker.turnAttackModifierPP = -3
                    attacker.turnDefenseModifierPP = -1
                else
                    attacker.turnAttackModifierPP = 0
                    attacker.turnDefenseModifierPP = 0
                end


            local minDamage = math.max(0, (1 + attacker.baseAttack + attacker.turnAttackModifierPP + boardGrid[attacker.x][attacker.y].attackModifier) - (enemy.baseDefense + boardGrid[enemy.x][enemy.y].defenseModifier + enemy.turnDefenseModifierPP))
            local maxDamage = math.max(0, (6 + attacker.baseAttack + attacker.turnAttackModifierPP + boardGrid[attacker.x][attacker.y].attackModifier) - (enemy.baseDefense + boardGrid[enemy.x][enemy.y].defenseModifier + enemy.turnDefenseModifierPP))

          
                love.graphics.setFont(littleFont)
                love.graphics.rectangle("fill", (enemy.x * tileW + (tileW / 4) - 5) + offsetX, (enemy.y * tileH) + (tileH - 17) + offsetY, 48, 15)
                love.graphics.setColor(selectedColor)
                love.graphics.print(minDamage .. " - " .. maxDamage, (enemy.x * tileW + (tileW / 4)) + offsetX, (enemy.y * tileH) + (tileH - 17) + offsetY)
                love.graphics.setFont(statFont)
                love.graphics.setColor(charColor)
            end
    end

end

local function initBoardgrid()
    for x = 1, maxRow do boardGrid[x] = {}
        for y = 1, maxCol do 
            selectedType = 4
            --start mezők beállítása  
            if      x == 5 and y == 2 or x == 5 and y == 3 or
                    x == 6 and y == 2 or x == 6 and y == 3 or
                    x == 5 and y == 8 or x == 6 and y == 8 or
                    x == 5 and y == 9 or x == 6 and y == 9 then 
                    
                    selectedType = 4
            -- egyébként legyen random
            --else    selectedType = love.math.random(1, #cellType)           
            end
            -- a mezők adatai itt kerülnek be a táblázatba
            if      selectedType == 1 then boardGrid[x][y] = Forest(x, y)
            elseif  selectedType == 2 then boardGrid[x][y] = Mount(x, y) 
            elseif  selectedType == 3 then boardGrid[x][y] = Lake(x, y)    
            elseif  selectedType == 4 then boardGrid[x][y] = Field(x, y)
            end



        end
    end
end

function spawnChestPlayerOne()
    
    local rndCellX = love.math.random(1, 2) --1 3
    local rndCellY = love.math.random(1, 4) --2 4

        if not boardGrid[rndCellX][rndCellY].isChest and boardGrid[rndCellX][rndCellY]:instanceOf(Lake) == false 
        and not boardGrid[rndCellX][rndCellY].isOccupied  then 
            boardGrid[rndCellX][rndCellY].isChest = true
            chestCounter = chestCounter + 1
        
    end
end

function spawnChestPlayerTwo()
    local rndCellX = love.math.random(9, 10) --7 9
    local rndCellY = love.math.random(7, 10) --6 9

    if not boardGrid[rndCellX][rndCellY].isChest and boardGrid[rndCellX][rndCellY]:instanceOf(Lake) == false 
        and not boardGrid[rndCellX][rndCellY].isOccupied  then 
            boardGrid[rndCellX][rndCellY].isChest = true
            chestCounter = chestCounter + 1
        
    end
    
end

local function drawChests()

    for x = 1, 10 do
        for y = 1, 10 do
            if boardGrid[x][y].isChest == true then
                love.graphics.draw(chestImage, x * tileW + offsetX, y * tileH + offsetY)
            end
        end
    end

end

local function moveCharactersToStartingPosition()
    for i, currentChar in ipairs(playerOne.characters) do
        if     i == 1 then currentChar:move(5, 6) --5,2
        elseif i == 2 then currentChar:move(6, 6) --5,3
        elseif i == 3 then currentChar:move(6, 7) --6,2
        elseif i == 4 then currentChar:move(5, 7) --6,3
        end
        currentChar.stepPoints = 1
    end

    for i, currentChar in ipairs(playerTwo.characters) do
        if     i == 1 then currentChar:move(5, 8) --5,8
        elseif i == 2 then currentChar:move(5, 9) --5,9
        elseif i == 3 then currentChar:move(6, 8) --6,8
        elseif i == 4 then currentChar:move(6, 9) --6,9
        end
        currentChar.stepPoints = 1
    end

    if gameState.state == gameState.states.selectCharacter then
        table.insert(sequenceBufferTable, {
            name = "creatingRandomizedBoard",
            duration = 0.1,
            sequenceTime = love.timer.getTime(),
            action = function()
                createBoardGrid()
            end
        })

    end


end


function createBoardGrid()

    for y = 1, 10 do
        for x = 1, 10 do 
            table.insert(sequenceBufferTable, {
                name = "creatingRandomizedBoard",
                duration = 0.01,
                sequenceTime = love.timer.getTime(),
                action = function()
            
                    --start mezők beállítása  
                    if      x == 5 and y == 2 or x == 5 and y == 3 or
                            x == 6 and y == 2 or x == 6 and y == 3 or
                            x == 5 and y == 8 or x == 6 and y == 8 or
                            x == 5 and y == 9 or x == 6 and y == 9 then 
                            
                            selectedType = 4
                    -- egyébként legyen random
                    else    selectedType = love.math.random(1, #cellType)           
                    end
                    -- a mezők adatai itt kerülnek be a táblázatba
                  
                    if      selectedType == 1 then 
                        boardGrid[x][y] = Forest(x, y)
                    elseif  selectedType == 2 then 
                        boardGrid[x][y] = Mount(x, y) 
                    elseif  selectedType == 3 then 
                        boardGrid[x][y] = Lake(x, y)    
                    elseif  selectedType == 4 then 
                        boardGrid[x][y] = Field(x, y)
                    end
                    boardGrid[x][y].isInstanced = true
                end
            })

        end
    end
    table.insert(sequenceBufferTable, {
        name = "spawningachest",
        duration = 1.2,
        sequenceTime = love.timer.getTime(),
        action = function()
    
            while chestCounter ~= 1 do
                spawnChestPlayerOne()
            end
        end
    })
    table.insert(sequenceBufferTable, {
        name = "AirElementalblowFire",
        duration = 1.2,
        sequenceTime = love.timer.getTime(),
        action = function()
            while chestCounter ~= 2 do
                spawnChestPlayerTwo()
            end

        end
    })

    Cell:resetParticleDrawing()

end


local function drawRectanglesIfHoveredOrOccupied()
      
  -- kirajzolom a táblát
  for i=1, #boardGrid do
    for j=1, #boardGrid[i] do
        local currentCell = boardGrid[i][j] 
        local currentTileX = (currentCell.x) * tileW
        local currentTileY = (currentCell.y) * tileH

        if boardGrid[i][j].isHovered == true then
        love.graphics.setLineWidth(8)
        love.graphics.setColor(hoverColor)
        love.graphics.rectangle("line", currentTileX + offsetX , currentTileY + offsetY, tileW, tileH)
        love.graphics.setColor(charColor)
        love.graphics.setLineWidth(1)
        end
        
        if boardGrid[i][j].isOccupied == true and boardGrid[i][j].occupiedBy and boardGrid[i][j].occupiedBy.parentPlayer == activePlayer then
            love.graphics.setLineWidth(3)
            love.graphics.setColor(charColor)
            love.graphics.rectangle("line", currentTileX + offsetX, currentTileY + offsetY, tileW, tileH)
            love.graphics.setColor(charColor)
            love.graphics.setLineWidth(1)
        end
       
        end
    end
end

local function drawBoardGrid()
            for x = 1, 10 do
                for y = 1, 10 do 
                    
                    local cell = boardGrid[x][y]
                    local x = cell.x * tileW + offsetX
                    local y = cell.y * tileH  + offsetY
                    love.graphics.draw(boardPicture, cell.quad, x, y)
                    if cell.isOnFire then 
                        --love.graphics.draw(fireGridBorder, cell.x * tileW + offsetX, cell.y * tileH + offsetY) end
                        fireBorderAnimation:draw(fireBorderAnimationImage, x, y)
                    end
                    
                    if cell.isPoisoned then
                        poisonBorderAnimation:draw(poisonBorderAnimationImage, x, y) 
                    end

                    if cell.isFrozen then 
                        frozenBorderAnimation:draw(frozenBorderAnimationImage, x, y)
                    end

                end
            end

end


local function drawEndTurnButton()

   if isEndTurnButtonClicked then
    love.graphics.draw(endTurnButtonClickedImage, width / 2 + 257 - 64, height - 80) 
   else 
    love.graphics.draw(endTurnButtonImage, width / 2 + 257 - 64, height - 80)
   end
   

end


local function drawWarningForNextEvent()

    if eventTurnCounter >= nextTurnBeforeEvent - 2 then

        love.graphics.setFont(statFont)
        love.graphics.draw(eventWarningImage, width / 4, 30)
        love.graphics.draw(eventWarningImage, width / 4 + 640 - 128, 30)
        love.graphics.draw(eventWarningImage, width / 4, 700)
    end

end


local function drawEventOnBoard()

        Event:drawCurrentEvent()
end


function drawEventOnBackground()
        Event001:drawEventStuff()
end

function enableDrawAttack(character, enemy)


    table.insert(sequenceBufferTable, {
        name = "drawingAttackAnimation",
        duration = 0.0,
        sequenceTime = love.timer.getTime(),
        action = function()
            attackAnimation:gotoFrame(1)
            drawnAttackingCharacter = character
            drawnEnemyCharacter = enemy
            drawAttackAnim = true
            enemy.attackTime = love.timer.getTime()
            fnumber = { x=(enemy.x * tileW + offsetX), y = (enemy.y) * tileH + offsetY, text = damage }
            fnumberTween = tween.new(7, fnumber, {y= enemy.y + 0.1}, 'outSine')
           
            

        end
    })

    table.insert(sequenceBufferTable, { 
        name = "drawingAttackDiceAndDamage",
        duration = 0.2,
        sequenceTime = love.timer.getTime(),
        action = function()
            drawnAttackingCharacter = character
            drawnEnemyCharacter = enemy
            local angle = 2 * math.pi
            drawAttack = true
           

        end
    })



         
    
       
  


   

    animTimer = love.timer.getTime()
    animStop = 0.8

    timerStart = love.timer.getTime()
    timerStop = 4
   

    

end

function drawAttackOnBoard()
    --- tablanak kene kirajzolni
    if drawAttack then
        local enemy = drawnEnemyCharacter
        local character = drawnAttackingCharacter

        if enemy ~= nil and activePlayer == playerOne then

    
            local diceX = 25
            local diceY = height - 100
            local divineDiceX = diceX + tileW + tileW / 2
            love.graphics.setFont(pointFont)
            love.graphics.print("Dice:", diceX + 10, diceY - 32)
            if character.diceRoll == 1 then
                love.graphics.draw(diceImage, diceOne, diceX, diceY)
                love.graphics.setColor(selectedColor)
                love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                love.graphics.setColor(charColor)
            end
            if character.diceRoll == 2 then
                love.graphics.draw(diceImage, diceTwo, diceX, diceY)
                 love.graphics.setColor(selectedColor)
                love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                love.graphics.setColor(charColor)
            end
            if character.diceRoll == 3 then
                love.graphics.draw(diceImage, diceThree, diceX, diceY)
                 love.graphics.setColor(selectedColor)
                love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                love.graphics.setColor(charColor)
            end
            if character.diceRoll == 4 then
                love.graphics.draw(diceImage, diceFour, diceX, diceY)
                 love.graphics.setColor(selectedColor)
                love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                love.graphics.setColor(charColor)
            end
            if character.diceRoll == 5 then
                love.graphics.draw(diceImage, diceFive, diceX, diceY)
                 love.graphics.setColor(selectedColor)
                love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                love.graphics.setColor(charColor)
            end
            if character.diceRoll == 6 then
                love.graphics.draw(diceImage, diceSix, diceX, diceY)
                 love.graphics.setColor(selectedColor)
                love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                love.graphics.setColor(charColor)
            end


          

                

        
           

        elseif enemy ~= nil and activePlayer == playerTwo then
    
                local diceX = 985
                local diceY = height - 100
                love.graphics.setFont(pointFont)
                love.graphics.print("Dice:", diceX + 10, diceY - 32)
                if character.diceRoll == 1 then
                    love.graphics.draw(diceImage, diceOne, diceX, diceY)
                     love.graphics.setColor(selectedColor)
                love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                love.graphics.setColor(charColor)
                end
                if character.diceRoll == 2 then
                    love.graphics.draw(diceImage, diceTwo, diceX, diceY)
                     love.graphics.setColor(selectedColor)
                    love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                    love.graphics.setColor(charColor)
                end
                if character.diceRoll == 3 then
                    love.graphics.draw(diceImage, diceThree, diceX, diceY)
                    love.graphics.setColor(selectedColor)
                    love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                    love.graphics.setColor(charColor)
                end
                if character.diceRoll == 4 then
                    love.graphics.draw(diceImage, diceFour, diceX, diceY)
                     love.graphics.setColor(selectedColor)
                love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                love.graphics.setColor(charColor)
                end
                if character.diceRoll == 5 then
                    love.graphics.draw(diceImage, diceFive, diceX, diceY)
                     love.graphics.setColor(selectedColor)
                love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                love.graphics.setColor(charColor)
                end
                if character.diceRoll == 6 then
                    love.graphics.draw(diceImage, diceSix, diceX, diceY)
                     love.graphics.setColor(selectedColor)
                love.graphics.print("-"..damage.."HP", diceX + 80, diceY + 24)
                love.graphics.setColor(charColor)
                end
    
              
             
        end
    end

end

function drawDamageFlyingNumbers()

    if drawAttackAnim then
  
        local enemy = drawnEnemyCharacter
        local duration = 7
        if love.timer.getTime() - enemy.attackTime <= duration then





            
        
            love.graphics.setColor(selectedColor)
            love.graphics.setFont(font)
            love.graphics.print("-"..fnumber.text, fnumber.x, fnumber.y)
            love.graphics.setColor(charColor)
           -- love.graphics.rectangle("fill", fnumberTween.x, fnumberTween.y, 64,64)
            --
            --love.graphics.setFont(font)
            print(fnumber, fnumber.x)
            
          --  love.graphics.print("-"..damage, fnumber.x * tileW + offsetX, fnumber.y * tileW + offsetY)
          --  



        end
    end

end



local function drawSpellAnimationsOnBoard()
    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar:drawSpellAnimation()
    end
end

local function loadAnimations()
    ---Borders
   fireBorderAnimationImage = love.graphics.newImage('graphics/fireborderanimation.png')
   local g = anim8.newGrid(64, 64, fireBorderAnimationImage:getWidth(), fireBorderAnimationImage:getHeight())
   fireBorderAnimation = anim8.newAnimation(g('1-8', 1, '7-2', 1), {['1-7']= 0.1, ['8-8']= 2, ['9-14']=0.1})

   frozenBorderAnimationImage = love.graphics.newImage('graphics/frozenborderanimation.png')
   local g = anim8.newGrid(64, 64, frozenBorderAnimationImage:getWidth(), frozenBorderAnimationImage:getHeight())
   frozenBorderAnimation = anim8.newAnimation(g('1-8',1, '7-2', 1), {['1-7']= 0.1, ['8-8']= 2, ['9-14']=0.1})

   poisonBorderAnimationImage = love.graphics.newImage('graphics/poisonborderanimation.png')
   local g = anim8.newGrid(64, 64, poisonBorderAnimationImage:getWidth(), poisonBorderAnimationImage:getHeight())
   poisonBorderAnimation = anim8.newAnimation(g('1-8',1, '7-2', 1), {['1-7']= 0.1, ['8-8']= 2, ['9-14']=0.1})

   --Spells
   attackAnimationImage = love.graphics.newImage('graphics/attackanimationdown.png')
   local g = anim8.newGrid(64, 128, attackAnimationImage:getWidth(), attackAnimationImage:getHeight())
   attackAnimation = anim8.newAnimation(g('1-8',1), 0.1)

   fireSpellAnimationImage = love.graphics.newImage('graphics/firemagespellanim.png')
   local g = anim8.newGrid(32, 32, fireSpellAnimationImage:getWidth(), fireSpellAnimationImage:getHeight())
   fireSpellAnimation = anim8.newAnimation(g('1-8',1), 0.1)

   airElementalSpellAnimationImage = love.graphics.newImage('graphics/airelementalspellanim.png')
   local g = anim8.newGrid(32, 32, airElementalSpellAnimationImage:getWidth(), airElementalSpellAnimationImage:getHeight())
   airElementalSpellAnimation = anim8.newAnimation(g('1-4',1), 0.3)

   alchemistSpellAnimationImage = love.graphics.newImage('graphics/alchemistspellanim.png')
   local g = anim8.newGrid(32, 32, alchemistSpellAnimationImage:getWidth(), alchemistSpellAnimationImage:getHeight())
   alchemistSpellAnimation = anim8.newAnimation(g('1-4',1), 0.3)

   druidSpellAnimationImage = love.graphics.newImage('graphics/druidspellanim.png')
   local g = anim8.newGrid(32, 32, druidSpellAnimationImage:getWidth(), druidSpellAnimationImage:getHeight())
   druidSpellAnimation = anim8.newAnimation(g('1-4',1), 0.3)

   iceWizardSpellAnimationImage = love.graphics.newImage('graphics/icewizardspellanim.png')
   local g = anim8.newGrid(32, 32, iceWizardSpellAnimationImage:getWidth(), iceWizardSpellAnimationImage:getHeight())
   iceWizardSpellAnimation = anim8.newAnimation(g('1-4',1), 0.3)

   sandWitchSpellAnimationImage = love.graphics.newImage('graphics/sandwitchspellanim.png')
   local g = anim8.newGrid(32, 32, sandWitchSpellAnimationImage:getWidth(), sandWitchSpellAnimationImage:getHeight())
   sandWitchSpellAnimation = anim8.newAnimation(g('1-4',1), 0.3)

   waterHagSpellAnimationImage = love.graphics.newImage('graphics/waterwitchspellanim.png')
   local g = anim8.newGrid(32, 32, waterHagSpellAnimationImage:getWidth(), waterHagSpellAnimationImage:getHeight())
   waterHagSpellAnimation = anim8.newAnimation(g('1-4',1), 0.3)

   geoGnomeSpellAnimationImage = love.graphics.newImage('graphics/geognomespellanim.png')
   local g = anim8.newGrid(32, 32, geoGnomeSpellAnimationImage:getWidth(), geoGnomeSpellAnimationImage:getHeight())
   geoGnomeSpellAnimation = anim8.newAnimation(g('1-4',1), 0.3)
end

function board:load()

    playerOne = {

        name = "Player One",
        characters = {}

    }

    playerTwo = {

        name = "Player Two",
        characters = {}

    }
    playerOne.prisonCount = 0
    playerTwo.prisonCount = 0

    initPlayerDeck(playerOne)
    initPlayerDeck(playerTwo)
    boardGrid = {}        
    initBoardgrid()
    moveCharactersToStartingPosition()

    loadAnimations()
   
  
   
end

function board:update(dt)

   
    --if sequenceBufferTable
if drawAttack then
    fnumberTween:update(dt)
end
    local lightningTimerStop = 1

    for x = 1, 10 do
        for y = 1, 10 do
            if boardGrid[x][y].drawLightning and love.timer.getTime() - lightningTimer >= lightningTimerStop then
               boardGrid[x][y].drawLightning = false
            end


        end
    end

    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar:update(dt)
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar:update(dt)
    end

    fireBorderAnimation:update(dt)
    frozenBorderAnimation:update(dt)
    poisonBorderAnimation:update(dt)
    
  

    testBoardForOccupy(activePlayer, inactivePlayer)
  
   
end

function board:draw()
    
    love.graphics.draw(hillShiftLogoImage, width / 4 + 128, 10)
    --drawModifier()
    drawBoardGrid()
   
    drawChests()
    drawEndTurnButton()
    Cell:drawFireParticles()
    Character:drawHealthBar()
    Cell:drawPrisonCell()
    drawCharactersOnBoard(playerOne)
    drawCharactersOnBoard(playerTwo)
    drawStatsOnSideBarPlayerOne(playerOne)
    drawStatsOnSideBarPlayerTwo(playerTwo)
    Character:drawCancelButton()
    
    Character:drawValidIcons()
    
    drawSpellAnimationsOnBoard()
    drawPossibleDamageOnEnemyCharacter()
    Character:drawAttackAnimation()
   
    drawRectanglesIfHoveredOrOccupied()
    drawAttackOnBoard()
    drawDamageFlyingNumbers()
    Cell:drawLightningOnBoard()
    
    Cell:spawnParticlesWhenInstanced()
    
    


    -----EVENT RAJZOLÁS
    drawEventOnBoard()
    drawEventOnBackground()
    drawWarningForNextEvent()


    ---Item rajzolás
    

 
    -- for debugging:
    -- itt lehet láthatóvá tenni, hogy melyik cella, milyen indexxel rendelkezik
    -- love.graphics.print(currentCell.x .. "," .. currentCell.y, currentCell.x*tileW, currentCell.y*tileH)

end

 --for debugging
 
 --print a table

-- for k, v in pairs(characterCopy) do
--    print(k, v)
-- end

-- for k, v in ipairs(playerOne) do
--     for a, b in pairs(v) do 
--        print(a, b)
--     end
--        print(k, v)
   
--    end