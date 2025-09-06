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

-- URLs untuk setiap module (ganti dengan URL paste-bin kamu)
local MODULES = {
    Utils = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader3/Utils.lua",
    GUI = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader3/GUI.lua", 
    WalkSpeed = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader3/walkspeed.lua",
    Headlamp = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader3/headlamp.lua", 
    BrightMode = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader3/brightmode.lua",
    GodMode = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader3/godmode.lua",
    InfinityJump = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader3/infjump.lua",
    Teleport = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader3/teleport.lua"
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
        -- return game:HttpGet(url) -- Uncomment ini untuk production
        
        -- Sementara return placeholder
        return "return function() print('✅ " .. name .. " module loaded!') end"
    end)
    
    if success then
        local moduleFunc = loadstring(result)
        if moduleFunc then
            _G.PlayerSettings.Modules[name] = moduleFunc()
            print("✅ " .. name .. " module loaded successfully!")
            return true
        else
            print("❌ Failed to compile " .. name .. " module")
        end
    else
        print("❌ Failed to fetch " .. name .. " module:", result)
    end
    return false
end

-- Load semua modules
local loadOrder = {"Utils", "GUI", "WalkSpeed", "Headlamp", "BrightMode", "GodMode", "InfinityJump", "Teleport"}

for _, moduleName in ipairs(loadOrder) do
    if not loadModule(moduleName, MODULES[moduleName]) then
        print("Failed to load required module: " .. moduleName)
    end
end

-- Initialize GUI setelah semua module loaded
if _G.PlayerSettings.Modules.GUI and _G.PlayerSettings.Modules.GUI.Initialize then
    _G.PlayerSettings.Modules.GUI.Initialize()
end

-- Initialize semua feature modules
for _, moduleName in ipairs({"WalkSpeed", "Headlamp", "BrightMode", "GodMode", "InfinityJump", "Teleport"}) do
    local module = _G.PlayerSettings.Modules[moduleName]
    if module and module.Initialize then
        module.Initialize()
    end
end

-- Keybind untuk toggle (Insert key)
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        if _G.PlayerSettings.GUI.MainFrame then
            _G.PlayerSettings.GUI.MainFrame.Visible = not _G.PlayerSettings.GUI.MainFrame.Visible
        end
    end
end)

print("🎮 Player Settings fully loaded! Press INSERT to toggle GUI")
print("📦 Loaded modules: " .. table.concat(loadOrder, ", "))
