local Effector = class("Effector")

function Effector:init(x, y, name)
    self.x = x
    self.y = y
    self.name = name
    
end

function Effector:drawEffector()
    for x = 1, 10 do
        for y = 1, 10 do
           
                local cell = boardGrid[x][y] 
                local i = x * tileW + offsetX
                local j = y * tileH + offsetY

                if cell.isOnFire and 3 + cell.fireTurn - turnCounter > 0 then 
                    --love.graphics.draw(fireGridBorder, cell.x * tileW + offsetX, cell.y * tileH + offsetY) end
                    fireBorderAnimation:draw(fireBorderAnimationImage, i, j)
                    love.graphics.draw(fireRemTurnIcon, i, j)

                    love.graphics.setFont(pointFont)
                    love.graphics.setColor(yellowColor)
                    love.graphics.print(3 + cell.fireTurn - turnCounter, i + 8 , j + tileH - 24)
                    love.graphics.setColor(charColor)
                    love.graphics.setFont(statFont)

                end
                
                if cell.isPoisoned and 2 + cell.poisoningTurn - turnCounter > 0 then
                    poisonBorderAnimation:draw(poisonBorderAnimationImage, i, j) 
                    love.graphics.draw(poisonRemTurnIcon, i, j)

                    love.graphics.setFont(pointFont)
                    love.graphics.setColor(yellowColor)
                    love.graphics.print(2 + cell.poisoningTurn - turnCounter, i + tileW - 18 , j + tileH - 24)
                    love.graphics.setColor(charColor)
                    love.graphics.setFont(statFont)
                end

                if cell.isFrozen and 2 + cell.freezeTurn - turnCounter > 0 then 
                    frozenBorderAnimation:draw(frozenBorderAnimationImage, i, j)
                    love.graphics.draw(freezeRemTurnIcon, i, j)

                    love.graphics.setFont(pointFont)
                    love.graphics.setColor(yellowColor)
                    love.graphics.print(2 + cell.freezeTurn - turnCounter, i + 8 , j + tileH - 24)
                    love.graphics.setColor(charColor)
                    love.graphics.setFont(statFont)
                end
           
        end
    end
end


function Effector:apply(x, y)
    

end

return Effector