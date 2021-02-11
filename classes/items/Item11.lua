local Item11 = Item:extend("Item11")
function Item11:init()
    Item.init(self,
    love.graphics.newImage("graphics/item11image.png"),
    love.graphics.newImage("graphics/weaponicon.png"),
    "Prolitemitus Sword",
    "Axe Of Healing\n\n+1AT +2HP",
    1,
    0,
    1)
end

function Item11:drawItemOnScreenWhenPickup()
    if self.enableDraw or self.inventoryHover  then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 5, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 14, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 152, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item11:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)
    character.baseAttack = character.baseAttack + 1
    character.baseHP = character.baseHP + 2

end

return Item11