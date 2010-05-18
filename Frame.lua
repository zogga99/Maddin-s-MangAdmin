SLASH_MADDINSMANGADMIN1 = "/maddinsmangadmin";
-- use "/maddinsmangadmin debug" for debug-informations
-- use "/maddinsmangadmin debug_extended" for extended debug-informations

version = "2010.05.18";
debugFlag = 0;

reloadTables = {
	["all"] = {
		["text"] = "all",
		["command"] = ".reload all"
	},
	["achievement"] = {
		["text"] = "achievement",
		["command"] = ".reload all_achievement"
	},
	["area"] = {
		["text"] = "area",
		["command"] = ".reload all_area"
	},
	["eventai"] = {
		["text"] = "eventai",
		["command"] = ".reload all_eventai"
	},
	["item"] = {
		["text"] = "item",
		["command"] = ".reload all_item"
	},
	["locales"] = {
		["text"] = "locales",
		["command"] = ".reload all_locales"
	},
	["loot"] = {
		["text"] = "loot",
		["command"] = ".reload all_loot"
	},
	["npc"] = {
		["text"] = "npc",
		["command"] = ".reload all_npc"
	},
	["quest"] = {
		["text"] = "quest",
		["command"] = ".reload all_quest"
	},
	["scripts"] = {
		["text"] = "scripts",
		["command"] = ".reload all_scripts"
	},
	["spell"] = {
		["text"] = "spell",
		["command"] = ".reload all_spell"
	}
};

reloadTablesOrder = {
	"all",
	"achievement",
	"area",
	"eventai",
	"item",
	"locales",
	"loot",
	"npc",
	"quest",
	"scripts",
	"spell"
};

AccountExtensions = {
	["normal"] = {
		["text"] = "Normal",
		["command"] = "0"
	},
	["tbc"] = {
		["text"] =  "The Burning Crusade",
		["command"] = "1"
	},
	["wotlk"] = {
		["text"] = "Wrath of the LichKing",
		["command"] = "2"
	}
};

AccountExtensionsOrder = {
	"normal",
	"tbc",
	"wotlk"
};

AccountGmLevel = {
	["0"] = {
		["text"] = "0",
		["command"] = "0"
	},
	["1"] = {
		["text"] = "1",
		["command"] = "1"
	},
	["2"] = {
		["text"] = "2",
		["command"] = "2"
	},
	["3"] = {
		["text"] = "3",
		["command"] = "3"
	}
};

AccountGmLevelOrder = {
	"0",
	"1",
	"2",
	"3"
};

SlashCmdList["MADDINSMANGADMIN"] = function(msg)
	if msg == "debug" then
		debugFlag = 1;
	elseif msg == "debug_extended" then
		debugFlag = 2;
	else
		debugFlag = 0;
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
	
	ButtonAccountExtensionSave.tooltipText = "Speichert die ausgewählte Erweiterung";
	ButtonAccountGmLevelShow.tooltipText = "Zeigt die aktuelle Berechtigungsstufe an";
	
	ButtonServermessageSend.tooltipText = "Sendet den eingegebenen Text an alle Spieler die gerade online sind";
	ButtonServerrestart.tooltipText = "Startet den Server nach x Sekunden neu";
	ButtonServerShutdown.tooltipText = "Fährt den Server nach x Sekunden herunter";
	ButtonServerexit.tooltipText = "Beenden den Server sofort";
	ButtonServerrestartCancel.tooltipText = "Bricht den Neustart des Servers ab";
	ButtonServershutdownCancel.tooltipText = "Bricht das Herunterfahren des Servers ab";
	ButtonServerMotdSave.tooltipText = "Ändert die Nachricht des Tages";
	ButtonServerMotdShow.tooltipText = "Zeigt die aktuelle Nachricht des Tages im Chat-Fenster an";
	ButtonServerReload.tooltipText = "Lädt die ausgewählte Tabelle(n) neu";
	ButtonServerReloadConfigFile.tooltipText = "Lädt die Serverkonfigurationsdatei neu";
	
	alert("show frame ready", 1);
end

function ButtonHide_OnClick()
	MainFrame:Hide();
end

function hideAllTabs()
	alert("hide all tabs", 1);
	
	-- hide all tabs
	TabGeneral:Hide();
	TabPlayer:Hide();
	TabAccount:Hide();
	TabServer:Hide();
	
	-- enable all tabs
	PanelTemplates_DeselectTab(ButtonTabGeneral);
	PanelTemplates_DeselectTab(ButtonTabPlayer);
	PanelTemplates_DeselectTab(ButtonTabAccount);
	PanelTemplates_DeselectTab(ButtonTabServer);
end

function ButtonTabGeneral_OnClick()
	alert("show tab general ready", 1);
	hideAllTabs();
	TabGeneral:Show();
	PanelTemplates_SelectTab(ButtonTabGeneral);
end

function ButtonTabPlayer_OnClick()
	alert("show tab player", 1);
	hideAllTabs();
	TabPlayer:Show();
	PanelTemplates_SelectTab(ButtonTabPlayer);
end

function ButtonTabAccount_OnClick()
	alert("show tab account", 1);
	hideAllTabs();
	TabAccount:Show();
	PanelTemplates_SelectTab(ButtonTabAccount);
end

function ButtonTabServer_OnClick()
	alert("show tab server", 1);
	hideAllTabs();
	TabServer:Show();
	PanelTemplates_SelectTab(ButtonTabServer);
end


-- -----------------------------------------------------------------------
--  Account
-- -----------------------------------------------------------------------
function DropDownMenuAccountExtension_OnLoad()
	UIDropDownMenu_SetWidth(DropDownMenuAccountExtension, 150, 0);
	for key, subarray in pairs(AccountExtensionsOrder) do
		info		= {};
		info.text	= AccountExtensions[AccountExtensionsOrder[key]].text;
		info.value	= AccountExtensionsOrder[key];
		info.func	= DropDownMenuAccountExtension_Selected;
		UIDropDownMenu_AddButton(info);
	end
end

function DropDownMenuAccountExtension_Selected(element)
	UIDropDownMenu_SetSelectedValue(DropDownMenuAccountExtension, element.value);
end

function ButtonAccountExtensionSave_OnClick()
	if UIDropDownMenu_GetSelectedValue(DropDownMenuAccountExtension) then
		executeCommand(".account set addon "..AccountExtensions[UIDropDownMenu_GetSelectedValue(DropDownMenuAccountExtension)].command);
	else
		alert("no extension selected", 1);
	end
end


--function DropDownMenuAccountGmLevel_OnLoad()
--	UIDropDownMenu_SetWidth(DropDownMenuAccountGmLevel, 50, 0);
--	for key, subarray in pairs(AccountGmLevelOrder) do
--		info		= {};
--		info.text	= AccountGmLevel[AccountGmLevelOrder[key]].text;
--		info.value	= AccountGmLevelOrder[key];
--		info.func	= DropDownMenuAccountGmLevel_Selected;
--		UIDropDownMenu_AddButton(info);
--	end
--end

--function DropDownMenuAccountGmLevel_Selected(element)
--	UIDropDownMenu_SetSelectedValue(DropDownMenuAccountGmLevel, element.value);
--end

--function ButtonAccountGmLevelSave_OnClick()
--	if UIDropDownMenu_GetSelectedValue(DropDownMenuAccountGmLevel) then
--		executeCommand(".account set gmlevel "..AccountGmLevel[UIDropDownMenu_GetSelectedValue(DropDownMenuAccountGmLevel)].command);
--	else
--		alert("no gm level selected", 1);
--	end
--end

function ButtonAccountGmLevelShow_OnClick()
	alert("shows current extension level", 1);
	executeCommand(".account");
end

-- -----------------------------------------------------------------------
--  Server
-- -----------------------------------------------------------------------
function ButtonServermessageSend_OnClick()
	if EditBoxServermessage:GetText() ~= "" then
		alert("send server message", 1);
		command = ".announce "..EditBoxServermessage:GetText();
		executeCommand(command);
		command = ".notify "..EditBoxServermessage:GetText();
		executeCommand(command);
	else
		alert("no message to send", 1);
	end
	
	EditBoxServermessage:SetText("");
	EditBoxServermessage:ClearFocus();
end

function ButtonServerrestart_OnClick()
	if EditBoxServertime:GetText() ~= "" then
		alert("restart server in "..EditBoxServertime:GetText().." seconds", 1);
		command = ".server restart "..EditBoxServertime:GetText();
		executeCommand(command);
	else
		alert("no time set", 1);
	end
	
	EditBoxServertime:SetText("");
	EditBoxServertime:ClearFocus();
end

function ButtonServershutdown_OnClick()
	if EditBoxServertime:GetText() ~= "" then
		alert("shutdown server in "..EditBoxServertime:GetText().." seconds", 1);
		command = ".server shutdown "..EditBoxServertime:GetText();
		executeCommand(command);
	else
		alert("no time set", 1);
	end
	
	EditBoxServertime:SetText("");
	EditBoxServertime:ClearFocus();
end

function ButtonServerexit_OnClick()
	alert("server exit", 1);
	executeCommand(".server exit");
end

function ButtonServerrestartCancel_OnClick()
	alert("cancel server restart", 1);
	executeCommand(".server restart cancel");
end

function ButtonServershutdownCancel_OnClick()
	alert("cancel server shutdown", 1);
	executeCommand(".server shutdown cancel");
end

function ButtonServerMotdSave_OnClick()
	alert("save new message of the day", 1);
	command = ".server set motd "..EditBoxMotd:GetText();
	executeCommand(command);
	
	EditBoxMotd:SetText("");
	EditBoxMotd:ClearFocus();
end

function ButtonServerMotdShow_OnClick()
	alert("show message of the day", 1);
	executeCommand(".server motd");
end

function DropDownMenuTables_OnLoad()
	for key, subarray in pairs(reloadTablesOrder) do
		info		= {};
		info.text	= reloadTables[reloadTablesOrder[key]].text;
		info.value	= reloadTablesOrder[key];
		info.func	= DropDownMenuTables_Selected;
		UIDropDownMenu_AddButton(info);
	end
end

function DropDownMenuTables_Selected(element)
	UIDropDownMenu_SetSelectedValue(DropDownMenuTables, element.value);
end

function ButtonServerReload_OnClick()
	if UIDropDownMenu_GetSelectedValue(DropDownMenuTables) then
		executeCommand(reloadTables[UIDropDownMenu_GetSelectedValue(DropDownMenuTables)].command);
	else
		alert("no table selected", 1);
	end
end

function ButtonServerReloadConfigFile_OnClick()
	executeCommand(".reload config");
end


-- -----------------------------------------------------------------------
--  Global Mouse Funcitons
-- -----------------------------------------------------------------------
function MouseOverShow(self)
	alert("show mouveover", 2);
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(self:GetText(), 1, 1, 1);
	GameTooltip:AddLine(self.tooltipText);
	GameTooltip:Show();
end

function MouseOverHide(self)
	alert("hide mouseover", 2);
	GameTooltip:Hide();
end


-- -----------------------------------------------------------------------
--  Global Command Function
-- -----------------------------------------------------------------------
function executeCommand(command)
	alert("Execute: "..command, 1);
	--SendChatMessage(command, "CHANNEL", nil, 1);
	SendChatMessage(command, "SAY", nil, nil);
	alert("Execution successfull", 1);
end


-- -----------------------------------------------------------------------
--  Global Debug Function
-- -----------------------------------------------------------------------
function alert(msg, level)
	if level <= debugFlag then
		print(msg);
	end
end