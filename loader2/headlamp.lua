local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Headlamp = {}
local enabled = false
local lamp

function Headlamp.Setup(parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,40,0,20)
    btn.Position = UDim2.new(1,-40,0,85)
    btn.Text = "OFF"
    btn.BackgroundColor3 = Color3.fromRGB(200,0,0)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = parent

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        btn.Text = enabled and "ON" or "OFF"

        if enabled then
            local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
            if head then
                local att = Instance.new("Attachment", head)
                lamp = Instance.new("PointLight", att)
                lamp.Brightness = 3
                lamp.Range = 20
                lamp.Color = Color3.fromRGB(255,240,200)
            end
        elseif lamp then
            lamp:Destroy()
            lamp = nil
        end
    end)
end

return Headlamp
