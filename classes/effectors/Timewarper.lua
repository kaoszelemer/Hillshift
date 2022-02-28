local Timewarper = Cell:extend("Timewarper")

function Timewarper:init(x, y, name)
    Effector.init(
        self, 
        x, 
        y, 
        "Timewarper"  
    )

     if boardGrid[self.x][self.y].isOccupied then
         if boardGrid[self.x][self.y].occupiedBy.parentPlayer == activePlayer.parentPlayer then
             turnTimer = turnTimer + 5
         end
     end

end

function  Timewarper:apply(x, y)

    boardGrid[x][y].isTimewarped = true
    boardGrid[x][y].timerParent = selectedChar.parentPlayer

    
end



return Timewarper