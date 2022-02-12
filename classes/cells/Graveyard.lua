local Graveyard = Cell:extend("Graveyard")

function Graveyard:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(448, 0, tileW, tileH, tilesetW, tilesetH),
        0,
        0,
     1000,
    "Only ghosts live there\nYou run away in fear on entry to \na random neighbouring tile",
    "Graveyard"
)
end





function Graveyard:onEntry(selectedChar, ax, ay)

    

    table.insert(sequenceBufferTable, {
        name = "graveyardentry",
        duration = 1,
        sequenceTime = love.timer.getTime(),
        action = function()

            boardGrid[self.x][self.y].drawGhost = true
            boardGrid[self.x][self.y].ghostTimer = love.timer.getTime()
            
            soundEngine:playSFX(ghostSound)

            local rngX = randomFunction(nil, nil, "graveyard:onEntry")
            local rngY = randomFunction(nil, nil, "graveyard:onEntry")

            if rngX < 0.33 then rngX = 1
            elseif rngX > 0.33 and rngX < 0.66 then rngX = 0
            elseif rngX > 0.66 then
                rngX = -1
            end
            
            if rngY < 0.33 then rngY = 1
            elseif rngY > 0.33 and rngY < 0.66 then 
                if rngX == 0 then
                    local xchance = randomFunction(nil, nil, "chance for x")
                    if xchance < 0.5 then
                        rngY = -1
                    else
                        rngY = 1
                    end
                else
                    rngY = 0
                end
            elseif rngY > 0.66 then
                rngY = -1 
            end

            print(rngX, rngY)
            
            if boardGrid[selectedChar.x + rngX][selectedChar.y + rngY].isOccupied then
                selectedChar.stepPoints = selectedChar.stepPoints + 1
                selectedChar:move(ax, ay, selectedChar.x, selectedChar.y)
            else
                selectedChar.stepPoints = selectedChar.stepPoints + 1
                selectedChar:move(selectedChar.x + rngX, selectedChar.y + rngY, selectedChar.x, selectedChar.y)
            end
                
            

        end})
        
    

end




return Graveyard