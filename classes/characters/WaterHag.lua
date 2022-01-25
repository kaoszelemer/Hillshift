local WaterHag = Character:extend("WaterHag")

function WaterHag:init(parentPlayer)
    Character.init(self, 50, 50, 4, 11, 9, love.graphics.newImage("/graphics/waterwitch.png"), 
                love.graphics.newImage("/graphics/waterwitchanim.png"), 
                love.graphics.newImage("/graphics/waterwitchhover.png"), 
                love.graphics.newImage("/graphics/waterwitchsink.png"), 
                love.graphics.newImage("/graphics/waterwitchsinkhover.png"), 
                parentPlayer, 1, 1,
                "INFO ABOUT WATERHAG:\n\nThe Waterhag creates lakes.\nPeople in lakes can't be attacked\nand more suspectible to thunder, \nthey also only can move to land")
end
function WaterHag:update(dt)
    self.animation:update(dt)
    waterHagSpellAnimation:update(dt)
end

function WaterHag:drawSpellAnimation()

    local duration = 0.5


    if self.drawSpellAnim then
        if love.timer.getTime() - self.spellTime <= duration then
            if self.y - 1 > 0 then 
                waterHagSpellAnimation:draw(waterHagSpellAnimationImage, ((self.tcx) * tileW + offsetX) + tileW / 4, ((self.tcy)* tileH + offsetY) + tileH / 4)
            end
        end
    end

end


function WaterHag:spell(targetCell)
  
    if self.actionPoints ~= 0 then
            if (targetCell.x == self.x and (targetCell.y == self.y - 1 or targetCell.y == self.y + 1)) 
            or (targetCell.y == self.y and (targetCell.x == self.x - 1 or targetCell.x == self.x + 1))
            or (targetCell.y == self.y and targetCell.x == self.x) then

                self.tcx = targetCell.x
                self.tcy = targetCell.y
                self.drawSpellAnim = true
                self.spellTime = love.timer.getTime()


                table.insert(sequenceBufferTable, {
                    name = "WaterHagSpell",
                    duration = 0.2,
                    sequenceTime = love.timer.getTime(),
                    action = function()
                        self.actionPoints = self.actionPoints - 1
                

                        if not boardGrid[targetCell.x][targetCell.y]:instanceOf(Desert) then
                                boardGrid[targetCell.x][targetCell.y] = Lake(targetCell.x, targetCell.y)
                                boardGrid[targetCell.x][targetCell.y].isInstanced = true
                        elseif boardGrid[targetCell.x][targetCell.y]:instanceOf(Desert) then
                            boardGrid[targetCell.x][targetCell.y] = Swamp(targetCell.x, targetCell.y)
                        end
                        
                        
                       if boardGrid[targetCell.x][targetCell.y]:instanceOf(Lake) then

                            --random spread


                            local randomWaterSpreadX = randomFunction(0,1,"waterghag spell - waterspread x")
                            local randomWaterSpreadY = randomFunction(0,1,"waterhgag spell - waterspread y")
                            if targetCell.x + randomWaterSpreadX <= 10 and targetCell.x - randomWaterSpreadX > 0 and
                                targetCell.y + randomWaterSpreadY <= 10 and targetCell.y - randomWaterSpreadY > 0 then             
                    


                                if targetCell.x + randomWaterSpreadX <= 10 and targetCell.x - randomWaterSpreadX > 0 and
                                    targetCell.y + randomWaterSpreadY <= 10 and targetCell.y - randomWaterSpreadY > 0 then                 

                          
                                    if randomFunction(nil, nil, "waterhag spell into lake") < 0.25 then 
                                    
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY] = Lake(targetCell.x + randomWaterSpreadX, targetCell.y + randomWaterSpreadY) 
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY].isInstanced = true
                                    end
                                    if randomFunction(nil, nil, "waterhag spell into lake") < 0.25 then 
                                    
                                        boardGrid[targetCell.x - randomWaterSpreadX][targetCell.y + randomWaterSpreadY] = Lake(targetCell.x - randomWaterSpreadX, targetCell.y + randomWaterSpreadY) 
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY].isInstanced = true
                                    end
                                    if randomFunction(nil, nil, "waterhag spell into lake") < 0.25 then 
                                    
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y - randomWaterSpreadY] = Lake(targetCell.x + randomWaterSpreadX, targetCell.y - randomWaterSpreadY) 
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY].isInstanced = true
                                    end
                                    if randomFunction(nil, nil, "waterhag spell into lake") < 0.25 then 
                                    
                                        boardGrid[targetCell.x - randomWaterSpreadX][targetCell.y - randomWaterSpreadY] = Lake(targetCell.x - randomWaterSpreadX, targetCell.y - randomWaterSpreadY) 
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY].isInstanced = true
                                    end
                                    if randomFunction(nil, nil, "waterhag spell into lake") < 0.33 then 
                                    
                                        boardGrid[targetCell.x][targetCell.y - randomWaterSpreadY] = Lake(targetCell.x, targetCell.y - randomWaterSpreadY) 
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY].isInstanced = true
                                    end
                                    if randomFunction(nil, nil, "waterhag spell into lake") < 0.33 then 
                                    
                                        boardGrid[targetCell.x][targetCell.y + randomWaterSpreadY] = Lake(targetCell.x, targetCell.y + randomWaterSpreadY) 
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY].isInstanced = true
                                    end
                                    if randomFunction(nil, nil, "waterhag spell into lake") < 0.33 then 
                                    
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y] = Lake(targetCell.x + randomWaterSpreadX, targetCell.y) 
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY].isInstanced = true
                                    end
                                    if randomFunction(nil, nil, "waterhag spell into lake") < 0.33 then 
                                    
                                        boardGrid[targetCell.x - randomWaterSpreadX][targetCell.y] = Lake(targetCell.x - randomWaterSpreadX, targetCell.y) 
                                        boardGrid[targetCell.x + randomWaterSpreadX][targetCell.y + randomWaterSpreadY].isInstanced = true
                                    end
                                end
                            end
                        end
                    end
                })
                
                
            end
        
    end
    gameState:changeState(gameState.states.selectCharacter)
    print("RND STATE AFTER SPELL Whag: "..love.math.getRandomState())
    Cell:resetParticleDrawing()


end


   
return WaterHag