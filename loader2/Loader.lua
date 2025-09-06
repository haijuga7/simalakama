-- Main Loader Script
local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Base URL GitHub
local base = "https://raw.githubusercontent.com/haijuga7/simalakama/main/loader2"

-- Buat folder untuk menyimpan modul jika belum ada
if not ReplicatedStorage:FindFirstChild("GUIModules") then
    local GUIModules = Instance.new("Folder")
    GUIModules.Name = "GUIModules"
    GUIModules.Parent = ReplicatedStorage
end

-- Daftar modul yang akan di-load (tanpa Minimize dan Drag Handler)
local moduleScripts = {
    MainGUI = base.."/GUI.lua",
    WalkSpeedModule = base.."/WalkSpeed.lua",
    HeadlampModule = base.."/Headlamp.lua",
    BrightModeModule = base.."/BrightMode.lua",
    GodModeModule = base.."/GodMode.lua",
    InfinityJumpModule = base.."/InfinityJump.lua",
    TeleportModule = base.."/Teleport.lua"
}

-- Fungsi untuk load module
local function loadModule(name, url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url, true))()
    end)
    
    if success then
        local module = Instance.new("ModuleScript")
        module.Name = name
        module.Source = "-- Module loaded from: " .. url .. "\n\nreturn " .. tostring(result)
        module.Parent = ReplicatedStorage.GUIModules
        return require(module)
    else
        warn("Gagal load module " .. name .. ": " .. result)
        return nil
    end
end

-- Load semua module
local modules = {}
for name, url in pairs(moduleScripts) do
    modules[name] = loadModule(name, url)
end

-- Inisialisasi GUI utama jika berhasil di-load
if modules.MainGUI then
    modules.MainGUI.init(modules)
end

-- Handle respawn untuk mempertahankan toggle state
local function setupCharacterEvents()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid")
        
        -- Terapkan semua fitur yang aktif
        if modules.WalkSpeedModule then
            modules.WalkSpeedModule.reapply()
        end
        
        if modules.HeadlampModule then
            modules.HeadlampModule.reapply()
        end
        
        if modules.InfinityJumpModule then
            modules.InfinityJumpModule.reapply()
        end
        
        if modules.GodModeModule then
            modules.GodModeModule.reapply()
        end
        
        if modules.BrightModeModule then
            modules.BrightModeModule.reapply()
        end
    end)
end

setupCharacterEvents()