local Item = class("Item")

function Item:init(itemImage, itemName, itemAttackModifier, itemDefenseModifier, itemOwnerPlayer, itemOwnerCharacter)
    self.itemImage = itemImage
    self.itemName = itemName
    self.itemAttackModifier = itemAttackModifier
    self.itemDefenseModifier = itemDefenseModifier
    self.itemOwnerPlayer = itemOwnerPlayer
    self.itemOwnerCharacter = itemOwnerCharacter
end



return Item