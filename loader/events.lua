-- Events Module
local Events = {}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

function Events:Initialize()
    self:ConnectUIEvents()
    self:ConnectCharacterEvents()
end

function Events:ConnectUIEvents()
    -- Toggle Speed
    local speedToggle = UI.contentFrame:FindFirstChild("SpeedToggle")
    if speedToggle then
        speedToggle.MouseButton1Click:Connect(function()
            WalkSpeed:Toggle()
        end)
    end

    -- WalkSpeed slider
    local walkSpeedSlider = UI.contentFrame:FindFirstChild("WalkSpeedSlider")
    if walkSpeedSlider then
        walkSpeedSlider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                local pos = (input.Position.X - walkSpeedSlider.AbsolutePosition.X) / walkSpeedSlider.AbsoluteSize.X
                pos = math.clamp(pos, 0, 1)
                local newValue = math.floor(pos * WalkSpeed.maxWalkSpeed)
                WalkSpeed:UpdateWalkSpeed(newValue)
            end
        end)
    end

    -- Toggle Headlamp
    local headlampToggle = UI.contentFrame:FindFirstChild("HeadlampToggle")
    if headlampToggle then
        headlampToggle.MouseButton1Click:Connect(function()
            Headlamp:Toggle()
        end)
    end

    -- Toggle Bright Mode
    local brightToggle = UI.contentFrame:FindFirstChild("BrightToggle")
    if brightToggle then
        brightToggle.MouseButton1Click:Connect(function()
            BrightMode:Toggle()
        end)
    end

    -- Toggle God Mode
    local godToggle = UI.contentFrame:FindFirstChild("GodToggle")
    if godToggle then
        godToggle.MouseButton1Click:Connect(function()
            GodMode:Toggle()
        end)
    end

    -- Toggle Infinity Jump
    local infinityJumpToggle = UI.contentFrame:FindFirstChild("InfinityJumpToggle")
    if infinityJumpToggle then
        infinityJumpToggle.MouseButton1Click:Connect(function()
            InfinityJump:Toggle()
        end)
    end

    -- Teleport button
    local teleportButton = UI.contentFrame:FindFirstChild("TeleportButton")
    if teleportButton then
        teleportButton.MouseButton1Click:Connect(function()
            UI.teleportFrame.Visible = not UI.teleportFrame.Visible
        end)
    end

    -- Teleport locations
    local teleportFrame = UI.teleportFrame
    if teleportFrame then
        local scroll = teleportFrame:FindFirstChildWhichIsA("ScrollingFrame")
        if scroll then
            for _, button in ipairs(scroll:GetChildren()) do
                if button:IsA("TextButton") then
                    button.MouseButton1Click:Connect(function()
                        local position = Teleport.locations[button.Text]
                        if position then
                            Teleport:TeleportTo(position)
                        end
                    end)
                end
            end
        end
    end

    -- Close panel
    local closeButton = UI.MainFrame:FindFirstChild("CloseButton")
    if closeButton then
        closeButton.MouseButton1Click:Connect(function()
            UI.playerGuiUI:Destroy()
        end)
    end

    -- Minimize
    local minimizeButton = UI.MainFrame:FindFirstChild("MinimizeButton")
    if minimizeButton then
        minimizeButton.MouseButton1Click:Connect(function()
            UI:ToggleMinimize()
        end)
    end

    local sjLabel = UI.MainFrame:FindFirstChild("SJLabel")
    if sjLabel then
        sjLabel.MouseButton1Click:Connect(function()
            UI:ToggleMinimize()
        end)
    end
end

function Events:ConnectCharacterEvents()
    -- Event untuk mendeteksi ketika karakter berubah
    LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid") -- tunggu humanoid siap

        -- WalkSpeed tetap dipaksa
        WalkSpeed:ApplySettings()

        -- Buat ulang headlamp kalau ON
        Headlamp:ApplySettings()

        -- Re-apply infinity jump kalau aktif
        InfinityJump:ApplySettings()

        -- Re-apply god mode kalau aktif
        GodMode:ApplySettings()
    end)
end

return Events
