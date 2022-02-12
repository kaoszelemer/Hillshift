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
    "you slide down on entry at the\nexact opposite side of the glassmountain\n+2AT, +2DF if you can stop on it.",
    "Glass Mountain"    
)
end



function GlassMount:onEntry(character, ax, ay)

    
   
    table.insert(sequenceBufferTable, {
        name = "GlassMountSlide",
        duration = 0.3,
        sequenceTime = love.timer.getTime(),
        action = function()
            if ax > character.x and ay == character.y then
                if character.x - 1 > 0 then
                    if not boardGrid[character.x - 1][character.y].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x - 1, character.y, character.x, character.y)
                    end
                end
            end
        
        
            
            if ax < character.x and ay == character.y then
                if character.x + 1 <= 10 then
                    if not boardGrid[character.x + 1][character.y].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x + 1, character.y, character.x, character.y)
                    end
                end
            end

            if ax == character.x and ay > character.y then
                if character.y - 1 > 0 then
                    if not boardGrid[character.x][character.y - 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x, character.y - 1, character.x, character.y)
                    end
                 end
            end

            if ax == character.x and ay < character.y then
                if character.y + 1 <= 10 then
                    if not boardGrid[character.x][character.y + 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x, character.y + 1, character.x, character.y)
                    end
                end
            end
            
            if ax > character.x and ay < character.y then
                if character.x - 1 > 0 and character.y - 1 > 0 then
                    if not boardGrid[character.x - 1][character.y - 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x - 1, character.y + 1, character.x, character.y)
                    end
                end
            end

            if ax > character.x and ay > character.y then
                if character.x - 1 > 0 and character.y - 1 <= 10 then
                    if not boardGrid[character.x - 1][character.y - 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x - 1, character.y - 1, character.x, character.y)
                    end
                end
            end

            if ax < character.x and ay > character.y then
                if character.x + 1 <= 10 and character.y - 1 > 0 then
                    if not boardGrid[character.x + 1][character.y - 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x + 1, character.y - 1, character.x, character.y)
                    end
                 end
            end

            if ax < character.x and ay < character.y then
                if character.x + 1 <= 10 and character.y + 1 <= 10 then 
                    if not boardGrid[character.x + 1][character.y + 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x + 1, character.y + 1, character.x, character.y)
                    end
                end
            end
        end
    })

       
     
     

    

    


end

return GlassMount