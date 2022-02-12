local Swamp = Cell:extend("Swamp")

function Swamp:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(128, 64, tileW, tileH, tilesetW, tilesetH),
        0,
        -3,
     1000,
    "-2SP on entry, -DEFENSE",
    "Swamp")
end


return Swamp