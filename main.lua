-- HillShift - project started: 2021.01.01

--**** fullscreen or windowed
--creating randomgenerator object for sending state over network



isGameFullScreen = false
isMusicOn = true
isDebugDrawHoveredTiles = true
isTileHelperOn = true
debugIsTurnTimer = true
enableBannerDraw = false
--debugVolcanoChance = 0.77

timerActive = true


--require

--libs
class = require('lib.30log')
anim8 = require('lib.anim8')
flux = require('lib.flux')
tween = require('lib.tween')
ripple = require('lib.ripple')
sock = require('lib.sock')
bitser = require('lib.bitser')
smallfolks = require('lib.smallfolks')
lurker = require('lib.lurker')

--own files

helper = {}

StateMachine = require('classes.StateMachine')
speechBubbleTextTable = require('speechbubbles')

gameState = StateMachine({
    selectCharacter = {
        name = "selectCharacter",
        transitions = {"selectCharacter", "selectCharacterAction", "waitingState"} 
    },

    selectCharacterAction = {
        name = "selectCharacterAction",
        transitions = {"selectCharacter", "selectCharacterAction", "selectMoveTargetCell", "selectSpellTargetArea", "selectAttackTargetCharacter", "waitingState"}
    },

    selectMoveTargetCell = {
        name =  "selectMoveTargetCell",
        transitions = {"selectCharacter", "selectCharacterAction", "waitingState"}
    },

    selectSpellTargetArea = {
        name = "selectSpellTargetArea", 
        transitions = {"selectCharacter", "selectCharacterAction", "waitingState"}
    },

    selectAttackTargetCharacter = {
        name = "selectAttackTargetCharacter",
        transitions = {"selectCharacter", "selectCharacterAction", "waitingState"}
    },
    
    waitingState = {
        name = "waitingState",
        transitions = {"selectCharacter", "selectCharacterAction", "selectMoveTargetCell", "selectSpellTargetArea", "selectAttackTargetCharacter", "waitingState"}
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
Graveyard = require('classes.cells.Graveyard')
Volcano = require('classes.cells.Volcano')
Shrine = require('classes.cells.Shrine')

Effector = require('classes.effectors.Effector')
Burn = require('classes.effectors.Burn')
Freeze = require('classes.effectors.Freeze')
Poison = require('classes.effectors.Poison')


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

deadPool = {playerOne = {}, playerTwo = {}}



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


require ('soundengine')
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
magicForestCounter = 0

nextTurnBeforeEventModifier = 0
eventTurnCounter = 0

--timers
lightningTimer = 0
magicForestTimer = 0
gameStartTimer = love.timer.getTime()
bubbleTimer = 0
turnTimer = 0
timeWaited = 0

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
selectedCharacterColor = {1, 111 / 255, 0, 255}
playerOneColor = {214 / 255, 0, 104 / 255, 255}
playerTwoColor = {115 / 255, 241 / 255, 1, 255}
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
clockFont = love.graphics.newFont("EquipmentPro.ttf", 52)

--kepek betoltese
mouseArrow = love.graphics.newImage("/graphics/mousearrow.png")
mouseArrowP2 = love.graphics.newImage("/graphics/mousearrowp2.png")
endGameImage = love.graphics.newImage("graphics/endgame.png")
itemBackgroundImage = love.graphics.newImage("graphics/itembackgroundimage.png")
musicOnImage = love.graphics.newImage("graphics/musicon.png")
musicOffImage = love.graphics.newImage("graphics/musicoff.png")
tileHelperOnImage = love.graphics.newImage("graphics/tilehelperon.png")
tileHelperOffImage = love.graphics.newImage("graphics/tilehelperoff.png")

--aktualis kijelolt karakter
selectedChar = nil

--event tábla
eventTable = {}

function randomFunction(a, b, infotext)

    local c

    if a == nil and b == nil then
        c = love.math.random()
    else        
        c = love.math.random(a, b)
    end
    
    local d = love.math.getRandomState()
    if activePlayer ~= nil then
        print("[RNG]: by "..activePlayer.name.." in "..infotext.. " \n[RNDSTATE]: "..d)
    end
    return c
end

function sequenceProcessor()
   

        for index, sequence in ipairs(sequenceBufferTable) do 
            if index == 1 then 
               -- gameState:changeState(gameState.states.waitingState)

                if love.timer.getTime() - sequence.sequenceTime >= sequence.duration then
                        print("[SEQUENCE]: "..sequence.name)
                        sequence.action()
                        table.remove(sequenceBufferTable, 1)  
                      --  gameState:changeState(gameState.states.selectCharacter)
                end
            end
                
        end

end

function turnRemainingTime()
    

    isSecondsLeft = false
    if love.timer.getTime() - turnTimer >= 50 and turnTimer > 0 and turnCounter > 1 then

      
        if debugIsTurnTimer ~= false  then
       
           isSecondsLeft = true

        end
      
    end

    if isSecondsLeft then

        isSecondsLeft = false
        
    
        

    end


 
     
    if love.timer.getTime() - turnTimer >= 60 and turnTimer > 0 and turnCounter > 1 then

      
        if debugIsTurnTimer ~= false  then
       
           isTurnTimerDone = true

        end
      
    end

    if isTurnTimerDone then
        isTurnTimerDone = false
        endTurn()
        newTurn()

    end

end






function endTurn()
    
    
    gameState:changeState(gameState.states.waitingState)

    
   


    selectedChar = nil
    soundEngine:playSFX(endTurnSound)
    isFirstTurn = false
    drawAttack = false
    turnCounter = turnCounter + 1
    local maxTurns = 20
    
    eventTurnCounter = eventTurnCounter + 1
    if turnCounter == maxTurns then 
        isSuddenDeath = true 
        if turnCounter == maxTurns then isSuddenDeath = true end
        --eventTurnCounter = -40
        --chestCounter = 30
    end
    print("   ****   Turn "..turnCounter.." begins.   ****")
    oldPlayer = activePlayer
    activePlayer = inactivePlayer
    inactivePlayer = oldPlayer

  


    local burnCell

    

        ----------- EZ TÖRTÉNIK A BOARDDAL ------------------

        




    if turnCounter > 1 and isVolcanoOnBoard ~= true then
        local rngv = randomFunction(nil, nil, "endTurnVolcanoAppearsChance")
       

        if rngv < (debugVolcanoChance or 0.15) then
            local vx = randomFunction(2, 9, "volcanoX")
            local vy = randomFunction(2, 9, "volcanoY")
            if boardGrid[vx][vy].isOccupied ~= true then
                boardGrid[vx][vy] = Volcano(vx, vy)
                boardGrid[vx][vy].isOccupied = true
                isVolcanoOnBoard = true
                boardGrid[vx][vy].volcanoCounter = 3
            end
        end

    end

    if turnCounter > 8 and isShrineOnBoard ~= true then
        local rngs = randomFunction(nil, nil, "endTurnShrineAppearsChance")
   

        if rngs < 0.5 then
            local vx = randomFunction(2, 9, "shrineX")
            local vy = randomFunction(2, 9, "shrineY")
            if boardGrid[vx][vy].isOccupied ~= true then
                boardGrid[vx][vy] = Shrine(vx, vy)
                isShrineOnBoard = true
            end
        end
    end


    local magicForestChance = randomFunction(nil, nil, "magicforesttompitas")
    local forestCounter = 0
    table.insert(sequenceBufferTable, {
        name = "geognomeResetState",
        duration = 3,
        sequenceTime = love.timer.getTime(),
        action = function()

  
    for x = 1, 10 do
        for y = 1, 10 do

        
        
       
            
            if boardGrid[x][y]:instanceOf(Forest) then
                forestCounter = forestCounter + 1
                if forestCounter >= 33 and magicForestChance < 0.33 and magicForestCounter < 1 then
                    local mfX = randomFunction(3, 8, "magicforestx")
                    local mfY = randomFunction(3, 8, "magicforesty")
                    boardGrid[mfX][mfY] = MagicForest(mfX, mfY)
                    magicForestTimer = turnCounter
                    magicForestCounter = magicForestCounter + 1
                    
                end
            end






            if boardGrid[x][y].volcanoCounter ~= nil then

                boardGrid[x][y].volcanoCounter = boardGrid[x][y].volcanoCounter - 1

                if boardGrid[x][y].volcanoCounter == 1 then

                    boardGrid[x][y].isSmoking = true

                end


                if boardGrid[x][y].volcanoCounter == 0 then
                    table.insert(sequenceBufferTable, {
                        name = "ThunderShamanSpellUpAndDown",
                        duration = 3,
                        sequenceTime = love.timer.getTime(),
                        action = function()
                            boardGrid[x][y].eruptionTimer = love.timer.getTime()
                            boardGrid[x][y].isErupting = true

                            gameState:changeState(gameState.states.waitingState)

                            
                            Volcano:boom(x, y)
                            boardGrid[x][y].isSmoking = false
                        end})
                end
                

            end


            if isSuddenDeath then

                        eventTurnCounter = -40
                        for v = 1, 10 do  
                            if turnCounter == maxTurns - 1 + v then
                                table.insert(sequenceBufferTable, {
                                    name = "DruidSpellTopCell",
                                    duration = 1,
                                    sequenceTime = love.timer.getTime(),
                                    action = function()
                                        
                                        boardGrid[v][y].isOnFire = true
                                        boardGrid[x][v].isOnFire = true
                                        boardGrid[11 - v][y].isOnFire = true
                                        boardGrid[x][11- v].isOnFire = true
                                        if (10 + v) - v <= 10 then
                                        boardGrid[(10 +v) - v][y].isOnFire = true
                                        boardGrid[x][(10+v) - v].isOnFire = true
                                        end

                                    end})
                                
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

                    if randomFunction(nil, nil, "endTurn") < 0.25 then boardGrid[x][y] = Forest(x, y) end
                    if randomFunction(nil, nil, "endTurn") < 0.25 then boardGrid[x][y] = Mount(x, y) end
                    if randomFunction(nil, nil, "endTurn") < 0.25 then boardGrid[x][y] = Lake(x, y) end
                    if randomFunction(nil, nil, "endTurn") < 0.25 then boardGrid[x][y] = Field(x, y) end
                    if randomFunction(nil, nil, "endTurn") < 0.12 then boardGrid[x][y] = Desert(x, y) end
                    if randomFunction(nil, nil, "endTurn") < 0.10 then boardGrid[x][y] = Swamp(x, y) end
                    if randomFunction(nil, nil, "endTurn") < 0.08 then boardGrid[x][y] = GlassMount(x, y) end

                end
            
                    
                            
                if boardGrid[x][y].isOnFire and boardGrid[x][y]:instanceOf(Forest) then
                    boardGrid[x][y] = BurntField(x, y)
                    boardGrid[x][y].isBurntField = true
                    boardGrid[x][y].burntFieldTimer = turnCounter
                end
                    
            end

        end
                        

    end
   
    end})
        ----------- EZ TÖRTÉNIK AZ INAKTÍVPLAYERREL (MERT Ő VOLT A RÉGI JÁTÉKOS) ------------------

    for _, currentChar in ipairs(inactivePlayer.characters) do
        table.insert(sequenceBufferTable, {
            name = "inaktiv demidzs",
            duration = 3,
            sequenceTime = love.timer.getTime(),
            action = function()

                currentChar.defenseCounter = 0
                currentChar.stepPoints = 2
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
                    cell.drawDamageOnBoard = true
                    cell.drawDamageTime = love.timer.getTime()
                    cell:damageOnBoard("-2SP")
                elseif cell.isOnFire then
                
                    currentChar:damage(currentChar, 10)
                    

                elseif cell.isBurntField then
                currentChar:damage(currentChar, 7)

                elseif cell:instanceOf(Lake) then
                    currentChar.actionPoints = 0
                end


                if currentChar.isPoisoned then

                    local pd = 2
                    
                    if turnCounter - currentChar.poisoningTurn == 3 then
                        currentChar.isPoisoned = false
                    
                    end
                    if turnCounter - currentChar.poisoningTurn == 1 then
                        currentChar:damage(currentChar, 2)
                    end
                    if turnCounter - currentChar.poisoningTurn == 2 then
                        currentChar:damage(currentChar, 1)
                    end
                end   

                if currentChar.baseHP <= 0 then currentChar:kill() end
            end})
      
    end


            ----------- EZ TÖRTÉNIK AZ AKTÍVPLAYERREL MERT Ő AZ ÚJ JÁTÉKOS ------------------
            table.insert(sequenceBufferTable, {
                name = "aktiv demid",
                duration = 2,
                sequenceTime = love.timer.getTime(),
                action = function()
    

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

                        if currentChar.isPoisoned then
                            if turnCounter - currentChar.poisoningTurn == 3 then
                                currentChar.isPoisoned = false
                            end
                            if turnCounter - currentChar.poisoningTurn == 1 then
                                currentChar:damage(currentChar, 2)
                            end
                            if turnCounter - currentChar.poisoningTurn == 2 then
                                currentChar:damage(currentChar, 1)
                            
                            end
                        end           


                        if cell.isFrozen then
                            currentChar.stepPoints = 0
                        elseif cell.isOnFire then
                            currentChar:damage(currentChar, 10)
                        elseif cell.isBurntField then
                            currentChar:damage(currentChar, 7)
                        elseif cell:instanceOf(Lake) then
                            currentChar.actionPoints = 0
                        end

                        if currentChar.baseHP <= 0 then currentChar:kill() end

                    -- gameState:changeState(gameState.states.selectCharacter)

                    end
                end})

                table.insert(sequenceBufferTable, {
                    name = "resetstate",
                    duration = 3,
                    sequenceTime = love.timer.getTime(),
                    action = function()

                        gameState:changeState(gameState.states.selectCharacter)
                      
                    end})
                        


    print("RND STATE IN ENDTURN: "..love.math.getRandomState())

end

function newTurn()

    local text
    
    if activePlayer == playerOne then
        text = "PLAYER ONE - IT'S YOUR TURN"
    else
        text = "PLAYER TWO - IT'S YOUR TURN"
    end
   
    banner((turnCounter)..". TURN", text, "now it's your chance", love.timer.getTime(), 3)
    timeWaited = 0


  --  gameState:changeState(gameState.states.selectCharacter)

        if turnCounter < 20 and eventTurnCounter == nextTurnBeforeEvent + nextTurnBeforeEventModifier then
            
                soundEngine:playSFX(eventSound)
                Event:enableEvent()
                eventTurnCounter = 0
                nextTurnBeforeEventModifier = 0
   
        end

    
        if turnCounter == 20 then
            table.insert(sequenceBufferTable, {
                name = "DruidSpellTopCell",
                duration = 3,
                sequenceTime = love.timer.getTime(),
                action = function()
                   
                     banner("SUDDEN DEATH", "UNSTOPPABLE FIRE", "battle royale mode on", love.timer.getTime(), 3)
                end})
        end

        turnTimer = love.timer.getTime() + bannerDuration
    

--[[         if isGameServer then 
                
            print("[SYSTEM]: Random State Checking")
                  
                  local t = love.math.getRandomState()
                  
                  server:sendToAll("serverrandomcheck", t)
       
      
          end
      
          if isGameClient then
      
              print("[SYSTEM]: Random State Checking")
      
              local t = love.math.getRandomState()
              client:send("clientrandomcheck", t)
          end ]]
      

    Cell:resetParticleDrawing()

end

function screenShake(duration, magnitude)

    isScreenShake = true
    shakeTime, shakeDuration, shakeMagnitude = 0, duration or 1, magnitude or 5

end


function spawnPrison(player)
    if turnCounter < 20 then
       
        if player == playerTwo and playerTwo.prisonCount == 0 then
            boardGrid[3][8] = Field(3, 8)
            boardGrid[3][8].isPrison = true
            playerTwo.prisonCount = playerTwo.prisonCount + 1
        end
        if player == playerOne and playerOne.prisonCount == 0 then
            boardGrid[8][3] = Field(8, 3)
            boardGrid[8][3].isPrison = true
            playerOne.prisonCount = playerOne.prisonCount + 1
        end
    end
end

function enableEndGame()

    if turnCounter ~= 0 then 

    if #activePlayer.characters < 1 or #inactivePlayer.characters < 1 then
        drawEndGame = true
    end

    end


end

local function selectStartingPlayer()
   
   if isGameServer then
    activePlayer = playerOne
    inactivePlayer = playerTwo
    
 
   elseif isGameClient then
    activePlayer = playerOne
    inactivePlayer = playerTwo
  
   else

        startingDicePlayerOne = randomFunction(1,6, "selectStartingPlayer")
        startingDicePlayerTwo = randomFunction(1,6, "selectStartingPlayer")      

        if startingDicePlayerOne > startingDicePlayerTwo then rndPlayer = 1 end

        if rndPlayer == 1 then
            activePlayer = playerOne
            inactivePlayer = playerTwo
            banner("0. TURN", "PLAYER ONE - IT'S YOUR TURN", "the first team to shape the world", love.timer.getTime(), 7)
           
          
        else
            activePlayer = playerTwo
            inactivePlayer = playerOne
            banner("0. TURN", "PLAYER TWO - IT'S YOUR TURN", "the first team to shape the world", love.timer.getTime(), 7)
          
        end
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

   
    
 if gameState.state == gameState.states.selectSpellTargetArea or gameState.state == gameState.states.selectAttackTargetCharacter then
        for _, currentChar in ipairs(activePlayer.characters) do

            
            local  mX = math.floor((rMx / tileW) - offsetX / tileW) 
            local  mY = math.floor((rMy / tileH) - offsetY / tileH)

           
            if selectedChar and currentChar == selectedChar then

                --- Fent lent jobbra balra
                if currentChar.x < mX and currentChar.y == mY then
                    pointerOnLeftSide = false
                    pointerOnRightSide = true
                    pointerOnTopSide = false
                    pointerOnBottomSide = false
               -- print(currentChar.x, mX, currentChar.y, mY)
                end
                if currentChar.x  > mX and currentChar.y == mY then
                    pointerOnLeftSide = true
                    pointerOnRightSide = false
                    pointerOnTopSide = false
                    pointerOnBottomSide = false
        
                end
                if currentChar.y < mY and currentChar.x == mX then
                    pointerOnTopSide = false
                    pointerOnBottomSide = true
                    pointerOnLeftSide = false
                    pointerOnRightSide = false
                --  print('pointerOnBottomSide')
                end
                if currentChar.y > mY and currentChar.x == mX then
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

function getTextForSpeech()

    textNumber = randomForCosmetics:random(1, #speechBubbleTextTable)
    local tfs = speechBubbleTextTable[textNumber]
    return tfs

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

    smokeParticeImage = love.graphics.newImage("graphics/smokeparticle.png")
    smokeParticeImage:setFilter("linear", "linear")
    smokeParticleSystem = love.graphics.newParticleSystem(smokeParticeImage, 8)
    smokeParticleSystem:setDirection(-1.5707963705063)
    smokeParticleSystem:setEmissionArea("uniform", 1, 15, 3.1415927410126, false)
    smokeParticleSystem:setEmissionRate(23)
    smokeParticleSystem:setEmitterLifetime(-1)
    smokeParticleSystem:setInsertMode("top")
    smokeParticleSystem:setLinearAcceleration(0, 0, 0.1, 0.4)
    smokeParticleSystem:setLinearDamping(-0.0017912408802658, 8.0408802032471)
    smokeParticleSystem:setOffset(50, 50)
    smokeParticleSystem:setParticleLifetime(3, 5)
    smokeParticleSystem:setRadialAcceleration(0, 0)
    smokeParticleSystem:setRelativeRotation(false)
    smokeParticleSystem:setRotation(0, 0)
    smokeParticleSystem:setSizeVariation(0)
    smokeParticleSystem:setSpeed(0.0001, 0.0001)
    smokeParticleSystem:setSpin(1.5131316184998, -1.3010431528091)
    smokeParticleSystem:setSpinVariation(0)
    smokeParticleSystem:setSpread(0)
    smokeParticleSystem:setTangentialAcceleration(-0.099513381719589, 0)
    
    






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
    for step = 1, 84 do smokeParticleSystem:update(0.017179389794668)  end
    for step = 1, 96 do steamParticleSystem:update(0.0051606524114807) end
end

function drawInfoAboutCharacter(character)

    character.isDrawInfo = true
    isDrawInfoAboutCharacter = true
   
end


function animate(anim, img, x, y, duration, rotation, flx)
   

            gameState:changeState(gameState.states.waitingState)
            anim:gotoFrame(1)
            isAnimationPlaying = true
            print("[ANIMATION PLAYING]")
            animation = {}
            animation.time = love.timer.getTime()
            animation.anim = anim
            animation.img = img
            animation.x = x
            animation.y = y
            animation.duration = duration

            if rotation == nil then
            rotation = 0
            end 

            animation.rotation = rotation
            animation.flux = flx
     


    


end    

function drawAnimations()

    if isAnimationPlaying then
        
   
        if animation.flux == nil then
            animation.flux = {x = animation.x, y = animation.y, nx = animation.x, ny = animation.y, ea = "expoout"}
        end
        
        flux.to(animation.flux, animation.duration, {x = animation.flux.nx, y = animation.flux.ny}):ease(animation.flux.ea)
        animation.anim:draw(animation.img, animation.flux.x, animation.flux.y, animation.rotation)
        
        
    end

end    

local function quitGame()
    print("Quitting... Goodbye!")
    love.event.push("quit")
end

local function initNetworking(arg)

    local gameStartInstructions = arg[1]

    if gameStartInstructions == nil then 
        print("No load arguments, starting hot-seat mode")
        isGameServer = false
        isGameClient = false

    return
    end


    if gameStartInstructions == "host" then

        isGameServer = true
        isGameClient = false

        print("Argument: host, starting server mode")

        if arg[2] == nil then
            arg[2] = "*"
        end

        if arg[3] == nil then
            arg[3] = 22122
        end

        -- Creating a server on any IP, port 22122
        server = sock.newServer(arg[2], arg[3])
        server:setSerialization(bitser.dumps, bitser.loads)

        -- Called when someone connects to the server
        server:on("connect", function(data, client)
        
            local msg = "pong"

            client:send("hello", msg)
            clientIsConnected = true
            turnTimer = love.timer.getTime()
        end)

        server:on("connect", function(data, client)
          
            local rng = {}
            rng[1] = love.math.getRandomState()
            love.math.setRandomState(rng[1])
               
            print("server sending random seed")
           
            client:send("randomseed", rng)
          
            nextTurnBeforeEvent = randomFunction(5, 9, "server:on connect - next turn before event")
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

              table.insert(sequenceBufferTable, {
                  name = "moving characters to starting position",
                  duration = 1,
                  sequenceTime = love.timer.getTime(),
                  action = function()
                   createBoardGrid()
                  end})    
            
            if activePlayer == playerOne then
                banner("0. TURN", "PLAYER ONE - IT'S YOUR TURN", "the first team to shape the world", love.timer.getTime(), 7)
            else
                banner("0. TURN", "PLAYER TWO - ENEMY'S TURN", "rest now, you have some time", love.timer.getTime(), 7)
            end
            
        end)

    

        server:on("connect", function(data, client)

            for x = 1, 10 do
                for y = 1, 10 do
                    local chest = {}
                    if boardGrid[x][y].isChest then
                        chest = {x, y, true}
                        client:send("chest", chest)
                    end
                end
            end


                    

        end)




        server:on("connect", function(data, client)

           -- local ntbe = love.math.random(5, 9)

         --   client:send("nextturnbeforeevent", ntbe)

        end)

  

        server:on("clientcharacterpositionchanging", function(cp)

          

          

                for _, currentChar in ipairs(activePlayer.characters) do

                    if cp[1] == currentChar.id then
                        print("[CLIENT]: "..currentChar.name.." is moving to "..cp[2]..","..cp[3] )
                        currentChar:move(cp[2], cp[3], cp[4], cp[5])
                    end
                end
         
          
        end)

        server:on("clientendturn", function(cet)
        
            if cet == "endturnclicked" then
                print("[CLIENT]: Ending turn" )
                endTurn()
                newTurn()

            end

     
        end)

        server:on("client_characterspell", function(bs)
           
            local x = bs[1]
            local y = bs[2]
            local id = bs[3]
            local dir = bs[4]

         

            if activePlayer == playerTwo then
                for _, currentChar in ipairs(activePlayer.characters) do
                    if id == currentChar.id and id == 2 then
                        currentChar:spell(boardGrid[x][y], dir)
                        print("[CLIENT]: "..currentChar.name.." doing spell")
                    elseif id == currentChar.id then
                        print("[CLIENT]: "..currentChar.name.." doing spell")
                        currentChar:spell(boardGrid[x][y])
                    end
                end
            end
            
        end)

        server:on("client_attack", function(ac)

            local enemyid = ac[1]
            local attackerid = ac[2]

          
            for _, enemyChar in ipairs(inactivePlayer.characters) do

                if enemyid == enemyChar.id then
                    
                    
                    for _, attackerChar in ipairs(activePlayer.characters) do
                        if attackerChar.id == attackerid then
                            print("[CLIENT]: "..attackerChar.name.." attacking "..enemyChar.name)
                            attackerChar:attack(enemyChar, true)
                                               
                        end
                    end
                end
                    
            end


           

        end)


        server:on("clientrandomcheck", function(rs)

            if love.math.getRandomState() == rs then
                return
            else
                error("randomstate dont match on client"..rs.."  and server "..love.math.getRandomState())
            end


        end)

        server:on("clientmousepos", function(cm)

            clientMouseX = cm.x
            clientMouseY = cm.y


        end)

    

    end

        
    if gameStartInstructions == "join" then
               
        isGameServer = false
        isGameClient = true

        if arg[2] == nil then
            arg[2] = "localhost"
        end

        if arg[3] == nil then
            arg[3] = 22122
        end

        print("Argument: join, starting client mode")

            -- Creating a new client on localhost:22122
        client = sock.newClient(arg[2], arg[3])
     
      
        client:on("connect", function(data)
           
            print("Client connected to the server.")
            turnTimer = love.timer.getTime()
        end)
        
        -- Called when the client disconnects from the server
        client:on("disconnect", function(data)
            print("Client disconnected from the server.")
        end)

        client:on("randomseed", function(rng)
            print("client getting random seed")
           
            print(rng[1])
            love.math.setRandomState(rng[1])
        
            nextTurnBeforeEvent = randomFunction(5, 9, "client on: connect")

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

            table.insert(sequenceBufferTable, {
              name = "moving characters to starting position",
              duration = 0.03,
              sequenceTime = love.timer.getTime(),
              action = function()
               createBoardGrid()
              end})  
            
            if activePlayer == playerTwo then
                banner("0. TURN", "PLAYER TWO - IT'S YOUR TURN", "the first team to shape the world", love.timer.getTime(), 7)
            end
            if activePlayer == playerOne then
                banner("0. TURN", "PLAYER ONE - ENEMY'S TURN", "rest now, you have some time", love.timer.getTime(), 7)
            end

        end)

        -- Custom callback, called whenever you send the event from the server
        client:on("hello", function(msg)
            print("PING: " .. msg)
        end)


        client:on("chest", function(ch)                    
                    if ch[3] == true then
                        boardGrid[ch[1]][ch[2]].isChest = true
                    end
        end)

        client:on("serverendturn", function(ebc)                    
            if ebc == "endturnclicked" then
                print("[SERVER]: Ending Turn")
                endTurn()
                newTurn()
            end
        end)

    
        client:on("servercharacterpositionchanging", function(cp)

       

            
                for _, currentChar in ipairs(activePlayer.characters) do

               
                    if cp[1] == currentChar.id then
                        print("[SERVER]: moving"..currentChar.name.." to "..cp[2]..", "..cp[3])
                        currentChar:move(cp[2], cp[3], cp[4], cp[5])
                    end
                end
           


        end)

        client:on("server_characterspell", function(bs)
           
            local x = bs[1]
            local y = bs[2]
            local id = bs[3]
            local dir = bs[4]
        
           

            if activePlayer == playerOne then
                for _, currentChar in ipairs(activePlayer.characters) do
                    if id == currentChar.id and id == 2 then
                        currentChar:spell(boardGrid[x][y], dir)
                        print("[SERVER]: doing spell with "..currentChar.name)
                    elseif id == currentChar.id then
                        print("[SERVER]: doing spell with "..currentChar.name)
                        currentChar:spell(boardGrid[x][y])
                    end
                end
            end

            

        
        end)

        client:on("server_attack", function(ac)
            local enemyid = ac[1]
            local attackerid = ac[2]

          for _, enemyChar in ipairs(inactivePlayer.characters) do

                if enemyid == enemyChar.id then
                    
                    
                    for _, attackerChar in ipairs(activePlayer.characters) do
                        if attackerChar.id == attackerid then
                            attackerChar:attack(enemyChar, true)
                            print("[SERVER]: "..attackerChar.name.." attacking "..enemyChar.name)      
                        end
                    end
                end
                    
            end

          

        end)

        client:on("serverrandomcheck", function(rs)

            if love.math.getRandomState() == rs then
                return
            else
                error("randomstate dont match on server"..rs.."  and client "..love.math.getRandomState())
            end


        end)

        client:on("servermousepos", function(sm)
        
            serverMouseX = sm.x
            serverMouseY = sm.y
            
        end)
         
        client:connect()

    end

end

local function setWaitingStateForInactivePlayer()

        if isGameClient and activePlayer == playerOne and gameState.state ~= gameState.states.waitingState then
            gameState:changeState(gameState.states.waitingState)
        elseif isGameServer and activePlayer == playerTwo and gameState.state ~= gameState.states.waitingState then
            gameState:changeState(gameState.states.waitingState)
        elseif isGameServer ~= true and isGameClient ~= true then
            return
        end

end

function banner(name, text, flavor, bt, bandur)
    




    bannerDuration = bandur
    bannerTime = bt
    bannerText = {name = name, text = text, flavor = flavor}
   
  

    gameState:changeState(gameState.states.waitingState)
    turnTimer = turnTimer + bannerDuration
    
    bannerAnimation:gotoFrame(1)
    bannerAnimation:resume()
    enableBannerDraw = true  

end

function drawBanner()
    local x = (boardGrid[2][5].x * tileW + offsetX)
    local y = boardGrid[1][5].y * tileH + offsetY
    if enableBannerDraw then

        bannerAnimation:draw(bannerAnimationImage, x , y)

        if love.timer.getTime() - bannerTime >= 0.7 then

            local nameX = x + ((512 - font:getWidth(bannerText.name)) / 2) 
            local nameY = y + tileH / 8
            local textX = x + ((512 - pointFont:getWidth(bannerText.text)) / 2) 
            local textY = y + tileH - tileH / 4
            local flavX = x + ((512 - littleFont:getWidth(bannerText.flavor)) / 2)
            local flavY = y + tileH + tileH / 4

            love.graphics.setFont(font)
            love.graphics.setColor(purpleColor)
            love.graphics.print(bannerText.name, nameX, nameY)
            love.graphics.setFont(pointFont)
            love.graphics.print(bannerText.text, textX, textY)
            love.graphics.setFont(littleFont)
            love.graphics.print(bannerText.flavor, flavX, flavY)
            love.graphics.setColor(charColor)
            love.graphics.setFont(statFont)
        end

    end

end


function love.load(arg)
       --board betoltese
    if isGameClient ~= true and isGameServer ~= true then
         nextTurnBeforeEvent = randomFunction(5, 9, "Love:load - next turn before event")
    end

    initNetworking(arg)
    randomForCosmetics = love.math.newRandomGenerator(love.timer.getTime())
    if isGameFullScreen then love.window.setFullscreen(true, "desktop") --  <- fullscreen, drawban a skálálzás
    else love.window.setMode(width,height)
    end       
    --Particle systems
    loadParticleSystems()

    board:load()
    turnTimer = love.timer.getTime()

    if isGameClient ~= true and isGameServer ~= true then
        loadCharacterAnim()
    end
    
    soundEngine:load()
   
    Event:initEventTable()
    Item:initItemTable()
    selectStartingPlayer()

    --beallitasok
    love.window.setTitle("HillShift")
    love.graphics.setBackgroundColor(39 / 255,0,66 / 255)
  
    love.mouse.setVisible(false)

   
    --- networking
   -- loadNetworking(arg)
   
 


   
end

function love.update(dt)
    require("lovebird").update()
  

    updateParticleSystems(dt)
    flux.update(dt)


    mouseX, mouseY = love.mouse.getPosition()
    
    board:update(dt)
    soundEngine:update(dt)
    Character:update(dt)
    setWaitingStateForInactivePlayer()
    sequenceProcessor()
    enableEndGame()
    turnRemainingTime()
  

    if isGameServer then 
        
        server:update() 
    
      
        
    
    
    end
    
    if isGameClient then 
        
        client:update()
    
    end

    if isScreenShake then
        if shakeTime < shakeDuration then
                shakeTime = shakeTime + dt
        else
            isScreenShake = false
        end
    end
  
    bannerAnimation:update(dt)

    if love.timer.getTime() - turnTimer >= 0 and turnCounter > 1 then
        timeWaited = timeWaited + dt
        
        if timerActive and timeWaited >= 50 then
       
            timerActive = false
            soundEngine:playSFX(lastSecondsSound)

        end
    end


    if enableBannerDraw and love.timer.getTime() - bannerTime >= bannerDuration then
    
        enableBannerDraw = false
    --    turnTimer = love.timer.getTime()
        gameState:changeState(gameState.states.selectCharacter)
    end

    if isAnimationPlaying and love.timer.getTime() - animation.time >= animation.duration then
        isAnimationPlaying = false
        gameState:changeState(gameState.states.selectCharacter)
    end

  


    
end

function love.draw()
    if isScreenShake then
        if shakeTime < shakeDuration then
            local dx = randomForCosmetics:random(-shakeMagnitude, shakeMagnitude)
            local dy = randomForCosmetics:random(-shakeMagnitude, shakeMagnitude)
            love.graphics.translate(dx, dy)
        end
    end
    --scaling
    
    local screenWidth, screenHeight = love.window.getDesktopDimensions()

    local scaleX =  (screenWidth / width)
    local scaleY =  (screenHeight / height)
  
    if scaleX == 1 and scaleY == 1 then
        scaleX, scaleY = (screenWidth / width), (screenHeight / height)
    end

    if isGameFullScreen then love.graphics.scale(scaleX, scaleY) end -- fullscreen skálázás

    

    board:draw()
    
   

    soundEngine:draw()
  
    


    Character:drawParticles()
    love.graphics.setColor(charColor)
    Item:drawCurrentItem()

    if isDrawInfoAboutCharacter then
    
        local infoX = (width / 4 + offsetX)
        local infoY = (height / 4 + offsetY)
        
        

        for _, currentChar in ipairs (activePlayer.characters) do
            if currentChar.isDrawInfo then
                local ox, oy = 50, 60
                love.graphics.draw(eventBackgroundImage, infoX, infoY)
                love.graphics.setFont(statFont)
                love.graphics.setColor(purpleColor)
                love.graphics.print(currentChar.infoText, infoX + ox, infoY + oy)       
                love.graphics.setFont(font)
                love.graphics.setColor(charColor)    
            end
        end

    end



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

    if enableBannerDraw ~= true  and turnTimer > 0 and turnCounter > 1 then
       
        love.graphics.setFont(clockFont)
        love.graphics.setColor(yellowColor)
        love.graphics.print("Remaining time: "..60 + math.floor(turnTimer - love.timer.getTime()), width / 2 - tileW * 3.5, height - 76)
        love.graphics.setFont(statFont)
        love.graphics.setColor(charColor)

        if 60 + math.floor(turnTimer - love.timer.getTime()) < 10 and turnCounter > 1 then
            isSecondsLeft = true
            love.graphics.setFont(clockFont)
            love.graphics.setColor({1, 0, 0, 255})
            love.graphics.print("Remaining time: "..60 + math.floor(turnTimer - love.timer.getTime()), (width / 2 - tileW * 3.5)-2, height - 74)
            love.graphics.setFont(statFont)
            love.graphics.setColor(charColor)
        end
      
    end


   --Debug for networking

        
   if isGameServer and clientIsConnected ~= true then
            local eventX = (width / 4 + offsetX) - 2 * tileW
            local eventY = (height / 4 + offsetY)
            love.graphics.draw(eventBackgroundImage, eventX, eventY)
            love.graphics.setFont(statFont)
            love.graphics.setColor(purpleColor)
            love.graphics.print("\n\n\nWAITING FOR CLIENT TO JOIN", eventX + tileW, eventY + tileH)
            love.graphics.setFont(font)
            love.graphics.setColor(charColor)

    end


    if isGameServer then love.graphics.print("SERVER", width - 150, 10) end
    if isGameClient then love.graphics.print("CLIENT", width - 150, 10) end

    drawAnimations()


    if isGameServer then
        love.graphics.draw(mouseArrow, mouseX, mouseY)
        love.graphics.draw(mouseArrowP2, clientMouseX, clientMouseY)
    end

    if isGameClient then
        love.graphics.draw(mouseArrow, mouseX, mouseY)
        love.graphics.draw(mouseArrowP2, serverMouseX, serverMouseY)
    end

    if isGameClient ~= true and isGameServer ~= true then

        love.graphics.draw(mouseArrow, mouseX, mouseY)
    end

  
 
end

function love.mousemoved( x, y, dx, dy, istouch )


    if isGameServer then
        local sm = {x = x, y = y}
       

        server:sendToAll("servermousepos", sm)
    end

    if isGameClient then
        local cm = {x = x, y = y}

        client:send("clientmousepos", cm)
    end

    testMouseForValidSpellDrawing(x, y)

   testMouseForInventoryHover(x, y)

    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar:updateHover(x, y)        
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar:updateHover(x, y)
        currentChar:enablePossibleDamageDraw()
    end

    for _, row in ipairs(boardGrid) do
        for _, cell in ipairs(row) do
            cell:updateHover(x, y)
        end
    end

    if x > width / 16 and x < (width / 16) + tileW and y > 0 and y < tileH then
        isMusicHoverTextOn = true
    else
        isMusicHoverTextOn = false
    end


    if x > width / 16 + tileW and x < width / 16 + (tileW * 2) and y > 0 and y < tileH then
        isTileHelperHoverTextOn = true
    else
        isTileHelperHoverTextOn = false
    end
    

end

function love.mousereleased(x, y, button, istouch, presses) 
    
    local instance = clickSound:play()









    if x > width / 16 and x < (width / 16) + tileW and y > 0 and y < tileH then

        if isMusicOff then 
                mainThemeMusic:resume()
                isMusicOff = false
                isMusicOn = true
                print('Music On') 
        
        elseif  isMusicOn then 
                mainThemeMusic:pause()
                isMusicOn = false
                isMusicOff = true
                print('Music Off')

        else isMusicOff = true
        end
     return
    end

    if x > width / 16 + tileW and x < width / 16 + (tileW * 2) and y > 0 and y < tileH then

        if isTileHelperOff then
            isTileHelperOff = false
            isTileHelperOn = true
            print("Tile Helper On")

        elseif isTileHelperOn then
            isTileHelperOn = false
            isTileHelperOff = true
        else
            isTileHelperOff = true
        end
                
        return

    end

    if button == 2 then
        gameState:changeState(gameState.states.selectCharacter)
    end


    ------


    if drawEndGame and
       
    x > (boardGrid[1][1].x * tileW + offsetX) + 106 and x < (boardGrid[1][1].x * tileW + offsetX) + 223 and
    y > (boardGrid[1][1].y * tileH + offsetY) + 450 and y < (boardGrid[1][1].y * tileH + offsetY) + 492 then
        quitGame()
        return
    end

    if drawEndGame and
       
    x > (boardGrid[1][1].x * tileW + offsetX) + 435 and x < (boardGrid[1][1].x * tileW + offsetX) + 555 and
    y > (boardGrid[1][1].y * tileH + offsetY) + 450 and y < (boardGrid[1][1].y * tileH + offsetY) + 492 then
        isNewGame = true
        newGame()
        return
    end


    if not drawEndGame and gameState.state ~= gameState.states.waitingState then
     
        if isDrawInfoAboutCharacter and
        x > (width / 4 + offsetX) + 200 and x < (width / 4 + offsetX) + 352 and
        y > (height / 4 + offsetY) + 230 and y < ((height / 4 + offsetY) + 310) then

           for _, currentChar in ipairs(activePlayer.characters) do
               if currentChar.isDrawInfo then
                   currentChar.isDrawInfo = false
               end
           end
           
           return
        end
      
     --[[    if isCancelButton and selectedChar then
            local sx = selectedChar.x * tileW + offsetX
            local sy = selectedChar.y * tileW + offsetY
          
            if x > sx  and x < (sx + tileW) - tileW / 6 and
                y > sy and y < (sy + tileW) - tileW /6 then
                
                    gameState:changeState(gameState.states.selectCharacter)
                    isCancelButton = false
                    return
            end
        end ]]

      

       -- if not enableBannerDraw then
           --[[      for _, currentChar in ipairs(activePlayer.characters) do

                    if currentChar.isHovered then 
                        currentChar:click(x, y) 
                        
                    end  
                
                end

                for _, currentChar in ipairs(inactivePlayer.characters) do

                    if currentChar.isHovered then 
                        currentChar:click(x, y) 
                        
                    end  
                
                end
 ]]
                




                local mx = math.floor((mouseX / tileW) - offsetX / tileW) 
                local my = math.floor((mouseY / tileH) - offsetY / tileH)

                if (mx <= 10 and mx >= 1) and (my <= 10 and my >= 1) then
                    boardGrid[mx][my]:click()
                end

                if (x > width / 2 + 192 and x < width / 2 + 310) and (y > height - 70 and y < height - 30) then
                    isEndTurnButtonClicked = false

                    if isGameServer and activePlayer == playerOne and not enableBannerDraw then
                        server:sendToAll("serverendturn", "endturnclicked")
                        endTurn()
                        newTurn()
                    end
                    if isGameClient and activePlayer == playerTwo and not enableBannerDraw then
                        client:send("clientendturn", "endturnclicked")
                        endTurn()
                        newTurn()
                    end

                    if isGameClient ~= true and isGameServer ~= true and not enableBannerDraw then
                        endTurn()
                        newTurn()
                    end
                end

        --end

     

       
     
     
end

function love.mousepressed( x, y, button, istouch, presses )

    
    if not enableEvent and not enableEndGame and not enableBannerDraw and
       
            (x > width / 2 + 192 and x < width / 2 + 310) and (y > height - 70 and y < height - 30) then
                isEndTurnButtonClicked = true
       
    end
end

function love.keypressed(key)
    if key == "l" then
        lurker:scan()
    end

    
    if key == "escape" then
        love.event.push("quit") -- quit the game
    end

    if key == "k" then
        debug.debug()
    end
    
end



end
