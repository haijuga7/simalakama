local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Daftar posisi teleport (ganti dengan posisi yang Anda inginkan)
local teleportPositions = {
    Vector3.new(-419.4, 191.3, 557.0),
    Vector3.new(-626.6, 578.3, 1137.4),
    Vector3.new(-899.6, 689.7, 1224.3),
    Vector3.new(-386.7, 1041.0, 2044.6),
    Vector3.new(-753.9,1525.0,2057.5),
    Vector3.new(-480.6, 1633.0, 2283.2,
    Vector3.new(-86.4, 1929.0, 2113.9),
    Vector3.new(4.1, 2493.0, 2043.8),
}

-- Delay untuk setiap teleport (dalam detik)
local teleportDelays = {
    60,
    60,
    60,
    10,
    10,
    5,
    5,
    1
    
}

-- Variabel kontrol
local isTeleporting = false
local teleportCoroutine = nil

-- Membuat GUI
local teleportGui = Instance.new("ScreenGui")
teleportGui.Name = "TeleportGUI"
teleportGui.Parent = PlayerGui
teleportGui.ResetOnSpawn = false

-- Frame utama
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 120)
mainFrame.Position = UDim2.new(0, 100, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = teleportGui

-- Membuat sudut membulat
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Header untuk drag functionality
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.BorderSizePixel = 0
header.Parent = mainFrame

-- Sudut membulat untuk header
local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

-- Judul
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "Teleport Controller"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = header

-- Toggle untuk teleport
local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(0.8, 0, 0, 30)
toggleFrame.Position = UDim2.new(0.1, 0, 0, 40)
toggleFrame.BackgroundTransparency = 1
toggleFrame.Parent = mainFrame

local toggleLabel = Instance.new("TextLabel")
toggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
toggleLabel.BackgroundTransparency = 1
toggleLabel.Text = "Auto Teleport:"
toggleLabel.Font = Enum.Font.Gotham
toggleLabel.TextSize = 12
toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleLabel.Parent = toggleFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.3, 0, 0.7, 0)
toggleButton.Position = UDim2.new(0.65, 0, 0.15, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
toggleButton.Text = "OFF"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 12
toggleButton.Parent = toggleFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Tombol Rejoin
local rejoinButton = Instance.new("TextButton")
rejoinButton.Size = UDim2.new(0.8, 0, 0, 30)
rejoinButton.Position = UDim2.new(0.1, 0, 0, 80)
rejoinButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
rejoinButton.Text = "Rejoin"
rejoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinButton.Font = Enum.Font.GothamBold
rejoinButton.TextSize = 12
rejoinButton.Parent = mainFrame

local rejoinCorner = Instance.new("UICorner")
rejoinCorner.CornerRadius = UDim.new(0, 8)
rejoinCorner.Parent = rejoinButton

-- Fungsi untuk auto respawn
local function autoRespawn()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
    end
    wait(3) -- Tunggu respawn
end

-- Fungsi untuk rejoin
local function rejoinGame()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end

-- Fungsi untuk teleport
local function teleportToPosition(position)
    local character = LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(position)
        end
    end
end

-- Fungsi utama teleport loop
local function startTeleportLoop()
    isTeleporting = true
    toggleButton.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
    toggleButton.Text = "ON"
    
    teleportCoroutine = coroutine.create(function()
        while isTeleporting do
            wait(60)
            for i, position in ipairs(teleportPositions) do
                if not isTeleporting then break end
                
                -- Teleport ke posisi
                teleportToPosition(position)
                
                -- Tunggu delay yang ditentukan
                wait(teleportDelays[i] or 1)
                
                -- Jika ini adalah teleport terakhir, lakukan auto respawn
                if i == #teleportPositions and isTeleporting then
                    autoRespawn()
                end
            end
        end
    end)
    
    coroutine.resume(teleportCoroutine)
end

-- Fungsi untuk menghentikan teleport loop
local function stopTeleportLoop()
    isTeleporting = false
    toggleButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    toggleButton.Text = "OFF"
end

-- Toggle button functionality
toggleButton.MouseButton1Click:Connect(function()
    if isTeleporting then
        stopTeleportLoop()
    else
        startTeleportLoop()
    end
end)

-- Rejoin button functionality
rejoinButton.MouseButton1Click:Connect(function()
    rejoinGame()
end)

-- Drag functionality
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Cleanup ketika GUI dihapus
teleportGui.AncestryChanged:Connect(function()
    if teleportGui.Parent == nil then
        stopTeleportLoop()
    end
end)
