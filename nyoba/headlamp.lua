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
        headlampLight.Brightness = 3.5
        headlampLight.Range = 35
        headlampLight.Color = Color3.fromRGB(255, 240, 200)
        headlampLight.Parent = attachment
        
        return true
    end
    return false
end

function module.removeHeadlamp()
    if headlampLight then
        headlampLight:Destroy()
        headlampLight = nil
    end
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        local head = char.Head
        if head:FindFirstChild("HeadlampAttachment") then
            head.HeadlampAttachment:Destroy()
        end
    end
end

function module.toggleHeadlamp()
    if headlampEnabled then
        -- Coba buat headlamp, jika gagal (karakter belum ada), tunggu karakter
        if not module.createHeadlamp() then
            -- Jika karakter belum ada, tunggu sampai karakter ada
            local connection
            connection = LocalPlayer.CharacterAdded:Connect(function()
                module.createHeadlamp()
                connection:Disconnect()
            end)
        end
    else
        module.removeHeadlamp()
    end
end

function module.applySettings()
    if headlampEnabled then
        -- Coba buat headlamp, jika gagal (karakter belum ada), tunggu karakter
        if not module.createHeadlamp() then
            -- Jika karakter belum ada, tunggu sampai karakter ada
            local connection
            connection = LocalPlayer.CharacterAdded:Connect(function()
                module.createHeadlamp()
                connection:Disconnect()
            end)
        end
    end
end

-- Simpan status headlampEnabled agar bisa diakses dari luar
function module.isEnabled()
    return headlampEnabled
end

function module.setEnabled(enabled)
    headlampEnabled = enabled
    toggleButton(headlampToggle, headlampEnabled)
    module.toggleHeadlamp()
end

return module
