--[[
    Three-Finger Swipe Volume Control Script for Hammerspoon on MacOS
    Author: AndroidDev77
    Created: 
    License: MIT License

    Copyright (c) 2024 AndroidDev77 . All rights reserved.

--]]

local lastY = nil
local trackedFinger = nil -- Identity of the tracked finger
local lastVolumeChangeTime = 0 -- Track the last volume change time
local debounceTime = 0.1 -- Minimum time (in seconds) between volume adjustments
local deltaThreshold = 0.5 -- Minimum delta required to trigger a swipe

local function pressMediaKey(key)
    -- Simulate a system-defined media key press
    local keyEvent = hs.eventtap.event.newSystemKeyEvent(key, true) -- Key down
    keyEvent:post()
    hs.timer.usleep(1000) -- Small delay
    keyEvent = hs.eventtap.event.newSystemKeyEvent(key, false) -- Key up
    keyEvent:post()
end

local function detectSwipe(event)
    local touches = event:getTouches()

    -- Ensure it's a three-finger gesture
    if not touches or #touches ~= 3 then
        lastY = nil
        trackedFinger = nil
        return false
    end

    -- Select or validate the tracked finger
    if not trackedFinger then
        -- Track the first finger we detect
        trackedFinger = touches[1].identity
    end

    -- Find the tracked finger in the current touches
    local trackedTouch = nil
    for _, touch in ipairs(touches) do
        if touch.identity == trackedFinger then
            trackedTouch = touch
            break
        end
    end

    -- If the tracked finger isn't found, reset
    if not trackedTouch then
        lastY = nil
        trackedFinger = nil
        return false
    end

    -- Process movement of the tracked finger
    if trackedTouch.phase == "moved" then
        if not trackedTouch.normalizedPosition or not trackedTouch.deviceSize then
            lastY = nil
            trackedFinger = nil
            return false
        end

        -- Calculate current Y position
        local normalizedY = trackedTouch.normalizedPosition.y
        local deviceHeight = trackedTouch.deviceSize.h
        local currentY = normalizedY * deviceHeight

        -- Compute deltaY and check for debounce
        if lastY then
            local deltaY = lastY - currentY
            local currentTime = hs.timer.secondsSinceEpoch()
            if math.abs(deltaY) > deltaThreshold and (currentTime - lastVolumeChangeTime > debounceTime) then
                if deltaY > 0 then
                    pressMediaKey("SOUND_DOWN") -- Simulate Volume Down
                elseif deltaY < 0 then
                    pressMediaKey("SOUND_UP") -- Simulate Volume Up
                end
                lastVolumeChangeTime = currentTime -- Update last change time
            end
        end

        -- Update lastY for the tracked finger
        lastY = currentY
    end

    return false
end

-- Create the gesture event tap
gestureEventTap = hs.eventtap.new({ hs.eventtap.event.types.gesture }, detectSwipe)

-- Start listening
gestureEventTap:start()

hs.alert.show("Three-Finger Swipe Detection Active")
