local Desert = Cell:extend("Desert")

function Desert:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(384, 0, tileW, tileH, tilesetW, tilesetH),
        -2,
        0,
        1000,
        "-1SP on entry, -AT if you stay there")
end


return Desert