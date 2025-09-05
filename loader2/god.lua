local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local God = {}
local enabled = false
local conn

function God.Setup(parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,40,0,20)
    btn.Position = UDim2.new(1,-40,0,145)
    btn.Text = "OFF"
    btn.BackgroundColor3 = Color3.fromRGB(200,0,0)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = parent

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        btn.Text = enabled and "ON" or "OFF"

        if enabled then
            conn = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health < hum.MaxHealth then
                        hum.Health = hum.MaxHealth
                    end
                end
                if LocalPlayer:FindFirstChild("Hunger") then LocalPlayer.Hunger.Value = 100 end
                if LocalPlayer:FindFirstChild("Thirst") then LocalPlayer.Thirst.Value = 100 end
            end)
        else
            if conn then conn:Disconnect() end
        end
    end)
end

return God
