local Lighting = game:GetService("Lighting")

local Bright = {}
local enabled = false
local connections = {}

local function apply(state)
    if state then
        Lighting.FogStart, Lighting.FogEnd = 1e6, 1e6
        Lighting.ClockTime = 12
        Lighting.Brightness = 3
        Lighting.Ambient = Color3.fromRGB(128,128,128)
        Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    else
        Lighting.FogStart, Lighting.FogEnd = 0, 1000
        Lighting.ClockTime = 14
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(0,0,0)
        Lighting.OutdoorAmbient = Color3.fromRGB(127,127,127)
    end
end

function Bright.Setup(parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,40,0,20)
    btn.Position = UDim2.new(1,-40,0,115)
    btn.Text = "OFF"
    btn.BackgroundColor3 = Color3.fromRGB(200,0,0)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = parent

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        btn.Text = enabled and "ON" or "OFF"
        apply(enabled)
    end)
end

return Bright
