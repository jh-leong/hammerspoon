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

-------------- 聚焦 & 移动光标 至下一个屏幕 -----------------

local function focus_other_screen(isNext) -- focuses the other screen 
    local screen = hs.mouse.getCurrentScreen()

    local nextScreen = isNext and screen:next() or screen:previous()

    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.absolutePosition(center)
end

function get_window_under_mouse() -- from https://gist.github.com/kizzx2/e542fa74b80b7563045a 
    local my_pos = hs.geometry.new(hs.mouse.absolutePosition())
    local my_screen = hs.mouse.getCurrentScreen()
    return hs.fnutils.find(hs.window.orderedWindows(), function(w)
        return my_screen == w:screen() and my_pos:inside(w:frame())
    end)
end

function activate_other_screen(isNext)
    focus_other_screen(isNext)
    local win = get_window_under_mouse()
    -- now activate that window 
    win:focus()
end

hs.hotkey.bind(hyperKey, "i", function()
    activate_other_screen(true)
end)

hs.hotkey.bind(hyperKey, "o", function()
    activate_other_screen(false)
end)

-------------- 将窗口移动至其他 space -----------------

-- function moveWindowOneSpace(direction)
--     local mouseOrigin = hs.mouse.absolutePosition()
--     local win = hs.window.focusedWindow()
--     local clickPoint = win:zoomButtonRect()

--     clickPoint.x = clickPoint.x + clickPoint.w + 5
--     clickPoint.y = clickPoint.y + (clickPoint.h / 2)

--     local mouseClickEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmousedown, clickPoint)
--     mouseClickEvent:post()
--     hs.timer.usleep(150000)

--     local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, direction, true)
--     nextSpaceDownEvent:post()
--     hs.timer.usleep(150000)

--     local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, direction, false)
--     nextSpaceUpEvent:post()
--     hs.timer.usleep(150000)

--     local mouseReleaseEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmouseup, clickPoint)
--     mouseReleaseEvent:post()
--     hs.timer.usleep(150000)

--     hs.mouse.setAbsolutePosition(mouseOrigin)
-- end

-- hs.hotkey.bind(hyperKey, "e", function()
--     moveWindowOneSpace("right")
-- end)
-- hs.hotkey.bind(hyperKey, "q", function()
--     moveWindowOneSpace("left")
-- end)
