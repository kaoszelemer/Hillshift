local Swamp = Cell:extend("Swamp")

function Swamp:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(128, 64, tileW, tileH, tilesetW, tilesetH),
        0,
        -1,
     1000)
end


return Swamp