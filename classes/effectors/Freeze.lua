local Freeze = Cell:extend("Freeze")

function Freeze:init(x, y, name)
    Effector.init(
        self, 
        x, 
        y, 
        "Freeze"  
    )

     

end

function Freeze:apply(x, y)
    if boardGrid[x][y].isFrozen ~= true and boardGrid[x][y]:instanceOf(Volcano) ~= true and boardGrid[x][y]:instanceOf(Ice) ~= true  then

        boardGrid[x][y].isFrozen = true
        boardGrid[x][y].freezeTurn = turnCounter
    end

    if boardGrid[x][y]:instanceOf(Lake) then 
        
        boardGrid[x][y] = Ice(x, y) 
        boardGrid[x][y].isInstanced = true
    end
    if boardGrid[x][y].isOnFire then boardGrid[x][y].isOnFire = false end 

end

return Freeze