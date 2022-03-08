local ArchMager = Character:extend("ArchMager")
function ArchMager:init(parentPlayer)
    Character.init(self, 35, 35, 2, 10, 11, love.graphics.newImage("/graphics/ArchMager.png"), 
                love.graphics.newImage("/graphics/ArchMageranim.png"), 
                love.graphics.newImage("/graphics/ArchMagerhover.png"), 
                love.graphics.newImage("/graphics/ArchMagersink.png"),
                love.graphics.newImage("/graphics/ArchMagersinkhover.png"),
                parentPlayer, 1, 1, 
                "INFO ABOUT ArchMager:\n\nThe ArchMager can shoot 3 tiles away\nfor critical damage.\nHas low HP and defense")
end


function ArchMager:update(dt)
    self.animation:update(dt)
    archMagerSpellAnimation:update(dt)
end



function ArchMager:spell(targetcell)
    
    gameState:changeState(gameState.states.waitingState)
         
          if self.actionPoints > 0 then
                soundEngine:playSFX(arrowSound)
                local flx = {x = (self.x * tileW + offsetX), y = (self.y * tileH + offsetY), nx = ((targetcell.x) * tileW + offsetX), ny = (targetcell.y * tileH + offsetY), ea = "expoout"}
                animate(archMagerSpellAnimation, archMagerSpellAnimationImage, flx.x, flx.y, 1, nil, flx )
                table.insert(sequenceBufferTable, {
                    name = "archmager damage",
                    duration = 1,
                    sequenceTime = love.timer.getTime(),
                    action = function()
                        if boardGrid[targetcell.x][targetcell.y].isOccupied then
                            boardGrid[targetcell.x][targetcell.y].occupiedBy:damage(boardGrid[targetcell.x][targetcell.y].occupiedBy, 20)
                        end
                    end})
              
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

return ArchMager