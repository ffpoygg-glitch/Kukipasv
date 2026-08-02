-- =====================================================================
-- ระบบป้องกันการ Dump / Hook เบื้องต้นในโค้ด Lua (คงเดิม 100%)
-- =====================================================================

if getrawmetatable and setreadonly then
    local mt = getrawmetatable(game)
    if not isreadonly(mt) then
        pcall(function()
            game:GetService("Players").LocalPlayer:Kick("❌ ตรวจพบความผิดปกติในการดักจับระบบ (Security Violation)")
        end)
        return
    end
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local CurrentSelectedPlayer = nil
local StatusLabel = nil

local AssetCache = {}

-- ==================== รายชื่อ Admin Whitelist ====================
local AdminList = {
    ["kfc_punyai"] = true,
    ["Aekshop_34d3c"] = true,
    ["CGGG_PRJOOOO"] = true,
    ["Haren_902"] = true,
}

local function IsAdmin(player)
    if not player then return false end
    return AdminList[player.Name] == true
end

local function IsLocalAdmin()
    return IsAdmin(LocalPlayer)
end

-- ==================== ระบบคำสั่ง Admin ผ่านแชท (ใช้งานได้จริง) ====================
local TextChatService = game:GetService("TextChatService")

local function getTargetPlayer(nameStr)
    if not nameStr then return nil end
    nameStr = string.lower(nameStr)
    for _, p in ipairs(Players:GetPlayers()) do
        if string.find(string.lower(p.Name), nameStr) or string.find(string.lower(p.DisplayName), nameStr) then
            return p
        end
    end
    return nil
end

local TAG_NAME = "Honkuki_Active_Runner_Tag"

local function processAdminCommand(player, msg)
    if not IsAdmin(player) then return end
    
    local args = {}
    for word in string.gmatch(msg, "%S+") do
        table.insert(args, word)
    end
    
    local cmd = string.lower(args[1] or "")
    
    if cmd == ";bring" then
        local target = getTargetPlayer(args[2])
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            target.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    elseif cmd == ";fly" then
        local target = getTargetPlayer(args[2]) or player
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = target.Character.HumanoidRootPart
            if not hrp:FindFirstChild("HonFlyBodyVelocity") then
                local bv = Instance.new("BodyVelocity", hrp)
                bv.Name = "HonFlyBodyVelocity"
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.Velocity = Vector3.new(0, 0, 0)
            end
        end
    elseif cmd == ";unfly" then
        local target = getTargetPlayer(args[2]) or player
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local bv = target.Character.HumanoidRootPart:FindFirstChild("HonFlyBodyVelocity")
            if bv then bv:Destroy() end
        end
    elseif cmd == ";freeze" then
        local target = getTargetPlayer(args[2])
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            target.Character.HumanoidRootPart.Anchored = true
        end
    elseif cmd == ";unfreeze" then
        local target = getTargetPlayer(args[2])
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            target.Character.HumanoidRootPart.Anchored = false
        end
    elseif cmd == ";check" then
        if player == LocalPlayer then
            local runningCount = 0
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild(TAG_NAME) then
                    runningCount = runningCount + 1
                end
            end
            if StatusLabel then
                StatusLabel.Text = "🛡️ ตรวจพบผู้เล่นรันสคริปต์ทั้งหมด: " .. runningCount .. " คน"
            end
        end
    elseif cmd == ";fling" then
        local target = getTargetPlayer(args[2])
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            target.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(99999, 99999, 99999)
        end
    elseif cmd == ";void" then
        local target = getTargetPlayer(args[2])
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            target.Character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0)
        end
    elseif cmd == ";kill" then
        local target = getTargetPlayer(args[2])
        if target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") then
            target.Character:FindFirstChildOfClass("Humanoid").Health = 0
        end
    elseif cmd == ";tp" then
        local target1 = getTargetPlayer(args[2])
        local target2 = getTargetPlayer(args[3])
        if target1 and target2 and target1.Character and target2.Character then
            local hrp1 = target1.Character:FindFirstChild("HumanoidRootPart")
            local hrp2 = target2.Character:FindFirstChild("HumanoidRootPart")
            if hrp1 and hrp2 then
                hrp1.CFrame = hrp2.CFrame + Vector3.new(0, 3, 0)
            end
        end
    elseif cmd == ";op" and string.lower(args[2] or "") == "all" then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local adminPos = player.Character.HumanoidRootPart.CFrame
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild(TAG_NAME) then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = adminPos + Vector3.new(math.random(-3, 3), 3, math.random(-3, 3))
                    end
                end
            end
        end
    end
end

local function fromTextBoxMessage(textChatMessage)
    if not textChatMessage or not textChatMessage.TextSource then return end
    local speaker = Players:GetPlayerByUserId(textChatMessage.TextSource.UserId)
    if speaker and IsAdmin(speaker) then
        processAdminCommand(speaker, textChatMessage.Text)
    end
end

local function setupAdminCommands(player)
    if not IsAdmin(player) then return end
    
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            local generalChannel = channels:FindFirstChild("RBXGeneral")
            if generalChannel then
                generalChannel.MessageReceived:Connect(fromTextBoxMessage)
            end
        end
    end
    
    player.Chatted:Connect(function(msg)
        processAdminCommand(player, msg)
    end)
end

for _, p in ipairs(Players:GetPlayers()) do
    setupAdminCommands(p)
end
Players.PlayerAdded:Connect(setupAdminCommands)

-- ==================== ระบบสื่อสาร & TAG บนหัว ====================
local function markSelfAsRunner()
    if LocalPlayer.Character then
        local tagVal = LocalPlayer.Character:FindFirstChild(TAG_NAME)
        if not tagVal then
            tagVal = Instance.new("BoolValue")
            tagVal.Name = TAG_NAME
            tagVal.Value = true
            tagVal.Parent = LocalPlayer.Character
        end
    end
end

markSelfAsRunner()
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    markSelfAsRunner()
end)

local function setupPlayerTag(player)
    if not player or not player.Character then return end
    local char = player.Character
    local head = char:WaitForChild("Head", 5)
    if not head then return end

    if not char:FindFirstChild(TAG_NAME) and player ~= LocalPlayer then
        if head:FindFirstChild("HonkukiHeadTag") then
            head.HonkukiHeadTag:Destroy()
        end
        return
    end

    if head:FindFirstChild("HonkukiHeadTag") then
        head.HonkukiHeadTag:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "HonkukiHeadTag"
    billboard.Size = UDim2.new(0, 160, 0, 32)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local tagLabel = Instance.new("TextLabel", billboard)
    tagLabel.Size = UDim2.new(1, 0, 1, 0)
    tagLabel.BackgroundTransparency = 1
    tagLabel.Font = Enum.Font.GothamBold
    tagLabel.TextSize = 12
    tagLabel.TextStrokeTransparency = 0.2

    if IsAdmin(player) then
        tagLabel.Text = "👑 [ ADMIN ]"
        tagLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        tagLabel.TextStrokeColor3 = Color3.fromRGB(150, 100, 0)
    else
        tagLabel.Text = "🔰 [ PLAYER ]"
        tagLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
        tagLabel.TextStrokeColor3 = Color3.fromRGB(0, 100, 50)
    end
end

-- ==================== 2 REMOTE COMBO FOR MUSIC ====================
local function ForcePlayMusicCombo(musicId)
    if not musicId or musicId == "" then return false end
    local re = ReplicatedStorage:FindFirstChild("RE")
    if not re then return false end
    
    local success1, success2, success3 = false, false, false
    local toolEvent = re:FindFirstChild("PlayerToolEvent")
    if toolEvent then
        local args1 = { "ToolMusicText", tostring(musicId), "", [4] = true }
        success1 = pcall(function() toolEvent:FireServer(unpack(args1)) end)
    end
    
    local vehicleEvent = re:FindFirstChild("1NoMoto1rVehicle1s")
    if vehicleEvent then
        local args2 = { "ToolMusicText", tostring(musicId), "", [4] = true }
        success2 = pcall(function() vehicleEvent:FireServer(unpack(args2)) end)
        
        local args3 = { "PickingScooterMusicText", tostring(musicId), "", [4] = true }
        success3 = pcall(function() vehicleEvent:FireServer(unpack(args3)) end)
    end
    
    return success1 or success2 or success3
end

-- ==================== ระบบบล็อค ID ปลอม ====================
local BlockedIDs = {
    ["54410081542"] = true, ["70999314371231"] = true,
    ["71352236"] = true, ["76500780055460"] = true,
    ["78515442941510"] = true, ["90533928572341"] = true,
    ["99721399503975"] = true, ["00101020203030404"] = true,
}

local function urlDecode(str)
    if not str then return "" end
    str = string.gsub(str, "+", " ")
    return (string.gsub(str, "%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end))
end

local function hexDecode(str)
    if not str then return "" end
    str = string.gsub(str, "0x", "")
    str = string.gsub(str, "\\x", "")
    str = string.gsub(str, "%%", "")
    str = string.gsub(str, "%s+", "")
    
    if string.match(str, "^%x+$") and #str % 2 == 0 then
        local decoded = ""
        for i = 1, #str, 2 do
            local byteStr = string.sub(str, i, i+1)
            local byte = tonumber(byteStr, 16)
            if byte then 
                decoded = decoded .. string.char(byte) 
            end
        end
        if #decoded > 0 then return decoded end
    end
    return str
end

local function deepDecode(str)
    if type(str) ~= "string" then return str end
    local prev
    repeat
        prev = str
        str = urlDecode(str)
        str = hexDecode(str)
    until str == prev
    return str
end

local function extractIDsFromPattern(text)
    local ids = {}
    local patterns = {
        "69%%64=([^&]*)", "&id=([^&]*)", "id=([^&]*)",
        "audio=([^&]*)", "song=([^&]*)", "music=([^&]*)",
        "%%69%%64=([^&]*)", "&%%69%%64=([^&]*)",
        "9%s*d%s*=%s*([^&]*)", "9d=([^&]*)", "9_d=([^&]*)", "9%%20d%%20=([^&]*)"
    }
    for _, pat in ipairs(patterns) do
        for capture in string.gmatch(text, pat) do
            for num in string.gmatch(capture, "%d+") do
                if not BlockedIDs[num] then
                    table.insert(ids, num)
                end
            end
        end
    end
    return ids
end

local function getPlayerVehicle(player)
    if not player then return nil end
    local character = player.Character
    if not character then return nil end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return nil end
    local seatPart = humanoid.SeatPart
    if not seatPart then return nil end
    local vehicle = seatPart.Parent
    while vehicle and not vehicle:IsA("Model") do
        vehicle = vehicle.Parent
    end
    if vehicle and vehicle:IsA("Model") then
        return vehicle
    end
    return nil
end

local function checkPlayerAllSounds(targetPlayer)
    if not targetPlayer then return {} end
    -- ป้องกันไม่ให้ผู้เล่นทั่วไปสแกนเสียงของ Admin (ตีกลับเป็น protection ทันที)
    if IsAdmin(targetPlayer) and not IsLocalAdmin() then
        return {}
    end

    local scanTargets = {}
    if targetPlayer.Character then table.insert(scanTargets, targetPlayer.Character) end
    local backpack = targetPlayer:FindFirstChild("Backpack")
    if backpack then table.insert(scanTargets, backpack) end
    
    local vehicle = getPlayerVehicle(targetPlayer)
    if vehicle then table.insert(scanTargets, vehicle) end

    local validSounds = {}
    local soundMap = {}
    local NameBlacklist = {
        ["gettingup"] = true, ["died"] = true, ["freefalling"] = true,
        ["jumping"] = true, ["landing"] = true, ["running"] = true,
        ["splash"] = true, ["swimming"] = true, ["climbing"] = true,
        ["engine"] = true, ["motor"] = true, ["horn"] = true
    }

    for _, folder in ipairs(scanTargets) do
        local success, descendants = pcall(function() return folder:GetDescendants() end)
        if success and descendants then
            for _, obj in ipairs(descendants) do
                if obj:IsA("Sound") and obj.SoundId ~= "" and obj.IsPlaying then
                    local soundNameLower = string.lower(obj.Name)
                    local isBlacklisted = false
                    for blockedName, _ in pairs(NameBlacklist) do
                        if string.find(soundNameLower, blockedName) then
                            isBlacklisted = true
                            break
                        end
                    end
                    if not isBlacklisted then
                        local key = obj.SoundId
                        if not soundMap[key] then
                            soundMap[key] = true
                            table.insert(validSounds, obj)
                        end
                    end
                end
            end
        end
    end
    return validSounds
end

local function copyToClipboard(text)
    local setclip = setclipboard or toclipboard or (Clipboard and Clipboard.set)
    if setclip then setclip(text) end
end

local function playMusicFromId(musicId)
    return ForcePlayMusicCombo(musicId)
end

-- ==================== โครงสร้าง UI หลัก ====================
if PlayerGui:FindFirstChild("Honkuki-191") then PlayerGui.Honkuki_DeepSoundSpy:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "เมนูสคริปดึงเพลงBY.HONKUKI⊂⁠(⁠◉⁠‿⁠◉⁠)⁠つ"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function setDrag(frame, handle)
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 200)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BackgroundTransparency = 1
MainFrame.Visible = false
MainFrame.ZIndex = 1
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local mStroke = Instance.new("UIStroke", MainFrame)
mStroke.Color = Color3.fromRGB(255, 215, 0)
mStroke.Transparency = 1

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)
setDrag(MainFrame, TopBar)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -15, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "✨ สคริปดึงเพลงHonkuki ✨"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left

local ListScroll = Instance.new("ScrollingFrame", MainFrame)
ListScroll.Size = UDim2.new(0.45, 0, 0, 115)
ListScroll.Position = UDim2.new(0.03, 0, 0.22, 0)
ListScroll.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
ListScroll.BorderSizePixel = 0
ListScroll.ScrollBarThickness = 4
ListScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", ListScroll).CornerRadius = UDim.new(0, 8)

local Layout = Instance.new("UIListLayout", ListScroll)
Layout.Padding = UDim.new(0, 5)

local ButtonsContainer = Instance.new("Frame", MainFrame)
ButtonsContainer.Size = UDim2.new(0.47, 0, 0, 115)
ButtonsContainer.Position = UDim2.new(0.5, 0, 0.22, 0)
ButtonsContainer.BackgroundTransparency = 1

local BLayout = Instance.new("UIListLayout", ButtonsContainer)
BLayout.Padding = UDim.new(0, 6)

local GetIDBtn = Instance.new("TextButton", ButtonsContainer)
GetIDBtn.Size = UDim2.new(1, 0, 0, 22)
GetIDBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
GetIDBtn.Text = "⚡ เจาะเพลง"
GetIDBtn.Font = Enum.Font.GothamBold
GetIDBtn.TextSize = 11
GetIDBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", GetIDBtn).CornerRadius = UDim.new(0, 6)

local GetJunkBtn = Instance.new("TextButton", ButtonsContainer)
GetJunkBtn.Size = UDim2.new(1, 0, 0, 22)
GetJunkBtn.BackgroundColor3 = Color3.fromRGB(230, 90, 40)
GetJunkBtn.Text = "🎵 เปิดเพลงตามขยะอย่างเดียว"
GetJunkBtn.Font = Enum.Font.GothamBold
GetJunkBtn.TextSize = 11
GetJunkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", GetJunkBtn).CornerRadius = UDim.new(0, 6)

local ViewRawJunkBtn = Instance.new("TextButton", ButtonsContainer)
ViewRawJunkBtn.Size = UDim2.new(1, 0, 0, 22)
ViewRawJunkBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230)
ViewRawJunkBtn.Text = "ดูRawดิบ"
ViewRawJunkBtn.Font = Enum.Font.GothamBold
ViewRawJunkBtn.TextSize = 11
ViewRawJunkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ViewRawJunkBtn).CornerRadius = UDim.new(0, 6)

local ViewInstantBtn = Instance.new("TextButton", ButtonsContainer)
ViewInstantBtn.Size = UDim2.new(1, 0, 0, 22)
ViewInstantBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ViewInstantBtn.Text = "ดูไอดีที่เจาะReal time"
ViewInstantBtn.Font = Enum.Font.GothamBold
ViewInstantBtn.TextSize = 11
ViewInstantBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ViewInstantBtn).CornerRadius = UDim.new(0, 6)

-- ปุ่ม Audio Logger (กลุ่มใหม่ตามที่คุณสั่ง)
local AudioLoggerBtn = Instance.new("TextButton", ButtonsContainer)
AudioLoggerBtn.Size = UDim2.new(1, 0, 0, 22)
AudioLoggerBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
AudioLoggerBtn.Text = "🎧 Audio Logger (สแกนเพลงทั้งหมด)"
AudioLoggerBtn.Font = Enum.Font.GothamBold
AudioLoggerBtn.TextSize = 11
AudioLoggerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", AudioLoggerBtn).CornerRadius = UDim.new(0, 6)

StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Size = UDim2.new(0.68, 0, 0, 24)
StatusLabel.Position = UDim2.new(0.03, 0, 0.82, 0)
StatusLabel.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
StatusLabel.BackgroundTransparency = 0.9
StatusLabel.Text = "เลือกชื่อผู้เล่นก่อนดึงไอดีเพลง"
StatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.TextWrapped = true
Instance.new("UICorner", StatusLabel).CornerRadius = UDim.new(0, 4)

local RefreshBtn = Instance.new("TextButton", MainFrame)
RefreshBtn.Size = UDim2.new(0.24, 0, 0, 24)
RefreshBtn.Position = UDim2.new(0.73, 0, 0.82, 0)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
RefreshBtn.Text = "🔄 รีเฟรชรายชื่อ"
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.TextSize = 10
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", RefreshBtn).CornerRadius = UDim.new(0, 6)

local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 52, 0, 52)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleBtn.Image = "rbxassetid://104747656190057"
ToggleBtn.ZIndex = 10
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 16)
local tStroke = Instance.new("UIStroke", ToggleBtn)
tStroke.Color = Color3.fromRGB(255, 215, 0)
tStroke.Thickness = 2
setDrag(ToggleBtn, ToggleBtn)

-- ==================== หน้าต่างรองส่อง / Audio Logger ====================
local JunkFrame = Instance.new("Frame", ScreenGui)
JunkFrame.Size = UDim2.new(0, 440, 0, 270)
JunkFrame.Position = UDim2.new(0.5, -220, 0.5, -135)
JunkFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
JunkFrame.BackgroundTransparency = 1
JunkFrame.Visible = false
JunkFrame.ZIndex = 5
Instance.new("UICorner", JunkFrame).CornerRadius = UDim.new(0, 12)
local jStroke = Instance.new("UIStroke", JunkFrame)
jStroke.Color = Color3.fromRGB(0, 150, 255)
jStroke.Transparency = 1

local JunkTopBar = Instance.new("Frame", JunkFrame)
JunkTopBar.Size = UDim2.new(1, 0, 0, 32)
JunkTopBar.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
Instance.new("UICorner", JunkTopBar).CornerRadius = UDim.new(0, 12)
setDrag(JunkFrame, JunkTopBar)

local JunkTitle = Instance.new("TextLabel", JunkTopBar)
JunkTitle.Size = UDim2.new(1, -15, 1, 0)
JunkTitle.Position = UDim2.new(0, 15, 0, 0)
JunkTitle.BackgroundTransparency = 1
JunkTitle.Text = "🎧 Audio Logger & Raw Viewer"
JunkTitle.TextColor3 = Color3.fromRGB(100, 200, 255)
JunkTitle.Font = Enum.Font.GothamBold
JunkTitle.TextSize = 11
JunkTitle.TextXAlignment = Enum.TextXAlignment.Left

local JunkScroll = Instance.new("ScrollingFrame", JunkFrame)
JunkScroll.Size = UDim2.new(0.94, 0, 0, 170)
JunkScroll.Position = UDim2.new(0.03, 0, 0.16, 0)
JunkScroll.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
JunkScroll.BorderSizePixel = 0
JunkScroll.ScrollBarThickness = 4
JunkScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
Instance.new("UICorner", JunkScroll).CornerRadius = UDim.new(0, 8)

local JunkLayout = Instance.new("UIListLayout", JunkScroll)
JunkLayout.Padding = UDim.new(0, 4)

-- ข้อความสำรองกรณีไม่มีข้อมูล
local JunkTextLabel = Instance.new("TextLabel", JunkScroll)
JunkTextLabel.Size = UDim2.new(1, -10, 0, 40)
JunkTextLabel.BackgroundTransparency = 1
JunkTextLabel.Text = "ไม่มีข้อมูลเพลงผู้เล่น หรือผู้เล่นไม่ได้เปิดเพลงภายในแมพ"
JunkTextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
JunkTextLabel.Font = Enum.Font.Code
JunkTextLabel.TextSize = 11
JunkTextLabel.TextXAlignment = Enum.TextXAlignment.Left
JunkTextLabel.TextYAlignment = Enum.TextYAlignment.Top
JunkTextLabel.TextWrapped = true

-- ปุ่มด้านล่างหน้าต่างรอง
local JunkCopyBtn = Instance.new("TextButton", JunkFrame)
JunkCopyBtn.Size = UDim2.new(0.30, 0, 0, 28)
JunkCopyBtn.Position = UDim2.new(0.03, 0, 0.86, 0)
JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
JunkCopyBtn.Text = "📋 คัดลอกโค้ดทั้งหมด"
JunkCopyBtn.Font = Enum.Font.GothamBold
JunkCopyBtn.TextSize = 10
JunkCopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", JunkCopyBtn).CornerRadius = UDim.new(0, 6)

local LiveListenBtn = Instance.new("TextButton", JunkFrame)
LiveListenBtn.Size = UDim2.new(0.30, 0, 0, 28)
LiveListenBtn.Position = UDim2.new(0.35, 0, 0.86, 0)
LiveListenBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
LiveListenBtn.Text = "🔊 เปิดฟัง (หูเรา)"
LiveListenBtn.Font = Enum.Font.GothamBold
LiveListenBtn.TextSize = 10
LiveListenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", LiveListenBtn).CornerRadius = UDim.new(0, 6)

local JunkBackBtn = Instance.new("TextButton", JunkFrame)
JunkBackBtn.Size = UDim2.new(0.30, 0, 0, 28)
JunkBackBtn.Position = UDim2.new(0.67, 0, 0.86, 0)
JunkBackBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
JunkBackBtn.Text = "⬅️ ย้อนกลับ"
JunkBackBtn.Font = Enum.Font.GothamBold
JunkBackBtn.TextSize = 10
JunkBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", JunkBackBtn).CornerRadius = UDim.new(0, 6)

-- ==================== ระบบ Animation & Toggle ====================
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local function toggleUI(isOpen)
    if isOpen then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, tweenInfo, {BackgroundTransparency = 0.15}):Play()
        TweenService:Create(mStroke, tweenInfo, {Transparency = 0}):Play()
    else
        local tw1 = TweenService:Create(MainFrame, tweenInfo, {BackgroundTransparency = 1})
        local tw2 = TweenService:Create(mStroke, tweenInfo, {Transparency = 1})
        tw1:Play()
        tw2:Play()
        tw1.Completed:Connect(function()
            if MainFrame.BackgroundTransparency == 1 then
                MainFrame.Visible = false
                JunkFrame.Visible = false
            end
        end)
    end
end

local function toggleJunkUI(isOpen)
    if isOpen then
        JunkFrame.Visible = true
        TweenService:Create(JunkFrame, tweenInfo, {BackgroundTransparency = 0.1}):Play()
        TweenService:Create(jStroke, tweenInfo, {Transparency = 0}):Play()
    else
        local tw1 = TweenService:Create(JunkFrame, tweenInfo, {BackgroundTransparency = 1})
        local tw2 = TweenService:Create(jStroke, tweenInfo, {Transparency = 1})
        tw1:Play()
        tw2:Play()
        tw1.Completed:Connect(function()
            if JunkFrame.BackgroundTransparency == 1 then
                JunkFrame.Visible = false
            end
        end)
    end
end

local CurrentViewMode = 1 -- 1: Raw, 2: Instant, 3: Audio Logger
local PlayerButtons = {}
local activePreviewSound = nil

local function stopActivePreview()
    if activePreviewSound and activePreviewSound.Parent then
        activePreviewSound:Stop()
        activePreviewSound:Destroy()
    end
    activePreviewSound = nil
end

local CurrentViewMode = 1 -- 1: Raw, 2: Instant, 3: Audio Logger
local PlayerButtons = {}
local activePreviewSound = nil

local function stopActivePreview()
    if activePreviewSound and activePreviewSound.Parent then
        activePreviewSound:Stop()
        activePreviewSound:Destroy()
    end
    activePreviewSound = nil
end

local function updateJunkViewerLive()
    if not JunkFrame.Visible then return end
    
    -- ล้างรายการแถบเก่าใน ScrollingFrame ทิ้งก่อนสร้างใหม่
    for _, child in ipairs(JunkScroll:GetChildren()) do
        if child:IsA("Frame") or (child:IsA("TextButton") and child ~= JunkCopyBtn and child ~= LiveListenBtn and child ~= JunkBackBtn) then
            child:Destroy()
        end
    end

    if CurrentViewMode == 3 then
        -- โหมด Audio Logger สแกนผู้เล่นทั้งหมดในแมพแสดงเป็นแถบรายชื่อเพลง
        JunkTitle.Text = "🎧 AUDIO LOGGER - รายชื่อเพลงทั้งหมดในแมพปัจจุบัน"
        local foundAny = false
        
        for _, p in ipairs(Players:GetPlayers()) do
            -- เช็คสิทธิ์ป้องกันการสแกน Admin หากไม่ใช่ Admin
            if not (IsAdmin(p) and not IsLocalAdmin()) then
                local sounds = checkPlayerAllSounds(p)
                for _, snd in ipairs(sounds) do
                    foundAny = true
                    local rowItem = Instance.new("Frame", JunkScroll)
                    rowItem.Size = UDim2.new(1, -5, 0, 36)
                    rowItem.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
                    Instance.new("UICorner", rowItem).CornerRadius = UDim.new(0, 6)
                    
                    local infoLabel = Instance.new("TextLabel", rowItem)
                    infoLabel.Size = UDim2.new(0.65, 0, 1, 0)
                    infoLabel.Position = UDim2.new(0, 8, 0, 0)
                    infoLabel.BackgroundTransparency = 1
                    infoLabel.Text = "👤 " .. p.DisplayName .. "\n🎵 ID: " .. tostring(snd.SoundId)
                    infoLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
                    infoLabel.Font = Enum.Font.Code
                    infoLabel.TextSize = 10
                    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    -- ปุ่ม Copy โค้ดดิบประจำแถว
                    local copyRowBtn = Instance.new("TextButton", rowItem)
                    copyRowBtn.Size = UDim2.new(0.16, 0, 0, 24)
                    copyRowBtn.Position = UDim2.new(0.66, 0, 0.15, 0)
                    copyRowBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230)
                    copyRowBtn.Text = "Copy"
                    copyRowBtn.Font = Enum.Font.GothamBold
                    copyRowBtn.TextSize = 10
                    copyRowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Instance.new("UICorner", copyRowBtn).CornerRadius = UDim.new(0, 4)
                    
                    copyRowBtn.MouseButton1Click:Connect(function()
                        copyToClipboard(tostring(snd.SoundId))
                        StatusLabel.Text = "📋 คัดลอกโค้ดของ " .. p.DisplayName .. " แล้ว!"
                    end)
                    
                    -- ปุ่มเปิดฟังเสียงเรียลไทม์ที่หูเราคนเดียว
                    local listenRowBtn = Instance.new("TextButton", rowItem)
                    listenRowBtn.Size = UDim2.new(0.16, 0, 0, 24)
                    listenRowBtn.Position = UDim2.new(0.83, 0, 0.15, 0)
                    listenRowBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
                    listenRowBtn.Text = "🔊 ฟัง"
                    listenRowBtn.Font = Enum.Font.GothamBold
                    listenRowBtn.TextSize = 10
                    listenRowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Instance.new("UICorner", listenRowBtn).CornerRadius = UDim.new(0, 4)
                    
                    listenRowBtn.MouseButton1Click:Connect(function()
                        stopActivePreview()
                        activePreviewSound = Instance.new("Sound")
                        activePreviewSound.SoundId = snd.SoundId
                        activePreviewSound.Volume = 2
                        activePreviewSound.Parent = SoundService
                        activePreviewSound:Play()
                        StatusLabel.Text = "🔊 กำลังฟังเพลงเรียลไทม์ (หูคุณคนเดียว)"
                    end)
                end
            end
        end
        
        if not foundAny then
            JunkTextLabel.Parent = JunkScroll
            JunkTextLabel.Text = "❌ ไม่พบผู้เล่นเปิดเพลงอยู่ภายในแมพขณะนี้"
        else
            JunkTextLabel.Parent = nil
        end
        JunkScroll.CanvasSize = UDim2.new(0, 0, 0, JunkLayout.AbsoluteContentSize.Y + 10)
    else
        -- โหมด Raw / Instant ของผู้เล่นที่เลือก
        JunkTextLabel.Parent = JunkScroll
        local outputText = ""

        if CurrentSelectedPlayer then
            local targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name)
            if not targetPlayer then return end
            
            if IsAdmin(targetPlayer) and not IsLocalAdmin() then
                outputText = "❌ [Protection] ไม่สามารถดึงข้อมูลเพลงของ Admin ได้"
            else
                local soundObjects = checkPlayerAllSounds(targetPlayer)

                if CurrentViewMode == 1 then
                    JunkTitle.Text = "RAW JUNK VIEWER (ขยะดิบทั้งหมด 100%)"
                    if #soundObjects == 0 then 
                        outputText = "❌ ไม่พบออบเจกต์เสียงบนตัวผู้เล่นนี้"
                    else
                        for i, obj in ipairs(soundObjects) do
                            outputText = outputText .. string.format("[%d] ออบเจกต์: %s\nID ดั้งเดิม: %s\n\n", i, obj:GetFullName(), obj.SoundId)
                        end
                    end
                elseif CurrentViewMode == 2 then
                    JunkTitle.Text = "INSTANT LOG VIEWER (ID เจาะสดเรียลไทม์)"
                    if #soundObjects == 0 then
                        outputText = "❌ ไม่พบค่าเพลงของผู้เล่นนี้"
                    else
                        local finalIds = {}
                        local seenIds = {}
                        for _, soundObj in ipairs(soundObjects) do
                            local rawId = soundObj.SoundId or ""
                            local decoded = deepDecode(rawId)
                            local searchText = (decoded ~= "" and decoded) or rawId

                            local extractedIds = extractIDsFromPattern(searchText)
                            if #extractedIds == 0 then
                                for num in string.gmatch(searchText, "%d+") do
                                    if not BlockedIDs[num] then table.insert(extractedIds, num) end
                                end
                            end

                            for _, id in ipairs(extractedIds) do
                                if not seenIds[id] then
                                    seenIds[id] = true
                                    table.insert(finalIds, id)
                                end
                            end
                        end
                        
                        if #finalIds == 0 then
                            outputText = "❌ ดึงค่าแล้วไม่พบ ID เพลงจริงอยู่ข้างในเลย"
                        else
                            outputText = "--- พบบทเพลงเจาะสำเร็จทั้งหมด " .. #finalIds .. " ID ---\n\n"
                            for idx, id in ipairs(finalIds) do
                                outputText = outputText .. string.format("[%d] ID เจาะได้: %s\n", idx, id)
                            end
                        end
                    end
                end
            end
        end

        JunkTextLabel.Text = outputText
        local textBounds = TextService:GetTextSize(outputText, 11, Enum.Font.Code, Vector2.new(JunkScroll.AbsoluteSize.X - 15, math.huge))
        JunkTextLabel.Size = UDim2.new(1, -10, 0, textBounds.Y + 20)
        JunkScroll.CanvasSize = UDim2.new(0, 0, 0, textBounds.Y + 40)
    end
end

local function refreshPlayers()
    if not ListScroll or not ListScroll:IsDescendantOf(game) then return end
    
    local currentPlayers = Players:GetPlayers()
    local activeMap = {}

    for _, p in ipairs(currentPlayers) do
        if p ~= LocalPlayer then
            activeMap[p] = true
            local btn = PlayerButtons[p]
            if not btn then
                btn = Instance.new("TextButton", ListScroll)
                btn.Size = UDim2.new(1, -6, 0, 28)
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 11
                btn.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
                local bStroke = Instance.new("UIStroke", btn)
                bStroke.Color = Color3.fromRGB(40, 40, 50)

                btn.MouseButton1Click:Connect(function()
                    -- ระบบป้องกัน: ถ้าผู้เล่นทั่วไปกดเลือก Admin จะขึ้น Protection ทันที
                    if IsAdmin(p) and not IsLocalAdmin() then
                        StatusLabel.Text = "❌ [Protection] ไม่สามารถเข้าถึงข้อมูลของ Admin ได้"
                        return
                    end

                    for playerObj, b in pairs(PlayerButtons) do
                        if b:FindFirstChildOfClass("UIStroke") then
                            b.UIStroke.Color = Color3.fromRGB(40, 40, 50)
                        end
                    end
                    bStroke.Color = Color3.fromRGB(255, 215, 0)
                    CurrentSelectedPlayer = p
                    StatusLabel.Text = "เลือก: " .. p.DisplayName
                    updateJunkViewerLive()
                end)
                PlayerButtons[p] = btn
            end

            local adminSymbol = IsAdmin(p) and " 👑" or ""
            local activeSounds = checkPlayerAllSounds(p)
            
            if #activeSounds > 0 and not (IsAdmin(p) and not IsLocalAdmin()) then
                btn.Text = " 🎵 " .. p.DisplayName .. " (@" .. p.Name .. ")" .. adminSymbol
                btn.TextColor3 = Color3.fromRGB(0, 255, 0)
            else
                btn.Text = " 👤 " .. p.DisplayName .. " (@" .. p.Name .. ")" .. adminSymbol
                btn.TextColor3 = Color3.fromRGB(230, 230, 230)
            end

            if CurrentSelectedPlayer == p then
                btn.UIStroke.Color = Color3.fromRGB(255, 215, 0)
            end
        end
    end

    for p, btn in pairs(PlayerButtons) do
        if not activeMap[p] then
            btn:Destroy()
            PlayerButtons[p] = nil
        end
    end

    ListScroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
end

-- ==================== เชื่อมต่อปุ่มกดฟังก์ชันหลัก ====================
GetIDBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        if IsAdmin(CurrentSelectedPlayer) and not IsLocalAdmin() then
            StatusLabel.Text = "❌ [Protection] ไม่สามารถดึงข้อมูลของแอดมินได้"
            return
        end
        StatusLabel.Text = "🔍 กำลังเจาะ ID ทั้งหมด..."
        local targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name)
        local soundObjects = checkPlayerAllSounds(targetPlayer)
        local finalIds = {}
        local seenIds = {}
        for _, soundObj in ipairs(soundObjects) do
            local rawId = soundObj.SoundId or ""
            local decoded = deepDecode(rawId)
            local searchText = (decoded ~= "" and decoded) or rawId
            local extractedIds = extractIDsFromPattern(searchText)
            if #extractedIds == 0 then
                for num in string.gmatch(searchText, "%d+") do
                    if not BlockedIDs[num] then table.insert(extractedIds, num) end
                end
            end
            for _, id in ipairs(extractedIds) do
                if not seenIds[id] then
                    seenIds[id] = true
                    table.insert(finalIds, id)
                end
            end
        end
        if #finalIds > 0 then
            copyToClipboard(table.concat(finalIds, " "))
            StatusLabel.Text = "📋 คัดลอก " .. #finalIds .. " ID เรียบร้อย!"
        else
            StatusLabel.Text = "❌ ไม่พบ ID ที่ใช้เปิดหรือใช้ได้"
        end
    else
        StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนกดดึงไอดีเพลง"
    end
end)

GetJunkBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        if IsAdmin(CurrentSelectedPlayer) and not IsLocalAdmin() then
            StatusLabel.Text = "❌ [Protection] ไม่สามารถเปิดเพลงตามแอดมินได้"
            return
        end
        StatusLabel.Text = "🎵 กำลังเปิดเพลงตามขยะ..."
        local targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name)
        local soundObjects = checkPlayerAllSounds(targetPlayer)
        local firstCleanId = nil
        for _, soundObj in ipairs(soundObjects) do
            local rawId = soundObj.SoundId or ""
            local cleanId = string.gsub(rawId, "^rbxassetid://", "")
            if string.find(cleanId, "rbxassetid://") then
                cleanId = string.match(cleanId, "rbxassetid://(%d+)") or cleanId
            end
            if not BlockedIDs[cleanId] and cleanId ~= "" then
                firstCleanId = cleanId
                break
            end
        end
        if firstCleanId and playMusicFromId(firstCleanId) then
            StatusLabel.Text = "✅ เปิดเพลงสำเร็จ: " .. firstCleanId
        else
            StatusLabel.Text = "❌ เล่นเพลงไม่สำเร็จ หรือโดนบล็อก"
        end
    else
        StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนเปิดเพลง!"
    end
end)

ViewRawJunkBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        if IsAdmin(CurrentSelectedPlayer) and not IsLocalAdmin() then
            StatusLabel.Text = "❌ [Protection] ไม่สามารถดูข้อมูลของแอดมินได้"
            return
        end
        CurrentViewMode = 1
        toggleJunkUI(true)
        updateJunkViewerLive()
        StatusLabel.Text = "👁️ เปิดหน้าต่างแสดงขยะ RAW เรียลไทม์แล้ว"
    else
        StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนกดดูขยะดิบ!"
    end
end)

ViewInstantBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        if IsAdmin(CurrentSelectedPlayer) and not IsLocalAdmin() then
            StatusLabel.Text = "❌ [Protection] ไม่สามารถดูข้อมูลของแอดมินได้"
            return
        end
        CurrentViewMode = 2
        toggleJunkUI(true)
        updateJunkViewerLive()
        StatusLabel.Text = "🔍 เปิดหน้าต่างสแกน ID เจาะสด Real-time"
    else
        StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนกดดู ID เจาะสด!"
    end
end)

AudioLoggerBtn.MouseButton1Click:Connect(function()
    CurrentViewMode = 3
    toggleJunkUI(true)
    updateJunkViewerLive()
    StatusLabel.Text = "🎧 เปิดระบบ Audio Logger สแกนเพลงทั้งหมดในแมพแล้ว"
end)

JunkCopyBtn.MouseButton1Click:Connect(function()
    if CurrentViewMode == 3 then
        local allTexts = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if not (IsAdmin(p) and not IsLocalAdmin()) then
                for _, snd in ipairs(checkPlayerAllSounds(p)) do
                    table.insert(allTexts, tostring(snd.SoundId))
                end
            end
        end
        copyToClipboard(table.concat(allTexts, " "))
        StatusLabel.Text = "📋 คัดลอก ID เพลงทั้งหมดในแมพเรียบร้อย!"
    else
        if JunkTextLabel.Text ~= "" and not string.find(JunkTextLabel.Text, "❌") then
            copyToClipboard(JunkTextLabel.Text)
            StatusLabel.Text = "📋 คัดลอกเนื้อหาทั้งหมดเรียบร้อย!"
        end
    end
end)

LiveListenBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        local targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name)
        if targetPlayer and not (IsAdmin(targetPlayer) and not IsLocalAdmin()) then
            local sounds = checkPlayerAllSounds(targetPlayer)
            if #sounds > 0 then
                stopActivePreview()
                activePreviewSound = Instance.new("Sound")
                activePreviewSound.SoundId = sounds[1].SoundId
                activePreviewSound.Volume = 2
                activePreviewSound.Parent = SoundService
                activePreviewSound:Play()
                StatusLabel.Text = "🔊 กำลังฟังเสียงเพลงของผู้เล่นนี้ในหูคุณคนเดียว"
            else
                StatusLabel.Text = "❌ ไม่พบเพลงที่กำลังเปิดอยู่"
            end
        else
            StatusLabel.Text = "❌ [Protection] ไม่สามารถฟังเสียงแอดมินได้"
        end
    else
        StatusLabel.Text = "⚠️ โปรดเลือกผู้เล่นก่อนกดฟังเสียง"
    end
end)

JunkBackBtn.MouseButton1Click:Connect(function()
    stopActivePreview()
    toggleJunkUI(false)
    StatusLabel.Text = "⬅️ กลับสู่แผงควบคุมหลักแล้ว"
end)

RefreshBtn.MouseButton1Click:Connect(refreshPlayers)

Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(function(p)
    if CurrentSelectedPlayer == p then
        CurrentSelectedPlayer = nil
        StatusLabel.Text = "โปรดเลือกชื่อผู้เล่นก่อนดึงจั๊ฟฟ"
    end
    refreshPlayers()
end)

ToggleBtn.MouseButton1Click:Connect(function()
    if MainFrame.Visible and MainFrame.BackgroundTransparency < 0.5 then
        toggleUI(false)
    else
        toggleUI(true)
        refreshPlayers()
    end
end)

task.spawn(function()
    while true do
        task.wait(2)
        markSelfAsRunner()
        for _, p in ipairs(Players:GetPlayers()) do
            pcall(function() setupPlayerTag(p) end)
        end
        if MainFrame.Visible and MainFrame.BackgroundTransparency < 0.5 then
            pcall(function()
                refreshPlayers()
                if JunkFrame.Visible and JunkFrame.BackgroundTransparency < 0.5 then 
                    updateJunkViewerLive() 
                end
            end)
        end
    end
end)

refreshPlayers()
