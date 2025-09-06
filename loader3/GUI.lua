-- GUI MODULE
-- Main interface creation and management

return function()
    local GUI = {}
    local Services = _G.PlayerSettings.Services
    local Utils = _G.PlayerSettings.Modules.Utils
    
    local minimized = false
    local dragging, dragInput, dragStart, startPos
    
    function GUI.Initialize()
        -- Buat ScreenGui
        local playerGuiUI = Instance.new("ScreenGui")
        playerGuiUI.Name = "PlayerGuiUI"
        playerGuiUI.Parent = Services.LocalPlayer.PlayerGui
        playerGuiUI.ResetOnSpawn = false
        playerGuiUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        -- Frame utama
        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 280, 0, 280)
        MainFrame.Position = UDim2.new(0, 100, 0, 50)
        MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        MainFrame.BorderSizePixel = 0
        MainFrame.Parent = playerGuiUI
        
        local corner = Utils.createCorner(MainFrame, 8)
        
        -- Header
        local header = Instance.new("Frame")
        header.Size = UDim2.new(1, 0, 0, 30)
        header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        header.BorderSizePixel = 0
        header.Parent = MainFrame
        
        local Title = Instance.new("TextLabel")
        Title.Text = "Player Settings"
        Title.Size = UDim2.new(0.7, 0, 1, 0)
        Title.Position = UDim2.new(0, 10, 0, 0)
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 16
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = header
        
        -- Tombol minimize
        local MinimizeButton = Instance.new("TextButton")
        MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
        MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
        MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        MinimizeButton.Text = "-"
        MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        MinimizeButton.Font = Enum.Font.GothamBold
        MinimizeButton.TextSize = 16
        MinimizeButton.Parent = header
        Utils.createCorner(MinimizeButton, 15)
        
        -- Tombol close
        local CloseButton = Instance.new("TextButton")
        CloseButton.Size = UDim2.new(0, 30, 0, 30)
        CloseButton.Position = UDim2.new(1, -35, 0, 0)
        CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        CloseButton.Text = "X"
        CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.TextSize = 16
        CloseButton.Parent = header
        Utils.createCorner(CloseButton, 15)
        
        -- Label SJ (untuk minimize)
        local sjLabel = Instance.new("TextButton")
        sjLabel.Size = UDim2.new(1, 0, 1, 0)
        sjLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        sjLabel.Text = "SJ"
        sjLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        sjLabel.Font = Enum.Font.GothamBold
        sjLabel.TextSize = 18
        sjLabel.TextScaled = true
        sjLabel.Visible = false
        sjLabel.Parent = MainFrame
        Utils.createCorner(sjLabel, 50)
        
        -- Content container
        local contentFrame = Instance.new("Frame")
        contentFrame.Size = UDim2.new(1, -10, 1, -40)
        contentFrame.Position = UDim2.new(0, 5, 0, 35)
        contentFrame.BackgroundTransparency = 1
        contentFrame.Parent = MainFrame
        
        -- Setup drag functionality
        local function update(input)
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        
        local function setupDrag(element)
            element.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = MainFrame.Position
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)
            element.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    dragInput = input
                end
            end)
        end
        
        setupDrag(header)
        setupDrag(sjLabel)
        
        Services.UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
        
        -- Minimize/Maximize functionality
        local function toggleMinimize()
            minimized = not minimized
            if minimized then
                MainFrame:TweenSize(UDim2.new(0, 50, 0, 50), "Out", "Quad", 0.3, true)
                corner.CornerRadius = UDim.new(1, 0)
                for _, v in pairs(MainFrame:GetChildren()) do
                    if v ~= sjLabel and v ~= corner then
                        v.Visible = false
                    end
                end
                sjLabel.Visible = true
                MinimizeButton.Text = "+"
            else
                MainFrame:TweenSize(UDim2.new(0, 280, 0, 280), "Out", "Quad", 0.3, true)
                corner.CornerRadius = UDim.new(0, 8)
                for _, v in pairs(MainFrame:GetChildren()) do
                    if v:IsA("GuiObject") then
                        v.Visible = true
                    end
                end
                sjLabel.Visible = false
                MinimizeButton.Text = "-"
            end
        end
        
        MinimizeButton.MouseButton1Click:Connect(toggleMinimize)
        sjLabel.MouseButton1Click:Connect(toggleMinimize)
        
        -- Close functionality
        CloseButton.MouseButton1Click:Connect(function()
            playerGuiUI:Destroy()
        end)
        
        -- Save references to global
        _G.PlayerSettings.GUI = {
            ScreenGui = playerGuiUI,
            MainFrame = MainFrame,
            ContentFrame = contentFrame,
            Header = header,
            toggleMinimize = toggleMinimize
        }
        
        print("🖼️ GUI Module Initialized")
    end
    
    -- Helper function untuk mendapatkan content frame
    function GUI.getContentFrame()
        return _G.PlayerSettings.GUI.ContentFrame
    end
    
    -- Helper function untuk mendapatkan main frame
    function GUI.getMainFrame()
        return _G.PlayerSettings.GUI.MainFrame
    end
    
    return GUI
end
