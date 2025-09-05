-- InfinityJump.lua
return function(Utils, parent, yOffset)
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local LocalPlayer = Players.LocalPlayer

    local jumpEnabled = false
    local connection
    local toggle, _ = Utils.createToggle(parent, "Infinity Jump", yOffset)

    local function enableJump()
        connection = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    end

    toggle.MouseButton1Click:Connect(function()
        jumpEnabled = not jumpEnabled
        Utils.toggleButton(toggle, jumpEnabled)
        if jumpEnabled then enableJump() else if connection then connection:Disconnect() connection=nil end end
    end)

    return function()
        if jumpEnabled and not connection then enableJump() end
    end
end
