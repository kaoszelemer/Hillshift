local Item = class("Item")

function Item:init(itemImage, itemIcon, itemName, itemDesc, itemAttackModifier, itemDefenseModifier, itemID, itemOwnerPlayer, itemOwnerCharacter)
    self.itemImage = itemImage
    self.itemIcon = itemIcon
    self.itemName = itemName
    self.itemDesc = itemDesc
    self.itemAttackModifier = itemAttackModifier
    self.itemDefenseModifier = itemDefenseModifier
    self.itemOwnerPlayer = itemOwnerPlayer
    self.itemOwnerCharacter = itemOwnerCharacter
end

function Item:initItemTable()

    itemTable = {}

    table.insert(itemTable, Item01())
    table.insert(itemTable, Item02())
    table.insert(itemTable, Item03())
    table.insert(itemTable, Item04())
    table.insert(itemTable, Item05())
    table.insert(itemTable, Item06())
    table.insert(itemTable, Item07())
    table.insert(itemTable, Item08())
    table.insert(itemTable, Item09())
    table.insert(itemTable, Item10())
    table.insert(itemTable, Item11())


end

local function getRandomItemFromItemTable()

    local randomItem = love.math.random(1, #itemTable)
    return randomItem
    
end


function Item:drawCurrentItem()

    

    if self.drawItemOnScreen or self.inventoryHover then

        love.graphics.draw(itemBackgroundImage, 4 * tileW + offsetX, 4 * tileH + offsetY)
    
        for index, item in ipairs(itemTable) do
          
            if self.currentItem == index then

                currentItem = item
                currentItem.enableDraw = true
                currentItem:drawItemOnScreenWhenPickup()

            end

        end

    end
    
end

function Item:confirmItemPickup()

    

    for index, item in ipairs(itemTable) do
        if item.enableDraw == true then
          item:itemFunction(self.itemOwnerCharacter, self.itemOwnerPlayer)
          item.enableDraw = false

        end
    end

    self.drawItemOnScreen = false
    self.enableDraw = false
    self.itemPickUp = false

   --[[  for i, currentItem in ipairs(itemTable) do
        if currentItem == self then
            table.remove(itemTable, i)
        end
    end
 ]]

end

function Item:enableDrawCurrentItemOnSideBar(character, player, item)

   character.drawCurrentItem = true
     
end

function Item:addItemModifier()

end


function Item:pickUpItem(character, player)

    self.currentItem = getRandomItemFromItemTable()
    self.itemOwnerCharacter = character
    self.itemOwnerPlayer = player
    self.itemPickUp = true
    self.drawItemOnScreen = true
 

end


function Item:itemFunction(character, player)
end

return Item