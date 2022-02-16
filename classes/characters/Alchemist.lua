local Alchemist = Character:extend("Alchemist")
function Alchemist:init(parentPlayer)
    Character.init(self, 50, 50, 3, 10, 2, love.graphics.newImage("/graphics/alchemist.png"), 
                love.graphics.newImage("/graphics/alchemistanim.png"),
                love.graphics.newImage("/graphics/alchemisthover.png"),
                love.graphics.newImage("/graphics/alchemistsink.png"),
                love.graphics.newImage("/graphics/alchemistsinkhover.png"),

                parentPlayer, 1, 1,
                "INFO ABOUT ALCHEMIST:\n\nThe Alchemist spits poisonclouds.\nPoison give minus to defense\nand more minus to attack\nbecause your eyes are bleeding\nin the clouds.")
end

function Alchemist:update(dt)
        self.animation:update(dt)
        alchemistSpellAnimation:update(dt)
end

function Alchemist:drawSpellAnimation()

    local duration = 0.5


    if self.drawSpellTL then
        if love.timer.getTime() - self.spellTime <= duration then
            if self.x - 1 > 0 and self.y - 1 > 0 then 
                alchemistSpellAnimation:draw(alchemistSpellAnimationImage, ((self.x - 1) * tileW + offsetX) + tileW / 4, ((self.y - 1 )* tileH + offsetY) + tileH / 4)
            end
            if self.x - 2 > 0 and self.y - 2 > 0 then 
                 alchemistSpellAnimation:draw(alchemistSpellAnimationImage, ((self.x - 2) * tileW + offsetX) + tileW / 4, ((self.y - 2 )* tileH + offsetY) + tileH / 4)
            end
        end
    end

    if self.drawSpellTR then
        if love.timer.getTime() - self.spellTime <= duration then
                if self.x + 1 <= 10 and self.y - 1 > 0 then 
                        alchemistSpellAnimation:draw(alchemistSpellAnimationImage, ((self.x + 1) * tileW + offsetX) + tileW / 4, ((self.y - 1 )* tileH + offsetY) + tileH / 4)
                end
                if self.x + 2 <= 10 and self.y - 2 > 0 then 
                        alchemistSpellAnimation:draw(alchemistSpellAnimationImage, ((self.x + 2) * tileW + offsetX) + tileW / 4, ((self.y - 2 )* tileH + offsetY) + tileH / 4)
                end
        end
    end



    if self.drawSpellBL then
        if love.timer.getTime() - self.spellTime <= duration then
                if self.x - 1 > 0 and self.y + 1 <= 10 then 
                        alchemistSpellAnimation:draw(alchemistSpellAnimationImage, ((self.x - 1) * tileW + offsetX) + tileW / 4, ((self.y + 1 )* tileH + offsetY) + tileH / 4)
                end
                if self.x - 2 > 0 and self.y + 2 <= 10 then 
                        alchemistSpellAnimation:draw(alchemistSpellAnimationImage, ((self.x - 2) * tileW + offsetX) + tileW / 4, ((self.y + 2 )* tileH + offsetY) + tileH / 4)
                end
        end
    end

    if self.drawSpellBR then
        if love.timer.getTime() - self.spellTime <= duration then
                if self.x + 1 <= 10 and self.y + 1 <= 10 then 
                        alchemistSpellAnimation:draw(alchemistSpellAnimationImage, ((self.x + 1) * tileW + offsetX) + tileW / 4, ((self.y + 1 )* tileH + offsetY) + tileH / 4)
                end
                if self.x + 2 <= 10 and self.y + 2 <= 10 then 
                        alchemistSpellAnimation:draw(alchemistSpellAnimationImage, ((self.x + 2) * tileW + offsetX) + tileW / 4, ((self.y + 2 )* tileH + offsetY) + tileH / 4)
                end
        end  
    end

    

end



function Alchemist:poisonBoardGrid(targetCell, direction)

      

           
                        if pointerOnTopLeftSide or direction == "tl" then 
                                self.drawSpellTL = true
                                self.spellTime = love.timer.getTime()
                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonTopLeftCellOne",
                                        duration = 0.2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()

                                                if self.x - 1 > 0 and self.y - 1 > 0 then
                                                        boardGrid[self.x - 1][self.y - 1].isPoisoned = true 
                                                        boardGrid[self.x - 1][self.y - 1].poisoningTurn = turnCounter
                                                        
                                                end

                                        end
                                })

                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonTopLeftCellTwo",
                                        duration = 0.4,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x - 2 > 0 and self.y - 2 > 0 then
                                                        boardGrid[self.x - 2][self.y - 2].isPoisoned = true
                                                        boardGrid[self.x - 2][self.y - 2].poisoningTurn = turnCounter
                                                end
                                                
                                        end
                                })

                     

                        elseif pointerOnTopRightSide  or direction == "tr" then
                                self.drawSpellTR = true
                                self.spellTime = love.timer.getTime()
                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonTopRightCellOne",
                                        duration = 0.2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x + 1 <= 10 and self.y - 1 > 0 then 
                                                        boardGrid[self.x + 1][self.y - 1].isPoisoned = true
                                                        boardGrid[self.x + 1][self.y - 1].poisoningTurn = turnCounter
                                                end

                                        end
                                })

                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonTopRightCellTwo",
                                        duration = 0.4,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x + 2 <= 10 and self.y - 2 > 0 then 
                                                        boardGrid[self.x + 2][self.y - 2].isPoisoned = true
                                                        boardGrid[self.x + 2][self.y - 2].poisoningTurn = turnCounter 
                                                end
                                        end
                                })
                        elseif pointerOnBottomLeftSide  or direction == "bl" then
                                self.drawSpellBL = true
                                self.spellTime = love.timer.getTime()
                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonBottomLeftCellOne",
                                        duration = 0.2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x - 1 > 0 and self.y + 1 <= 10 then 
                                                        boardGrid[self.x - 1][self.y + 1].isPoisoned = true 
                                                        boardGrid[self.x - 1][self.y + 1].poisoningTurn = turnCounter
                                                end
                                        end
                                })

                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonBottomLeftCellTwo",
                                        duration = 0.4,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x - 2 > 0 and self.y + 2 <= 10 then 
                                                        boardGrid[self.x - 2][self.y + 2].isPoisoned = true 
                                                        boardGrid[self.x - 2][self.y + 2].poisoningTurn = turnCounter
                                                end
                                        end
                                })

                        elseif pointerOnBottomRightSide  or direction == "br" then
                                self.drawSpellBR = true
                                self.spellTime = love.timer.getTime()
                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonBottomRightCellOne",
                                        duration = 0.2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x + 1 <= 10 and self.y + 1 <= 10 then 
                                                        boardGrid[self.x + 1][self.y + 1].isPoisoned = true
                                                        boardGrid[self.x + 1][self.y + 1].poisoningTurn = turnCounter 
                                                end
                                        end
                                })

                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonBottomRightCellTwo",
                                        duration = 0.4,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()     
                                                if self.x + 2 <= 10 and self.y + 2 <= 10 then 
                                                        boardGrid[self.x + 2][self.y + 2].isPoisoned = true 
                                                        boardGrid[self.x + 2][self.y + 2].poisoningTurn = turnCounter
                                                 
                                                end
                                        end
                                })
                        end
             
                        table.insert(sequenceBufferTable, {
                                name = "poisoningCharacters",
                                duration = 0.1,
                                sequenceTime = love.timer.getTime(),
                                action = function()

                                        for x = 1, 10 do
                                                for y = 1, 10 do

                                                        if boardGrid[x][y].isPoisoned and boardGrid[x][y].occupiedBy ~= nil and boardGrid[x][y].occupiedBy.isPoisoned ~= true then
                                                                boardGrid[x][y].occupiedBy.isPoisoned = true
                                                                boardGrid[x][y].occupiedBy.poisoningTurn = turnCounter
                                                                boardGrid[x][y].occupiedBy:damage(boardGrid[x][y].occupiedBy, 3)

                                                        end
                                                end
                                        end
                                end})
                                                







                        


                        table.insert(sequenceBufferTable, {
                                name = "resetSpellDrawing",
                                duration = 1,
                                sequenceTime = love.timer.getTime(),
                                action = function()
                
                                    self.drawSpellTL = false
                                    self.drawSpellTR = false
                                    
                                    self.drawSpellBR = false
                                    self.drawSpellBL = false
                                end
                            })
         

end


function Alchemist:spell(targetCell, direction)

        gameState:changeState(gameState.states.waitingState)

        if self.actionPoints ~= 0 then
                self:poisonBoardGrid(targetCell, direction)
                self.actionPoints = self.actionPoints - 1
             
                soundEngine:playSFX(poisonSound)
        end

        table.insert(sequenceBufferTable, {
                name = "AlchemistResetState",
                duration = 2,
                sequenceTime = love.timer.getTime(),
                action = function()
                        selectedChar = self
                                
                        gameState:changeState(gameState.states.selectCharacter)
               
            
                end})


end

return Alchemist