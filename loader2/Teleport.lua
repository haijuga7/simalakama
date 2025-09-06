-- Teleport Module
local TeleportModule = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function TeleportModule.createUI(parent, mainFrame, screenGui)
    -- Teleport button
    local teleportButton = Instance.new("TextButton")
    teleportButton.Size = UDim2.new(1, 0, 0, 30)
    teleportButton.Position = UDim2.new(0, 0, 0, 205)
    teleportButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    teleportButton.Text = "Open Teleport Menu"
    teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportButton.Font = Enum.Font.GothamBold
    teleportButton.TextSize = 14
    teleportButton.Parent = parent

    -- Teleport menu
    local teleportFrame = Instance.new("Frame")
    teleportFrame.Size = UDim2.new(0, 200, 0, 150)
    teleportFrame.Position = mainFrame.Position + UDim2.new(0, 300, 0, 0)
    teleportFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    teleportFrame.Visible = false
    teleportFrame.Parent = screenGui

    local scroll = Instance.new("ScrollingFrame", teleportFrame)
    scroll.Size = UDim2.new(1, -10, 1, -10)
    scroll.Position = UDim2.new(0, 5, 0, 5)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 5
    
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 5)

    -- Teleport locations
    local teleportLocations = {
        {name = "Spawn", position = Vector3.new(0, 5, 0)},
        {name = "High Place", position = Vector3.new(0, 100, 0)},
        {name = "Mountain", position = Vector3.new(100, 50, 100)}
    }

    -- Add teleport buttons
    for _, location in ipairs(teleportLocations) do
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        btn.Text = location.name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.MouseButton1Click:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(location.position)
                teleportFrame.Visible = false
            end
        end)
    end

    -- Toggle teleport menu
    teleportButton.MouseButton1Click:Connect(function()
        teleportFrame.Visible = not teleportFrame.Visible
    end)
end

return TeleportModule