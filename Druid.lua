local Druid = Character:extend("Druid")
    function Druid:init(parentPlayer)
        Character.init(self, 6, 4, 3, 2, love.graphics.newImage("/graphics/druid.png"), 
                    love.graphics.newImage("/graphics/druidhover.png"), x, y, parentPlayer)
    end



return Druid