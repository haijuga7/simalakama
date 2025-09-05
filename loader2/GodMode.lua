-- GodMode.lua
return function(Utils, parent, yOffset)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer

    local godEnabled = false
    local connection
    local toggle, _ = Utils.createToggle(parent, "God Mode", yOffset)

    local function enableGod()
        connection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.Health = hum.MaxHealth end
                if LocalPlayer:FindFirstChild("Hunger") then LocalPlayer.Hunger.Value = 100 end
                if LocalPlayer:FindFirstChild("Thirst") then LocalPlayer.Thirst.Value = 100 end
            end
        end)
    end

    toggle.MouseButton1Click:Connect(function()
        godEnabled = not godEnabled
        Utils.toggleButton(toggle, godEnabled)
        if godEnabled then enableGod() else if connection then connection:Disconnect() connection=nil end end
    end)

    return function()
        if godEnabled and not connection then enableGod() end
    end
end
