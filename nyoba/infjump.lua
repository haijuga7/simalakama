local module = {}

local LocalPlayer, UserInputService, toggleButton, infinityJumpToggle
local infinityJumpEnabled = false
local infinityJumpConnection

function module.init(config)
    LocalPlayer = config.LocalPlayer
    UserInputService = config.UserInputService
    toggleButton = config.toggleButton
    infinityJumpToggle = config.infinityJumpToggle
    
    -- Toggle Infinity Jump
    infinityJumpToggle.MouseButton1Click:Connect(function()
        infinityJumpEnabled = not infinityJumpEnabled
        toggleButton(infinityJumpToggle, infinityJumpEnabled)
        module.toggleInfinityJump()
    end)
end

function module.toggleInfinityJump()
    if infinityJumpEnabled then
        if infinityJumpConnection then infinityJumpConnection:Disconnect() end
        infinityJumpConnection = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        if infinityJumpConnection then
            infinityJumpConnection:Disconnect()
            infinityJumpConnection = nil
        end
    end
end

function module.applySettings()
    if infinityJumpEnabled then
        module.toggleInfinityJump()
    end
end

return module
