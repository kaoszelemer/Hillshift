-- HillShift - project started: 2021.01.01

--require
require ('board')
require ('characters')
--valtozok
--altalanos valtozok
width = 1280
height = 720
offsetX = 15
offsetY = 15
font = love.graphics.newFont(32)
--karakterek valtozoi
charColor = {1, 1, 1}
hoverColor = {0, 0, 1}
selectedColor = {1, 0, 0}
charH = 32
charW = 32
--eger es egyeb interakciok valtozoi
mouseX, mouseY = love.mouse.getPosition()
--betutipus beállítása
love.graphics.setFont(font)

function love.load()
    --board betoltese
    board:load()
    
    --beallitasok
    love.window.setTitle("HillShift")
    love.graphics.setBackgroundColor(0,0,0)
    love.window.setMode(width,height)
    love.mouse.setVisible(true)
end

function love.update(dt)
    
    mouseX, mouseY = love.mouse.getPosition()
    board:update(dt) 

end

function love.draw()
    board:draw()
    love.graphics.setColor(charColor)
    love.graphics.print("x", mouseX, mouseY)
end

function love.mousereleased(x, y, button, istouch, presses)
    -- ez ellenorzi h felengedtem az egeret
    for i = 1, 4 do

                if      playerOne[i].isHovered then playerOne[i].isSelected = true   
                else    playerOne[i].isSelected = false
                end

                if      playerTwo[i].isHovered then playerTwo[i].isSelected = true
                else    playerTwo[i].isSelected = false
                end            

    end

    --melyik cella felett hoverelek eppen az egermutatoval -> ezt tegnap megcsinaltuk
  --amikor felengedem az egeret meg kell neznem -> kész mivel a mousepressed-be vagyok
    for index, rows in ipairs(boardGrid) do
        for _, cell in ipairs(boardGrid) do
            if cell.isHovered == true
  --van-e eppen kivalasztott karakterem
            --and playerOne[1].isSelected == true
  --ha ez a ketto true akkor meg kell neznem valid-e a mozgas (ezt lehet kesobb)
            then print('helo') end
  --ha valid a mozgas akkor mozgatom a karaktert
  --ha invalid akkor deszelektálom a karaktert
        end
    end

end
