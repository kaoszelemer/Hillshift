local Volcano = Cell:extend("Volcano")

function Volcano:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(384, 64, tileW, tileH, tilesetW, tilesetH),
        0,
        0,
        1000,
        "its gonna erupt in a few turns\nsetting everything around it on Fire\nA wonderful spectacle",
        "Volcano")
end




function Volcano:boom(bx, by)

   


            local d = 0.3

      
            
        soundEngine:playSFX(eruptionSound)
        boardGrid[bx][by].isErupting = true
        boardGrid[bx][by].eruptionTimer = love.timer.getTime()

            for x = -1, 1 do
                for y = -1, 1 do
                    if x ~= 0 or y ~= 0 then
                        table.insert(sequenceBufferTable, {
                            name = "vulkar_boomstart",
                            duration = 0,
                            sequenceTime = love.timer.getTime(),
                            action = function()

        

                                       Burn:apply(bx + x, by + y)
                                       


                            end})

                        
                            
                    
                    end
                end
            end

            gameState:changeState(gameState.states.selectCharacter)

         
         
     
end


return Volcano