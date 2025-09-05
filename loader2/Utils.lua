-- Utils.lua
local Utils = {}

function Utils.toggleButton(btn, state)
    if state then
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        btn.Text = "ON"
    else
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        btn.Text = "OFF"
    end
end

function Utils.createToggle(parent, text, yOffset)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.7, 0, 0, 20)
    label.Position = UDim2.new(0, 0, 0, yOffset)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 40, 0, 20)
    btn.Position = UDim2.new(1, -40, 0, yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    return btn, label
end

function Utils.createSlider(parent, yOffset, default, maxValue)
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, 0, 0, 20)
    slider.Position = UDim2.new(0, 0, 0, yOffset)
    slider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    slider.Parent = parent
    Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 10)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(default/maxValue, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    fill.Parent = slider
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 10)

    return slider, fill
end

return Utils
