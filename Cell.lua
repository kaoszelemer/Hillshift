local Cell = class("Cell")

function Cell:init(x, y, isWalkable, quad)
    self.x = x
    self.y = y
    self.isWalkable = isWalkable
    self.quad = quad
end


return Cell