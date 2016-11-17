

C_Timer.After(.1, function() -- need to wait a bit
	if not InCombatLockdown() then
		-- 血条最远显示距离，7.0默认是60，7.0以前是40
		SetCVar("nameplateMaxDistance", 40)
		-- 禁止显示不在屏幕内单位的血条(血条贴在屏幕边缘)
		-- SetCVar("nameplateOtherTopInset", -1)
		-- SetCVar("nameplateOtherBottomInset", -1)
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


-- disable new talent alert
local f = CreateFrame("Frame")
function f:OnEvent(event)
	hooksecurefunc("MainMenuMicroButton_ShowAlert", function(alert)
		alert:Hide()
	end)
end

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LEVEL_UP")
f:SetScript("OnEvent", f.OnEvent)
