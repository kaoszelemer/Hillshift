local Alchemist = Character:extend("Alchemist")
function Alchemist:init(parentPlayer)
    Character.init(self, 12, 3, 3, 2, love.graphics.newImage("/graphics/alchemistanim.png"), 
                love.graphics.newImage("/graphics/alchemisthover.png"),
                love.graphics.newImage("/graphics/alchemistsink.png"),
                love.graphics.newImage("/graphics/alchemistsinkhover.png"),

                parentPlayer, 1, 1, 0, 0, 0, false)
end

function Alchemist:update(dt)
        self.animation:update(dt)
end

function Alchemist:poisonBoardGrid(targetCell)
      
                        if pointerOnTopLeftSide then 

                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonTopLeftCellOne",
                                        duration = 0.2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()

                                                if self.x - 1 > 0 and self.y - 1 > 0 then 
                                                        boardGrid[self.x - 1][self.y - 1].isPoisoned = true 
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
                                                end
                                        end
                                })

                        elseif pointerOnTopRightSide then
                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonTopRightCellOne",
                                        duration = 0.2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x + 1 <= 10 and self.y - 1 > 0 then 
                                                        boardGrid[self.x + 1][self.y - 1].isPoisoned = true 
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
                                                end
                                        end
                                })
                        elseif pointerOnBottomLeftSide then
                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonBottomLeftCellOne",
                                        duration = 0.2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x - 1 > 0 and self.y + 1 <= 10 then 
                                                        boardGrid[self.x - 1][self.y + 1].isPoisoned = true 
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
                                                end
                                        end
                                })

                        elseif pointerOnBottomRightSide then
                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonBottomRightCellOne",
                                        duration = 0.2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x + 1 <= 10 and self.y + 1 <= 10 then 
                                                        boardGrid[self.x + 1][self.y + 1].isPoisoned = true 
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
                                                end
                                        end
                                })
                        end
         

end

function Alchemist:spell(targetCell)
        if self.actionPoints ~= 0 then
                self:poisonBoardGrid(targetCell)
                self.actionPoints = self.actionPoints - 1
                gameState:changeState(gameState.states.selectCharacter)
        end

end

return Alchemist