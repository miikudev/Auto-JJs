local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Config = {
    Enabled = false,
    ClickDelay = 0.1,
    AdvancedMode = false,
    TargetClicks = 400,
    TargetTime = 420,
    CurrentClicks = 0,
    StartTime = 0,
    ToggleKey = Enum.KeyCode.RightShift,
    WaitingForKey = false
}

local ScreenGui
local MainFrame
local Connections = {}

local function CreateGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AutoClickerGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BackgroundTransparency = 0.3
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -175, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 350, 0, 280)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Transparency = 0.8
    UIStroke.Thickness = 1
    UIStroke.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Auto Clicker Polichinelos"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.ZIndex = 2
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = MainFrame
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    ToggleButton.BackgroundTransparency = 0.2
    ToggleButton.Position = UDim2.new(0.1, 0, 0.18, 0)
    ToggleButton.Size = UDim2.new(0.8, 0, 0, 35)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 14
    ToggleButton.BorderSizePixel = 0
    ToggleButton.ZIndex = 2
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleButton
    
    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
    ToggleStroke.Transparency = 0.7
    ToggleStroke.Thickness = 1
    ToggleStroke.Parent = ToggleButton
    
    local DelayLabel = Instance.new("TextLabel")
    DelayLabel.Name = "DelayLabel"
    DelayLabel.Parent = MainFrame
    DelayLabel.BackgroundTransparency = 1
    DelayLabel.Position = UDim2.new(0.1, 0, 0.35, 0)
    DelayLabel.Size = UDim2.new(0.4, 0, 0, 25)
    DelayLabel.Font = Enum.Font.Gotham
    DelayLabel.Text = "Delay (s):"
    DelayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    DelayLabel.TextSize = 13
    DelayLabel.TextXAlignment = Enum.TextXAlignment.Left
    DelayLabel.ZIndex = 2
    
    local DelayInput = Instance.new("TextBox")
    DelayInput.Name = "DelayInput"
    DelayInput.Parent = MainFrame
    DelayInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    DelayInput.BackgroundTransparency = 0.3
    DelayInput.Position = UDim2.new(0.55, 0, 0.35, 0)
    DelayInput.Size = UDim2.new(0.35, 0, 0, 25)
    DelayInput.Font = Enum.Font.Gotham
    DelayInput.Text = "0.1"
    DelayInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    DelayInput.TextSize = 13
    DelayInput.ClearTextOnFocus = false
    DelayInput.ZIndex = 2
    
    local DelayCorner = Instance.new("UICorner")
    DelayCorner.CornerRadius = UDim.new(0, 6)
    DelayCorner.Parent = DelayInput
    
    local DelayStroke = Instance.new("UIStroke")
    DelayStroke.Color = Color3.fromRGB(255, 255, 255)
    DelayStroke.Transparency = 0.8
    DelayStroke.Thickness = 1
    DelayStroke.Parent = DelayInput
    
    local KeybindFrame = Instance.new("Frame")
    KeybindFrame.Name = "KeybindFrame"
    KeybindFrame.Parent = MainFrame
    KeybindFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeybindFrame.BackgroundTransparency = 0.3
    KeybindFrame.Position = UDim2.new(0.1, 0, 0.48, 0)
    KeybindFrame.Size = UDim2.new(0.8, 0, 0, 30)
    KeybindFrame.BorderSizePixel = 0
    KeybindFrame.ZIndex = 2
    
    local KeybindFrameCorner = Instance.new("UICorner")
    KeybindFrameCorner.CornerRadius = UDim.new(0, 6)
    KeybindFrameCorner.Parent = KeybindFrame
    
    local KeybindFrameStroke = Instance.new("UIStroke")
    KeybindFrameStroke.Color = Color3.fromRGB(255, 255, 255)
    KeybindFrameStroke.Transparency = 0.8
    KeybindFrameStroke.Thickness = 1
    KeybindFrameStroke.Parent = KeybindFrame
    
    local KeybindLabel = Instance.new("TextLabel")
    KeybindLabel.Name = "KeybindLabel"
    KeybindLabel.Parent = KeybindFrame
    KeybindLabel.BackgroundTransparency = 1
    KeybindLabel.Position = UDim2.new(0, 10, 0, 0)
    KeybindLabel.Size = UDim2.new(0.65, -10, 1, 0)
    KeybindLabel.Font = Enum.Font.Gotham
    KeybindLabel.Text = "Esconder/Mostrar UI"
    KeybindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeybindLabel.TextSize = 12
    KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    KeybindLabel.ZIndex = 2
    
    local KeybindButton = Instance.new("TextButton")
    KeybindButton.Name = "KeybindButton"
    KeybindButton.Parent = KeybindFrame
    KeybindButton.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
    KeybindButton.BackgroundTransparency = 0.2
    KeybindButton.Position = UDim2.new(0.65, 0, 0.15, 0)
    KeybindButton.Size = UDim2.new(0.3, 0, 0.7, 0)
    KeybindButton.Font = Enum.Font.GothamBold
    KeybindButton.Text = "RightShift"
    KeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeybindButton.TextSize = 11
    KeybindButton.BorderSizePixel = 0
    KeybindButton.ZIndex = 2
    
    local KeybindButtonCorner = Instance.new("UICorner")
    KeybindButtonCorner.CornerRadius = UDim.new(0, 4)
    KeybindButtonCorner.Parent = KeybindButton
    
    local KeybindButtonStroke = Instance.new("UIStroke")
    KeybindButtonStroke.Color = Color3.fromRGB(255, 255, 255)
    KeybindButtonStroke.Transparency = 0.7
    KeybindButtonStroke.Thickness = 1
    KeybindButtonStroke.Parent = KeybindButton
    
    local AdvancedButton = Instance.new("TextButton")
    AdvancedButton.Name = "AdvancedButton"
    AdvancedButton.Parent = MainFrame
    AdvancedButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    AdvancedButton.BackgroundTransparency = 0.2
    AdvancedButton.Position = UDim2.new(0.1, 0, 0.6, 0)
    AdvancedButton.Size = UDim2.new(0.8, 0, 0, 30)
    AdvancedButton.Font = Enum.Font.GothamBold
    AdvancedButton.Text = "Modo Avançado: OFF"
    AdvancedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    AdvancedButton.TextSize = 12
    AdvancedButton.BorderSizePixel = 0
    AdvancedButton.ZIndex = 2
    
    local AdvCorner = Instance.new("UICorner")
    AdvCorner.CornerRadius = UDim.new(0, 6)
    AdvCorner.Parent = AdvancedButton
    
    local AdvStroke = Instance.new("UIStroke")
    AdvStroke.Color = Color3.fromRGB(255, 255, 255)
    AdvStroke.Transparency = 0.7
    AdvStroke.Thickness = 1
    AdvStroke.Parent = AdvancedButton
    
    local AdvancedPanel = Instance.new("Frame")
    AdvancedPanel.Name = "AdvancedPanel"
    AdvancedPanel.Parent = MainFrame
    AdvancedPanel.BackgroundTransparency = 1
    AdvancedPanel.Position = UDim2.new(0.1, 0, 0.72, 0)
    AdvancedPanel.Size = UDim2.new(0.8, 0, 0, 60)
    AdvancedPanel.Visible = false
    AdvancedPanel.ZIndex = 2
    
    local ClicksLabel = Instance.new("TextLabel")
    ClicksLabel.Parent = AdvancedPanel
    ClicksLabel.BackgroundTransparency = 1
    ClicksLabel.Size = UDim2.new(0.45, 0, 0, 25)
    ClicksLabel.Font = Enum.Font.Gotham
    ClicksLabel.Text = "Cliques:"
    ClicksLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ClicksLabel.TextSize = 11
    ClicksLabel.TextXAlignment = Enum.TextXAlignment.Left
    ClicksLabel.ZIndex = 2
    
    local ClicksInput = Instance.new("TextBox")
    ClicksInput.Name = "ClicksInput"
    ClicksInput.Parent = AdvancedPanel
    ClicksInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ClicksInput.BackgroundTransparency = 0.3
    ClicksInput.Position = UDim2.new(0.5, 0, 0, 0)
    ClicksInput.Size = UDim2.new(0.5, 0, 0, 25)
    ClicksInput.Font = Enum.Font.Gotham
    ClicksInput.Text = "400"
    ClicksInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    ClicksInput.TextSize = 11
    ClicksInput.ZIndex = 2
    
    local ClicksCorner = Instance.new("UICorner")
    ClicksCorner.CornerRadius = UDim.new(0, 4)
    ClicksCorner.Parent = ClicksInput
    
    local TimeLabel = Instance.new("TextLabel")
    TimeLabel.Parent = AdvancedPanel
    TimeLabel.BackgroundTransparency = 1
    TimeLabel.Position = UDim2.new(0, 0, 0.5, 5)
    TimeLabel.Size = UDim2.new(0.45, 0, 0, 25)
    TimeLabel.Font = Enum.Font.Gotham
    TimeLabel.Text = "Tempo (s):"
    TimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TimeLabel.TextSize = 11
    TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
    TimeLabel.ZIndex = 2
    
    local TimeInput = Instance.new("TextBox")
    TimeInput.Name = "TimeInput"
    TimeInput.Parent = AdvancedPanel
    TimeInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TimeInput.BackgroundTransparency = 0.3
    TimeInput.Position = UDim2.new(0.5, 0, 0.5, 5)
    TimeInput.Size = UDim2.new(0.5, 0, 0, 25)
    TimeInput.Font = Enum.Font.Gotham
    TimeInput.Text = "420"
    TimeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    TimeInput.TextSize = 11
    TimeInput.ZIndex = 2
    
    local TimeCorner = Instance.new("UICorner")
    TimeCorner.CornerRadius = UDim.new(0, 4)
    TimeCorner.Parent = TimeInput
    
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "StatusLabel"
    StatusLabel.Parent = MainFrame
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Position = UDim2.new(0, 0, 0.88, 0)
    StatusLabel.Size = UDim2.new(1, 0, 0, 25)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.Text = "Status: Desativado"
    StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    StatusLabel.TextSize = 12
    StatusLabel.ZIndex = 2
    
    DelayInput.FocusLost:Connect(function()
        local num = tonumber(DelayInput.Text)
        if num and num >= 0.01 then
            Config.ClickDelay = num
            print("[DEBUG] Delay alterado para: " .. num)
        else
            DelayInput.Text = tostring(Config.ClickDelay)
        end
    end)
    
    ClicksInput.FocusLost:Connect(function()
        local num = tonumber(ClicksInput.Text)
        if num and num > 0 then
            Config.TargetClicks = num
            print("[DEBUG] Cliques alvo: " .. num)
        else
            ClicksInput.Text = tostring(Config.TargetClicks)
        end
    end)
    
    TimeInput.FocusLost:Connect(function()
        local num = tonumber(TimeInput.Text)
        if num and num > 0 then
            Config.TargetTime = num
            print("[DEBUG] Tempo alvo: " .. num)
        else
            TimeInput.Text = tostring(Config.TargetTime)
        end
    end)
    
    KeybindButton.MouseButton1Click:Connect(function()
        if Config.WaitingForKey then return end
        
        Config.WaitingForKey = true
        KeybindButton.Text = "..."
        KeybindButton.BackgroundColor3 = Color3.fromRGB(255, 200, 80)
        print("[DEBUG] Aguardando tecla...")
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            if input.UserInputType == Enum.UserInputType.Keyboard then
                Config.ToggleKey = input.KeyCode
                Config.WaitingForKey = false
                
                local keyName = input.KeyCode.Name
                KeybindButton.Text = keyName
                KeybindButton.BackgroundColor3 = Color3.fromRGB(150, 100, 200)
                
                print("[DEBUG] Keybind configurada para: " .. keyName)
                connection:Disconnect()
            end
        end)
    end)
    
    AdvancedButton.MouseButton1Click:Connect(function()
        Config.AdvancedMode = not Config.AdvancedMode
        AdvancedPanel.Visible = Config.AdvancedMode
        
        if Config.AdvancedMode then
            AdvancedButton.Text = "Modo Avançado: ON"
            AdvancedButton.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
            MainFrame.Size = UDim2.new(0, 350, 0, 360)
            DelayInput.TextEditable = false
            DelayInput.BackgroundTransparency = 0.6
        else
            AdvancedButton.Text = "Modo Avançado: OFF"
            AdvancedButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
            MainFrame.Size = UDim2.new(0, 350, 0, 280)
            DelayInput.TextEditable = true
            DelayInput.BackgroundTransparency = 0.3
        end
    end)
    
    ToggleButton.MouseButton1Click:Connect(function()
        Config.Enabled = not Config.Enabled
        
        if Config.Enabled then
            Config.CurrentClicks = 0
            Config.StartTime = os.clock()
            
            if Config.AdvancedMode then
                local calculatedDelay = Config.TargetTime / Config.TargetClicks
                Config.ClickDelay = calculatedDelay
                DelayInput.Text = string.format("%.3f", calculatedDelay)
                print("[DEBUG] Delay calculado: " .. calculatedDelay)
                StatusLabel.Text = string.format("Progresso: 0/%d | Tempo: 0s", Config.TargetClicks)
            else
                StatusLabel.Text = "Status: Ativado ✓"
            end
            
            ToggleButton.Text = "ON"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
            StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
        else
            ToggleButton.Text = "OFF"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
            StatusLabel.Text = "Status: Desativado"
            StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end)
    
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local function FindMinigameScreen()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    for _, gui in pairs(PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            local screen = gui:FindFirstChild("Screen")
            if screen and screen:IsA("Frame") then
                return screen
            end
        end
    end
    
    return nil
end

local function UpdateProgress()
    if not Config.AdvancedMode then return end
    
    local elapsed = os.clock() - Config.StartTime
    local StatusLabel = MainFrame:FindFirstChild("StatusLabel")
    
    if StatusLabel then
        StatusLabel.Text = string.format("Progresso: %d/%d | Tempo: %.1fs", 
            Config.CurrentClicks, Config.TargetClicks, elapsed)
    end
    
    if Config.CurrentClicks >= Config.TargetClicks then
        Config.Enabled = false
        local ToggleButton = MainFrame:FindFirstChild("ToggleButton")
        if ToggleButton then
            ToggleButton.Text = "OFF"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        end
        if StatusLabel then
            StatusLabel.Text = string.format("Completo! %d cliques em %.1fs", Config.CurrentClicks, elapsed)
            StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 255)
        end
        print("[DEBUG] Objetivo alcançado!")
    end
end

local function SimulateInput(inputButton, keyRequired)
    if not Config.Enabled then return end
    
    task.wait(Config.ClickDelay)
    
    if not inputButton or not inputButton.Parent then return end
    if inputButton:GetAttribute("Completed") then return end
    
    if keyRequired and keyRequired ~= "TAP" then
        local keyCode = Enum.KeyCode[keyRequired]
        
        if keyCode then
            VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
            task.wait(0.05)
            VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
            
            Config.CurrentClicks = Config.CurrentClicks + 1
            UpdateProgress()
        end
    else
        if inputButton:IsA("ImageButton") then
            local success = pcall(function()
                for _, connection in pairs(getconnections(inputButton.MouseButton1Down)) do
                    connection:Fire()
                end
            end)
            
            if not success then
                local pos = inputButton.AbsolutePosition + (inputButton.AbsoluteSize / 2)
                VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 0)
                task.wait(0.05)
                VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 0)
            end
            
            Config.CurrentClicks = Config.CurrentClicks + 1
            UpdateProgress()
        end
    end
end

local function MonitorInputs()
    local Screen = FindMinigameScreen()
    
    if not Screen then
        warn("[DEBUG] Screen do minigame não encontrada!")
        return
    end
    
    print("[DEBUG] Auto Clicker iniciado!")
    
    table.insert(Connections, Screen.ChildAdded:Connect(function(child)
        if not Config.Enabled then return end
        
        if child:IsA("ImageButton") and child.Name == "InputTemplate" then
            task.wait(0.05)
            
            local textLabel = child:FindFirstChildWhichIsA("TextLabel")
            local keyRequired = textLabel and textLabel.Text or "TAP"
            
            print("[DEBUG] Input detectado: " .. keyRequired)
            
            task.spawn(function()
                SimulateInput(child, keyRequired)
            end)
        end
    end))
end

local function Cleanup()
    for _, connection in pairs(Connections) do
        if connection.Connected then
            connection:Disconnect()
        end
    end
    Connections = {}
end

CreateGUI()
MonitorInputs()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if Config.WaitingForKey then return end
    
    if UserInputService:GetFocusedTextBox() then return end
    
    if input.KeyCode == Config.ToggleKey then
        MainFrame.Visible = not MainFrame.Visible
        print("[DEBUG] UI " .. (MainFrame.Visible and "mostrada" or "escondida"))
    end
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        Cleanup()
    end
end)

print("[DEBUG] Auto Clicker carregado com sucesso!")
