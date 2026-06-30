-- [[ Cobel Scripts - Raging DOAB Custom UI ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Reference Script Character Handling Logic
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = newCharacter:WaitForChild("Humanoid")
end)

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CobelScriptsUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- State Variables
local MainSpeed = 16
local SpeedEnabled = false

-- Draggable Script for Mobile Setup
local function makeDraggable(frame)
    local dragStart, startPos
    local dragging = false
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    frame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- Main Window Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 220)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
makeDraggable(MainFrame)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 35)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Text = "Cobel Scripts"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -35, 0, 0)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.BackgroundTransparency = 1
MinBtn.Parent = MainFrame

-- Minimized Round Icon Button
local MinIcon = Instance.new("TextButton")
MinIcon.Size = UDim2.new(0, 130, 0, 40)
MinIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MinIcon.Text = "Raging DOAB"
MinIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
MinIcon.Font = Enum.Font.GothamBold
MinIcon.TextSize = 13
MinIcon.Visible = false
MinIcon.Parent = ScreenGui
makeDraggable(MinIcon)

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 10)
MinCorner.Parent = MinIcon

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinIcon.Position = MainFrame.Position
    MinIcon.Visible = true
end)

MinIcon.MouseButton1Click:Connect(function()
    MinIcon.Visible = false
    MainFrame.Visible = true
end)

-- Navigation Bar
local NavBar = Instance.new("Frame")
NavBar.Size = UDim2.new(1, 0, 0, 25)
NavBar.Position = UDim2.new(0, 0, 0, 35)
NavBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
NavBar.BorderSizePixel = 0
NavBar.Parent = MainFrame

local MainTabBtn = Instance.new("TextButton")
MainTabBtn.Size = UDim2.new(0.5, 0, 1, 0)
MainTabBtn.Text = "Main"
MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTabBtn.Font = Enum.Font.GothamBold
MainTabBtn.TextSize = 12
MainTabBtn.BackgroundTransparency = 1
MainTabBtn.Parent = NavBar

local OthersTabBtn = Instance.new("TextButton")
OthersTabBtn.Size = UDim2.new(0.5, 0, 1, 0)
OthersTabBtn.Position = UDim2.new(0.5, 0, 0, 0)
OthersTabBtn.Text = "Others"
OthersTabBtn.TextColor3 = Color3.fromRGB(140, 140, 145)
OthersTabBtn.Font = Enum.Font.GothamBold
OthersTabBtn.TextSize = 12
OthersTabBtn.BackgroundTransparency = 1
OthersTabBtn.Parent = NavBar

-- Content Area (With Scrolling Capability for space management)
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -20, 1, -80)
ContentFrame.Position = UDim2.new(0, 10, 0, 65)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 160)
ContentFrame.ScrollBarThickness = 4
ContentFrame.Parent = MainFrame

-- Page Systems
local MainPage = Instance.new("Frame")
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.BackgroundTransparency = 1
MainPage.Parent = ContentFrame

local OthersPage = Instance.new("Frame")
OthersPage.Size = UDim2.new(1, 0, 1, 0)
OthersPage.BackgroundTransparency = 1
OthersPage.Visible = false
OthersPage.Parent = ContentFrame

MainTabBtn.MouseButton1Click:Connect(function()
    MainPage.Visible = true
    OthersPage.Visible = false
    MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    OthersTabBtn.TextColor3 = Color3.fromRGB(140, 140, 145)
end)

OthersTabBtn.MouseButton1Click:Connect(function()
    MainPage.Visible = false
    OthersPage.Visible = true
    MainTabBtn.TextColor3 = Color3.fromRGB(140, 140, 145)
    OthersTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

-- MAIN PAGE CONTENT: Speed Configuration
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0, 130, 0, 32)
SpeedInput.Position = UDim2.new(0, 10, 0, 15)
SpeedInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
SpeedInput.Text = "16"
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 14
SpeedInput.Parent = MainPage

local SpeedInputCorner = Instance.new("UICorner")
SpeedInputCorner.CornerRadius = UDim.new(0, 4)
SpeedInputCorner.Parent = SpeedInput

local ToggleSpeedBtn = Instance.new("TextButton")
ToggleSpeedBtn.Size = UDim2.new(0, 140, 0, 32)
ToggleSpeedBtn.Position = UDim2.new(0, 150, 0, 15)
ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(160, 50, 50)
ToggleSpeedBtn.Text = "Toggle Speed: OFF"
ToggleSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleSpeedBtn.Font = Enum.Font.GothamBold
ToggleSpeedBtn.TextSize = 12
ToggleSpeedBtn.Parent = MainPage

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 4)
ToggleCorner.Parent = ToggleSpeedBtn

SpeedInput.FocusLost:Connect(function()
    local num = tonumber(SpeedInput.Text)
    if num then MainSpeed = num else SpeedInput.Text = tostring(MainSpeed) end
end)

ToggleSpeedBtn.MouseButton1Click:Connect(function()
    SpeedEnabled = not SpeedEnabled
    if SpeedEnabled then
        ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 140, 50)
        ToggleSpeedBtn.Text = "Toggle Speed: ON"
    else
        ToggleSpeedBtn.BackgroundColor3 = Color3.fromRGB(160, 50, 50)
        ToggleSpeedBtn.Text = "Toggle Speed: OFF"
        -- Reset to normal when toggled off
        if Humanoid then Humanoid.WalkSpeed = 16 end
    end
end)

-- OTHERS PAGE CONTENT: Social Profiles
local SocialsLabel = Instance.new("TextLabel")
SocialsLabel.Size = UDim2.new(1, 0, 0, 100)
SocialsLabel.Position = UDim2.new(0, 0, 0, 10)
SocialsLabel.Text = "Discord: CobelScripts\nYouTube: @CobelScripts\n\nCustom UI Framework successfully re-implemented."
SocialsLabel.TextColor3 = Color3.fromRGB(190, 190, 195)
SocialsLabel.Font = Enum.Font.Gotham
SocialsLabel.TextSize = 13
SocialsLabel.BackgroundTransparency = 1
SocialsLabel.Parent = OthersPage

-- Bottom Credit Label
local Credits = Instance.new("TextLabel")
Credits.Size = UDim2.new(1, 0, 0, 15)
Credits.Position = UDim2.new(0, 0, 1, -15)
Credits.Text = "made by CobelScripts"
Credits.TextColor3 = Color3.fromRGB(110, 110, 115)
Credits.Font = Enum.Font.Gotham
Credits.TextSize = 10
Credits.BackgroundTransparency = 1
Credits.Parent = MainFrame

-- Continuous Execution Hook (From Reference Engine Features)
RunService.Heartbeat:Connect(function()
    if SpeedEnabled and Humanid then
        Humanoid.WalkSpeed = MainSpeed
    end
end)

print("System successfully re-implemented and loaded.")
