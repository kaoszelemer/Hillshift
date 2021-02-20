-- HillShift - project started: 2021.01.01

--require
class = require('lib.30log')
anim8 = require('lib.anim8')
flux = require('lib.flux')

StateMachine = require('classes.StateMachine')

gameState = StateMachine({
    selectCharacter = {
        name = "selectCharacter",
        transitions = {"selectCharacter", "selectCharacterAction"} 
    },

    selectCharacterAction = {
        name = "selectCharacterAction",
        transitions = {"selectCharacter", "selectMoveTargetCell", "selectSpellTargetArea", "selectAttackTargetCharacter"}
    },

    selectMoveTargetCell = {
        name =  "selectMoveTargetCell",
        transitions = {"selectCharacter", "selectCharacterAction"}
    },

    selectSpellTargetArea = {
        name = "selectSpellTargetArea", 
        transitions = {"selectCharacter", "selectCharacterAction"}
    },

    selectAttackTargetCharacter = {
        name = "selectAttackTargetCharacter",
        transitions = {"selectCharacter", "selectCharacterAction"}
    }
    },
    "selectCharacter"
)



sequenceBufferTable = {}




Cell = require('classes.cells.Cell')
Forest = require('classes.cells.Forest')
Lake = require('classes.cells.Lake')
Mount = require('classes.cells.Mount')
Field = require('classes.cells.Field')
BurntField = require('classes.cells.BurntField')
MagicForest = require('classes.cells.MagicForest')
Desert = require('classes.cells.Desert')
Swamp = require('classes.cells.Swamp')
GlassMount = require('classes.cells.GlassMount')
Ice = require('classes.cells.Ice')
Character = require('classes.characters.Character')
GeoGnome = require('classes.characters.GeoGnome')
Druid = require('classes.characters.Druid')
IceWizard = require('classes.characters.IceWizard')
AirElemental = require('classes.characters.AirElemental')
Alchemist = require('classes.characters.Alchemist')
FireMage = require('classes.characters.FireMage')
ThunderShaman = require('classes.characters.ThunderShaman')
SandWitch = require('classes.characters.SandWitch')
WaterHag = require('classes.characters.WaterHag')

Item = require('classes.items.Item')
Item01 = require('classes.items.Item01')
Item02 = require('classes.items.Item02')
Item03 = require('classes.items.Item03')
Item04 = require('classes.items.Item04')
Item05 = require('classes.items.Item05')
Item06 = require('classes.items.Item06')
Item07 = require('classes.items.Item07')
Item08 = require('classes.items.Item08')
Item09 = require('classes.items.Item09')
Item10 = require('classes.items.Item10')
Item11 = require('classes.items.Item11')

Event = require('classes.events.Event')
Event001 = require('classes.events.Event001')
Event002 = require('classes.events.Event002')
Event003 = require('classes.events.Event003')
Event004 = require('classes.events.Event004')
Event005 = require('classes.events.Event005')
Event006 = require('classes.events.Event006')
Event007 = require('classes.events.Event007')
Event008 = require('classes.events.Event008')
Event009 = require('classes.events.Event009')
Event010 = require('classes.events.Event010')
Event011 = require('classes.events.Event011')
Event012 = require('classes.events.Event012')
Event013 = require('classes.events.Event013')
Event014 = require('classes.events.Event014')
Event015 = require('classes.events.Event015')
Event016 = require('classes.events.Event016')
Event017 = require('classes.events.Event017')
Event018 = require('classes.events.Event018')
Event019 = require('classes.events.Event019')
Event020 = require('classes.events.Event020')
Event021 = require('classes.events.Event021')
Event022 = require('classes.events.Event022')
Event023 = require('classes.events.Event023')
Event024 = require('classes.events.Event024')
Event025 = require('classes.events.Event025')
Event026 = require('classes.events.Event026')
Event027 = require('classes.events.Event027')
Event028 = require('classes.events.Event028')
Event029 = require('classes.events.Event029')
Event030 = require('classes.events.Event030')
Event031 = require('classes.events.Event031')
Event032 = require('classes.events.Event032')
Event033 = require('classes.events.Event033')
Event034 = require('classes.events.Event034')
Event035 = require('classes.events.Event035')
Event036 = require('classes.events.Event036')
Event037 = require('classes.events.Event037')
Event038 = require('classes.events.Event038')
Event039 = require('classes.events.Event039')
Event040 = require('classes.events.Event040')
Event041 = require('classes.events.Event041')
Event042 = require('classes.events.Event042')
Event043 = require('classes.events.Event043')
Event044 = require('classes.events.Event044')
Event045 = require('classes.events.Event045')
Event046 = require('classes.events.Event046')
Event047 = require('classes.events.Event047')
Event048 = require('classes.events.Event048')
Event049 = require('classes.events.Event049')
Event050 = require('classes.events.Event050')
Event051 = require('classes.events.Event051')
Event052 = require('classes.events.Event052')
Event053 = require('classes.events.Event053')
Event054 = require('classes.events.Event054')
Event055 = require('classes.events.Event055')
Event056 = require('classes.events.Event056')
Event057 = require('classes.events.Event057')
Event058 = require('classes.events.Event058')
Event059 = require('classes.events.Event059')
Event060 = require('classes.events.Event060')
Event061 = require('classes.events.Event061')
Event062 = require('classes.events.Event062')
Event063 = require('classes.events.Event063')
Event064 = require('classes.events.Event064')
Event065 = require('classes.events.Event065')
Event066 = require('classes.events.Event066')
Event067 = require('classes.events.Event067')
Event068 = require('classes.events.Event068')
Event069 = require('classes.events.Event069')
Event070 = require('classes.events.Event070')
Event071 = require('classes.events.Event071')
Event072 = require('classes.events.Event072')
Event073 = require('classes.events.Event073')
Event074 = require('classes.events.Event074')
Event075 = require('classes.events.Event075')



require ('board')



--valtozok
--altalanos valtozok
width = 1280
height = 800
numberOfTiles = 10
offsetX = math.floor(width / 2 - (tileW * numberOfTiles / 2)  - tileW)
offsetY = math.floor(height / 2 - (tileH * numberOfTiles / 2) - tileH)


-- counters
turnCounter = 0

nextTurnBeforeEvent = love.math.random(5, 9)
nextTurnBeforeEventModifier = 0
eventTurnCounter = 0

lightningTimer = 0
magicForestTimer = 0
--Colors
charColor = {167 / 255, 147 / 255, 173 / 255}
cellOccupiedColor = {1, 192 / 255, 203 / 255}
hoverColor = {0, 0, 1}
selectedColor = {184 / 255, 0, 0}
greenColor = {0, 1, 0}
blackColor = {0, 0, 0}
darkgreenColor = {0, 64 / 255, 21 / 255}
purpleColor = {87 / 255, 0, 87 / 255}
---
charH = 32
charW = 32
mouseX, mouseY = love.mouse.getPosition()

--betutipus beállítása
statFont = love.graphics.newFont("EquipmentPro.ttf", 20)
actionMenuFont = love.graphics.newFont("EquipmentPro.ttf",32)
font = love.graphics.newFont("EquipmentPro.ttf",40)
love.graphics.setFont(font)
pointFont = love.graphics.newFont("EquipmentPro.ttf",24)
littleFont = love.graphics.newFont("EquipmentPro.ttf",14)

--kepek betoltese
mouseArrow = love.graphics.newImage("/graphics/mousearrow.png")
endGameImage = love.graphics.newImage("graphics/endgame.png")
itemBackgroundImage = love.graphics.newImage("graphics/itembackgroundimage.png")
--aktualis kijelolt karakter
selectedChar = nil

--event tábla
eventTable = {}

function sequenceProcessor()


        for index, sequence in ipairs(sequenceBufferTable) do 
            if index == 1 then 
                if love.timer.getTime() - sequence.sequenceTime >= sequence.duration then
                        print("[SEQUENCE]: "..sequence.name)
                        sequence.action()
                        table.remove(sequenceBufferTable, 1)  
                end
            end
                
        end

end

function endTurn()
    turnCounter = turnCounter + 1
    eventTurnCounter = eventTurnCounter + 1
    oldPlayer = activePlayer
    activePlayer = inactivePlayer
    inactivePlayer = oldPlayer
    local burnCell

        ----------- EZ TÖRTÉNIK A BOARDDAL ------------------
        for x = 1, 10 do
            for y = 1, 10 do

            if boardGrid[x][y]:instanceOf(Mount) and boardGrid[x][y].isOnFire or boardGrid[x][y].isFrozen then
                boardGrid[x][y].HP = boardGrid[x][y].HP - 1
            end

            if boardGrid[x][y]:instanceOf(Mount) and boardGrid[x][y].HP <= 0 then
                boardGrid[x][y] = Desert(x, y)
            end

            if boardGrid[x][y].isBurntField and turnCounter - boardGrid[x][y].burntFieldTimer == 2 then
                boardGrid[x][y] = Field(x, y)
                boardGrid[x][y].isBurntField = false
            end

            if boardGrid[x][y].isPoisoned and turnCounter - boardGrid[x][y].poisoningTurn == 2 then
                boardGrid[x][y].isPoisoned = false
                boardGrid[x][y].attackModifier = boardGrid[x][y].attackModifier + 1
                boardGrid[x][y].defenseModifier = boardGrid[x][y].defenseModifier + 3
            end

            if boardGrid[x][y].isOnFire and turnCounter - boardGrid[x][y].fireTurn == 2 then
               boardGrid[x][y].isOnFire = false
            end
       

            if boardGrid[x][y].isFrozen and turnCounter - boardGrid[x][y].freezeTurn == 2 then
                boardGrid[x][y].isFrozen = false
            end

            if boardGrid[x][y].isFrozen and turnCounter - boardGrid[x][y].freezeTurn == 2 then
                boardGrid[x][y].isFrozen = false
            end

            if boardGrid[x][y]:instanceOf(MagicForest) and turnCounter - magicForestTimer == 3 then

                if love.math.random() < 0.25 then boardGrid[x][y] = Forest(x, y) end
                if love.math.random() < 0.25 then boardGrid[x][y] = Mount(x, y) end
                if love.math.random() < 0.25 then boardGrid[x][y] = Lake(x, y) end
                if love.math.random() < 0.25 then boardGrid[x][y] = Field(x, y) end
                if love.math.random() < 0.12 then boardGrid[x][y] = Desert(x, y) end
                if love.math.random() < 0.10 then boardGrid[x][y] = Swamp(x, y) end
                if love.math.random() < 0.08 then boardGrid[x][y] = GlassMount(x, y) end

            end
        
                
                        
            if boardGrid[x][y].isOnFire and boardGrid[x][y]:instanceOf(Forest) then
                boardGrid[x][y] = BurntField(x, y)
                boardGrid[x][y].isBurntField = true
                boardGrid[x][y].burntFieldTimer = turnCounter
            end
                 
        end
    end
  
        ----------- EZ TÖRTÉNIK AZ INAKTÍVPLAYERREL (MERT Ő VOLT A RÉGI JÁTÉKOS) ------------------

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar.defenseCounter = 0
        currentChar.stepPoints = 1
        currentChar.actionPoints = 1
        if currentChar.stepPointModify then 
            currentChar.stepPoints = currentChar.stepPoints + currentChar.stepPointModifier 
            currentChar.stepPointModify = false
        end
        if currentChar.actionPointModify then 
            currentChar.actionPoints = currentChar.actionPoints + currentChar.actionPointModifier 
            currentChar.actionPointModify = false
        end
       --[[  if currentChar.defenseState then
            currentChar.defenseCounter = currentChar.defenseCounter + 1
        end
         ]]
        local cell = boardGrid[currentChar.x][currentChar.y]

        if not cell.isPoisoned then
            currentChar.turnDefenseModifier = 0
            currentChar.turnAttackModifier = 0
        end
      --[[   if currentChar.defenseState then
            currentChar.turnDefenseModifier = 2
        end
 ]]
        if cell.isFrozen then
            currentChar.stepPoints = 0
        elseif cell.isOnFire then
            currentChar.baseHP = currentChar.baseHP - 2
        elseif cell.isBurntField then
            currentChar.baseHP = currentChar.baseHP - 1
        elseif cell:instanceOf(Lake) then
            currentChar.actionPoints = 0
        end
        if currentChar.baseHP <= 0 then currentChar:kill() end
      
    end


            ----------- EZ TÖRTÉNIK AZ AKTÍVPLAYERREL MERT Ő AZ ÚJ JÁTÉKOS ------------------


    for _, currentChar in ipairs(activePlayer.characters) do
     
        if currentChar.stepPointModify then 
            currentChar.stepPoints = currentChar.stepPoints + currentChar.stepPointModifier 
            currentChar.stepPointModify = false
        end
        if currentChar.actionPointModify then 
            currentChar.actionPoints = currentChar.actionPoints + currentChar.actionPointModifier 
            currentChar.actionPointModify = false
        end
        local cell = boardGrid[currentChar.x][currentChar.y]

        if  currentChar.defenseState and turnCounter - currentChar.defenseCounter >= 1 then
            currentChar.defenseCounter = 0
            currentChar.enableDefendDraw = false
            currentChar.defenseState = false
            currentChar.isInDefenseState = false
            currentChar.turnDefenseModifier = 0
            currentChar.turnAttackModifier = 0
        end


        if cell.isFrozen then
            currentChar.stepPoints = 0
        elseif cell.isOnFire then
            currentChar.baseHP = currentChar.baseHP - 2
        elseif cell.isBurntField then
            currentChar.baseHP = currentChar.baseHP - 1
        elseif cell:instanceOf(Lake) then
            currentChar.actionPoints = 0
        end

        if currentChar.baseHP <= 0 then currentChar:kill() end

        gameState:changeState(gameState.states.selectCharacter)

    end
end

function newTurn()


    gameState:changeState(gameState.states.selectCharacter)

        if eventTurnCounter == nextTurnBeforeEvent + nextTurnBeforeEventModifier then
            Event:enableEvent()
            eventTurnCounter = 0
            nextTurnBeforeEventModifier = 0
        end

        for x = 1, 10 do
            for y = 1, 10 do
                for _, currentChar in ipairs(activePlayer.characters) do

                    if boardGrid[x][y].x == currentChar.x and boardGrid[x][y].y == currentChar.y and boardGrid[x][y]:instanceOf(MagicForest) then
                        currentChar.actionPoints = currentChar.actionPoints + 1
                    end
                end


            end
        end


end

function enableEndGame()

    if #activePlayer.characters < 1 or #inactivePlayer.characters < 1 then
    drawEndGame = true
    end



end

local function selectStartingPlayer()
   
        startingDicePlayerOne = love.math.random(1, 6)
        startingDicePlayerTwo = love.math.random(1, 6)

        if startingDicePlayerOne > startingDicePlayerTwo then rndPlayer = 1 end

        if rndPlayer == 1 then
            activePlayer = playerOne
            inactivePlayer = playerTwo
        else
            activePlayer = playerTwo
            inactivePlayer = playerOne
        end
   
end

local function testMouseForValidSpellDrawing(rMx, rMy)

    local  mX = math.floor((rMx / tileW) - offsetX / tileW) 
    local  mY = math.floor((rMy / tileH) - offsetY / tileH)
 if gameState.state == gameState.states.selectSpellTargetArea or gameState.state == gameState.states.selectAttackTargetCharacter then
        for _, currentChar in ipairs(activePlayer.characters) do

            --- Fent lent jobbra balra

            if currentChar.x < mX then
                pointerOnLeftSide = false
                pointerOnRightSide = true
                pointerOnTopSide = false
                pointerOnBottomSide = false
            elseif currentChar.x  > mX then
                pointerOnLeftSide = true
                pointerOnRightSide = false
                pointerOnTopSide = false
                pointerOnBottomSide = false
            elseif currentChar.y < mY  then
                pointerOnTopSide = false
                pointerOnBottomSide = true
                pointerOnLeftSide = false
                pointerOnRightSide = false
            elseif currentChar.y > mY then
                pointerOnTopSide = true
                pointerOnBottomSide = false
                pointerOnLeftSide = false
                pointerOnRightSide = false
            end 

            --4 irányba pl. alkimista

            if  mX < currentChar.x and mY < currentChar.y then
                pointerOnTopLeftSide = true
                pointerOnTopRightSide = false
                pointerOnBottomRightSide = false
                pointerOnBottomLeftSide = false
            elseif  mX > currentChar.x and mY < currentChar.y then
                pointerOnTopLeftSide = false
                pointerOnTopRightSide = true
                pointerOnBottomRightSide = false
                pointerOnBottomLeftSide = false
            elseif  mX < currentChar.x and mY > currentChar.y then
                pointerOnTopLeftSide = false
                pointerOnTopRightSide = false
                pointerOnBottomRightSide = false
                pointerOnBottomLeftSide = true
            elseif  mX > currentChar.x and mY > currentChar.y then
                pointerOnTopLeftSide = false
                pointerOnTopRightSide = false
                pointerOnBottomRightSide = true
                pointerOnBottomLeftSide = false
            end
        end
    else
        pointerOnBottomLeftSide = false
        pointerOnBottomRightSide = false
        pointerOnBottomSide = false
        pointerOnTopLeftSide = false
        pointerOnTopRightSide = false
        pointerOnTopSide = false
        pointerOnLeftSide = false
        pointerOnRightSide = false
    end
  
end

local function testMouseForInventoryHover(mx, my)

    for i, currentChar in ipairs(activePlayer) do
        local pxp = width / 6
        if currentChar.hasItem and
            (mx > pxp - 48 and mx < pxp - 24) and
            (my > i * 108 and my < i * 108 + 24) then
                currentChar.inventoryHover = true
        end
    end

    for i, currentChar in ipairs(inactivePlayer) do
        local pxp = width / 6
        if currentChar.hasItem and
            (mx > pxp - 48 and mx < pxp - 24) and
            (my > i * 108 and my < i * 108 + 24) then
                currentChar.inventoryHover = true
        end
    end

    inventoryHover = false


end

function loadCharacterAnim()

    for _, currentChar in ipairs(playerOne.characters) do
        print("loading character animation for "..currentChar.name)
        currentChar.animImage = currentChar.idleAnimImage
        local g = anim8.newGrid(64, 64, currentChar.idleAnimImage:getWidth(), currentChar.idleAnimImage:getHeight())
        currentChar.animation = anim8.newAnimation(g('1-4', 1, '3-2', 1), 0.2)
    end

    for _, currentChar in ipairs(playerTwo.characters) do
        print("loading character animation for "..currentChar.name)
        currentChar.animImage = currentChar.idleAnimImage
        local g = anim8.newGrid(64, 64, currentChar.idleAnimImage:getWidth(), currentChar.idleAnimImage:getHeight())
        currentChar.animation = anim8.newAnimation(g('1-4', 1, '3-2', 1), 0.2)
    end

  


end

function love.load()
    --board betoltese
  
    board:load()
    loadCharacterAnim()
    Event:initEventTable()
    Item:initItemTable()
    selectStartingPlayer()
    --beallitasok
    love.window.setTitle("HillShift")
    love.graphics.setBackgroundColor(39 / 255,0,66 / 255)
    love.window.setMode(width,height)
    love.mouse.setVisible(false)
end

function love.update(dt)
    flux.update(dt)
    mouseX, mouseY = love.mouse.getPosition()
    board:update(dt)
    Character:update(dt)
    sequenceProcessor()
    enableEndGame()
    

end

function love.draw()
    board:draw()
    love.graphics.setColor(charColor)
    Item:drawCurrentItem()
   
   
    if drawEndGame then
        love.graphics.draw(endGameImage, boardGrid[1][1].x * tileW + offsetX, boardGrid[1][1].y * tileH + offsetY)
        love.graphics.setFont(actionMenuFont)
        love.graphics.setColor(selectedColor)
        if #activePlayer.characters == 0 then
            love.graphics.print(inactivePlayer.name, 260 + offsetX, 580 + offsetY)
        else
            love.graphics.print(activePlayer.name, 260 + offsetX, 580 + offsetY)
        end
        love.graphics.setFont(statFont)
        love.graphics.setColor(charColor)

    end

    love.graphics.draw(mouseArrow, mouseX, mouseY)

end

function love.mousemoved( x, y, dx, dy, istouch )

   testMouseForValidSpellDrawing(x, y)

   testMouseForInventoryHover(x, y)

    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar:updateHover(x, y)        
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar:updateHover(x, y)
        currentChar:enablePossibleDamageDraw()
    end

end

function love.mousereleased(x, y, button, istouch, presses) 
    if not drawEndGame then

        if button == 2 then
            gameState:changeState(gameState.states.selectCharacter)
        end

        if not enableEvent then
            for _, currentChar in ipairs(activePlayer.characters) do
                if currentChar.isHovered then currentChar:click(x, y) end  
            
            end

            for _, currentChar in ipairs(inactivePlayer.characters) do
                
                if currentChar.isHovered then currentChar:click(x, y) end  
            
            end




            local mx = math.floor((mouseX / tileW) - offsetX / tileW) 
            local my = math.floor((mouseY / tileH) - offsetY / tileH)

            if (mx <= 10 and mx >= 1) and (my <= 10 and my >= 1) then
                boardGrid[mx][my]:click()
            end

            if (x > width / 2 + 192 and x < width / 2 + 310) and (y > height - 70 and y < height - 30) then
                isEndTurnButtonClicked = false
                endTurn()
                newTurn()
            end

        end

        if enableEvent and
            x > (width / 4 + offsetX) + 200 and x < (width / 4 + offsetX) + 352 and
            y > (height / 4 + offsetY) + 230 and y < ((height / 4 + offsetY) + 310) then
                isEndTurnButtonClicked = false
                Event:confirmEventWithClick()
                
        end

        if Item.drawItemOnScreen and
        x > (width / 4 + offsetX) + 200 and x < (width / 4 + offsetX) + 352 and
        y > (height / 4 + offsetY) + 230 and y < ((height / 4 + offsetY) + 310) then
                Item:confirmItemPickup()
           end


        

    end

function love.mousepressed( x, y, button, istouch, presses )
    if (x > width / 2 + 192 and x < width / 2 + 310) and (y > height - 70 and y < height - 30) then
       isEndTurnButtonClicked = true
    end
end

end
