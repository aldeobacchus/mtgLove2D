local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()
local startTime = love.timer.getTime()


function love.load()

    print("Starting game...")

    require("src/startup/startup")
    startup()

    canvas = love.graphics.newCanvas(screenWidth, screenHeight, { type = '2d', readable = true })
    
    print("Creating a new card...")
    cards:newCard()

end

function love.draw()

    
    love.graphics.setCanvas(canvas)
    love.graphics.clear(0.937, 0.945, 0.96, 1)

    
    

    cards:draw()

    love.graphics.setCanvas()
    love.graphics.draw(canvas, 0, 0)
end

function love.update(dt)
    updateGameplay(dt)
end