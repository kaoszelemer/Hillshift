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
    "-2SP on entry, -DEFENSE if you stay there\nstinking sand mixed with boiling water",
    "Swamp")
end

function Swamp:onEntry(currentChar, ax, ay)


        currentChar.stepPoints = 0
        boardGrid[self.x][self.y].drawDamageOnBoard = true
        boardGrid[self.x][self.y] = currentChar
        boardGrid[self.x][self.y]:damageOnBoard("-2SP")




end


return Swamp