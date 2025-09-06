local module = {}

local LocalPlayer, RunService, toggleButton, godToggle
local godModeEnabled = false
local godModeConnection

function module.init(config)
    LocalPlayer = config.LocalPlayer
    RunService = config.RunService
    toggleButton = config.toggleButton
    godToggle = config.godToggle
    
    -- Toggle God Mode
    godToggle.MouseButton1Click:Connect(function()
        godModeEnabled = not godModeEnabled
        toggleButton(godToggle, godModeEnabled)
        module.toggleGodMode()
    end)
end

function module.toggleGodMode()
    if godModeEnabled then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Health = math.huge end

        godModeConnection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    -- Isi darah penuh terus
                    if hum.Health < hum.MaxHealth then
                        hum.Health = hum.MaxHealth
                    end
                end

                -- Tambahan: isi Hunger & Thirst terus
                if LocalPlayer:FindFirstChild("Hunger") then
                    LocalPlayer.Hunger.Value = 100
                end
                if LocalPlayer:FindFirstChild("Thirst") then
                    LocalPlayer.Thirst.Value = 100
                end
                local gui = LocalPlayer:FindFirstChild("PlayerGui")
                if gui then
                    local bar = gui:FindFirstChild("HungerAndHealthBar", true)
                    if bar and bar:FindFirstChild("Hunger") then
                        bar.Hunger.Size = UDim2.new(1, 0, 1, 0)
                    end
                end
            end
        end)
    else
        if godModeConnection then
            godModeConnection:Disconnect()
            godModeConnection = nil
        end
    end
end

function module.applySettings()
    if godModeEnabled then
        module.toggleGodMode()
    end
end

return module
