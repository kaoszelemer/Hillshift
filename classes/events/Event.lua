local Event = class("Event")

function Cell:init(x, y, backgroundImage, image, name, id, flavorText, text, isGood)
    self.x = x
    self.y = y
    self.backgroundImage = backgroundImage
    self.image = image
    self.name = name
    self.id = id
    self.flavorText = flavorText
    text = text
    self.isGood = isGood
end

return Event