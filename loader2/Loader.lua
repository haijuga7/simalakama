-- Loader.lua
local base,,="https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader2
local links = {
    Utils = base.."/Utils.lua",
    Speed = base.."/Speed.lua",
    Headlamp = base.."/Headlamp.lua",
    Bright = base.."/Bright.lua",
    GodMode = base.."/GodMode.lua",
    InfinityJump = base.."/InfinityJump.lua"
}

local Utils = loadstring(game:HttpGet(links.Utils))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "PlayerGuiUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame", screenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 300)
MainFrame.Position = UDim2.new(0, 100, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local contentFrame = Instance.new("Frame", MainFrame)
contentFrame.Size = UDim2.new(1, -10, 1, -10)
contentFrame.Position = UDim2.new(0, 5, 0, 5)
contentFrame.BackgroundTransparency = 1

local applyFuncs = {}

local function loadModule(name, yOffset)
    local mod = loadstring(game:HttpGet(links[name]))
    local apply = mod(Utils, contentFrame, yOffset)
    if apply then table.insert(applyFuncs, apply) end
end

loadModule("Speed", 0)
loadModule("Headlamp", 70)
loadModule("Bright", 100)
loadModule("GodMode", 130)
loadModule("InfinityJump", 160)

LocalPlayer.CharacterAdded:Connect(function()
    for _,f in ipairs(applyFuncs) do f() end
end)
