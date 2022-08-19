WinWin = hs.loadSpoon("WinWin")

windowMode = hs.hotkey.modal.new({}, 'F19')

local message = require('status-message')
windowMode.statusMessage = message.new('Windom Mode (hyperKey + w)')

windowMode.entered = function()
    windowMode.statusMessage:show()
end
windowMode.exited = function()
    windowMode.statusMessage:hide()
end

windowMode:bind({}, 'w', function()
    WinWin:moveToScreen('up')
end)
windowMode:bind({}, 's', function()
    WinWin:moveToScreen('down')
end)
windowMode:bind({}, 'd', function()
    WinWin:moveToScreen('right')
end)
windowMode:bind({}, 'a', function()
    WinWin:moveToScreen('left')
end)
windowMode:bind({}, 'z', function()
    WinWin:moveAndResize('cornerSW')
end)
windowMode:bind({}, 'c', function()
    WinWin:moveAndResize('cornerSE')
end)
windowMode:bind({}, 'e', function()
    WinWin:moveAndResize('cornerNE')
end)
windowMode:bind({}, 'q', function()
    WinWin:moveAndResize('cornerNW')
end)
windowMode:bind({}, "f", function()
    WinWin:moveAndResize('maximize')
end)
windowMode:bind({}, "x", function()
    WinWin:moveAndResize('center')
end)
windowMode:bind({}, "h", function()
    WinWin:moveAndResize('halfleft')
end)
windowMode:bind({}, "j", function()
    WinWin:moveAndResize('halfdown')
end)
windowMode:bind({}, "k", function()
    WinWin:moveAndResize('halfup')
end)
windowMode:bind({}, "l", function()
    WinWin:moveAndResize('halfright')
end)
windowMode:bind({}, "-", function()
    WinWin:moveAndResize('shrink')
end)
windowMode:bind({}, "=", function()
    WinWin:moveAndResize('expand')
end)
windowMode:bind({}, "down", function()
    WinWin:stepMove('down')
end)
windowMode:bind({}, "up", function()
    WinWin:stepMove('up')
end)
windowMode:bind({}, "right", function()
    WinWin:stepMove('right')
end)
windowMode:bind({}, "left", function()
    WinWin:stepMove('left')
end)

hs.hotkey.bind(hyperKey, "f", function()
    WinWin:moveAndResize('maximize')
end)

-- Use Control+m to toggle Markdown Mode
hs.hotkey.bind(hyperKey, 'w', function()
    windowMode:enter()
end)

-- Use Control+m or escape to exit Markdown Mode
windowMode:bind(hyperKey, 'w', function()
    windowMode:exit()
end)
windowMode:bind({}, 'escape', function()
    windowMode:exit()
end)

-------------- focus display -----------------

function moveMouse2TargetDisplay(display)
    local rect = display:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.absolutePosition(center)
end

-- * code from: https://gist.github.com/kizzx2/e542fa74b80b7563045a 
function getDisplayUnderMouse()
    local my_pos = hs.geometry.new(hs.mouse.absolutePosition())
    local my_screen = hs.mouse.getCurrentScreen()
    return hs.fnutils.find(hs.window.orderedWindows(), function(w)
        return my_screen == w:screen() and my_pos:inside(w:frame())
    end)
end

function activateDisplay(display)
    moveMouse2TargetDisplay(display)
    getDisplayUnderMouse():focus()
end

-- focus main display
hs.hotkey.bind(hyperKey, "p", function()
    activateDisplay(hs.screen.primaryScreen())
end)
windowMode:bind({}, "p", function()
    activateDisplay(hs.screen.primaryScreen())
end)

-- focus next display
hs.hotkey.bind(hyperKey, "o", function()
    activateDisplay(hs.mouse.getCurrentScreen():next())
end)
windowMode:bind({}, "o", function()
    activateDisplay(hs.mouse.getCurrentScreen():next())
end)

-------------- focus display end -----------------
