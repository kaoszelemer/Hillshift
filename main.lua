-- HillShift - project started: 2021.01.01

--require
class = require('lib.30log')
Cell = require('classes.cells.Cell')
Forest = require('classes.cells.Forest')
Lake = require('classes.cells.Lake')
Mount = require('classes.cells.Mount')
Field = require('classes.cells.Field')
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
stepCounter = 0

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
pointFont = love.graphics.newFont(16)
littleFont = love.graphics.newFont(8)

--kepek betoltese
mouseArrow = love.graphics.newImage("/graphics/mousearrow.png")

--aktualis kijelolt karakter
selectedChar = nil

local function endTurn()
    turnCounter = turnCounter + 1
    oldPlayer = activePlayer
    activePlayer = inactivePlayer
    inactivePlayer = oldPlayer
    local burnCell

        ----------- EZ TÖRTÉNIK A BOARDDAL ------------------
    for index, row in ipairs(boardGrid) do
        for _, cell in ipairs(row) do

            if cell.isPoisoned and turnCounter - poisoningTurn == 3 then
                cell.isPoisoned = false
                cell.defenseModifier = cell.defenseModifier + 3
                cell.attackModifier = cell.attackModifier + 1
            end

            if cell.isOnFire and turnCounter - fireTurn == 3 then
               cell.isOnFire = false
            end

            if cell.isFrozen and turnCounter - freezeTurn == 3 then
                cell.isFrozen = false
            end
        
            if cell.isOnFire and cell:instanceOf(Forest) then
                if boardGrid[cell.x][cell.y].isOnFire then burnCell = true end
                boardGrid[cell.x][cell.y] = Field(cell.x, cell.y)
                if burnCell then boardGrid[cell.x][cell.y].isOnFire = true end
            end

        end
    end
  
        ----------- EZ TÖRTÉNIK AZ INAKTÍVPLAYERREL (MERT Ő VOLT A RÉGI JÁTÉKOS) ------------------

    for _, currentChar in ipairs(inactivePlayer.characters) do
        currentChar.stepPoints = 1
        currentChar.actionPoints = 1
        local cell = boardGrid[currentChar.x][currentChar.y]

        if cell.isFrozen then
            currentChar.stepPoints = 0
        elseif cell.isOnFire then
            currentChar.baseHP = currentChar.baseHP - 2
        elseif cell.isPoisoned then
            cell.defenseModifier = cell.defenseModifier - 3
            cell.attackModifier = cell.attackModifier - 1
        elseif cell:instanceOf(Lake) then
            currentChar.actionPoints = 0
        end
        if currentChar.baseHP <= 0 then currentChar:kill() end
      
    end


            ----------- EZ TÖRTÉNIK AZ AKTÍVPLAYERREL MERT Ő AZ ÚJ JÁTÉKOS ------------------


    for _, currentChar in ipairs(activePlayer.characters) do
        local cell = boardGrid[currentChar.x][currentChar.y]
        if cell.isFrozen then
            currentChar.stepPoints = 0
        elseif cell.isOnFire then
            currentChar.baseHP = currentChar.baseHP - 2
        elseif cell.isPoisoned then
            cell.defenseModifier = cell.defenseModifier - 3
            cell.attackModifier  = cell.attackModifier - 1
        elseif cell:instanceOf(Lake) then
            currentChar.actionPoints = 0
        end

        if currentChar.baseHP <= 0 then currentChar:kill() end

        board:resetAllCharacterStates(activePlayer, inactivePlayer)

    end
end

function love.load()
    --board betoltese
    board:load()
    activePlayer = playerOne
    inactivePlayer = playerTwo
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
    end

   

end

function love.mousereleased(x, y, button, istouch, presses) 

    for _, currentChar in ipairs(activePlayer.characters) do
        
        if currentChar.isHovered then currentChar:click(x, y) end  
    
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        
        if currentChar.isHovered then currentChar:click(x, y) end  
    
    end

    local mx = math.floor((mouseX / tileW) - offsetX / tileW) 
    local my = math.floor((mouseY / tileH) - offsetY / tileH)
    -- itt meghivom mindenkepp a cella klikkejt akkor is ha nem oda kattintok, ezt majd ki kell javitani

    if (mx <= 10 and mx >= 1) and (my <= 10 and my >= 1) then
        boardGrid[mx][my]:click()
    end

    if (x > width / 2 + 200 and x < width / 2 + 264) and (y > 10 and y < 74) then
      --  isEndTurnButtonClicked = true
        endTurn()

    end
    

end
