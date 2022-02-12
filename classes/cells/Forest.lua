local Forest = Cell:extend("Forest")

function Forest:init(x, y)
    Cell.init(
    self, 
    x,
    y, 
    true, 
    love.graphics.newQuad(0, 0, tileW, tileH, tilesetW, tilesetH),
    0,
    2,
 1000,
    "gives +2DEFENSE, when burned down\n it becames a burnt field\nProtects from fire.",
    "Forest" )
end


return Forest