local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = game.Workspace.CurrentCamera
local aiming = false
local targetPlayer = nil
local espEnabled = true

local function createESP(player)
    local esp = Instance.new("BillboardGui")
    esp.Name = "PlayerESP"
    esp.Size = UDim2.new(0, 100, 0, 20)
    esp.StudsOffset = Vector3.new(0, 2, 0) -- Offset above player's head
    esp.Adornee = player.Character.Head
    esp.AlwaysOnTop = true
    esp.Enabled = true

    local espLabel = Instance.new("TextLabel")
    espLabel.Name = "Name"
    espLabel.Parent = esp
    espLabel.BackgroundTransparency = 1
    espLabel.Position = UDim2.new(0, 0, 0, 0)
    espLabel.Size = UDim2.new(1, 0, 1, 0)
    espLabel.Font = Enum.Font.SourceSansBold
    espLabel.TextColor3 = Color3.new(1, 1, 1)
    espLabel.TextStrokeTransparency = 0.5
    espLabel.TextSize = 18
    espLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    espLabel.Text = player.Name

    esp.Parent = game.CoreGui
end

local function removeESP(player)
    local esp = game.CoreGui:FindFirstChild(player.Name)
    if esp then
        esp:Destroy()
    end
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character then
            if espEnabled then
                createESP(player)
            else
                removeESP(player)
            end
        end
    end
end

local function toggleAiming()
    aiming = not aiming
end

local function aimAtPlayer(player)
    if player and player.Character then
        local playerHeadPosition = player.Character.Head.Position
        local playerBodyPosition = player.Character.HumanoidRootPart.Position
        local aimPosition = playerHeadPosition + Vector3.new(0, 2, 0) -- Offset for camera position above player's head
        Camera.CFrame = CFrame.new(aimPosition, playerBodyPosition)
    end
end

local function findNearestPlayer()
    -- This function has already been implemented
end

local function updateCamera()
    -- This function has already been implemented
end

local function checkPlayerInSight()
    -- This function has already been implemented
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then -- Right Shift key to toggle aiming
        toggleAiming()
    elseif input.KeyCode == Enum.KeyCode.LeftControl then -- Left Control key for shooting
        -- Implement shooting functionality here
    end
end)

while true do
    if aiming then
        targetPlayer = findNearestPlayer()
        if targetPlayer then
            aimAtPlayer(targetPlayer)
        end
    else
        updateCamera()
    end
    checkPlayerInSight()
    updateESP()
    RunService.RenderStepped:Wait() -- Wait for render step for smooth update
end
