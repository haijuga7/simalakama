local Teleport = {}

function Teleport.Setup(parent, playerGuiUI, mainFrame)
    local teleportButton = Instance.new("TextButton")
    teleportButton.Size = UDim2.new(1,0,0,30)
    teleportButton.Position = UDim2.new(0,0,0,205)
    teleportButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
    teleportButton.Text = "Teleport"
    teleportButton.TextColor3 = Color3.fromRGB(255,255,255)
    teleportButton.Parent = parent

    local teleportFrame = Instance.new("Frame")
    teleportFrame.Size = UDim2.new(0,200,0,150)
    teleportFrame.Position = mainFrame.Position + UDim2.new(0,300,0,0)
    teleportFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
    teleportFrame.Visible = false
    teleportFrame.Parent = playerGuiUI

    local scroll = Instance.new("ScrollingFrame", teleportFrame)
    scroll.Size = UDim2.new(1,-10,1,-10)
    scroll.Position = UDim2.new(0,5,0,5)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 5
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,5)

    local function addTeleport(name, pos)
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(1,0,0,30)
        btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.MouseButton1Click:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(pos)
                teleportFrame.Visible = false
            end
        end)
    end

    addTeleport("Spawn", Vector3.new(0,5,0))
    addTeleport("High Place", Vector3.new(0,100,0))
    addTeleport("Mountain", Vector3.new(100,50,100))

    teleportButton.MouseButton1Click:Connect(function()
        teleportFrame.Visible = not teleportFrame.Visible
    end)
end

return Teleport
