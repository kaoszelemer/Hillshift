local Ice = Cell:extend("Ice")

function Ice:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(64, 64, tileW, tileH, tilesetW, tilesetH),
        0,
        0,
     1000,
    "Infinite skating while on ice\nbut when you're done\nyour AP set to 0",
    "Ice")
end


function Ice:onEntry(sChar)
 
    
    table.insert(sequenceBufferTable, {
        name = "iceSlide",
        duration = 0.5,
        sequenceTime = love.timer.getTime(),
        action = function()

            if sChar then
                
                sChar.actionPoints = 0

                if sChar.stepPoints == 2 then
                    sChar.stepPoints = 2
                elseif sChar.stepPoints <= 1 then
                    sChar.stepPoints = 1
                end

                selectedChar = sChar
                gameState:changeState(gameState.states.selectCharacterAction)
            end
        end})

 
    
  

end

return Ice