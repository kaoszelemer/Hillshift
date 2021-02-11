local Item = class("Item")

function Item:init(itemImage, itemName, itemDesc, itemAttackModifier, itemDefenseModifier, itemOwnerPlayer, itemOwnerCharacter)
    self.itemImage = itemImage
    self.itemName = itemName
    self.itemDesc = itemDesc
    self.itemAttackModifier = itemAttackModifier
    self.itemDefenseModifier = itemDefenseModifier
    self.itemOwnerPlayer = itemOwnerPlayer
    self.itemOwnerCharacter = itemOwnerCharacter
end



function Item:drawItemOnScreenWhenPickup()

    if self.drawItemOnScreen then
        love.graphics.draw(itemBackgroundImage, 4 * tileW + offsetX, 4 * tileH + offsetY)
    end

end

function Item:confirmItemPickup()

    self:addItemModifier()
    self.drawItemOnScreen = false
    self.itemPickUp = false


end

function Item:drawItemOnSideBar()
end

function Item:addItemModifier()
    print("modositok")
end


function Item:pickUpItem()

    self.itemPickUp = true
    self.drawItemOnScreen = true

end

return Item