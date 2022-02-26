local Shrine = Cell:extend("Shrine")

function Shrine:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(192, 0, tileW, tileH, tilesetW, tilesetH),
        -2,
        0,
        1000,
    "+5HP on entry, not much, but can save lives\nbeautiful singing voice emanates\nfrom there",
    "Shrine")
end

function Shrine:onEntry(selectedChar, ax, ay)

    soundEngine:playSFX(shrineSound)

    selectedChar.baseHP = selectedChar.baseHP + 5
    boardGrid[self.x][self.y] = Field(self.x, self.y)
    boardGrid[self.x][self.y].occupiedBy = selectedChar
    boardGrid[self.x][self.y].drawDamageOnBoard = true
    boardGrid[self.x][self.y]:damageOnBoard("+5HP")

end


return Shrine