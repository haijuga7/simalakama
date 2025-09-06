-- WALKSPEED MODULE
-- Mengatur kecepatan jalan karakter

return function()
    local WalkSpeed = {}
    local Services = _G.PlayerSettings.Services
    local Utils = _G.PlayerSettings.Modules.Utils
    
    -- Variables
    local defaultWalkSpeed = 16
    local maxWalkSpeed = 100
    local speedEnabled = false
    local currentWalkSpeed = defaultWalkSpeed
    local walkSpeedLoop
    
    -- UI Elements
    local speedToggle
    local walkSpeedLabel
    local walkSpeedSlider
    local walkSpeedFill
    
    function WalkSpeed.Initialize()
        local contentFrame = _G.PlayerSettings.GUI.ContentFrame
        if not contentFrame then
            warn("GUI ContentFrame not found for WalkSpeed module")
            return
        end
        
        -- Speed toggle button
        speedToggle = Utils.createToggleButton(
            contentFrame, 
            UDim2.new(1, -40, 0, 2),
            "OFF"
        )
        
        -- Speed label
        local speedLabel = Utils.createLabel(
            contentFrame,
            UDim2.new(0, 0, 0, 0),
            "Walk Speed",
            UDim2.new(0.7, 0, 0, 20)
        )
        
        -- Walk speed value label
        walkSpeedLabel = Utils.createLabel(
            contentFrame,
            UDim2.new(0, 0, 0, 30),
            "Walk Speed: " .. currentWalkSpeed,
            UDim2.new(1, 0, 0, 20)
        )
        
        -- Walk speed slider background
        walkSpeedSlider = Instance.new("Frame")
        walkSpeedSlider.Size = UDim2.new(1, 0, 0, 20)
        walkSpeedSlider.Position = UDim2.new(0, 0, 0, 55)
        walkSpeedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        walkSpeedSlider.Parent = contentFrame
        Utils.createCorner(walkSpeedSlider, 10)
        
        -- Walk speed slider fill
        walkSpeedFill = Instance.new("Frame")
        walkSpeedFill.Size = UDim2.new(currentWalkSpeed / maxWalkSpeed, 0, 1, 0)
        walkSpeedFill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        walkSpeedFill.Parent = walkSpeedSlider
        Utils.createCorner(walkSpeedFill, 10)
        
        -- Connect events
        speedToggle.MouseButton1Click:Connect(WalkSpeed.toggleSpeed)
        walkSpeedSlider.InputBegan:Connect(WalkSpeed.handleSliderInput)
        
        print("👟 WalkSpeed Module Initialized")
    end
    
    function WalkSpeed.updateWalkSpeed(value)
        currentWalkSpeed = math.clamp(value, 1, maxWalkSpeed)
        
        if speedEnabled then
            -- Loop untuk mempertahankan speed
            if walkSpeedLoop then walkSpeedLoop:Disconnect() end
            walkSpeedLoop = Services.RunService.RenderStepped:Connect(function()
                local hum = Utils.getHumanoid()
                if hum and hum.WalkSpeed ~= currentWalkSpeed then
                    hum.WalkSpeed = currentWalkSpeed
                end
            end)
        else
            -- Kembalikan ke normal
            if walkSpeedLoop then
                walkSpeedLoop:Disconnect()
                walkSpeedLoop = nil
            end
            local hum = Utils.getHumanoid()
            if hum then hum.WalkSpeed = defaultWalkSpeed end
        end
        
        -- Update UI
        if walkSpeedLabel then
            walkSpeedLabel.Text = "Walk Speed: " .. tostring(currentWalkSpeed)
        end
        if walkSpeedFill then
            walkSpeedFill.Size = UDim2.new(currentWalkSpeed / maxWalkSpeed, 0, 1, 0)
        end
    end
    
    function WalkSpeed.toggleSpeed()
        speedEnabled = not speedEnabled
        Utils.toggleButton(speedToggle, speedEnabled)
        WalkSpeed.updateWalkSpeed(currentWalkSpeed)
    end
    
    function WalkSpeed.handleSliderInput(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local pos = (input.Position.X - walkSpeedSlider.AbsolutePosition.X) / walkSpeedSlider.AbsoluteSize.X
            pos = math.clamp(pos, 0, 1)
            local newValue = math.floor(pos * maxWalkSpeed)
            if newValue < 1 then newValue = 1 end
            WalkSpeed.updateWalkSpeed(newValue)
        end
    end
    
    function WalkSpeed.onCharacterAdded()
        -- Re-apply walk speed settings when character respawns
        WalkSpeed.updateWalkSpeed(currentWalkSpeed)
    end
    
    function WalkSpeed.getState()
        return {
            enabled = speedEnabled,
            value = currentWalkSpeed
        }
    end
    
    function WalkSpeed.setState(state)
        speedEnabled = state.enabled or false
        currentWalkSpeed = state.value or defaultWalkSpeed
        if speedToggle then
            Utils.toggleButton(speedToggle, speedEnabled)
        end
        WalkSpeed.updateWalkSpeed(currentWalkSpeed)
    end
    
    -- Connect to character respawn
    Services.LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid")
        wait(0.1)
        WalkSpeed.onCharacterAdded()
    end)
    
    -- Initialize with default values
    WalkSpeed.updateWalkSpeed(defaultWalkSpeed)
    
    return WalkSpeed
end
