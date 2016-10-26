

C_Timer.After(.1, function() -- need to wait a bit
	if not InCombatLockdown() then
		-- 血条最远显示距离，7.0默认是60，7.0以前是40
		SetCVar("nameplateMaxDistance", 60)
		-- 禁止显示不在屏幕内单位的血条(血条贴在屏幕边缘)
		SetCVar("nameplateOtherTopInset", -1)
		SetCVar("nameplateOtherBottomInset", -1)
		-- tab的行为改回7.0以前，优先tab最近的单位
		--SetCVar("TargetPriorityAllowAnyOnScreen", 0)
		SetCVar("Targetnearestuseold", 1)
		-- 7.0新的伤害字体显示方式
		SetCVar("floatingCombatTextCombatDamageDirectionalScale", 1)
		-- 最远视野距离
		SetCVar("cameraDistanceMaxZoomFactor", 2.6)

		SetCVar("screenshotQuality", 10)
		SetCVar("nameplateShowFriends", 0)
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("ShowClassColorInNameplate", 1)

		--SetCVar("TargetPriorityAllowAnyOnScreen", 0)
		SetCVar("Targetnearestuseold", 1)

		SetCVar("overrideArchive", 0)
	end
end)


local function SetupChat()

	local channels = {
		"SAY",
		"EMOTE",
		"YELL",
		"GUILD",
		"OFFICER",
		"GUILD_ACHIEVEMENT",
		"ACHIEVEMENT",
		"WHISPER",
		"PARTY",
		"PARTY_LEADER",
		"INSTANCE_CHAT",
		"INSTANCE_CHAT_LEADER",
		"RAID",
		"RAID_LEADER",
		"RAID_WARNING",
		"BATTLEGROUND",
		"BATTLEGROUND_LEADER",
		"CHANNEL1",
		"CHANNEL2",
		"CHANNEL3",
		"CHANNEL4",
		"CHANNEL5",
		"CHANNEL6",
		"CHANNEL7",
		"CHANNEL8",
		"CHANNEL9",
		"CHANNEL10",
	}

	for _, channel in next, channels do
		ToggleChatColorNamesByClassGroup(true, channel)
	end
end


local f = CreateFrame("Frame")
function f:OnEvent(event)
	hooksecurefunc("MainMenuMicroButton_ShowAlert", function(alert)
		alert:Hide()
	end)
end

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LEVEL_UP")
f:SetScript("OnEvent", f.OnEvent)