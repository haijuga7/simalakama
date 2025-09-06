local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Fungsi untuk membuat elemen UI
local function createLabel(parent, text, position, size)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = size or UDim2.new(0.7, 0, 0, 20)
    label.Position = position
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local function createToggle(parent, position)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = position
    toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = toggle
    
    return toggle
end

local function createSlider(parent, position)
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, 0, 0, 20)
    slider.Position = position
    slider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    slider.Parent = parent
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 10)
    sliderCorner.Parent = slider

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0.2, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    fill.Parent = slider
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 10)
    fillCorner.Parent = fill
    
    return slider, fill
end

local function createButton(parent, text, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 30)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    return button
end

-- Buat ScreenGui
local playerGuiUI = Instance.new("ScreenGui")
playerGuiUI.Name = "PlayerGuiUI"
playerGuiUI.Parent = PlayerGui
playerGuiUI.ResetOnSpawn = false
playerGuiUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame utama (diperkecil menjadi 250 lebar)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 280)
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
Title.TextSize = 14
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
MinimizeButton.TextSize = 14
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
CloseButton.TextSize = 14
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
sjLabel.TextSize = 16
sjLabel.TextScaled = true
sjLabel.Visible = false
sjLabel.Parent = MainFrame
local sjCorner = Instance.new("UICorner")
sjCorner.CornerRadius = UDim.new(1, 0)
sjCorner.Parent = sjLabel

-- Content container dengan scroll
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -40)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 240)
scrollFrame.Parent = MainFrame

-- Content frame di dalam scroll
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, 0)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = scrollFrame

-- Buat UI elements menggunakan fungsi
local speedLabel = createLabel(contentFrame, "Walk Speed", UDim2.new(0, 0, 0, 0))
local speedToggle = createToggle(contentFrame, UDim2.new(1, -40, 0, 2))

local walkSpeedLabel = createLabel(contentFrame, "Walk Speed: 16", UDim2.new(0, 0, 0, 30), UDim2.new(1, 0, 0, 20))
local walkSpeedSlider, walkSpeedFill = createSlider(contentFrame, UDim2.new(0, 0, 0, 55))

local headlampLabel = createLabel(contentFrame, "Headlamp", UDim2.new(0, 0, 0, 85))
local headlampToggle = createToggle(contentFrame, UDim2.new(1, -40, 0, 85))

local brightLabel = createLabel(contentFrame, "No Fog & Bright Mode", UDim2.new(0, 0, 0, 115))
local brightToggle = createToggle(contentFrame, UDim2.new(1, -40, 0, 115))

local godLabel = createLabel(contentFrame, "God Mode", UDim2.new(0, 0, 0, 145))
local godToggle = createToggle(contentFrame, UDim2.new(1, -40, 0, 145))

local infinityJumpLabel = createLabel(contentFrame, "Infinity Jump", UDim2.new(0, 0, 0, 175))
local infinityJumpToggle = createToggle(contentFrame, UDim2.new(1, -40, 0, 175))

local teleportButton = createButton(contentFrame, "Open Teleport Menu", UDim2.new(0, 0, 0, 205))

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
teleportFrame.Position = MainFrame.Position + UDim2.new(0, 260, 0, 0)
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
    local btn = createButton(scroll, name, UDim2.new(0, 0, 0, 0))
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    
    btn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(pos)
            teleportFrame.Visible = false
        end
    end)
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
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 280), "Out", "Quad", 0.3, true)
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
    walkspeed = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/nyoba/walkspeed.lua",
    headlamp = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/nyoba/headlamp.lua",
    brightmode = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/nyoba/brightmode.lua",
    godmode = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/nyoba/godmode.lua",
    infjump = "https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/nyoba/infjump.lua"
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
    
    if loadedModules.godmode and godModeEnabled then
        loadedModules.godmode.applySettings()
    end
    
    if loadedModules.brightmode and brightModeEnabled then
        loadedModules.brightmode.applySettings()
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
