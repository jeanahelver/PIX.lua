local PIX = {mouse ={}}

function PIX.init(w,h,mode)
    love.graphics.setLineStyle( "rough" ) -- fixes blurry shapes
    PIX.minWidth = w
    PIX.minHeigth = h

    -- mode initilization
    if mode == nil then
        mode = "floor"
    end
    if type(mode) == "number" then
        PIX.resize = PIX.fixed
        PIX.scale = mode
        PIX.resize(mode)
    else
        PIX.resize = PIX[mode]
        PIX.resize()
    end
end
-- resize modes:
function PIX.fixed(scale)
    PIX.scaler = scale or PIX.scale
    if love.graphics.getWidth()*PIX.minHeigth > love.graphics.getHeight()*PIX.minWidth then
        PIX.height = math.floor(love.graphics.getHeight()/PIX.scaler)
        PIX.width = math.floor(love.graphics.getWidth()/PIX.scaler) 
    else
        PIX.width = math.floor(love.graphics.getWidth()/PIX.scaler) 
        PIX.height = math.floor(love.graphics.getHeight()/PIX.scaler)
    end
    PIX.canvas = love.graphics.newCanvas(PIX.width+1,PIX.height+1)
    PIX.canvas:setFilter("nearest")
end
function PIX.floor()
    if love.graphics.getWidth()*PIX.minHeigth > love.graphics.getHeight()*PIX.minWidth then
        PIX.scaler = math.floor(love.graphics.getHeight() / PIX.minHeigth)
        PIX.height = math.floor(love.graphics.getHeight()/PIX.scaler)
        PIX.width = math.floor(love.graphics.getWidth()/PIX.scaler)  
    else
        PIX.scaler = math.floor(love.graphics.getWidth() / PIX.minWidth)
        PIX.width = math.floor(love.graphics.getWidth()/PIX.scaler) 
        PIX.height = math.floor(love.graphics.getHeight()/PIX.scaler) 
    end
    PIX.canvas = love.graphics.newCanvas(PIX.width+1,PIX.height+1)
    PIX.canvas:setFilter("nearest")
end
function PIX.stretch()
    if love.graphics.getWidth()*PIX.minHeigth > love.graphics.getHeight()*PIX.minWidth then
        PIX.height = PIX.minHeigth
        PIX.width = math.floor(love.graphics.getWidth()/love.graphics.getHeight()*PIX.height) 
        PIX.scaler = love.graphics.getHeight() / PIX.minHeigth 
    else
        PIX.width = PIX.minWidth
        PIX.height = math.floor(love.graphics.getHeight()/love.graphics.getWidth()*PIX.width)
        PIX.scaler = love.graphics.getWidth() / PIX.minWidth
    end
    PIX.canvas = love.graphics.newCanvas(PIX.width+1,PIX.height+1)
    PIX.canvas:setFilter("nearest")
end
-- draw routine
function PIX.draw(func)
    love.graphics.setCanvas(PIX.canvas)
    love.graphics.clear()
    func()
    love.graphics.setCanvas()
    love.graphics.draw(PIX.canvas,0,0, 0, PIX.scaler)
end
-- mouse helper
function PIX.mouse.getPosition()
    return math.floor(love.mouse.getX()/PIX.scaler), math.floor(love.mouse.getY()/PIX.scaler)
end
function PIX.mouse.getX()
    return math.floor(love.mouse.getX()/PIX.scaler)
end
function PIX.mouse.getY()
    return math.floor(love.mouse.getY()/PIX.scaler)
end
-- image helper
function PIX.newImage(source)
    local image = love.graphics.newImage(source)
    image:setFilter("nearest")
    return image
end
return PIX