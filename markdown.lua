-- * code from: https://github.com/jasonrudolph/keyboard/blob/main/hammerspoon/markdown.lua
function delayKeyUpDownLeftArrow(triggerCount)
    hs.timer.doAfter(0.01, function()
        for i = triggerCount, 1, -1 do
            keyUpDown('', 'left')
        end
    end)
end

function cacheClipboard(fn)
    -- Fetch content from the system clipboard
    local originalClipboardContents = hs.pasteboard.getContents()

    fn(originalClipboardContents)

    -- Allow some time for the command+v keystroke to fire asynchronously before
    -- we restore the original clipboard
    hs.timer.doAfter(0.2, function()
        hs.pasteboard.setContents(originalClipboardContents)
    end)
end

function inputContent(text)
    cacheClipboard(function()
        hs.pasteboard.setContents(text)
        keyUpDown('cmd', 'v')
    end)
end

function createHeading(level)
    local focusedElement = hs.uielement.focusedElement()
    local selectedText = focusedElement and focusedElement:selectedText() or ''

    local numberSign = ''

    for i = 1, level, 1 do
        numberSign = numberSign .. '#'
    end

    -- todo: see the todo in wrapSelectedText
    if (focusedElement == nil or selectedText == '') then
        inputContent(numberSign .. ' ')
    else
        inputContent(numberSign .. ' ' .. selectedText)
    end

end

function wrapSelectedText(wrapCharacters)
    cacheClipboard(function(originSelectText)
        -- Copy the selected text to the clipboard
        hs.eventtap.keyStroke({"cmd"}, "c")
        -- hs.timer.usleep(5000)

        local selectedText = hs.pasteboard.getContents()

        if selectedText and selectedText ~= '' and selectedText ~= originSelectText then
            -- Insert the wrapped text
            inputContent(wrapCharacters .. selectedText .. wrapCharacters)
        else
            inputContent(wrapCharacters .. '' .. wrapCharacters)
            delayKeyUpDownLeftArrow(#wrapCharacters)
        end
    end)
end

function inlineLink()
    local clipboardContent = hs.pasteboard.getContents()

    local contentIsUrl = clipboardContent and string.match(clipboardContent, '[a-z]*://[^ >,;]*') or false
    local linkUrl = contentIsUrl and clipboardContent or ''

    local focusedElement = hs.uielement.focusedElement()
    local selectedText = focusedElement and focusedElement:selectedText() or ''

    -- todo: see the todo in wrapSelectedText
    if (focusedElement == nil or selectedText == '') then
        inputContent('[' .. '' .. '](' .. linkUrl .. ')')
        delayKeyUpDownLeftArrow(3 + #linkUrl)
    else
        inputContent('[' .. selectedText .. '](' .. linkUrl .. ')')

        if linkUrl == '' then
            delayKeyUpDownLeftArrow(1)
        end
    end
end

--------------------------------------------------------------------------------
-- Define Markdown Mode
--
-- Markdown Mode allows you to perform common Markdown-formatting tasks anywhere
-- that you're editing text. Use Control+m to turn on Markdown mode. Then, use
-- any shortcut below to perform a formatting action. For example, to format the
-- selected text as bold in Markdown, hit Control+m, and then b.
--
--   1 - 6 => print # befor the selected text (e.g., # H1, ## H2)
--   t => print task list ("t" for "task list")
--   d => print dashes ("d" for "dashes")
--   h => wrap the selected text in double equal sign ("h" for "hightlight")
--   b => wrap the selected text in double asterisks ("b" for "bold")
--   c => wrap the selected text in backticks ("c" for "code")
--   i => wrap the selected text in single asterisks ("i" for "italic")
--   s => wrap the selected text in double tildes ("s" for "strikethrough")
--   l => convert the currently-selected text to an inline link, using a URL from the clipboard ("l" for "link")
--------------------------------------------------------------------------------

markdownMode = hs.hotkey.modal.new({}, 'F20')

local message = require('status-message')

markdownMode.statusMessage = message.new('Markdown Mode (control-m)')
markdownMode.entered = function()
    markdownMode.statusMessage:show()
end
markdownMode.exited = function()
    markdownMode.statusMessage:hide()
end

-- Bind the given key to call the given function and exit Markdown mode
function markdownMode.bindWithAutomaticExit(mode, key, fn)
    mode:bind({}, key, function()
        mode:exit()
        fn()
    end)
end

markdownMode:bindWithAutomaticExit('t', function()
    inputContent('- [ ] ')
end)

markdownMode:bindWithAutomaticExit('p', function()
    inputContent('![]()')
    delayKeyUpDownLeftArrow(3)
end)

markdownMode:bindWithAutomaticExit('d', function()
    inputContent('---')
end)

markdownMode:bindWithAutomaticExit('b', function()
    wrapSelectedText('**')
end)

markdownMode:bindWithAutomaticExit('i', function()
    wrapSelectedText('*')
end)

markdownMode:bindWithAutomaticExit('s', function()
    wrapSelectedText('~~')
end)

markdownMode:bindWithAutomaticExit('l', function()
    inlineLink()
end)

markdownMode:bindWithAutomaticExit('c', function()
    wrapSelectedText('`')
end)

markdownMode:bindWithAutomaticExit('h', function()
    wrapSelectedText('==')
end)

for i = 1, 6, 1 do
    markdownMode:bindWithAutomaticExit(tostring(i), function()
        createHeading(i)
    end)
end

-- Use Control+m to toggle Markdown Mode
hs.hotkey.bind({'ctrl'}, 'm', function()
    markdownMode:enter()
end)

-- Use Control+m or escape to exit Markdown Mode
markdownMode:bind({'ctrl'}, 'm', function()
    markdownMode:exit()
end)
markdownMode:bind({}, 'escape', function()
    markdownMode:exit()
end)
