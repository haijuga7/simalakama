-- MAIN LOADER SCRIPT
-- Loader utama yang load semua module secara terpisah

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Cek apakah GUI sudah ada
if LocalPlayer.PlayerGui:FindFirstChild("PlayerGuiUI") then
    LocalPlayer.PlayerGui.PlayerGuiUI:Destroy()
    wait(0.1)
end

print("🔄 Loading Player Settings...")

-- URLs untuk setiap module
local MODULES = {
    Utils = "https://raw.githubusercontent.com/haijuga7/simalakama/main/loader3/Utils.lua",
    GUI = "https://raw.githubusercontent.com/haijuga7/simalakama/main/loader3/GUI.lua", 
    WalkSpeed = "https://raw.githubusercontent.com/haijuga7/simalakama/main/loader3/walkspeed.lua",
    Headlamp = "https://raw.githubusercontent.com/haijuga7/simalakama/main/loader3/headlamp.lua", 
    BrightMode = "https://raw.githubusercontent.com/haijuga7/simalakama/main/loader3/brightmode.lua",
    GodMode = "https://raw.githubusercontent.com/haijuga7/simalakama/main/loader3/godmode.lua",
    InfinityJump = "https://raw.githubusercontent.com/haijuga7/simalakama/main/loader3/infjump.lua",
    Teleport = "https://raw.githubusercontent.com/haijuga7/simalakama/main/loader3/teleport.lua"
}

-- Global storage untuk sharing antar module
_G.PlayerSettings = _G.PlayerSettings or {
    GUI = {},
    Modules = {},
    Services = {
        Players = game:GetService("Players"),
        UserInputService = game:GetService("UserInputService"),
        RunService = game:GetService("RunService"),
        Lighting = game:GetService("Lighting"),
        LocalPlayer = game:GetService("Players").LocalPlayer
    }
}

-- Function untuk load module
local function loadModule(name, url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success then
        local moduleFunc, err = loadstring(result)
        if moduleFunc then
            -- Panggil fungsi untuk mendapatkan modul sebenarnya
            local moduleTable = moduleFunc()
            _G.PlayerSettings.Modules[name] = moduleTable
            print("✅ " .. name .. " module loaded successfully!")
            return true
        else
            warn("❌ Failed to compile " .. name .. " module: " .. tostring(err))
        end
    else
        warn("❌ Failed to fetch " .. name .. " module: " .. tostring(result))
    end
    return false
end

-- Load semua modules dengan urutan yang benar
local loadOrder = {"Utils", "GUI", "WalkSpeed", "Headlamp", "BrightMode", "GodMode", "InfinityJump", "Teleport"}

for _, moduleName in ipairs(loadOrder) do
    local success = loadModule(moduleName, MODULES[moduleName])
    if not success then
        warn("⚠️ Could not load module: " .. moduleName)
    end
end

-- Initialize GUI setelah semua module loaded
if _G.PlayerSettings.Modules.GUI and _G.PlayerSettings.Modules.GUI.Initialize then
    local success, err = pcall(function()
        _G.PlayerSettings.Modules.GUI.Initialize()
    end)
    if not success then
        warn("❌ Failed to initialize GUI: " .. tostring(err))
    end
end

-- Initialize semua feature modules
for _, moduleName in ipairs({"WalkSpeed", "Headlamp", "BrightMode", "GodMode", "InfinityJump", "Teleport"}) do
    local module = _G.PlayerSettings.Modules[moduleName]
    if module and module.Initialize then
        local success, err = pcall(function()
            module.Initialize()
        end)
        if not success then
            warn("❌ Failed to initialize " .. moduleName .. ": " .. tostring(err))
        end
    end
end

-- Keybind untuk toggle (Insert key)
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        if _G.PlayerSettings.GUI and _G.PlayerSettings.GUI.MainFrame then
            _G.PlayerSettings.GUI.MainFrame.Visible = not _G.PlayerSettings.GUI.MainFrame.Visible
        end
    end
end)

print("🎮 Player Settings fully loaded! Press INSERT to toggle GUI")
