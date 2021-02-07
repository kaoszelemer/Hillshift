-- HillShift - project started: 2021.01.01

--require
class = require('lib.30log')
Cell = require('classes.cells.Cell')
Forest = require('classes.cells.Forest')
Lake = require('classes.cells.Lake')
Mount = require('classes.cells.Mount')
Field = require('classes.cells.Field')
BurntField = require('classes.cells.BurntField')
Ice = require('classes.cells.Ice')
Character = require('classes.characters.Character')
GeoGnome = require('classes.characters.GeoGnome')
Druid = require('classes.characters.Druid')
IceWizard = require('classes.characters.IceWizard')
AirElemental = require('classes.characters.AirElemental')
Alchemist = require('classes.characters.Alchemist')
FireMage = require('classes.characters.FireMage')
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

statFont = love.graphics.newFont(12)
actionMenuFont = love.graphics.newFont(24)
-- counters
turnCounter = 0

nextTurnBeforeEvent = love.math.random(8, 11)
eventTurnCounter = 0

defenseCounter = 0
fireTurn = 0
poisoningTurn = 0
freezeTurn = 0
burntFieldTimer = 0

--karakterek valtozoi
charColor = {1, 1, 1}
cellOccupiedColor = {1, 192 / 255, 203 / 255}
hoverColor = {0, 0, 1}
selectedColor = {1, 0, 0}
greenColor = {0, 1, 0}
charH = 32
charW = 32
--eger es egyeb interakciok valtozoi
mouseX, mouseY = love.mouse.getPosition()
--kiszámolom az egér és tile relációt X és Y tengelyen

--betutipus beállítása
font = love.graphics.newFont(32)
love.graphics.setFont(font)
statFont = love.graphics.newFont(12)
pointFont = love.graphics.newFont(16)
littleFont = love.graphics.newFont(8)

--kepek betoltese
mouseArrow = love.graphics.newImage("/graphics/mousearrow.png")

--aktualis kijelolt karakter
selectedChar = nil

--event tábla

eventTable = {}

function endTurn()
    turnCounter = turnCounter + 1
    eventTurnCounter = eventTurnCounter + 1
    oldPlayer = activePlayer
    activePlayer = inactivePlayer
    inactivePlayer = oldPlayer
    local burnCell

        ----------- EZ TÖRTÉNIK A BOARDDAL ------------------
    for index, row in ipairs(boardGrid) do
        for _, cell in ipairs(row) do

            if cell.isPoisoned and turnCounter - poisoningTurn == 3 then
                cell.isPoisoned = false
                cell.attackModifier = cell.attackModifier + 1
                cell.defenseModifier = cell.defenseModifier + 3
            end

            if cell.isOnFire and turnCounter - fireTurn == 3 then
               cell.isOnFire = false
            end

            if cell.isBurntField and turnCounter - burntFieldTimer == 3 then
                cell.isBurntField = false
                boardGrid[cell.x][cell.y] = Field(cell.x, cell.y)
            end

            if cell.isFrozen and turnCounter - freezeTurn == 3 then
                cell.isFrozen = false
            end

            if cell.isFrozen and turnCounter - freezeTurn == 3 then
                cell.isFrozen = false
            end
        
            if cell.isOnFire and cell:instanceOf(Forest) then
                    boardGrid[cell.x][cell.y] = BurntField(cell.x, cell.y)
                    boardGrid[cell.x][cell.y].isBurntField = true
                    burntFieldTimer = turnCounter
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
        if currentChar.defenseState then
            currentChar.defenseCounter = currentChar.defenseCounter + 1
        end
        
        local cell = boardGrid[currentChar.x][currentChar.y]

        if not cell.isPoisoned then
            currentChar.turnDefenseModifier = 0
            currentChar.turnAttackModifier = 0
        end
        if currentChar.defenseState then
            currentChar.turnDefenseModifier = 2
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

        board:resetAllCharacterStates(activePlayer, inactivePlayer)

    end
end

function newTurn()

        if eventTurnCounter == nextTurnBeforeEvent then
            Event:enableEvent()
            eventTurnCounter = 0
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

function love.load()
    --board betoltese
    board:load()
    Event:initEventTable()
    selectStartingPlayer()
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

function love.mousemoved( x, y, dx, dy, istouch )

   
    for _, currentChar in ipairs(activePlayer.characters) do
        currentChar:updateHover(x, y)
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar:updateHover(x, y)
        currentChar:enablePossibleDamageDraw()
    end

   

end

function love.mousereleased(x, y, button, istouch, presses) 

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

        if (x > width / 2 + 200 and x < width / 2 + 264) and (y > 10 and y < 74) then
        --  isEndTurnButtonClicked = true
            endTurn()
            newTurn()
        end

    end

    if enableEvent and
        x > (width / 4 + offsetX) + 250 and x < (width / 4 + offsetX) + 302 and
        y > (height / 4 + offsetY) + 260 and y < ((height / 4 + offsetY) + 310) then
            Event:confirmEventWithClick()
            
    end

    

end
