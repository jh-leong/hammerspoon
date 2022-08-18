-- * code from: https://github.com/jasonrudolph/keyboard/blob/main/hammerspoon/status-message.lua
local drawing = require 'hs.drawing'
local geometry = require 'hs.geometry'
local screen = require 'hs.screen'
local styledtext = require 'hs.styledtext'

local statusmessage = {}

statusmessage.new = function(messageText)
    local buildParts = function(messageText)
        local frame = screen.primaryScreen():frame()

        local styledTextAttributes = {
            font = {
                name = 'Monaco',
                size = 20
            },
            color = {
                red = 1,
                green = 1,
                blue = 1
            }
        }

        local styledText = styledtext.new('🔨 ' .. messageText, styledTextAttributes)

        local styledTextSize = drawing.getTextDrawingSize(styledText)
        local textRect = {
            x = frame.w - styledTextSize.w - 40,
            y = frame.h - styledTextSize.h,
            w = styledTextSize.w + 40,
            h = styledTextSize.h + 40
        }
        local text = drawing.text(textRect, styledText):setAlpha(1)

        local background = drawing.rectangle({
            x = frame.w - styledTextSize.w - 54,
            y = frame.h - styledTextSize.h - 6,
            w = styledTextSize.w + 28,
            h = styledTextSize.h + 12
        })
        background:setRoundedRectRadii(10, 10)
        background:setFillColor({
            red = 0.167,
            green = 0.131,
            blue = 0.247
        })

        return background, text
    end

    return {
        _buildParts = buildParts,
        show = function(self)
            self:hide()

            self.background, self.text = self._buildParts(messageText)
            self.background:show()
            self.text:show()
        end,
        hide = function(self)
            if self.background then
                self.background:delete()
                self.background = nil
            end
            if self.text then
                self.text:delete()
                self.text = nil
            end
        end,
        notify = function(self, seconds)
            local seconds = seconds or 1
            self:show()
            hs.timer.delayed.new(seconds, function()
                self:hide()
            end):start()
        end
    }
end

return statusmessage
