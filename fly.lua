-- [[ SCRIPT FLY CAU VONG BY GEMINI FOR  ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyBtn = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")

ScreenGui.Name = "RainbowFlyGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Giao dien chinh
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

-- Vien mau cau vong (Rainbow Effect)
spawn(function()
    local hue = 0
    while task.wait() do
        hue = hue + 0.01
        if hue > 1 then hue = 0 end
        MainFrame.BorderColor3 = Color3.fromHSV(hue, 1, 1)
    end
end)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "FLY CAU VONG"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1

FlyBtn.Parent = MainFrame
FlyBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
FlyBtn.Size = UDim2.new(0, 160, 0, 40)
FlyBtn.Text = "Bat Fly"
FlyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FlyBtn.TextColor3 = Color3.fromRGB(0, 255, 0)

SpeedInput.Parent = MainFrame
SpeedInput.Position = UDim2.new(0.1, 0, 0.65, 0)
SpeedInput.Size = UDim2.new(0, 160, 0, 30)
SpeedInput.Text = "50"
SpeedInput.PlaceholderText = "Toc do bay..."
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Logic Fly va Speed chinh sua
local flying = false
local speed = 50
local player = game.Players.LocalPlayer

FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    local character = player.Character
    local torso = character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso"))
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if flying then
        FlyBtn.Text = "Tat Fly"
        FlyBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
        if not torso then return end
        
        local bv = Instance.new("BodyVelocity", torso)
        bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.velocity = Vector3.new(0, 0.1, 0)
        
        local bg = Instance.new("BodyGyro", torso)
        bg.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.cframe = torso.CFrame
        
        spawn(function()
            while flying and task.wait() do
                speed = tonumber(SpeedInput.Text) or 50
                if humanoid and torso then
                    humanoid.PlatformStand = true
                    if humanoid.MoveDirection.Magnitude > 0 then
                        bv.velocity = humanoid.MoveDirection * speed
                    else
                        bv.velocity = Vector3.new(0, 0, 0)
                    end
                    bg.cframe = workspace.CurrentCamera.CFrame
                end
            end
            
            -- Doan nay de don dep khi tat hack
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
                                bg.cframe = workspace.CurrentCamera.CFrame
                end
            end
            
            -- Dọn dẹp lực khi tắt fly
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
            if humanoid then humanoid.PlatformStand = false end
            FlyBtn.Text = "Bat Fly"
            FlyBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
        end)
    else
        FlyBtn.Text = "Bat Fly"
        FlyBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
    end
end)
