-- BrightMode Module
local BrightModeModule = {}
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local brightModeEnabled = false
local brightConnections = {}

-- UI Elements
local brightToggle

function BrightModeModule.createUI(parent)
    -- Bright Mode toggle
    brightToggle = Instance.new("TextButton")
    brightToggle.Size = UDim2.new(0, 40, 0, 20)
    brightToggle.Position = UDim2.new(1, -40, 0, 115)
    brightToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    brightToggle.Text = "OFF"
    brightToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    brightToggle.Font = Enum.Font.GothamBold
    brightToggle.TextSize = 12
    brightToggle.Parent = parent

    local brightLabel = Instance.new("TextLabel")
    brightLabel.Text = "No Fog & Bright Mode"
    brightLabel.Size = UDim2.new(0.7, 0, 0, 20)
    brightLabel.Position = UDim2.new(0, 0, 0, 115)
    brightLabel.BackgroundTransparency = 1
    brightLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    brightLabel.Font = Enum.Font.Gotham
    brightLabel.TextSize = 14
    brightLabel.TextXAlignment = Enum.TextXAlignment.Left
    brightLabel.Parent = parent

    -- Setup interactions
    brightToggle.MouseButton1Click:Connect(function()
        BrightModeModule.toggleBrightMode()
    end)
end

function BrightModeModule.toggleBrightMode()
    brightModeEnabled = not brightModeEnabled
    BrightModeModule.updateButtonState()
    BrightModeModule.applyBrightMode(brightModeEnabled)
    BrightModeModule.connectLightingEvents()
end

function BrightModeModule.updateButtonState()
    if brightModeEnabled then
        brightToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        brightToggle.Text = "ON"
    else
        brightToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        brightToggle.Text = "OFF"
    end
end

function BrightModeModule.applyBrightMode(state)
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

function BrightModeModule.connectLightingEvents()
    -- Pastikan event tidak double
    for _, c in ipairs(brightConnections) do
        c:Disconnect()
    end
    brightConnections = {}

    -- Kalau aktif, pantau semua properti Lighting
    if brightModeEnabled then
        table.insert(brightConnections, Lighting:GetPropertyChangedSignal("FogStart"):Connect(function()
            if brightModeEnabled then Lighting.FogStart = 1e6 end
        end))
        table.insert(brightConnections, Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
            if brightModeEnabled then Lighting.FogEnd = 1e6 end
        end))
        table.insert(brightConnections, Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
            if brightModeEnabled then Lighting.ClockTime = 12 end
        end))
        table.insert(brightConnections, Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
            if brightModeEnabled then Lighting.Brightness = 3 end
        end))
        table.insert(brightConnections, Lighting:GetPropertyChangedSignal("ExposureCompensation"):Connect(function()
            if brightModeEnabled then Lighting.ExposureCompensation = 0.5 end
        end))
        table.insert(brightConnections, Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
            if brightModeEnabled then Lighting.Ambient = Color3.fromRGB(128, 128, 128) end
        end))
        table.insert(brightConnections, Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
            if brightModeEnabled then Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128) end
        end))
    end
end

function BrightModeModule.reapply()
    if brightModeEnabled then
        BrightModeModule.applyBrightMode(true)
        BrightModeModule.connectLightingEvents()
    end
end

return BrightModeModule