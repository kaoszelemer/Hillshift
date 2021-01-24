local AirElemental = Character:extend("AirElemental")
    function AirElemental:init(parentPlayer)
        Character.init(self, 7, 4, 2, 4, love.graphics.newImage("/graphics/airelemental.png"), 
                    love.graphics.newImage("/graphics/airelementalhover.png"), parentPlayer)
    end


    
return AirElemental