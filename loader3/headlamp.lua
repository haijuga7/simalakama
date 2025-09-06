-- HEADLAMP MODULE
-- Mengatur lampu kepala karakter

return function()
    local Headlamp = {}
    local Services = _G.PlayerSettings.Services
    local Utils = _G.PlayerSettings.Modules.Utils
    
    -- Variables
    local headlampEnabled = false
    local headlampLight
    local headlampToggle
    
    function Headlamp.Initialize()
        local contentFrame = _G.PlayerSettings.GUI.ContentFrame
        if not contentFrame then
            warn("GUI ContentFrame not found for Headlamp module")
            return
        end
        
        -- Headlamp toggle button
        headlampToggle = Utils.createToggleButton(
            contentFrame,
            UDim2.new(1, -40, 0, 85),
            "OFF"
        )
        
        -- Headlamp label
        local headlampLabel = Utils.createLabel(
            contentFrame,
            UDim2.new(0, 0, 0, 85),
            "Headlamp",
            UDim2.new(0.7, 0, 0, 20)
        )
        
        -- Connect events
        headlampToggle.MouseButton1Click:Connect(Headlamp.toggle)
        
        print("💡 Headlamp Module Initialized")
    end
    
    function Headlamp.createHeadlamp()
        local char = Utils.getCharacter()
        if char and char:FindFirstChild("Head") then
            local head = char.Head
            
            -- Hapus lampu lama kalau ada
            if head:FindFirstChild("HeadlampAttachment") then
                head.HeadlampAttachment:Destroy()
            end
            
            -- Buat attachment baru
            local attachment = Instance.new("Attachment")
            attachment.Name = "HeadlampAttachment"
            attachment.Parent = head
            attachment.Position = Vector3.new(0, 0.5, 0)
            
            -- Buat point light
            headlampLight = Instance.new("PointLight")
            headlampLight.Brightness = 3
            headlampLight.Range = 20
            headlampLight.Color = Color3.fromRGB(255, 240, 200)
            headlampLight.Parent = attachment
            
            print("💡 Headlamp created")
        end
    end
    
    function Headlamp.removeHeadlamp()
        local char = Utils.getCharacter()
        if char and char:FindFirstChild("Head") then
            local head = char.Head
            if head:FindFirstChild("HeadlampAttachment") then
                head.HeadlampAttachment:Destroy()
            end
        end
        
        if headlampLight then
            headlampLight = nil
        end
        
        print("💡 Headlamp removed")
    end
    
    function Headlamp.toggle()
        headlampEnabled = not headlampEnabled
        Utils.toggleButton(headlampToggle, headlampEnabled)
        
        if headlampEnabled then
            Headlamp.createHeadlamp()
        else
            Headlamp.removeHeadlamp()
        end
    end
    
    function Headlamp.onCharacterAdded()
        -- Re-create headlamp when character respawns
        if headlampEnabled then
            wait(0.2) -- Wait for head to be ready
            Headlamp.createHeadlamp()
        end
    end
    
    function Headlamp.getState()
        return {
            enabled = headlampEnabled
        }
    end
    
    function Headlamp.setState(state)
        headlampEnabled = state.enabled or false
        if headlampToggle then
            Utils.toggleButton(headlampToggle, headlampEnabled)
        end
        
        if headlampEnabled then
            Headlamp.createHeadlamp()
        else
            Headlamp.removeHeadlamp()
        end
    end
    
    -- Connect to character respawn
    Services.LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Head")
        Headlamp.onCharacterAdded()
    end)
    
    return Headlamp
end
