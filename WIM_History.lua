--[Functions: GUI Interface for WIM_History.xml

WIM_HistoryView_Name_Selected = "";
WIM_HistoryView_Filter_Selected = "";

function WIM_HistoryView_NameClick()
	if(WIM_HistoryView_Name_Selected ~= this.theName) then
		WIM_HistoryView_Filter_Selected = "";
	end
	WIM_HistoryView_Name_Selected = this.theName;
	WIM_HistoryViewFiltersScrollBar_Update();
end

function WIM_HistoryView_FilterClick()
	WIM_HistoryView_Filter_Selected = this.theName;
end

function WIM_HistoryViewNameScrollBar_Update()
	local line;
	local lineplusoffset;
	local HistoryNames = {};
	
	for key in WIM_History do
		table.insert(HistoryNames, key);
	end
	table.sort(HistoryNames);
	
	FauxScrollFrame_Update(WIM_HistoryFrameNameListScrollBar,table.getn(HistoryNames),15,16);
	for line=1,15 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(WIM_HistoryFrameNameListScrollBar);
		if lineplusoffset <= table.getn(HistoryNames) then
			getglobal("WIM_HistoryFrameNameListButton"..line.."Name"):SetText(HistoryNames[lineplusoffset]);
			getglobal("WIM_HistoryFrameNameListButton"..line).theName = HistoryNames[lineplusoffset];
			if ( WIM_HistoryView_Name_Selected == HistoryNames[lineplusoffset] ) then
				getglobal("WIM_HistoryFrameNameListButton"..line):LockHighlight();
			else
				getglobal("WIM_HistoryFrameNameListButton"..line):UnlockHighlight();
			end
			getglobal("WIM_HistoryFrameNameListButton"..line):Show();
		else
			getglobal("WIM_HistoryFrameNameListButton"..line):Hide();
		end
	end
end




function WIM_HistoryViewFiltersScrollBar_Update()
	local line;
	local lineplusoffset;
	local Filters = {};
	
	local tDate = "";
	local lDate = "";
	if(WIM_History[WIM_HistoryView_Name_Selected]) then
		for i=1,table.getn(WIM_History[WIM_HistoryView_Name_Selected]) do
			tDate = WIM_History[WIM_HistoryView_Name_Selected][i].date;
			if(tDate ~= lDate) then
				table.insert(Filters, tDate);
				lDate = tDate;
			end
		end
	end
	table.sort(Filters);
	table.insert(Filters, 1, WIM_L_NONESHOWALL);
	if(WIM_HistoryView_Filter_Selected == "") then
		--[WIM_HistoryView_Filter_Selected = Filters[1];
	end
	
	FauxScrollFrame_Update(WIM_HistoryFrameFilterListScrollBar,table.getn(Filters),7,16);
	for line=1,7 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(WIM_HistoryFrameFilterListScrollBar);
		if lineplusoffset <= table.getn(Filters) then
			getglobal("WIM_HistoryFrameFilterListButton"..line.."Name"):SetText(Filters[lineplusoffset]);
			if(lineplusoffset == 1) then
				getglobal("WIM_HistoryFrameFilterListButton"..line).theName = "";
			else
				getglobal("WIM_HistoryFrameFilterListButton"..line).theName = Filters[lineplusoffset];
			end
			if ( WIM_HistoryView_Filter_Selected == Filters[lineplusoffset] ) then
				getglobal("WIM_HistoryFrameFilterListButton"..line):LockHighlight();
			else
				getglobal("WIM_HistoryFrameFilterListButton"..line):UnlockHighlight();
			end
			getglobal("WIM_HistoryFrameFilterListButton"..line):Show();
		else
			getglobal("WIM_HistoryFrameFilterListButton"..line):Hide();
		end
	end
	WIM_HistoryView_ShowMessages();
end


-- Scrolling for the History message list, driven by our own tracked position.
-- This client exposes no scroll-position read-back API (GetScrollOffset is
-- unavailable), so we track the position ourselves and feed the thumb.
-- The FauxScrollFrameTemplate provides the arrows + thumb (the look); we drive
-- the real slider object (resolved the way Vanilla does) and attach our own
-- OnValueChanged + arrow handlers.

local WIM_HistoryMsgPos = 0;            -- rows from the top: 0 = oldest (top), max = newest (bottom)
local WIM_HistoryMsgMax = 0;            -- maximum scrollable rows
local WIM_HistoryMsgScrollSyncing = false;
local WIM_HistoryMsgScrollInstalled = false;
local WIM_HistoryJumpGuard = 5000;

local function WIM_History_GetSlider(sb)
	local slider = sb.ScrollBar;
	if(not slider) then
		slider = getglobal(sb:GetName() .. "ScrollBar");
	end
	return slider;
end

local function WIM_History_ReadCounts(smf)
	local numMessages = 0;
	if smf.GetNumMessages then
		numMessages = smf:GetNumMessages() or 0;
	end
	local numLines = 1;
	if smf.GetNumLinesDisplayed then
		numLines = smf:GetNumLinesDisplayed() or 1;
	end
	if(numLines < 1) then
		numLines = 1;
	end
	return numMessages, numLines;
end

-- Recompute the range, correct the tracked position at the two endpoints,
-- and drive the thumb. Called on Show and whenever the list scrolls.
local function WIM_History_Refresh()
	local smf = WIM_HistoryFrameMessageListScrollingMessageFrame;
	local sb = WIM_HistoryFrameMessageListScrollBar;
	if(not smf or not sb) then
		return;
	end

	local numMessages, numLines = WIM_History_ReadCounts(smf);
	local maxScroll = math.max(0, numMessages - numLines);
	WIM_HistoryMsgMax = maxScroll;

	if smf:AtBottom() then
		WIM_HistoryMsgPos = maxScroll;
	elseif smf:AtTop() then
		WIM_HistoryMsgPos = 0;
	end
	WIM_HistoryMsgPos = math.max(0, math.min(WIM_HistoryMsgPos, maxScroll));

	FauxScrollFrame_Update(sb, numMessages, numLines, 16);
	WIM_History_EnsureSliderWired();

	local slider = WIM_History_GetSlider(sb);
	if(slider) then
		slider:SetMinMaxValues(0, maxScroll * 16);
		WIM_HistoryMsgScrollSyncing = true;
		slider:SetValue(WIM_HistoryMsgPos * 16);
		WIM_HistoryMsgScrollSyncing = false;
	end
end

-- Public sync entry point (OnShow + WIM_UpdateScrollBars / OnMessageScrollChanged)
function WIM_HistoryViewMessageListScrollBar_Update()
	WIM_History_Refresh();
end

-- Move the list toward `target` rows-from-top, stepping our tracked position.
local function WIM_History_JumpTo(target)
	local smf = WIM_HistoryFrameMessageListScrollingMessageFrame;
	if(not smf) then
		return;
	end
	target = math.max(0, math.min(target, WIM_HistoryMsgMax));

	if(math.abs(target - WIM_HistoryMsgPos) <= 1) then
		return;
	end

	local guard = 0;
	WIM_HistoryMsgScrollSyncing = true;
	while(WIM_HistoryMsgPos < target and guard < WIM_HistoryJumpGuard) do
		smf:ScrollDown();
		WIM_HistoryMsgPos = WIM_HistoryMsgPos + 1;
		guard = guard + 1;
	end
	while(WIM_HistoryMsgPos > target and guard < WIM_HistoryJumpGuard) do
		smf:ScrollUp();
		WIM_HistoryMsgPos = WIM_HistoryMsgPos - 1;
		guard = guard + 1;
	end
	WIM_HistoryMsgScrollSyncing = false;
	WIM_HistoryMsgPos = math.max(0, math.min(WIM_HistoryMsgPos, WIM_HistoryMsgMax));

	WIM_History_Refresh();
end

-- Slider OnValueChanged (drag, track click, arrows) -> jump to that target.
local function WIM_HistoryMsgScrollJump(value)
	local target = math.max(0, math.min(math.floor(value / 16), WIM_HistoryMsgMax));
	WIM_History_JumpTo(target);
end

function WIM_HistoryMsgScrollDragged(value)
	if(WIM_HistoryMsgScrollSyncing) then
		return;
	end
	WIM_HistoryMsgScrollJump(value);
end

-- Wheel/page tracking. stepSign: -1 = up (older/top), +1 = down (newer/bottom).
function WIM_HistoryMsgOnWheel(stepSign, isPage)
	local smf = WIM_HistoryFrameMessageListScrollingMessageFrame;
	if(not smf) then
		return;
	end
	local _, numLines = WIM_History_ReadCounts(smf);
	local step = (isPage and numLines) or 1;
	WIM_HistoryMsgPos = math.max(0, math.min(WIM_HistoryMsgPos + stepSign * step, WIM_HistoryMsgMax));
	WIM_History_Refresh();
end

-- Attach our own handlers to the slider and its arrows (run once).
function WIM_History_EnsureSliderWired()
	if(WIM_HistoryMsgScrollInstalled) then
		return;
	end
	local sb = WIM_HistoryFrameMessageListScrollBar;
	if(not sb) then
		return;
	end
	local slider = WIM_History_GetSlider(sb);
	if(not slider) then
		return;
	end
	WIM_HistoryMsgScrollInstalled = true;

	slider:SetScript("OnValueChanged", function(self, value)
		WIM_HistoryMsgScrollDragged(value);
	end);

	local up = getglobal(sb:GetName() .. "ScrollBarScrollUpButton");
	local down = getglobal(sb:GetName() .. "ScrollBarScrollDownButton");
	if(up) then
		up:SetScript("OnClick", function()
			slider:SetValue(math.max(0, slider:GetValue() - 16));
		end);
	end
	if(down) then
		down:SetScript("OnClick", function()
			local _, maxV = slider:GetMinMaxValues();
			slider:SetValue(math.min(maxV or 0, slider:GetValue() + 16));
		end);
	end
end

-- Temporary diagnostic: run /wimdbghist while the History window is open.
SLASH_WIMDBGHIST1 = "/wimdbghist";
SlashCmdList["WIMDBGHIST"] = function()
	local sb = WIM_HistoryFrameMessageListScrollBar;
	local smf = WIM_HistoryFrameMessageListScrollingMessageFrame;
	local slider = sb and WIM_History_GetSlider(sb);
	local num, lines, so = "nil", "nil", "nil";
	if smf then
		if smf.GetNumMessages then num = tostring(smf:GetNumMessages() or 0) end
		if smf.GetNumLinesDisplayed then lines = tostring(smf:GetNumLinesDisplayed() or 1) end
		if smf.GetScrollOffset then so = tostring(smf:GetScrollOffset() or 0) end
	end
	local range = "n/a";
	if slider then
		local mn, mx = slider:GetMinMaxValues();
		range = string.format("min=%s max=%s val=%s", tostring(mn), tostring(mx), tostring(slider:GetValue()));
	end
	DEFAULT_CHAT_FRAME:AddMessage(
		"|cff00ff00[WIM]|r pos=" .. tostring(WIM_HistoryMsgPos) ..
		" max=" .. tostring(WIM_HistoryMsgMax) ..
		" | num=" .. num .. " lines=" .. lines .. " scrollOffset=" .. so
	);
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[WIM]|r slider: " .. range);
end


function WIM_HistoryView_ShowMessages()
	local tStamp = "";
	local tFrom = "";
	local tMsg = "";
	local prevDate = "";

	WIM_HistoryFrameMessageListScrollingMessageFrame:Clear();
	if(WIM_History[WIM_HistoryView_Name_Selected]) then
		for i = 1, table.getn(WIM_History[WIM_HistoryView_Name_Selected]) do
			if(WIM_HistoryView_Filter_Selected == "" or WIM_HistoryView_Filter_Selected == WIM_History[WIM_HistoryView_Name_Selected][i].date) then
				if(WIM_HistoryView_Filter_Selected == "") then
					if(prevDate ~= WIM_History[WIM_HistoryView_Name_Selected][i].date) then
						prevDate = WIM_History[WIM_HistoryView_Name_Selected][i].date
						WIM_HistoryFrameMessageListScrollingMessageFrame:AddMessage(" ");
						WIM_HistoryFrameMessageListScrollingMessageFrame:AddMessage("|cffffffff["..prevDate.."]|r");
					end
				end
				tStamp = "|cff"..WIM_RGBtoHex(WIM_Data.displayColors.sysMsg.r, WIM_Data.displayColors.sysMsg.g, WIM_Data.displayColors.sysMsg.b)..WIM_History[WIM_HistoryView_Name_Selected][i].time.."|r ";
				tFrom = "[|Hplayer:"..WIM_History[WIM_HistoryView_Name_Selected][i].from.."|h"..WIM_GetAlias(WIM_History[WIM_HistoryView_Name_Selected][i].from, true).."|h]: ";
				tMsg = tStamp..tFrom..WIM_History[WIM_HistoryView_Name_Selected][i].msg;
				if(WIM_History[WIM_HistoryView_Name_Selected][i].type == 1) then
					WIM_HistoryFrameMessageListScrollingMessageFrame:AddMessage(tMsg, WIM_Data.displayColors.wispIn.r, WIM_Data.displayColors.wispIn.g, WIM_Data.displayColors.wispIn.b);
				elseif(WIM_History[WIM_HistoryView_Name_Selected][i].type == 2) then
					WIM_HistoryFrameMessageListScrollingMessageFrame:AddMessage(tMsg, WIM_Data.displayColors.wispOut.r, WIM_Data.displayColors.wispOut.g, WIM_Data.displayColors.wispOut.b);
				end
			end
		end
	end
	WIM_UpdateScrollBars(WIM_HistoryFrameMessageListScrollingMessageFrame);
end
