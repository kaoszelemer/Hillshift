local GeoGnome = Character:extend("GeoGnome")
    function GeoGnome:init(x, y)
        Character.init(self, 10, 6, 0, 1, love.graphics.newImage("/graphics/geognome.png"), love.graphics.newImage("/graphics/geognomehover.png"), x, y)
    
    end


    function GeoGnome:draw()
        Character.draw(self)
    end
return GeoGnome--