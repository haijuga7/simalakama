local module = {}

local LocalPlayer, toggleButton, headlampToggle
local headlampEnabled = false
local headlampLight

function module.init(config)
    LocalPlayer = config.LocalPlayer
    toggleButton = config.toggleButton
    headlampToggle = config.headlampToggle
    
    -- Toggle Headlamp
    headlampToggle.MouseButton1Click:Connect(function()
        headlampEnabled = not headlampEnabled
        toggleButton(headlampToggle, headlampEnabled)
        module.toggleHeadlamp()
    end)
end

function module.createHeadlamp()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        local head = char.Head

        -- Hapus lampu lama kalau ada
        if head:FindFirstChild("HeadlampAttachment") then
            head.HeadlampAttachment:Destroy()
        end

        local attachment = Instance.new("Attachment")
        attachment.Name = "HeadlampAttachment"
        attachment.Parent = head
        attachment.Position = Vector3.new(0, 0.5, 0)

        headlampLight = Instance.new("PointLight")
        headlampLight.Brightness = 3
        headlampLight.Range = 20
        headlampLight.Color = Color3.fromRGB(255, 240, 200)
        headlampLight.Parent = attachment
    end
end

function module.removeHeadlamp()
    if headlampLight then
        headlampLight:Destroy()
        headlampLight = nil
    end
end

function module.toggleHeadlamp()
    if headlampEnabled then
        module.createHeadlamp()
    else
        module.removeHeadlamp()
    end
end

function module.applySettings()
    if headlampEnabled then
        module.createHeadlamp()
    end
end

return module
