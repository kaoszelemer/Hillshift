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


function MagicForest:onEntry(selectedChar, ax, ay)

    selectedChar.actionPoints = selectedChar.actionPoints + 1
    boardGrid[self.x][self.y] = Field(self.x, self.y)
    boardGrid[self.x][self.y].drawDamageOnBoard = true
    boardGrid[self.x][self.y]:damageOnBoard("+1AP")

end


return MagicForest