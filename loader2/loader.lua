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
