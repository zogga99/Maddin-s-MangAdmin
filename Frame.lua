SLASH_MADDINSMANGADMIN1 = "/maddinsmangadmin";
-- use "/maddinsmangadmin debug" for debug-informations

version = "2010.05.13";
debugFlag = false;

reloadTables = {
	["01"] = {
		["text"] = "all",
		["command"] = ".reload all"
	},
	["02"] = {
		["text"] = "achievement",
		["command"] = ".reload all_achievement"
	},
	["03"] = {
		["text"] = "area",
		["command"] = ".reload all_area"
	},
	["04"] = {
		["text"] = "eventai",
		["command"] = ".reload all_eventai"
	},
	["05"] = {
		["text"] = "item",
		["command"] = ".reload all_item"
	},
	["06"] = {
		["text"] = "locales",
		["command"] = ".reload all_locales"
	},
	["07"] = {
		["text"] = "loot",
		["command"] = ".reload all_loot"
	},
	["08"] = {
		["text"] = "npc",
		["command"] = ".reload all_npc"
	},
	["09"] = {
		["text"] = "quest",
		["command"] = ".reload all_quest"
	},
	["10"] = {
		["text"] = "scripts",
		["command"] = ".reload all_scripts"
	},
	["11"] = {
		["text"] = "spell",
		["command"] = ".reload all_spell"
	}
};

SlashCmdList["MADDINSMANGADMIN"] = function(msg)
	if msg == "debug" then
		debugFlag = true;
	else
		debugFlag = false;
	end
	showMainFrame();
end

function showMainFrame()
	MainFrame:Show();
	TabTop:Show();
	TabBottom:Show();
	ButtonTabGeneral_OnClick();
	FontStringVersion:SetText("Version: "..version);
	
	ButtonHide.tooltipText = "Schließt das Fenster";
	ButtonServerexit.tooltipText = "Beenden den Server sofort";
	ButtonServerrestartCancel.tooltipText = "Bricht den Neustart des Servers ab";
	ButtonServershutdownCancel.tooltipText = "Bricht das Herunterfahren des Servers ab";
	ButtonServerReload.tooltipText = "Lädt die ausgewählte Tabelle(n) neu";
	
	alert("show frame ready");
end

function ButtonHide_OnClick()
	MainFrame:Hide();
end

function hideAllTabs()
	-- hide all tabs
	TabGeneral:Hide();
	TabServer:Hide();
	
	-- enable all buttons
	-- ButtonTabGeneral:Enable();
	-- ButtonTabServer:Enable();
	PanelTemplates_DeselectTab(ButtonTabGeneral);
	PanelTemplates_DeselectTab(ButtonTabServer);
	alert("all tabs are now hidden");
end

function ButtonTabGeneral_OnClick()
	hideAllTabs();
	TabGeneral:Show();
	-- ButtonTabGeneral:Disable();
	PanelTemplates_SelectTab(ButtonTabGeneral);
	alert("show tab general ready");
end

function ButtonTabServer_OnClick()
	hideAllTabs();
	TabServer:Show();
	-- ButtonTabServer:Disable();
	PanelTemplates_SelectTab(ButtonTabServer);
	alert("show tab server");
end

function ButtonServermessageSend_OnClick()
	if EditBoxServermessage:GetText() ~= "" then
		alert("send server message");
		command = ".announce "..EditBoxServermessage:GetText();
		executeCommand(command);
		command = ".notify "..EditBoxServermessage:GetText();
		executeCommand(command);
	else
		alert("no message to send");
	end
	
	EditBoxServermessage:SetText("");
	EditBoxServermessage:ClearFocus();
end

function ButtonServerrestart_OnClick()
	if EditBoxServertime:GetText() ~= "" then
		alert("restart server in "..EditBoxServertime:GetText().." seconds");
		command = ".server restart "..EditBoxServertime:GetText();
		executeCommand(command);
	else
		alert("no time set");
	end
	
	EditBoxServertime:SetText("");
	EditBoxServertime:ClearFocus();
end

function ButtonServershutdown_OnClick()
	if EditBoxServertime:GetText() ~= "" then
		alert("shutdown server in "..EditBoxServertime:GetText().." seconds");
		command = ".server shutdown "..EditBoxServertime:GetText();
		executeCommand(command);
	else
		alert("no time set");
	end
	
	EditBoxServertime:SetText("");
	EditBoxServertime:ClearFocus();
end

function ButtonServerexit_OnClick()
	alert("server exit");
	executeCommand(".server exit");
end

function ButtonServerrestartCancel_OnClick()
	alert("cancel server restart");
	executeCommand(".server restart cancel");
end

function ButtonServershutdownCancel_OnClick()
	alert("cancel server shutdown");
	executeCommand(".server shutdown cancel");
end

function ButtonServerMotdSave_OnClick()
	alert("save new message of the day");
	command = ".server set motd "..EditBoxMotd:GetText();
	executeCommand(command);
	
	EditBoxMotd:SetText("");
	EditBoxMotd:ClearFocus();
end

function ButtonServerMotdShow_OnClick()
	alert("show message of the day");
	executeCommand(".server motd");
end

function DropDownMenuTables_OnLoad()
	for key, subarray in pairs(reloadTables) do
		info		= {};
		info.text	= reloadTables[key].text;
		info.value	= key;
		info.func	= DropDownMenuTables_Selected
		UIDropDownMenu_AddButton(info);
	end
end

function DropDownMenuTables_Selected(element)
	UIDropDownMenu_SetSelectedValue(DropDownMenuTables, element.value);
end

function ButtonServerReload_OnClick()
	if UIDropDownMenu_GetSelectedValue(DropDownMenuTables) then
		executeCommand(reloadTables[UIDropDownMenu_GetSelectedValue(DropDownMenuTables)].command);
	end
end

function MouseOverShow(self)
	alert("show mouveover");
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(self:GetText(), 1, 1, 1);
	GameTooltip:AddLine(self.tooltipText);
	GameTooltip:Show();
end

function MouseOverHide(self)
	alert("hide mouseover");
	GameTooltip:Hide();
end

function executeCommand(command)
	alert("Execute: "..command);
	--SendChatMessage(command, "CHANNEL", nil, 1);
	SendChatMessage(command, "SAY", nil, nil);
	alert("Execution successfull");
end

function alert(msg)
	if debugFlag == true then
		print(msg);
	end
end