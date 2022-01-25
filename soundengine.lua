soundEngine = {}



local function drawMusicPlayer()

    if isMusicOn then
        love.graphics.draw(musicOnImage, width / 16 , 0)
        
    elseif isMusicOff then love.graphics.draw(musicOffImage, width / 16 , 0)
    end

end

function soundEngine:playSFX(sound)

    if sound == "playrandomsound" then

        local rnd = randomFunction(1,10,"soundengine playsfx")
        print(rnd)
        if rnd == 1 then
            uhhSounds.uh:play()
        elseif rnd == 2 then
            uhhSounds.uh1:play()
        elseif rnd == 3 then
            uhhSounds.uh2:play()
        elseif rnd == 4 then
            uhhSounds.uh3:play()
        elseif rnd == 5 then
            uhhSounds.uh4:play()
        elseif rnd == 6 then
            uhhSounds.uh5:play()
        elseif rnd == 7 then
            uhhSounds.uh6:play()
        elseif rnd == 8 then
            uhhSounds.uh7:play()
        elseif rnd == 9 then
            uhhSounds.uh8:play()
        elseif rnd == 10 then
            uhhSounds.uh9:play()
        else

    
        sound:play()
        end
        return
    end

    sound:play()
    
    
end

function soundEngine:stopSFX(sound)

    sound:stop()

end


function soundEngine:load()

      
    local music1 = love.audio.newSource("/sounds/hs_maintheme.mp3", "static")
    mainThemeMusic = ripple.newSound(music1, {volume = .5, loop = true})

    --

    local sfx1 = love.audio.newSource("/sounds/click.mp3", "static")
    clickSound = ripple.newSound(sfx1, {volume = 0.75, loop = false})

    local sfx2 = love.audio.newSource("/sounds/iconhover.mp3", "static")
    iconAnimSound = ripple.newSound(sfx2, {volume = 0.25, loop = true})

    local fireBall = love.audio.newSource("/sounds/fireball.mp3", "static")
    fireBallSound = ripple.newSound(fireBall, {volume = 0.75, loop = false})

    local steam = love.audio.newSource("/sounds/steam.mp3", "static")
    steamSound = ripple.newSound(steam, {volume = 0.75, loop = false})

    local mount = love.audio.newSource("/sounds/mountain.mp3", "static")
    mountSound = ripple.newSound(mount, {volume = 0.75, loop = false})

    local thunder = love.audio.newSource("/sounds/thunder.mp3", "static")
    thunderSound = ripple.newSound(thunder, {volume = 0.75, loop = false})

    local uh = love.audio.newSource("/sounds/char_uh.mp3", "static")
    local uh1 = love.audio.newSource("/sounds/char_uh1.mp3", "static")
    local uh2 = love.audio.newSource("/sounds/char_uh2.mp3", "static")
    local uh3 = love.audio.newSource("/sounds/char_uh3.mp3", "static")
    local uh4 = love.audio.newSource("/sounds/char_uh4.mp3", "static")
    local uh5 = love.audio.newSource("/sounds/char_uh5.mp3", "static")
    local uh6 = love.audio.newSource("/sounds/char_uh6.mp3", "static")
    local uh7 = love.audio.newSource("/sounds/char_uh7.mp3", "static")
    local uh8 = love.audio.newSource("/sounds/char_uh8.mp3", "static")
    local uh9 = love.audio.newSource("/sounds/char_uh9.mp3", "static")


    uhhSounds = {
        uh = ripple.newSound(uh, {volume = 0.75, loop = false}),
        uh1 = ripple.newSound(uh1, {volume = 0.75, loop = false}),
        uh2 = ripple.newSound(uh2, {volume = 0.75, loop = false}),
        uh3 = ripple.newSound(uh3, {volume = 0.75, loop = false}),
        uh4 = ripple.newSound(uh4, {volume = 0.75, loop = false}),
        uh5 = ripple.newSound(uh5, {volume = 0.75, loop = false}),
        uh6 = ripple.newSound(uh6, {volume = 0.75, loop = false}),
        uh7 = ripple.newSound(uh7, {volume = 0.75, loop = false}),
        uh8 = ripple.newSound(uh8, {volume = 0.75, loop = false}),
        uh9 = ripple.newSound(uh9, {volume = 0.75, loop = false}),
        
    }

  
    
    

    local death = love.audio.newSource("/sounds/char_death.mp3", "static")
    deathSound = ripple.newSound(death, {volume = 0.75, loop = false})

    local endturn = love.audio.newSource("/sounds/endturn.mp3", "static")
    endTurnSound = ripple.newSound(endturn, {volume = 0.12, loop = false})

    if isMusicOn then local instance = mainThemeMusic:play() end

end

function soundEngine:update()

--[[     for x = 1, 10 do
        for y = 1, 10 do

            if boardGrid[x][y].isSteaming then
                print(boardGrid.isSteaming)
                soundEngine:playSFX(steamSound)

            end
        end
    end ]]


    mainThemeMusic:update(dt)
    iconAnimSound:update(dt)

end

function soundEngine:draw()

    drawMusicPlayer()

end