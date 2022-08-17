ClipboardTool = hs.loadSpoon("ClipboardTool")

local hyperKey = {"shift", "alt", "ctrl", "cmd"}

-------------- 剪贴板相关功能 -----------------

-- true: 显示在菜单栏
ClipboardTool.show_in_menubar = false

-- true: 复制成功提示
ClipboardTool.show_copied_alert = false

hs.hotkey.bind(hyperKey, "x", function()
    ClipboardTool:toggleClipboard()
end)

ClipboardTool:start()
