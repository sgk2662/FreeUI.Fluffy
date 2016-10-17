local _, private = ...

-- [[ Lua Globals ]]
local _G = _G

-- [[ Core ]]
local F, C = _G.unpack(private.Aurora)

C.themes["Blizzard_ChallengesUI"] = function()
	_G.ChallengesFrameInset:DisableDrawLayer("BORDER")
	_G.ChallengesFrameInsetBg:Hide()

--	_G.ChallengesModeWeeklyBest.Child.Star:Hide()
--	_G.ChallengesModeWeeklyBest.Child.Glow:Hide()
	_G.ChallengesModeWeeklyBest.Child.Level:SetPoint("CENTER", ChallengesModeWeeklyBest.Child.Star, "CENTER", 0, 3)

	F.CreateBD(ChallengesFrame.GuildBest, .3)

	select(1, _G.ChallengesFrame.GuildBest:GetRegions()):Hide()
	select(3, _G.ChallengesFrame.GuildBest:GetRegions()):Hide()
	
	for i = 1, 2 do
		select(i, _G.ChallengesFrame:GetRegions()):Hide()
	end
	
	hooksecurefunc("ChallengesFrame_Update", function()
		for i = 1, 9 do
			local bu = _G.ChallengesFrame.DungeonIcons[i]
			if bu then
				select(1, bu:GetRegions()):Hide()
				bu.Icon:SetTexCoord(.08, .92, .08, .92)
			end
		end
	end)
end
