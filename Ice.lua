local Ice = Cell:extend("Ice")

function Ice:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(64, 64, tileW, tileH, tilesetW, tilesetH),
        0,
        0)
end


return Ice