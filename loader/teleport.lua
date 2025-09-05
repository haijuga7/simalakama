-- Teleport Module
local Teleport = {}

-- Services
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- Variabel state
Teleport.locations = {
    ["Spawn"] = Vector3.new(0, 5, 0),
    ["High Place"] = Vector3.new(0, 100, 0),
    ["Mountain"] = Vector3.new(100, 50, 100)
}

function Teleport:Initialize()
    self:CreateUI()
end

function Teleport:CreateUI()
    if not UI or not UI.contentFrame then return end
    
    -- Teleport button
    local teleportButton = Instance.new("TextButton")
    teleportButton.Size = UDim2.new(1, 0, 0, 30)
    teleportButton.Position = UDim2.new(0, 0, 0, 205)
    teleportButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    teleportButton.Text = "Open Teleport Menu"
    teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportButton.Font = Enum.Font.GothamBold
    teleportButton.TextSize = 14
    teleportButton.Parent = UI.contentFrame
    teleportButton.Name = "TeleportButton"
    local teleportButtonCorner = Instance.new("UICorner")
    teleportButtonCorner.CornerRadius = UDim.new(0, 8)
    teleportButtonCorner.Parent = teleportButton

    -- Teleport menu
    UI.teleportFrame = Instance.new("Frame")
    UI.teleportFrame.Size = UDim2.new(0, 200, 0, 150)
    UI.teleportFrame.Position = UI.MainFrame.Position + UDim2.new(0, 300, 0, 0)
    UI.teleportFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    UI.teleportFrame.Visible = false
    UI.teleportFrame.Parent = UI.playerGuiUI
    local teleportCorner = Instance.new("UICorner")
    teleportCorner.CornerRadius = UDim.new(0, 8)
    teleportCorner.Parent = UI.teleportFrame

    local scroll = Instance.new("ScrollingFrame", UI.teleportFrame)
    scroll.Size = UDim2.new(1, -10, 1, -10)
    scroll.Position = UDim2.new(0, 5, 0, 5)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 5
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 5)

    -- Tambahkan lokasi teleport
    for name, _ in pairs(self.locations) do
        self:AddTeleportLocation(name)
    end
end

function Teleport:AddTeleportLocation(name)
    local scroll = UI.teleportFrame:FindFirstChildWhichIsA("ScrollingFrame")
    if not scroll then return end
    
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Name = name .. "Button"
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 8)
end

function Teleport:TeleportTo(position)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(position)
        if UI and UI.teleportFrame then
            UI.teleportFrame.Visible = false
        end
    end
end

function Teleport:ApplySettings()
    -- Tidak ada pengaturan yang perlu diterapkan saat startup
end

return Teleport
