-- [[ SCRIPT FLY CẦU VỒNG BY GEMINI FOR NGỌC THÀNH ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyBtn = Instance.new("TextButton")
local SpeedInput = Instance.new("TextBox")

ScreenGui.Name = "RainbowFlyGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Giao diện chính
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

-- Viền màu cầu vồng (Rainbow Effect)
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
Title.Text = "☠️ FLY CẦU VỒNG ☠️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1

FlyBtn.Parent = MainFrame
FlyBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
FlyBtn.Size = UDim2.new(0, 160, 0, 40)
FlyBtn.Text = "Bật Fly"
FlyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FlyBtn.TextColor3 = Color3.fromRGB(0, 255, 0)

SpeedInput.Parent = MainFrame
SpeedInput.Position = UDim2.new(0.1, 0, 0.65, 0)
SpeedInput.Size = UDim2.new(0, 160, 0, 30)
SpeedInput.Text = "50" -- Tốc độ mặc định
SpeedInput.PlaceholderText = "Tốc độ bay..."
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Logic Fly và Speed chỉnh sửa
local flying = false
local speed = 50
local player = game.Players.LocalPlayer
local lground = false

FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        FlyBtn.Text = "Tắt Fly"
        FlyBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
        
        local torso = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso")
        if not torso then return end
        
        local bv = Instance.new("BodyVelocity", torso)
        bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.velocity = Vector3.new(0,0.1,0)
        
        local bg = Instance.new("BodyGyro", torso)
        bg.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.cframe = torso.CFrame
        spawn(function()
    while flying and task.wait() do
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        speed = tonumber(SpeedInput.Text) or 50
        
        if humanoid and torso then
            humanoid.PlatformStand = true
            
            -- Kiểm tra xem bro có đang chạm vào joystick/bấm nút di chuyển không
            if humanoid.MoveDirection.Magnitude > 0 then
                -- Có bấm nút: Bay theo hướng di chuyển chuẩn
                bv.velocity = humanoid.MoveDirection * speed
            else
                -- Buông tay: Nhân vật đứng im tại chỗ, không bị trôi tự động
                bv.velocity = Vector3.new(0, 0, 0)
            end
            
            bg.cframe = workspace.CurrentCamera.CFrame
        end
                    end
                    
        
        FlyBtn.Text = "Bật Fly"
        FlyBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
    end
end)


