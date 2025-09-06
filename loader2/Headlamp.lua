-- Headlamp Module
local HeadlampModule = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local headlampEnabled = false
local headlampLight

-- UI Elements
local headlampToggle

function HeadlampModule.createUI(parent)
    -- Headlamp toggle
    print("Creating Headlamp UI...")
    headlampToggle = Instance.new("TextButton")
    headlampToggle.Size = UDim2.new(0, 40, 0, 20)
    headlampToggle.Position = UDim2.new(1, -40, 0, 85)
    headlampToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    headlampToggle.Text = "OFF"
    headlampToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    headlampToggle.Font = Enum.Font.GothamBold
    headlampToggle.TextSize = 12
    headlampToggle.Parent = parent

    local headlampLabel = Instance.new("TextLabel")
    headlampLabel.Text = "Headlamp"
    headlampLabel.Size = UDim2.new(0.7, 0, 0, 20)
    headlampLabel.Position = UDim2.new(0, 0, 0, 85)
    headlampLabel.BackgroundTransparency = 1
    headlampLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    headlampLabel.Font = Enum.Font.Gotham
    headlampLabel.TextSize = 14
    headlampLabel.TextXAlignment = Enum.TextXAlignment.Left
    headlampLabel.Parent = parent

    -- Setup interactions
    headlampToggle.MouseButton1Click:Connect(function()
        HeadlampModule.toggleHeadlamp()
    end)
    
    print("HeadLamp UI... success")
end

function HeadlampModule.toggleHeadlamp()
    headlampEnabled = not headlampEnabled
    HeadlampModule.updateButtonState()
    
    if headlampEnabled then
        HeadlampModule.createHeadlamp()
    else
        HeadlampModule.removeHeadlamp()
    end
end

function HeadlampModule.updateButtonState()
    if headlampEnabled then
        headlampToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        headlampToggle.Text = "ON"
    else
        headlampToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        headlampToggle.Text = "OFF"
    end
end

function HeadlampModule.createHeadlamp()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        local head = char.Head

        -- Hapus lampu lama kalau ada
        if head:FindFirstChild("HeadlampAttachment") then
            head.HeadlampAttachment:Destroy()
        end

        local attachment = Instance.new("Attachment")
        attachment.Name = "HeadlampAttachment"
        attachment.Parent = head
        attachment.Position = Vector3.new(0, 0.5, 0)

        headlampLight = Instance.new("PointLight")
        headlampLight.Brightness = 3
        headlampLight.Range = 20
        headlampLight.Color = Color3.fromRGB(255, 240, 200)
        headlampLight.Parent = attachment
    end
end

function HeadlampModule.removeHeadlamp()
    if headlampLight then
        headlampLight:Destroy()
        headlampLight = nil
    end
end

function HeadlampModule.reapply()
    if headlampEnabled then
        HeadlampModule.createHeadlamp()
    end
end

return HeadlampModule