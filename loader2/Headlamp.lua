-- Headlamp.lua
return function(Utils, parent, yOffset)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local headlampEnabled = false
    local headlampLight

    local toggle, _ = Utils.createToggle(parent, "Headlamp", yOffset)

    local function createHeadlamp()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Head") then
            local head = char.Head
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

    local function removeHeadlamp()
        if headlampLight then
            headlampLight:Destroy()
            headlampLight = nil
        end
    end

    toggle.MouseButton1Click:Connect(function()
        headlampEnabled = not headlampEnabled
        Utils.toggleButton(toggle, headlampEnabled)
        if headlampEnabled then createHeadlamp() else removeHeadlamp() end
    end)

    return function()
        if headlampEnabled then createHeadlamp() end
    end
end
