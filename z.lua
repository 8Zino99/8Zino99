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
    if aiming then
        targetPlayer = findNearestPlayer()
    end
end

local function aimAtPlayer(player)
    if player and player.Character then
        local playerHeadPosition = player.Character.Head.Position
        local playerBodyPosition = player.Character.HumanoidRootPart.Position
        local aimPosition = playerHeadPosition + Vector3.new(0, 2, 0)
        Camera.CFrame = CFrame.new(aimPosition, playerBodyPosition)
    end
end

local function findNearestPlayer()
    local nearestDistance = math.huge
    local nearestPlayer = nil
    local localPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local distance = (player.Character.HumanoidRootPart.Position - localPosition).magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestPlayer = player
            end
        end
    end
    return nearestPlayer
end

local function updateCamera()
    -- Implementiere die Aktualisierung der Kamera
end

local function checkPlayerInSight()
    -- Implementiere die Überprüfung, ob ein Spieler im Blick ist
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        toggleAiming()
    elseif input.KeyCode == Enum.KeyCode.LeftControl then
        -- Füge hier die Schussfunktionalität ein
    end
end)

while true do
    if aiming and targetPlayer then
        aimAtPlayer(targetPlayer)
    else
        updateCamera()
    end
    checkPlayerInSight()
    updateESP()
    RunService.RenderStepped:Wait()
end
