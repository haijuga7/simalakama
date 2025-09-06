-- UTILS MODULE
-- Helper functions yang digunakan oleh module lain

return function()
    local Utils = {}
    
    -- Toggle button appearance
    function Utils.toggleButton(btn, state)
        if state then
            btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            btn.Text = "ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            btn.Text = "OFF"
        end
    end
    
    -- Create UICorner with radius
    function Utils.createCorner(parent, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius or 8)
        corner.Parent = parent
        return corner
    end
    
    -- Create button with standard style
    function Utils.createToggleButton(parent, position, text)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 40, 0, 20)
        button.Position = position
        button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        button.Text = text or "OFF"
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 12
        button.Parent = parent
        
        Utils.createCorner(button, 10)
        
        return button
    end
    
    -- Create label with standard style
    function Utils.createLabel(parent, position, text, size)
        local label = Instance.new("TextLabel")
        label.Text = text
        label.Size = size or UDim2.new(0.7, 0, 0, 20)
        label.Position = position
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = parent
        
        return label
    end
    
    -- Get current character safely
    function Utils.getCharacter()
        return _G.PlayerSettings.Services.LocalPlayer.Character
    end
    
    -- Get humanoid safely
    function Utils.getHumanoid()
        local char = Utils.getCharacter()
        return char and char:FindFirstChildOfClass("Humanoid")
    end
    
    -- Safe wait for child
    function Utils.waitForChild(parent, childName, timeout)
        timeout = timeout or 5
        local startTime = tick()
        while not parent:FindFirstChild(childName) and tick() - startTime < timeout do
            wait(0.1)
        end
        return parent:FindFirstChild(childName)
    end
    
    -- Cleanup connections
    function Utils.cleanupConnections(connections)
        if connections then
            for _, connection in ipairs(connections) do
                if connection then
                    connection:Disconnect()
                end
            end
        end
        return {}
    end
    
    -- Save to global storage
    function Utils.saveData(key, value)
        _G.PlayerSettings[key] = value
    end
    
    -- Load from global storage
    function Utils.loadData(key, default)
        return _G.PlayerSettings[key] or default
    end
    
    print("🔧 Utils Module Ready")
    return Utils
end
