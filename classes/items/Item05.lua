local Item05 = Item:extend("Item05")
function Item05:init()
    Item.init(self,
    love.graphics.newImage("graphics/item05image.png"),
    love.graphics.newImage("graphics/weaponicon.png"),
    "Onyx Spear",
    "don't you break it\n-1A +1DF",
    1,
    0,
    1)
end

function Item05:drawItemOnScreenWhenPickup()
    if self.enableDraw  or self.inventoryHover then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 105, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 114, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 252, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item05:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)
    if character.baseAttack ~= 0 then character.baseAttack = character.baseAttack - 1 end
    character.baseDefense = character.baseDefense + 1


end

return Item05