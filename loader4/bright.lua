-- brightmode.lua
local Lighting = game:GetService("Lighting")

local BrightMode = {}

function BrightMode.Initialize(SharedState)
    local contentFrame = SharedState.UI.ContentFrame
    local UI = SharedState.UI
    
    -- Create BrightMode UI elements
    local brightToggle, brightLabel = UI.CreateToggle("No Fog & Bright Mode", UDim2.new(0, 0, 0, 115), function(btn)
        SharedState.Settings.BrightMode.Enabled = not SharedState.Settings.BrightMode.Enabled
        UI.UpdateToggle(btn, SharedState.Settings.BrightMode.Enabled)
        
        BrightMode.Apply(SharedState)
        BrightMode.ConnectEvents(SharedState)
    end)
    
    -- Store UI elements in SharedState
    SharedState.Settings.BrightMode.UI = {
        Toggle = brightToggle,
        Label = brightLabel
    }
end

function BrightMode.Apply(SharedState)
    local enabled = SharedState.Settings.BrightMode.Enabled
    
    if enabled then
        -- Apply bright mode settings
        Lighting.FogStart = 1e6
        Lighting.FogEnd = 1e6
        Lighting.ClockTime = 12
        Lighting.Brightness = 3
        Lighting.ExposureCompensation = 0.5
        Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        -- Reset to default lighting
        Lighting.FogStart = 0
        Lighting.FogEnd = 1000
        Lighting.ClockTime = 14
        Lighting.Brightness = 2
        Lighting.ExposureCompensation = 0
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    end
end

function BrightMode.ConnectEvents(SharedState)
    -- Disconnect existing connections
    for _, connection in ipairs(SharedState.Settings.BrightMode.Connections) do
        connection:Disconnect()
    end
    SharedState.Settings.BrightMode.Connections = {}
    
    -- If enabled, monitor lighting properties
    if SharedState.Settings.BrightMode.Enabled then
        local connections = SharedState.Settings.BrightMode.Connections
        
        table.insert(connections, Lighting:GetPropertyChangedSignal("FogStart"):Connect(function()
            if SharedState.Settings.BrightMode.Enabled then Lighting.FogStart = 1e6 end
        end))
        
        table.insert(connections, Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
            if SharedState.Settings.BrightMode.Enabled then Lighting.FogEnd = 1e6 end
        end))
        
        table.insert(connections, Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
            if SharedState.Settings.BrightMode.Enabled then Lighting.ClockTime = 12 end
        end))
        
        table.insert(connections, Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
            if SharedState.Settings.BrightMode.Enabled then Lighting.Brightness = 3 end
        end))
        
        table.insert(connections, Lighting:GetPropertyChangedSignal("ExposureCompensation"):Connect(function()
            if SharedState.Settings.BrightMode.Enabled then Lighting.ExposureCompensation = 0.5 end
        end))
        
        table.insert(connections, Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
            if SharedState.Settings.BrightMode.Enabled then Lighting.Ambient = Color3.fromRGB(128, 128, 128) end
        end))
        
        table.insert(connections, Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
            if SharedState.Settings.BrightMode.Enabled then Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128) end
        end))
    end
end

return BrightMode
