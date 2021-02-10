local GlassMount = Cell:extend("GlassMount")

function GlassMount:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(320, 64, tileW, tileH, tilesetW, tilesetH),
        1,
        1,
     1000)
end

function GlassMount:onEntry(character, ax, ay)


            if ax > character.x and ay == character.y then
                if character.x - 1 > 0 then
                    if not boardGrid[character.x - 1][character.y].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x - 1, character.y)
                    end
                end
            end
            
            if ax < character.x and ay == character.y then
                if character.x + 1 <= 10 then
                    if not boardGrid[character.x + 1][character.y].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x + 1, character.y)
                    end
                end
            end

            if ax == character.x and ay > character.y then
                if character.y - 1 > 0 then
                    if not boardGrid[character.x][character.y - 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x, character.y - 1)
                    end
                 end
            end

            if ax == character.x and ay < character.y then
                if character.y + 1 <= 10 then
                    if not boardGrid[character.x][character.y + 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x, character.y + 1)
                    end
                end
            end
            
            if ax > character.x and ay < character.y then
                if character.x - 1 > 0 and character.y - 1 > 0 then
                    if not boardGrid[character.x - 1][character.y - 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x - 1, character.y + 1)
                    end
                end
            end

            if ax > character.x and ay > character.y then
                if character.x - 1 > 0 and character.y - 1 <= 10 then
                    if not boardGrid[character.x - 1][character.y - 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x - 1, character.y - 1)
                    end
                end
            end

            if ax < character.x and ay > character.y then
                if character.x + 1 <= 10 and character.y - 1 > 0 then
                    if not boardGrid[character.x + 1][character.y - 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x + 1, character.y - 1)
                    end
                 end
            end

            if ax < character.x and ay < character.y then
                if character.x + 1 <= 10 and character.y + 1 <= 10 then 
                    if not boardGrid[character.x + 1][character.y + 1].isOccupied then
                        character.stepPoints = character.stepPoints + 1
                        character:move(character.x + 1, character.y + 1)
                    end
                end
            end

       
     
     

    

    


end

return GlassMount