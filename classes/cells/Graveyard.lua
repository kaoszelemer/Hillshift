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





function Graveyard:onEntry(sChar, ax, ay)

   gameState:changeState(gameState.states.waitingState)

    table.insert(sequenceBufferTable, {
        name = "graveyardentry",
        duration = 0.3,
        sequenceTime = love.timer.getTime(),
        action = function()

            boardGrid[self.x][self.y].drawGhost = true
            boardGrid[self.x][self.y].ghostTimer = love.timer.getTime()
            
            soundEngine:playSFX(ghostSound)

            local ghostRunTable = {}

            for x = -1, 1 do
                for y = -1, 1 do
                    if x ~= 0 or y ~= 0 then
                        if self.x + x > 0 and self.x + x <= 10 and self.y + y > 0 and self.y + y <= 10 then

                            local runAwayCell = boardGrid[self.x + x][self.y + y]
                            if runAwayCell.isOccupied ~= true then

                                table.insert(ghostRunTable, runAwayCell)

                            end
                        end
                    end
                end
            end

            local runAwayCellIndex = randomFunction(1, #ghostRunTable, "graveyard", self.x, sChar.stepPoints + 1, activePlayer.characters[1].id, sChar.id)
        

            table.insert(sequenceBufferTable, {
                name = "graveyardentry",
                duration = 0.1,
                sequenceTime = love.timer.getTime(),
                action = function()
                    
                
                    sChar:freeMove(ghostRunTable[runAwayCellIndex].x, ghostRunTable[runAwayCellIndex].y, self.x, self.y)

                end})
        end})
        
    

end




return Graveyard