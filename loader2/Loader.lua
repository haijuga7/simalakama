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

-- Daftar modul yang akan di-load
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
    print("Loading module: " .. name .. " from: " .. url)
    
    local success, result = pcall(function()
        local source = game:HttpGet(url, true)
        if not source or source == "" then
            error("Empty response from URL")
        end
        return loadstring(source)()
    end)
    
    if success then
        print("Module " .. name .. " loaded successfully")
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
    print("Initializing GUI...")
    modules.MainGUI.init(modules)
else
    warn("MainGUI module failed to load")
end

-- Handle respawn untuk mempertahankan toggle state
local function setupCharacterEvents()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    
    LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid")
        
        print("Character added, reapplying settings...")
        
        -- Terapkan semua fitur yang aktif
        if modules.WalkSpeedModule and modules.WalkSpeedModule.reapply then
            modules.WalkSpeedModule.reapply()
        end
        
        if modules.HeadlampModule and modules.HeadlampModule.reapply then
            modules.HeadlampModule.reapply()
        end
        
        if modules.InfinityJumpModule and modules.InfinityJumpModule.reapply then
            modules.InfinityJumpModule.reapply()
        end
        
        if modules.GodModeModule and modules.GodModeModule.reapply then
            modules.GodModeModule.reapply()
        end
        
        if modules.BrightModeModule and modules.BrightModeModule.reapply then
            modules.BrightModeModule.reapply()
        end
    end)
end

setupCharacterEvents()

print("Loader script executed successfully")