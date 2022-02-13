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
        "Damages 7 at turn end, 3 on entry\nafter 2 turns it becames a field\nSoft ash floating in the wind",
        "Burnt Field"    
    )

    function BurntField:onEntry(char, ax, ay)


        char:damage(char, 3)

    end
end


return BurntField