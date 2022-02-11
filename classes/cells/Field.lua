local Field = Cell:extend("Field")

function Field:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(256, 0, tileW, tileH, tilesetW, tilesetH),
        0,
        0,
     1000,
        "Gives no modifiers. It's quiet.")
end


return Field