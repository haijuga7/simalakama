-- headlamp.lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Headlamp = {}

function Headlamp.Initialize(SharedState)
    local contentFrame = SharedState.UI.ContentFrame
    local UI = SharedState.UI
    
    -- Create Headlamp UI elements
    local headlampToggle, headlampLabel = UI.CreateToggle("Headlamp", UDim2.new(0, 0, 0, 85), function(btn)
        SharedState.Settings.Headlamp.Enabled = not SharedState.Settings.Headlamp.Enabled
        UI.UpdateToggle(btn, SharedState.Settings.Headlamp.Enabled)
        
        if SharedState.Settings.Headlamp.Enabled then
            Headlamp.Create(SharedState)
        else
            Headlamp.Remove(SharedState)
        end
    end)
    
    -- Store UI elements in SharedState
    SharedState.Settings.Headlamp.UI = {
        Toggle = headlampToggle,
        Label = headlampLabel
    }
end

function Headlamp.Create(SharedState)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        local head = char.Head
        
        -- Remove existing headlamp if any
        if head:FindFirstChild("HeadlampAttachment") then
            head.HeadlampAttachment:Destroy()
        end
        
        -- Create new headlamp
        local attachment = Instance.new("Attachment")
        attachment.Name = "HeadlampAttachment"
        attachment.Parent = head
        attachment.Position = Vector3.new(0, 0.5, 0)
        
        local light = Instance.new("PointLight")
        light.Brightness = 3
        light.Range = 20
        light.Color = Color3.fromRGB(255, 240, 200)
        light.Parent = attachment
        
        SharedState.Settings.Headlamp.Light = light
    end
end

function Headlamp.Remove(SharedState)
    if SharedState.Settings.Headlamp.Light then
        local light = SharedState.Settings.Headlamp.Light
        if light.Parent and light.Parent.Parent then
            light.Parent:Destroy()
        end
        SharedState.Settings.Headlamp.Light = nil
    end
end

return Headlamp
