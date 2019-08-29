PIX = require "PIX"
function love.load()
    love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=256, minheight=512})

    -- how to use: PIX.init(minimum width,minimum height, scaling mode)

    PIX.init(64,128,"floor") -- tries most optimal amount of pixels for the aspect ratio, pixels will all be equal size
    --PIX.init(128,128,"stretch") -- steches the pixels to fill the screen, pixels could be differnt size
    --PIX.init(128,128,3) -- fixed mode, set the amount the pixels will scale, in this case 3x

    test = PIX.newImage("test.png") -- helper for images drawn inside PIX
end

function DrawPixelated()
    love.graphics.circle("fill",0,0,50)
    love.graphics.circle("fill",PIX.width,PIX.height,50)

    love.graphics.draw(test,PIX.mouse.getPosition())
end

function love.draw()
    -- pass function to draw in pixelated mode
    PIX.draw(DrawPixelated)
end

function love.resize(w, h)
    -- resize to fill the screen
    PIX.resize()
end
  