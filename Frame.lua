SLASH_MANGADMIN1 = "/maddinsmangadmin";
-- use "/mangadmin debug" for debug-informations

version = "2010.02.28";
debugFlag = false;

SlashCmdList["MANGADMIN"] = function(msg)
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
	ButtonServerrestartCancel.tooltipText = "Bricht den Neustart des Servers ab";
	ButtonServershutdownCancel.tooltipText = "Bricht das Herunterfahren des Servers ab";
	
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
	ButtonTabGeneral:Enable();
	ButtonTabServer:Enable();
	alert("all tabs are now hidden");
end

function ButtonTabGeneral_OnClick()
	hideAllTabs();
	TabGeneral:Show();
	ButtonTabGeneral:Disable();
	alert("show tab general ready");
end

function ButtonTabServer_OnClick()
	hideAllTabs();
	TabServer:Show();
	ButtonTabServer:Disable();
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