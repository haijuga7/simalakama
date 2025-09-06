local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Buat ScreenGui
local playerGuiUI = Instance.new("ScreenGui")
playerGuiUI.Name = "PlayerGuiUI"
playerGuiUI.Parent = PlayerGui
playerGuiUI.ResetOnSpawn = false
playerGuiUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 280)
MainFrame.Position = UDim2.new(0, 100, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = playerGuiUI

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = MainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.BorderSizePixel = 0
header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "Player Settings"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = header

-- Tombol minimize
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = header
local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 15)
MinimizeCorner.Parent = MinimizeButton

-- Tombol close
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = header
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 15)
CloseCorner.Parent = CloseButton

-- Label SJ (untuk minimize)
local sjLabel = Instance.new("TextButton")
sjLabel.Size = UDim2.new(1, 0, 1, 0)
sjLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
sjLabel.Text = "SJ"
sjLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
sjLabel.Font = Enum.Font.GothamBold
sjLabel.TextSize = 18
sjLabel.TextScaled = true
sjLabel.Visible = false
sjLabel.Parent = MainFrame
local sjCorner = Instance.new("UICorner")
sjCorner.CornerRadius = UDim.new(1, 0)
sjCorner.Parent = sjLabel

-- Content container
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -10, 1, -40)
contentFrame.Position = UDim2.new(0, 5, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = MainFrame

-- Toggle Speed
local speedToggle = Instance.new("TextButton")
speedToggle.Size = UDim2.new(0, 40, 0, 20)
speedToggle.Position = UDim2.new(1, -40, 0, 2)
speedToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
speedToggle.Text = "OFF"
speedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedToggle.Font = Enum.Font.GothamBold
speedToggle.TextSize = 12
speedToggle.Parent = contentFrame
local speedToggleCorner = Instance.new("UICorner")
speedToggleCorner.CornerRadius = UDim.new(0, 10)
speedToggleCorner.Parent = speedToggle

local speedLabel = Instance.new("TextLabel")
speedLabel.Text = "Walk Speed"
speedLabel.Size = UDim2.new(0.7, 0, 0, 20)
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 14
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = contentFrame

local walkSpeedLabel = Instance.new("TextLabel")
walkSpeedLabel.Text = "Walk Speed: 16"
walkSpeedLabel.Size = UDim2.new(1, 0, 0, 20)
walkSpeedLabel.Position = UDim2.new(0, 0, 0, 30)
walkSpeedLabel.BackgroundTransparency = 1
walkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedLabel.Font = Enum.Font.Gotham
walkSpeedLabel.TextSize = 14
walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
walkSpeedLabel.Parent = contentFrame

-- WalkSpeed slider
local walkSpeedSlider = Instance.new("Frame")
walkSpeedSlider.Size = UDim2.new(1, 0, 0, 20)
walkSpeedSlider.Position = UDim2.new(0, 0, 0, 55)
walkSpeedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
walkSpeedSlider.Parent = contentFrame
local walkSpeedSliderCorner = Instance.new("UICorner")
walkSpeedSliderCorner.CornerRadius = UDim.new(0, 10)
walkSpeedSliderCorner.Parent = walkSpeedSlider

local walkSpeedFill = Instance.new("Frame")
walkSpeedFill.Size = UDim2.new(0.2, 0, 1, 0)
walkSpeedFill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
walkSpeedFill.Parent = walkSpeedSlider
local walkSpeedFillCorner = Instance.new("UICorner")
walkSpeedFillCorner.CornerRadius = UDim.new(0, 10)
walkSpeedFillCorner.Parent = walkSpeedFill

-- Headlamp toggle
local headlampToggle = Instance.new("TextButton")
headlampToggle.Size = UDim2.new(0, 40, 0, 20)
headlampToggle.Position = UDim2.new(1, -40, 0, 85)
headlampToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
headlampToggle.Text = "OFF"
headlampToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
headlampToggle.Font = Enum.Font.GothamBold
headlampToggle.TextSize = 12
headlampToggle.Parent = contentFrame
local headlampToggleCorner = Instance.new("UICorner")
headlampToggleCorner.CornerRadius = UDim.new(0, 10)
headlampToggleCorner.Parent = headlampToggle

local headlampLabel = Instance.new("TextLabel")
headlampLabel.Text = "Headlamp"
headlampLabel.Size = UDim2.new(0.7, 0, 0, 20)
headlampLabel.Position = UDim2.new(0, 0, 0, 85)
headlampLabel.BackgroundTransparency = 1
headlampLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
headlampLabel.Font = Enum.Font.Gotham
headlampLabel.TextSize = 14
headlampLabel.TextXAlignment = Enum.TextXAlignment.Left
headlampLabel.Parent = contentFrame

-- No Fog & Bright Mode toggle
local brightToggle = Instance.new("TextButton")
brightToggle.Size = UDim2.new(0, 40, 0, 20)
brightToggle.Position = UDim2.new(1, -40, 0, 115)
brightToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
brightToggle.Text = "OFF"
brightToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
brightToggle.Font = Enum.Font.GothamBold
brightToggle.TextSize = 12
brightToggle.Parent = contentFrame
local brightToggleCorner = Instance.new("UICorner")
brightToggleCorner.CornerRadius = UDim.new(0, 10)
brightToggleCorner.Parent = brightToggle

local brightLabel = Instance.new("TextLabel")
brightLabel.Text = "No Fog & Bright Mode"
brightLabel.Size = UDim2.new(0.7, 0, 0, 20)
brightLabel.Position = UDim2.new(0, 0, 0, 115)
brightLabel.BackgroundTransparency = 1
brightLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
brightLabel.Font = Enum.Font.Gotham
brightLabel.TextSize = 14
brightLabel.TextXAlignment = Enum.TextXAlignment.Left
brightLabel.Parent = contentFrame

-- GodMode toggle
local godToggle = Instance.new("TextButton")
godToggle.Size = UDim2.new(0, 40, 0, 20)
godToggle.Position = UDim2.new(1, -40, 0, 145)
godToggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
godToggle.Text = "OFF"
godToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
godToggle.Font = Enum.Font.GothamBold
godToggle.TextSize = 12
godToggle.Parent = contentFrame
local godToggleCorner = Instance.new("UICorner")
godToggleCorner.CornerRadius = UDim.new(0, 10)
godToggleCorner.Parent = godToggle

local godLabel = Instance.new("TextLabel")
godLabel.Text = "God Mode"
godLabel.Size = UDim2.new(0.7, 0, 0, 20)
godLabel.Position = UDim2.new(0, 0, 0, 145)
godLabel.BackgroundTransparency = 1
godLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
godLabel.Font = Enum.Font.Gotham
godLabel.TextSize = 14
godLabel.TextXAlignment = Enum.TextXAlignment.Left
godLabel.Parent = contentFrame

-- Infinity Jump toggle
local infinityJumpToggle = Instance.new("TextButton")
infinityJumpToggle.Size = UDim2.new(0, 40, 0, 20)
infinityJumpToggle.Position = UDim2.new(1, -40, 0, 175)
infinityJumpToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
infinityJumpToggle.Text = "OFF"
infinityJumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
infinityJumpToggle.Font = Enum.Font.GothamBold
infinityJumpToggle.TextSize = 12
infinityJumpToggle.Parent = contentFrame
local infinityJumpToggleCorner = Instance.new("UICorner")
infinityJumpToggleCorner.CornerRadius = UDim.new(0, 10)
infinityJumpToggleCorner.Parent = infinityJumpToggle

local infinityJumpLabel = Instance.new("TextLabel")
infinityJumpLabel.Text = "Infinity Jump"
infinityJumpLabel.Size = UDim2.new(0.7, 0, 0, 20)
infinityJumpLabel.Position = UDim2.new(0, 0, 0, 175)
infinityJumpLabel.BackgroundTransparency = 1
infinityJumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
infinityJumpLabel.Font = Enum.Font.Gotham
infinityJumpLabel.TextSize = 14
infinityJumpLabel.TextXAlignment = Enum.TextXAlignment.Left
infinityJumpLabel.Parent = contentFrame

-- Teleport button
local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(1, 0, 0, 30)
teleportButton.Position = UDim2.new(0, 0, 0, 205)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
teleportButton.Text = "Open Teleport Menu"
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Font = Enum.Font.GothamBold
teleportButton.TextSize = 14
teleportButton.Parent = contentFrame
local teleportButtonCorner = Instance.new("UICorner")
teleportButtonCorner.CornerRadius = UDim.new(0, 8)
teleportButtonCorner.Parent = teleportButton

-- LOGIC
local defaultWalkSpeed = 16
local maxWalkSpeed = 100
local speedEnabled = false
local headlampEnabled = false
local headlampLight
local infinityJumpEnabled = false
local infinityJumpConnection
local minimized = false
local walkSpeedLoop

-- [!] TAMBAHAN: Variabel untuk menyimpan nilai walk speed yang dipilih user
local currentWalkSpeed = defaultWalkSpeed

-- Fungsi toggle button
local function toggleButton(btn, state)
    if state then
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        btn.Text = "ON"
    else
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.Text = "OFF"
    end
end

-- Teleport menu
local teleportFrame = Instance.new("Frame")
teleportFrame.Size = UDim2.new(0, 200, 0, 150)
teleportFrame.Position = MainFrame.Position + UDim2.new(0, 300, 0, 0)
teleportFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
teleportFrame.Visible = false
teleportFrame.Parent = playerGuiUI
local teleportCorner = Instance.new("UICorner")
teleportCorner.CornerRadius = UDim.new(0, 8)
teleportCorner.Parent = teleportFrame

local scroll = Instance.new("ScrollingFrame", teleportFrame)
scroll.Size = UDim2.new(1, -10, 1, -10)
scroll.Position = UDim2.new(0, 5, 0, 5)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 5
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 5)

local function addTeleport(name, pos)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(pos)
            teleportFrame.Visible = false
        end
    end)
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 8)
end

addTeleport("Spawn", Vector3.new(0, 5, 0))
addTeleport("High Place", Vector3.new(0, 100, 0))
addTeleport("Mountain", Vector3.new(100, 50, 100))

teleportButton.MouseButton1Click:Connect(function()
    teleportFrame.Visible = not teleportFrame.Visible
end)

-- Close panel
CloseButton.MouseButton1Click:Connect(function()
    playerGuiUI:Destroy()
end)

-- Minimize
-- Minimize / Maximize
local function toggleMinimize()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 50, 0, 50), "Out", "Quad", 0.3, true)
        corner.CornerRadius = UDim.new(1, 0)
        for _, v in pairs(MainFrame:GetChildren()) do
            if v ~= sjLabel and v ~= corner then
                v.Visible = false
            end
        end
        sjLabel.Visible = true
        MinimizeButton.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 280, 0, 280), "Out", "Quad", 0.3, true)
        corner.CornerRadius = UDim.new(0, 8)
        for _, v in pairs(MainFrame:GetChildren()) do
            if v:IsA("GuiObject") then
                v.Visible = true
            end
        end
        sjLabel.Visible = false
        MinimizeButton.Text = "-"
    end
end
MinimizeButton.MouseButton1Click:Connect(toggleMinimize)
sjLabel.MouseButton1Click:Connect(toggleMinimize)

-- Drag GUI
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function setupDrag(element)
    element.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    element.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
end

setupDrag(header)
setupDrag(sjLabel)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Load modules
local modules = {
    walkspeed = "https://raw.githubusercontent.com/yourusername/yourrepo/main/walkspeed.lua",
    headlamp = "https://raw.githubusercontent.com/yourusername/yourrepo/main/headlamp.lua",
    brightmode = "https://raw.githubusercontent.com/yourusername/yourrepo/main/brightmode.lua",
    godmode = "https://raw.githubusercontent.com/yourusername/yourrepo/main/godmode.lua",
    infjump = "https://raw.githubusercontent.com/yourusername/yourrepo/main/infjump.lua"
}

local function loadModule(name, url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if success then
        result.init({
            LocalPlayer = LocalPlayer,
            RunService = RunService,
            UserInputService = UserInputService,
            Players = Players,
            toggleButton = toggleButton,
            speedToggle = speedToggle,
            headlampToggle = headlampToggle,
            brightToggle = brightToggle,
            godToggle = godToggle,
            infinityJumpToggle = infinityJumpToggle,
            walkSpeedSlider = walkSpeedSlider,
            walkSpeedFill = walkSpeedFill,
            walkSpeedLabel = walkSpeedLabel,
            defaultWalkSpeed = defaultWalkSpeed,
            maxWalkSpeed = maxWalkSpeed
        })
        return result
    else
        warn("Failed to load module " .. name .. ": " .. result)
        return nil
    end
end

-- Load all modules
local loadedModules = {}
for name, url in pairs(modules) do
    loadedModules[name] = loadModule(name, url)
end

-- Function to apply settings to character
local function applySettingsToCharacter()
    if loadedModules.walkspeed then
        loadedModules.walkspeed.applySettings(currentWalkSpeed, speedEnabled)
    end
    
    if loadedModules.headlamp and headlampEnabled then
        loadedModules.headlamp.applySettings()
    end
    
    if loadedModules.infjump and infinityJumpEnabled then
        loadedModules.infjump.applySettings()
    end
end

-- Event untuk mendeteksi ketika karakter berubah
LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid") -- tunggu humanoid siap
    applySettingsToCharacter()
end)

-- Inisialisasi
if loadedModules.walkspeed then
    loadedModules.walkspeed.applySettings(defaultWalkSpeed, false)
end
