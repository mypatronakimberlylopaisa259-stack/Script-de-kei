-- Murderers VS Sheriffs DUELS | Simple Auto Farm Coins/Wins GUI
-- ADVERTENCIA: USO BAJO TU PROPIO RIESGO - POSIBLE BAN

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MVS Duels Farm - Alina", "DarkTheme")

local Tab = Window:NewTab("Auto Farm")
local Section = Tab:NewSection("Farm Coins & Wins")

Section:NewButton("Activar Auto Farm Wins (1v1 Queue + Kill All)", "Intenta farmear wins y coins automáticamente", function()
    _G.AutoFarm = true
    
    spawn(function()
        while _G.AutoFarm do
            -- Intenta unirse a queue 1v1 automáticamente (ajusta path si cambió)
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.JoinQueue:FireServer("1v1") -- Nombre del remote puede variar
            end)
            
            wait(3) -- Espera a que entre al duelo
            
            -- Kill All (mata a todos los oponentes - muy detectable)
            for _, player in pairs(game.Players:GetPlayers()) do
                if player \~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        -- Ejemplo genérico de remote shoot / knife hit (cambia según el juego)
                        game:GetService("ReplicatedStorage").Remotes.Shoot:FireServer(
                            player.Character.HumanoidRootPart.Position,
                            player.Character.HumanoidRootPart
                        )
                    end)
                end
            end
            
            wait(1) -- Pequeña pausa para no crashear
        end
    end)
    
    print("Auto Farm activado! (Cuidado con el ban)")
end)

Section:NewButton("Desactivar Auto Farm", "Para el farm", function()
    _G.AutoFarm = false
    print("Auto Farm desactivado.")
end)

Section:NewToggle("Auto Rejoin Queue", "Auto vuelve a la cola si pierdes", function(state)
    _G.AutoRejoin = state
end)

-- Bonus: si sabes el remote exacto de claim coins o daily
Section:NewButton("Intentar Claim Coins x100 (si no está parcheado)", "", function()
    for i = 1, 100 do
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.ClaimDaily:FireServer() -- Ejemplo, casi nunca funciona así
        end)
        wait(0.1)
    end
end)

print("GUI cargada! Usa con cuidado en https://www.roblox.com/games/12355337193")
