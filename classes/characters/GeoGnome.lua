local GeoGnome = Character:extend("GeoGnome")

function GeoGnome:init(parentPlayer)
    Character.init(self, 14, 3, 1, 1, love.graphics.newImage("/graphics/geognome.png"), 
                love.graphics.newImage("/graphics/geognomeanim.png"), 
                love.graphics.newImage("/graphics/geognomehover.png"), 
                love.graphics.newImage("/graphics/geognomesink.png"), 
                love.graphics.newImage("/graphics/geognomesinkhover.png"), 
                parentPlayer, 1, 1, 0, 0, 0, false)
end

function GeoGnome:update(dt)
    self.animation:update(dt)
    geoGnomeSpellAnimation:update(dt)
end

function GeoGnome:drawSpellAnimation()

    local duration = 0.5


    if self.drawSpellAnim then
        if love.timer.getTime() - self.spellTime <= duration then
            if self.y - 1 > 0 then 
                geoGnomeSpellAnimation:draw(geoGnomeSpellAnimationImage, ((self.tcx) * tileW + offsetX) + tileW / 4, ((self.tcy) * tileH + offsetY) + tileH / 4)
            end
        end
    end

    

end

function GeoGnome:spell(targetCell)

    if self.actionPoints ~= 0 then
            if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
            or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
            or (targetCell.y == self.y and targetCell.x == self.x) then 
                
                self.tcx = targetCell.x
                self.tcy = targetCell.y
                self.drawSpellAnim = true
                self.spellTime = love.timer.getTime()

                self.actionPoints = self.actionPoints - 1
                table.insert(sequenceBufferTable, {
                    name = "GeoGnomeSpell",
                    duration = 0.2,
                    sequenceTime = love.timer.getTime(),
                    action = function()

                        boardGrid[targetCell.x][targetCell.y] = Mount(targetCell.x, targetCell.y)
                    end
                })
                    gameState:changeState(gameState.states.selectCharacter)
            end
        
    end


end


   
return GeoGnome