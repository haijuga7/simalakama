-- BRIGHT MODE MODULE
-- Mengatur pencahayaan terang dan menghilangkan fog

return function()
    local BrightMode = {}
    local Services = _G.PlayerSettings.Services
    local Utils = _G.PlayerSettings.Modules.Utils
    
    -- Variables
    local brightModeEnabled = false
    local brightConnections = {}
    local brightToggle
    
    -- Default lighting values untuk restore
    local defaultLighting = {
        FogStart = 0,
        FogEnd = 1000,
        ClockTime = 14,
        Brightness = 2,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(0, 0, 0),
        OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    }
    
    function BrightMode.Initialize()
        local contentFrame = _G.PlayerSettings.GUI.ContentFrame
        if not contentFrame then
            warn("GUI ContentFrame not found for BrightMode module")
            return
        end
        
        -- Bright mode toggle button
        brightToggle = Utils.createToggleButton(
            contentFrame,
            UDim2.new(1, -40, 0, 115),
            "OFF"
        )
        
        -- Bright mode label
        local brightLabel = Utils.createLabel(
            contentFrame,
            UDim2.new(0, 0, 0, 115),
            "No Fog & Bright Mode",
            UDim2.new(0.7, 0, 0, 20)
        )
        
        -- Connect events
        brightToggle.MouseButton1Click:Connect(BrightMode.toggle)
        
        print("🌅 Bright Mode Module Initialized")
    end
    
    function BrightMode.applyBrightMode(state)
        local Lighting = Services.Lighting
        
        if state then
            -- Apply bright settings
            Lighting.FogStart = 1e6
            Lighting.FogEnd = 1e6
            Lighting.ClockTime = 12
            Lighting.Brightness = 3
            Lighting.ExposureCompensation = 0.5
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            print("🌅 Bright mode applied")
        else
            -- Restore default settings
            Lighting.FogStart = defaultLighting.FogStart
            Lighting.FogEnd = defaultLighting.FogEnd
            Lighting.ClockTime = defaultLighting.ClockTime
            Lighting.Brightness = defaultLighting.Brightness
            Lighting.ExposureCompensation = defaultLighting.ExposureCompensation
            Lighting.Ambient = defaultLighting.Ambient
            Lighting.OutdoorAmbient = defaultLighting.OutdoorAmbient
            print("🌅 Lighting restored to default")
        end
    end
    
    function BrightMode.connectLightingEvents()
        -- Cleanup existing connections
        brightConnections = Utils.cleanupConnections(brightConnections)
        
        if brightModeEnabled then
            local Lighting = Services.Lighting
            
            -- Monitor lighting properties dan force nilai bright mode
            table.insert(brightConnections, Lighting:GetPropertyChangedSignal("FogStart"):Connect(function()
                if brightModeEnabled then 
                    Lighting.FogStart = 1e6 
                end
            end))
            
            table.insert(brightConnections, Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
                if brightModeEnabled then 
                    Lighting.FogEnd = 1e6 
                end
            end))
            
            table.insert(brightConnections, Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
                if brightModeEnabled then 
                    Lighting.ClockTime = 12 
                end
            end))
            
            table.insert(brightConnections, Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
                if brightModeEnabled then 
                    Lighting.Brightness = 3 
                end
            end))
            
            table.insert(brightConnections, Lighting:GetPropertyChangedSignal("ExposureCompensation"):Connect(function()
                if brightModeEnabled then 
                    Lighting.ExposureCompensation = 0.5 
                end
            end))
            
            table.insert(brightConnections, Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
                if brightModeEnabled then 
                    Lighting.Ambient = Color3.fromRGB(128, 128, 128) 
                end
            end))
            
            table.insert(brightConnections, Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
                if brightModeEnabled then 
                    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128) 
                end
            end))
            
            print("🌅 Lighting event monitors connected")
        end
    end
    
    function BrightMode.toggle()
        brightModeEnabled = not brightModeEnabled
        Utils.toggleButton(brightToggle, brightModeEnabled)
        BrightMode.applyBrightMode(brightModeEnabled)
        BrightMode.connectLightingEvents()
    end
    
    function BrightMode.getState()
        return {
            enabled = brightModeEnabled
        }
    end
    
    function BrightMode.setState(state)
        brightModeEnabled = state.enabled or false
        if brightToggle then
            Utils.toggleButton(brightToggle, brightModeEnabled)
        end
        BrightMode.applyBrightMode(brightModeEnabled)
        BrightMode.connectLightingEvents()
    end
    
    function BrightMode.cleanup()
        brightConnections = Utils.cleanupConnections(brightConnections)
        BrightMode.applyBrightMode(false)
        print("🌅 Bright Mode cleaned up")
    end
    
    -- Auto-cleanup when module is destroyed
    game:GetService("Players").PlayerRemoving:Connect(function(player)
        if player == Services.LocalPlayer then
            BrightMode.cleanup()
        end
    end)
    
    return BrightMode
end
