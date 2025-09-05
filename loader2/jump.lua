local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Jump = {}
local enabled = false
local conn

function Jump.Setup(parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,40,0,20)
    btn.Position = UDim2.new(1,-40,0,175)
    btn.Text = "OFF"
    btn.BackgroundColor3 = Color3.fromRGB(200,0,0)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = parent

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        btn.Text = enabled and "ON" or "OFF"

        if enabled then
            conn = UserInputService.JumpRequest:Connect(function()
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if conn then conn:Disconnect() end
        end
    end)
end

return Jump
