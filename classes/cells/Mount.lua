local Mount = Cell:extend("Mount")

function Mount:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(256, 64, tileW, tileH, tilesetW, tilesetH),
        1,
        0,
        5)
end

return Mount