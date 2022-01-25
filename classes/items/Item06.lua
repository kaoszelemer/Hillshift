local Item06 = Item:extend("Item06")
function Item06:init()
    Item.init(self,
    love.graphics.newImage("graphics/item06image.png"),
    love.graphics.newImage("graphics/weaponicon.png"),
    "Jade Broadsword",
    "Sword of Logic\n\n+1A or +1DF",
    1,
    0,
    1)
end

function Item06:drawItemOnScreenWhenPickup()
    if self.enableDraw or self.inventoryHover  then
        love.graphics.setFont(pointFont)
        love.graphics.draw(self.itemImage, (4 * tileW + offsetX) + 105, (4 * tileH + offsetY) + 64)
        love.graphics.print(self.itemName, (4 * tileW + offsetX) + 114, (4 * tileH + offsetY) + 17)
        love.graphics.setFont(statFont)
        love.graphics.print(self.itemDesc, (4 * tileW + offsetX) + 252, (4 * tileH + offsetY) + 76)
        love.graphics.setFont(font)
    end
end

function Item06:itemFunction(character, player)
    character.ownedItem = self
    Item:enableDrawCurrentItemOnSideBar(character, player, self)

    local chance = randomFunction(nil, nil, "item6")

    if chance > 0.5 then
    character.baseAttack = character.baseAttack + 1
    else
    character.baseDefense = character.baseDefense + 1
    end

end

return Item06