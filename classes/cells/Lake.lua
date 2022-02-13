local Lake = Cell:extend("Lake")

function Lake:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        false, 
        love.graphics.newQuad(0, 64, tileW, tileH, tilesetW, tilesetH),
        0,
        0,
     1000,
    "You cant attack someone in a lake\nand you only can move to land\nIt takes away your SP and AP on entry.",
    "Lake"

)
end

function Lake:onEntry(char, ax, ay)

    char.actionPoints = 0
    char.stepPoints = 0

    boardGrid[self.x][self.y].drawDamageOnBoard = true
    boardGrid[self.x][self.y]:damageOnBoard("-1AP, -2SP")


end

return Lake