-- GodMode Module
local GodModeModule = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local godModeEnabled = false
local godModeConnection

-- UI Elements
local godToggle

function GodModeModule.createUI(parent)
    -- GodMode toggle
    godToggle = Instance.new("TextButton")
    godToggle.Size = UDim2.new(0, 40, 0, 20)
    godToggle.Position = UDim2.new(1, -40, 0, 145)
    godToggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    godToggle.Text = "OFF"
    godToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    godToggle.Font = Enum.Font.GothamBold
    godToggle.TextSize = 12
    godToggle.Parent = parent

    local godLabel = Instance.new("TextLabel")
    godLabel.Text = "God Mode"
    godLabel.Size = UDim2.new(0.7, 0, 0, 20)
    godLabel.Position = UDim2.new(0, 0, 0, 145)
    godLabel.BackgroundTransparency = 1
    godLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    godLabel.Font = Enum.Font.Gotham
    godLabel.TextSize = 14
    godLabel.TextXAlignment = Enum.TextXAlignment.Left
    godLabel.Parent = parent

    -- Setup interactions
    godToggle.MouseButton1Click:Connect(function()
        GodModeModule.toggleGodMode()
    end)
end

function GodModeModule.toggleGodMode()
    godModeEnabled = not godModeEnabled
    GodModeModule.updateButtonState()

    if godModeEnabled then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = math.huge end

        godModeConnection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    -- Isi darah penuh terus
                    if hum.Health < hum.MaxHealth then
                        hum.Health = hum.MaxHealth
                    end
                end

                -- Tambahan: isi Hunger & Thirst terus
                if LocalPlayer:FindFirstChild("Hunger") then
                    LocalPlayer.Hunger.Value = 100
                end
                if LocalPlayer:FindFirstChild("Thirst") then
                    LocalPlayer.Thirst.Value = 100
                end
                local gui = LocalPlayer:FindFirstChild("PlayerGui")
                if gui then
                    local bar = gui:FindFirstChild("HungerAndHealthBar", true)
                    if bar and bar:FindFirstChild("Hunger") then
                        bar.Hunger.Size = UDim2.new(1, 0, 1, 0)
                    end
                end
            end
        end)
    else
        if godModeConnection then
            godModeConnection:Disconnect()
            godModeConnection = nil
        end
    end
end

function GodModeModule.updateButtonState()
    if godModeEnabled then
        godToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        godToggle.Text = "ON"
    else
        godToggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        godToggle.Text = "OFF"
    end
end

function GodModeModule.reapply()
    if godModeEnabled then
        if godModeConnection then godModeConnection:Disconnect() end
        godModeConnection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
            end
        end)
    end
end

return GodModeModule