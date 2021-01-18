local Alchemist = Character:extend("Alchemist")
    function Alchemist:init(x, y, parentPlayer)
        Character.init(self, 6, 4, 3, 2, love.graphics.newImage("/graphics/druid.png"), 
                    love.graphics.newImage("/graphics/druidhover.png"), x, y, parentPlayer)
    end


    function Alchemist:draw()
        Character.draw(self)
    end
return Alchemist