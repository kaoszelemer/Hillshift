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
        5,
    "+2AT when you're on a mountain.\nMountains can be destroyed sometimes\nand then they become Deserts.",
    "Mountain")
end

function Mount:spawnParticlesWhenInstanced()

    

end

return Mount