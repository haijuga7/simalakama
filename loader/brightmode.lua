-- BrightMode Module
local BrightMode = {}

-- Services
local Lighting = game:GetService("Lighting")

-- Variabel state
BrightMode.enabled = false
BrightMode.connections = {}

function BrightMode:Initialize()
    self:CreateUI()
end

function BrightMode:CreateUI()
    if not UI or not UI.contentFrame then return end
    
    -- No Fog & Bright Mode toggle
    local brightToggle = Instance.new("TextButton")
    brightToggle.Size = UDim2.new(0, 40, 0, 20)
    brightToggle.Position = UDim2.new(1, -40, 0, 115)
    brightToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    brightToggle.Text = "OFF"
    brightToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    brightToggle.Font = Enum.Font.GothamBold
    brightToggle.TextSize = 12
    brightToggle.Parent = UI.contentFrame
    brightToggle.Name = "BrightToggle"
    local brightToggleCorner = Instance.new("UICorner")
    brightToggleCorner.CornerRadius = UDim.new(0, 10)
    brightToggleCorner.Parent = brightToggle

    local brightLabel = Instance.new("TextLabel")
    brightLabel.Text = "No Fog & Bright Mode"
    brightLabel.Size = UDim2.new(0.7, 0, 0, 20)
    brightLabel.Position = UDim2.new(0, 0, 0, 115)
    brightLabel.BackgroundTransparency = 1
    brightLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    brightLabel.Font = Enum.Font.Gotham
    brightLabel.TextSize = 14
    brightLabel.TextXAlignment = Enum.TextXAlignment.Left
    brightLabel.Parent = UI.contentFrame
end

function BrightMode:ToggleButton(btn, state)
    if state then
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        btn.Text = "ON"
    else
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.Text = "OFF"
    end
end

function BrightMode:ApplyBrightMode(state)
    if state then
        -- Hilangkan fog
        Lighting.FogStart = 1e6
        Lighting.FogEnd = 1e6
        -- Paksa siang hari & terang
        Lighting.ClockTime = 12
        Lighting.Brightness = 3
        Lighting.ExposureCompensation = 0.5
        Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        -- Kembalikan default (biarkan game yang atur)
        Lighting.FogStart = 0
        Lighting.FogEnd = 1000
        Lighting.ClockTime = 14
        Lighting.Brightness = 2
        Lighting.ExposureCompensation = 0
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    end
end

function BrightMode:ConnectLightingEvents()
    -- Pastikan event tidak double
    for _, c in ipairs(self.connections) do
        c:Disconnect()
    end
    self.connections = {}

    -- Kalau aktif, pantau semua properti Lighting
    if self.enabled then
        table.insert(self.connections, Lighting:GetPropertyChangedSignal("FogStart"):Connect(function()
            if self.enabled then Lighting.FogStart = 1e6 end
        end))
        table.insert(self.connections, Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
            if self.enabled then Lighting.FogEnd = 1e6 end
        end))
        table.insert(self.connections, Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
            if self.enabled then Lighting.ClockTime = 12 end
        end))
        table.insert(self.connections, Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
            if self.enabled then Lighting.Brightness = 3 end
        end))
        table.insert(self.connections, Lighting:GetPropertyChangedSignal("ExposureCompensation"):Connect(function()
            if self.enabled then Lighting.ExposureCompensation = 0.5 end
        end))
        table.insert(self.connections, Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
            if self.enabled then Lighting.Ambient = Color3.fromRGB(128, 128, 128) end
        end))
        table.insert(self.connections, Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
            if self.enabled then Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128) end
        end))
    end
end

function BrightMode:Toggle()
    self.enabled = not self.enabled
    self:ToggleButton(UI.contentFrame:FindFirstChild("BrightToggle"), self.enabled)
    self:ApplyBrightMode(self.enabled)
    self:ConnectLightingEvents()
end

function BrightMode:ApplySettings()
    if self.enabled then
        self:ApplyBrightMode(true)
        self:ConnectLightingEvents()
    end
end

return BrightMode
