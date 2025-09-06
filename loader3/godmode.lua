-- GOD MODE MODULE
-- Mengatur kesehatan tak terbatas dan pengisian hunger/thirst

return function()
    local GodMode = {}
    local Services = _G.PlayerSettings.Services
    local Utils = _G.PlayerSettings.Modules.Utils
    
    -- Variables
    local godModeEnabled = false
    local godModeConnection
    local godToggle
    
    function GodMode.Initialize()
        local contentFrame = _G.PlayerSettings.GUI.ContentFrame
        if not contentFrame then
            warn("GUI ContentFrame not found for GodMode module")
            return
        end
        
        -- God mode toggle button
        godToggle = Utils.createToggleButton(
            contentFrame,
            UDim2.new(1, -40, 0, 145),
            "OFF"
        )
        
        -- Make button red untuk indicate power
        godToggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        
        -- God mode label
        local godLabel = Utils.createLabel(
            contentFrame,
            UDim2.new(0, 0, 0, 145),
            "God Mode",
            UDim2.new(0.7, 0, 0, 20)
        )
        
        -- Connect events
        godToggle.MouseButton1Click:Connect(GodMode.toggle)
        
        print("⚡ God Mode Module Initialized")
    end
    
    function GodMode.applyGodMode()
        -- Set initial health to max
        local hum = Utils.getHumanoid()
        if hum then 
            hum.Health = hum.MaxHealth
            -- Set to very high value untuk "infinite" health
            hum.MaxHealth = math.huge
            hum.Health = math.huge
        end
        
        -- Start monitoring loop
        if godModeConnection then godModeConnection:Disconnect() end
        godModeConnection = Services.RunService.Stepped:Connect(function()
            local char = Utils.getCharacter()
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    -- Keep health full
                    if hum.Health < hum.MaxHealth then
                        hum.Health = hum.MaxHealth
                    end
                    -- Ensure max health stays high
                    if hum.MaxHealth < 1000 then
                        hum.MaxHealth = math.huge
                        hum.Health = math.huge
                    end
                end
                
                -- Keep hunger and thirst full (if exists)
                local player = Services.LocalPlayer
                if player:FindFirstChild("Hunger") and player.Hunger.Value < 100 then
                    player.Hunger.Value = 100
                end
                if player:FindFirstChild("Thirst") and player.Thirst.Value < 100 then
                    player.Thirst.Value = 100
                end
                
                -- Update GUI hunger bar (if exists)
                local gui = player:FindFirstChild("PlayerGui")
                if gui then
                    local bar = gui:FindFirstChild("HungerAndHealthBar", true)
                    if bar and bar:FindFirstChild("Hunger") then
                        bar.Hunger.Size = UDim2.new(1, 0, 1, 0)
                    end
                    if bar and bar:FindFirstChild("Thirst") then
                        bar.Thirst.Size = UDim2.new(1, 0, 1, 0)
                    end
                end
            end
        end)
        
        print("⚡ God Mode activated - Infinite health & resources")
    end
    
    function GodMode.removeGodMode()
        -- Stop monitoring
        if godModeConnection then
            godModeConnection:Disconnect()
            godModeConnection = nil
        end
        
        -- Reset health to normal
        local hum = Utils.getHumanoid()
        if hum then
            hum.MaxHealth = 100
            hum.Health = 100
        end
        
        print("⚡ God Mode deactivated")
    end
    
    function GodMode.toggle()
        godModeEnabled = not godModeEnabled
        Utils.toggleButton(godToggle, godModeEnabled)
        
        if godModeEnabled then
            GodMode.applyGodMode()
        else
            GodMode.removeGodMode()
        end
    end
    
    function GodMode.onCharacterAdded()
        -- Re-apply god mode when character respawns
        if godModeEnabled then
            wait(0.2) -- Wait for humanoid to be ready
            GodMode.applyGodMode()
        end
    end
    
    function GodMode.getState()
        return {
            enabled = godModeEnabled
        }
    end
    
    function GodMode.setState(state)
        godModeEnabled = state.enabled or false
        if godToggle then
            Utils.toggleButton(godToggle, godModeEnabled)
        end
        
        if godModeEnabled then
            GodMode.applyGodMode()
        else
            GodMode.removeGodMode()
        end
    end
    
    function GodMode.cleanup()
        GodMode.removeGodMode()
    end
    
    -- Connect to character respawn
    Services.LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid")
        GodMode.onCharacterAdded()
    end)
    
    return GodMode
end
