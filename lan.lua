local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 200)  -- Increased height to accommodate the new label and text box
Frame.Position = UDim2.new(0.5, -125, 0.5, -100)
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.new(1, 1, 1)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundTransparency = 1
TitleBar.Text = "LANCÔME IDÔLE HOUSE"
TitleBar.TextColor3 = Color3.new(1, 1, 1)
TitleBar.Font = Enum.Font.SourceSansBold
TitleBar.TextSize = 16
TitleBar.Position = UDim2.new(0, -15, 0, 0)
TitleBar.Parent = Frame

local YTLabel = Instance.new("TextLabel")
YTLabel.Size = UDim2.new(0, 100, 0, 20)
YTLabel.Position = UDim2.new(0, 0, 1, -25)
YTLabel.BackgroundTransparency = 1
YTLabel.Text = "Yt: oxireun"
YTLabel.TextColor3 = Color3.new(1, 1, 1)
YTLabel.Font = Enum.Font.SourceSans
YTLabel.TextSize = 14
YTLabel.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -30, 0, 3)
CloseButton.BackgroundColor3 = Color3.new(0, 0, 1)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18
CloseButton.Parent = Frame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -70, 0, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = Frame

local StartStopButton = Instance.new("TextButton")
StartStopButton.Size = UDim2.new(0, 150, 0, 40)
StartStopButton.Position = UDim2.new(0.5, -75, 0, 100)  -- Adjusted position for the new elements
StartStopButton.BackgroundColor3 = Color3.new(0, 0, 1)
StartStopButton.Text = "Start"
StartStopButton.TextColor3 = Color3.new(1, 1, 1)
StartStopButton.Font = Enum.Font.SourceSansBold
StartStopButton.TextSize = 18
StartStopButton.Parent = Frame

-- Add a label for speed
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 100, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0, 70)  -- Positioned above the text box
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed:"
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextSize = 14
SpeedLabel.Parent = Frame

-- Add a text box for speed input
local SpeedTextBox = Instance.new("TextBox")
SpeedTextBox.Size = UDim2.new(0, 50, 0, 20)
SpeedTextBox.Position = UDim2.new(0, 120, 0, 70)  -- Positioned next to the label
SpeedTextBox.BackgroundColor3 = Color3.new(1, 1, 1)
SpeedTextBox.TextColor3 = Color3.new(0, 0, 0)
SpeedTextBox.Font = Enum.Font.SourceSans
SpeedTextBox.TextSize = 14
SpeedTextBox.Text = "0.1"  -- Default value
SpeedTextBox.Parent = Frame

local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    if minimized then
        Frame.Size = UDim2.new(0, 250, 0, 200)  -- Adjusted height
        StartStopButton.Visible = true
        YTLabel.Visible = true
        SpeedLabel.Visible = true
        SpeedTextBox.Visible = true
        MinimizeButton.Text = "-"
    else
        Frame.Size = UDim2.new(0, 250, 0, 30)
        StartStopButton.Visible = false
        YTLabel.Visible = false
        SpeedLabel.Visible = false
        SpeedTextBox.Visible = false
        MinimizeButton.Text = "+"
    end
    minimized = not minimized
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Başlatma ve durdurma işlemi için değişken
local isRunning = false
local collectionThread

-- Nesneleri toplama ve CFrame'lere ışınlanma işlemi
local function startCollecting()
    local workspaceChildren = workspace:GetChildren()
    local indices = {16, 17} -- 16. ve 17. öğelere odaklanıyoruz
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if #workspaceChildren >= 17 then
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = character.HumanoidRootPart
            local visited = {}

            -- Tüm Collisions nesnelerinin bir listesini oluşturuyoruz
            local allObjects = {}

            for _, index in ipairs(indices) do
                local folder = workspaceChildren[index]:FindFirstChild("Collisions")

                if folder then
                    for _, obj in ipairs(folder:GetChildren()) do
                        if obj:IsA("BasePart") then
                            table.insert(allObjects, obj)
                        end
                    end
                else
                    warn("İlgili indeksde 'Collisions' klasörü bulunamadı!")
                end
            end

            -- Nesneleri sırasıyla ziyaret etmek için bir işlev
            local function visitNextObject()
                local closestObject = nil
                local closestDistance = math.huge -- Başlangıçta çok uzak bir mesafe

                -- Ziyaret edilmemiş en yakın nesneyi bul
                for _, obj in ipairs(allObjects) do
                    if not visited[obj] then
                        local distance = (humanoidRootPart.Position - obj.Position).Magnitude -- Mesafeyi hesapla
                        if distance < closestDistance then
                            closestDistance = distance
                            closestObject = obj
                        end
                    end
                end

                -- Eğer en yakın nesne bulunduysa, ona ışınlan
                if closestObject then
                    humanoidRootPart.CFrame = closestObject.CFrame + Vector3.new(0, 3, 0) -- Biraz yukarıda ışınlar
                    visited[closestObject] = true -- Gidildi olarak işaretle
                    return true
                end
                return false
            end

            -- Tüm nesneleri toplamak için sırayla git
            local continue = true
            while continue do
                if not isRunning then
                    break -- Eğer işlem durdurulmuşsa döngüden çık
                end
                continue = visitNextObject()
                task.wait(tonumber(SpeedTextBox.Text))  -- Use the user-defined speed value
            end

            print("Tüm nesneler toplandı!")

            -- Şimdi belirtilen CFrames'e gitme işlemi başlasın
            local cframes = {
                CFrame.new(152.464951, 2.91174078, -45.1876373, -0.219859883, 8.02032385e-10, 0.975531459, 6.71054989e-10, 1, -6.70910494e-10, -0.975531459, 5.0712895e-10, -0.219859883),
                CFrame.new(-152.022018, 2.91176748, 89.0239868, -0.930311322, 2.55563481e-09, 0.366770864, 1.13259793e-08, 1, 2.17603215e-08, -0.366770864, 2.4397913e-08, -0.930311322)
            }

            -- Her CFrame için hareket etme işlemi
            for _, targetCFrame in ipairs(cframes) do
                if not isRunning then
                    break -- Eğer işlem durdurulmuşsa döngüden çık
                end
                humanoidRootPart.CFrame = targetCFrame -- CFrame'e ışınlan
                task.wait(2) -- 2 saniye bekle

                -- Karakter biraz ileri gitmesi için
                humanoidRootPart.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 2 -- Biraz ileri hareket et
                task.wait(2) -- 2 saniye bekle
            end

            print("CFrame'lere ışınlanma ve hareket etme tamamlandı!")
        else
            warn("Karakter veya HumanoidRootPart bulunamadı!")
        end
    else
        warn("Workspace içinde en az 17 öğe yok!")
    end
end

-- Start/Stop işlemi
StartStopButton.MouseButton1Click:Connect(function()
    if isRunning then
        -- Duraklatma işlemi
        isRunning = false
        StartStopButton.Text = "Start"
    else
        -- Başlatma işlemi
        isRunning = true
        StartStopButton.Text = "Stop"
        collectionThread = coroutine.create(startCollecting)
        coroutine.resume(collectionThread)
    end
end)
