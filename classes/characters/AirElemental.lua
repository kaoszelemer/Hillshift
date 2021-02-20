local AirElemental = Character:extend("AirElemental")
function AirElemental:init(parentPlayer)
    Character.init(self, 12, 3, 2, 4, love.graphics.newImage("/graphics/airelemental.png"), 
                love.graphics.newImage("/graphics/airelementalanim.png"), 
                love.graphics.newImage("/graphics/airelementalhover.png"), 
                love.graphics.newImage("/graphics/airelementalsink.png"),
                love.graphics.newImage("/graphics/airelementalsinkhover.png"),
                parentPlayer, 1, 1, 0, 0, 0, false)
end


function AirElemental:update(dt)
    self.animation:update(dt)
end


function AirElemental:blowCharacter(targetCell, tcx, tcy, ox, oy)
    table.insert(sequenceBufferTable, {
        name = "AirElementalblowCharacter",
        duration = 0.3,
        sequenceTime = love.timer.getTime(),
        action = function()

            local spreadX = 0
            local spreadY = 0
                                            
            if boardGrid[self.x + tcx][self.y + tcy].isOccupied then

                if self.x == boardGrid[self.x + tcx][self.y + tcy].occupiedBy.x then
                    spreadX = 0
                end

                if self.x > boardGrid[self.x + tcx][self.y + tcy].occupiedBy.x then
                    spreadX = -2
                end

                if self.x < boardGrid[self.x + tcx][self.y + tcy].occupiedBy.x then
                    spreadX = 2
                end

                if self.y > boardGrid[self.x + tcx][self.y + tcy].occupiedBy.y then
                    spreadY = -2
                end

                if self.y < boardGrid[self.x + tcx][self.y + tcy].occupiedBy.y then
                    spreadY = 2
                end

                if (self.x + spreadX <= 10 and self.x + spreadX > 0) and (self.y + spreadY <= 10 and self.y + spreadY > 0) then
            
                    if not boardGrid[self.x +spreadX][self.y + spreadY].isOccupied then
                        boardGrid[self.x + tcx][self.y + tcy].occupiedBy.stepPoints = boardGrid[self.x + tcx][self.y + tcy].occupiedBy.stepPoints + 1
                        boardGrid[self.x + tcx][self.y + tcy].occupiedBy:move(self.x + spreadX, self.y + spreadY, self.x, self.y)
                    end
                end
            
            end
     end
    })

end

function AirElemental:clearPoison(targetCell, tcx, tcy)
    table.insert(sequenceBufferTable, {
        name = "AirElementalclearPoison",
        duration = 0.1,
        sequenceTime = love.timer.getTime(),
        action = function()
            if (self.x + tcx <= 10 or self.x + tcx > 0) and (self.y + tcy <= 10 or self.y + tcy > 0) then
                if boardGrid[self.x + tcx][self.y + tcy].isPoisoned then boardGrid[self.x + tcx][self.y + tcy].isPoisoned = false end
            end
        end
    })

end

function AirElemental:blowFire(targetCell, tcx, tcy)
    table.insert(sequenceBufferTable, {
        name = "AirElementalblowFire",
        duration = 0.2,
        sequenceTime = love.timer.getTime(),
        action = function()

            local chanceOfBurning = love.math.random()
            local fx = 0
            local fy = 0
            
            if chanceOfBurning > 0.2 then 

                if self.x == boardGrid[self.x + tcx][self.y + tcy].x then
                    fx = 0
                end

                if self.x > boardGrid[self.x + tcx][self.y + tcy].x then
                    fx = -1
                end

                if self.x < boardGrid[self.x + tcx][self.y + tcy].x then
                    fx = 1
                end

                if self.y > boardGrid[self.x + tcx][self.y + tcy].y then
                    fy = -1
                end

                if self.y < boardGrid[self.x + tcx][self.y + tcy].y then
                    fy = 1
                end
            end

            if (self.x + fx + tcx <= 10 and self.x + fx + tcx > 0) and (self.y + fy + tcy <= 10 and self.y + fy + tcy > 0) then


                if boardGrid[self.x + tcx][self.y + tcy].isOnFire then 
                    
                    if not boardGrid[self.x + fx + tcx][self.y + fy + tcy]:instanceOf(Lake) then
                        boardGrid[self.x + fx + tcx][self.y + fy + tcy].isOnFire = true
                        boardGrid[self.x + fx + tcx][self.y + fy + tcy].fireTurn = turnCounter
                    end
                
                    if boardGrid[self.x + fx + tcx][self.y + fy + tcy]:instanceOf(Desert) then
                        boardGrid[self.x + fx + tcx][self.y + fy + tcy] = GlassMount(self.x + fx + tcx, self.y + fy + tcy) 
                    end

                    if boardGrid[self.x + fx + tcx][self.y + fy + tcy]:instanceOf(Lake) then
                        boardGrid[self.x + fx + tcx][self.y + fy + tcy] = Field(self.x + fx + tcx, self.y + fy + tcy) 
                    end
                    if boardGrid[self.x + fx + tcx][self.y + fy + tcy]:instanceOf(Ice) then
                        boardGrid[self.x + fx + tcx][self.y + fy + tcy] = Lake(self.x + fx + tcx, self.y + fy + tcy) 
                    end
                end

            end
        end
    })

end

function AirElemental:blowSand(targetCell, tcx, tcy)
    table.insert(sequenceBufferTable, {
        name = "AirElementalblowSand",
        duration = 0.2,
        sequenceTime = love.timer.getTime(),
        action = function()
            local spreadX = 0
            local spreadY = 0

            if self.x == boardGrid[self.x + tcx][self.y + tcy].x then
                spreadX = 0
            end

            if self.x > boardGrid[self.x + tcx][self.y + tcy].x then
                spreadX = -1
            end

            if self.x < boardGrid[self.x + tcx][self.y + tcy].x then
                spreadX = 1
            end

            if self.y > boardGrid[self.x + tcx][self.y + tcy].y then
                spreadY = -1
            end

            if self.y < boardGrid[self.x + tcx][self.y + tcy].y then
                spreadY = 1
            end

            if (self.x + spreadY + tcx <= 10 and self.x + spreadX + tcx > 0) and (self.y + spreadY + tcy <= 10 and self.y + spreadY + tcy > 0) then

                if boardGrid[self.x + tcx][self.y + tcy]:instanceOf(Desert) then 

                    if boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy]:instanceOf(Lake) then
                        boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy] = Swamp(self.x + spreadX + tcx, self.y + spreadY + tcy) 
                    end

                    if not boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy].isOnFire and not boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy]:instanceOf(Swamp) then 
                        boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy] = Desert(self.x + spreadX + tcx, self.y + spreadY + tcy)
                    end

                    if boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy].isOnFire then
                        boardGrid[self.x + spreadX + tcx][self.y + spreadY + tcy] = GlassMount(self.x + spreadX + tcx, self.y + spreadY + tcy) 
                    end

                end
            end
        end
    })

end

function AirElemental:spell(targetCell, tcx, tcy)
    local spreadX = 0
    local spreadY = 0
    if self.actionPoints ~= 0 then

        for tcx = -1, 1 do
            for tcy = -1, 1 do
                if tcy ~= 0 then
                    if (targetCell.x == self.x and targetCell.y == self.y + tcy) or (targetCell.x == self.x + tcx and targetCell.y == self.y + tcy) then
                        if (self.x + tcx <= 10 or self.x + tcx > 0) and (self.y + tcy <= 10 or self.y + tcy > 0) then

                            self:blowCharacter(targetCell, tcx, tcy)
                            self:blowFire(targetCell, tcx, tcy)
                            self:blowSand(targetCell, tcx, tcy)
                            self:clearPoison(targetCell, tcx, tcy)
                           
                        end
                    end
                end
            end
        end
        gameState:changeState(gameState.states.selectCharacter)
    end
   

end
    
return AirElemental