-- Main Loader
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Load semua modul
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader/ui.lua"))()
local WalkSpeed = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader/walkspeed.lua"))()
local Headlamp = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader/headlamp.lua"))()
local BrightMode = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader/brightmode.lua))()
local GodMode = loadstring(game:HttpGet("https://raw.githubusercontent.com/your-username/your-repo/main/godmode.lua"))()
local InfinityJump = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader/infinityjump.lua"))()
local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader/ui.lua"))()
local Events = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader/events.lua"))()

-- Inisialisasi
UI:Initialize()
WalkSpeed:Initialize()
Headlamp:Initialize()
BrightMode:Initialize()
GodMode:Initialize()
InfinityJump:Initialize()
Teleport:Initialize()
Events:Initialize()

-- Terapkan pengaturan awal
WalkSpeed:ApplySettings()
Headlamp:ApplySettings()
BrightMode:ApplySettings()
GodMode:ApplySettings()
InfinityJump:ApplySettings()
