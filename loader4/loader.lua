-- loader.lua
-- Script ini adalah loader utama yang akan memuat semua modul

-- Fungsi untuk memuat modul dari URL
local function loadModule(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if success then
        return result
    else
        warn("Failed to load module from " .. url .. ": " .. tostring(result))
        return nil
    end
end

-- Inisialisasi state bersama
local SharedState = {
    UI = {
        PlayerGuiUI = nil,
        MainFrame = nil,
        ContentFrame = nil
    },
    Settings = {
        WalkSpeed = {
            Enabled = false,
            Value = 16,
            Default = 16,
            Max = 100,
            Connection = nil
        },
        Headlamp = {
            Enabled = false,
            Light = nil
        },
        BrightMode = {
            Enabled = false,
            Connections = {}
        },
        GodMode = {
            Enabled = false,
            Connection = nil
        },
        InfinityJump = {
            Enabled = false,
            Connection = nil
        }
    }
}

-- Buat ScreenGui
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local playerGuiUI = Instance.new("ScreenGui")
playerGuiUI.Name = "PlayerGuiUI"
playerGuiUI.Parent = PlayerGui
playerGuiUI.ResetOnSpawn = false
playerGuiUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

SharedState.UI.PlayerGuiUI = playerGuiUI

-- URL modul-modul (ganti dengan URL GitHub atau pastebin Anda)
local ModuleURLs = {
    UI = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader4/GUI.lua",
    WalkSpeed = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader4/walkspeed.lua",
    Headlamp = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader4/headlamp.lua",
    BrightMode = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader4/bright.lua",
    GodMode = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader4/godmode.lua",
    InfinityJump = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader4/infjump.lua",
    Teleport = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader4/teleport.lua",
    CharacterHandler = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader4/Utils.lua"
}

-- Muat modul-modul
local Modules = {}

-- Muat UI terlebih dahulu karena modul lain bergantung padanya
Modules.UI = loadModule(ModuleURLs.UI)
if Modules.UI then
    print("GUI sedang di load")
    Modules.UI.Initialize(SharedState)
    print("GUI berhasil di load")
    
    -- Muat modul-modul lainnya
    print("walkspeed")
    Modules.WalkSpeed = loadModule(ModuleURLs.WalkSpeed)
    if Modules.WalkSpeed then Modules.WalkSpeed.Initialize(SharedState) end
    print("berhasil")

    print("headlamp")
    Modules.Headlamp = loadModule(ModuleURLs.Headlamp)
    if Modules.Headlamp then Modules.Headlamp.Initialize(SharedState) end
    print("berhasil")

    print("bright")
    Modules.BrightMode = loadModule(ModuleURLs.BrightMode)
    if Modules.BrightMode then Modules.BrightMode.Initialize(SharedState) end
    print("berhasil")

    print("godmode")
    Modules.GodMode = loadModule(ModuleURLs.GodMode)
    if Modules.GodMode then Modules.GodMode.Initialize(SharedState) end
    print("berhasil")

    print("infjump")
    Modules.InfinityJump = loadModule(ModuleURLs.InfinityJump)
    if Modules.InfinityJump then Modules.InfinityJump.Initialize(SharedState) end
    print("berhasil")

    print("teleport")
    Modules.Teleport = loadModule(ModuleURLs.Teleport)
    if Modules.Teleport then Modules.Teleport.Initialize(SharedState) end
    print("berhasil")
    
    -- Muat CharacterHandler terakhir karena bergantung pada modul lainnya
    print("character")
    Modules.CharacterHandler = loadModule(ModuleURLs.CharacterHandler)
    if Modules.CharacterHandler then Modules.CharacterHandler.Initialize(SharedState, Modules) end
    print("berhasil")
    
    print("Player Settings GUI loaded successfully!")
else
    warn("Failed to load UI module. Aborting.")
    playerGuiUI:Destroy()
end
