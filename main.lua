-- HillShift - project started: 2021.01.01

--require
class = require('lib.30log')
Cell = require('Cell')
Forest = require('Forest')
Character = require('Character')
GeoGnome = require('GeoGnome')
Druid = require('Druid')
IceWizard = require('IceWizard')
AirElemental = require('AirElemental')
Alchemist = require('Alchemist')
FireMage = require('FireMage')

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

--aktualis kijelolt karakter
selectedChar = nil

--[[

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

        

end ]]

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

function love.mousemoved( x, y, dx, dy, istouch )

    for _, currentChar in ipairs(playerOne.characters) do
        currentChar:updateHover(x, y)
    end

end

function love.mousereleased(x, y, button, istouch, presses) 

    for _, currentChar in ipairs(playerOne.characters) do
        
        if currentChar.isHovered then currentChar:click(x, y) end
        
    
    end

    cellMousePositionX = math.floor((mouseX / tileW) - offsetX / tileW) 
    cellMousePositionY = math.floor((mouseY / tileH) - offsetY / tileH)
    local mx = math.min(math.max(cellMousePositionX, 1), 10)
    local my = math.min(math.max(cellMousePositionY, 1), 10)
    
    boardGrid[mx][my]:click()

end
