local DragonDiviner = Character:extend("DragonDiviner")
function DragonDiviner:init(parentPlayer)
    Character.init(self, 35, 35, 2, 10, 12, love.graphics.newImage("/graphics/DragonDiviner.png"), 
                love.graphics.newImage("/graphics/DragonDivineranim.png"), 
                love.graphics.newImage("/graphics/DragonDivinerhover.png"), 
                love.graphics.newImage("/graphics/DragonDivinersink.png"),
                love.graphics.newImage("/graphics/DragonDivinersinkhover.png"),
                parentPlayer, 1, 1, 
                "INFO ABOUT DragonDiviner:\n\nThe DragonDiviner can fly over lakes,\nspits fire ahead and behind\n2 tiles away. Has low HP and defense\n")

                self.isWalkable = {
                    Forest = true,
                    Mount = true,
                    Field = true,
                    Ice = true,
                    BurntField = true,
                    MagicForest = true,
                    Desert = true,
                    Swamp = true,
                    GlassMount = true,
                    Graveyard = true,
                    Shrine = true,
                    Prison = true,
                    Volcano = true,
                    Lake = true
                }
end

function DragonDiviner:update(dt)
    self.animation:update(dt)
end

function DragonDiviner:spell(targetcell)
   
    gameState:changeState(gameState.states.waitingState)

    if self.actionPoints ~= 0 then

        soundEngine:playSFX(fireBallSound)

        for oy = -2, 2 do     
            if oy ~= 0 then
                if self.y + oy > 0 and self.y + oy <= 10 then
                    Burn:apply(self.x, self.y + oy)
                end
            end
        end
        self.actionPoints = self.actionPoints - 1
    end

    
    table.insert(sequenceBufferTable, {
        name = "ArchmagerResetState",
        duration = 2,
        sequenceTime = love.timer.getTime(),
        action = function()
                if self.actionPoints > 0  or self.stepPoints > 0 then
                        selectedChar = self
                        gameState:changeState(gameState.states.selectCharacterAction)
                    else
                 
                        selectedChar = self
                        gameState:changeState(gameState.states.selectCharacter)
                    end
              
    
        end})


end


return DragonDiviner