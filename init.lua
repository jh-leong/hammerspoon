-- set your own hyperKey
hyperKey = {"shift", "alt", "ctrl", "cmd"}

keyUpDown = function(modifiers, key)
    -- Un-comment & reload config to log each keystroke that we're triggering
    -- log.d('Sending keystroke:', hs.inspect(modifiers), key)

    hs.eventtap.keyStroke(modifiers, key, 0)
end

--- 禁用热键提示，开始使用的时候可以先设置成 1
-- hs.hotkey.alertDuration = 0

--- 禁用切换应用时的文件名提示
-- hs.hints.showTitleThresh = 0

--- 禁用动画
hs.window.animationDuration = 0

-- Use Control+` to reload Hammerspoon config
hs.hotkey.bind({'ctrl'}, '`', nil, function()
    hs.reload()
end)

require('vim')
require('window')
require('markdown')
-- require('clipboard')

hs.notify.new({
    title = 'Hammerspoon',
    informativeText = 'Ready to rock 🤘'
}):send()
