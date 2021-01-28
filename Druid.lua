local Druid = Character:extend("Druid")
    function Druid:init(parentPlayer)
        Character.init(self, 6, 4, 3, 5, love.graphics.newImage("/graphics/druid.png"), 
                    love.graphics.newImage("/graphics/druidhover.png"), parentPlayer)
    end




    
return Druid