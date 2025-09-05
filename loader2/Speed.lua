-- Speed.lua
return function(Utils, parent, yOffset)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer

    local defaultWalkSpeed = 16
    local maxWalkSpeed = 100
    local currentWalkSpeed = defaultWalkSpeed
    local speedEnabled = false
    local walkSpeedLoop

    local toggle, _ = Utils.createToggle(parent, "Walk Speed", yOffset)
    local slider, fill = Utils.createSlider(parent, yOffset + 30, defaultWalkSpeed, maxWalkSpeed)

    local function updateWalkSpeed(value)
        currentWalkSpeed = value
        fill.Size = UDim2.new(value/maxWalkSpeed, 0, 1, 0)

        if speedEnabled then
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
            if walkSpeedLoop then walkSpeedLoop:Disconnect() end
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = defaultWalkSpeed end
            end
        end
    end

    toggle.MouseButton1Click:Connect(function()
        speedEnabled = not speedEnabled
        Utils.toggleButton(toggle, speedEnabled)
        updateWalkSpeed(currentWalkSpeed)
    end)

    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local pos = (input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
            pos = math.clamp(pos, 0, 1)
            local newValue = math.floor(pos * maxWalkSpeed)
            updateWalkSpeed(newValue)
        end
    end)

    return function()
        if speedEnabled then updateWalkSpeed(currentWalkSpeed) end
    end
end
