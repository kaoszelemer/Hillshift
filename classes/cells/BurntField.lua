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
        "Damages 7 at turn end, 3 on entry\nafter 2 turns it becames a field",
        "Burnt Field"    
    )

    function BurntField:onEntry(char, ax, ay)


        char.baseHP = char.baseHP - 3
        boardGrid[self.x][self.y].drawDamageOnBoard = true
        boardGrid[self.x][self.y]:damageOnBoard("3HP")
        if char.baseHP <= 0 then
            char:kill()
        end

    end
end


return BurntField