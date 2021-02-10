local Desert = Cell:extend("Desert")

function Desert:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(384, 0, tileW, tileH, tilesetW, tilesetH),
        -1,
        0)
end


return Desert