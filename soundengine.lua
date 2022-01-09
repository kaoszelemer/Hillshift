soundEngine = {}



local function drawMusicPlayer()

    if isMusicOn then
        love.graphics.draw(musicOnImage, width / 16 , 0)
        
    elseif isMusicOff then love.graphics.draw(musicOffImage, width / 16 , 0)
    end

end

function soundEngine:playSFX(sound)
    
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

    local uh1 = love.audio.newSource("/sounds/char_uh.mp3", "static")
    uhhSound = ripple.newSound(uh1, {volume = 0.75, loop = false})

    local death = love.audio.newSource("/sounds/char_death.mp3", "static")
    deathSound = ripple.newSound(death, {volume = 0.75, loop = false})


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