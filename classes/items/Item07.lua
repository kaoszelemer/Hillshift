local Item07 = Item:extend("Item07")
function Item07:init()
    Item.init(self,
    love.graphics.newImage("graphics/item07image.png"),
    love.graphics.newImage("graphics/weaponicon.png"),
    "Dagger of Jesus",
    "It embraces you\n+1A +10HP",
    1,
    0,
    1)
end

function Item07:drawItemOnScreenWhenPickup()
    if self.enableDraw  or self.inventoryHover then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 105, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 114, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 252, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item07:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)
    character.baseAttack = character.baseAttack + 1
    character.baseHP = character.baseHP + 10

end

return Item07