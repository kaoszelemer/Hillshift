local Item08 = Item:extend("Item08")
function Item08:init()
    Item.init(self,
    love.graphics.newImage("graphics/item08image.png"),
    love.graphics.newImage("graphics/weaponicon.png"),
    "Knife Of Hell",
    "My hand!!!\n+1AT -5HP",
    1,
    0,
    1)
end

function Item08:drawItemOnScreenWhenPickup()
    if self.enableDraw  or self.inventoryHover then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 105, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 114, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 252, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item08:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)
    character.baseAttack = character.baseAttack + 1
    character:damage(currentChar, 5)

end

return Item08