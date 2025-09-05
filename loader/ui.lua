-- UI Module
local UI = {}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Variabel UI
UI.playerGuiUI = nil
UI.MainFrame = nil
UI.contentFrame = nil
UI.teleportFrame = nil
UI.minimized = false

function UI:Initialize()
    self:CreateMainUI()
    self:SetupDrag()
end

function UI:CreateMainUI()
    -- Buat ScreenGui
    self.playerGuiUI = Instance.new("ScreenGui")
    self.playerGuiUI.Name = "PlayerGuiUI"
    self.playerGuiUI.Parent = PlayerGui
    self.playerGuiUI.ResetOnSpawn = false
    self.playerGuiUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Frame utama
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Size = UDim2.new(0, 280, 0, 280)
    self.MainFrame.Position = UDim2.new(0, 100, 0, 50)
    self.MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = self.playerGuiUI

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.MainFrame

    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    header.BorderSizePixel = 0
    header.Parent = self.MainFrame

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
    MinimizeButton.Name = "MinimizeButton"
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
    CloseButton.Name = "CloseButton"
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
    sjLabel.Parent = self.MainFrame
    sjLabel.Name = "SJLabel"
    local sjCorner = Instance.new("UICorner")
    sjCorner.CornerRadius = UDim.new(1, 0)
    sjCorner.Parent = sjLabel

    -- Content container
    self.contentFrame = Instance.new("Frame")
    self.contentFrame.Size = UDim2.new(1, -10, 1, -40)
    self.contentFrame.Position = UDim2.new(0, 5, 0, 35)
    self.contentFrame.BackgroundTransparency = 1
    self.contentFrame.Parent = self.MainFrame
end

function UI:SetupDrag()
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        self.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    local function setupDrag(element)
        element.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = self.MainFrame.Position
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

    setupDrag(self.MainFrame:FindFirstChildWhichIsA("Frame")) -- Header
    setupDrag(self.MainFrame:FindFirstChild("SJLabel"))
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function UI:ToggleMinimize()
    self.minimized = not self.minimized
    if self.minimized then
        self.MainFrame:TweenSize(UDim2.new(0, 50, 0, 50), "Out", "Quad", 0.3, true)
        self.MainFrame:FindFirstChildWhichIsA("UICorner").CornerRadius = UDim.new(1, 0)
        for _, v in pairs(self.MainFrame:GetChildren()) do
            if v:IsA("GuiObject") and v.Name ~= "SJLabel" then
                v.Visible = false
            end
        end
        self.MainFrame:FindFirstChild("SJLabel").Visible = true
        self.MainFrame:FindFirstChild("MinimizeButton").Text = "+"
    else
        self.MainFrame:TweenSize(UDim2.new(0, 280, 0, 280), "Out", "Quad", 0.3, true)
        self.MainFrame:FindFirstChildWhichIsA("UICorner").CornerRadius = UDim.new(0, 8)
        for _, v in pairs(self.MainFrame:GetChildren()) do
            if v:IsA("GuiObject") then
                v.Visible = true
            end
        end
        self.MainFrame:FindFirstChild("SJLabel").Visible = false
        self.MainFrame:FindFirstChild("MinimizeButton").Text = "-"
    end
end

return UI
