-- loader
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local Games = {
    [9431156611] = {  -- SR
        Name = "Slap Royale",
        Url = "https://raw.githubusercontent.com/RegularVolt/Volt/refs/heads/main/Slap%20Royale/Script.lua"
    },

    [2413927524] = {  -- The Rake Remastered
        Name = "The Rake REMASTERED",
        Url = "https://raw.githubusercontent.com/RegularVolt/Volt/refs/heads/main/The%20Rake%20REMASTERED/Script.lua"
    }
}

local function Notify(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 5
        })
    end)
end

local function LoadScript(url)
    local success, content = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        local func, err = loadstring(content)
        if func then
            task.spawn(func)
            Notify("Success", "Script loaded!")
        else
            Notify("Error", "Loadstring failed: " .. tostring(err))
        end
    else
        Notify("Error", "Failed to fetch script.")
    end
end

-- Main execution
local placeId = game.PlaceId
local gameData = Games[placeId]

if gameData then
    Notify("Loader", "Loading " .. gameData.Name .. "...")
    LoadScript(gameData.Url)
else
    Notify("Loader", "No script for this game (ID: " .. placeId .. ")")
end
