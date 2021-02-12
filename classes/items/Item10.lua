local Item10 = Item:extend("Item10")
function Item10:init()
    Item.init(self,
    love.graphics.newImage("graphics/item11image.png"),
    love.graphics.newImage("graphics/weaponicon.png"),
    "Dwarf Hat",
    "with visor\n\n+1DF +1HP",
    1,
    0,
    1)
end

function Item10:drawItemOnScreenWhenPickup()
    if self.enableDraw or self.inventoryHover  then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 1055, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 114, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 252, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item10:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)
    character.baseDefense = character.baseDefense + 1
    character.baseHP = character.baseHP + 1
end

return Item10