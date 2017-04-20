local _, private = ...

-- [[ Lua Globals ]]
local select, pairs = _G.select, _G.pairs

-- [[ WoW API ]]
local hooksecurefunc, CreateFrame = _G.hooksecurefunc, _G.CreateFrame

-- [[ Core ]]
local F, C = _G.unpack(private.Aurora)

C.themes["Blizzard_Contribution"] = function()
	local r, g, b = C.r, C.g, C.b

	local frame = ContributionCollectionFrame
	F.SetBD(frame)
	F.ReskinClose(frame.CloseButton)
	frame.CloseButton.CloseButtonBackground:Hide()
	frame.Background:Hide()

	hooksecurefunc(ContributionMixin, "Update", function(self)
		if not self.styled then
			self.Header.Text:SetTextColor(1, .8, 0)
			F.Reskin(self.ContributeButton)

			self.styled = true
		end
	end)

	hooksecurefunc(ContributionRewardMixin, "Setup", function(self)
		if not self.styled then
			self.RewardName:SetTextColor(1, 1, 1)
			self.Icon:SetTexCoord(.08, .92, .08, .92)
			self.Icon.SetTexCoord = F.dummy
			self.Border:Hide()
			F.CreateBDFrame(self.Icon)

			self.styled = true
		end
	end)

	-- Tooltips
	if AuroraConfig.tooltips then
		ContributionTooltip:SetBackdrop(nil)
		ContributionBuffTooltip:DisableDrawLayer("BACKGROUND")
		F.CreateBDFrame(ContributionTooltip)
		F.CreateBDFrame(ContributionBuffTooltip)
		ContributionBuffTooltip.Icon:SetTexCoord(.08, .92, .08, .92)
		ContributionBuffTooltip.Border:SetAlpha(0)
	end
end
