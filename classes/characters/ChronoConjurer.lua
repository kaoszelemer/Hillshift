local ChronoConjurer = Character:extend("ChronoConjurer")


function ChronoConjurer:init(parentPlayer)
    Character.init(self, 45, 45, 3, 10, 10, love.graphics.newImage("/graphics/chronoconjurer.png"), 
                love.graphics.newImage("/graphics/chronoconjureranim.png"),
                love.graphics.newImage("/graphics/alchemisthover.png"),
                love.graphics.newImage("/graphics/alchemistsink.png"),
                love.graphics.newImage("/graphics/alchemistsinkhover.png"),

                parentPlayer, 2, 1,
                "INFO ABOUT CHRONOCONJUREUR:")
end


function ChronoConjurer:spell(targetCell)

    if targetCell.x + 1 == self.x + 1 or targetCell.x - 1 == self.x - 1 or targetCell.y == self.y + 1 or targetCell.y == self.y - 1 then

        print("kubli")
        for x = -1, 1 do
            for y = -1, 1 do
                if x ~= 0 and y ~= 0 then
                    boardGrid[self.x +x][self.y +y].isTimewarped = true
                    boardGrid[self.x +x][self.y +y].timerParent = self.parentPlayer
                end
            end
        end

    end



end



return ChronoConjurer