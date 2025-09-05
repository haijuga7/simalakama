local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Walk = {}
local speedEnabled = false
local currentWalkSpeed = 16
local maxWalkSpeed = 100
local walkLoop

local function toggleButton(btn, state)
    btn.BackgroundColor3 = state and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    btn.Text = state and "ON" or "OFF"
end

local function updateWalkSpeed(value, label, fill)
    currentWalkSpeed = value
    if speedEnabled then
        if walkLoop then walkLoop:Disconnect() end
        walkLoop = RunService.RenderStepped:Connect(function()
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= currentWalkSpeed then
                hum.WalkSpeed = currentWalkSpeed
            end
        end)
    else
        if walkLoop then walkLoop:Disconnect() end
        walkLoop = nil
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end
    label.Text = "Walk Speed: " .. tostring(currentWalkSpeed)
    fill.Size = UDim2.new(currentWalkSpeed / maxWalkSpeed, 0, 1, 0)
end

function Walk.Setup(parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,80)
    frame.Parent = parent
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel")
    label.Text = "Walk Speed: 16"
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Size = UDim2.new(1,0,0,20)
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0,40,0,20)
    toggle.Position = UDim2.new(1,-40,0,0)
    toggle.Text = "OFF"
    toggle.BackgroundColor3 = Color3.fromRGB(200,0,0)
    toggle.TextColor3 = Color3.fromRGB(255,255,255)
    toggle.Parent = frame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1,0,0,20)
    slider.Position = UDim2.new(0,0,0,30)
    slider.BackgroundColor3 = Color3.fromRGB(80,80,80)
    slider.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0.2,0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(0,120,215)
    fill.Parent = slider

    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local pos = (input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
            pos = math.clamp(pos, 0, 1)
            local newValue = math.floor(pos * maxWalkSpeed)
            updateWalkSpeed(newValue, label, fill)
        end
    end)

    toggle.MouseButton1Click:Connect(function()
        speedEnabled = not speedEnabled
        toggleButton(toggle, speedEnabled)
        updateWalkSpeed(currentWalkSpeed, label, fill)
    end)
end

return Walk
