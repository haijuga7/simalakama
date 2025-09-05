-- Bright.lua
return function(Utils, parent, yOffset)
    local Lighting = game:GetService("Lighting")
    local brightModeEnabled = false
    local connections = {}

    local toggle, _ = Utils.createToggle(parent, "No Fog & Bright", yOffset)

    local function apply(state)
        if state then
            Lighting.FogStart = 1e6
            Lighting.FogEnd = 1e6
            Lighting.ClockTime = 12
            Lighting.Brightness = 3
            Lighting.ExposureCompensation = 0.5
        else
            Lighting.FogStart = 0
            Lighting.FogEnd = 1000
            Lighting.ClockTime = 14
            Lighting.Brightness = 2
            Lighting.ExposureCompensation = 0
        end
    end

    local function connectEvents()
        for _,c in ipairs(connections) do c:Disconnect() end
        connections = {}
        if brightModeEnabled then
            table.insert(connections, Lighting:GetPropertyChangedSignal("FogStart"):Connect(function() if brightModeEnabled then Lighting.FogStart = 1e6 end end))
        end
    end

    toggle.MouseButton1Click:Connect(function()
        brightModeEnabled = not brightModeEnabled
        Utils.toggleButton(toggle, brightModeEnabled)
        apply(brightModeEnabled)
        connectEvents()
    end)

    return function()
        if brightModeEnabled then apply(true) connectEvents() end
    end
end
