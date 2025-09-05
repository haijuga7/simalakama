-- Loader Utama
local gui = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader2/gui.lua"))()
local walk = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader2/walkspeed.lua"))()
local headlamp = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader2/headlamp.lua"))()
local bright = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader2/bright.lua"))()
local god = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader2/god.lua"))()
local jump = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader2/jump.lua"))()
local teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/haijuga7/simalakama/refs/heads/main/loader2/teleport.lua"))()

-- Panggil inisialisasi GUI
gui.Init({
    Walk = walk,
    Headlamp = headlamp,
    Bright = bright,
    God = god,
    Jump = jump,
    Teleport = teleport
})

-- Fungsi untuk menerapkan settings ke karakter baru
local function applySettingsToCharacter()
    -- WalkSpeed
    updateWalkSpeed(currentWalkSpeed)

    -- Headlamp
    if headlampEnabled then
        createHeadlamp()
    end

    -- Infinity Jump
    if infinityJumpEnabled then
        if infinityJumpConnection then infinityJumpConnection:Disconnect() end
        infinityJumpConnection = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end

    -- God Mode
    if godModeEnabled and not godModeConnection then
        godModeConnection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
                -- isi Hunger & Thirst lagi
                if LocalPlayer:FindFirstChild("Hunger") then
                    LocalPlayer.Hunger.Value = 100
                end
                if LocalPlayer:FindFirstChild("Thirst") then
                    LocalPlayer.Thirst.Value = 100
                end
            end
        end)
    end
end

-- Apply otomatis saat respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid") -- tunggu humanoid ready
    task.wait(0.5) -- kasih delay kecil biar part siap
    applySettingsToCharacter()
end)

-- Jalankan sekali saat pertama kali
applySettingsToCharacter()

