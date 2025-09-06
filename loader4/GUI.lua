-- ui.lua
local UserInputService = game:GetService("UserInputService")

local UI = {}

function UI.Initialize(SharedState)
    local playerGuiUI = SharedState.UI.PlayerGuiUI
    
    -- Frame utama
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 280, 0, 280)
    MainFrame.Position = UDim2.new(0, 100, 0, 50)
    MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = playerGuiUI
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = MainFrame
    
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
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 15)
    MinimizeCorner.Parent = MinimizeButton
    
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
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 15)
    CloseCorner.Parent = CloseButton
    
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
    
    local sjCorner = Instance.new("UICorner")
    sjCorner.CornerRadius = UDim.new(1, 0)
    sjCorner.Parent = sjLabel
    
    -- Content container
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -10, 1, -40)
    contentFrame.Position = UDim2.new(0, 5, 0, 35)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = MainFrame
    
    -- Store UI elements in SharedState
    SharedState.UI.MainFrame = MainFrame
    SharedState.UI.ContentFrame = contentFrame
    SharedState.UI.Header = header
    SharedState.UI.MinimizeButton = MinimizeButton
    SharedState.UI.CloseButton = CloseButton
    SharedState.UI.SJLabel = sjLabel
    SharedState.UI.Corner = corner
    
    -- Minimize / Maximize
    local minimized = false
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
    
    -- Close panel
    CloseButton.MouseButton1Click:Connect(function()
        playerGuiUI:Destroy()
    end)
    
    -- Drag GUI
    local dragging, dragInput, dragStart, startPos
    
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
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Helper function for creating toggle buttons
    UI.CreateToggle = function(text, position, callback)
        local toggleLabel = Instance.new("TextLabel")
        toggleLabel.Text = text
        toggleLabel.Size = UDim2.new(0.7, 0, 0, 20)
        toggleLabel.Position = position
        toggleLabel.BackgroundTransparency = 1
        toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleLabel.Font = Enum.Font.Gotham
        toggleLabel.TextSize = 14
        toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
        toggleLabel.Parent = contentFrame
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0, 40, 0, 20)
        toggleButton.Position = position + UDim2.new(1, -40, 0, 0)
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        toggleButton.Text = "OFF"
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.Font = Enum.Font.GothamBold
        toggleButton.TextSize = 12
        toggleButton.Parent = contentFrame
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 10)
        toggleCorner.Parent = toggleButton
        
        toggleButton.MouseButton1Click:Connect(function()
            callback(toggleButton)
        end)
        
        return toggleButton, toggleLabel
    end
    
    -- Helper function for updating toggle button appearance
    UI.UpdateToggle = function(btn, state)
        if state then
            btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            btn.Text = "ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            btn.Text = "OFF"
        end
    end
end

return UI
