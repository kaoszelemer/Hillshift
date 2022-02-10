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
     1000)
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

            if rngX > 0.4 then rngX = 1
            elseif rngX < 0.7 then rngX = 0
            else rngX = -1
            end 
            
            if rngY > 0.4 then rngY = 1
            elseif rngY < 0.7 then 
                if rngX == 0 then
                    rngY = 1
                else
                    rngY = 0
                end
            else rngY = -1
            end

            
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