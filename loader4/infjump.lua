-- infinityjump.lua
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local InfinityJump = {}

function InfinityJump.Initialize(SharedState)
    local contentFrame = SharedState.UI.ContentFrame
    local UI = SharedState.UI
    
    -- Create InfinityJump UI elements
    local jumpToggle, jumpLabel = UI.CreateToggle("Infinity Jump", UDim2.new(0, 0, 0, 175), function(btn)
        SharedState.Settings.InfinityJump.Enabled = not SharedState.Settings.InfinityJump.Enabled
        UI.UpdateToggle(btn, SharedState.Settings.InfinityJump.Enabled)
        
        InfinityJump.Toggle(SharedState)
    end)
    
    -- Store UI elements in SharedState
    SharedState.Settings.InfinityJump.UI = {
        Toggle = jumpToggle,
        Label = jumpLabel
    }
end

function InfinityJump.Toggle(SharedState)
    local enabled = SharedState.Settings.InfinityJump.Enabled
    
    -- Disconnect existing connection if any
    if SharedState.Settings.InfinityJump.Connection then
        SharedState.Settings.InfinityJump.Connection:Disconnect()
        SharedState.Settings.InfinityJump.Connection = nil
    end
    
    if enabled then
        -- Create new connection for infinity jump
        SharedState.Settings.InfinityJump.Connection = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end

return InfinityJump
