-- SERVIÇOS
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- 1. CRIAÇÃO DA INTERFACE (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FreeVipHub"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Quadro Principal (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true -- Importante para o Drag funcionar
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame
MainFrame.Parent = ScreenGui

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Free Vip ⭐️"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

-- Botão VIP
local VipBtn = Instance.new("TextButton")
VipBtn.Size = UDim2.new(0.8, 0, 0, 50)
VipBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
VipBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
VipBtn.Text = "Vip"
VipBtn.Font = Enum.Font.GothamBold
VipBtn.TextSize = 18
VipBtn.TextColor3 = Color3.fromRGB(40, 40, 40)
VipBtn.Parent = MainFrame
local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = VipBtn

-- Créditos
local Credits = Instance.new("TextLabel")
Credits.Size = UDim2.new(1, 0, 0, 30)
Credits.Position = UDim2.new(0, 0, 0.9, 0)
Credits.Text = "Feito por: xCosmico"
Credits.TextColor3 = Color3.new(0.7, 0.7, 0.7)
Credits.BackgroundTransparency = 1
Credits.Font = Enum.Font.Gotham
Credits.TextSize = 14
Credits.Parent = MainFrame

-- Botão Minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(0.85, 0, 0.02, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.Parent = MainFrame
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinBtn

-- 2. NOVO SISTEMA DE ARRASTAR (DRAG) - MAIS ESTÁVEL
local gui = MainFrame
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- 3. FUNCIONALIDADE DO BOTÃO VIP (REMOVER PAREDES)
VipBtn.MouseButton1Click:Connect(function()
	-- Procura e remove objetos chamados "VipWall"
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj.Name == "VIP" or obj.Name == "VIP_PLUS" then
			obj:Destroy()
		end
	end
	print("Paredes VIP removidas!")
end)

-- 4. MINIMIZAR
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		VipBtn.Visible = false
		Credits.Visible = false
		MainFrame:TweenSize(UDim2.new(0, 250, 0, 40), "Out", "Quad", 0.3, true)
		MinBtn.Text = "+"
	else
		MainFrame:TweenSize(UDim2.new(0, 250, 0, 300), "Out", "Quad", 0.3, true)
		task.wait(0.2)
		VipBtn.Visible = true
		Credits.Visible = true
		MinBtn.Text = "-"
	end
end)
