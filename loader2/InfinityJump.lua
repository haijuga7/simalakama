-- InfinityJump Module
local InfinityJumpModule = {}
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local infinityJumpEnabled = false
local infinityJumpConnection

-- UI Elements
local infinityJumpToggle

function InfinityJumpModule.createUI(parent)
    -- Infinity Jump toggle
    print("Creating InfinityJump UI...")
    infinityJumpToggle = Instance.new("TextButton")
    infinityJumpToggle.Size = UDim2.new(0, 40, 0, 20)
    infinityJumpToggle.Position = UDim2.new(1, -40, 0, 175)
    infinityJumpToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    infinityJumpToggle.Text = "OFF"
    infinityJumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    infinityJumpToggle.Font = Enum.Font.GothamBold
    infinityJumpToggle.TextSize = 12
    infinityJumpToggle.Parent = parent

    local infinityJumpLabel = Instance.new("TextLabel")
    infinityJumpLabel.Text = "Infinity Jump"
    infinityJumpLabel.Size = UDim2.new(0.7, 0, 0, 20)
    infinityJumpLabel.Position = UDim2.new(0, 0, 0, 175)
    infinityJumpLabel.BackgroundTransparency = 1
    infinityJumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infinityJumpLabel.Font = Enum.Font.Gotham
    infinityJumpLabel.TextSize = 14
    infinityJumpLabel.TextXAlignment = Enum.TextXAlignment.Left
    infinityJumpLabel.Parent = parent

    -- Setup interactions
    infinityJumpToggle.MouseButton1Click:Connect(function()
        InfinityJumpModule.toggleInfinityJump()
    end)
    print("InfinityJump UI... success")
end

function InfinityJumpModule.toggleInfinityJump()
    infinityJumpEnabled = not infinityJumpEnabled
    InfinityJumpModule.updateButtonState()
    
    if infinityJumpEnabled then
        if infinityJumpConnection then infinityJumpConnection:Disconnect() end
        infinityJumpConnection = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        if infinityJumpConnection then
            infinityJumpConnection:Disconnect()
            infinityJumpConnection = nil
        end
    end
end

function InfinityJumpModule.updateButtonState()
    if infinityJumpEnabled then
        infinityJumpToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        infinityJumpToggle.Text = "ON"
    else
        infinityJumpToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        infinityJumpToggle.Text = "OFF"
    end
end

function InfinityJumpModule.reapply()
    if infinityJumpEnabled then
        if infinityJumpConnection then infinityJumpConnection:Disconnect() end
        infinityJumpConnection = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end

return InfinityJumpModule