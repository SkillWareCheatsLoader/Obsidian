-- SkillWare Premium Loader Library (Obsidian Fork by ChatGPT)

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Library = {}
Library.Options = {}
Library.Toggles = {}

-- Background blur
local blur = Instance.new("BlurEffect")
blur.Size = 12
blur.Parent = game.Lighting

-- Main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SkillWareLoaderUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.BackgroundTransparency = 0.25
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(255,0,100)
stroke.Thickness = 1.5
stroke.Transparency = 0.4

-- Tabs system
local Tabs = {}
local currentTab

function Library:CreateWindow(config)
    -- Title Bar
    local Title = Instance.new("TextLabel")
    Title.Text = config.Title or "SkillWare Loader"
    Title.Size = UDim2.new(1,0,0,40)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.Parent = MainFrame

    return Library
end

function Library:AddTab(name)
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1,0,1,-50)
    TabFrame.Position = UDim2.new(0,0,0,50)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = false
    TabFrame.Parent = MainFrame

    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0,100,0,30)
    button.Position = UDim2.new(0, (#Tabs)*110,0,5)
    button.BackgroundColor3 = Color3.fromRGB(30,30,30)
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = MainFrame

    local bcorner = Instance.new("UICorner", button)
    bcorner.CornerRadius = UDim.new(0,6)

    local bstroke = Instance.new("UIStroke", button)
    bstroke.Color = Color3.fromRGB(255,0,100)
    bstroke.Thickness = 1
    bstroke.Transparency = 0.7

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255,50,100)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
    end)

    button.MouseButton1Click:Connect(function()
        if currentTab then currentTab.Visible = false end
        TabFrame.Visible = true
        currentTab = TabFrame
    end)

    table.insert(Tabs, button)
    return TabFrame
end

function Library:AddInput(tab, title, callback)
    local Box = Instance.new("TextBox")
    Box.PlaceholderText = title
    Box.Size = UDim2.new(0,200,0,30)
    Box.Position = UDim2.new(0,10,0,10 + (#tab:GetChildren() * 35))
    Box.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Box.TextColor3 = Color3.fromRGB(255,255,255)
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 14
    Box.Parent = tab

    local icorner = Instance.new("UICorner", Box)
    icorner.CornerRadius = UDim.new(0,6)
    local istroke = Instance.new("UIStroke", Box)
    istroke.Color = Color3.fromRGB(255,0,100)
    istroke.Thickness = 1
    istroke.Transparency = 0.7

    Box.FocusLost:Connect(function()
        callback(Box.Text)
    end)
end

function Library:AddButton(tab, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Text = text
    Btn.Size = UDim2.new(0,200,0,30)
    Btn.Position = UDim2.new(0,10,0,10 + (#tab:GetChildren() * 35))
    Btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Btn.TextColor3 = Color3.fromRGB(255,255,255)
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Btn.Parent = tab

    local ucorner = Instance.new("UICorner", Btn)
    ucorner.CornerRadius = UDim.new(0,6)
    local ustroke = Instance.new("UIStroke", Btn)
    ustroke.Color = Color3.fromRGB(255,0,100)
    ustroke.Thickness = 1
    ustroke.Transparency = 0.7

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255,50,100)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
    end)

    Btn.MouseButton1Click:Connect(function()
        callback()
    end)
end

function Library:Notify(text)
    local Notify = Instance.new("Frame")
    Notify.Size = UDim2.new(0,220,0,50)
    Notify.Position = UDim2.new(1,50,0.8,0)
    Notify.BackgroundColor3 = Color3.fromRGB(255,0,100)
    Notify.BackgroundTransparency = 0.1
    Notify.Parent = ScreenGui

    local ncorner = Instance.new("UICorner", Notify)
    ncorner.CornerRadius = UDim.new(0,8)

    local Label = Instance.new("TextLabel")
    Label.Text = text
    Label.Size = UDim2.new(1,0,1,0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.Parent = Notify

    TweenService:Create(Notify, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(1,-240,0.8,0)}):Play()

    task.delay(3, function()
        TweenService:Create(Notify, TweenInfo.new(0.4), {Position = UDim2.new(1,50,0.8,0)}):Play()
        task.delay(0.5, function()
            Notify:Destroy()
        end)
    end)
end

function Library:Unload()
    blur:Destroy()
    ScreenGui:Destroy()
end

return Library
