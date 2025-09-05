local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local GUI = {}
local minimized = false

function GUI.Init(modules)
    local playerGuiUI = Instance.new("ScreenGui")
    playerGuiUI.Name = "PlayerGuiUI"
    playerGuiUI.Parent = PlayerGui
    playerGuiUI.ResetOnSpawn = false
    playerGuiUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 280, 0, 280)
    MainFrame.Position = UDim2.new(0, 100, 0, 50)
    MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = playerGuiUI

    local corner = Instance.new("UICorner", MainFrame)
    corner.CornerRadius = UDim.new(0, 8)

    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    header.BorderSizePixel = 0
    header.Parent = MainFrame

    local title = Instance.new("TextLabel")
    title.Text = "Player Settings"
    title.Size = UDim2.new(0.7, 0, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

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
    Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 15)

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
    Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 15)

    -- Label SJ untuk minimize
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
    Instance.new("UICorner", sjLabel).CornerRadius = UDim.new(1, 0)

    -- Fungsi toggle minimize
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

    -- Fungsi close
    CloseButton.MouseButton1Click:Connect(function()
        playerGuiUI:Destroy()
    end)

    -- Tambahkan modul ke dalam MainFrame
    modules.Walk.Setup(MainFrame)
    modules.Headlamp.Setup(MainFrame)
    modules.Bright.Setup(MainFrame)
    modules.God.Setup(MainFrame)
    modules.Jump.Setup(MainFrame)
    modules.Teleport.Setup(MainFrame, playerGuiUI, MainFrame)

    -- Drag GUI (supaya bisa digeser)
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    header.InputBegan:Connect(function(input)
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
    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

return GUI
