WinWin = hs.loadSpoon("WinWin")

local windowModeEvTap
local isActive = false
local SizeStep = 20

WinWin.gridparts = 120 

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
windowMode:bind({}, ',', function()
    WinWin:moveAndResize('cornerSW')
end)
windowMode:bind({}, '.', function()
    WinWin:moveAndResize('cornerSE')
end)
windowMode:bind({}, 'm', function()
    WinWin:moveAndResize('cornerNE')
end)
windowMode:bind({}, 'n', function()
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

-- hs.hotkey.bind(hyperKey, "f", function()
--     WinWin:moveAndResize('maximize')
-- end)

local function runTap()
    windowModeEvTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
        -- Gets the keyboard modifiers of an event
        local flags = e:getFlags()
        local keyCode = e:getKeyCode()

        local window = hs.window.focusedWindow()
        local frame = window:frame()

        if keyCode == hs.keycodes.map['y'] then
            if flags and flags.shift then
                frame.w = frame.w - SizeStep
            else
                frame.w = frame.w + SizeStep
            end
            window:setFrame(frame)
            return true
        end
        if keyCode == hs.keycodes.map['u'] then
            if flags and flags.shift then
                frame.h = frame.h - SizeStep
            else
                frame.h = frame.h + SizeStep
            end
            window:setFrame(frame)
            return true
        end
        if keyCode == hs.keycodes.map['-'] then
            WinWin:moveAndResize('shrink')
            return true
        end
        if keyCode == hs.keycodes.map['='] then
            WinWin:moveAndResize('expand')
            return true
        end
        if keyCode == hs.keycodes.map['up'] then
            WinWin:stepMove('up')
            return true
        end
        if keyCode == hs.keycodes.map['right'] then
            WinWin:stepMove('right')
            return true
        end
        if keyCode == hs.keycodes.map['left'] then
            WinWin:stepMove('left')
            return true
        end
        if keyCode == hs.keycodes.map['down'] then
            WinWin:stepMove('down')
            return true
        end

        return false
    end)

    windowModeEvTap:start()
end

-- Use hyperKey+w to toggle window Mode
hs.hotkey.bind(hyperKey, 'w', function()
    if isActive then
        return
    end
    isActive = true
    windowMode:enter()
    runTap()
end)

local function exitWindowMode()
    windowModeEvTap:stop()
    windowMode:exit()
    isActive = false
end

-- Use q or escape to exit window Mode
windowMode:bind({}, 'q', function()
    exitWindowMode();
end)
windowMode:bind({}, 'escape', function()
    exitWindowMode();
end)

-------------- focus display -----------------

local function moveMouse2TargetDisplay(display)
    local rect = display:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.absolutePosition(center)
end

-- * code from: https://gist.github.com/kizzx2/e542fa74b80b7563045a 
local function getDisplayUnderMouse()
    local my_pos = hs.geometry.new(hs.mouse.absolutePosition())
    local my_screen = hs.mouse.getCurrentScreen()
    return hs.fnutils.find(hs.window.orderedWindows(), function(w)
        return my_screen == w:screen() and my_pos:inside(w:frame())
    end)
end

local function activateDisplay(display)
    moveMouse2TargetDisplay(display)
    getDisplayUnderMouse():focus()
end

-- focus main display
hs.hotkey.bind(hyperKey, "o", function()
    activateDisplay(hs.screen.primaryScreen())
end)
windowMode:bind({}, "o", function()
    activateDisplay(hs.screen.primaryScreen())
end)

-- focus next display
-- hs.hotkey.bind(hyperKey, "i", function()
--     activateDisplay(hs.mouse.getCurrentScreen():next())
-- end)
-- windowMode:bind({}, "i", function()
--     activateDisplay(hs.mouse.getCurrentScreen():next())
-- end)

-------------- focus display end -----------------
