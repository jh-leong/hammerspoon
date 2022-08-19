-------------- 窗口相关功能 -----------------
WinWin = hs.loadSpoon("WinWin")

-- 窗口最大化
hs.hotkey.bind(hyperKey, "f", function()
    WinWin:moveAndResize('maximize')
end)

-- 将窗口移动至 上 屏幕
hs.hotkey.bind(hyperKey, "w", function()
    WinWin:moveToScreen('up')
end)

-- 将窗口移动至 下 屏幕
hs.hotkey.bind(hyperKey, "s", function()
    WinWin:moveToScreen('down')
end)

-- 将窗口移动至 左 屏幕
hs.hotkey.bind(hyperKey, "a", function()
    WinWin:moveToScreen('left')
end)

-- 将窗口移动至 右 屏幕
hs.hotkey.bind(hyperKey, "d", function()
    WinWin:moveToScreen('right')
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

-- focus next display
hs.hotkey.bind(hyperKey, "o", function()
    activateDisplay(hs.mouse.getCurrentScreen():next())
end)

-------------- focus display end -----------------
