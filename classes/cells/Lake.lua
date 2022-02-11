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
    "you cant attack someone in a lake\nand you only can move to land")
end

return Lake