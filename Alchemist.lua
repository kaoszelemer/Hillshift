local Alchemist = Character:extend("Alchemist")
    function Alchemist:init(parentPlayer)
        Character.init(self, 6, 4, 3, 2, love.graphics.newImage("/graphics/alchemist.png"), 
                    love.graphics.newImage("/graphics/alchemisthover.png"), x, y, parentPlayer)
    end


 
return Alchemist