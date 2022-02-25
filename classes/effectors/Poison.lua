local Poison = Cell:extend("Poison")

function Poison:init(x, y, name)
    Effector.init(
        self, 
        x, 
        y, 
        "Poison"
    )

     
    
    
end

function Poison:apply(x, y)
  
   
    if boardGrid[x][y]:instanceOf(Volcano) ~= true and boardGrid[x][y].isPoisoned ~=true then
        boardGrid[x][y].isPoisoned = true
        boardGrid[x][y].poisoningTurn = turnCounter
        
        if boardGrid[x][y].isOccupied and boardGrid[x][y].occupiedBy.isPoisoned  then
            boardGrid[x][y]:damageOnBoard("MISS")
        end
        
        if boardGrid[x][y].isOccupied and boardGrid[x][y].occupiedBy.isPoisoned ~= true then
            boardGrid[x][y].occupiedBy.isPoisoned = true
            boardGrid[x][y].occupiedBy.poisoningTurn = turnCounter
            boardGrid[x][y].occupiedBy:damage(boardGrid[x][y].occupiedBy, 3)   
        end



    end

end

return Poison