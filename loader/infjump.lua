-- InfinityJump Module
local InfinityJump = {}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- Variabel state
InfinityJump.enabled = false
InfinityJump.connection = nil

function InfinityJump:Initialize()
    self:CreateUI()
end

function InfinityJump:CreateUI()
    if not UI or not UI.contentFrame then return end
    
    -- Infinity Jump toggle
    local infinityJumpToggle = Instance.new("TextButton")
    infinityJumpToggle.Size = UDim2.new(0, 40, 0, 20)
    infinityJumpToggle.Position = UDim2.new(1, -40, 0, 175)
    infinityJumpToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    infinityJumpToggle.Text = "OFF"
    infinityJumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    infinityJumpToggle.Font = Enum.Font.GothamBold
    infinityJumpToggle.TextSize = 12
    infinityJumpToggle.Parent = UI.contentFrame
    infinityJumpToggle.Name = "InfinityJumpToggle"
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
    infinityJumpLabel.Parent = UI.contentFrame
end

function InfinityJump:ToggleButton(btn, state)
    if state then
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        btn.Text = "ON"
    else
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.Text = "OFF"
    end
end

function InfinityJump:Toggle()
    self.enabled = not self.enabled
    self:ToggleButton(UI.contentFrame:FindFirstChild("InfinityJumpToggle"), self.enabled)
    
    if self.enabled then
        if self.connection then self.connection:Disconnect() end
        self.connection = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        if self.connection then
            self.connection:Disconnect()
            self.connection = nil
        end
    end
end

function InfinityJump:ApplySettings()
    if self.enabled then
        self:Toggle()
    end
end

return InfinityJump
