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
    "gives +2DEFENSE, when burned down becames\n a burnt field. Protects from fire.\nGiant millennia-old trees",
    "Forest" )
end


return Forest