--== GUI Creation ==--
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CollectionService = game:GetService("CollectionService")

local G2L = {}
G2L["ScreenGui_1"] = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
G2L["ScreenGui_1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CollectionService:AddTag(G2L["ScreenGui_1"], "main")

G2L["AdminFrame_2"] = Instance.new("Frame", G2L["ScreenGui_1"])
G2L["AdminFrame_2"].BorderSizePixel = 0
G2L["AdminFrame_2"].BackgroundColor3 = Color3.fromRGB(107, 121, 142)
G2L["AdminFrame_2"].AnchorPoint = Vector2.new(0.5, 0.5)
G2L["AdminFrame_2"].Size = UDim2.new(0.5, 0, 0.6, 0)
G2L["AdminFrame_2"].Position = UDim2.new(0.5, 0, 0.5, 0)
G2L["AdminFrame_2"].Name = "AdminFrame"
G2L["AdminFrame_2"].BackgroundTransparency = 0.2
G2L["AdminFrame_2"].Visible = true -- starts visible

G2L["TopFrame_3"] = Instance.new("Frame", G2L["AdminFrame_2"])
G2L["TopFrame_3"].BorderSizePixel = 0
G2L["TopFrame_3"].BackgroundColor3 = Color3.fromRGB(114, 148, 165)
G2L["TopFrame_3"].Size = UDim2.new(1, 0, 0.165, 0)
G2L["TopFrame_3"].Name = "TopFrame"

G2L["Title_4"] = Instance.new("TextLabel", G2L["TopFrame_3"])
G2L["Title_4"].TextWrapped = true
G2L["Title_4"].BorderSizePixel = 0
G2L["Title_4"].TextScaled = true
G2L["Title_4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
G2L["Title_4"].TextColor3 = Color3.fromRGB(255, 255, 255)
G2L["Title_4"].BackgroundTransparency = 1
G2L["Title_4"].Size = UDim2.new(0.6, 0, 1, 0)
G2L["Title_4"].Text = "ADMIN PANEL"
G2L["Title_4"].Font = Enum.Font.GothamBold
G2L["Title_4"].Name = "Title"
Instance.new("UIStroke", G2L["Title_4"]).Thickness = 2

G2L["UserBox"] = Instance.new("TextBox", G2L["TopFrame_3"])
G2L["UserBox"].Name = "UserBox"
G2L["UserBox"].TextXAlignment = Enum.TextXAlignment.Left
G2L["UserBox"].PlaceholderColor3 = Color3.fromRGB(97, 97, 97)
G2L["UserBox"].BorderSizePixel = 0
G2L["UserBox"].TextSize = 24
G2L["UserBox"].TextColor3 = Color3.fromRGB(255, 255, 255)
G2L["UserBox"].BackgroundColor3 = Color3.fromRGB(9, 9, 9)
G2L["UserBox"].Font = Enum.Font.GothamBold
G2L["UserBox"].ClearTextOnFocus = false
G2L["UserBox"].PlaceholderText = "Username.."
G2L["UserBox"].Size = UDim2.new(0.55, 0, 0.6, 0)
G2L["UserBox"].Position = UDim2.new(0.025, 0, 1.1, 0)
G2L["UserBox"].BackgroundTransparency = 0.4

-- Close Button
local CloseButton = Instance.new("TextButton", G2L["TopFrame_3"])
CloseButton.Name = "CloseButton"
CloseButton.Text = "X"
CloseButton.TextScaled = true
CloseButton.Size = UDim2.new(0.07, 0, 0.6, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0.2, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(245, 0, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UIStroke", CloseButton).Thickness = 1.4

local function createButton(name, text, positionY)
	local btn = Instance.new("TextButton", G2L["TopFrame_3"])
	btn.Name = name
	btn.Text = text
	btn.TextSize = 20
	btn.Size = UDim2.new(0.25, 0, 0.6, 0)
	btn.Position = UDim2.new(0.025, 0, positionY, 0)
	btn.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.BackgroundTransparency = 0.4
	return btn
end

-- Buttons
local SlapButton = createButton("SlapButton", "Slap", 2.3)
local GotoButton = createButton("GotoButton", "Goto", 3.0)
local KillButton = createButton("KillButton", "Kill", 3.7)

--== Functionality ==--

local function findPlayer(input)
	for _, p in pairs(Players:GetPlayers()) do
		if p.Name:lower():sub(1, #input) == input:lower() then
			return p
		end
	end
	return nil
end

local function getCharacter(player)
	return player and player.Character
end

local function equipSlapTool()
	local backpack = LocalPlayer:FindFirstChild("Backpack")
	local character = LocalPlayer.Character
	if backpack and character then
		local tool = backpack:FindFirstChild("SecretSlap")
		if tool then
			tool.Parent = character
		end
	end
end

local function fireSlap(targetChar, forceVec)
	equipSlapTool()
	task.wait(0.1)
	local success, err = pcall(function()
		local args = {
			"slash",
			targetChar,
			forceVec
		}
		LocalPlayer:WaitForChild("Backpack"):WaitForChild("SecretSlap"):WaitForChild("Event"):FireServer(unpack(args))
	end)
	if not success then warn("[SLAP ERROR]:", err) end
end

local function teleportToPlayer(targetChar)
	local hrp = targetChar:FindFirstChild("HumanoidRootPart")
	local myChar = LocalPlayer.Character
	if hrp and myChar and myChar:FindFirstChild("HumanoidRootPart") then
		myChar:FindFirstChild("HumanoidRootPart").CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
	end
end

-- Button Events

SlapButton.MouseButton1Click:Connect(function()
	local nameInput = G2L["UserBox"].Text
	local target = findPlayer(nameInput)
	if target then
		local char = getCharacter(target)
		if char then
			fireSlap(char, Vector3.new(15.397182, -0.0000012, -12.764276))
		end
	end
end)

KillButton.MouseButton1Click:Connect(function()
	local nameInput = G2L["UserBox"].Text
	local target = findPlayer(nameInput)
	if target then
		local char = getCharacter(target)
		if char then
			fireSlap(char, Vector3.new(math.huge, math.huge, math.huge))
		end
	end
end)

GotoButton.MouseButton1Click:Connect(function()
	local nameInput = G2L["UserBox"].Text
	local target = findPlayer(nameInput)
	if target then
		local char = getCharacter(target)
		if char then
			teleportToPlayer(char)
		end
	end
end)

-- Close button hides GUI
CloseButton.MouseButton1Click:Connect(function()
	G2L["AdminFrame_2"].Visible = false
end)

-- Chat command /panel to toggle GUI visibility
LocalPlayer.Chatted:Connect(function(msg)
	if msg:lower() == "/panel" then
		G2L["AdminFrame_2"].Visible = not G2L["AdminFrame_2"].Visible
	end
end)
