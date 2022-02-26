local Prison = Cell:extend("Prison")

function Prison:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(192, 64, tileW, tileH, tilesetW, tilesetH),
        0,
        0,
        1000,
        "One of the characters are imprisoned here.\nRotten iron bars, and sad noises",
        "Prison"    
    )

     

end

function Prison:onEntry(character, ax, ay)

    print(character.name)
    if character.parentPlayer == playerOne then

        table.insert(sequenceBufferTable, {
            name = "startingCellwasOccupiedSoMovingToanotherPosition",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                deadPool.playerOne[1].x = randomFunction(1, 10, "cell:onentry prison", self.x, self.y, inactivePlayer.characters[1].maxHP, turnCounter)
                deadPool.playerOne[1].y = randomFunction(1, 10, "cell:onentry prison", self.x, self.y,  inactivePlayer.characters[1].x, turnCounter)
                if boardGrid[deadPool.playerOne[1].x][deadPool.playerOne[1].y].isOccupied then
                    deadPool.playerOne[1].x = 1
                    deadPool.playerOne[1].y = 1
                end
                deadPool.playerOne[1].baseHP = math.floor((deadPool.playerOne[1].maxHP / 100) * 60)
                deadPool.playerOne[1].actionPoints = 0
                deadPool.playerOne[1].stepPoints = 0
                table.insert(character.parentPlayer.characters, deadPool.playerOne[1])
                table.remove(deadPool.playerOne)
                boardGrid[self.x][self.y] = Field(self.x, self.y)
            end
        })

  

    end




   if character.parentPlayer == playerTwo then

    local currentChar = deadPool.playerTwo[1]

        table.insert(sequenceBufferTable, {
            name = "startingCellwasOccupiedSoMovingToanotherPosition",
            duration = 0.3,
            sequenceTime = love.timer.getTime(),
            action = function()
                currentChar.x = randomFunction(1, 10, "cell:onentry prison", self.x, self.y, inactivePlayer.characters[1].maxHP, turnCounter)
                currentChar.y = randomFunction(1, 10, "cell:onentry prison", self.x, self.y, inactivePlayer.characters[1].x, turnCounter)
                if boardGrid[currentChar.x][currentChar.y].isOccupied then
                    currentChar.x = 1
                    currentChar.y = 1
                end
                currentChar.baseHP = math.floor((currentChar.maxHP / 100) * 60)
                currentChar.actionPoints = 0
                currentChar.stepPoints = 0
                table.insert(character.parentPlayer.characters, currentChar)
                table.remove(deadPool.playerTwo)
                boardGrid[self.x][self.y] = Field(self.x, self.y)
            end
        })

   
    end


end


return Prison