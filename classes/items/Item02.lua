local Item02 = Item:extend("Item02")
function Item02:init()
    Item.init(self,
    love.graphics.newImage("graphics/item02image.png"),
    love.graphics.newImage("graphics/shieldicon.png"),
    "Fiery Hauberk",
    "It's too ho at summer\n+4DF -10HP",
    0,
    1,
    1)
end

function Item02:drawItemOnScreenWhenPickup()
    if self.enableDraw or self.inventoryHover then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 105, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 114, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 252, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item02:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)
    character.baseDefense = character.baseDefense + 4
    character:damage(character, 10)

end

return Item02