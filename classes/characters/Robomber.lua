local Robomber = Character:extend("Robomber")
function Robomber:init(parentPlayer)
    Character.init(self, 50, 50, 3, 10, 13, love.graphics.newImage("/graphics/Robomber.png"), 
                love.graphics.newImage("/graphics/Robomberanim.png"),
                love.graphics.newImage("/graphics/Robomberhover.png"),
                love.graphics.newImage("/graphics/Robombersink.png"),
                love.graphics.newImage("/graphics/Robombersinkhover.png"),

                parentPlayer, 1, 1,
                "INFO ABOUT Robomber:\n\nThe Robomber spits poisonclouds.\nPoison give minus to defense\nand more minus to attack\nbecause your eyes are bleeding\nin the clouds.")
end

function Robomber:update(dt)
    self.animation:update(dt)
end

function Robomber:spell(targetcell)

    print("szpell elek")

end


return Robomber