-- godmode.lua
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local GodMode = {}

function GodMode.Initialize(SharedState)
    local contentFrame = SharedState.UI.ContentFrame
    local UI = SharedState.UI
    
    -- Create GodMode UI elements
    local godToggle, godLabel = UI.CreateToggle("God Mode", UDim2.new(0, 0, 0, 145), function(btn)
        SharedState.Settings.GodMode.Enabled = not SharedState.Settings.GodMode.Enabled
        UI.UpdateToggle(btn, SharedState.Settings.GodMode.Enabled)
        
        GodMode.Toggle(SharedState)
    end)
    
    -- Store UI elements in SharedState
    SharedState.Settings.GodMode.UI = {
        Toggle = godToggle,
        Label = godLabel
    }
end

function GodMode.Toggle(SharedState)
    local enabled = SharedState.Settings.GodMode.Enabled
    
    if enabled then
        -- Apply god mode
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = math.huge end
        end
        
        -- Create connection to maintain god mode
        if SharedState.Settings.GodMode.Connection then
            SharedState.Settings.GodMode.Connection:Disconnect()
        end
        
        SharedState.Settings.GodMode.Connection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    -- Keep health full
                    if hum.Health < hum.MaxHealth then
                        hum.Health = hum.MaxHealth
                    end
                end
                
                -- Fill hunger and thirst if they exist
                if LocalPlayer:FindFirstChild("Hunger") then
                    LocalPlayer.Hunger.Value = 100
                end
                
                if LocalPlayer:FindFirstChild("Thirst") then
                    LocalPlayer.Thirst.Value = 100
                end
                
                -- Update UI elements if they exist
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
        -- Disable god mode
        if SharedState.Settings.GodMode.Connection then
            SharedState.Settings.GodMode.Connection:Disconnect()
            SharedState.Settings.GodMode.Connection = nil
        end
    end
end

return GodMode
