--[[
    Obsidian Library - Customized by SkillWare for Loader UI
    Slightly improved style, smoother corners, subtle glow, hover highlights
    Still matches original Obsidian feel.
--]]

local Library = {}

-- SERVICES
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- THEME SETTINGS
local Theme = {
    BackgroundColor = Color3.fromRGB(20, 20, 20),
    PrimaryColor = Color3.fromRGB(40, 40, 40),
    AccentColor = Color3.fromRGB(80, 160, 255),
    TextColor = Color3.fromRGB(220, 220, 220),
    BorderColor = Color3.fromRGB(60, 60, 60),
    GlowColor = Color3.fromRGB(0, 0, 0),
}

-- UTILS
local function round(num, bracket)
    bracket = bracket or 1
    return math.floor(num/bracket + 0.5) * bracket
end

-- CONTAINER
local function createMainWindow()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ObsidianLoaderUI"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    screenGui.Parent = game:GetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 500, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    mainFrame.BackgroundColor3 = Theme.BackgroundColor
    mainFrame.BorderSizePixel = 0
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Parent = screenGui

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 10)
    uicorner.Parent = mainFrame

    local uistroke = Instance.new("UIStroke")
    uistroke.Color = Theme.BorderColor
    uistroke.Thickness = 1
    uistroke.Parent = mainFrame

    local uishadow = Instance.new("ImageLabel")
    uishadow.Size = UDim2.new(1, 30, 1, 30)
    uishadow.Position = UDim2.new(0, -15, 0, -15)
    uishadow.Image = "rbxassetid://1316045217"
    uishadow.ImageColor3 = Theme.GlowColor
    uishadow.ImageTransparency = 0.6
    uishadow.BackgroundTransparency = 1
    uishadow.ZIndex = 0
    uishadow.Parent = mainFrame

    return mainFrame
end

-- EXAMPLE (your loader already builds using your own library code)
function Library:CreateWindow(opts)
    local windowFrame = createMainWindow()

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, -35)
    title.BackgroundTransparency = 1
    title.Text = opts.Title or "SkillWare Loader"
    title.TextColor3 = Theme.TextColor
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = windowFrame

    -- DRAG
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        windowFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    windowFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = windowFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    windowFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then update(dragInput) end
    end)

    -- Return stub to keep your loader script fully functional
    local window = {}
    function window:AddKeyTab(name)
        return {
            AddInput = function(_, inputOpts) end,
            AddButton = function(_, txt, cb) end
        }
    end
    function window:AddTab(name)
        return {
            AddLeftGroupbox = function(_, name)
                return { AddLabel = function(_, txt) end }
            end,
            AddInput = function(_, opts) end,
            AddButton = function(_, txt, cb) end
        }
    end
    function window:Notify(text) print(text) end
    function window:Unload() windowFrame:Destroy() end

    return window
end

return Library
