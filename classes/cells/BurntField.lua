local BurntField = Cell:extend("BurntField")

function BurntField:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(320, 0, tileW, tileH, tilesetW, tilesetH),
        0,
        0,
        1000,
        "Damages 7 at turn end, after 2 turns it becames a field"    
    )
end


return BurntField