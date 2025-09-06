-- INFINITY JUMP MODULE
-- Memungkinkan lompat tanpa batas

return function()
    local InfinityJump = {}
    local Services = _G.PlayerSettings.Services
    local Utils = _G.PlayerSettings.Modules.Utils
    
    -- Variables
    local infinityJumpEnabled = false
    local infinityJumpConnection
    local infinityJumpToggle
    
    function InfinityJump.Initialize()
        local contentFrame = _G.PlayerSettings.GUI.ContentFrame
        if not contentFrame then
            warn("GUI ContentFrame not found for InfinityJump module")
            return
        end
        
        -- Infinity jump toggle button
        infinityJumpToggle = Utils.createToggleButton(
            contentFrame,
            UDim2.new(1, -40, 0, 175),
            "OFF"
        )
        
        -- Infinity jump label
        local infinityJumpLabel = Utils.createLabel(
            contentFrame,
            UDim2.new(0, 0, 0, 175),
            "Infinity Jump",
            UDim2.new(0.7, 0, 0, 20)
        )
        
        -- Connect events
        infinityJumpToggle.MouseButton1Click:Connect(InfinityJump.toggle)
        
        print("🦘 Infinity Jump Module Initialized")
    end
    
    function InfinityJump.enableInfinityJump()
        -- Disconnect existing connection if any
        if infinityJumpConnection then infinityJumpConnection:Disconnect() end
        
        -- Connect to jump request
        infinityJumpConnection = Services.UserInputService.JumpRequest:Connect(function()
            local char = Utils.getCharacter()
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    -- Force jump state
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
        
        print("🦘 Infinity Jump enabled")
    end
    
    function InfinityJump.disableInfinityJump()
        if infinityJumpConnection then
            infinityJumpConnection:Disconnect()
            infinityJumpConnection = nil
        end
        
        print("🦘 Infinity Jump disabled")
    end
    
    function InfinityJump.toggle()
        infinityJumpEnabled = not infinityJumpEnabled
        Utils.toggleButton(infinityJumpToggle, infinityJumpEnabled)
        
        if infinityJumpEnabled then
            InfinityJump.enableInfinityJump()
        else
            InfinityJump.disableInfinityJump()
        end
    end
    
    function InfinityJump.onCharacterAdded()
        -- Re-enable infinity jump when character respawns
        if infinityJumpEnabled then
            wait(0.1) -- Small delay untuk ensure humanoid is ready
            InfinityJump.enableInfinityJump()
        end
    end
    
    function InfinityJump.getState()
        return {
            enabled = infinityJumpEnabled
        }
    end
    
    function InfinityJump.setState(state)
        infinityJumpEnabled = state.enabled or false
        if infinityJumpToggle then
            Utils.toggleButton(infinityJumpToggle, infinityJumpEnabled)
        end
        
        if infinityJumpEnabled then
            InfinityJump.enableInfinityJump()
        else
            InfinityJump.disableInfinityJump()
        end
    end
    
    function InfinityJump.cleanup()
        InfinityJump.disableInfinityJump()
    end
    
    -- Connect to character respawn
    Services.LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid")
        InfinityJump.onCharacterAdded()
    end)
    
    return InfinityJump
end
