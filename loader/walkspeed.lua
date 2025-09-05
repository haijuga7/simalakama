-- WalkSpeed Module
local WalkSpeed = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Variabel state
WalkSpeed.enabled = false
WalkSpeed.walkSpeedLoop = nil

-- Nilai default
WalkSpeed.defaultWalkSpeed = 16
WalkSpeed.maxWalkSpeed = 100
WalkSpeed.currentWalkSpeed = WalkSpeed.defaultWalkSpeed

function WalkSpeed:Initialize()
    self:CreateUI()
end

function WalkSpeed:CreateUI()
    if not UI or not UI.contentFrame then return end
    
    -- Toggle Speed
    local speedToggle = Instance.new("TextButton")
    speedToggle.Size = UDim2.new(0, 40, 0, 20)
    speedToggle.Position = UDim2.new(1, -40, 0, 2)
    speedToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    speedToggle.Text = "OFF"
    speedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedToggle.Font = Enum.Font.GothamBold
    speedToggle.TextSize = 12
    speedToggle.Parent = UI.contentFrame
    speedToggle.Name = "SpeedToggle"
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
    speedLabel.Parent = UI.contentFrame

    local walkSpeedLabel = Instance.new("TextLabel")
    walkSpeedLabel.Text = "Walk Speed: 16"
    walkSpeedLabel.Size = UDim2.new(1, 0, 0, 20)
    walkSpeedLabel.Position = UDim2.new(0, 0, 0, 30)
    walkSpeedLabel.BackgroundTransparency = 1
    walkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkSpeedLabel.Font = Enum.Font.Gotham
    walkSpeedLabel.TextSize = 14
    walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    walkSpeedLabel.Parent = UI.contentFrame
    walkSpeedLabel.Name = "WalkSpeedLabel"

    -- WalkSpeed slider
    local walkSpeedSlider = Instance.new("Frame")
    walkSpeedSlider.Size = UDim2.new(1, 0, 0, 20)
    walkSpeedSlider.Position = UDim2.new(0, 0, 0, 55)
    walkSpeedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    walkSpeedSlider.Parent = UI.contentFrame
    walkSpeedSlider.Name = "WalkSpeedSlider"
    local walkSpeedSliderCorner = Instance.new("UICorner")
    walkSpeedSliderCorner.CornerRadius = UDim.new(0, 10)
    walkSpeedSliderCorner.Parent = walkSpeedSlider

    local walkSpeedFill = Instance.new("Frame")
    walkSpeedFill.Size = UDim2.new(0.2, 0, 1, 0)
    walkSpeedFill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    walkSpeedFill.Parent = walkSpeedSlider
    walkSpeedFill.Name = "WalkSpeedFill"
    local walkSpeedFillCorner = Instance.new("UICorner")
    walkSpeedFillCorner.CornerRadius = UDim.new(0, 10)
    walkSpeedFillCorner.Parent = walkSpeedFill
end

function WalkSpeed:ToggleButton(btn, state)
    if state then
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        btn.Text = "ON"
    else
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.Text = "OFF"
    end
end

function WalkSpeed:UpdateWalkSpeed(value)
    self.currentWalkSpeed = math.clamp(value, 0, self.maxWalkSpeed)
    
    if self.enabled then
        -- Looping agar selalu paksa WalkSpeed
        if self.walkSpeedLoop then self.walkSpeedLoop:Disconnect() end
        self.walkSpeedLoop = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed ~= self.currentWalkSpeed then
                    hum.WalkSpeed = self.currentWalkSpeed
                end
            end
        end)
    else
        -- Kalau OFF, kembalikan normal & stop loop
        if self.walkSpeedLoop then
            self.walkSpeedLoop:Disconnect()
            self.walkSpeedLoop = nil
        end
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = self.defaultWalkSpeed end
        end
    end
    
    -- Update UI
    if UI and UI.contentFrame then
        local walkSpeedLabel = UI.contentFrame:FindFirstChild("WalkSpeedLabel")
        if walkSpeedLabel then
            walkSpeedLabel.Text = "Walk Speed: " .. tostring(self.currentWalkSpeed)
        end
        
        local walkSpeedFill = UI.contentFrame:FindFirstChild("WalkSpeedFill")
        if walkSpeedFill then
            walkSpeedFill.Size = UDim2.new(self.currentWalkSpeed / self.maxWalkSpeed, 0, 1, 0)
        end
    end
end

function WalkSpeed:Toggle()
    self.enabled = not self.enabled
    self:ToggleButton(UI.contentFrame:FindFirstChild("SpeedToggle"), self.enabled)
    self:UpdateWalkSpeed(self.currentWalkSpeed)
end

function WalkSpeed:ApplySettings()
    self:UpdateWalkSpeed(self.currentWalkSpeed)
end

return WalkSpeed
