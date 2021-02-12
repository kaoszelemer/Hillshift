local Item09 = Item:extend("Item09")
function Item09:init()
    Item.init(self,
    love.graphics.newImage("graphics/item10image.png"),
    love.graphics.newImage("graphics/shieldicon.png"),
    "Oval Shield",
    "Looks like\n something else\n\n+1DF",
    1,
    0,
    1)
end

function Item09:drawItemOnScreenWhenPickup()
    if self.enableDraw or self.inventoryHover  then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 105, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 114, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 252, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item09:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)
    character.baseDefense = character.baseDefense + 1

end

return Item09