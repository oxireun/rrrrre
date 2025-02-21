local a0 = Instance.new("ScreenGui") 
a0.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local b0 = Instance.new("Frame")
b0.Size = UDim2.new(0, 250, 0, 200)
b0.Position = UDim2.new(0.5, -125, 0.5, -100)
b0.BackgroundColor3 = Color3.new(0, 0, 0)
b0.BorderSizePixel = 2
b0.BorderColor3 = Color3.new(1, 1, 1)
b0.Active = true
b0.Draggable = true
b0.Parent = a0

local c0 = Instance.new("TextLabel")
c0.Size = UDim2.new(1, 0, 0, 30)
c0.BackgroundTransparency = 1
c0.Text = "LANCÔME IDÔLE HOUSE"
c0.TextColor3 = Color3.new(1, 1, 1)
c0.Font = Enum.Font.SourceSansBold
c0.TextSize = 16
c0.Position = UDim2.new(0, -15, 0, 0)
c0.Parent = b0

local d0 = Instance.new("TextLabel")
d0.Size = UDim2.new(0, 100, 0, 20)
d0.Position = UDim2.new(0, 0, 1, -25)
d0.BackgroundTransparency = 1
d0.Text = "Yt: oxireun"
d0.TextColor3 = Color3.new(1, 1, 1)
d0.Font = Enum.Font.SourceSans
d0.TextSize = 14
d0.Parent = b0

local e0 = Instance.new("TextButton")
e0.Size = UDim2.new(0, 20, 0, 20)
e0.Position = UDim2.new(1, -30, 0, 3)
e0.BackgroundColor3 = Color3.new(0, 0, 1)
e0.Text = "X"
e0.TextColor3 = Color3.new(1, 1, 1)
e0.Font = Enum.Font.SourceSansBold
e0.TextSize = 18
e0.Parent = b0

e0.MouseButton1Click:Connect(function()
    a0:Destroy()
end)

local f0 = false
local g0 = Instance.new("TextButton")
g0.Size = UDim2.new(0, 25, 0, 25)
g0.Position = UDim2.new(1, -70, 0, 0)
g0.BackgroundTransparency = 1
g0.Text = "-"
g0.TextColor3 = Color3.new(1, 1, 1)
g0.Font = Enum.Font.SourceSansBold
g0.TextSize = 20
g0.Parent = b0

g0.MouseButton1Click:Connect(function()
    if f0 then
        b0.Size = UDim2.new(0, 250, 0, 200)
        d0.Visible = true
        g0.Text = "-"
    else
        b0.Size = UDim2.new(0, 250, 0, 30)
        d0.Visible = false
        g0.Text = "+"
    end
    f0 = not f0
end)

local h0 = false
local i0 = Instance.new("TextButton")
i0.Size = UDim2.new(0, 150, 0, 40)
i0.Position = UDim2.new(0.5, -75, 0, 100)
i0.BackgroundColor3 = Color3.new(0, 0, 1)
i0.Text = "Start"
i0.TextColor3 = Color3.new(1, 1, 1)
i0.Font = Enum.Font.SourceSansBold
i0.TextSize = 18
i0.Parent = b0

local function j0()
    local k0 = workspace:GetChildren()
    local l0 = {16, 17}
    local m0 = game.Players.LocalPlayer
    local n0 = m0.Character or m0.CharacterAdded:Wait()
    
    if #k0 >= 17 then
        if n0 and n0:FindFirstChild("HumanoidRootPart") then
            local o0 = n0.HumanoidRootPart
            local p0 = {}
            local q0 = {}
            
            for _, r0 in ipairs(l0) do
                local s0 = k0[r0]:FindFirstChild("Collisions")
                if s0 then
                    for _, t0 in ipairs(s0:GetChildren()) do
                        if t0:IsA("BasePart") then
                            table.insert(q0, t0)
                        end
                    end
                end
            end
            
            local function u0()
                local v0, w0 = nil, math.huge
                for _, x0 in ipairs(q0) do
                    if not p0[x0] then
                        local y0 = (o0.Position - x0.Position).Magnitude
                        if y0 < w0 then
                            w0 = y0
                            v0 = x0
                        end
                    end
                end
                
                if v0 then
                    o0.CFrame = v0.CFrame + Vector3.new(0, 3, 0)
                    p0[v0] = true
                    return true
                end
                return false
            end
            
            while h0 do
                if not u0() then break end
                task.wait(0.1)
            end
        end
    end
end

i0.MouseButton1Click:Connect(function()
    if h0 then
        h0 = false
        i0.Text = "Start"
    else
        h0 = true
        i0.Text = "Stop"
        coroutine.wrap(j0)()
    end
end)
