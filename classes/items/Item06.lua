local Item06 = Item:extend("Item06")
function Item06:init()
    Item.init(self,
    love.graphics.newImage("graphics/item06image.png"),
    love.graphics.newImage("graphics/weaponicon.png"),
    "Jade Broadsword",
    "Sword of Logic\n\n+1A or +0AT",
    1,
    0,
    1)
end

function Item06:drawItemOnScreenWhenPickup()
    if self.enableDraw or self.inventoryHover  then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 5, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 14, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 152, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item06:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)
    character.baseAttack = character.baseAttack + love.math.random(0,1)

end

return Item06