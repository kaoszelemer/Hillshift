local Mount = Cell:extend("Mount")

function Mount:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(256, 64, tileW, tileH, tilesetW, tilesetH),
        2,
        0,
        5)
end

function Mount:spawnParticlesWhenInstanced()

    

end

return Mount