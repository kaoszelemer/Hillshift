soundEngine = {}



local function drawMusicPlayer()

    if isMusicOn then
        love.graphics.draw(musicOnImage, width / 16 , 0)
    end
        
    if isMusicOff then 
        love.graphics.draw(musicOffImage, width / 16 , 0)
    end

    if isMusicHoverTextOn then
        love.graphics.setFont(statFont)
        love.graphics.setColor(purpleColor)
        love.graphics.rectangle("fill", mouseX - tileW / 2, (mouseY + tileH / 2) + 4, tileW + tileW / 2, 12)
        love.graphics.setColor(charColor)
        love.graphics.print("Music on/off", mouseX - tileW / 2, mouseY + tileH / 2)
        love.graphics.setColor(charColor)
        love.graphics.setFont(statFont)
    end

end



function soundEngine:playSFX(sound)

    if sound == "playrandomsound" then

        local rnd = randomForCosmetics:random(1,10,"soundengine playsfx")
    
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
    mainThemeMusic = ripple.newSound(music1, {volume = .1, loop = true})

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

    local water = love.audio.newSource("/sounds/water.mp3", "static")
    waterSound = ripple.newSound(water, {volume = 0.75, loop = false})
  
    local air = love.audio.newSource("/sounds/airblow.mp3", "static")
    airBlowSound = ripple.newSound(air, {volume = 0.75, loop = false})
  
    local knife = love.audio.newSource("/sounds/knife.mp3", "static")
    knifeSound = ripple.newSound(knife, {volume = 0.75, loop = false})
  
    local forest = love.audio.newSource("/sounds/forest.mp3", "static")
    forestSound = ripple.newSound(forest, {volume = 0.75, loop = false})
  
    local desert = love.audio.newSource("/sounds/desert.mp3", "static")
    desertSound = ripple.newSound(desert, {volume = 0.75, loop = false})
  
    local ice = love.audio.newSource("/sounds/ice.mp3", "static")
    iceSound = ripple.newSound(ice, {volume = 0.75, loop = false})
  
    local poison = love.audio.newSource("/sounds/poison.mp3", "static")
    poisonSound = ripple.newSound(poison, {volume = 0.5, loop = false})

    local step = love.audio.newSource("/sounds/step.mp3", "static")
    stepSound = ripple.newSound(step, {volume = 0.5, loop = false})

    local ghost = love.audio.newSource("/sounds/ghost.mp3", "static")
    ghostSound = ripple.newSound(ghost, {volume = 0.5, loop = false})

    local eruption = love.audio.newSource("/sounds/eruption.mp3", "static")
    eruptionSound = ripple.newSound(eruption, {volume = 0.7, loop = false})

    local shrine = love.audio.newSource("/sounds/shrine.mp3", "static")
    shrineSound = ripple.newSound(shrine, {volume = 0.5, loop = false})
    
    local event = love.audio.newSource("/sounds/event.mp3", "static")
    eventSound = ripple.newSound(event, {volume = 0.75, loop = false})

    local criticalHit = love.audio.newSource("/sounds/criticalHit.mp3", "static")
    criticalHitSound = ripple.newSound(criticalHit, {volume = 0.75, loop = false})

    local lastSeconds = love.audio.newSource("/sounds/lastSeconds.mp3", "static")
    lastSecondsSound = ripple.newSound(lastSeconds, {volume = 0.33, loop = false})

    local niceRoll = love.audio.newSource("/sounds/niceRoll.mp3", "static")
    niceRollSound = ripple.newSound(niceRoll, {volume = 0.75, loop = false})

    local haha = love.audio.newSource("/sounds/haha.mp3", "static")
    hahaSound = ripple.newSound(haha, {volume = 0.75, loop = false})

    local doubledamage = love.audio.newSource("/sounds/doubledamage.mp3", "static")
    doubledamageSound = ripple.newSound(doubledamage, {volume = 0.75, loop = false})

    local tripledamage = love.audio.newSource("/sounds/tripledamage.mp3", "static")
    tripledamageSound = ripple.newSound(tripledamage, {volume = 0.75, loop = false})

    local quadripledamage = love.audio.newSource("/sounds/quadripledamage.mp3", "static")
    quadripledamageSound = ripple.newSound(quadripledamage, {volume = 0.75, loop = false})

    local quintipledamage = love.audio.newSource("/sounds/quintipledamage.mp3", "static")
    quintipledamageSound = ripple.newSound(quintipledamage, {volume = 0.75, loop = false})

    local sextupledamage = love.audio.newSource("/sounds/sextupledamage.mp3", "static")
    sextupledamageSound = ripple.newSound(sextupledamage, {volume = 0.75, loop = false})

    local ultramegabrutal = love.audio.newSource("/sounds/ultramegabrutal.mp3", "static")
    ultramegabrutalSound = ripple.newSound(ultramegabrutal, {volume = 0.75, loop = false})
    
    local itempickup = love.audio.newSource("/sounds/itempickup.mp3", "static")
    itempickupSound = ripple.newSound(itempickup, {volume = 0.75, loop = false})

    local prisononentry = love.audio.newSource("/sounds/prisononentry.mp3", "static")
    prisononentrySound = ripple.newSound(prisononentry, {volume = 0.75, loop = false})
   
    local arrow = love.audio.newSource("/sounds/arrow.mp3", "static")
    arrowSound = ripple.newSound(arrow, {volume = 0.75, loop = false})

    
    
    
    


    

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
    endTurnSound = ripple.newSound(endturn, {volume = 0.5, loop = false})

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