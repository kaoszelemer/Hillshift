local Volcano = Cell:extend("Volcano")

function Volcano:init(x, y)
    Cell.init(
        self, 
        x, 
        y, 
        true, 
        love.graphics.newQuad(384, 64, tileW, tileH, tilesetW, tilesetH),
        0,
        0,
        1000)
end




function Volcano:boom(bx, by)

    local d = 0.3
  
   
    for x = 1, 10 do
        for y = 1, 10 do
            if boardGrid[x][y].isErupting then
                print('erupting!!')
            end
        end
    end
    

    
   
    soundEngine:playSFX(eruptionSound)


    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if bx - 1 > 0 then

               
                boardGrid[bx - 1][by].isOnFire = true
                boardGrid[bx - 1][by].fireTurn = turnCounter
            end

        end})

    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if bx + 1 <= 10 then   
                boardGrid[bx + 1][by].isOnFire = true
                boardGrid[bx + 1][by].fireTurn = turnCounter
            end

        end})

    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if bx - 1 > 0 and by - 1 > 0 then  
                boardGrid[bx - 1][by - 1].isOnFire = true
                boardGrid[bx - 1][by - 1].fireTurn = turnCounter
            end

        end})


    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()


            if bx + 1 <= 10 and  by - 1 > 0 then   
                boardGrid[bx + 1][by - 1].isOnFire = true
                boardGrid[bx + 1][by - 1].fireTurn = turnCounter
            end

        end})


    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if bx - 1 > 0 and by + 1 <= 10 then   
                boardGrid[bx - 1][by + 1].isOnFire = true
                boardGrid[bx - 1][by + 1].fireTurn = turnCounter
            end

        end})

    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if  bx + 1 <= 10 and by + 1 <= 10 then   
                boardGrid[bx + 1][by + 1].isOnFire = true
                boardGrid[bx + 1][by + 1].fireTurn = turnCounter
            end
        end})

    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if by + 1 <= 10 then   
                boardGrid[bx][by + 1].isOnFire = true
                boardGrid[bx][by + 1].fireTurn = turnCounter
            end

        end})

    table.insert(sequenceBufferTable, {
        name = "IceMageSpellTopCell",
        duration = d,
        sequenceTime = love.timer.getTime(),
        action = function()

            if by - 1 > 0 then   
                boardGrid[bx][by - 1].isOnFire = true
                boardGrid[bx][by - 1].fireTurn = turnCounter
            end


        end})
   

    boardGrid[bx][by] = Mount(bx, by)
    isVolcanoOnBoard = false

  

end


return Volcano