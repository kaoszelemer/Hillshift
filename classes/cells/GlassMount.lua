local GlassMount = Cell:extend("GlassMount")

function GlassMount:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(320, 64, tileW, tileH, tilesetW, tilesetH),
        2,
        2,
     1000,
    "you slide on entry at the exact\nopposite side of the glassmountain\n+2AT, +2DF if you can stop.",
    "Glass Mountain"    
)
end



function GlassMount:onEntry(character, ax, ay)


     
    

    local targetx = self.x + (self.x - ax)
    local targety = self.y + (self.y - ay)

    if ((targetx < 0 or targetx > 10) or (targety < 0  or targety > 10)) then
        return
    end

    if boardGrid[targetx][targety].isOccupied then
        return
    end

 
   
    table.insert(sequenceBufferTable, {
        name = "GlassMountSlide",
        duration = 0.3,
        sequenceTime = love.timer.getTime(),
        action = function()
          
                        
                        character:freeMove(targetx, targety, character.x, character.y)
    
        end})

       
     
     

    

    


end

return GlassMount