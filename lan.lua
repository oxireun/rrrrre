--[==[ Obfuscated Lua Script ]==]
local a = Instance.new("ScreenGui") 
a.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local b = Instance.new("Frame")
b.Size = UDim2.new(0, 250, 0, 200)
b.Position = UDim2.new(0.5, -125, 0.5, -100)
b.BackgroundColor3 = Color3.new(0, 0, 0)
b.BorderSizePixel = 2
b.BorderColor3 = Color3.new(1, 1, 1)
b.Active = true
b.Draggable = true
b.Parent = a

local c = Instance.new("TextLabel")
c.Size = UDim2.new(1, 0, 0, 30)
c.BackgroundTransparency = 1
c.Text = "LANCÔME IDÔLE HOUSE"
c.TextColor3 = Color3.new(1, 1, 1)
c.Font = Enum.Font.SourceSansBold
c.TextSize = 16
c.Position = UDim2.new(0, -15, 0, 0)
c.Parent = b

local d = Instance.new("TextLabel")
d.Size = UDim2.new(0, 100, 0, 20)
d.Position = UDim2.new(0, 0, 1, -25)
d.BackgroundTransparency = 1
d.Text = "Yt: oxireun"
d.TextColor3 = Color3.new(1, 1, 1)
d.Font = Enum.Font.SourceSans
d.TextSize = 14
d.Parent = b

local e = Instance.new("TextButton")
e.Size = UDim2.new(0, 20, 0, 20)
e.Position = UDim2.new(1, -30, 0, 3)
e.BackgroundColor3 = Color3.new(0, 0, 1)
e.Text = "X"
e.TextColor3 = Color3.new(1, 1, 1)
e.Font = Enum.Font.SourceSansBold
e.TextSize = 18
e.Parent = b

e.MouseButton1Click:Connect(function()
    a:Destroy()
end)

local f = false
local g = Instance.new("TextButton")
g.Size = UDim2.new(0, 25, 0, 25)
g.Position = UDim2.new(1, -70, 0, 0)
g.BackgroundTransparency = 1
g.Text = "-"
g.TextColor3 = Color3.new(1, 1, 1)
g.Font = Enum.Font.SourceSansBold
g.TextSize = 20
g.Parent = b

g.MouseButton1Click:Connect(function()
    if f then
        b.Size = UDim2.new(0, 250, 0, 200)
        d.Visible = true
        g.Text = "-"
    else
        b.Size = UDim2.new(0, 250, 0, 30)
        d.Visible = false
        g.Text = "+"
    end
    f = not f
end)

local h = false
local i
local function j()
    local k = workspace:GetChildren()
    local l = {16, 17}
    local m = game.Players.LocalPlayer
    local n = m.Character or m.CharacterAdded:Wait()
    if #k >= 17 then
        if n and n:FindFirstChild("HumanoidRootPart") then
            local o = n.HumanoidRootPart
            local p = {}
            local q = {}
            for _, r in ipairs(l) do
                local s = k[r]:FindFirstChild("Collisions")
                if s then
                    for _, t in ipairs(s:GetChildren()) do
                        if t:IsA("BasePart") then
                            table.insert(q, t)
                        end
                    end
                end
            end
            local function u()
                local v, w = nil, math.huge
                for _, x in ipairs(q) do
                    if not p[x] then
                        local y = (o.Position - x.Position).Magnitude
                        if y < w then
                            w, v = y, x
                        end
                    end
                end
                if v then
                    o.CFrame = v.CFrame + Vector3.new(0, 3, 0)
                    p[v] = true
                    return true
                end
                return false
            end
            local z = true
            while z do
                if not h then break end
                z = u()
                task.wait(0.1)
            end
        end
    end
end

local A = Instance.new("TextButton")
A.Size = UDim2.new(0, 150, 0, 40)
A.Position = UDim2.new(0.5, -75, 0, 100)
A.BackgroundColor3 = Color3.new(0, 0, 1)
A.Text = "Start"
A.TextColor3 = Color3.new(1, 1, 1)
A.Font = Enum.Font.SourceSansBold
A.TextSize = 18
A.Parent = b

A.MouseButton1Click:Connect(function()
    if h then
        h = false
        A.Text = "Start"
    else
        h = true
        A.Text = "Stop"
        i = coroutine.create(j)
        coroutine.resume(i)
    end
end)
