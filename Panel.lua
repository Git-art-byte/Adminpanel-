local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdminPanelGui"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local AdminFrame = Instance.new("Frame")
AdminFrame.Name = "AdminFrame"
AdminFrame.Size = UDim2.new(0.5235, 0, 0.61995, 0)
AdminFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
AdminFrame.AnchorPoint = Vector2.new(0.5, 0.5)
AdminFrame.BackgroundColor3 = Color3.fromRGB(107, 121, 142)
AdminFrame.BackgroundTransparency = 0.2
AdminFrame.BorderSizePixel = 0
AdminFrame.Parent = ScreenGui

-- Top Frame (Title bar)
local TopFrame = Instance.new("Frame")
TopFrame.Name = "TopFrame"
TopFrame.Size = UDim2.new(1, 0, 0.16522, 0)
TopFrame.BackgroundColor3 = Color3.fromRGB(114, 148, 165)
TopFrame.BorderSizePixel = 0
TopFrame.Parent = AdminFrame

-- Title Label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Text = "ADMIN PANEL"
TitleLabel.TextScaled = true
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.Gotham
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(0.596, 0, 1, 0)
TitleLabel.TextWrapped = true
TitleLabel.Parent = TopFrame

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Thickness = 2
TitleStroke.Parent = TitleLabel

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Text = "X"
CloseButton.TextScaled = true
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BackgroundColor3 = Color3.fromRGB(245, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Size = UDim2.new(0.0745, 0, 0.63158, 0)
CloseButton.Position = UDim2.new(0.91117, 0, 0.18421, 0)
CloseButton.Parent = TopFrame

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Thickness = 1.4
CloseStroke.Parent = CloseButton

-- Username TextBox
local UserBox = Instance.new("TextBox")
UserBox.Name = "UserBox"
UserBox.PlaceholderText = "Username.."
UserBox.TextSize = 48
UserBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UserBox.TextXAlignment = Enum.TextXAlignment.Left
UserBox.ClearTextOnFocus = false
UserBox.BackgroundColor3 = Color3.fromRGB(9, 9, 9)
UserBox.PlaceholderColor3 = Color3.fromRGB(97, 97, 97)
UserBox.BorderSizePixel = 0
UserBox.BackgroundTransparency = 0.4
UserBox.Size = UDim2.new(0.55587, 0, 0.84211, 0)
UserBox.Position = UDim2.new(0.02006, 0, 1.18421, 0)
UserBox.Font = Enum.Font.GothamBold
UserBox.Parent = TopFrame

-- Function to create buttons matching your style and position
local function createButton(name, text, posY)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 60
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
	btn.BackgroundTransparency = 0.4
	btn.BorderSizePixel = 0
	btn.Size = UDim2.new(0.26074, 0, 0.89474, 0)
	btn.Position = UDim2.new(0.02006, 0, posY, 0)
	btn.Parent = TopFrame
	return btn
end

-- Create buttons exactly where you placed them
local SlapButton = createButton("SlapButton", "Slap", 2.31579)
local GotoButton = createButton("GotoButton", "Goto", 3.18421)
local EndButton = createButton("EndButton", "End", 4.57895)
local ToolsButton = createButton("ToolsButton", "Tools", 5.0)
local KillButton = createButton("KillButton", "Kill", 4.57895)
local SlapAuraButton = createButton("SlapAuraButton", "Aura", 5.7)

-- Helper functions
local function findPlayerByNameStart(text)
	if not text or text == "" then return nil end
	text = text:lower()
	for _, player in pairs(Players:GetPlayers()) do
		if player.Name:lower():sub(1, #text) == text then
			return player
		end
	end
	return nil
end

local function getCharacter(player)
	return player and player.Character
end

local function equipSecretSlap()
	local backpack = LocalPlayer:FindFirstChild("Backpack")
	local character = LocalPlayer.Character
	if backpack and character then
		local tool = backpack:FindFirstChild("SecretSlap")
		if tool then
			tool.Parent = character
		end
	end
end

local function slapTarget(character, forceVector)
	equipSecretSlap()
	task.wait(0.1)
	pcall(function()
		LocalPlayer.Backpack.SecretSlap.Event:FireServer("slash", character, forceVector)
	end)
end

local function teleportToTarget(character)
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if hrp and myHrp then
		myHrp.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
	end
end

-- Connect buttons to functionality
SlapButton.MouseButton1Click:Connect(function()
	local player = findPlayerByNameStart(UserBox.Text)
	if player then
		local char = getCharacter(player)
		if char then
			local force = Vector3.new(15.39718246459961, -0.000001215329575643409, -12.764276504516602)
			slapTarget(char, force)
		end
	end
end)

KillButton.MouseButton1Click:Connect(function()
	local player = findPlayerByNameStart(UserBox.Text)
	if player then
		local char = getCharacter(player)
		if char then
			local force = Vector3.new(math.huge, math.huge, math.huge)
			slapTarget(char, force)
		end
	end
end)

GotoButton.MouseButton1Click:Connect(function()
	local player = findPlayerByNameStart(UserBox.Text)
	if player then
		local char = getCharacter(player)
		if char then
			teleportToTarget(char)
		end
	end
end)

-- Close button hides the AdminFrame
CloseButton.MouseButton1Click:Connect(function()
	AdminFrame.Visible = false
end)

-- Chat command to toggle panel
LocalPlayer.Chatted:Connect(function(msg)
	if msg:lower() == "/panel" then
		AdminFrame.Visible = not AdminFrame.Visible
	end
end)
