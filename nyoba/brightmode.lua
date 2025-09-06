local module = {}

local Lighting = game:GetService("Lighting")
local toggleButton, brightToggle
local brightModeEnabled = false
local brightConnections = {}

function module.init(config)
    toggleButton = config.toggleButton
    brightToggle = config.brightToggle
    
    -- Toggle Bright Mode
    brightToggle.MouseButton1Click:Connect(function()
        brightModeEnabled = not brightModeEnabled
        toggleButton(brightToggle, brightModeEnabled)
        module.toggleBrightMode()
    end)
end

function module.applyBrightMode(state)
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

function module.connectLightingEvents()
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

function module.toggleBrightMode()
    module.applyBrightMode(brightModeEnabled)
    module.connectLightingEvents()
end

function module.applySettings()
    if brightModeEnabled then
        module.toggleBrightMode()
    end
end

return module
