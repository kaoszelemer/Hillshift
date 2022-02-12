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
        "-1SP on entry, -AT if you stay there",
        "Desert"
    )
end


function Desert:onEntry(currentChar, ax, ay)

   
                currentChar.stepPoints = currentChar.stepPoints - 1
                boardGrid[self.x][self.y].drawDamageOnBoard = true
                boardGrid[self.x][self.y]:damageOnBoard("1SP")

end

return Desert