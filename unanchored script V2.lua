local ScreenGui = Instance.new("ScreenGui")
local MenuFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UsernameBar = Instance.new("TextBox")
local BringButton = Instance.new("TextButton")
local ToggleMenuButton = Instance.new("TextButton")
local InfoText = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

MenuFrame.Parent = ScreenGui
MenuFrame.Size = UDim2.new(0, 400, 0, 300)
MenuFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MenuFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MenuFrame.BackgroundTransparency = 0.2

UICorner.Parent = MenuFrame

Title.Parent = MenuFrame
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "by king_baconROYALTY"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

UsernameBar.Parent = MenuFrame
UsernameBar.Size = UDim2.new(0.6, -10, 0.2, 0)
UsernameBar.Position = UDim2.new(0.05, 0, 0.15, 0)
UsernameBar.PlaceholderText = "Username"
UsernameBar.TextScaled = true
UsernameBar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
UsernameBar.TextColor3 = Color3.fromRGB(0, 0, 0)

InfoText.Parent = MenuFrame
InfoText.Size = UDim2.new(1, 0, 0.1, 0)
InfoText.Position = UDim2.new(0, 0, 0.85, 0)
InfoText.Text = "This script was created by a user with the username king_baconROYALTY, and it does not possess any copyright."
InfoText.TextScaled = true
InfoText.BackgroundTransparency = 1
InfoText.TextColor3 = Color3.fromRGB(255, 0, 0)

BringButton.Parent = MenuFrame
BringButton.Size = UDim2.new(0.3, 0, 0.2, 0)
BringButton.Position = UDim2.new(0.7, 5, 0.15, 0)
BringButton.Text = "Bring"
BringButton.TextScaled = true
BringButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
BringButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local BringUICorner = Instance.new("UICorner")
BringUICorner.Parent = BringButton

ToggleMenuButton.Parent = ScreenGui
ToggleMenuButton.Size = UDim2.new(0, 100, 0, 50)
ToggleMenuButton.Position = UDim2.new(0.5, -50, 0.9, 0)
ToggleMenuButton.Text = "Toggle Menu"
ToggleMenuButton.TextScaled = true
ToggleMenuButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
ToggleMenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local ToggleMenuUICorner = Instance.new("UICorner")
ToggleMenuUICorner.Parent = ToggleMenuButton

local PhysicsActive = false

local function bringUnanchoredToPlayer(targetPlayer)
    local targetChar = targetPlayer.Character
    if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then return end
    local targetPosition = targetChar.HumanoidRootPart.Position
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part.Anchored then
            part.Position = targetPosition
        end
    end
end

BringButton.MouseButton1Click:Connect(function()
    PhysicsActive = not PhysicsActive
    if PhysicsActive then
        BringButton.Text = "Unbring"
    else
        BringButton.Text = "Bring"
    end
end)

UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and PhysicsActive then
        local targetName = UsernameBar.Text
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name == targetName then
                while PhysicsActive do
                    bringUnanchoredToPlayer(player)
                    wait(0.1)
                end
            end
        end
    end
end)

ToggleMenuButton.MouseButton1Click:Connect(function()
    MenuFrame.Visible = not MenuFrame.Visible
end)

local function makeDraggable(frame)
    local dragging
    local dragInput
    local dragStart
    local startPos
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

makeDraggable(MenuFrame)
