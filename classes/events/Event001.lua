local Event001 = Character:extend("Event001")
    function Event01:init(x, y)
     Event.init(self,
        love.graphics.newImage("eventbackgroundimage.png"),
        love.graphics.newImage("event001image.png"),
        "Armageddon",
        1,
        "... burn, burn, burn ...",
        "All cellls are on fire.",
        0,
            )

        end

return Event001