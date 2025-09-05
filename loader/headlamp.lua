-- Headlamp Module
local Headlamp = {}

-- Services
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- Variabel state
Headlamp.enabled = false
Headlamp.headlampLight = nil

function Headlamp:Initialize()
    self:CreateUI()
end

function Headlamp:CreateUI()
    if not UI or not UI.contentFrame then return end
    
    -- Headlamp toggle
    local headlampToggle = Instance.new("TextButton")
    headlampToggle.Size = UDim2.new(0, 40, 0, 20)
    headlampToggle.Position = UDim2.new(1, -40, 0, 85)
    headlampToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    headlampToggle.Text = "OFF"
    headlampToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    headlampToggle.Font = Enum.Font.GothamBold
    headlampToggle.TextSize = 12
    headlampToggle.Parent = UI.contentFrame
    headlampToggle.Name = "HeadlampToggle"
    local headlampToggleCorner = Instance.new("UICorner")
    headlampToggleCorner.CornerRadius = UDim.new(0, 10)
    headlampToggleCorner.Parent = headlampToggle

    local headlampLabel = Instance.new("TextLabel")
    headlampLabel.Text = "Headlamp"
    headlampLabel.Size = UDim2.new(0.7, 0, 0, 20)
    headlampLabel.Position = UDim2.new(0, 0, 0, 85)
    headlampLabel.BackgroundTransparency = 1
    headlampLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    headlampLabel.Font = Enum.Font.Gotham
    headlampLabel.TextSize = 14
    headlampLabel.TextXAlignment = Enum.TextXAlignment.Left
    headlampLabel.Parent = UI.contentFrame
end

function Headlamp:ToggleButton(btn, state)
    if state then
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        btn.Text = "ON"
    else
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.Text = "OFF"
    end
end

function Headlamp:CreateHeadlamp()
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

        self.headlampLight = Instance.new("PointLight")
        self.headlampLight.Brightness = 3
        self.headlampLight.Range = 20
        self.headlampLight.Color = Color3.fromRGB(255, 240, 200)
        self.headlampLight.Parent = attachment
    end
end

function Headlamp:RemoveHeadlamp()
    if self.headlampLight then
        self.headlampLight:Destroy()
        self.headlampLight = nil
    end
end

function Headlamp:Toggle()
    self.enabled = not self.enabled
    self:ToggleButton(UI.contentFrame:FindFirstChild("HeadlampToggle"), self.enabled)
    
    if self.enabled then
        self:CreateHeadlamp()
    else
        self:RemoveHeadlamp()
    end
end

function Headlamp:ApplySettings()
    if self.enabled then
        self:CreateHeadlamp()
    end
end

return Headlamp
