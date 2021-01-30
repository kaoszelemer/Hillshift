local Character = class("Character")

function Character:init(baseHP, baseDefense, baseAttack, id, image, imageHover, parentPlayer)
    self.baseHP = baseHP
    self.baseDefense = baseDefense
    self.baseAttack = baseAttack
    self.id = id
    self.image = image
    self.imageHover = imageHover
    self.parentPlayer = parentPlayer
    self.isWalkable = {
        Forest = true,
        Mount = true,
        Field = true,
        Ice = true,
    }
end

function Character:draw()
    local x = self.x * tileW + offsetX
    local y = self.y * tileH + offsetY
    
    if     self.isHovered == true then love.graphics.draw(self.imageHover, x, y)
    else   love.graphics.draw(self.image, x, y)
    end
    
    if self.isActionMenuDrawn == true then
        love.graphics.draw(attackIcon, x, y)
        love.graphics.draw(moveIcon, x + (tileW - tileW / 2), y)
        love.graphics.draw(spellIcon, x, y + (tileH - tileH / 2))
        love.graphics.draw(defenseIcon, x + (tileW - tileW / 2), y + (tileH - tileH / 2))     
    end

    if self.isInStepState then 
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




    if self.isInAttackState then
        if self.x + 1 < 11 and boardGrid[(self.x + 1)][self.y].isOccupied and  boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= self.parentPlayer  then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, self.y  * tileH + offsetY) end
        if self.x - 1 > 0 and boardGrid[(self.x -1)][self.y].isOccupied and  boardGrid[(self.x - 1)][self.y].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, self.y  * tileH + offsetY) end
        if self.y + 1 < 11 and boardGrid[self.x][(self.y + 1)].isOccupied and  boardGrid[(self.x)][self.y + 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, self.x * tileW + offsetX, (self.y + 1)  * tileH + offsetY) end
        if self.y - 1 > 0 and boardGrid[self.x][(self.y - 1)].isOccupied and  boardGrid[(self.x)][self.y - 1].occupiedBy.parentPlayer ~= self.parentPlayer then  love.graphics.draw(validAttackImage, self.x * tileW + offsetX, (self.y - 1)  * tileH + offsetY)  end
        if self.x + 1 < 11 and self.y + 1 < 11 and boardGrid[(self.x + 1)][self.y + 1].isOccupied and  boardGrid[(self.x + 1)][self.y + 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
        if self.x - 1 > 0 and self.y - 1 > 0 and boardGrid[(self.x - 1)][self.y - 1].isOccupied and  boardGrid[(self.x - 1)][self.y - 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
        if self.x + 1 < 11 and self.y - 1 > 0 and boardGrid[(self.x + 1)][self.y - 1].isOccupied and  boardGrid[(self.x + 1)][self.y - 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
        if self.x - 1 > 0 and self.y + 1 < 11 and boardGrid[(self.x - 1)][self.y + 1].isOccupied and  boardGrid[(self.x - 1)][self.y + 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end 
    end

    if selectedChar and self.drawAttack then
        
        local enemy = selectedChar
        local character = self
        if enemy ~= nil then
            love.graphics.setColor(charColor)
            love.graphics.setFont(statFont)
            love.graphics.print("---****------ BATTLE COMMENCES ----****--------", 10, 600)
            love.graphics.print(self.name .. " attacked " .. enemy.name, 10, 620)
            love.graphics.print(self.name .. " AT is: " .. self.baseAttack .. " + Dice: " .. self.diceRoll .. " + CM: " .. boardGrid[self.x][self.y].attackModifier , 10,640)
            love.graphics.print(enemy.name .. " DF is: " .. enemy.baseDefense .. " + CM: " .. boardGrid[enemy.x][enemy.y].defenseModifier , 10, 660)
            love.graphics.print("Battle: "  .. self.rolledAttack .. " AT - " .. enemy.baseDefense .. " DF" , 10, 680)
            love.graphics.print(self.name .. " obliterated " .. enemy.name .. " with " .. damage .. " damage.", 10, 700)
            love.graphics.print(enemy.name .. " remaining HP: " .. enemy.baseHP, 10, 720)
            love.graphics.print("------------*END OF THE BATTLE*-------------", 10, 740)
            love.graphics.setFont(font)
            love.graphics.setColor(selectedColor)
            love.graphics.print("-" .. damage, (enemy.x * tileW + (tileW / 4)) + offsetX, (enemy.y * tileH) + (tileH / 4) + offsetY)
            love.graphics.setColor(charColor)
        end
    end


    if self.isInSpellState then
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


function Character:updateHover(mX, mY)
    local  mouseCellCoordinateX = math.floor((mX / tileW) - offsetX / tileW) 
    local  mouseCellCoordinateY = math.floor((mY / tileH) - offsetY / tileH)
    if  mouseCellCoordinateX == self.x and mouseCellCoordinateY == self.y then
        self.isHovered = true
    else
        self.isHovered = false
    end
end


function Character:click(mX, mY)
    if self.isHovered and selectedChar and selectedChar.isInAttackState and selectedChar.parentPlayer ~= self.parentPlayer then
        selectedChar:attack(self)
        self.drawAttack = false
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



    if  self.isHovered and (selectedChar == nil or (selectedChar and not selectedChar.isInSpellState)) then-- ha az akciomenu nincs kirajzolva és a karakter felett vagyok és klikkelek akkor
        self.isSelected = true
        selectedChar = self
        selectedChar.drawAttack = false
        selectedChar.isActionMenuDrawn = true
    end


    -- ha a kivalasztott karakterem spell stateban van es valaki masra kattintok akkor ne valassza ki a valaki mast hanem fusson le a spell
              --  selectedChar           selectedChar.isInSpellState             self            
    

end

function Character:chooseActionMenu(mx, my)
    local cx = self.x * tileW + offsetX
    local cy = self.y * tileH + offsetY
        -- BAl FELSO NEGYED - ATTACK STATE
        if  mx > cx and mx < cx + tileW / 2 and  my > cy and my < cy + tileH / 2 then
                self.isInAttackState = true
                self.isActionMenuDrawn = false
        end
        -- JOBB FELSÖ NEGYED - STEP STATE                       
        if  mx > cx + tileW / 2 and mx < cx + tileW and my > cy and my < cy + tileH / 2 then
                self.isInStepState = true
                self.isActionMenuDrawn = false
        end
        -- BAL ALSO NEGYED - SPELL STATE
        if   mx > cx and mx < cx + tileW / 2 and my > cy + (tileH / 2) and my < cy + tileH then
                self.isInSpellState = true
                self.isActionMenuDrawn = false     
        end
        -- JOBB ALSO NEGYED - DEFENSE STATE
        if mx > cx + tileW / 2 and mx < cx + tileW and  my > cy + tileH / 2 and my < cy + tileH then
                self.isInDefenseState = true
                self.isActionMenuDrawn = false
        end
    
    self.drawBattle = false
end
        
    

function Character:move(x, y)
    if x >= 10 then x = 10 end
    if x <= 0 then x = 1 end
    if y >= 10 then y = 10 end
    if y <= 0 then y = 1 end

    if self.x and self.y then
        boardGrid[self.x][self.y].isOccupied = false
        boardGrid[self.x][self.y].occupiedBy = nil
    end
        self.x = x
        self.y = y
        boardGrid[self.x][self.y].isOccupied = true
        boardGrid[self.x][self.y].occupiedBy = self
      
end


function Character:defend()
    if self.isInDefenseState and self.actionPoints ~= 0 and self.isHovered then
        
        self.baseDefense = self.baseDefense + 2
        self.actionPoints = 0
        self.stepPoints = 0
        self.drawActionMenu = false
        self.isInDefenseState = false
        self.isSelected = false
    else self.isInDefenseState = false
        end
end


function Character:attack(enemy)
    if self.isInAttackState then
        local dr = getDiceRoll()
        self.drawAttack = true
        self.diceRoll = dr
        self.rolledAttack = self.baseAttack + dr + boardGrid[self.x][self.y].attackModifier
        damage = math.max(0, self.rolledAttack - (enemy.baseDefense + boardGrid[enemy.x][enemy.y].defenseModifier))
        enemy.baseHP = enemy.baseHP - damage
        self.isSelected = false
        --self.actionPoints = self.actionPoints - 1
        self.isInAttackState = false
        enemy = nil
    end
end

function Character:spell(targetCell)

end

return Character