local AirElemental = Character:extend("AirElemental")
    function AirElemental:init(x, y, parentPlayer)
        Character.init(self, 7, 4, 2, 4, love.graphics.newImage("/graphics/airelemental.png"), 
                    love.graphics.newImage("/graphics/airelementalhover.png"), x, y, parentPlayer)
    end


    function AirElemental:draw()
        Character.draw(self)
    end
return AirElemental