## Toward a more useful keyboard

Inspired by [jasonrudolph/keyboard](https://github.com/jasonrudolph/keyboard#toward-a-more-useful-keyboard).
My configuration files for [Hammerspoon](https://github.com/Hammerspoon/hammerspoon#hammerspoon). It has highly modal-based, vim-style keybindings, provides several interesting features.

## Features

- [Navigate (up/down/left/right) via the home row](#vim-mode)
- [Navigate to previous/next word via the home row](#vim-mode)
- [Arrange windows via the home row](#window-layout-mode)
- [Format text as Markdown](#markdown-mode)

### Vim-mode

Use <kbd>hyperKey</kbd> + <kbd>v</kbd> to turn on Vim Mode (use <kbd>q</kbd> or <kbd>escape</kbd> to exit). Now you can:

- Use <kbd>h</kbd> / <kbd>j</kbd> / <kbd>k</kbd> / <kbd>l</kbd> for **left**/**down**/**up**/**right** respectively
- Use <kbd>H</kbd> / <kbd>L</kbd> for move to the beginning/end of the line
- Use <kbd>J</kbd> / <kbd>K</kbd> for move down/up 15 line
- Use <kbd>d</kbd> / <kbd>u</kbd> for <kbd>page down</kbd> / <kbd>page up</kbd>
- Use <kbd>b</kbd> / <kbd>w</kbd> or <kbd>e</kbd> to move to previous/next word (in most apps)

### Window Layout Mode

Quickly arrange and resize windows in common configurations, using keyboard shortcuts that are on or near the home row.

Use <kbd>hyperKey</kbd> + <kbd>w</kbd> to turn on Window Layout Mode (use <kbd>q</kbd> or <kbd>escape</kbd> to exit). Now you can:

- Use <kbd>h</kbd> to send window left (left half of screen)
- Use <kbd>j</kbd> to send window down (bottom half of screen)
- Use <kbd>k</kbd> to send window up (top half of screen)
- Use <kbd>l</kbd> to send window right (right half of screen)
- Use <kbd>n</kbd> to send window to upper left quarter of screen
- Use <kbd>m</kbd> to send window to upper right quarter of screen
- Use <kbd>,</kbd> to send window to lower left quarter of screen
- Use <kbd>.</kbd> to send window to lower right quarter of screen
- Use <kbd>y</kbd> to increase the window width
- Use <kbd>Y</kbd> to decrease the window width
- Use <kbd>u</kbd> to increase the window height
- Use <kbd>U</kbd> to decrease the window height
- Use <kbd>x</kbd> to send window to center of screen
- Use <kbd>f</kbd> to resize window to fill the screen
- Use <kbd>w</kbd> to send window to the monitor on the above (if there is one)
- Use <kbd>s</kbd> to send window to the monitor on the below (if there is one)
- Use <kbd>d</kbd> to send window to the monitor on the left (if there is one)
- Use <kbd>a</kbd> to send window to the monitor on the right (if there is one)
- Use <kbd>=</kbd> to expand the window size
- Use <kbd>-</kbd> to shrink the window size
- Use <kbd>↑</kbd> move the focused window above by on step
- Use <kbd>↓</kbd> move the focused window below by on step
- Use <kbd>←</kbd> move the focused window left by on step
- Use <kbd>→</kbd> move the focused window right by on step
- Use <kbd>o</kbd> focus the main display
- Use <kbd>i</kbd> focus the next display

For a couple of features that I use a lot, you can use them without Windows Layout Mode enabled:

- Use <kbd>hyperKey</kbd> + <kbd>o</kbd> focus the main display
- Use <kbd>hyperKey</kbd> + <kbd>i</kbd> focus the next display
- Use <kbd>hyperKey</kbd> + <kbd>f</kbd> to resize window to fill the screen

### Markdown Mode

Perform common [Markdown](https://daringfireball.net/projects/markdown/syntax)-formatting tasks anywhere that you're editing text (e.g. in a GitHub comment, in your editor, in your email client).

Use <kbd>control</kbd> + <kbd>m</kbd> to turn on Markdown Mode. Then, use any shortcut below to perform an action. For example, to format the selected text as bold in Markdown, hit <kbd>control</kbd> + <kbd>m</kbd>, and then <kbd>b</kbd>.

- Use <kbd>b</kbd> to wrap the currently-selected text in double asterisks ("B" for "Bold")

  Example: `**selection**`

- Use <kbd>1~6</kbd> to print `#` before the currently-selected text (Heading)

  Example: `### selection`

- Use <kbd>t</kbd> to print task list("T" for task list)

  Example: `- [] `

- Use <kbd>p</kbd> to print img wrap("p" for "picture")

  Example: `![]()`

- Use <kbd>d</kbd> to print dashes("D" for "Dashes")

  Example: `---`

- Use <kbd>h</kbd> to wrap the currently-selected text in `=` ("H" for "Hight light")

  Example: `==selection==`

- Use <kbd>c</kbd> to wrap the currently-selected text in backticks ("C" for "Code")

  Example: `` `selection` ``

- Use <kbd>i</kbd> to wrap the currently-selected text in single asterisks ("I" for "Italic")

  Example: `*selection*`

- Use <kbd>s</kbd> to wrap the currently-selected text in double tildes ("S" for "Strikethrough")

  Example: `~~selection~~`

- Use <kbd>l</kbd> to convert the currently-selected text to an inline link, using a URL from the clipboard ("L" for "Link")

  Example: `[selection](clipboard)`

- Use <kbd>control</kbd> + <kbd>m</kbd> to exit Markdown Mode without performing any actions

## How to use it

1.  Install [Hammerspoon](http://www.hammerspoon.org) (minimum version required: 0.9.55, which introduced the hs.spoons module)
2.  Clone this repository into your ~/.hammerspoon directory:

    ```sh
    git clone https://github.com/jh-leong/hammerspoon.git ~/.hammerspoon
    ```

3.  Run Hammerspoon.
4.  Have fun!

### Choose your own keybindings

See [init.lua](init.lua), set your own hyperKey. In default:

```lua
hyperKey = {"shift", "alt", "ctrl", "cmd"} -- set your own hyperKey
```

In my way, I configured Right Command as my HyperKey through [Karabiner](https://karabiner-elements.pqrs.org/).

You’re welcome to personalize all keybindings above.

## Contribute

Feel free to file issues or open PRs.

Here are some resources that may help you:

- [Learn X in Y minutes](http://learnxinyminutes.com/docs/lua/)
- [Getting Started with Hammerspoon](http://www.hammerspoon.org/go/)
- [Hammerspoon API Docs](http://www.hammerspoon.org/docs/index.html)
- [Hammerspoon Spoon Plugins Documentation](https://github.com/Hammerspoon/hammerspoon/blob/master/SPOONS.md)
