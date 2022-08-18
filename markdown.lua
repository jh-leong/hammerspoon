-- * code from: https://github.com/jasonrudolph/keyboard/blob/main/hammerspoon/markdown.lua
function inputContent(text)
    hs.pasteboard.setContents(text)
    keyUpDown('cmd', 'v')
end

function delayKeyUpDownLeftArrow(triggerCount)
    hs.timer.doAfter(0.01, function()
        for i = triggerCount, 1, -1 do
            keyUpDown('', 'left')
        end
    end)
end

function wrapSelectedText(wrapCharacters)
    -- Preserve the current contents of the system clipboard
    local originalClipboardContents = hs.pasteboard.getContents()

    local focusedElement = hs.uielement.focusedElement()
    local selectedText = focusedElement and focusedElement:selectedText() or ''

    -- todo
    -- some app can not get focusedElement and selectedText
    -- such as some Elactron app, like Vscode/Obsidan
    -- here do that for workaround
    if (focusedElement == nil or selectedText == '') then
        inputContent(wrapCharacters .. '' .. wrapCharacters)
        delayKeyUpDownLeftArrow(#wrapCharacters)
    else
        inputContent(wrapCharacters .. selectedText .. wrapCharacters)
    end

    -- Allow some time for the command+v keystroke to fire asynchronously before
    -- we restore the original clipboard
    hs.timer.doAfter(0.2, function()
        hs.pasteboard.setContents(originalClipboardContents)
    end)
end

function inlineLink()
    -- Fetch URL from the system clipboard
    local originalClipboardContents = hs.pasteboard.getContents()

    local contentIsUrl = originalClipboardContents and string.match(originalClipboardContents, '[a-z]*://[^ >,;]*') or
                             false
    local linkUrl = contentIsUrl and originalClipboardContents or ''

    local focusedElement = hs.uielement.focusedElement()
    local selectedText = focusedElement and focusedElement:selectedText() or ''

    -- todo
    -- some app can not get focusedElement and selectedText
    -- such as some Elactron app, like Vscode/Obsidan
    -- here do that for workaround
    if (focusedElement == nil or selectedText == '') then
        inputContent('[' .. '' .. '](' .. linkUrl .. ')')
        delayKeyUpDownLeftArrow(3 + #linkUrl)
    else
        inputContent('[' .. selectedText .. '](' .. linkUrl .. ')')

        if linkUrl == '' then
            delayKeyUpDownLeftArrow(1)
        end
    end

    hs.timer.doAfter(0.2, function()
        hs.pasteboard.setContents(linkUrl)
    end)
end

--------------------------------------------------------------------------------
-- Define Markdown Mode
--
-- Markdown Mode allows you to perform common Markdown-formatting tasks anywhere
-- that you're editing text. Use Control+m to turn on Markdown mode. Then, use
-- any shortcut below to perform a formatting action. For example, to format the
-- selected text as bold in Markdown, hit Control+m, and then b.
--
--   h => wrap the selected text in double = ("b" for "hightlight")
--   b => wrap the selected text in double asterisks ("b" for "bold")
--   c => wrap the selected text in backticks ("c" for "code")
--   i => wrap the selected text in single asterisks ("i" for "italic")
--   s => wrap the selected text in double tildes ("s" for "strikethrough")
--   l => convert the currently-selected text to an inline link, using a URL
--        from the clipboard ("l" for "link")
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
