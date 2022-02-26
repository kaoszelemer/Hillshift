local Item01 = Item:extend("Item01")
function Item01:init()
    Item.init(self,
    love.graphics.newImage("graphics/item01image.png"),
    love.graphics.newImage("graphics/weaponicon.png"),
    "Prolitemitus Sword",
    "  Sword of Kaosz Elemer \n+3A +2DF",
    1,
    0,
    1)
end

function Item01:drawItemOnScreenWhenPickup()
    if self.enableDraw or self.inventoryHover then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 105, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 114, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 252, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item01:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)
    character.baseAttack = character.baseAttack + 3
    character.baseDefense = character.baseDefense + 2

end

return Item01