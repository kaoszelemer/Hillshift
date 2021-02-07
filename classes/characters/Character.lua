local Character = class("Character")

function Character:init(baseHP, baseDefense, baseAttack, id, image, imageHover, sinkImage, sinkImageHover, parentPlayer, actionPoints, stepPoints, turnAttackModifier, turnDefenseModifier, defenseCounter, defenseState)
    self.baseHP = baseHP
    self.baseDefense = baseDefense
    self.baseAttack = baseAttack
    self.id = id
    self.image = image
    self.imageHover = imageHover
    self.sinkImage = sinkImage
    self.sinkImageHover = sinkImageHover
    self.parentPlayer = parentPlayer
    self.actionPoints = actionPoints
    self.stepPoints = stepPoints
    self.turnAttackModifier = turnAttackModifier
    self.turnDefenseModifier = turnDefenseModifier
    self.defenseCounter = defenseCounter
    self.defenseState = defenseState
    self.isWalkable = {
        Forest = true,
        Mount = true,
        Field = true,
        Ice = true,
        BurntField = true,
    }
end

function Character:draw()
    local x = self.x * tileW + offsetX
    local y = self.y * tileH + offsetY
    
    if     boardGrid[self.x][self.y]:instanceOf(Lake) then love.graphics.draw(self.sinkImage, x, y)
    elseif boardGrid[self.x][self.y]:instanceOf(Lake) and self.isHovered then love.graphics.draw(self.sinkImageHover, x, y)
    elseif self.isHovered == true then love.graphics.draw(self.imageHover, x, y)
    else   love.graphics.draw(self.image, x, y)
    end
    
    if self.isActionMenuDrawn == true then
        if self.actionPoints ~= 0 then love.graphics.draw(attackIcon, x, y) end
        if self.stepPoints ~= 0 then love.graphics.draw(moveIcon, x + (tileW - tileW / 2), y) end
        if self.actionPoints ~= 0 then love.graphics.draw(spellIcon, x, y + (tileH - tileH / 2)) end
        if self.actionPoints ~= 0 then love.graphics.draw(defenseIcon, x + (tileW - tileW / 2), y + (tileH - tileH / 2)) end   
    end

    if self.enableDefendDraw then
        self.isActionMenuDrawn = false
        love.graphics.draw(defendedCellIcon, self.x * tileW + offsetX, self.y * tileH + offsetY)
    end


end

function Character:drawHealthBar()

    

    for _, currentChar in ipairs(activePlayer.characters) do
        if currentChar.isHovered then
            local healthBarMaxWidth = 3
            local healthBarWidth = healthBarMaxWidth * currentChar.baseHP
            if healthBarWidth < 10 then
                love.graphics.setColor(selectedColor)
                love.graphics.rectangle("fill", 6 + currentChar.x * tileW + offsetX, currentChar.y * tileH + offsetY, healthBarWidth, 7)
                love.graphics.setColor(charColor)
            else 
                love.graphics.setColor(greenColor)
                love.graphics.rectangle("fill", 6 + currentChar.x * tileW + offsetX, currentChar.y * tileH + offsetY, healthBarWidth, 7)
                love.graphics.setColor(charColor) 
            end
        end
    end

    for _, currentChar in ipairs(inactivePlayer.characters) do
        if currentChar.isHovered then
            local healthBarMaxWidth = 3
            local healthBarWidth = healthBarMaxWidth * currentChar.baseHP
            if healthBarWidth < 10 then
                love.graphics.setColor(selectedColor)
                love.graphics.rectangle("fill", 6 + currentChar.x * tileW + offsetX, currentChar.y * tileH + offsetY, healthBarWidth, 6)
                love.graphics.setColor(charColor)
            else
                love.graphics.setColor(greenColor)
                love.graphics.rectangle("fill", 6 + currentChar.x * tileW + offsetX, currentChar.y * tileH + offsetY, healthBarWidth, 7)
                love.graphics.setColor(charColor) 
            end
        end
    end

    


end

function Character:drawValidIcons()

    for _, currentChar in ipairs(activePlayer.characters) do
        local self = currentChar
        if self.isInStepState and self.stepPoints ~= 0 then 
            if self.x + 1 < 11 and self.isWalkable[boardGrid[(self.x + 1)][self.y].class.name] and not boardGrid[(self.x + 1)][self.y].isOccupied then
                love.graphics.draw(validStepImage, (self.x + 1) * tileW + offsetX, self.y  * tileH + offsetY)
            end
            if self.x - 1 > 0 and self.isWalkable[boardGrid[self.x - 1][self.y].class.name] and not boardGrid[self.x - 1][self.y].isOccupied then 
                love.graphics.draw(validStepImage, (self.x - 1) * tileW + offsetX, self.y  * tileH + offsetY)
            end
            if self.y + 1 < 11 and self.isWalkable[boardGrid[(self.x)][self.y + 1].class.name] and not boardGrid[self.x][(self.y + 1)].isOccupied then 
                love.graphics.draw(validStepImage, self.x * tileW + offsetX, (self.y + 1)  * tileH + offsetY) 
            end
            if self.y - 1 > 0 and self.isWalkable[boardGrid[self.x][self.y - 1].class.name] and not boardGrid[self.x][(self.y - 1)].isOccupied then 
                love.graphics.draw(validStepImage, self.x * tileW + offsetX, (self.y - 1)  * tileH + offsetY) 
            end
            if self.x + 1 < 11 and self.y + 1 < 11 and self.isWalkable[boardGrid[(self.x + 1)][self.y + 1].class.name] and not boardGrid[(self.x + 1)][self.y + 1].isOccupied  then
                love.graphics.draw(validStepImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) 
            end
            if self.x - 1 > 0 and self.y - 1 > 0 and self.isWalkable[boardGrid[(self.x - 1)][self.y - 1].class.name]  and not boardGrid[(self.x - 1)][self.y - 1].isOccupied then
                love.graphics.draw(validStepImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) 
            end    
            if self.x + 1 < 11 and self.y - 1 > 0 and self.isWalkable[boardGrid[(self.x + 1)][self.y - 1].class.name] and not boardGrid[(self.x + 1)][self.y - 1].isOccupied then 
                love.graphics.draw(validStepImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) 
            end
            if self.x - 1 > 0 and self.y + 1 < 11 and self.isWalkable[boardGrid[(self.x - 1)][self.y + 1].class.name] and not boardGrid[(self.x - 1)][self.y + 1].isOccupied then 
                love.graphics.draw(validStepImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) 
            end
        end
    
    
    
    
        if self.isInAttackState and self.actionPoints ~= 0 then
            if self.x + 1 < 11 and boardGrid[(self.x + 1)][self.y].isOccupied and boardGrid[(self.x + 1)][self.y].occupiedBy and boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= self.parentPlayer  then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, self.y  * tileH + offsetY) end
            if self.x - 1 > 0 and boardGrid[(self.x -1)][self.y].isOccupied and boardGrid[(self.x - 1)][self.y].occupiedBy and boardGrid[(self.x - 1)][self.y].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, self.y  * tileH + offsetY) end
            if self.y + 1 < 11 and boardGrid[self.x][(self.y + 1)].isOccupied and boardGrid[(self.x)][self.y + 1].occupiedBy and boardGrid[(self.x)][self.y + 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, self.x * tileW + offsetX, (self.y + 1)  * tileH + offsetY) end
            if self.y - 1 > 0 and boardGrid[self.x][(self.y - 1)].isOccupied and boardGrid[(self.x)][self.y - 1].occupiedBy and boardGrid[(self.x)][self.y - 1].occupiedBy.parentPlayer ~= self.parentPlayer then  love.graphics.draw(validAttackImage, self.x * tileW + offsetX, (self.y - 1)  * tileH + offsetY)  end
            if self.x + 1 < 11 and self.y + 1 < 11 and boardGrid[(self.x + 1)][self.y + 1].isOccupied and boardGrid[(self.x + 1)][self.y + 1].occupiedBy and boardGrid[(self.x + 1)][self.y + 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y - 1 > 0 and boardGrid[(self.x - 1)][self.y - 1].isOccupied and boardGrid[(self.x - 1)][self.y - 1].occupiedBy and boardGrid[(self.x - 1)][self.y - 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 and boardGrid[(self.x + 1)][self.y - 1].isOccupied and boardGrid[(self.x + 1)][self.y - 1].occupiedBy and boardGrid[(self.x + 1)][self.y - 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 and boardGrid[(self.x - 1)][self.y + 1].isOccupied and boardGrid[(self.x - 1)][self.y + 1].occupiedBy and boardGrid[(self.x - 1)][self.y + 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end 
        end
    
        if self.isInSpellState and self.actionPoints ~= 0 then
        if self.id == 1 or self.id == 5 then
            if self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
            if self.x - 1 > 0 then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y) * tileH + offsetY) end
        end
    
        if self.id == 3 or self.id == 4 then
            if self.x - 1 > 0 and self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
        end
    
        if self.id == 2 then
            if self.x - 1 > 0 and self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x - 2 > 0 and self.y - 2 > 0 then love.graphics.draw(validSpellImage, (self.x - 2) * tileW + offsetX, (self.y - 2) * tileH + offsetY) end
            if self.x - 2 > 0 and self.y + 2 < 11 then love.graphics.draw(validSpellImage, (self.x - 2) * tileW + offsetX, (self.y + 2) * tileH + offsetY) end
            if self.x + 2 < 11 and self.y - 2 > 0 then love.graphics.draw(validSpellImage, (self.x + 2) * tileW + offsetX, (self.y - 2) * tileH + offsetY) end
            if self.x + 2 < 11 and self.y + 2 < 11 then love.graphics.draw(validSpellImage, (self.x + 2) * tileW + offsetX, (self.y + 2) * tileH + offsetY) end
        end
    
        if self.id == 6 then
            if self.x - 1 > 0 and self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y + 1 < 11 then love.graphics.draw(validSpellImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
        end
    
    
        end
    end


end



function Character:updateHover(mX, mY)
    local  mouseCellCoordinateX = math.floor((mX / tileW) - offsetX / tileW) 
    local  mouseCellCoordinateY = math.floor((mY / tileH) - offsetY / tileH)
    if  mouseCellCoordinateX == self.x and mouseCellCoordinateY == self.y then
        self.isHovered = true
    else
        self.isHovered = false
    end
end

function Character:enablePossibleDamageDraw()

    local attacker
    local enemy
  
        for _, currentChar in ipairs(activePlayer.characters) do

            if currentChar.isInAttackState then
                attacker = currentChar
            end

        end

        for _, currentChar in ipairs(inactivePlayer.characters) do

            if currentChar.isHovered then
                enemy = currentChar
            end

        end

        if enemy ~= nil then
           isPossibleDamageDrawn = true
        end


end

function Character:click(mX, mY)

    if not self.enableDefendDraw and selectedChar and selectedChar.isInDefenseState  then
            local cell = boardGrid[self.x][ self.y]
            selectedChar:defend(cell)
            self.enableDefendDraw = true
            self.defenseState = true
            self.drawActionMenu = false
    end

   
    if selectedChar and selectedChar.isInAttackState and selectedChar.parentPlayer ~= self.parentPlayer then
        if  self.x + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x + 1][self.y]  or
            self.x - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x - 1][self.y] or
            self.y + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x][self.y + 1] or
            self.y - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x][self.y - 1] or
            self.x + 1 <= 10 and self.y + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x + 1][self.y + 1] or
            self.x - 1 > 0 and self.y + 1 <= 10 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x - 1][self.y + 1] or
            self.x + 1 <= 10 and self.y - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x + 1][self.y - 1] or
            self.x - 1 > 0 and self.y - 1 > 0 and boardGrid[selectedChar.x][selectedChar.y] == boardGrid[self.x - 1][self.y - 1] then

            selectedChar:attack(self)
        end
    end
 

    if  selectedChar and selectedChar.isActionMenuDrawn and selectedChar.isHovered and selectedChar.isSelected and selectedChar.isInAttackState == false
    and selectedChar.isInSpellState == false and selectedChar.isInDefenseState == false and selectedChar.isInStepState == false then
        selectedChar:chooseActionMenu(mX, mY)
        
    else 
        self.isInAttackState = false
        self.isInStepState = false
        self.isInSpellState = false
        self.isInDefenseState = false
        self.drawAttack = false
    end

    if  (selectedChar and not selectedChar.isInAttackState and not selectedChar.isInSpellState) and (not self.isInAttackState and not self.isInDefenseState and not self.isInSpellState and not self.isInStepState) then
        board:resetAllCharacterStates(playerOne, playerTwo)
        self.drawAttack = false
    end

    -- ha nem vagyok semmilyen kulonleges stateben akkor ki tudjak valasztan masik karaktert
    -- selectedChar and selectedChar ~= self  ha nem ugyanarra a karakterre nyomok mint a kivalasztott karakter akkor a resetallfaszom nem fut le hanem megy a tovabb a fuggveny

    if  self.parentPlayer == activePlayer and self.isHovered and (selectedChar == nil or (selectedChar and not selectedChar.isInSpellState and not selectedChar.isInAttackState)) then-- ha az akciomenu nincs kirajzolva és a karakter felett vagyok és klikkelek akkor
        self.isSelected = true
        self.drawAttack = false
        selectedChar = self
        selectedChar.isActionMenuDrawn = true
    end


    -- ha a kivalasztott karakterem spell stateban van es valaki masra kattintok akkor ne valassza ki a valaki mast hanem fusson le a spell
              --  selectedChar           selectedChar.isInSpellState             self            
    

end

function Character:chooseActionMenu(mx, my)
    local cx = self.x * tileW + offsetX
    local cy = self.y * tileH + offsetY

        -- BAl FELSO NEGYED - ATTACK STATE
        if  mx > cx and mx < cx + tileW / 2 and  my > cy and my < cy + tileH / 2 and self.actionPoints ~= 0 then
                self.isInAttackState = true
                self.isActionMenuDrawn = false
        end
        -- JOBB FELSÖ NEGYED - STEP STATE                       
        if  mx > cx + tileW / 2 and mx < cx + tileW and my > cy and my < cy + tileH / 2 and self.stepPoints ~= 0 then
                self.isInStepState = true
                self.isActionMenuDrawn = false
        end
        -- BAL ALSO NEGYED - SPELL STATE
        if   mx > cx and mx < cx + tileW / 2 and my > cy + (tileH / 2) and my < cy + tileH and self.actionPoints ~= 0 then
                self.isInSpellState = true
                self.isActionMenuDrawn = false     
        end
        -- JOBB ALSO NEGYED - DEFENSE STATE
        if mx > cx + tileW / 2 and mx < cx + tileW and  my > cy + tileH / 2 and my < cy + tileH and self.actionPoints ~= 0 then
                self.isInDefenseState = true
                self.isActionMenuDrawn = false
        end
    
    self.drawBattle = false
end
        
    

function Character:move(x, y)
   
    if self.stepPoints ~= 0 then
        if self.x and self.y then
            boardGrid[self.x][self.y].isOccupied = false
            boardGrid[self.x][self.y].occupiedBy = nil
        end
            self.x = x
            self.y = y
            if self.x >= 10 then self.x = 10 end
            if self.x <= 0 then self.x = 1 end
            if self.y >= 10 then self.y = 10 end
            if self.y <= 0 then self.y = 1 end
            boardGrid[self.x][self.y].isOccupied = true
            boardGrid[self.x][self.y].occupiedBy = self
            self.stepPoints = self.stepPoints - 1

    end
   
end


function Character:defend(cell)
    if self.iceSlide ~= nil and self.defenseState and self.actionPoints ~= 0 and self.isHovered then
        self.turnDefenseModifier = self.turnDefenseModifier + 2
        self.defenseCounter = turnCounter
        self.actionPoints = 0
        self.stepPoints = 0
        self.isSelected = false
    else self.isInDefenseState = false
    end
end

function Character:kill()
 
    for index, currentChar in ipairs(self.parentPlayer.characters) do
        if self == currentChar then
            boardGrid[self.x][self.y].isOccupied = false
            table.remove(self.parentPlayer.characters, index)
        end   
    end

end

function Character:attack(enemy)
    if self.iceSlide ~= nil and self.isInAttackState and self.actionPoints ~= 0 then

        local dr = getDiceRoll()
        self.diceRoll = dr
        self.rolledAttack = self.baseAttack + dr + boardGrid[self.x][self.y].attackModifier + self.turnAttackModifier
        damage = math.max(0, self.rolledAttack - (enemy.baseDefense + boardGrid[enemy.x][enemy.y].defenseModifier + enemy.turnDefenseModifier))
        enemy.baseHP = enemy.baseHP - damage
        if enemy.baseHP <= 0 then enemy:kill() end
        enableDrawAttack(self, enemy)
        self.isSelected = false
        self.actionPoints = self.actionPoints - 1
        self.isInAttackState = false
        enemy = nil
    end
end


function Character:spell(targetCell)
end

return Character