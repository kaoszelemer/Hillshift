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
end

function GeoGnome:spell(targetCell)

    if self.actionPoints ~= 0 then
            if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
            or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
            or (targetCell.y == self.y and targetCell.x == self.x) then   
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