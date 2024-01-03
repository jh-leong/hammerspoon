local function loopKeyUpDown(triggerCount, modifiers, key)
    for i = triggerCount, 1, -1 do
        hs.eventtap.keyStroke(modifiers, key, 0)
    end
end

local gKeyHasStroked = false
local function handleGKeyDownEvent(flags)
    if flags and flags.shift then
        keyUpDown({}, 'end')
        keyUpDown({'cmd'}, 'end')
        keyUpDown({'ctrl'}, 'end')
    else
        if gKeyHasStroked then
            keyUpDown({}, 'home')
            keyUpDown({'cmd'}, 'home')
            keyUpDown({'ctrl'}, 'home')
            gKeyHasStroked = false
        else
            gKeyHasStroked = true
            hs.timer.doAfter(0.2, function()
                gKeyHasStroked = false
            end)
        end
    end
end

vimMode = hs.hotkey.modal.new({}, 'F18')

local message = require('status-message')
vimMode.statusMessage = message.new('Vim Mode (-- NOMAL --)')

vimMode.entered = function()
    vimMode.statusMessage:show()
end
vimMode.exited = function()
    vimMode.statusMessage:hide()
end

-- keyDown event
local vimModeEvtap
local insetMode = false

local function runTap()
    vimModeEvtap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
        -- Gets the keyboard modifiers of an event
        local flags = e:getFlags()
        local keyCode = e:getKeyCode()

        if insetMode then
            if keyCode == hs.keycodes.map['escape'] then
                vimMode.statusMessage:hide()
                vimMode.statusMessage = message.new('Vim Mode (-- NOMAL --)')
                vimMode.statusMessage:show()
                insetMode = false
                return true;
            end

            return false
        end

        -- INSET mode
        if keyCode == hs.keycodes.map['i'] then
            vimMode.statusMessage:hide()
            vimMode.statusMessage = message.new('Vim Mode (-- INSERT --)')
            vimMode.statusMessage:show()
            insetMode = true
            return true
        end

        if keyCode == hs.keycodes.map['h'] then
            if flags and flags.shift then
                keyUpDown({'cmd'}, 'left')
            else
                keyUpDown({}, 'left')
            end
            -- Stop event from propogating
            return true
        end
        if keyCode == hs.keycodes.map['j'] then
            if flags and flags.shift then
                loopKeyUpDown(15, {}, 'down')
            else
                keyUpDown({}, 'down')
            end
            return true
        end
        if keyCode == hs.keycodes.map['k'] then
            if flags and flags.shift then
                loopKeyUpDown(15, {}, 'up')
            else
                keyUpDown({}, 'up')
            end
            return true
        end
        if keyCode == hs.keycodes.map['l'] then
            if flags and flags.shift then
                keyUpDown({'cmd'}, 'right')
            else
                keyUpDown({}, 'right')
            end
            return true
        end
        if keyCode == hs.keycodes.map['w'] or keyCode == hs.keycodes.map['e'] then
            keyUpDown({'alt'}, 'right')
            return true
        end
        if keyCode == hs.keycodes.map['b'] then
            keyUpDown({'alt'}, 'left')
            return true
        end
        if keyCode == hs.keycodes.map['u'] then
            keyUpDown({}, 'pageUp')
            return true
        end
        if keyCode == hs.keycodes.map['d'] then
            keyUpDown({}, 'pageDown')
            return true
        end
        if keyCode == hs.keycodes.map['g'] then
            handleGKeyDownEvent(flags)
            return true
        end

        return false
    end)

    vimModeEvtap:start()
end

local isActive = false
-- Use hyperKey+v to toggle vim Mode
hs.hotkey.bind({'cmd'}, ';', function()
    if isActive then
        return
    end

    isActive = true
    vimMode:enter()
    runTap()
end)

local function exitVimMode()
    vimModeEvtap:stop()
    vimMode:exit()
    isActive = false
    insetMode = false
    vimMode.statusMessage = message.new('Vim Mode (-- NOMAL --)')
end

-- Use q or escape to exit vim Mode
vimMode:bind({'cmd'}, ';', function()
    exitVimMode()
end)

-- vimMode:bind({}, 'escape', function()
--     exitVimMode()
-- end)
