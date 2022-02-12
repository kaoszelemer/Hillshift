local MagicForest = Cell:extend("MagicForest")

function MagicForest:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(64, 0, tileW, tileH, tilesetW, tilesetH),
        0,
        0,
     1000,
    "i dont remember right now",
    "Magic Forest")
end


return MagicForest