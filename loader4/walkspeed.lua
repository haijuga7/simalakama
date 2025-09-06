-- walkspeed.lua
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local WalkSpeed = {}

function WalkSpeed.Initialize(SharedState)
    local contentFrame = SharedState.UI.ContentFrame
    local UI = SharedState.UI
    
    -- Create WalkSpeed UI elements
    local speedToggle, speedLabel = UI.CreateToggle("Walk Speed", UDim2.new(0, 0, 0, 0), function(btn)
        SharedState.Settings.WalkSpeed.Enabled = not SharedState.Settings.WalkSpeed.Enabled
        UI.UpdateToggle(btn, SharedState.Settings.WalkSpeed.Enabled)
        WalkSpeed.Update(SharedState)
    end)
    
    local walkSpeedLabel = Instance.new("TextLabel")
    walkSpeedLabel.Text = "Walk Speed: " .. SharedState.Settings.WalkSpeed.Value
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
    walkSpeedFill.Size = UDim2.new(SharedState.Settings.WalkSpeed.Value / SharedState.Settings.WalkSpeed.Max, 0, 1, 0)
    walkSpeedFill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    walkSpeedFill.Parent = walkSpeedSlider
    
    local walkSpeedFillCorner = Instance.new("UICorner")
    walkSpeedFillCorner.CornerRadius = UDim.new(0, 10)
    walkSpeedFillCorner.Parent = walkSpeedFill
    
    -- Store UI elements in SharedState
    SharedState.Settings.WalkSpeed.UI = {
        Toggle = speedToggle,
        Label = speedLabel,
        ValueLabel = walkSpeedLabel,
        Slider = walkSpeedSlider,
        Fill = walkSpeedFill
    }
    
    -- Setup slider
    walkSpeedSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local pos = (input.Position.X - walkSpeedSlider.AbsolutePosition.X) / walkSpeedSlider.AbsoluteSize.X
            pos = math.clamp(pos, 0, 1)
            local newValue = math.floor(pos * SharedState.Settings.WalkSpeed.Max)
            if newValue < 1 then newValue = 1 end
            SharedState.Settings.WalkSpeed.Value = newValue
            WalkSpeed.Update(SharedState)
        end
    end)
end

function WalkSpeed.Update(SharedState)
    local value = SharedState.Settings.WalkSpeed.Value
    local enabled = SharedState.Settings.WalkSpeed.Enabled
    
    -- Update UI
    SharedState.Settings.WalkSpeed.UI.ValueLabel.Text = "Walk Speed: " .. tostring(value)
    SharedState.Settings.WalkSpeed.UI.Fill.Size = UDim2.new(value / SharedState.Settings.WalkSpeed.Max, 0, 1, 0)
    
    -- Update functionality
    if enabled then
        -- Disconnect existing loop if any
        if SharedState.Settings.WalkSpeed.Connection then
            SharedState.Settings.WalkSpeed.Connection:Disconnect()
        end
        
        -- Create new loop
        SharedState.Settings.WalkSpeed.Connection = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed ~= value then
                    hum.WalkSpeed = value
                end
            end
        end)
    else
        -- Disconnect loop if exists
        if SharedState.Settings.WalkSpeed.Connection then
            SharedState.Settings.WalkSpeed.Connection:Disconnect()
            SharedState.Settings.WalkSpeed.Connection = nil
        end
        
        -- Reset walkspeed to default
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then 
                hum.WalkSpeed = SharedState.Settings.WalkSpeed.Default
            end
        end
    end
end

return WalkSpeed
