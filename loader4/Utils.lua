-- characterhandler.lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local CharacterHandler = {}

function CharacterHandler.Initialize(SharedState, Modules)
    -- Apply settings to current character if it exists
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        CharacterHandler.ApplySettings(SharedState, Modules)
    end
    
    -- Connect to CharacterAdded event to apply settings to new characters
    LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        newCharacter:WaitForChild("Humanoid") -- Wait for humanoid to be ready
        CharacterHandler.ApplySettings(SharedState, Modules)
    end)
end

function CharacterHandler.ApplySettings(SharedState, Modules)
    -- Apply WalkSpeed if enabled
    if SharedState.Settings.WalkSpeed.Enabled then
        Modules.WalkSpeed.Update(SharedState)
    end
    
    -- Apply Headlamp if enabled
    if SharedState.Settings.Headlamp.Enabled then
        Modules.Headlamp.Create(SharedState)
    end
    
    -- Apply BrightMode if enabled
    if SharedState.Settings.BrightMode.Enabled then
        Modules.BrightMode.Apply(SharedState)
        Modules.BrightMode.ConnectEvents(SharedState)
    end
    
    -- Apply GodMode if enabled
    if SharedState.Settings.GodMode.Enabled then
        Modules.GodMode.Toggle(SharedState)
    end
    
    -- Apply InfinityJump if enabled
    if SharedState.Settings.InfinityJump.Enabled then
        Modules.InfinityJump.Toggle(SharedState)
    end
end

return CharacterHandler
