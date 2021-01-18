local IceWizard = Character:extend("IceWizard")
    function IceWizard:init(x, y, parentPlayer)
        Character.init(self, 8, 5, 0, 3, love.graphics.newImage("/graphics/icewizard.png"), 
                    love.graphics.newImage("/graphics/icewizardhover.png"), x, y, parentPlayer)
    end


    function IceWizard:draw()
        Character.draw(self)
    end
return IceWizard