local Effector = class("Effector")

function Effector:init(x, y, name)
    self.x = x
    self.y = y
    self.name = name
    
end


function Effector:apply(x, y)
    print("kolbasz")

end

return Effector