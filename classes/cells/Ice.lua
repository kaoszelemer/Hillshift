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


function Ice:onEntry(selectedChar)
   
    table.insert(sequenceBufferTable, {
        name = "iceSlide",
        duration = 0.2,
        sequenceTime = love.timer.getTime(),
        action = function()
            selectedChar.stepPoints = selectedChar.stepPoints + 1
            selectedChar.actionPoints = 0
        end
    })

    --selectedChar.stepPoints = 0
    


end

return Ice