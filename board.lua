

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
infoIcon = love.graphics.newImage("graphics/infoicon.png")


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

frozenGridBorder = love.graphics.newImage("graphics/frozenborder.png")
poisonGridBorder = love.graphics.newImage("graphics/poisonborder.png")
fireGridBorder = love.graphics.newImage("graphics/fireborder.png")

freezeRemTurnIcon = love.graphics.newImage("graphics/iceremaining.png")
fireRemTurnIcon = love.graphics.newImage("graphics/fireremaining.png")
poisonRemTurnIcon = love.graphics.newImage("graphics/poisonremaining.png")


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
tileHelpBackGround = love.graphics.newImage("/graphics/tilehelpbackground.png")

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



function initPlayerDeck(player)

    --[[ if isDebug then debugHillShift(player)
    else ]]
       
       -- for networking

    --[[     if player == "server" then
            table.insert(playerOne.characters, GeoGnome(playerOne))
            table.insert(playerOne.characters, AirElemental(playerOne))
            table.insert(playerOne.characters, Alchemist(playerOne))
            table.insert(playerOne.characters, FireMage(playerOne))
            table.insert(playerOne.characters, Druid(playerOne))
            table.insert(playerOne.characters, IceWizard(playerOne))
            table.insert(playerOne.characters, ThunderShaman(playerOne))
            table.insert(playerOne.characters, SandWitch(playerOne))
            table.insert(playerOne.characters, WaterHag(playerOne))

            while #playerOne.characters ~= 4 do     
                local cardNumber = love.math.random(1, #playerOne.characters)
                table.remove(playerOne.characters, cardNumber)
            end

            table.insert(playerTwo.characters, GeoGnome(playerTwo))
            table.insert(playerTwo.characters, AirElemental(playerTwo))
            table.insert(playerTwo.characters, Alchemist(playerTwo))
            table.insert(playerTwo.characters, FireMage(playerTwo))
            table.insert(playerTwo.characters, Druid(playerTwo))
            table.insert(playerTwo.characters, IceWizard(playerTwo))
            table.insert(playerTwo.characters, ThunderShaman(playerTwo))
            table.insert(playerTwo.characters, SandWitch(playerTwo))
            table.insert(playerTwo.characters, WaterHag(playerTwo))

            while #playerTwo.characters ~= 4 do     
                local cardNumber = love.math.random(1, #playerTwo.characters)
                table.remove(playerTwo.characters, cardNumber)
            end

           
        elseif player == "client" then

            table.insert(playerOne.characters, GeoGnome(playerOne))
            table.insert(playerOne.characters, AirElemental(playerOne))
            table.insert(playerOne.characters, Alchemist(playerOne))
            table.insert(playerOne.characters, FireMage(playerOne))
            table.insert(playerOne.characters, Druid(playerOne))
            table.insert(playerOne.characters, IceWizard(playerOne))
            table.insert(playerOne.characters, ThunderShaman(playerOne))
            table.insert(playerOne.characters, SandWitch(playerOne))
            table.insert(playerOne.characters, WaterHag(playerOne))

            while #playerOne.characters ~= 4 do     
                local cardNumber = love.math.random(1, #playerOne.characters)
                table.remove(playerOne.characters, cardNumber)
            end
            
            table.insert(playerTwo.characters, GeoGnome(playerTwo))
            table.insert(playerTwo.characters, AirElemental(playerTwo))
            table.insert(playerTwo.characters, Alchemist(playerTwo))
            table.insert(playerTwo.characters, FireMage(playerTwo))
            table.insert(playerTwo.characters, Druid(playerTwo))
            table.insert(playerTwo.characters, IceWizard(playerTwo))
            table.insert(playerTwo.characters, ThunderShaman(playerTwo))
            table.insert(playerTwo.characters, SandWitch(playerTwo))
            table.insert(playerTwo.characters, WaterHag(playerTwo))

            while #playerTwo.characters ~= 4 do     
                local cardNumber = love.math.random(1, #playerTwo.characters)
                table.remove(playerTwo.characters, cardNumber)
            end

        
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

            --[[ table.insert(player.characters, Alchemist(player))
            table.insert(player.characters, Alchemist(player))
            table.insert(player.characters, Alchemist(player))
            table.insert(player.characters, Alchemist(player))
            table.insert(player.characters, Alchemist(player))
            table.insert(player.characters, Alchemist(player))
            table.insert(player.characters, Alchemist(player))
            table.insert(player.characters, Alchemist(player))
            table.insert(player.characters, Alchemist(player)) ]]

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
                local cardNumber = randomFunction(1, #player.characters, "initPlayerDeck")
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
   local diceRoll = randomFunction(1, 6, "getDiceRoll")
   return diceRoll
end

function drawTileHelper()

  

    if isTileHelperOn then
        love.graphics.draw(tileHelperOnImage, width / 16 + tileW, 0)
        love.graphics.draw(tileHelpBackGround, 10, 660)
        for _, row in ipairs(boardGrid) do
            for _, cell in ipairs(row) do
                if cell.isHovered then
                    love.graphics.setFont(statFont)
                    love.graphics.setColor(purpleColor)
                    love.graphics.print(cell.name, tileW / 2 + tileW / 8, (4*150 + 60) + tileH / 4)
                    love.graphics.setFont(littleFont)
                    love.graphics.print(cell.infoText, tileW / 2 + tileW / 8, (4*150 + 60) + tileH / 2)
                    love.graphics.setColor(charColor)
                    love.graphics.setFont(statFont)

                    if cell.isOnFire then
                        love.graphics.setColor(purpleColor)
                        love.graphics.setFont(littleFont)
                        love.graphics.print("This "..cell.name.." is on fire!\n-5HP on entry, -10HP end turn", tileW / 2 + tileW / 8, (4*150 + 60) + tileH + tileH / 4)
                        love.graphics.setColor(charColor)
                        love.graphics.setFont(statFont)
                    end
                    if cell.isPoisoned then
                        love.graphics.setColor(purpleColor)
                        love.graphics.setFont(littleFont)
                        love.graphics.print("This "..cell.name.." is poisoned!\n-3HP on entry, -6HP in 3 turn", tileW / 2 + tileW / 8, (4*150 + 60) + tileH+ tileH / 4)
                        love.graphics.setColor(charColor)
                        love.graphics.setFont(statFont)
                    end
                    if cell.isFrozen then
                        love.graphics.setColor(purpleColor)
                        love.graphics.setFont(littleFont)
                        love.graphics.print("This "..cell.name.." is frozen!\n0 Step points if you start from there", tileW / 2 + tileW / 8, (4*150 + 60) + tileH+ tileH / 4)
                        love.graphics.setColor(charColor)
                        love.graphics.setFont(statFont)
                    end

                   
                end
            end
        end

    end

    if isTileHelperOff then
        love.graphics.draw(tileHelperOffImage, width / 16 + tileW, 0)
    end

    if isTileHelperHoverTextOn then
        love.graphics.setFont(statFont)
        love.graphics.setColor(purpleColor)
        love.graphics.rectangle("fill", mouseX - tileW / 2, (mouseY + tileH / 2) + 4, tileW * 2 + 12, 12)
        love.graphics.setColor(charColor)
        love.graphics.print("tile helper on/off", mouseX - tileW / 2, mouseY + tileH / 2)
        love.graphics.setColor(charColor)
        love.graphics.setFont(statFont)
    end

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
                        love.graphics.print("-1 DF\n-3 AT", modifierX + 36, sideBarY + 39)
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


        if activePlayer == playerone and isGameServer then
            love.graphics.print(playerone.name.." IT'S YOUR TURN!!!", sideBarX + 32, 64)
        elseif isGameServer ~= true and isGameClient ~= true and activePlayer == playerone then
            love.graphics.print(playerone.name.." IT'S YOUR TURN!!!", sideBarX + 32, 64)
        end

        
        

        if activePlayer == playerone then
            love.graphics.print("TURN: #" .. turnCounter, (width - width / 4), height - 60)
            if currentChar.stepPoints ~= 0 then love.graphics.print(currentChar.stepPoints.."SP", sideBarX + 48, sideBarY + 112) end
            if currentChar.actionPoints ~= 0 then love.graphics.print(currentChar.actionPoints.."AP", sideBarX + 88, sideBarY + 112) end
            love.graphics.setFont(statFont)
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


        if activePlayer == playertwo and isGameClient then
            love.graphics.print(playertwo.name.." IT'S YOUR TURN!!!", sideBarX + 32, 64)
        elseif isGameServer ~= true and isGameClient ~= true and activePlayer == playertwo then
            love.graphics.print(playertwo.name.." IT'S YOUR TURN!!!", sideBarX + 32, 64)
        end
      

        if activePlayer == playertwo then
            love.graphics.setColor(charColor)
            love.graphics.print("TURN: #" .. turnCounter, (width - width / 4), height - 60)
            if currentChar.stepPoints ~= 0 then love.graphics.print(currentChar.stepPoints.."SP", sideBarX + 48, sideBarY + 112) end
            if currentChar.actionPoints ~= 0 then love.graphics.print(currentChar.actionPoints.."AP", sideBarX + 88, sideBarY + 112) end
        end

       

        if currentChar.hasItem and currentChar.drawCurrentItem then
            love.graphics.draw(currentChar.ownedItem.itemIcon, sideBarX + tileW + 94, sideBarY + tileH + 5)
        end

    end
 
    love.graphics.setFont(font)
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
    
    local rndCellX = randomFunction(1, 2, "spawnChestPlayerOne") --1 3
    local rndCellY = randomFunction(3, 4, "spawnChestPlayerOne") --2 4


        if not boardGrid[rndCellX][rndCellY].isChest and boardGrid[rndCellX][rndCellY]:instanceOf(Lake) == false 
        and not boardGrid[rndCellX][rndCellY].isOccupied  then 


            boardGrid[rndCellX][rndCellY].isChest = true
            chestCounter = chestCounter + 1
        
    end
end

function spawnChestPlayerTwo()
    local rndCellX = randomFunction(9, 10, "spawnChestPlayerTwo") --7 9
    local rndCellY = randomFunction(7, 8, "spawnChestPlayerTwo") --6 9

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

function moveCharactersToStartingPosition(arg)

        for i, currentChar in ipairs(playerOne.characters) do
            if     i == 1 then currentChar:move(5, 5) --5,2
            elseif i == 2 then currentChar:move(5, 6) --5,3
            elseif i == 3 then currentChar:move(6, 5) --6,2
            elseif i == 4 then currentChar:move(6, 6) --6,3
            end
            currentChar.stepPoints = 2
        end

        for i, currentChar in ipairs(playerTwo.characters) do
            if     i == 1 then currentChar:move(5, 8) --5,8
            elseif i == 2 then currentChar:move(5, 9) --5,9
            elseif i == 3 then currentChar:move(6, 8) --6,8
            elseif i == 4 then currentChar:move(6, 9) --6,9
            end
            currentChar.stepPoints = 2
        end
    

    if gameState.state == gameState.states.selectCharacter then
        table.insert(sequenceBufferTable, {
            name = "creatingRandomizedBoard",
            duration = 1,
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
                        screenShake(0.1, 3)
                        --start mezők beállítása  
                        if      x == 5 and y == 2 or x == 5 and y == 3 or
                                x == 6 and y == 2 or x == 6 and y == 3 or
                                x == 5 and y == 8 or x == 6 and y == 8 or
                                x == 5 and y == 9 or x == 6 and y == 9 then 
                                
                                selectedType = 4
                        -- egyébként legyen random
                        else    selectedType = randomFunction(1, #cellType, "createBoardGrid")           
                        end
                        -- a mezők adatai itt kerülnek be a táblázatba
                    
                        if      selectedType == 1 then 
                            boardGrid[x][y] = Forest(x, y)
                        elseif  selectedType == 2 then 
                            boardGrid[x][y] = Mount(x, y) 
                            soundEngine:playSFX(mountSound)
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
            name = "spawningachestforplayerOne",
            duration = 1.2,
            sequenceTime = love.timer.getTime(),
            action = function()
        
                while chestCounter ~= 1 do
                    spawnChestPlayerOne()
                end
            end
        })
        table.insert(sequenceBufferTable, {
            name = "spawningachestforplayertwo",
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
      
 
  for i=1, #boardGrid do
    for j=1, #boardGrid[i] do
        local currentCell = boardGrid[i][j] 
        local currentTileX = (currentCell.x) * tileW
        local currentTileY = (currentCell.y) * tileH

     
        
        if boardGrid[i][j].isOccupied == true and boardGrid[i][j].occupiedBy and boardGrid[i][j].occupiedBy.parentPlayer == activePlayer and activePlayer == playerOne then
            love.graphics.setLineWidth(3)
            love.graphics.setColor(playerOneColor)
            love.graphics.rectangle("line", (currentTileX + offsetX) + 3, (currentTileY + offsetY) + 3, tileW - 6, tileH - 6)
            love.graphics.setColor(charColor)
            love.graphics.setLineWidth(1)
        end

        if boardGrid[i][j].isOccupied == true and boardGrid[i][j].occupiedBy and boardGrid[i][j].occupiedBy.parentPlayer == activePlayer and activePlayer == playerTwo then
            love.graphics.setLineWidth(3)
            love.graphics.setColor(playerTwoColor)
            love.graphics.rectangle("line", (currentTileX + offsetX) + 3, (currentTileY + offsetY) + 3, tileW - 6, tileH - 6)
            love.graphics.setColor(charColor)
            love.graphics.setLineWidth(1)
        end

        
        if boardGrid[i][j].isOccupied == true and selectedChar == boardGrid[i][j].occupiedBy and boardGrid[i][j]:instanceOf(Volcano) ~= true then
            love.graphics.setLineWidth(3)
            love.graphics.setColor(selectedCharacterColor)
            love.graphics.rectangle("line", (currentTileX + offsetX) + 3, (currentTileY + offsetY) + 3, tileW - 6, tileH - 6)
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

        for i = 255, 0, -1 do
        love.graphics.setColor(255,255,255,i)
        love.graphics.draw(eventWarningImage, width / 4, 30)
        love.graphics.draw(eventWarningImage, width / 4 + 640 - 128, 30)
        love.graphics.draw(eventWarningImage, width / 4, 700)
        end
    end

end

local function drawEventOnBoard()

        Event:drawCurrentEvent()
end

function drawEventOnBackground()
        Event001:drawEventStuff()
end

function enableDrawAttack(character, enemy)
    animTimer = love.timer.getTime()
    animStop = 0.8

    timerStart = love.timer.getTime()
    timerStop = 4
   
    table.insert(sequenceBufferTable, {
        name = "drawingAttackAnimation",
        duration = 0.0,
        sequenceTime = love.timer.getTime(),
        action = function()
            attackAnimation:gotoFrame(1)
            drawnAttackingCharacter = character
            drawnEnemyCharacter = enemy
            enemy.attackTime = love.timer.getTime()
            drawAttackAnim = true
            
           
            

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







local function drawSpellAnimationsOnBoard()
    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar:drawSpellAnimation()
    end
end




local function loadAnimations()

    --banner
    bannerAnimationImage = love.graphics.newImage('graphics/banneranim.png')
    local g = anim8.newGrid(512, 128, bannerAnimationImage:getWidth(), bannerAnimationImage:getHeight())
    bannerAnimation = anim8.newAnimation(g('1-8', 1), 0.1, 'pauseAtEnd')


    --Cell:entry
    ghostAnimationImage = love.graphics.newImage('graphics/ghostanim.png')
    local g = anim8.newGrid(64, 64, ghostAnimationImage:getWidth(), ghostAnimationImage:getHeight())
    ghostAnimation = anim8.newAnimation(g('1-8', 1), 0.1)


    --cell etc

    eruptionAnimationImage = love.graphics.newImage('graphics/eruption.png')
    local g = anim8.newGrid(192, 192, eruptionAnimationImage:getWidth(), eruptionAnimationImage:getHeight())
    eruptionAnimation = anim8.newAnimation(g('1-4', 1), 0.1)

    ---Icons
    local iconAnimSpeed = 0.05

    spellIconAnimationImage = love.graphics.newImage('graphics/spelliconanim.png')
    local g = anim8.newGrid(64, 64, spellIconAnimationImage:getWidth(), spellIconAnimationImage:getHeight())
    spellIconAnimation = anim8.newAnimation(g('1-8', 1), iconAnimSpeed, 'pauseAtEnd')

    attackIconAnimationImage = love.graphics.newImage('graphics/attackiconanim.png')
    local g = anim8.newGrid(64, 64, attackIconAnimationImage:getWidth(), attackIconAnimationImage:getHeight())
    attackIconAnimation = anim8.newAnimation(g('1-8', 1), iconAnimSpeed, 'pauseAtEnd')

    infoIconAnimationImage = love.graphics.newImage('graphics/infoiconanim.png')
    local g = anim8.newGrid(64, 64, infoIconAnimationImage:getWidth(), infoIconAnimationImage:getHeight())
    infoIconAnimation = anim8.newAnimation(g('1-8', 1), iconAnimSpeed, 'pauseAtEnd')    
    
    moveIconAnimationImage = love.graphics.newImage('graphics/moveiconanim.png')
    local g = anim8.newGrid(64, 64, moveIconAnimationImage:getWidth(), moveIconAnimationImage:getHeight())
    moveIconAnimation = anim8.newAnimation(g('1-8', 1), iconAnimSpeed, 'pauseAtEnd')   
    


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

   iceWizardSpellAnimationImage = love.graphics.newImage('graphics/icewizardspellanim2.png')
   local g = anim8.newGrid(192, 128, iceWizardSpellAnimationImage:getWidth(), iceWizardSpellAnimationImage:getHeight())
   iceWizardSpellAnimation = anim8.newAnimation(g('1-4',1), 0.1)

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



function newGame()

    print("newGame")
    

    drawEndGame = false
    isSuddenDeath = false

    playerOne.prisonCount = 0
    playerTwo.prisonCount = 0
    chestCounter = 0
    turnCounter = 0
    eventTurnCounter = 0
    nextTurnBeforeEvent = randomFunction(5, 9, "newGame - next turn before event")
    print("initing player decks")
    initPlayerDeck(playerOne)
    initPlayerDeck(playerTwo)
  
    print("loading character animations")
    loadCharacterAnim()

    print("initing boardGrid")
    boardGrid = {}        
    initBoardgrid()

    print("moving characters to starting position")
    moveCharactersToStartingPosition()

    startingDicePlayerOne = randomFunction(1, 6, "newGame - starting dice player one")
    startingDicePlayerTwo = randomFunction(1, 6, "newGame - starting dice player two")

    if startingDicePlayerOne > startingDicePlayerTwo then rndPlayer = 1 end

    if rndPlayer == 1 then
        activePlayer = playerOne
        inactivePlayer = playerTwo
    else
        activePlayer = playerTwo
        inactivePlayer = playerOne
    end

    for index, currentChar in ipairs(playerOne.characters) do
        currentChar.baseHP = currentChar.maxHP
    end
    for index, currentChar in ipairs(playerTwo.characters) do
        currentChar.baseHP = currentChar.maxHP
    end



    isNewGame = false
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

        boardGrid = {} 
        print('initing grid')
        initBoardgrid()
        print('loading animations')
        loadAnimations() 
    -- loadSounds()
    -- musicPlayer()

    if isGameServer then return
    end
      
    if isGameClient then return
    end

    initPlayerDeck(playerOne)
    initPlayerDeck(playerTwo)      
              
    loadCharacterAnim()
    
    for i, currentChar in ipairs(playerOne.characters) do
        if     i == 1 then 
            currentChar.x = 5 
            currentChar.y = 2 --5,2
        elseif i == 2 then 
            currentChar.x = 5 --5,3
            currentChar.y = 3
        elseif i == 3 then 
            currentChar.x = 6 --6,2
            currentChar.y = 2
        elseif i == 4 then 
            currentChar.x = 6
            currentChar.y = 3 --6,3
        end
        currentChar.stepPoints = 2
    end

    for i, currentChar in ipairs(playerTwo.characters) do
        if     i == 1 then 
            currentChar.x = 5 
            currentChar.y = 8 --5,2
        elseif i == 2 then 
            currentChar.x = 5 --5,3
            currentChar.y = 9
        elseif i == 3 then 
            currentChar.x = 6 --6,2
            currentChar.y = 8
        elseif i == 4 then 
            currentChar.x = 6
            currentChar.y = 9 --6,3
        end
        currentChar.stepPoints = 2
    end

    createBoardGrid()
    

   
end

function board:update(dt)

  
    --if sequenceBufferTable
    
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
    Cell:update(dt)
   
end

function board:draw()
    
    love.graphics.draw(hillShiftLogoImage, width / 4 + 128, 10)
    --drawModifier()
    
    drawBoardGrid()
    drawTileHelper()
    drawChests()

    if enableBannerDraw == false then
        if isGameServer and playerOne == activePlayer then
            drawEndTurnButton()
        elseif isGameClient and playerTwo == activePlayer then
            drawEndTurnButton()
        elseif isGameClient ~= true and isGameServer ~= true then
            drawEndTurnButton()
        end
    end

    drawRectanglesIfHoveredOrOccupied()
    Effector:drawEffector()
    Cell:drawFireParticles()
    Character:drawHealthBar()
  
    Cell:drawPrisonCell()
   
    drawCharactersOnBoard(playerOne)
    drawCharactersOnBoard(playerTwo)
    Character:drawSpeechBubbles()
    drawStatsOnSideBarPlayerOne(playerOne)
    drawStatsOnSideBarPlayerTwo(playerTwo)
    Character:drawCancelButton()
    
    Character:drawValidIcons()
    Character:drawAttackAnimation()
    
    drawSpellAnimationsOnBoard()
    drawPossibleDamageOnEnemyCharacter()
    
    Cell:drawDamageOnBoard()
    drawAttackOnBoard()
    
    Cell:drawLightningOnBoard()
    
    Cell:spawnParticlesWhenInstanced()
    Cell:drawGhostAnim()
    Cell:drawVolcanoAnim()

    drawBanner()
   
    
    
    


    -----EVENT RAJZOLÁS
    drawEventOnBoard()
    drawEventOnBackground()
    drawWarningForNextEvent()

    ---MUSIC ON / OFF

    --drawMusicPlayer()


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