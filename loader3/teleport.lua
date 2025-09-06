-- TELEPORT MODULE
-- Menyediakan menu teleport ke berbagai lokasi

return function()
    local Teleport = {}
    local Services = _G.PlayerSettings.Services
    local Utils = _G.PlayerSettings.Modules.Utils
    
    -- Variables
    local teleportButton
    local teleportFrame
    local teleportLocations = {
        {name = "Spawn", position = Vector3.new(0, 5, 0)},
        {name = "High Place", position = Vector3.new(0, 100, 0)},
        {name = "Mountain", position = Vector3.new(100, 50, 100)},
        {name = "Sky", position = Vector3.new(0, 200, 0)},
        {name = "Underground", position = Vector3.new(0, -50, 0)}
    }
    
    function Teleport.Initialize()
        local contentFrame = _G.PlayerSettings.GUI.ContentFrame
        if not contentFrame then
            warn("GUI ContentFrame not found for Teleport module")
            return
        end
        
        -- Teleport button
        teleportButton = Instance.new("TextButton")
        teleportButton.Size = UDim2.new(1, 0, 0, 30)
        teleportButton.Position = UDim2.new(0, 0, 0, 205)
        teleportButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        teleportButton.Text = "Open Teleport Menu"
        teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        teleportButton.Font = Enum.Font.GothamBold
        teleportButton.TextSize = 14
        teleportButton.Parent = contentFrame
        Utils.createCorner(teleportButton, 8)
        
        -- Create teleport menu
        Teleport.createTeleportMenu()
        
        -- Connect events
        teleportButton.MouseButton1Click:Connect(Teleport.toggleMenu)
        
        print("🌐 Teleport Module Initialized")
    end
    
    function Teleport.createTeleportMenu()
        local screenGui = _G.PlayerSettings.GUI.ScreenGui
        local mainFrame = _G.PlayerSettings.GUI.MainFrame
        
        if not screenGui or not mainFrame then
            warn("GUI components not found for teleport menu")
            return
        end
        
        -- Teleport frame
        teleportFrame = Instance.new("Frame")
        teleportFrame.Size = UDim2.new(0, 200, 0, 200)
        teleportFrame.Position = mainFrame.Position + UDim2.new(0, 300, 0, 0)
        teleportFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        teleportFrame.Visible = false
        teleportFrame.Parent = screenGui
        Utils.createCorner(teleportFrame, 8)
        
        -- Title bar
        local titleBar = Instance.new("Frame")
        titleBar.Size = UDim2.new(1, 0, 0, 30)
        titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        titleBar.BorderSizePixel = 0
        titleBar.Parent = teleportFrame
        Utils.createCorner(titleBar, 8)
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Text = "Teleport Locations"
        titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
        titleLabel.Position = UDim2.new(0, 10, 0, 0)
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 14
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = titleBar
        
        -- Close button for teleport menu
        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0, 25, 0, 25)
        closeBtn.Position = UDim2.new(1, -30, 0, 2.5)
        closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        closeBtn.Text = "X"
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.TextSize = 12
        closeBtn.Parent = titleBar
        Utils.createCorner(closeBtn, 12)
        closeBtn.MouseButton1Click:Connect(function()
            teleportFrame.Visible = false
        end)
        
        -- Scrolling frame for teleport buttons
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Size = UDim2.new(1, -10, 1, -40)
        scrollFrame.Position = UDim2.new(0, 5, 0, 35)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.ScrollBarThickness = 8
        scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        scrollFrame.Parent = teleportFrame
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 5)
        layout.Parent = scrollFrame
        
        -- Add teleport buttons
        for i, location in ipairs(teleportLocations) do
            Teleport.addTeleportButton(scrollFrame, location.name, location.position)
        end
        
        -- Update canvas size
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
        end)
    end
    
    function Teleport.addTeleportButton(parent, name, position)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.Parent = parent
        Utils.createCorner(btn, 8)
        
        -- Hover effect
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end)
        
        -- Teleport functionality
        btn.MouseButton1Click:Connect(function()
            Teleport.teleportTo(position)
            teleportFrame.Visible = false
        end)
        
        return btn
    end
    
    function Teleport.teleportTo(position)
        local char = Utils.getCharacter()
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(position)
            print("🌐 Teleported to:", position)
        else
            warn("Cannot teleport: Character or HumanoidRootPart not found")
        end
    end
    
    function Teleport.toggleMenu()
        if teleportFrame then
            teleportFrame.Visible = not teleportFrame.Visible
        end
    end
    
    function Teleport.addLocation(name, position)
        table.insert(teleportLocations, {name = name, position = position})
        
        -- Refresh menu if it exists
        if teleportFrame then
            local scrollFrame = teleportFrame:FindFirstChild("ScrollingFrame")
            if scrollFrame then
                Teleport.addTeleportButton(scrollFrame, name, position)
            end
        end
    end
    
    function Teleport.removeLocation(name)
        for i, location in ipairs(teleportLocations) do
            if location.name == name then
                table.remove(teleportLocations, i)
                break
            end
        end
        
        -- Would need to refresh menu here if implementing removal
    end
    
    function Teleport.getLocations()
        return teleportLocations
    end
    
    function Teleport.cleanup()
        if teleportFrame then
            teleportFrame:Destroy()
        end
    end
    
    return Teleport
end
