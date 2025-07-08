-- // SkillWare Obsidian UI Library (Blue Accent)
-- Based on: https://github.com/deividcomsono/Obsidian
-- Customized by SkillWare

local Library = {}

-- CONFIG
Library.AccentColor = Color3.fromRGB(0, 146, 255)
Library.Objects = {}

-- Example function to register objects for theme changes
function Library:Register(obj)
    table.insert(self.Objects, obj)
end

-- Function to apply the theme
function Library:ApplyTheme()
    for _, obj in ipairs(self.Objects) do
        if obj:IsA("Frame") or obj:IsA("TextButton") or obj:IsA("TextLabel") then
            if obj.Name:find("Accent") or obj.Name:find("Toggle") or obj.Name:find("Slider") then
                obj.BackgroundColor3 = self.AccentColor
            elseif obj.Name:find("Icon") then
                obj.ImageColor3 = self.AccentColor
            end
        end
    end
end

-- FAKE CreateWindow to simulate the same API as your Obsidian
function Library:CreateWindow(opts)
    local win = Instance.new("ScreenGui")
    win.Name = opts.Title or "SkillWare Window"
    win.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 500, 0, 400)
    frame.Position = UDim2.new(0.5, -250, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Parent = win
    self:Register(frame)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Text = opts.Title or "SkillWare"
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundColor3 = self.AccentColor
    title.Parent = frame
    self:Register(title)

    return {
        AddTab = function(_, name)
            local tab = Instance.new("Frame")
            tab.Size = UDim2.new(1, 0, 1, -50)
            tab.Position = UDim2.new(0, 0, 0, 50)
            tab.BackgroundColor3 = Color3.fromRGB(40,40,40)
            tab.Parent = frame
            self:Register(tab)
            return tab
        end
    }
end

return Library
