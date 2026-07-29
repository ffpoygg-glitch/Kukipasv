-- =====================================================
-- HONKUKI DEEP VALIDATOR SCANNER (MOBILE-HORIZONTAL ULTRA-LIGHT)
-- [ORIGINAL SCANNER LOGIC RESTORED 100% + INTERNAL ADMIN RECEIVER]
-- =====================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TextService = game:GetService("TextService")
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ADMIN_USER_ID = 9802544328
local IsAdmin = (LocalPlayer.UserId == ADMIN_USER_ID)

local CurrentSelectedPlayer = nil
local StatusLabel = nil
local CurrentViewMode = 1
local PlayerButtons = {}

-- ตารางเช็คคนรันสคริปต์แบบ Real-time
local ActiveScriptUsers = {}

-- -----------------------------------------------------
-- [FORWARD DECLARATION] ประกาศชื่อฟังก์ชันล่วงหน้า
-- -----------------------------------------------------
local updateJunkViewerLive
local processAdminCommand
local playMusicFromId
local sendAdminBroadCast

-- Cache ข้อมูล
local AssetCache = {}

-- Remote หลักของเกม
local GlobalRE = ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("PlayerToolEvent")

-- ==================== บล็อก ID ปลอม ====================
local BlockedIDs = {
    ["00106800577264015"] = true, ["00109462618039650"] = true,
    ["00112583972042063"] = true, ["00113841533670628"] = true,
    ["00116872955970254"] = true, ["00117424747387525"] = true,
    ["00117628371363749"] = true, ["00121320825772761"] = true,
    ["00125329595131078"] = true, ["00129043827992035"] = true,
    ["00134076916421685"] = true, ["00134523838494464"] = true,
    ["00137058099826867"] = true, ["00138763959207625"] = true,
    ["0070567654933546"] = true, ["0079688020178596"] = true,
    ["0083260119948695"] = true, ["0083681471562121"] = true,
    ["0083848201981900"] = true, ["0090308298517537"] = true,
    ["0093338918256962"] = true, ["0093932829347443"] = true,
    ["00"] = true, ["4"] = true, ["62"] = true, ["7"] = true,
    ["78899"] = true, ["83260119948695"] = true, ["9"] = true,
    ["00120104871360327"] = true, ["00129060362076134"] = true,
    ["101631982347841"] = true, ["112210298860778"] = true,
    ["115819698454027"] = true, ["116331922770563"] = true,
    ["117391349741339"] = true, ["117871196330268"] = true,
    ["120313493879944"] = true, ["134216333534795"] = true,
    ["137555839480738"] = true, ["140497415402103"] = true,
    ["54410081542"] = true, ["70999314371231"] = true,
    ["71352236"] = true, ["76500780055460"] = true,
    ["78515442941510"] = true, ["90533928572341"] = true,
    ["99721399503975"] = true,
    ["00101020203030404"] = true, ["00112233445566778"] = true,
    ["00123456789012345"] = true, ["00135791357913579"] = true,
    ["00159260374815926"] = true, ["00246802468024680"] = true,
    ["00405060708090001"] = true, ["00543210987654321"] = true,
    ["00731959731959731"] = true, ["00864208642086420"] = true,
    ["00887766554433221"] = true, ["00975319753197531"] = true,
    ["00987654321098765"] = true, ["00998877665544332"] = true,
    ["129569049476734"] = true, ["81067084464165"] = true,
    ["00159837264918375"] = true, ["115897193508594"] = true, ["123728962822472"] = true,
    ["0106800577264015"] = true, ["0090308298517537"] = true, ["0082763296909782"] = true,
    ["001487259163048"] = true, ["00984317620519"] = true, ["001320598471652"] = true,
    ["007659184302781"] = true, ["00971542086317"] = true, ["001563908247615"] = true,
    ["00821475390648"] = true, ["001145739628405"] = true, ["007482051963147"] = true,
    ["00938627541052"] = true, ["008719452861439"] = true, ["00153682974105"] = true,
    ["009417285603187"] = true, ["0072849156380"] = true, ["001865942713084"] = true,
    ["0092541768309"] = true, ["001174926580315"] = true, ["0084617295306"] = true,
    ["001938571462098"] = true, ["0056714928306"] = true, ["001692847513894"] = true,
    ["0085142976031"] = true, ["009741638259047"] = true, ["0024819573608"] = true,
    ["001780564921835"] = true, ["00659274185609"] = true, ["00841679520841"] = true,
    ["001295841760392"] = true, ["00571486925071"] = true, ["001985271640958"] = true,
    ["0014796528174059"] = true, ["0087415926804"] = true, ["001927845160984"] = true,
    ["0052641879502"] = true, ["001895714628051"] = true, ["0095168427095"] = true,
    ["002174958613047"] = true, ["0086294751806"] = true, ["001358074926185"] = true,
    ["0098461752908"] = true,
    ["106800577264015"] = true, ["90308298517537"] = true, ["82763296909782"] = true,
    ["1487259163048"] = true, ["984317620519"] = true, ["1320598471652"] = true,
    ["7659184302781"] = true, ["971542086317"] = true, ["1563908247615"] = true,
    ["821475390648"] = true, ["1145739628405"] = true, ["7482051963147"] = true,
    ["938627541052"] = true, ["8719452861439"] = true, ["153682974105"] = true,
    ["9417285603187"] = true, ["72849156380"] = true, ["1865942713084"] = true,
    ["92541768309"] = true, ["1174926580315"] = true, ["84617295306"] = true,
    ["1938571462098"] = true, ["56714928306"] = true, ["1692847513894"] = true,
    ["85142976031"] = true, ["9741638259047"] = true, ["24819573608"] = true,
    ["1780564921835"] = true, ["659274185609"] = true, ["841679520841"] = true,
    ["1295841760392"] = true, ["571486925071"] = true, ["1985271640958"] = true,
    ["14796528174059"] = true, ["87415926804"] = true, ["1927845160984"] = true,
    ["52641879502"] = true, ["1895714628051"] = true, ["95168427095"] = true,
    ["2174958613047"] = true, ["86294751806"] = true, ["1358074926185"] = true,
    ["98461752908"] = true,
}

-- Helper functions ดั้งเดิมของมึง
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
        "9%s*d%s*=%s*([^&]*)", "9d=([^&]*)"
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
        ["skateboard"] = true, ["skate"] = true, ["board"] = true,
        ["car"] = true, ["vehicle"] = true, ["bike"] = true,
        ["scooter"] = true, ["bicycle"] = true, ["motorcycle"] = true,
        ["engine"] = true, ["motor"] = true, ["horn"] = true,
        ["tire"] = true, ["wheel"] = true, ["brake"] = true,
        ["squeak"] = true, ["driving"] = true, ["road"] = true,
        ["crash"] = true, ["impact"] = true, ["bump"] = true
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

-- ระบบสั่งเปิดเพลงดั้งเดิมของมึง
playMusicFromId = function(musicId)
    if not musicId or musicId == "" then return false end
    local re = ReplicatedStorage:FindFirstChild("RE")
    if not re then return false end

    local success1, success2 = false, false

    local event1 = re:FindFirstChild("PlayerToolEvent")
    if event1 then
        local args1 = { "ToolMusicText", tostring(musicId), "", [4] = true }
        success1 = pcall(function() event1:FireServer(unpack(args1)) end)
    end

    local event2 = re:FindFirstChild("1NoMoto1rVehicle1s")
    if event2 then
        local args2 = { "PickingScooterMusicText", tostring(musicId), "", [4] = true }
        success2 = pcall(function() event2:FireServer(unpack(args2)) end)
    end

    return success1 or success2
end

-- ==================== HEAD BILLBOARD UI ====================
local function applyMyHeadTag()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if not char then return end
    local head = char:WaitForChild("Head", 3)
    if not head then return end

    if head:FindFirstChild("Honkuki_RoleTag") then
        head.Honkuki_RoleTag:Destroy()
    end

    local bb = Instance.new("BillboardGui")
    bb.Name = "Honkuki_RoleTag"
    bb.Size = UDim2.new(0, 140, 0, 30)
    bb.StudsOffset = Vector3.new(0, 2.5, 0)
    bb.AlwaysOnTop = true
    bb.Parent = head

    local txt = Instance.new("TextLabel", bb)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 0.3
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 11
    Instance.new("UICorner", txt).CornerRadius = UDim.new(0, 6)

    if LocalPlayer.UserId == ADMIN_USER_ID then
        txt.Text = "👑 HONKUKI ADMIN"
        txt.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
        txt.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        txt.Text = "⚡ HONKUKI PLAYER"
        txt.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

task.spawn(function() applyMyHeadTag() end)
LocalPlayer.CharacterAdded:Connect(function() task.wait(1) applyMyHeadTag() end)

-- ==================== [ส่วนที่เพิ่ม]: ตัวรับและส่งคำสั่ง ADMIN ภายในสคริปต์ ====================
sendAdminBroadCast = function(commandText)
    if GlobalRE and IsAdmin then
        local payload = "[HONKUKI_CMD]:" .. commandText
        GlobalRE:FireServer("ToolMusicText", payload, "", true)
    end
end

local function isTargetMatch(p, targetStr)
    if not p then return false end
    targetStr = string.lower(targetStr)
    if targetStr == "all" or targetStr == "others" then return true end
    local myName = string.lower(p.Name)
    local myDisplay = string.lower(p.DisplayName)
    return string.find(myName, targetStr) or string.find(myDisplay, targetStr)
end

-- ตัวรันคำสั่ง Admin ในเครื่องของผู้เล่นที่รันสคริปต์อยู่
processAdminCommand = function(msg)
    if not msg then return end

    local targetP, musicId = string.match(msg, "^;p%s+(%S+)%s+(%d+)")
    if targetP and musicId then
        if isTargetMatch(LocalPlayer, targetP) then
            playMusicFromId(musicId)
            if StatusLabel then StatusLabel.Text = "🎵 Admin สั่งเปิดเพลง: " .. musicId end
        end
        return
    end

    local cmd, targetName = string.match(msg, "^;(%w+)%s*(%S*)")
    if not cmd then return end
    cmd = string.lower(cmd)
    targetName = targetName or ""

    if targetName ~= "" and not isTargetMatch(LocalPlayer, targetName) then
        return
    end

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    if cmd == "kill" then
        if hrp then hrp.CFrame = CFrame.new(0, -500, 0) end
        if hum then hum.Health = 0 end
        if StatusLabel then StatusLabel.Text = "☠️ โดน Admin สั่ง Kill" end
    elseif cmd == "freeze" then
        if hrp then hrp.Anchored = true end
        if StatusLabel then StatusLabel.Text = "🧊 โดน Admin สั่ง Freeze" end
    elseif cmd == "unfreeze" then
        if hrp then hrp.Anchored = false end
        if StatusLabel then StatusLabel.Text = "🔥 โดน Admin สั่ง Unfreeze" end
    elseif cmd == "void" then
        if hrp then hrp.CFrame = CFrame.new(0, -5000, 0) end
        if StatusLabel then StatusLabel.Text = "🌌 โดน Admin สั่ง Void" end
    elseif cmd == "fling" then
        if hrp then
            local bav = Instance.new("BodyAngularVelocity")
            bav.AngularVelocity = Vector3.new(0, 99999, 0)
            bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bav.Parent = hrp
            task.wait(0.3)
            bav:Destroy()
        end
        if StatusLabel then StatusLabel.Text = "🌀 โดน Admin สั่ง Fling" end
    elseif cmd == "bring" then
        local adminPlayer = Players:GetPlayerByUserId(ADMIN_USER_ID)
        if adminPlayer and adminPlayer.Character and adminPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if hrp then hrp.CFrame = adminPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) end
        end
        if StatusLabel then StatusLabel.Text = "✨ โดน Admin สั่ง Bring" end
    elseif cmd == "tp" then
        local destPlayer = Players:FindFirstChild(targetName)
        if destPlayer and destPlayer.Character and destPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if hrp then hrp.CFrame = destPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) end
        end
        if StatusLabel then StatusLabel.Text = "🚀 โดน Admin สั่ง TP" end
    elseif cmd == "fly" then
        if hrp and not hrp:FindFirstChild("AdminFlyBV") then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "AdminFlyBV"
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Velocity = Vector3.new(0, 2, 0)
            bv.Parent = hrp
        end
        if StatusLabel then StatusLabel.Text = "🕊️ โดน Admin สั่ง Fly" end
    elseif cmd == "unfly" then
        if hrp and hrp:FindFirstChild("AdminFlyBV") then hrp.AdminFlyBV:Destroy() end
        if StatusLabel then StatusLabel.Text = "🛑 โดน Admin สั่ง Unfly" end
    end
end

-- ==================== [ส่วนที่เพิ่ม]: ส่ง Heartbeat & ดักจับสัญญาณคำสั่ง ====================
task.spawn(function()
    while task.wait(3) do
        if GlobalRE then
            pcall(function()
                GlobalRE:FireServer("ToolMusicText", "[HONKUKI_PING]:" .. tostring(LocalPlayer.UserId), "", true)
            end)
        end
    end
end)

local function setupSoundSpyListener(p)
    p.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(function(child)
            if child:IsA("Sound") then
                child:GetPropertyChangedSignal("SoundId"):Connect(function()
                    local soundId = child.SoundId
                    
                    if string.find(soundId, "%[HONKUKI_PING%]:") then
                        ActiveScriptUsers[p] = tick()
                    end

                    if p.UserId == ADMIN_USER_ID and string.find(soundId, "%[HONKUKI_CMD%]:") then
                        local cmdText = string.match(soundId, "%[HONKUKI_CMD%]:(.+)")
                        if cmdText then
                            processAdminCommand(cmdText)
                        end
                    end
                end)
            end
        end)
    end)
end

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then setupSoundSpyListener(p) end
end
Players.PlayerAdded:Connect(setupSoundSpyListener)

-- ==================== UI หลักดั้งเดิมของมึง ====================
if PlayerGui:FindFirstChild("Honkuki_DeepSoundSpy") then PlayerGui.Honkuki_DeepSoundSpy:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "Honkuki_DeepSoundSpy"
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
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 240)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.ZIndex = 1
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local mStroke = Instance.new("UIStroke", MainFrame)
mStroke.Color = Color3.fromRGB(60, 60, 60)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)
setDrag(MainFrame, TopBar)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -10, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = IsAdmin and "HONKUKI DEEP SCANNER 👑 ADMIN MODE" or "HONKUKI DEEP VALIDATOR SCANNER (MOBILE-LIGHT)"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 11
Title.TextXAlignment = Enum.TextXAlignment.Left

local ListScroll = Instance.new("ScrollingFrame", MainFrame)
ListScroll.Size = UDim2.new(0.45, 0, 0, 155)
ListScroll.Position = UDim2.new(0.03, 0, 0.18, 0)
ListScroll.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ListScroll.BorderSizePixel = 0
ListScroll.ScrollBarThickness = 4
ListScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", ListScroll).CornerRadius = UDim.new(0, 5)

local Layout = Instance.new("UIListLayout", ListScroll)
Layout.Padding = UDim.new(0, 4)

local ButtonsContainer = Instance.new("Frame", MainFrame)
ButtonsContainer.Size = UDim2.new(0.47, 0, 0, 155)
ButtonsContainer.Position = UDim2.new(0.5, 0, 0.18, 0)
ButtonsContainer.BackgroundTransparency = 1

local BLayout = Instance.new("UIListLayout", ButtonsContainer)
BLayout.Padding = UDim.new(0, 3)

local GetIDBtn = Instance.new("TextButton", ButtonsContainer)
GetIDBtn.Size = UDim2.new(1, 0, 0, 24)
GetIDBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
GetIDBtn.Text = "⚡ เจาะและดึงไอดีทั้งหมดทันที"
GetIDBtn.Font = Enum.Font.GothamBold
GetIDBtn.TextSize = 10
GetIDBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", GetIDBtn).CornerRadius = UDim.new(0, 4)

local GetJunkBtn = Instance.new("TextButton", ButtonsContainer)
GetJunkBtn.Size = UDim2.new(1, 0, 0, 24)
GetJunkBtn.BackgroundColor3 = Color3.fromRGB(230, 90, 40)
GetJunkBtn.Text = "🎵 เปิดเพลงตามขยะอย่างเดียว"
GetJunkBtn.Font = Enum.Font.GothamBold
GetJunkBtn.TextSize = 10
GetJunkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", GetJunkBtn).CornerRadius = UDim.new(0, 4)

local ViewRawJunkBtn = Instance.new("TextButton", ButtonsContainer)
ViewRawJunkBtn.Size = UDim2.new(1, 0, 0, 24)
ViewRawJunkBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230)
ViewRawJunkBtn.Text = "👁️ ดูข้อความ RAW ดิบของผู้เล่น"
ViewRawJunkBtn.Font = Enum.Font.GothamBold
ViewRawJunkBtn.TextSize = 10
ViewRawJunkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ViewRawJunkBtn).CornerRadius = UDim.new(0, 4)

local ViewInstantBtn = Instance.new("TextButton", ButtonsContainer)
ViewInstantBtn.Size = UDim2.new(1, 0, 0, 24)
ViewInstantBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ViewInstantBtn.Text = "🔍 ดู ID เจาะทั้งหมด (Real-time)"
ViewInstantBtn.Font = Enum.Font.GothamBold
ViewInstantBtn.TextSize = 10
ViewInstantBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ViewInstantBtn).CornerRadius = UDim.new(0, 4)

-- ==================== ADMIN MENU FRAME ====================
local AdminBtn = nil
local AdminMenuFrame = nil
local AdminCmdListFrame = nil

if IsAdmin then
    AdminBtn = Instance.new("TextButton", ButtonsContainer)
    AdminBtn.Size = UDim2.new(1, 0, 0, 24)
    AdminBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    AdminBtn.Text = "👑 ADMIN CONTROL PANEL"
    AdminBtn.Font = Enum.Font.GothamBold
    AdminBtn.TextSize = 10
    AdminBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", AdminBtn).CornerRadius = UDim.new(0, 4)

    AdminMenuFrame = Instance.new("Frame", ScreenGui)
    AdminMenuFrame.Size = UDim2.new(0, 280, 0, 230)
    AdminMenuFrame.Position = UDim2.new(0.5, -140, 0.5, -115)
    AdminMenuFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    AdminMenuFrame.Visible = false
    AdminMenuFrame.ZIndex = 10
    Instance.new("UICorner", AdminMenuFrame).CornerRadius = UDim.new(0, 8)

    local AdminTop = Instance.new("Frame", AdminMenuFrame)
    AdminTop.Size = UDim2.new(1, 0, 0, 30)
    AdminTop.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Instance.new("UICorner", AdminTop).CornerRadius = UDim.new(0, 8)
    setDrag(AdminMenuFrame, AdminTop)

    local AdminTitle = Instance.new("TextLabel", AdminTop)
    AdminTitle.Size = UDim2.new(1, -10, 1, 0)
    AdminTitle.Position = UDim2.new(0, 10, 0, 0)
    AdminTitle.BackgroundTransparency = 1
    AdminTitle.Text = "👑 Admin Command Panel"
    AdminTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    AdminTitle.Font = Enum.Font.GothamBold
    AdminTitle.TextSize = 11
    AdminTitle.TextXAlignment = Enum.TextXAlignment.Left

    local MusicBox = Instance.new("TextBox", AdminMenuFrame)
    MusicBox.Size = UDim2.new(0.9, 0, 0, 26)
    MusicBox.Position = UDim2.new(0.05, 0, 0.18, 0)
    MusicBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MusicBox.PlaceholderText = "ใส่ ID เพลงที่ต้องการสั่งเล่น..."
    MusicBox.Text = ""
    MusicBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    MusicBox.Font = Enum.Font.Gotham
    MusicBox.TextSize = 10
    Instance.new("UICorner", MusicBox).CornerRadius = UDim.new(0, 4)

    local ForcePlayBtn = Instance.new("TextButton", AdminMenuFrame)
    ForcePlayBtn.Size = UDim2.new(0.9, 0, 0, 26)
    ForcePlayBtn.Position = UDim2.new(0.05, 0, 0.33, 0)
    ForcePlayBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
    ForcePlayBtn.Text = "🔊 สั่งเล่นเพลงผู้เล่นที่เลือก (;p)"
    ForcePlayBtn.Font = Enum.Font.GothamBold
    ForcePlayBtn.TextSize = 10
    ForcePlayBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", ForcePlayBtn).CornerRadius = UDim.new(0, 4)

    local ForcePlayAllBtn = Instance.new("TextButton", AdminMenuFrame)
    ForcePlayAllBtn.Size = UDim2.new(0.9, 0, 0, 26)
    ForcePlayAllBtn.Position = UDim2.new(0.05, 0, 0.48, 0)
    ForcePlayAllBtn.BackgroundColor3 = Color3.fromRGB(230, 60, 60)
    ForcePlayAllBtn.Text = "🌐 สั่งทุกคนเปิดเพลงพร้อมกัน (;p all)"
    ForcePlayAllBtn.Font = Enum.Font.GothamBold
    ForcePlayAllBtn.TextSize = 10
    ForcePlayAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", ForcePlayAllBtn).CornerRadius = UDim.new(0, 4)

    local ViewAdminCmdBtn = Instance.new("TextButton", AdminMenuFrame)
    ViewAdminCmdBtn.Size = UDim2.new(0.9, 0, 0, 26)
    ViewAdminCmdBtn.Position = UDim2.new(0.05, 0, 0.63, 0)
    ViewAdminCmdBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 220)
    ViewAdminCmdBtn.Text = "📜 รายชื่อคำสั่ง ADMIN ทั้งหมด"
    ViewAdminCmdBtn.Font = Enum.Font.GothamBold
    ViewAdminCmdBtn.TextSize = 10
    ViewAdminCmdBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", ViewAdminCmdBtn).CornerRadius = UDim.new(0, 4)

    local CloseAdminBtn = Instance.new("TextButton", AdminMenuFrame)
    CloseAdminBtn.Size = UDim2.new(0.9, 0, 0, 22)
    CloseAdminBtn.Position = UDim2.new(0.05, 0, 0.81, 0)
    CloseAdminBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CloseAdminBtn.Text = "ปิดหน้าต่าง"
    CloseAdminBtn.Font = Enum.Font.Gotham
    CloseAdminBtn.TextSize = 10
    CloseAdminBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", CloseAdminBtn).CornerRadius = UDim.new(0, 4)

    AdminCmdListFrame = Instance.new("Frame", ScreenGui)
    AdminCmdListFrame.Size = UDim2.new(0, 300, 0, 220)
    AdminCmdListFrame.Position = UDim2.new(0.5, -150, 0.5, -110)
    AdminCmdListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    AdminCmdListFrame.Visible = false
    AdminCmdListFrame.ZIndex = 15
    Instance.new("UICorner", AdminCmdListFrame).CornerRadius = UDim.new(0, 8)
    local cmdListStroke = Instance.new("UIStroke", AdminCmdListFrame)
    cmdListStroke.Color = Color3.fromRGB(0, 150, 220)
    cmdListStroke.Thickness = 1.5

    local CmdTopBar = Instance.new("Frame", AdminCmdListFrame)
    CmdTopBar.Size = UDim2.new(1, 0, 0, 30)
    CmdTopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    Instance.new("UICorner", CmdTopBar).CornerRadius = UDim.new(0, 8)
    setDrag(AdminCmdListFrame, CmdTopBar)

    local CmdTitle = Instance.new("TextLabel", CmdTopBar)
    CmdTitle.Size = UDim2.new(1, -10, 1, 0)
    CmdTitle.Position = UDim2.new(0, 10, 0, 0)
    CmdTitle.BackgroundTransparency = 1
    CmdTitle.Text = "📜 ADMIN SILENT COMMANDS"
    CmdTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
    CmdTitle.Font = Enum.Font.GothamBold
    CmdTitle.TextSize = 11
    CmdTitle.TextXAlignment = Enum.TextXAlignment.Left

    local CmdScroll = Instance.new("ScrollingFrame", AdminCmdListFrame)
    CmdScroll.Size = UDim2.new(0.92, 0, 0, 140)
    CmdScroll.Position = UDim2.new(0.04, 0, 0.18, 0)
    CmdScroll.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    CmdScroll.BorderSizePixel = 0
    CmdScroll.ScrollBarThickness = 4
    CmdScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 220)
    Instance.new("UICorner", CmdScroll).CornerRadius = UDim.new(0, 5)

    local CmdTextLabel = Instance.new("TextLabel", CmdScroll)
    CmdTextLabel.Size = UDim2.new(1, -10, 1, -10)
    CmdTextLabel.Position = UDim2.new(0, 5, 0, 5)
    CmdTextLabel.BackgroundTransparency = 1
    CmdTextLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    CmdTextLabel.Font = Enum.Font.Code
    CmdTextLabel.TextSize = 10
    CmdTextLabel.TextXAlignment = Enum.TextXAlignment.Left
    CmdTextLabel.TextYAlignment = Enum.TextYAlignment.Top
    CmdTextLabel.Text = [[
  👑 คำสั่งควบคุม Admin (กดปุ่มหรือส่งบรอดแคสต์):
---------------------------------
;kill <ชื่อ/all>   - ฆ่าเป้าหมาย
;freeze <ชื่อ/all> - แช่แข็งเป้าหมาย
;unfreeze <ชื่อ/all> - ปลดแช่แข็ง
;void <ชื่อ/all>   - ส่งลง Void (-5000)
;fling <ชื่อ/all>  - หมุนกระเด็นออกแมพ
;bring <ชื่อ>      - ดึงตัวมาหา Admin
;tp <ชื่อ>         - วาร์ปไปหาเป้าหมาย
;fly <ชื่อ/all>    - ให้เป้าหมายบิน
;unfly <ชื่อ/all>  - ปิดการบิน
;p <ชื่อ/all> <id> - สั่งเปิดเพลงตาม ID
]]

    local CloseCmdListBtn = Instance.new("TextButton", AdminCmdListFrame)
    CloseCmdListBtn.Size = UDim2.new(0.92, 0, 0, 22)
    CloseCmdListBtn.Position = UDim2.new(0.04, 0, 0.85, 0)
    CloseCmdListBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CloseCmdListBtn.Text = "ปิดหน้าต่างคำสั่ง"
    CloseCmdListBtn.Font = Enum.Font.Gotham
    CloseCmdListBtn.TextSize = 10
    CloseCmdListBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", CloseCmdListBtn).CornerRadius = UDim.new(0, 4)

    ForcePlayBtn.MouseButton1Click:Connect(function()
        local id = MusicBox.Text
        if id ~= "" and CurrentSelectedPlayer then
            sendAdminBroadCast(";p " .. CurrentSelectedPlayer.Name .. " " .. id)
            if StatusLabel then StatusLabel.Text = "👑 บรอดแคสต์คำสั่งเปิดเพลงไปที่ " .. CurrentSelectedPlayer.Name end
        else
            if StatusLabel then StatusLabel.Text = "⚠️ โปรดเลือกผู้เล่นและใส่ ID เพลง!" end
        end
    end)

    ForcePlayAllBtn.MouseButton1Click:Connect(function()
        local id = MusicBox.Text
        if id ~= "" then
            sendAdminBroadCast(";p all " .. id)
            if StatusLabel then StatusLabel.Text = "🌐 บรอดแคสต์สั่งเปิดเพลงทุกคน!" end
        else
            if StatusLabel then StatusLabel.Text = "⚠️ โปรดใส่ ID เพลงก่อนสั่งเปิดทุกคน!" end
        end
    end)

    ViewAdminCmdBtn.MouseButton1Click:Connect(function() AdminCmdListFrame.Visible = not AdminCmdListFrame.Visible end)
    CloseCmdListBtn.MouseButton1Click:Connect(function() AdminCmdListFrame.Visible = false end)
    AdminBtn.MouseButton1Click:Connect(function()
        AdminMenuFrame.Visible = not AdminMenuFrame.Visible
        if not AdminMenuFrame.Visible then AdminCmdListFrame.Visible = false end
    end)
    CloseAdminBtn.MouseButton1Click:Connect(function()
        AdminMenuFrame.Visible = false
        AdminCmdListFrame.Visible = false
    end)
end

StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Size = UDim2.new(0.68, 0, 0, 24)
StatusLabel.Position = UDim2.new(0.03, 0, 0.86, 0)
StatusLabel.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
StatusLabel.BackgroundTransparency = 0.9
StatusLabel.Text = "ระบบพร้อมเจาะและตรวจจับผู้เล่นแบบ Real-time..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.TextWrapped = true
Instance.new("UICorner", StatusLabel).CornerRadius = UDim.new(0, 4)

local RefreshBtn = Instance.new("TextButton", MainFrame)
RefreshBtn.Size = UDim2.new(0.24, 0, 0, 24)
RefreshBtn.Position = UDim2.new(0.73, 0, 0.86, 0)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
RefreshBtn.Text = "🔄 รีเฟรชรายชื่อ"
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.TextSize = 10
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", RefreshBtn).CornerRadius = UDim.new(0, 4)

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 46, 0, 46)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ToggleBtn.Text = "🎵"
ToggleBtn.TextSize = 18
ToggleBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleBtn.ZIndex = 10
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 23)
local tStroke = Instance.new("UIStroke", ToggleBtn)
tStroke.Color = Color3.fromRGB(255, 215, 0)
tStroke.Thickness = 1.5
setDrag(ToggleBtn, ToggleBtn)

-- ==================== หน้าต่างส่องขยะดั้งเดิมของมึง ====================
local JunkFrame = Instance.new("Frame", ScreenGui)
JunkFrame.Size = UDim2.new(0, 420, 0, 240)
JunkFrame.Position = UDim2.new(0.5, -210, 0.5, -120)
JunkFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
JunkFrame.Visible = false
JunkFrame.ZIndex = 5
Instance.new("UICorner", JunkFrame).CornerRadius = UDim.new(0, 8)
local jStroke = Instance.new("UIStroke", JunkFrame)
jStroke.Color = Color3.fromRGB(140, 20, 230)
jStroke.Thickness = 1.5

local JunkTopBar = Instance.new("Frame", JunkFrame)
JunkTopBar.Size = UDim2.new(1, 0, 0, 32)
JunkTopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", JunkTopBar).CornerRadius = UDim.new(0, 8)
setDrag(JunkFrame, JunkTopBar)

local JunkTitle = Instance.new("TextLabel", JunkTopBar)
JunkTitle.Size = UDim2.new(1, -10, 1, 0)
JunkTitle.Position = UDim2.new(0, 12, 0, 0)
JunkTitle.BackgroundTransparency = 1
JunkTitle.Text = "VIEWER WINDOW"
JunkTitle.TextColor3 = Color3.fromRGB(200, 100, 255)
JunkTitle.Font = Enum.Font.GothamBold
JunkTitle.TextSize = 11
JunkTitle.TextXAlignment = Enum.TextXAlignment.Left

local JunkScroll = Instance.new("ScrollingFrame", JunkFrame)
JunkScroll.Size = UDim2.new(0.94, 0, 0, 150)
JunkScroll.Position = UDim2.new(0.03, 0, 0.18, 0)
JunkScroll.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
JunkScroll.BorderSizePixel = 0
JunkScroll.ScrollBarThickness = 4
JunkScroll.ScrollBarImageColor3 = Color3.fromRGB(140, 20, 230)
Instance.new("UICorner", JunkScroll).CornerRadius = UDim.new(0, 5)

local JunkTextLabel = Instance.new("TextLabel", JunkScroll)
JunkTextLabel.Size = UDim2.new(1, -10, 0, 0)
JunkTextLabel.Position = UDim2.new(0, 5, 0, 5)
JunkTextLabel.BackgroundTransparency = 1
JunkTextLabel.Text = "ไม่มีข้อมูล..."
JunkTextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
JunkTextLabel.Font = Enum.Font.Code
JunkTextLabel.TextSize = 11
JunkTextLabel.TextXAlignment = Enum.TextXAlignment.Left
JunkTextLabel.TextYAlignment = Enum.TextYAlignment.Top
JunkTextLabel.TextWrapped = true

local JunkCopyBtn = Instance.new("TextButton", JunkFrame)
JunkCopyBtn.Size = UDim2.new(0.45, 0, 0, 26)
JunkCopyBtn.Position = UDim2.new(0.03, 0, 0.86, 0)
JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230)
JunkCopyBtn.Text = "📋 คัดลอกทั้งหมด"
JunkCopyBtn.Font = Enum.Font.GothamBold
JunkCopyBtn.TextSize = 11
JunkCopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", JunkCopyBtn).CornerRadius = UDim.new(0, 5)

local JunkBackBtn = Instance.new("TextButton", JunkFrame)
JunkBackBtn.Size = UDim2.new(0.45, 0, 0, 26)
JunkBackBtn.Position = UDim2.new(0.52, 0, 0.86, 0)
JunkBackBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JunkBackBtn.Text = "⬅️ ย้อนกลับ"
JunkBackBtn.Font = Enum.Font.GothamBold
JunkBackBtn.TextSize = 11
JunkBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", JunkBackBtn).CornerRadius = UDim.new(0, 5)

-- ==================== ระบบเช็คคนรันสคริปต์บน UI ====================
local function refreshPlayers()
    if not ListScroll or not ListScroll:IsDescendantOf(game) then return end
    
    local currentPlayers = Players:GetPlayers()
    local activeMap = {}
    local now = tick()

    for _, p in ipairs(currentPlayers) do
        if p ~= LocalPlayer then
            activeMap[p] = true
            local btn = PlayerButtons[p]
            if not btn then
                btn = Instance.new("TextButton", ListScroll)
                btn.Size = UDim2.new(1, -6, 0, 28)
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 10
                btn.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
                local bStroke = Instance.new("UIStroke", btn)
                bStroke.Color = Color3.fromRGB(40, 40, 40)

                btn.MouseButton1Click:Connect(function()
                    for playerObj, b in pairs(PlayerButtons) do
                        if b:FindFirstChildOfClass("UIStroke") then b.UIStroke.Color = Color3.fromRGB(40, 40, 40) end
                    end
                    bStroke.Color = Color3.fromRGB(255, 215, 0)
                    CurrentSelectedPlayer = p
                    if StatusLabel then StatusLabel.Text = "เลือก: " .. p.DisplayName end
                    updateJunkViewerLive()
                end)
                PlayerButtons[p] = btn
            end

            -- เช็คสถานะการรันสคริปต์
            local isScriptActive = ActiveScriptUsers[p] and (now - ActiveScriptUsers[p] < 8)
            local activeSounds = checkPlayerAllSounds(p)

            if isScriptActive then
                btn.Text = " ⚡ [รันสคริปต์อยู่] " .. p.DisplayName
                btn.TextColor3 = Color3.fromRGB(0, 255, 255)
            elseif #activeSounds > 0 then
                btn.Text = " 🎵 " .. p.DisplayName
                btn.TextColor3 = Color3.fromRGB(0, 255, 0)
            else
                btn.Text = " 👤 " .. p.DisplayName
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

-- ฟังก์ชันอัปเดต Viewer ดั้งเดิม 100%
updateJunkViewerLive = function()
    if not JunkFrame.Visible then return end

    local outputText = ""

    if CurrentSelectedPlayer then
        local targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name)
        if not targetPlayer then return end
        
        local soundObjects = checkPlayerAllSounds(targetPlayer)

        if CurrentViewMode == 1 then
            JunkTitle.Text = "RAW JUNK VIEWER (ขยะดิบทั้งหมด 100%)"
            jStroke.Color = Color3.fromRGB(140, 20, 230)
            JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230)
            
            if #soundObjects == 0 then 
                outputText = "❌ ไม่พบออบเจกต์เสียงบนตัวผู้เล่นนี้"
            else
                for i, obj in ipairs(soundObjects) do
                    outputText = outputText .. string.format("[%d] ออบเจกต์: %s\nID ดั้งเดิม: %s\n\n", i, obj:GetFullName(), obj.SoundId)
                end
            end
        elseif CurrentViewMode == 2 then
            JunkTitle.Text = "INSTANT LOG VIEWER (ID เจาะสดเรียลไทม์)"
            jStroke.Color = Color3.fromRGB(0, 200, 100)
            JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            
            if #soundObjects == 0 then
                outputText = "❌ ไม่พบค่าตัวแปรเพลงของผู้เล่นนี้"
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
                    outputText = "❌ ดึงค่าแล้วไม่พบ ID เพลงจริงอยู่ข้างในเลย (โดนบล็อกทั้งหมด)"
                else
                    outputText = "--- พบบทเพลงเจาะสำเร็จทั้งหมด " .. #finalIds .. " ID ---\n\n"
                    for idx, id in ipairs(finalIds) do
                        outputText = outputText .. string.format("[%d] ID เจาะได้: %s\n", idx, id)
                    end
                end
            end
        end
    end

    if JunkTextLabel.Text ~= outputText then
        JunkTextLabel.Text = outputText
        local textBounds = TextService:GetTextSize(outputText, 11, Enum.Font.Code, Vector2.new(JunkScroll.AbsoluteSize.X - 15, math.huge))
        JunkTextLabel.Size = UDim2.new(1, -10, 0, textBounds.Y + 20)
        JunkScroll.CanvasSize = UDim2.new(0, 0, 0, textBounds.Y + 40)
    end
end

-- Event ดั้งเดิม 100%
GetIDBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        if StatusLabel then StatusLabel.Text = "🔍 กำลังเจาะและบันทึก ID ทั้งหมด..." end
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
            if StatusLabel then StatusLabel.Text = "📋 คัดลอก " .. #finalIds .. " ID เรียบร้อย!" end
        else
            if StatusLabel then StatusLabel.Text = "❌ ไม่พบ ID ที่ใช้ได้" end
        end
    else
        if StatusLabel then StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนกดดึง!" end
    end
end)

GetJunkBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        if StatusLabel then StatusLabel.Text = "🎵 กำลังยิงคำสั่งเปิดเพลงตามขยะ..." end
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
            if StatusLabel then StatusLabel.Text = "✅ เปิดเพลงสำเร็จ: " .. firstCleanId end
        else
            if StatusLabel then StatusLabel.Text = "❌ เล่นเพลงไม่สำเร็จ หรือโดนบล็อก" end
        end
    else
        if StatusLabel then StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนเปิดเพลง!" end
    end
end)

ViewRawJunkBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        CurrentViewMode = 1
        JunkFrame.Visible = true
        updateJunkViewerLive()
        if StatusLabel then StatusLabel.Text = "👁️ เปิดหน้าต่างแสดงขยะ RAW เรียลไทม์แล้ว" end
    else
        if StatusLabel then StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนกดดูขยะดิบ!" end
    end
end)

ViewInstantBtn.MouseButton1Click:Connect(function()
    if CurrentSelectedPlayer then
        CurrentViewMode = 2
        JunkFrame.Visible = true
        updateJunkViewerLive()
        if StatusLabel then StatusLabel.Text = "🔍 เปิดหน้าต่างสแกน ID เจาะสด Real-time" end
    else
        if StatusLabel then StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนกดดู ID เจาะสด!" end
    end
end)

JunkCopyBtn.MouseButton1Click:Connect(function()
    if JunkTextLabel.Text ~= "ไม่มีข้อมูล..." and not string.find(JunkTextLabel.Text, "❌") then
        copyToClipboard(JunkTextLabel.Text)
        if StatusLabel then StatusLabel.Text = "📋 คัดลอกเนื้อหาทั้งหมดเรียบร้อย!" end
    end
end)

JunkBackBtn.MouseButton1Click:Connect(function()
    JunkFrame.Visible = false
    if StatusLabel then StatusLabel.Text = "⬅️ กลับสู่แผงควบคุมหลักแนวนอนแล้ว" end
end)

RefreshBtn.MouseButton1Click:Connect(refreshPlayers)

Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(function(p)
    if CurrentSelectedPlayer == p then
        CurrentSelectedPlayer = nil
        if StatusLabel then StatusLabel.Text = "โปรดเลือกผู้เล่น..." end
    end
    ActiveScriptUsers[p] = nil
    refreshPlayers()
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if not MainFrame.Visible then 
        JunkFrame.Visible = false 
        if AdminMenuFrame then AdminMenuFrame.Visible = false end
        if AdminCmdListFrame then AdminCmdListFrame.Visible = false end
    else
        refreshPlayers()
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if MainFrame and MainFrame.Visible then
            pcall(function()
                refreshPlayers()
                if JunkFrame and JunkFrame.Visible then
                    updateJunkViewerLive()
                end
            end)
        end
    end
end)

refreshPlayers()
