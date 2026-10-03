WIM_Options_CurrentSwatch = nil;
WIM_Options_AlreadyShown = false;

WIM_Alias_Selected = "";
WIM_Filter_Selected = "";
WIM_History_Selected = "";

function WIM_Options_OnShow()
	local tRGB;
	
	WIM_OptionsEnableWIM:SetChecked(WIM_Data.enableWIM);
	
	--[ Initialize Minimap Icon Frame 
		WIM_OptionsMiniMapIconPosition:SetValue(WIM_Data.iconPosition);
		WIM_OptionsMiniMapIconPositionTitle:SetText(WIM_L_ICONPOSIT);
		WIM_OptionsMiniMapEnabled:SetChecked(WIM_Data.showMiniMap);
		WIM_OptionsMiniMapFreeMoving:SetChecked(WIM_Data.miniFreeMoving.enabled);
	
	--[ Initialize Display Settings Frame 
		--[Swatches
		WIM_Options_CurrentSwatch = "WIM_OptionsDisplayIncomingWisp";
		tRGB = WIM_Data.displayColors.wispIn;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_Options_CurrentSwatch = "WIM_OptionsDisplayOutgoingWisp";
		tRGB = WIM_Data.displayColors.wispOut;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_Options_CurrentSwatch = "WIM_OptionsDisplaySystemMessage";
		tRGB = WIM_Data.displayColors.sysMsg;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_Options_CurrentSwatch = "WIM_OptionsDisplayErrorMessage";
		tRGB = WIM_Data.displayColors.errorMsg;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_Options_CurrentSwatch = "WIM_OptionsDisplayWebAddress";
		tRGB = WIM_Data.displayColors.webAddress;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_OptionsDisplayShowTimeStamps:SetChecked(WIM_Data.showTimeStamps);
		WIM_OptionsDisplayShowShortcutBar:SetChecked(WIM_Data.showShortcutBar);
		--[Character Info
		WIM_OptionsDisplayShowCharacterInfo:SetChecked(WIM_Data.characterInfo.show);
		WIM_OptionsDisplayShowCharacterInfoClassIcon:SetChecked(WIM_Data.characterInfo.classIcon);
		WIM_OptionsDisplayShowCharacterInfoClassColor:SetChecked(WIM_Data.characterInfo.classColor);
		WIM_OptionsDisplayShowCharacterInfoDetails:SetChecked(WIM_Data.characterInfo.details);
		
		--[Sliders
		WIM_OptionsDisplayFontSize:SetValue(WIM_Data.fontSize);
		WIM_OptionsDisplayFontSizeTitle:SetText(WIM_L_FONTSIZE);
		WIM_OptionsDisplayWindowSize:SetValue(WIM_Data.windowSize * 100);
		WIM_OptionsDisplayWindowSizeTitle:SetText(WIM_L_WINDOWSIZEPERC);
		WIM_OptionsDisplayWindowAlpha:SetValue(WIM_Data.windowAlpha * 100);
		WIM_OptionsDisplayWindowAlphaTitle:SetText(WIM_L_TRANSPARENCYPERC);
	--[ Initialize General Settings
		WIM_OptionsTabbedFrameGeneralKeepFocus:SetChecked(WIM_Data.keepFocus);
		WIM_OptionsTabbedFrameGeneralKeepFocusRested:SetChecked(WIM_Data.keepFocusRested);
		WIM_Options_KeepFocusClicked();
		WIM_OptionsTabbedFrameGeneralAutoFocus:SetChecked(WIM_Data.autoFocus);
		WIM_OptionsTabbedFrameGeneralShowToolTips:SetChecked(WIM_Data.showToolTips);
		WIM_OptionsTabbedFrameGeneralSupress:SetChecked(WIM_Data.supressWisps);
		WIM_OptionsTabbedFrameGeneralPopNew:SetChecked(WIM_Data.popNew);
		WIM_OptionsTabbedFrameGeneralPopUpdate:SetChecked(WIM_Data.popUpdate);
		WIM_Options_PopNewClicked();
		WIM_OptionsTabbedFrameGeneralPlaySoundWisp:SetChecked(WIM_Data.playSoundWisp);
		WIM_OptionsTabbedFrameGeneralSortOrderAlpha:SetChecked(WIM_Data.sortAlpha);
		WIM_OptionsTabbedFrameGeneralPopCombat:SetChecked(WIM_Data.popCombat);
		WIM_OptionsTabbedFrameGeneralPopOnSend:SetChecked(WIM_Data.popOnSend);
		WIM_OptionsTabbedFrameGeneralShowAFK:SetChecked(WIM_Data.showAFK);
		WIM_OptionsTabbedFrameGeneralUseEscape:SetChecked(WIM_Data.useEscape);
		WIM_OptionsTabbedFrameGeneralInterceptSlashWisp:SetChecked(WIM_Data.hookWispParse);
		
	--[ Window Settings
		WIM_OptionsTabbedFrameWindowWindowWidthTitle:SetText(WIM_L_WINDOWWIDTH);
		WIM_OptionsTabbedFrameWindowWindowWidth:SetValue(WIM_Data.winSize.width);
		WIM_OptionsTabbedFrameWindowWindowHeightTitle:SetText(WIM_L_WINDOWHEIGHT);
		WIM_OptionsTabbedFrameWindowWindowHeight:SetValue(WIM_Data.winSize.height);
		WIM_OptionsTabbedFrameWindowWindowCascade:SetChecked(WIM_Data.winCascade.enabled);
		
	--[ Filter Settings
		WIM_OptionsTabbedFrameFilterAliasEnabled:SetChecked(WIM_Data.enableAlias);
		WIM_OptionsTabbedFrameFilterFilteringEnabled:SetChecked(WIM_Data.enableFilter);
		WIM_OptionsTabbedFrameFilterAliasShowAsComment:SetChecked(WIM_Data.aliasAsComment);
		
	--[ History
		WIM_OptionsTabbedFrameHistoryEnabled:SetChecked(WIM_Data.enableHistory);
		WIM_OptionsTabbedFrameHistoryRecordEveryone:SetChecked(WIM_Data.historySettings.recordEveryone);
		WIM_OptionsTabbedFrameHistoryRecordFriends:SetChecked(WIM_Data.historySettings.recordFriends);
		WIM_OptionsTabbedFrameHistoryRecordGuild:SetChecked(WIM_Data.historySettings.recordGuild);
		WIM_Options_HistoryRecordEveryoneClicked();
		WIM_Options_CurrentSwatch = "WIM_OptionsTabbedFrameHistoryColorIn";
		tRGB = WIM_Data.historySettings.colorIn;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_Options_CurrentSwatch = "WIM_OptionsTabbedFrameHistoryColorOut";
		tRGB = WIM_Data.historySettings.colorOut;
		WIM_Options_UpdateSwatchColor(tRGB.r, tRGB.g, tRGB.b);
		WIM_OptionsTabbedFrameHistoryShowInMessage:SetChecked(WIM_Data.historySettings.popWin.enabled);
		WIM_OptionsTabbedFrameHistorySetMaxToStore:SetChecked(WIM_Data.historySettings.maxMsg.enabled);
		WIM_OptionsTabbedFrameHistorySetAutoDelete:SetChecked(WIM_Data.historySettings.autoDelete.enabled);
	--[ Other
		
		WIM_Options_ShowShortcutBarClicked();
		WIM_HistoryScrollBar_Update();
		
	if(not WIM_Options_AlreadyShown) then
		WIM_Options_General_Click();
		WIM_Options_AlreadyShown = true;
	end
end


function WIM_Options_ShowMiniMapClick()
	if(WIM_OptionsMiniMapEnabled:GetChecked()) then
		WIM_Data.showMiniMap = true;
		if(WIM_Data.miniFreeMoving.enabled) then
			WIM_IconFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT",WIM_Data.miniFreeMoving.left,WIM_Data.miniFreeMoving.top);
			WIM_IconFrame:Show();
			return;
		end
	else
		WIM_Data.showMiniMap = false;
	end
	WIM_Icon_UpdatePosition();
end

function WIM_Options_OpenColorPicker(button)
	CloseMenus();
	WIM_Options_CurrentSwatch = button:GetName();
	ColorPickerFrame.hasOpacity = false;
	ColorPickerFrame.func = WIM_Options_ColorPickerChanged;
	ColorPickerFrame:SetColorRGB(button.r, button.g, button.b);
	ColorPickerFrame.previousValues = {button.r, button.g, button.b};
	ColorPickerFrame.cancelFunc = WIM_Options_ColorPickerCanceled;
	ColorPickerFrame:SetFrameStrata("DIALOG");
	ColorPickerFrame:Show();
end

function WIM_Options_ColorPickerChanged()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	WIM_Options_UpdateSwatchColor(r,g,b);
end

function WIM_Options_ColorPickerCanceled(prevvals)
	local r,g,b = unpack(prevvals)
	WIM_Options_UpdateSwatchColor(r,g,b);
end


function WIM_Options_UpdateSwatchColor(r,g,b)
	if(WIM_Options_CurrentSwatch == "WIM_OptionsDisplayIncomingWisp") then
		WIM_Data.displayColors.wispIn.r = r;
		WIM_Data.displayColors.wispIn.g = g;
		WIM_Data.displayColors.wispIn.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsDisplayOutgoingWisp") then
		WIM_Data.displayColors.wispOut.r = r;
		WIM_Data.displayColors.wispOut.g = g;
		WIM_Data.displayColors.wispOut.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsDisplaySystemMessage") then
		WIM_Data.displayColors.sysMsg.r = r;
		WIM_Data.displayColors.sysMsg.g = g;
		WIM_Data.displayColors.sysMsg.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsDisplayErrorMessage") then
		WIM_Data.displayColors.errorMsg.r = r;
		WIM_Data.displayColors.errorMsg.g = g;
		WIM_Data.displayColors.errorMsg.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsDisplayWebAddress") then
		WIM_Data.displayColors.webAddress.r = r;
		WIM_Data.displayColors.webAddress.g = g;
		WIM_Data.displayColors.webAddress.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsTabbedFrameHistoryColorIn") then
		WIM_Data.historySettings.colorIn.r = r;
		WIM_Data.historySettings.colorIn.g = g;
		WIM_Data.historySettings.colorIn.b = b;
	elseif(WIM_Options_CurrentSwatch == "WIM_OptionsTabbedFrameHistoryColorOut") then
		WIM_Data.historySettings.colorOut.r = r;
		WIM_Data.historySettings.colorOut.g = g;
		WIM_Data.historySettings.colorOut.b = b;
	end

	getglobal(WIM_Options_CurrentSwatch).r = r;
	getglobal(WIM_Options_CurrentSwatch).g = g;
	getglobal(WIM_Options_CurrentSwatch).b = b;
	getglobal(WIM_Options_CurrentSwatch.."_ColorSwatchNormalTexture"):SetVertexColor(r,g,b);
end

local WIM_Options_TabInfo = {
	{ tab = "WIM_OptionsOptionTab1", panel = "WIM_OptionsTabbedFrameGeneral" },
	{ tab = "WIM_OptionsOptionTab2", panel = "WIM_OptionsTabbedFrameWindow" },
	{ tab = "WIM_OptionsOptionTab3", panel = "WIM_OptionsTabbedFrameFilter" },
	{ tab = "WIM_OptionsOptionTab4", panel = "WIM_OptionsTabbedFrameHistory" },
};

local function WIM_Options_ShowTab(idx)
	for i, info in ipairs(WIM_Options_TabInfo) do
		local tab = getglobal(info.tab);
		if(i == idx) then
			PanelTemplates_SelectTab(tab);
		else
			PanelTemplates_DeselectTab(tab);
		end
	end
	for i, info in ipairs(WIM_Options_TabInfo) do
		local panel = getglobal(info.panel);
		if(i == idx) then
			panel:Show();
		else
			panel:Hide();
		end
	end
	if(idx == 1) then
		WIM_Options_GeneralScroll:Show();
	else
		WIM_Options_GeneralScroll:Hide();
	end
end

function WIM_Options_General_Click()
	WIM_Options_ShowTab(1);
end

function WIM_Options_Windows_Click()
	WIM_Options_ShowTab(2);
end

function WIM_Options_Filter_Click()
	WIM_Options_ShowTab(3);
end

function WIM_Options_History_Click()
	WIM_Options_ShowTab(4);
end

-- Shared checkbox handler: writes a checked state into WIM_Data and runs
-- optional extra logic. `path` may be dotted for nested keys (e.g.
-- "historySettings.recordFriends").
local function WIM_Options_SetCheckedState(path, checkboxName, extra)
	local checkbox = getglobal(checkboxName);
	if(checkbox) then
		local segs = {};
		for segment in string.gmatch(path, "[^.]+") do
			segs[#segs + 1] = segment;
		end
		local t = WIM_Data;
		for i = 1, #segs - 1 do
			t = t[segs[i]];
		end
		if(checkbox:GetChecked()) then
			t[segs[#segs]] = true;
		else
			t[segs[#segs]] = false;
		end
	end
	if(extra) then
		extra(checkbox);
	end
end

function WIM_Options_SupressWispsClicked()
	WIM_Options_SetCheckedState("supressWisps", "WIM_OptionsTabbedFrameGeneralSupress");
end

function WIM_Options_KeepFocusClicked()
	WIM_Options_SetCheckedState("keepFocus", "WIM_OptionsTabbedFrameGeneralKeepFocus", function(cb)
		if(cb and cb:GetChecked()) then
			WIM_OptionsTabbedFrameGeneralKeepFocusRested:Enable();
		else
			WIM_OptionsTabbedFrameGeneralKeepFocusRested:Disable();
		end
	end);
end

function WIM_Options_KeepFocusRestedClicked()
	WIM_Options_SetCheckedState("keepFocusRested", "WIM_OptionsTabbedFrameGeneralKeepFocusRested");
end

function WIM_Options_AutoFocusClicked()
	WIM_Options_SetCheckedState("autoFocus", "WIM_OptionsTabbedFrameGeneralAutoFocus");
end

function WIM_Options_PopNewClicked()
	WIM_Options_SetCheckedState("popNew", "WIM_OptionsTabbedFrameGeneralPopNew", function(cb)
		if(cb and cb:GetChecked()) then
			WIM_OptionsTabbedFrameGeneralPopUpdate:Enable();
			WIM_OptionsTabbedFrameGeneralPopCombat:Enable();
		else
			WIM_OptionsTabbedFrameGeneralPopUpdate:Disable();
			WIM_OptionsTabbedFrameGeneralPopCombat:Disable();
		end
	end);
end

function WIM_Options_PopUpdateClicked()
	WIM_Options_SetCheckedState("popUpdate", "WIM_OptionsTabbedFrameGeneralPopUpdate");
end

function WIM_Options_PopOnSendClicked()
	WIM_Options_SetCheckedState("popOnSend", "WIM_OptionsTabbedFrameGeneralPopOnSend");
end

function WIM_Options_PlaySoundWispClicked()
	WIM_Options_SetCheckedState("playSoundWisp", "WIM_OptionsTabbedFrameGeneralPlaySoundWisp");
end

function WIM_Options_ShowToolTipsClicked()
	WIM_Options_SetCheckedState("showToolTips", "WIM_OptionsTabbedFrameGeneralShowToolTips");
end

function WIM_Options_SortOrderAlphaClicked()
	WIM_Options_SetCheckedState("sortAlpha", "WIM_OptionsTabbedFrameGeneralSortOrderAlpha");
	WIM_Icon_DropDown_Update();
end

function WIM_Options_ShowAFKClicked()
	WIM_Options_SetCheckedState("showAFK", "WIM_OptionsTabbedFrameGeneralShowAFK");
end

function WIM_Options_UseEscapeClicked()
	WIM_Options_SetCheckedState("useEscape", "WIM_OptionsTabbedFrameGeneralUseEscape");
	WIM_SetAllWindowProps();
end

function WIM_Options_InterceptSlashWispClicked()
	WIM_Options_SetCheckedState("hookWispParse", "WIM_OptionsTabbedFrameGeneralInterceptSlashWisp");
end


function WIM_Options_FreeMoving_Clicked()
	WIM_Options_SetCheckedState("miniFreeMoving.enabled", "WIM_OptionsMiniMapFreeMoving", function(cb)
		if(cb and cb:GetChecked()) then
			WIM_Data.miniFreeMoving.left = WIM_IconFrame:GetLeft();
			WIM_Data.miniFreeMoving.top = WIM_IconFrame:GetTop();
			WIM_IconFrame:ClearAllPoints();
			WIM_IconFrame:SetFrameStrata("HIGH");
			WIM_IconFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", WIM_Data.miniFreeMoving.left, WIM_Data.miniFreeMoving.top);
		else
			WIM_IconFrame:SetFrameStrata("LOW");
			WIM_Icon_UpdatePosition();
		end
	end);
end

function WIM_Options_PopCombatClicked()
	WIM_Options_SetCheckedState("popCombat", "WIM_OptionsTabbedFrameGeneralPopCombat");
end

function WIM_Options_CharacerInfoClicked()
	WIM_Options_SetCheckedState("characterInfo.show", "WIM_OptionsDisplayShowCharacterInfo", function(cb)
		if(cb and cb:GetChecked()) then
			WIM_OptionsDisplayShowCharacterInfoClassIcon:Enable();
			WIM_OptionsDisplayShowCharacterInfoClassColor:Enable();
		else
			WIM_OptionsDisplayShowCharacterInfoClassIcon:Disable();
			WIM_OptionsDisplayShowCharacterInfoClassColor:Disable();
		end
	end);
end

function WIM_Options_CharacerInfoClassIconClicked()
	WIM_Options_SetCheckedState("characterInfo.classIcon", "WIM_OptionsDisplayShowCharacterInfoClassIcon");
end

function WIM_Options_CharacerInfoClassColorClicked()
	WIM_Options_SetCheckedState("characterInfo.classColor", "WIM_OptionsDisplayShowCharacterInfoClassColor");
end

function WIM_Options_CharacerInfoDetailsClicked()
	WIM_Options_SetCheckedState("characterInfo.details", "WIM_OptionsDisplayShowCharacterInfoDetails");
end

function WIM_Options_ShowTimeStampsClicked()
	WIM_Options_SetCheckedState("showTimeStamps", "WIM_OptionsDisplayShowTimeStamps");
end

function WIM_Options_EnableWIMClicked()
	WIM_Options_SetCheckedState("enableWIM", "WIM_OptionsEnableWIM");
	WIM_SetWIM_Enabled(WIM_Data.enableWIM);
end

function WIM_Options_ShowShortcutBarClicked()
	WIM_Options_SetCheckedState("showShortcutBar", "WIM_OptionsDisplayShowShortcutBar", function(cb)
		if(cb and cb:GetChecked()) then
			WIM_OptionsTabbedFrameWindowWindowHeightTitle:SetText(WIM_L_WINDOWHEIGHTLIM);
		else
			WIM_OptionsTabbedFrameWindowWindowHeightTitle:SetText(WIM_L_WINDOWHEIGHT);
		end
	end);
	WIM_SetAllWindowProps();
end

function WIM_AliasScrollBar_Update()
	local line;
	local lineplusoffset;
	local AliasNames = {};
	
	for key in WIM_Alias do
		table.insert(AliasNames, key);
	end
	
	FauxScrollFrame_Update(WIM_OptionsTabbedFrameFilterAliasPanelScrollBar,table.getn(AliasNames),5,16);
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(WIM_OptionsTabbedFrameFilterAliasPanelScrollBar);
		if (lineplusoffset <= table.getn(AliasNames)) then
			getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line.."Name"):SetText(AliasNames[lineplusoffset]);
			getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line.."Alias"):SetText(WIM_Alias[AliasNames[lineplusoffset]]);
			getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line).theAliasName = AliasNames[lineplusoffset];
			if ( WIM_Alias_Selected == AliasNames[lineplusoffset] ) then
				getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line):LockHighlight();
			else
				getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line):UnlockHighlight();
			end
			getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line):Show();
		else
			getglobal("WIM_OptionsTabbedFrameFilterAliasPanelButton"..line):Hide();
		end
	end

end

function WIM_Options_AliasWindow_Click()
	local name = WIM_Options_AliasWindow_Name:GetText();
	local alias = WIM_Options_AliasWindow_Alias:GetText();
	
	name = string.gsub(name, " ", "");
	name = string.gsub(name, "^%l", string.upper)
	alias = string.gsub(alias, " ", "");
	
	if(name == "") then
		WIM_Options_AliasWindow_Error:SetText(WIM_L_ERRINVNAME);
		return;
	end
	if(alias == "") then
		WIM_Options_AliasWindow_Error:SetText(WIM_L_ERRINVALIAS);
		return;
	end
	if(WIM_Options_AliasWindow.theMode == "add" and WIM_Alias[name] ~= nil) then
		WIM_Options_AliasWindow_Error:SetText(WIM_L_ERRNAMEALREADYUSED);
		return;
	end
	
	WIM_Alias[name] = alias;
	
	if(WIM_Options_AliasWindow.theMode == "edit" and name ~= WIM_Options_AliasWindow.prevName)then
		WIM_Alias[WIM_Options_AliasWindow.prevName] = nil;
	end

	
	WIM_AliasScrollBar_Update();
	PlaySound("igMainMenuClose");
	WIM_Options_AliasWindow:Hide();
end


function WIM_Options_AliasEnabledClicked()
	WIM_Options_SetCheckedState("enableAlias", "WIM_OptionsTabbedFrameFilterAliasEnabled");
end

function WIM_Options_FilteringEnabledClicked()
	WIM_Options_SetCheckedState("enableFilter", "WIM_OptionsTabbedFrameFilterFilteringEnabled");
end

function WIM_FilteringScrollBar_Update()
	local line;
	local lineplusoffset;
	local FilteringNames = {};
	
	for key in WIM_Filters do
		table.insert(FilteringNames, key);
	end
	
	FauxScrollFrame_Update(WIM_OptionsTabbedFrameFilterFilteringPanelScrollBar,table.getn(FilteringNames),5,16);
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(WIM_OptionsTabbedFrameFilterFilteringPanelScrollBar);
		if lineplusoffset <= table.getn(FilteringNames) then
			getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line.."Name"):SetText(FilteringNames[lineplusoffset]);
			getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line.."Action"):SetText(WIM_Filters[FilteringNames[lineplusoffset]]);
			getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line).theFilterName = FilteringNames[lineplusoffset];
			if ( WIM_Filter_Selected == FilteringNames[lineplusoffset] ) then
				getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line):LockHighlight();
			else
				getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line):UnlockHighlight();
			end
			getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line):Show();
		else
			getglobal("WIM_OptionsTabbedFrameFilterFilteringPanelButton"..line):Hide();
		end
	end

end


function WIM_Options_FilteringIgnoreClicked()
	if(WIM_Options_FilterWindow_ActionIgnore:GetChecked()) then
		WIM_Options_FilterWindow.theAction = "Ignore";
		WIM_Options_FilterWindow_ActionBlock:SetChecked(false);
	else
		WIM_Options_FilterWindow_ActionBlock:SetChecked(true);
	end
end

function WIM_Options_FilteringBlockClicked()
	if(WIM_Options_FilterWindow_ActionBlock:GetChecked()) then
		WIM_Options_FilterWindow.theAction = "Block";
		WIM_Options_FilterWindow_ActionIgnore:SetChecked(false);
	else
		WIM_Options_FilterWindow_ActionIgnore:SetChecked(true);
	end
end

function WIM_Options_FilterWindow_Click()
	local name = WIM_Options_FilterWindow_Name:GetText();
	local action = WIM_Options_FilterWindow.theAction;
	
	local tname = string.gsub(name, " ", "");
	
	if(tname == "") then
		WIM_Options_FilterWindow_Error:SetText(WIM_L_ERRINVALIDKEYWORD);
		return;
	end
	if(WIM_Options_FilterWindow.theMode == "add" and WIM_Filters[name] ~= nil) then
		WIM_Options_FilterWindow_Error:SetText(WIM_L_ERRKEYWORDALREADYUSED);
		return;
	end
	
	WIM_Filters[name] = action;
	
	if(WIM_Options_FilterWindow.theMode == "edit" and name ~= WIM_Options_FilterWindow.prevName)then
		WIM_Filters[WIM_Options_FilterWindow.prevName] = nil;
	end
	
	WIM_FilteringScrollBar_Update();
	PlaySound("igMainMenuClose");
	WIM_Options_FilterWindow:Hide();
end

function WIM_Options_AliasShowAsCommentClicked()
	WIM_Options_SetCheckedState("aliasAsComment", "WIM_OptionsTabbedFrameFilterAliasShowAsComment");
end

function WIM_Options_HistoryEnabledClicked()
	WIM_Options_SetCheckedState("enableHistory", "WIM_OptionsTabbedFrameHistoryEnabled");
end

function WIM_Options_HistoryRecordEveryoneClicked()
	WIM_Options_SetCheckedState("historySettings.recordEveryone", "WIM_OptionsTabbedFrameHistoryRecordEveryone", function(cb)
		if(cb and cb:GetChecked()) then
			WIM_OptionsTabbedFrameHistoryRecordFriends:Disable();
			WIM_OptionsTabbedFrameHistoryRecordGuild:Disable();
		else
			WIM_OptionsTabbedFrameHistoryRecordFriends:Enable();
			WIM_OptionsTabbedFrameHistoryRecordGuild:Enable();
		end
	end);
end

function WIM_Options_HistoryRecordFriendsClicked()
	WIM_Options_SetCheckedState("historySettings.recordFriends", "WIM_OptionsTabbedFrameHistoryRecordFriends");
end

function WIM_Options_HistoryRecordGuildClicked()
	WIM_Options_SetCheckedState("historySettings.recordGuild", "WIM_OptionsTabbedFrameHistoryRecordGuild");
end

function WIM_Options_HistoryShowInMessageClicked()
	WIM_Options_SetCheckedState("historySettings.popWin.enabled", "WIM_OptionsTabbedFrameHistoryShowInMessage");
end

function WIM_Options_HistorySetMaxToStoreClicked()
	WIM_Options_SetCheckedState("historySettings.maxMsg.enabled", "WIM_OptionsTabbedFrameHistorySetMaxToStore");
end

function WIM_Options_HistorySetAutoDeleteClicked()
	WIM_Options_SetCheckedState("historySettings.autoDelete.enabled", "WIM_OptionsTabbedFrameHistorySetAutoDelete");
end

function WIM_Options_HistoryMessageCount_OnShow()
	UIDropDownMenu_Initialize(this, WIM_Options_HistoryMessageCount_Initialize);
	UIDropDownMenu_SetSelectedValue(this, WIM_Data.historySettings.popWin.count);
	UIDropDownMenu_SetWidth(60, WIM_OptionsTabbedFrameHistoryMessageCount);
end

function WIM_Options_HistoryMessageCount_Initialize()
	local info = {};
	info = { };
	info.text = "1";
	info.value = 1;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMessageClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "5";
	info.value = 5;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMessageClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "10";
	info.value = 10;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMessageClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "25";
	info.value = 25;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMessageClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "50";
	info.value = 50;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMessageClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function WIM_Options_HistoryMessageClick()
	WIM_Data.historySettings.popWin.count = this.value;
	UIDropDownMenu_SetSelectedValue(WIM_OptionsTabbedFrameHistoryMessageCount, WIM_Data.historySettings.popWin.count);
end

function WIM_Options_HistoryMaxCount_OnShow()
	UIDropDownMenu_Initialize(this, WIM_Options_HistoryMaxCount_Initialize);
	UIDropDownMenu_SetSelectedValue(this, WIM_Data.historySettings.maxMsg.count);
	UIDropDownMenu_SetWidth(60, WIM_OptionsTabbedFrameHistoryMaxCount);
end

function WIM_Options_HistoryMaxCount_Initialize()
	local info = {};
	info = { };
	info.text = "50";
	info.value = 50;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "100";
	info.value = 100;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "200";
	info.value = 200;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "300";
	info.value = 300;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "400";
	info.value = 400;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = "500";
	info.value = 500;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryMaxClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function WIM_Options_HistoryMaxClick()
	WIM_Data.historySettings.maxMsg.count = this.value;
	UIDropDownMenu_SetSelectedValue(WIM_OptionsTabbedFrameHistoryMaxCount, WIM_Data.historySettings.maxMsg.count);
end

function WIM_Options_HistoryAutoDeleteTime_OnShow()
	UIDropDownMenu_Initialize(this, WIM_Options_HistoryAutoDeleteTime_Initialize);
	UIDropDownMenu_SetSelectedValue(this, WIM_Data.historySettings.autoDelete.days);
	UIDropDownMenu_SetWidth(75, WIM_OptionsTabbedFrameHistoryAutoDeleteTime);
end

function WIM_Options_HistoryAutoDeleteTime_Initialize()
	local info = {};
	info = { };
	info.text = WIM_L_DAY;
	info.value = 1;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryAutoDeleteTimeClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_L_WEEK;
	info.value = 7;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryAutoDeleteTimeClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_L_MONTH;
	info.value = 30;
	info.justifyH = "LEFT";
	info.func = WIM_Options_HistoryAutoDeleteTimeClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function WIM_Options_HistoryAutoDeleteTimeClick()
	WIM_Data.historySettings.autoDelete.days = this.value;
	UIDropDownMenu_SetSelectedValue(WIM_OptionsTabbedFrameHistoryAutoDeleteTime, WIM_Data.historySettings.autoDelete.days);
end

function WIM_HistoryScrollBar_Update()
	local line;
	local lineplusoffset;
	local HistoryNames = {};
	
	for key in WIM_History do
		table.insert(HistoryNames, key);
	end
	table.sort(HistoryNames);
	
	FauxScrollFrame_Update(WIM_OptionsTabbedFrameHistoryPanelScrollBar,table.getn(HistoryNames),5,16);
	for line=1,5 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(WIM_OptionsTabbedFrameHistoryPanelScrollBar);
		if lineplusoffset <= table.getn(HistoryNames) then
			getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line.."Name"):SetText(HistoryNames[lineplusoffset]);
			getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line.."MessageCount"):SetText(table.getn(WIM_History[HistoryNames[lineplusoffset]]));
			getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line).theName = HistoryNames[lineplusoffset];
			if ( WIM_History_Selected == HistoryNames[lineplusoffset] ) then
				getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line):LockHighlight();
			else
				getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line):UnlockHighlight();
			end
			getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line):Show();
		else
			getglobal("WIM_OptionsTabbedFrameHistoryPanelButton"..line):Hide();
		end
	end
end

function WIM_Options_WindowAnchorToggle_Click()
	if(WIM_WindowAnchor:IsVisible()) then
		WIM_WindowAnchor:Hide();
		GameTooltip:Hide();
	else
		WIM_WindowAnchor:SetPoint(
			"TOPLEFT",
			"UIParent",
			"BOTTOMLEFT",
			WIM_Data.winLoc.left, 
			WIM_Data.winLoc.top
		);
		WIM_WindowAnchor:Show();
		GameTooltip:SetOwner(WIM_WindowAnchor, "ANCHOR_RIGHT");
		GameTooltip:SetText(WIM_L_DRAGTOSETDEFSPAWN);
	end
end

function WIM_Options_WindowCascadeClicked()
	if(WIM_OptionsTabbedFrameWindowWindowCascade:GetChecked()) then
		WIM_Data.winCascade.enabled = true;
	else
		WIM_Data.winCascade.enabled = false;
	end
end

function WIM_Options_CascadeDirection_OnShow()
	UIDropDownMenu_Initialize(this, WIM_Options_CascadeDirection_Initialize);
	UIDropDownMenu_SetSelectedValue(this, WIM_Data.winCascade.direction);
	UIDropDownMenu_SetWidth(100, WIM_OptionsTabbedFrameWindowCascadeDirection);
end

function WIM_Options_CascadeDirection_Initialize()
	local info = {};
	info = { };
	info.text = WIM_L_UP;
	info.value = "up";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_L_DOWN;
	info.value = "down";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_L_LEFT;
	info.value = "left";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_L_RIGHT;
	info.value = "right";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_L_UPANDLEFT;
	info.value = "upleft";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_L_UPANDRIGHT;
	info.value = "upright";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_L_DOWNANDLEFT;
	info.value = "downleft";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	info = { };
	info.text = WIM_L_DOWNANDRIGHT;
	info.value = "downright";
	info.justifyH = "LEFT";
	info.func = WIM_Options_CascadeDirectionClick;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function WIM_Options_CascadeDirectionClick()
	WIM_Data.winCascade.direction = this.value;
	WIM_CascadeStep = 0;
	UIDropDownMenu_SetSelectedValue(WIM_OptionsTabbedFrameWindowCascadeDirection, WIM_Data.winCascade.direction);
end

local function WIM_TrimWhitespaceLines(text)
	text = text:gsub("^%s*\n", "")
	text = text:gsub("\n%s*$", "")
	return text
end

local WIM_HelpBlockFrames = {}
local WIM_HelpBlockGap = 8
local WIM_HelpContentHeight = 0

-- Render the help text as stacked child frames (one per block of lines) inside
-- the scroll child. This client never computes a scroll range for a bare text
-- widget, but it ranges real Frames fine (same as the working lists elsewhere),
-- so giving it frame children restores the native wheel/scrollbar behavior.
-- Frames are pooled by index and reused (1.12 has no frame destruction, so we
-- never grow the pool beyond the largest tab's block count).
local function WIM_Help_GetBlock(i, width)
	local frame = WIM_HelpBlockFrames[i]
	if not frame then
		frame = CreateFrame("Frame", nil, WIM_HelpScrollFrameScrollChild)
		local fs = frame:CreateFontString(nil, "ARTWORK")
		fs:SetFont("Fonts\\FRIZQT__.TTF", 12, "")
		fs:SetTextColor(1, 0.8196079, 0)
		fs:SetShadowColor(0, 0, 0)
		fs:SetShadowOffset(1, -1)
		fs:SetJustifyH("LEFT")
		frame.fs = fs
		WIM_HelpBlockFrames[i] = frame
	end
	frame:SetWidth(width)
	frame.fs:SetWidth(width)
	return frame
end

local function WIM_Help_BuildBlocks(text, scrollChild, width)
	local blocks = {}
	local current = {}
	for line in (text .. "\n"):gmatch("(.-)\n") do
		if line == "" then
			if #current > 0 then
				blocks[#blocks + 1] = table.concat(current, "\n")
				current = {}
			end
		else
			current[#current + 1] = line
		end
	end
	if #current > 0 then
		blocks[#blocks + 1] = table.concat(current, "\n")
	end

	local previous
	WIM_HelpContentHeight = 0
	for i = 1, #blocks do
		local frame = WIM_Help_GetBlock(i, width)
		local fs = frame.fs

		fs:SetText(blocks[i])
		fs:ClearAllPoints()
		fs:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame:SetHeight(fs:GetHeight())

		frame:ClearAllPoints()
		if previous then
			frame:SetPoint("TOPLEFT", previous, "BOTTOMLEFT", 0, -WIM_HelpBlockGap)
		else
			frame:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, 0)
		end
		frame:Show()

		WIM_HelpContentHeight = WIM_HelpContentHeight + frame:GetHeight() + WIM_HelpBlockGap
		previous = frame
	end

	-- Hide any pooled frames left over from a larger earlier tab.
	for i = #blocks + 1, #WIM_HelpBlockFrames do
		WIM_HelpBlockFrames[i]:Hide()
	end

	if WIM_HelpContentHeight > 0 then
		WIM_HelpContentHeight = WIM_HelpContentHeight - WIM_HelpBlockGap
	end
end

local function WIM_Help_SetText(text)
	local scrollFrame = WIM_HelpScrollFrame
	local scrollChild = WIM_HelpScrollFrameScrollChild

	scrollChild:SetWidth(scrollFrame:GetWidth())
	WIM_Help_BuildBlocks(text, scrollChild, scrollFrame:GetWidth())

	local scrollBar = WIM_HelpScrollFrameScrollBar
	local maxScroll = math.max(0, WIM_HelpContentHeight - scrollFrame:GetHeight())
	if scrollBar then
		scrollBar:SetMinMaxValues(0, math.max(maxScroll, 1))
		scrollBar:SetValue(0)
	end
	scrollFrame:UpdateScrollChildRect()
	if scrollFrame.SetVerticalScroll then
		scrollFrame:SetVerticalScroll(0)
	end
end

local WIM_Help_TabInfo = {
	{ tab = "WIM_HelpTab1", textKey = "WIM_DESCRIPTION" },
	{ tab = "WIM_HelpTab2", textKey = "WIM_CHANGE_LOG" },
	{ tab = "WIM_HelpTab3", textKey = "WIM_DIDYOUKNOW" },
	{ tab = "WIM_HelpTabCredits", textKey = "WIM_CREDITS" },
};

local function WIM_Help_ShowTab(idx)
	for i, info in ipairs(WIM_Help_TabInfo) do
		local tab = getglobal(info.tab);
		if(i == idx) then
			PanelTemplates_SelectTab(tab);
		else
			PanelTemplates_DeselectTab(tab);
		end
	end
	WIM_Help_SetText(WIM_TrimWhitespaceLines(getglobal(WIM_Help_TabInfo[idx].textKey)));
end

function WIM_Help_Description_Click()
	WIM_Help_ShowTab(1);
end

function WIM_Help_ChangeLog_Click()
	WIM_Help_ShowTab(2);
end

function WIM_Help_DidYouKnow_Click()
	WIM_Help_ShowTab(3);
end

function WIM_Help_Credits_Click()
	WIM_Help_ShowTab(4);
end