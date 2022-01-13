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



function Alchemist:poisonBoardGrid(targetCell)

                       print(targetCell)
      
                        if pointerOnTopLeftSide then 
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

                        elseif pointerOnTopRightSide then
                                self.drawSpellTR = true
                                self.spellTime = love.timer.getTime()
                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonTopRightCellOne",
                                        duration = 0.2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x + 1 <= 10 and self.y - 1 > 0 then 
                                                        boardGrid[self.x + 1][self.y - 1].isPoisoned = true
                                                        boardGrid[self.x + 1][self.y - 1].defenseModifier = boardGrid[self.x + 1][self.y - 1].defenseModifier - 3
                                                        boardGrid[self.x + 1][self.y - 1].attackModifier = boardGrid[self.x + 1][self.y - 1].attackModifier - 3
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
                                                        boardGrid[self.x + 2][self.y - 2].defenseModifier = boardGrid[self.x + 2][self.y - 2].defenseModifier - 3
                                                        boardGrid[self.x + 2][self.y - 2].attackModifier = boardGrid[self.x + 2][self.y - 2].attackModifier - 3
                                                        boardGrid[self.x + 2][self.y - 2].poisoningTurn = turnCounter 
                                                end
                                        end
                                })
                        elseif pointerOnBottomLeftSide then
                                self.drawSpellBL = true
                                self.spellTime = love.timer.getTime()
                                table.insert(sequenceBufferTable, {
                                        name = "AlchimistPoisonBottomLeftCellOne",
                                        duration = 0.2,
                                        sequenceTime = love.timer.getTime(),
                                        action = function()
                                                if self.x - 1 > 0 and self.y + 1 <= 10 then 
                                                        boardGrid[self.x - 1][self.y + 1].isPoisoned = true 
                                                        boardGrid[self.x - 1][self.y + 1].defenseModifier = boardGrid[self.x - 1][self.y + 1].defenseModifier - 3
                                                        boardGrid[self.x - 1][self.y + 1].attackModifier = boardGrid[self.x - 1][self.y + 1].attackModifier - 3
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
                                                        boardGrid[self.x - 2][self.y + 2].defenseModifier = boardGrid[self.x - 2][self.y + 2].defenseModifier - 3
                                                        boardGrid[self.x - 2][self.y + 2].attackModifier = boardGrid[self.x - 2][self.y + 2].attackModifier - 3
                                                        boardGrid[self.x - 2][self.y + 2].poisoningTurn = turnCounter
                                                end
                                        end
                                })

                        elseif pointerOnBottomRightSide then
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

function Alchemist:nwSpell(targetCell)
        if self.actionPoints ~= 0 then
                self:poisonBoardGrid(targetCell)
          --      self.actionPoints = self.actionPoints - 1
          --      gameState:changeState(gameState.states.selectCharacter)
        end

end

function Alchemist:spell(targetCell)
        
       
        if spellSentNw ~= true then              
                Character:spell(targetCell, self.id)
        end
        
        if self.actionPoints ~= 0 then
                self:poisonBoardGrid(targetCell)
                self.actionPoints = self.actionPoints - 1
                gameState:changeState(gameState.states.selectCharacter)
        end


end

return Alchemist