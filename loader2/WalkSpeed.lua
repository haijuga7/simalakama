-- WalkSpeed Module
local WalkSpeedModule = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local speedEnabled = false
local currentWalkSpeed = 16
local maxWalkSpeed = 100
local defaultWalkSpeed = 16
local walkSpeedLoop

-- UI Elements
local speedToggle, walkSpeedLabel, walkSpeedSlider, walkSpeedFill

function WalkSpeedModule.createUI(parent)
    -- Toggle Speed
    print("Creating WalkSpeed UI...")
    speedToggle = Instance.new("TextButton")
    speedToggle.Size = UDim2.new(0, 40, 0, 20)
    speedToggle.Position = UDim2.new(1, -40, 0, 2)
    speedToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    speedToggle.Text = "OFF"
    speedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedToggle.Font = Enum.Font.GothamBold
    speedToggle.TextSize = 12
    speedToggle.Parent = parent

    local speedLabel = Instance.new("TextLabel")
    speedLabel.Text = "Walk Speed"
    speedLabel.Size = UDim2.new(0.7, 0, 0, 20)
    speedLabel.Position = UDim2.new(0, 0, 0, 0)
    speedLabel.BackgroundTransparency = 1
    speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedLabel.Font = Enum.Font.Gotham
    speedLabel.TextSize = 14
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    speedLabel.Parent = parent

    walkSpeedLabel = Instance.new("TextLabel")
    walkSpeedLabel.Text = "Walk Speed: 16"
    walkSpeedLabel.Size = UDim2.new(1, 0, 0, 20)
    walkSpeedLabel.Position = UDim2.new(0, 0, 0, 30)
    walkSpeedLabel.BackgroundTransparency = 1
    walkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkSpeedLabel.Font = Enum.Font.Gotham
    walkSpeedLabel.TextSize = 14
    walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    walkSpeedLabel.Parent = parent

    -- WalkSpeed slider
    walkSpeedSlider = Instance.new("Frame")
    walkSpeedSlider.Size = UDim2.new(1, 0, 0, 20)
    walkSpeedSlider.Position = UDim2.new(0, 0, 0, 55)
    walkSpeedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    walkSpeedSlider.Parent = parent

    walkSpeedFill = Instance.new("Frame")
    walkSpeedFill.Size = UDim2.new(0.2, 0, 1, 0)
    walkSpeedFill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    walkSpeedFill.Parent = walkSpeedSlider

    -- Setup interactions
    speedToggle.MouseButton1Click:Connect(function()
        WalkSpeedModule.toggleSpeed()
    end)

    walkSpeedSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local pos = (input.Position.X - walkSpeedSlider.AbsolutePosition.X) / walkSpeedSlider.AbsoluteSize.X
            pos = math.clamp(pos, 0, 1)
            local newValue = math.floor(pos * maxWalkSpeed)
            WalkSpeedModule.updateWalkSpeed(newValue)
        end
    end)
    print("WalkSpeed UI... success")
end

function WalkSpeedModule.toggleSpeed()
    speedEnabled = not speedEnabled
    WalkSpeedModule.updateButtonState()
    WalkSpeedModule.updateWalkSpeed(currentWalkSpeed)
end

function WalkSpeedModule.updateButtonState()
    if speedEnabled then
        speedToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        speedToggle.Text = "ON"
    else
        speedToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        speedToggle.Text = "OFF"
    end
end

function WalkSpeedModule.updateWalkSpeed(value)
    currentWalkSpeed = value
    
    if speedEnabled then
        -- Looping agar selalu paksa WalkSpeed
        if walkSpeedLoop then walkSpeedLoop:Disconnect() end
        walkSpeedLoop = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed ~= currentWalkSpeed then
                    hum.WalkSpeed = currentWalkSpeed
                end
            end
        end)
    else
        -- Kalau OFF, kembalikan normal & stop loop
        if walkSpeedLoop then
            walkSpeedLoop:Disconnect()
            walkSpeedLoop = nil
        end
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = defaultWalkSpeed end
        end
    end
    
    -- Update UI
    walkSpeedLabel.Text = "Walk Speed: " .. tostring(currentWalkSpeed)
    walkSpeedFill.Size = UDim2.new(currentWalkSpeed / maxWalkSpeed, 0, 1, 0)
end

function WalkSpeedModule.reapply()
    if speedEnabled then
        WalkSpeedModule.updateWalkSpeed(currentWalkSpeed)
    end
end

return WalkSpeedModule