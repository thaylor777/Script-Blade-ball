-- Blade Ball Mobile Auto Parry
-- Ativação manual por botão na tela
-- Formato para loadstring

local function Main()
    -- Configurações
    local parryDistance = 25
    local autoParryEnabled = false
    
    -- Cria a interface
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AutoParryUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ScreenGui
    ToggleButton.Size = UDim2.new(0, 150, 0, 50)
    ToggleButton.Position = UDim2.new(0.5, -75, 0.9, -60)
    ToggleButton.Text = "Auto Parry: OFF"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.Font = Enum.Font.SourceSansBold
    ToggleButton.TextSize = 18
    ToggleButton.ZIndex = 999
    
    -- Função para alternar
    local function toggleAutoParry()
        autoParryEnabled = not autoParryEnabled
        if autoParryEnabled then
            ToggleButton.Text = "Auto Parry: ON"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        else
            ToggleButton.Text = "Auto Parry: OFF"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        end
    end
    
    ToggleButton.MouseButton1Click:Connect(toggleAutoParry)
    
    -- Função principal
    local function checkBall()
        if not autoParryEnabled then return end
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        for _, ball in ipairs(workspace:GetChildren()) do
            if ball.Name == "Ball" and ball:FindFirstChild("Sphere") then
                local distance = (ball.Sphere.Position - rootPart.Position).Magnitude
                if distance <= parryDistance then
                    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("ParryEvent") or
                                 game:GetService("ReplicatedStorage"):FindFirstChild("Parry")
                    if remote then
                        remote:FireServer()
                        break
                    end
                end
            end
        end
    end
    
    -- Loop de verificação
    game:GetService("RunService").Heartbeat:Connect(checkBall)
    
    print("Script de Auto Parry carregado com sucesso!")
end

-- Executa a função principal
pcall(Main)
