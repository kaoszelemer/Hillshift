local GeoGnome = Character:extend("GeoGnome")

function GeoGnome:init(parentPlayer)
    Character.init(self, 55, 55, 4, 9, 1, love.graphics.newImage("/graphics/geognome.png"), 
                love.graphics.newImage("/graphics/geognomeanim.png"), 
                love.graphics.newImage("/graphics/geognomehover.png"), 
                love.graphics.newImage("/graphics/geognomesink.png"), 
                love.graphics.newImage("/graphics/geognomesinkhover.png"), 
                parentPlayer, 1, 1,
                "INFO ABOUT GEOGNOME:\n\nThe GeoGnome can make other\ntiles into mountains\nMountains give +AT\nMountains cancel all modifiers\n")
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
    if spellSentNw ~= true then
        Character:spell(targetCell, self.id)
    end

    if self.actionPoints ~= 0 then
            if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
            or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
            or (targetCell.y == self.y and targetCell.x == self.x) then 
        
                

                self.tcx = targetCell.x
                self.tcy = targetCell.y

                if self.tcx < self.x and self.tcy == self.y then self.drawParticlesLeft = true end
                if self.tcx > self.x and self.tcy == self.y then self.drawParticlesRight = true end
                if self.tcx == self.x and self.tcy < self.y then self.drawParticlesTop = true end
                if self.tcx == self.x and self.tcy > self.y then self.drawParticlesBottom = true end
               


                self.drawSpellAnim = true
                self.spellTime = love.timer.getTime()

                self.actionPoints = self.actionPoints - 1
                soundEngine:playSFX(mountSound)
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
    table.insert(sequenceBufferTable, {
            name = "resetParticleDrawing",
            duration = 1.5,
            sequenceTime = love.timer.getTime(),
            action = function()

                self.drawParticlesLeft = false
                self.drawParticlesRight = false
                self.drawParticlesTop = false
                self.drawParticlesBottom = false

            end
        })


end


   
return GeoGnome