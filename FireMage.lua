local FireMage = Character:extend("FireMage")
    function FireMage:init(parentPlayer)
        Character.init(self, 12, 4, 1, 6, love.graphics.newImage("/graphics/firemage.png"), 
                    love.graphics.newImage("/graphics/firemagehover.png"), x, y, parentPlayer)
    end


   
return FireMage