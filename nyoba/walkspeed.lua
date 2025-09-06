local module = {}

local LocalPlayer, RunService, toggleButton, speedToggle, walkSpeedSlider, walkSpeedFill, walkSpeedLabel
local defaultWalkSpeed, maxWalkSpeed
local walkSpeedLoop
local currentWalkSpeed = 16
local speedEnabled = false

function module.init(config)
    LocalPlayer = config.LocalPlayer
    RunService = config.RunService
    toggleButton = config.toggleButton
    speedToggle = config.speedToggle
    walkSpeedSlider = config.walkSpeedSlider
    walkSpeedFill = config.walkSpeedFill
    walkSpeedLabel = config.walkSpeedLabel
    defaultWalkSpeed = config.defaultWalkSpeed
    maxWalkSpeed = config.maxWalkSpeed
    
    -- Setup slider
    walkSpeedSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local pos = (input.Position.X - walkSpeedSlider.AbsolutePosition.X) / walkSpeedSlider.AbsoluteSize.X
            pos = math.clamp(pos, 0, 1)
            local newValue = math.floor(pos * maxWalkSpeed)
            module.updateWalkSpeed(newValue)
        end
    end)
    
    -- Toggle Speed
    speedToggle.MouseButton1Click:Connect(function()
        speedEnabled = not speedEnabled
        toggleButton(speedToggle, speedEnabled)
        module.updateWalkSpeed(currentWalkSpeed)
    end)
end

function module.updateWalkSpeed(value)
    currentWalkSpeed = value
    
    if speedEnabled then
        -- Looping agar selalu paksa WalkSpeed
        if walkSpeedLoop then walkSpeedLoop:Disconnect() end
        walkSpeedLoop = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed ~= currentWalkSpeed then
                    hum.WalkSpeed = currentWalkSpeed
                end
            end
        end)
    else
        -- Kalau OFF, kembalikan normal & stop loop
        if walkSpeedLoop then
            walkSpeedLoop:Disconnect()
            walkSpeedLoop = nil
        end
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = defaultWalkSpeed end
        end
    end
    
    -- Update UI
    walkSpeedLabel.Text = "Walk Speed: " .. tostring(currentWalkSpeed)
    walkSpeedFill.Size = UDim2.new(currentWalkSpeed / maxWalkSpeed, 0, 1, 0)
end

function module.applySettings(value, enabled)
    currentWalkSpeed = value or currentWalkSpeed
    speedEnabled = enabled or speedEnabled
    toggleButton(speedToggle, speedEnabled)
    module.updateWalkSpeed(currentWalkSpeed)
end

return module
