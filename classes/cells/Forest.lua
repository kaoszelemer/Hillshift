local Forest = Cell:extend("Forest")

function Forest:init(x, y)
    Cell.init(
    self, 
    x,
    y, 
    true, 
    love.graphics.newQuad(0, 0, tileW, tileH, tilesetW, tilesetH),
    0,
    3,
 1000)
end


return Forest