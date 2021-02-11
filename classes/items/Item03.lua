local Item03 = Item:extend("Item03")
function Item03:init()
    Item.init(self,
    love.graphics.newImage("graphics/item03image.png"),
    love.graphics.newImage("graphics/shieldicon.png"),
    "Assassin Dagger",
    "shvshvshvs \n\n+2DF",
    1,
    0,
    1)
end

function Item03:drawItemOnScreenWhenPickup()
    if self.enableDraw or self.inventoryHover then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 5, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 14, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 152, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item03:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)
    character.baseDefense = character.baseDefense + 2

end

return Item03