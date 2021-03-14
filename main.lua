-- HillShift - project started: 2021.01.01

isDebug = false

--require
class = require('lib.30log')
anim8 = require('lib.anim8')
flux = require('lib.flux')
tween = require('lib.tween')
sock = require('lib.sock')

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

deadPool = {}


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
charColor = {167 / 255, 147 / 255, 173 / 255, 255}
cellOccupiedColor = {1, 192 / 255, 203 / 255, 255}
hoverColor = {0, 0, 1, 255}
selectedColor = {184 / 255, 0, 0, 255}
greenColor = {0, 1, 0, 255}
blackColor = {0, 0, 0, 255}
darkgreenColor = {0, 64 / 255, 21 / 255, 255}
purpleColor = {87 / 255, 0, 87 / 255, 255}
yellowColor = {1,1,0, 255}
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
    drawAttack = false
    turnCounter = turnCounter + 1
    
    eventTurnCounter = eventTurnCounter + 1
    if turnCounter == 20 then 
        isSuddenDeath = true 
        if turnCounter == 20 then isDrawEventForSuddenDeath = true end
        --eventTurnCounter = -40
        --chestCounter = 30
    end
    oldPlayer = activePlayer
    activePlayer = inactivePlayer
    inactivePlayer = oldPlayer
    local burnCell

        ----------- EZ TÖRTÉNIK A BOARDDAL ------------------
      


    for x = 1, 10 do
        for y = 1, 10 do

            if isSuddenDeath then

                        eventTurnCounter = -40
                        for v = 1, 10 do  
                            if turnCounter == 19 + v then
                            
                            
                                boardGrid[v][y].isOnFire = true 
                                boardGrid[x][v].isOnFire = true
                                boardGrid[11-v][y].isOnFire = true
                                boardGrid[x][11-v].isOnFire = true
                                
                            end
                        end
                
            else

                

                if boardGrid[x][y]:instanceOf(Mount) and boardGrid[x][y].isOnFire or boardGrid[x][y].isFrozen then
                    boardGrid[x][y].HP = boardGrid[x][y].HP - 1
                end

                if boardGrid[x][y]:instanceOf(Mount) and boardGrid[x][y].HP <= 0 then
                    boardGrid[x][y] = Desert(x, y)
                    boardGrid[x][y].isInstanced = true
                end

                if boardGrid[x][y].isBurntField and turnCounter - boardGrid[x][y].burntFieldTimer == 2 then
                    boardGrid[x][y] = Field(x, y)
                    boardGrid[x][y].isInstanced = true
                    boardGrid[x][y].isBurntField = false
                end

                if boardGrid[x][y].isPoisoned and turnCounter - boardGrid[x][y].poisoningTurn == 2 then
                    boardGrid[x][y].isPoisoned = false
                    for _, currentChar in ipairs(activePlayer.characters) do
                        if currentChar == boardGrid[x][y].occupiedBy then
                            currentChar.defenseModifier = currentChar.turnDefenseModifier + 1
                            currentChar.attackModifier = currentChar.turnAttackModifier + 3
                        end
                    end
                    for _, currentChar in ipairs(inactivePlayer.characters) do
                        if currentChar == boardGrid[x][y].occupiedBy then
                            currentChar.turnDefenseModifier = currentChar.turnDefenseModifier + 1
                            currentChar.turnAttackModifier = currentChar.turnAttackModifier + 3
                        end
                    end
                end

                if boardGrid[x][y].isOnFire and turnCounter - boardGrid[x][y].fireTurn == 3 then
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

    
        currentChar.turnDefenseModifier = 0
        currentChar.turnAttackModifier = 0
        
      --[[   if currentChar.defenseState then
            currentChar.turnDefenseModifier = 2
        end
 ]]
        if cell.isFrozen then
            currentChar.stepPoints = 0
        elseif cell.isOnFire then
            currentChar.baseHP = currentChar.baseHP - 10
        elseif cell.isBurntField then
            currentChar.baseHP = currentChar.baseHP - 7
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

     


        if cell.isFrozen then
            currentChar.stepPoints = 0
        elseif cell.isOnFire then
            currentChar.baseHP = currentChar.baseHP - 10
        elseif cell.isBurntField then
            currentChar.baseHP = currentChar.baseHP - 7
        elseif cell:instanceOf(Lake) then
            currentChar.actionPoints = 0
        end

        if currentChar.baseHP <= 0 then currentChar:kill() end

        gameState:changeState(gameState.states.selectCharacter)

    end
end

function newTurn()


    gameState:changeState(gameState.states.selectCharacter)

        if not suddenDeath and eventTurnCounter == nextTurnBeforeEvent + nextTurnBeforeEventModifier then
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

    Cell:resetParticleDrawing()

end


function spawnPrison(player)
    if turnCounter < 20 then
        print(playerOne.prisonCount, playerTwo.prisonCount)
        if player == playerTwo and playerTwo.prisonCount == 0 then
            boardGrid[1][10] = Field(1, 10)
            boardGrid[1][10].isPrison = true
            playerTwo.prisonCount = playerTwo.prisonCount + 1
        end
        if player == playerOne and playerOne.prisonCount == 0 then
            boardGrid[10][1] = Field(10, 1)
            boardGrid[10][1].isPrison = true
            playerOne.prisonCount = playerOne.prisonCount + 1
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
    pointerOnBottomLeftSide = false
    pointerOnBottomRightSide = false
    pointerOnBottomSide = false
    pointerOnTopLeftSide = false
    pointerOnTopRightSide = false
    pointerOnTopSide = false
    pointerOnLeftSide = false
    pointerOnRightSide = false

    local  mX = math.floor((rMx / tileW) - offsetX / tileW) 
    local  mY = math.floor((rMy / tileH) - offsetY / tileH)
 if gameState.state == gameState.states.selectSpellTargetArea or gameState.state == gameState.states.selectAttackTargetCharacter then
        for _, currentChar in ipairs(activePlayer.characters) do


            --- Fent lent jobbra balra
            if currentChar.x < mX  then
                pointerOnLeftSide = false
                pointerOnRightSide = true
                pointerOnTopSide = false
                pointerOnBottomSide = false
            end
            if currentChar.x  > mX then
                pointerOnLeftSide = true
                pointerOnRightSide = false
                pointerOnTopSide = false
                pointerOnBottomSide = false
            end
            if currentChar.y < mY then
                pointerOnTopSide = false
                pointerOnBottomSide = true
                pointerOnLeftSide = false
                pointerOnRightSide = false
            end
            if currentChar.y > mY then
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
            end
            if  mX > currentChar.x and mY < currentChar.y then
                pointerOnTopLeftSide = false
                pointerOnTopRightSide = true
                pointerOnBottomRightSide = false
                pointerOnBottomLeftSide = false
            end
            if  mX < currentChar.x and mY > currentChar.y then
                pointerOnTopLeftSide = false
                pointerOnTopRightSide = false
                pointerOnBottomRightSide = false
                pointerOnBottomLeftSide = true
            end
            if  mX > currentChar.x and mY > currentChar.y then
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



function spawnChestIfPlayerIsBehind()

    if not suddenDeath and chestCounter == 0 and #activePlayer.characters - #inactivePlayer.characters >= 2 or #inactivePlayer.characters - #activePlayer.characters >= 2 then
        if inactivePlayer == playerOne then
            while chestCounter ~= 1 do
            spawnChestPlayerOne()
            end
        else
            while chestCounter ~= 1 do
            spawnChestPlayerTwo()
            end
        end

    end

end

local function loadParticleSystems()
    rockParticleImage = love.graphics.newImage("graphics/rockparticle.png")
    rockParticleSystem = love.graphics.newParticleSystem(rockParticleImage, 8)
    rockParticleSystem:setParticleLifetime(1, 1)
    rockParticleSystem:setEmissionRate(32)
    rockParticleSystem:setLinearAcceleration(-240,-290,240,290)
    rockParticleSystem:setSizes(1, 2, 3)
    rockParticleSystem:setSizeVariation(1)
    rockParticleSystem:setSpeed(50,60)
    rockParticleSystem:setSpread(6)
    rockParticleSystem:setRotation(1, 2)

    forestFieldParticleImage = love.graphics.newImage("graphics/forestfieldparticle.png")
    forestFieldParticleSystem = love.graphics.newParticleSystem(forestFieldParticleImage, 8)
    forestFieldParticleSystem:setParticleLifetime(1, 1)
    forestFieldParticleSystem:setEmissionRate(32)
    forestFieldParticleSystem:setLinearAcceleration(-240,-290,240,290)
    forestFieldParticleSystem:setSizes(1, 2, 3)
    forestFieldParticleSystem:setSizeVariation(1)
    forestFieldParticleSystem:setSpeed(50,60)
    forestFieldParticleSystem:setSpread(6)
    forestFieldParticleSystem:setRotation(1, 2)

    fireParticleImage = love.graphics.newImage("graphics/fireparticle.png")
    fireParticleSystem = love.graphics.newParticleSystem(fireParticleImage, 8)
    fireParticleSystem:setParticleLifetime(0.4, 0.6)
    fireParticleSystem:setEmissionRate(1)
    fireParticleSystem:setLinearAcceleration(-240,-290,240,290)
    fireParticleSystem:setSizes(1, 2, 3)
    fireParticleSystem:setSizeVariation(1)
    fireParticleSystem:setSpeed(10,20)
    fireParticleSystem:setSpread(6)
    fireParticleSystem:setRotation(1, 2)

    waterParticleImage = love.graphics.newImage("graphics/waterparticle.png")
    waterParticleSystem = love.graphics.newParticleSystem(waterParticleImage, 8)
    waterParticleSystem:setParticleLifetime(1, 1)
    waterParticleSystem:setEmissionRate(1)
    waterParticleSystem:setLinearAcceleration(-240,-290,240,290)
    waterParticleSystem:setSizes(1, 2, 3)
    waterParticleSystem:setSizeVariation(1)
    waterParticleSystem:setSpeed(10,20)
    waterParticleSystem:setSpread(6)
    waterParticleSystem:setRotation(1, 2)

    desertParticleImage = love.graphics.newImage("graphics/desertparticle.png")
    desertParticleSystem = love.graphics.newParticleSystem(desertParticleImage, 8)
    desertParticleSystem:setParticleLifetime(1, 1)
    desertParticleSystem:setEmissionRate(1)
    desertParticleSystem:setLinearAcceleration(-240,-290,240,290)
    desertParticleSystem:setSizes(1, 2, 3)
    desertParticleSystem:setSizeVariation(1)
    desertParticleSystem:setSpeed(10,20)
    desertParticleSystem:setSpread(6)
    desertParticleSystem:setRotation(1, 2)

    iceParticleImage = love.graphics.newImage("graphics/iceparticle.png")
    iceParticleSystem = love.graphics.newParticleSystem(iceParticleImage, 8)
    iceParticleSystem:setParticleLifetime(1.2, 1.2)
    iceParticleSystem:setEmissionRate(1000)
    iceParticleSystem:setLinearAcceleration(-10,30,1,290)
    iceParticleSystem:setSizes(1, 2, 3)
    iceParticleSystem:setSizeVariation(1)
    iceParticleSystem:setSpeed(30,40)
    iceParticleSystem:setSpread(6)
    iceParticleSystem:setRotation(1, 2)

    magicParticleImage = love.graphics.newImage("graphics/magicparticle.png")
    magicParticleSystem = love.graphics.newParticleSystem(magicParticleImage, 8)
    magicParticleSystem:setParticleLifetime(1, 1.2)
    magicParticleSystem:setEmissionRate(1000000)
    magicParticleSystem:setLinearAcceleration(-240,-290,240,290)
    magicParticleSystem:setSizes(1, 2, 3)
    magicParticleSystem:setSizeVariation(1)
    magicParticleSystem:setSpeed(10,20)
    magicParticleSystem:setSpread(6)
    magicParticleSystem:setRotation(1, 2)

    glassParticleImage = love.graphics.newImage("graphics/glassparticle.png")
    glassParticleSystem = love.graphics.newParticleSystem(glassParticleImage, 8)
    glassParticleSystem:setParticleLifetime(0.1, 1.2)
    glassParticleSystem:setEmissionRate(1000000)
    glassParticleSystem:setLinearAcceleration(-240,-290,240,290)
    glassParticleSystem:setSizes(1, 2, 3)
    glassParticleSystem:setSizeVariation(1)
    glassParticleSystem:setSpeed(10,20)
    glassParticleSystem:setSpread(6)
    glassParticleSystem:setRotation(1, 2)


    --------OTHER PARTICLES



    bloodParticleImage = love.graphics.newImage("graphics/bloodparticle.png")
    bloodParticleSystem = love.graphics.newParticleSystem(bloodParticleImage, 8)
    bloodParticleSystem:setParticleLifetime(1, 5)
    bloodParticleSystem:setEmissionRate(2)
    bloodParticleSystem:setLinearAcceleration(-320,-340,320,340)
    bloodParticleSystem:setSizes(1, 2, 3, 4, 5)
    bloodParticleSystem:setSizeVariation(1)
    bloodParticleSystem:setSpeed(100,200)
    bloodParticleSystem:setSpread(6)
    bloodParticleSystem:setRotation(1, 2)

    burntFieldParticleImage = love.graphics.newImage("graphics/burntfieldparticle.png")
    burntFieldParticleImage:setFilter("linear","linear")
    burntFieldParticleSystem = love.graphics.newParticleSystem(burntFieldParticleImage, 16)
    burntFieldParticleSystem:setColors(0.49615383148193, 0.49615383148193, 0.49615383148193, 0.66538459062576, 1, 1, 1, 0.89999997615814, 1, 1, 1, 0.41153845191002, 1, 1, 1, 0.26153847575188)
    burntFieldParticleSystem:setDirection(-1.5707963705063)
    burntFieldParticleSystem:setEmissionArea("ellipse", 32.436187744141, 29.382717132568, 3.1415927410126, false)
    burntFieldParticleSystem:setEmissionRate(8.152135848999)
    burntFieldParticleSystem:setEmitterLifetime(-1)
    burntFieldParticleSystem:setInsertMode("top")
    burntFieldParticleSystem:setLinearAcceleration(-1.2439172267914, 0.049756690859795, 2.4380776882172, 0.049756690859795)
    burntFieldParticleSystem:setLinearDamping(-0.0017912408802658, 8.0408802032471)
    burntFieldParticleSystem:setOffset(50, 50)
    burntFieldParticleSystem:setParticleLifetime(0.30825263261795, 2.2000000476837)
    burntFieldParticleSystem:setRadialAcceleration(0, 0)
    burntFieldParticleSystem:setRelativeRotation(false)
    burntFieldParticleSystem:setRotation(0, 0)
    burntFieldParticleSystem:setSizeVariation(0)
    burntFieldParticleSystem:setSpeed(20.302917480469, 27.786323547363)
    burntFieldParticleSystem:setSpin(1.5131316184998, -1.3010431528091)
    burntFieldParticleSystem:setSpinVariation(0)
    burntFieldParticleSystem:setSpread(0.31415927410126)
    burntFieldParticleSystem:setTangentialAcceleration(-0.099513381719589, 0)

    steamParticleImage = love.graphics.newImage("graphics/steamparticle.png")
    steamParticleImage:setFilter("linear","linear")
    steamParticleSystem = love.graphics.newParticleSystem(steamParticleImage, 16)
    steamParticleSystem:setDirection(-1.5707963705063)
    steamParticleSystem:setEmissionArea("uniform", 63.572940826416, 63.572940826416, 3.1415927410126, false)
    steamParticleSystem:setEmissionRate(8.152135848999)
    steamParticleSystem:setEmitterLifetime(-1)
    steamParticleSystem:setInsertMode("top")
    steamParticleSystem:setLinearAcceleration(-1.2439172267914, 0.049756690859795, 2.4380776882172, 0.049756690859795)
    steamParticleSystem:setLinearDamping(-0.0017912408802658, 8.0408802032471)
    steamParticleSystem:setOffset(50, 50)
    steamParticleSystem:setParticleLifetime(0.30825263261795, 2.2000000476837)
    steamParticleSystem:setRadialAcceleration(0, 0)
    steamParticleSystem:setRelativeRotation(false)
    steamParticleSystem:setRotation(0, 0)
    steamParticleSystem:setSizeVariation(0)
    steamParticleSystem:setSpeed(2.302917480469, 7.786323547363)
    steamParticleSystem:setSpin(1.5131316184998, -1.3010431528091)
    steamParticleSystem:setSpinVariation(0)
    steamParticleSystem:setSpread(0.31415927410126)
    steamParticleSystem:setTangentialAcceleration(-0.099513381719589, 0)
    




end

local function updateParticleSystems(dt)
    rockParticleSystem:update(dt)
    fireParticleSystem:update(dt)  
    forestFieldParticleSystem:update(dt)
    waterParticleSystem:update(dt)
    desertParticleSystem:update(dt)
    iceParticleSystem:update(dt)
    magicParticleSystem:update(dt)
    glassParticleSystem:update(dt)
    --Other Particle systems
    bloodParticleSystem:update(dt)
    burntFieldParticleSystem:update(dt)
    for step = 1, 96 do steamParticleSystem:update(0.0051606524114807) end
end




local function quitGame()
    print("Quitting... Goodbye!")
    love.event.push("quit")
end

local function loadNetworkingServer()

 server = sock.newServer("127.0.0.1", 22122)
 server:on("connect", function(data, client)
     local msg = "Server - Pong!"
     client:send("hello", msg)
 end)

end

local function loadNetworkingClient(ipaddress)
    local IP = ipaddress
    print("Joining to"..ipaddress)

    client = sock.newClient(ipaddress, 22122)

    client:on("connect", function(data)
        print("Client connected to the server.")
    end)
    
    client:on("disconnect", function(data)
        print("Client disconnected from the server.")
    end)

    -- Custom callback, called whenever you send the event from the server
    client:on("hello", function(msg)
        print("The server reply to ping: " .. msg)
    end)

    client:connect()
    
    --  You can send different types of data
    --[[ client:send("greeting", "Hello, my name is Inigo Montoya.")
    client:send("isShooting", true)
    client:send("bulletsLeft", 1)
    client:send("position", {
        x = 465.3,
        y = 50,
    }) ]]




end

function love.load(arg)
   -- love.window.setFullscreen(true, "desktop")

    local a = arg[1]
    local servercreator = "-create"
    local serverjoiner = "-join"

    if a == servercreator then 
        
        loadNetworkingServer()
        isServer = true
    end

    if a == serverjoiner then

        loadNetworkingClient(arg[2])
        isClient = true
    end

    love.window.setMode(width,height)
    --Particle systems
  

    loadParticleSystems()
   
    
    --board betoltese
    
    board:load()
    loadCharacterAnim()
    Event:initEventTable()
    Item:initItemTable()
    selectStartingPlayer()
    --beallitasok
    love.window.setTitle("HillShift")
    love.graphics.setBackgroundColor(39 / 255,0,66 / 255)
  
    love.mouse.setVisible(false)
end

function love.update(dt)
    updateParticleSystems(dt)
    flux.update(dt)
    mouseX, mouseY = love.mouse.getPosition()
    board:update(dt)
    Character:update(dt)
    sequenceProcessor()
    enableEndGame()
    if isServer then
        server:update()
    end

    if isClient then
        client:update()
    end
    

end

function love.draw()

    --scaling
    
    local screenWidth, screenHeight = love.window.getDesktopDimensions()

    local scaleX =  (screenWidth / width)
    local scaleY =  (screenHeight / height)
  
    if scaleX == 1 and scaleY == 1 then
        scaleX, scaleY = (screenWidth / width), (screenHeight / height)
    end

   -- love.graphics.scale(scaleX, scaleY)


    board:draw()
    Character:drawParticles()
    love.graphics.setColor(charColor)
    Item:drawCurrentItem()

   
    if drawEndGame then
        love.graphics.draw(endGameImage, boardGrid[1][1].x * tileW + offsetX, boardGrid[1][1].y * tileH + offsetY)
        love.graphics.setFont(actionMenuFont)
        love.graphics.setColor(selectedColor)
        love.graphics.print("ALL HILLS WERE SHIFTED.\n\nThat means you killed\nall of your enemies.\nYou've made the world:", boardGrid[1][1].x * tileW + offsetX + tileW, boardGrid[1][1].y * tileH + offsetY + tileH * 2)
        if #activePlayer.characters == 0 then
            love.graphics.print(inactivePlayer.name, 360 + offsetX, 380 + offsetY)
        else
            love.graphics.print(activePlayer.name, 360 + offsetX, 380 + offsetY)
        end
        love.graphics.setFont(statFont)
        love.graphics.setColor(charColor)

    end

    if isDrawEventForSuddenDeath then
        local eventX = (width / 4 + offsetX)
        local eventY = (height / 4 + offsetY)
        love.graphics.draw(eventBackgroundImage, eventX, eventY)
        love.graphics.setFont(statFont)
        love.graphics.setColor(purpleColor)
        love.graphics.print("SUDDEN DEATH mode is on.\n\nUnstoppable flames will spread\naround the board.\n\nBe QUICK or DIE!", eventX + tileW, eventY + tileH)
        love.graphics.setFont(font)
        love.graphics.setColor(charColor)
    end

    if isDrawEventForPrisonSpawn and turnCounter < 20 then
        local eventX = (width / 4 + offsetX)
        local eventY = (height / 4 + offsetY)
        love.graphics.draw(eventBackgroundImage, eventX, eventY)
        love.graphics.setFont(statFont)
        love.graphics.setColor(purpleColor)
        love.graphics.print("A PRISON has spawned!\n\nYour character not dead yet.\nYou can free him,\nby moving to the prison cell\n\nYou wont have a chance\nlike this again!", eventX + tileW, eventY + tileH)
        love.graphics.setFont(font)
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
    if drawEndGame and
       
    x > (boardGrid[1][1].x * tileW + offsetX) + 106 and x < (boardGrid[1][1].x * tileW + offsetX) + 223 and
    y > (boardGrid[1][1].y * tileH + offsetY) + 450 and y < (boardGrid[1][1].y * tileH + offsetY) + 492 then
        quitGame()
    end

    if drawEndGame and
       
    x > (boardGrid[1][1].x * tileW + offsetX) + 435 and x < (boardGrid[1][1].x * tileW + offsetX) + 555 and
    y > (boardGrid[1][1].y * tileH + offsetY) + 450 and y < (boardGrid[1][1].y * tileH + offsetY) + 492 then
        isNewGame = true
        newGame()
    end


    if not drawEndGame then
     

        if button == 2 then
            gameState:changeState(gameState.states.selectCharacter)
        end

        if not enableEvent and not isDrawEventForPrisonSpawn and not isDrawEventForSuddenDeath then
            for _, currentChar in ipairs(activePlayer.characters) do

                if currentChar.isHovered then 
                    currentChar:click(x, y) 
                end  
            
            end

            for _, currentChar in ipairs(inactivePlayer.characters) do

                if currentChar.isHovered then 
                    currentChar:click(x, y) 
                end  
            
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

        if isDrawEventForSuddenDeath and
        x > (width / 4 + offsetX) + 200 and x < (width / 4 + offsetX) + 352 and
        y > (height / 4 + offsetY) + 230 and y < ((height / 4 + offsetY) + 310) then
            isDrawEventForSuddenDeath = false
            
        end

        if isDrawEventForPrisonSpawn and
        x > (width / 4 + offsetX) + 200 and x < (width / 4 + offsetX) + 352 and
        y > (height / 4 + offsetY) + 230 and y < ((height / 4 + offsetY) + 310) then
            isDrawEventForPrisonSpawn = false
            
        end

        if Item.drawItemOnScreen and
                x > (width / 4 + offsetX) + 200 and x < (width / 4 + offsetX) + 352 and
                y > (height / 4 + offsetY) + 230 and y < ((height / 4 + offsetY) + 310) then
                Item:confirmItemPickup()
        end

        if isCancelButton then
            local sx = selectedChar.x * tileW + offsetX
            local sy = selectedChar.y * tileW + offsetY
        
            if x > sx  and x < (sx + tileW) - tileW / 6 and
                y > sy and y < (sy + tileW) - tileW /6 then
                    gameState:changeState(gameState.states.selectCharacter)
                    isCancelButton = false
            end

        end

       

end

function love.mousepressed( x, y, button, istouch, presses )
    if not enableEvent and not enableEndGame and not isDrawEventForPrisonSpawn and not isDrawEventForSuddenDeath then
        if (x > width / 2 + 192 and x < width / 2 + 310) and (y > height - 70 and y < height - 30) then
        isEndTurnButtonClicked = true
        end
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit") -- quit the game
    end
end



end
