-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CollectionService = game:GetService("CollectionService")

-- GUI Table
local G2L = {}

-- ScreenGui
G2L["ScreenGui_1"] = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
G2L["ScreenGui_1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CollectionService:AddTag(G2L["ScreenGui_1"], "main")

-- AdminFrame (your styled frame)
G2L["AdminFrame_2"] = Instance.new("Frame", G2L["ScreenGui_1"])
G2L["AdminFrame_2"].Name = "AdminFrame"
G2L["AdminFrame_2"].AnchorPoint = Vector2.new(0.5, 0.5)
G2L["AdminFrame_2"].Size = UDim2.new(0.5235, 0, 0.61995, 0)
G2L["AdminFrame_2"].Position = UDim2.new(0.5, 0, 0.5, 0)
G2L["AdminFrame_2"].BackgroundColor3 = Color3.fromRGB(107, 121, 142)
G2L["AdminFrame_2"].BorderSizePixel = 0
G2L["AdminFrame_2"].BackgroundTransparency = 0.2
G2L["AdminFrame_2"].Visible = true

-- TopFrame (title bar)
G2L["TopFrame_3"] = Instance.new("Frame", G2L["AdminFrame_2"])
G2L["TopFrame_3"].Name = "TopFrame"
G2L["TopFrame_3"].Size = UDim2.new(1, 0, 0.16522, 0)
G2L["TopFrame_3"].BackgroundColor3 = Color3.fromRGB(114, 148, 165)
G2L["TopFrame_3"].BorderSizePixel = 0

-- Title Label
G2L["Title_4"] = Instance.new("TextLabel", G2L["TopFrame_3"])
G2L["Title_4"].Name = "Title"
G2L["Title_4"].Text = "ADMIN PANEL"
G2L["Title_4"].TextScaled = true
G2L["Title_4"].BackgroundTransparency = 1
G2L["Title_4"].TextColor3 = Color3.fromRGB(255,255,255)
G2L["Title_4"].Font = Enum.Font.Gotham
G2L["Title_4"].Size = UDim2.new(0.59599, 0, 1, 0)
G2L["Title_4"].TextWrapped = true
Instance.new("UIStroke", G2L["Title_4"]).Thickness = 2

-- Close 'X' Button
G2L["CloseButton_6"] = Instance.new("TextButton", G2L["TopFrame_3"])
G2L["CloseButton_6"].Name = "CloseButton"
G2L["CloseButton_6"].Text = "X"
G2L["CloseButton_6"].TextScaled = true
G2L["CloseButton_6"].BackgroundColor3 = Color3.fromRGB(245, 0, 0)
G2L["CloseButton_6"].TextColor3 = Color3.fromRGB(255,255,255)
G2L["CloseButton_6"].BorderSizePixel = 0
G2L["CloseButton_6"].Size = UDim2.new(0.0745,0,0.63158,0)
G2L["CloseButton_6"].Position = UDim2.new(0.91117,0,0.18421,0)
Instance.new("UIStroke", G2L["CloseButton_6"]).Thickness = 1.4

-- UserBox TextBox
G2L["UserBox_8"] = Instance.new("TextBox", G2L["TopFrame_3"])
G2L["UserBox_8"].Name = "UserBox"
G2L["UserBox_8"].PlaceholderText = "Username.."
G2L["UserBox_8"].TextSize = 48
G2L["UserBox_8"].TextColor3 = Color3.fromRGB(255,255,255)
G2L["UserBox_8"].TextXAlignment = Enum.TextXAlignment.Left
G2L["UserBox_8"].ClearTextOnFocus = false
G2L["UserBox_8"].BackgroundColor3 = Color3.fromRGB(9,9,9)
G2L["UserBox_8"].PlaceholderColor3 = Color3.fromRGB(97,97,97)
G2L["UserBox_8"].BorderSizePixel = 0
G2L["UserBox_8"].BackgroundTransparency = 0.4
G2L["UserBox_8"].Size = UDim2.new(0.55587,0,0.84211,0)
G2L["UserBox_8"].Position = UDim2.new(0.02006,0,1.18421,0)
G2L["UserBox_8"].Font = Enum.Font.GothamBold

-- Custom function to create remaining styled buttons
local function makeBtn(name,text,posY)
	local b = Instance.new("TextButton", G2L["TopFrame_3"])
	b.Name = name
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 60
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.BackgroundColor3 = Color3.fromRGB(8,8,8)
	b.BackgroundTransparency = 0.4
	b.BorderSizePixel = 0
	b.Size = UDim2.new(0.26074,0,0.89474,0)
	b.Position = UDim2.new(0.02006,0,posY,0)
	return b
end

-- All action buttons
local SlapButton = makeBtn("SlapButton","Slap",2.31579)
local GotoButton = makeBtn("GotoButton","Goto",3.18421)
local EndButton = makeBtn("EndButton","End",4.57895) -- keep layout if you want
local ToolsButton = makeBtn("ToolsButton","Tools",5.0)
local KillButton = makeBtn("KillButton","Kill",4.57895)
local SlapAuraButton = makeBtn("SlapAuraButton","Aura",5.7)

-- Functionality
local function findPlayer(input)
	if not input or input == "" then return nil end
	for _,p in pairs(Players:GetPlayers()) do
		if p.Name:lower():sub(1,#input):lower() == input:lower() then
			return p
		end
	end
end

local function getChar(p)
	return p and p.Character
end

local function equip()
	local bp = LocalPlayer.Backpack
	local char = LocalPlayer.Character
	if bp and char then
		local t = bp:FindFirstChild("SecretSlap")
		if t then t.Parent = char end
	end
end

local function fire(targetChar,force)
	equip()
	task.wait(0.1)
	pcall(function()
		LocalPlayer.Backpack.SecretSlap.Event:FireServer("slash",targetChar,force)
	end)
end

local function teleport(targetChar)
	local hrp = targetChar:FindFirstChild("HumanoidRootPart")
	local me = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if hrp and me then me.CFrame = hrp.CFrame + Vector3.new(0,2,0) end
end

-- Button connections
SlapButton.MouseButton1Click:Connect(function()
	local t = findPlayer(G2L["UserBox_8"].Text)
	if t and getChar(t) then fire(getChar(t), Vector3.new(15.397182, -0.0000012, -12.764276)) end
end)
KillButton.MouseButton1Click:Connect(function()
	local t = findPlayer(G2L["UserBox_8"].Text)
	if t and getChar(t) then fire(getChar(t), Vector3.new(math.huge,math.huge,math.huge)) end
end)
GotoButton.MouseButton1Click:Connect(function()
	local t = findPlayer(G2L["UserBox_8"].Text)
	if t and getChar(t) then teleport(getChar(t)) end
end)

-- Close button hides frame
G2L["CloseButton_6"].MouseButton1Click:Connect(function()
	G2L["AdminFrame_2"].Visible = false
end)

-- Chat /panel toggle
LocalPlayer.Chatted:Connect(function(msg)
	if msg:lower() == "/panel" then
		G2L["AdminFrame_2"].Visible = not G2L["AdminFrame_2"].Visible
	end
end)
