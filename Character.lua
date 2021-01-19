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


       --[[  if self.isInAttackState then
            if self.x + 1 < 11 and boardGrid[(self.x + 1)][self.y].isOccupied and boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= nil and boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, self.y  * tileH + offsetY) end
            if self.x - 1 > 0 and boardGrid[(self.x -1)][self.y].isOccupied and boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= nil and  boardGrid[(self.x -1)][self.y].occupiedBy.parentPlayer ~= self.parentPlayer  then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, self.y  * tileH + offsetY) end
            if self.y + 1 < 11 and boardGrid[self.x][(self.y + 1)].isOccupied and  boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= nil and boardGrid[self.x][(self.y + 1)].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, self.x * tileW + offsetX, (self.y + 1)  * tileH + offsetY) end
            if self.y - 1 > 0 and boardGrid[self.x][(self.y - 1)].isOccupied and  boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= nil and boardGrid[self.x][(self.y - 1)].occupiedBy.parentPlayer ~= self.parentPlayer then  love.graphics.draw(validAttackImage, self.x * tileW + offsetX, (self.y - 1)  * tileH + offsetY)  end
            if self.x + 1 < 11 and self.y + 1 < 11 and boardGrid[(self.x + 1)][self.y + 1].isOccupied and boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= nil and  boardGrid[(self.x + 1)][self.y + 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y - 1 > 0 and boardGrid[(self.x - 1)][self.y - 1].isOccupied and  boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= nil and boardGrid[(self.x - 1)][self.y - 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 and boardGrid[(self.x + 1)][self.y - 1].isOccupied and  boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= nil and boardGrid[(self.x + 1)][self.y - 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 and boardGrid[(self.x - 1)][self.y + 1].isOccupied and  boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= nil and boardGrid[(self.x - 1)][self.y + 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end 
        end  ]]
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


    if  self.isActionMenuDrawn and self.isHovered and self.isSelected and self.isInAttackState == false
    and self.isInSpellState == false and self.isInDefenseState == false and self.isInStepState == false then
        self:chooseActionMenu(mX, mY)
    else 
        self.isInAttackState = false
        self.isInStepState = false
        self.isInSpellState = false
        self.isInDefenseState = false
    end

    if  not self.isInAttackState and not self.isInDefenseState and not self.isInSpellState and not self.isInStepState then
        board:resetAllCharacterStates(playerOne, playerTwo)
    end

    if  self.isHovered and not self.isInAttackState and not self.isInDefenseState and not self.isInSpellState and not self.isInStepState then  -- ha az akciomenu nincs kirajzolva és a karakter felett vagyok és klikkelek akkor
        self.isSelected = true
        selectedChar = self
        self.isActionMenuDrawn = true
        self.drawBattle = false
    end

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
        if self.x and self.y then
            boardGrid[self.x][self.y].isOccupied = false
        end
            self.x = x
            self.y = y
            boardGrid[self.x][self.y].isOccupied = true          
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
 

    function Character:attack(x, y)
    
        if self.isInAttackState and self.actionPoints ~= 0 and (self.isDefending == false or self.isInDefenseState == false) then

            local  mouseCellCoordinateX = math.floor((x / tileW) - offsetX / tileW) 
            local  mouseCellCoordinateY = math.floor((y / tileH) - offsetY / tileH)
            local mx = math.min(math.max(mouseCellCoordinateX, 1), 10)
            local my = math.min(math.max(mouseCellCoordinateY, 1), 10)
            local clickedCell =  boardGrid[mx][my] 
               
            if  clickedCell.isOccupied and clickedCell.occupiedBy.parentPlayer ~= self.parentPlayer and clickedCell.occupiedBy ~= nil then
                    -- itt az enemi a player two aktualis karaktere lenne
                    enemy = clickedCell.occupiedBy
            
                    if enemy ~= nil then
                        print("enemy is: " .. enemy.baseDefense)
                        self.drawBattle = true    
                            self.drawBattle = true    
                        self.drawBattle = true    
                        self.drawDice = true
                        local dr = getDiceRoll()
                        self.diceRoll = dr
                        self.rolledAttack = self.baseAttack + dr
                        damage = math.max(0, self.rolledAttack - enemy.baseDefense)
                        enemy.baseHP = enemy.baseHP - damage
                        enemy.drawDamage = true
                        self.drawBattle = true
                        self.isSelected = false
                        --self.actionPoints = self.actionPoints - 1
                        self.isInAttackState = false
                        print("---****------ BATTLE COMMENCES ----****--------")
                        print(self.name .. " attacked " .. enemy.name)
                        print(self.name .. " AT is: " .. self.baseAttack .. " + Dice: " .. self.diceRoll)
                        print(self.name .. " DF is: " .. enemy.baseDefense)
                        print("Battle: "  .. self.rolledAttack .. " AT - " .. enemy.baseDefense .. " DF" )
                        print(self.name .. " obliterated " .. enemy.name .. " with " .. damage .. " damage.")
                        print(enemy.name .. " remaining HP: " .. enemy.baseHP)
                        print("------------*END OF THE BATTLE*-------------")
                        enemy = nil
                        self.isInAttackState = false
                    end
                
            else    self.isInAttackState = false
            end
        else self.isInAttackState = false
        end
        self.isInAttackState = false
    end

return Character