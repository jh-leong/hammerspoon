-------------- 剪贴板相关功能 -----------------
ClipboardTool = hs.loadSpoon("ClipboardTool")

-- true: 显示在菜单栏
ClipboardTool.show_in_menubar = false

-- true: 复制成功提示
ClipboardTool.show_copied_alert = false

-- How many items to keep on history. Defaults to 100
-- 数量过多的话启动会出现卡顿的问题
ClipboardTool.hist_size = 30

hs.hotkey.bind(hyperKey, "x", function()
    ClipboardTool:toggleClipboard()
end)

ClipboardTool:start()
