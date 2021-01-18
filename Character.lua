local Character = class("Character")

    function Character:init(baseHP, baseDefense, baseAttack, id, image, imageHover, x, y, parentPlayer)
        self.baseHP = baseHP
        self.baseDefense = baseDefense
        self.baseAttack = baseAttack
        self.id = id
        self.image = image
        self.imageHover = imageHover
        self.x = x
        self.y = y
        self.parentPlayer = parentPlayer
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
            if self.x + 1 < 11 and boardGrid[(self.x + 1)][self.y].isWalkable and boardGrid[(self.x + 1)][self.y].isOccupied == false then love.graphics.draw(validStepImage, (self.x + 1) * tileW + offsetX, self.y  * tileH + offsetY) end
            if self.x - 1 > 0 and boardGrid[(self.x -1)][self.y].isWalkable and boardGrid[(self.x -1)][self.y].isOccupied == false then  love.graphics.draw(validStepImage, (self.x - 1) * tileW + offsetX, self.y  * tileH + offsetY) end
            if self.y + 1 < 11 and boardGrid[self.x][(self.y + 1)].isWalkable and boardGrid[self.x][(self.y + 1)].isOccupied == false then   love.graphics.draw(validStepImage, self.x * tileW + offsetX, (self.y + 1)  * tileH + offsetY) end
            if self.y - 1 > 0 and boardGrid[self.x][(self.y - 1)].isWalkable  and boardGrid[self.x][(self.y - 1)].isOccupied == false then  love.graphics.draw(validStepImage, self.x * tileW + offsetX, (self.y - 1)  * tileH + offsetY) end
            if self.x + 1 < 11 and self.y + 1 < 11 and boardGrid[(self.x + 1)][self.y + 1].isWalkable and boardGrid[(self.x + 1)][self.y + 1].isOccupied == false then love.graphics.draw(validStepImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y - 1 > 0 and boardGrid[(self.x - 1)][self.y - 1].isWalkable and boardGrid[(self.x - 1)][self.y - 1].isOccupied == false then  love.graphics.draw(validStepImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end    
            if self.x + 1 < 11 and self.y - 1 > 0 and boardGrid[(self.x + 1)][self.y - 1].isWalkable and boardGrid[(self.x + 1)][self.y - 1].isOccupied == false then love.graphics.draw(validStepImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 and boardGrid[(self.x - 1)][self.y + 1].isWalkable and boardGrid[(self.x - 1)][self.y + 1].isOccupied == false then  love.graphics.draw(validStepImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
        end



        if self.isInAttackState then
            if self.x + 1 < 11 and boardGrid[(self.x + 1)][self.y].isOccupied and boardGrid[(self.x + 1)][self.y].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, self.y  * tileH + offsetY) end
            if self.x - 1 > 0 and boardGrid[(self.x -1)][self.y].isOccupied and boardGrid[(self.x -1)][self.y].occupiedBy.parentPlayer ~= self.parentPlayer  then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, self.y  * tileH + offsetY) end
            if self.y + 1 < 11 and boardGrid[self.x][(self.y + 1)].isOccupied and boardGrid[self.x][(self.y + 1)].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, self.x * tileW + offsetX, (self.y + 1)  * tileH + offsetY) end
            if self.y - 1 > 0 and boardGrid[self.x][(self.y - 1)].isOccupied and boardGrid[self.x][(self.y - 1)].occupiedBy.parentPlayer ~= self.parentPlayer then  love.graphics.draw(validAttackImage, self.x * tileW + offsetX, (self.y - 1)  * tileH + offsetY)  end
            if self.x + 1 < 11 and self.y + 1 < 11 and boardGrid[(self.x + 1)][self.y + 1].isOccupied and boardGrid[(self.x + 1)][self.y + 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y - 1 > 0 and boardGrid[(self.x - 1)][self.y - 1].isOccupied and boardGrid[(self.x - 1)][self.y - 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x + 1 < 11 and self.y - 1 > 0 and boardGrid[(self.x + 1)][self.y - 1].isOccupied and boardGrid[(self.x + 1)][self.y - 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x + 1) * tileW + offsetX, (self.y - 1) * tileH + offsetY) end
            if self.x - 1 > 0 and self.y + 1 < 11 and boardGrid[(self.x - 1)][self.y + 1].isOccupied and boardGrid[(self.x - 1)][self.y + 1].occupiedBy.parentPlayer ~= self.parentPlayer then love.graphics.draw(validAttackImage, (self.x - 1) * tileW + offsetX, (self.y + 1) * tileH + offsetY) end 
        end
    end


   

    function Character:updateHover(x, y)
        local  mouseCellCoordinateX = math.floor((x / tileW) - offsetX / tileW) 
        local  mouseCellCoordinateY = math.floor((y / tileH) - offsetY / tileH)
        if  mouseCellCoordinateX == self.x and mouseCellCoordinateY == self.y then
            self.isHovered = true
        else
            self.isHovered = false
        end
    end

    function Character:click(x, y)
        if  self.isHovered then   -- ha az akciomenu nincs kirajzolva és a karakter felett vagyok és klikkelek akkor
            self.isSelected = true -- az adott karakter selected lesz
            self.isActionMenuDrawn = true
            self.drawBattle = false

            -- engedély az akciómenü rajzoláshoz a selectedPlayer esetén
        else self.isSelected = false            -- egyébként deszelektálom az összes karaktert
            self.isActionMenuDrawn = false -- akciómenü eltűnik az összes karakternél
            self.isInStepState = false
            self.isInAttackState = false
            self.drawDamage = false
            self.drawDice = false
        end   
    end

    function Character:drawContextualMenu(x, y)
        if  self.isActionMenuDrawn and self.isHovered and self.isSelected and self.isInAttackState == false
         and self.isInSpellState == false and self.isInDefenseState == false then

            local cx = self.x * tileW + offsetX
            local cy = self.y * tileH + offsetY
                -- BAl FELSO NEGYED - ATTACK STATE
                if  x > cx and x < cx + tileW / 2 and  y > cy and y < cy + tileH / 2 then
                        self.isInAttackState = true
                        self.isActionMenuDrawn = false
                end
                -- JOBB FELSÖ NEGYED - STEP STATE                       
                if  x > cx + tileW / 2 and x < cx + tileW and y > cy and y < cy + tileH / 2 then
                        self.isInStepState = true
                        self.isActionMenuDrawn = false
                end
                -- BAL ALSO NEGYED - SPELL STATE
                if   x > cx and x < cx + tileW / 2 and y > cy + (tileH / 2) and y < cy + tileH then
                        self.isInSpellState = true
                        self.isActionMenuDrawn = false     
                end
                -- JOBB ALSO NEGYED - DEFENSE STATE
                if x > cx + tileW / 2 and x < cx + tileW and  y > cy + tileH / 2 and y < cy + tileH then
                        self.isInDefenseState = true
                        self.isActionMenuDrawn = false
                end
            
            self.drawBattle = false
           
        else 
           -- self.isActionMenuDrawn = false
            self.isInAttackState = false
            self.isInStepState = false
            self.isInSpellState = false
            self.isInDefenseState = false
        end

    end

    function Character:move(x, y)
     

        if  self.isInStepState and self.stepPoints ~= 0 and (self.isInDefenseState == false or self.isDefending == false) then
            self.isMoving = true
            local  mouseCellCoordinateX = math.floor((x / tileW) - offsetX / tileW) 
            local  mouseCellCoordinateY = math.floor((y / tileH) - offsetY / tileH)
            local mx = math.min(math.max(mouseCellCoordinateX, 1), 10)
            local my = math.min(math.max(mouseCellCoordinateY, 1), 10)
            if  boardGrid[mx][my].isOccupied == false and self.isMoving and boardGrid[mx][my].isWalkable then
                if      mx == self.x + 1 or mx == self.x - 1 or my == self.y + 1 or my == self.y - 1 then
                        self.x = mx 
                        self.y = my  
                elseif  mx > self.x + 1 or my > self.y + 1 then character.isSelected = false
                elseif  mx < self.x - 1 or my < self.y - 1 then character.isSelected = false 
                end
            end 
        else self.isInStepState = false
        end
    
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
               if  clickedCell.isOccupied and self.parentPlayer ~= self.parentPlayer then
                    print(clickedCell.isOccupied)
                    if  (mx <= self.x + 1 and mx >= self.x - 1 and my <= self.y + 1 and my >= self.y - 1) 
                     and (self.x == mx and self.my == my) then -- itt a self.x es a self.y a player two x-e és y-ja
                        local enemy = self -- itt az enemi a player two aktualis karaktere lenne
           
                    else
                    self.isSelected = false
                    end 

                        if enemy ~= nil then
                            self.drawBattle = true    
                            self.drawDice = true
                            local dr = getDiceRoll()
                            self.diceRoll = dr
                            self.attack = self.baseAttack + dr
                            damage = math.max(0, self.attack - enemy.baseDefense)
                            enemy.baseHP = enemy.baseHP - damage
                            enemy.drawDamage = true
                            self.drawBattle = true
                            self.isSelected = false
                            self.actionPoints = self.actionPoints - 1
                            self.isInAttackState = false
                            enemy = nil
                        end
                end
                self.isInAttackState = false
                
        else self.isInAttackState = false
        end
    end

return Character