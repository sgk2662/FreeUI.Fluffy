local F, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local r, g, b = C.classcolours[class].r, C.classcolours[class].g, C.classcolours[class].b

if not C.general.objectivetracker then return end

local ot = ObjectiveTrackerFrame
local BlocksFrame = ot.BlocksFrame

-- [[ Positioning ]]
local frame = CreateFrame("Frame", "ObjectiveTrackerAnchor", UIParent)
frame:SetPoint(unpack(C.quests.position))
frame:SetHeight(150)
frame:SetWidth(260)

ObjectiveTrackerFrame:ClearAllPoints()
ObjectiveTrackerFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
ObjectiveTrackerFrame:SetHeight(GetScreenHeight() - 300)

hooksecurefunc(ObjectiveTrackerFrame, "SetPoint", function(_, _, parent)
	if parent ~= frame then
		ObjectiveTrackerFrame:ClearAllPoints()
		ObjectiveTrackerFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, 0)
	end
end)

for _, headerName in pairs({"QuestHeader", "AchievementHeader", "ScenarioHeader"}) do
	ObjectiveTrackerFrame.BlocksFrame[headerName].Background:Hide()
end
BONUS_OBJECTIVE_TRACKER_MODULE.Header.Background:Hide()

ObjectiveTrackerFrame.HeaderMenu.Title:SetAlpha(0)
OBJECTIVE_TRACKER_DOUBLE_LINE_HEIGHT = 30

----------------------------------------------------------------------------------------
--	Difficulty color for ObjectiveTrackerFrame lines
----------------------------------------------------------------------------------------
hooksecurefunc(QUEST_TRACKER_MODULE, "Update", function()
	for i = 1, GetNumQuestWatches() do
		local questID, _, questIndex = GetQuestWatchInfo(i)
		if not questID then
			break
		end
		local _, level = GetQuestLogTitle(questIndex)
		local col = GetQuestDifficultyColor(level)
		local block = QUEST_TRACKER_MODULE:GetExistingBlock(questID)
		if block then
			block.HeaderText:SetTextColor(col.r, col.g, col.b)
			block.HeaderText.col = col
		end
	end
end)

hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(self, block)
	if block.module == ACHIEVEMENT_TRACKER_MODULE then
		block.HeaderText:SetTextColor(0.75, 0.61, 0)
		block.HeaderText.col = nil
	end
end)

hooksecurefunc("ObjectiveTrackerBlockHeader_OnLeave", function(self)
	local block = self:GetParent()
	if block.HeaderText.col then
		block.HeaderText:SetTextColor(block.HeaderText.col.r, block.HeaderText.col.g, block.HeaderText.col.b)
	end
end)


-- [[ Header ]]

-- Header

--F.SetFS(ot.HeaderMenu.Title)
ot.HeaderMenu.Title:SetFont(C.media.font.normal, 14, "OUTLINE")

-- Minimize button

local minimizeButton = ot.HeaderMenu.MinimizeButton

F.ReskinExpandOrCollapse(minimizeButton)
minimizeButton:SetSize(15, 15)
minimizeButton.plus:Hide()

hooksecurefunc("ObjectiveTracker_Collapse", function()
	minimizeButton.plus:Show()
	FreeUIConfig.objectiveTracker.collapsed = true
end)

hooksecurefunc("ObjectiveTracker_Expand", function()
	minimizeButton.plus:Hide()
	FreeUIConfig.objectiveTracker.collapsed = false
end)

-- [[ Blocks and lines ]]

for _, headerName in pairs({"QuestHeader", "AchievementHeader", "ScenarioHeader"}) do
	local header = BlocksFrame[headerName]

	header.Background:Hide()
	
	if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
		header.Text:SetFont(C.media.font.normal, 14, "OUTLINE")
	else
		F.SetFS(header.Text)
	end
end

do
	local header = BONUS_OBJECTIVE_TRACKER_MODULE.Header

	header.Background:Hide()
	
	if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
		header.Text:SetFont(C.media.font.normal, 14, "OUTLINE")
	else
		F.SetFS(header.Text)
	end
end

hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "SetBlockHeader", function(_, block)
	if not block.headerStyled then
		if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
			block.HeaderText:SetFont(C.media.font.normal, 13, "OUTLINE")
		else
			F.SetFS(block.HeaderText)
		end
		block.headerStyled = true
	end
end)

hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", function(_, block)
	if not block.headerStyled then
		if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
			block.HeaderText:SetFont(C.media.font.normal, 13, "OUTLINE")
		else
			F.SetFS(block.HeaderText)
		end
		block.headerStyled = true
	end

	local itemButton = block.itemButton

	if itemButton and not itemButton.styled then
		itemButton:SetNormalTexture("")
		itemButton:SetPushedTexture("")

		itemButton.HotKey:ClearAllPoints()
		itemButton.HotKey:SetPoint("CENTER", itemButton, 1, 0)
		itemButton.HotKey:SetJustifyH("CENTER")
		F.SetFS(itemButton.HotKey)

		itemButton.Count:ClearAllPoints()
		itemButton.Count:SetPoint("TOP", itemButton, 2, -1)
		itemButton.Count:SetJustifyH("CENTER")
		F.SetFS(itemButton.Count)

		itemButton.icon:SetTexCoord(.08, .92, .08, .92)
		F.CreateBG(itemButton)

		itemButton.styled = true
	end
end)

hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(self, block)
	if block.module == QUEST_TRACKER_MODULE or block.module == ACHIEVEMENT_TRACKER_MODULE then
		local line = block.currentLine

		local p1, a, p2, x, y = line:GetPoint()
		line:SetPoint(p1, a, p2, x, y - 4)
	end
end)

local function fixBlockHeight(block)
	if block.shouldFix then
		local height = block:GetHeight()

		if block.lines then
			for _, line in pairs(block.lines) do
				if line:IsShown() then
					height = height + 4
				end
			end
		end

		block.shouldFix = false
		block:SetHeight(height + 5)
		block.shouldFix = true
	end
end

hooksecurefunc("ObjectiveTracker_AddBlock", function(block)
	if block.lines then
		for _, line in pairs(block.lines) do
			if not line.styled then
				if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
					line.Text:SetFont(C.media.font.normal, 12, "OUTLINE")
				else
					F.SetFS(line.Text)
				end
				line.Text:SetSpacing(2)

				if line.Dash then
					F.SetFS(line.Dash)
				end

				line:SetHeight(line.Text:GetHeight())

				line.styled = true
			end
		end
	end

	if not block.styled then
		block.shouldFix = true
		hooksecurefunc(block, "SetHeight", fixBlockHeight)
		block.styled = true
	end
end)

-- [[ Bonus objective progress bar ]]

-- hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", function(self, block, line)
-- 	local progressBar = line.ProgressBar
-- 	local bar = progressBar.Bar
-- 	local icon = bar.Icon

-- 	if not progressBar.styled then
-- 		local label = bar.Label

-- 		bar.BarBG:Hide()

-- 		icon:SetMask(nil)
-- 		icon:SetDrawLayer("BACKGROUND", 1)
-- 		icon:ClearAllPoints()
-- 		icon:SetPoint("RIGHT", 26, 2)
-- 		icon:SetSize(24, 24)
-- 		bar.newIconBg = F.ReskinIcon(icon)

-- 		bar.BarFrame:Hide()

-- 		bar:SetStatusBarTexture(C.media.backdrop)
-- 		bar:SetStatusBarColor(255/255, 108/255, 0/255)

-- 		label:ClearAllPoints()
-- 		label:SetPoint("CENTER")
-- --		F.SetFS(label)
-- 		label:SetFont(C.media.font2, 12, "OUTLINE")

-- 		local bg = F.CreateBDFrame(bar)
-- 		bg:SetPoint("TOPLEFT", -1, 1)
-- 		bg:SetPoint("BOTTOMRIGHT", 0, -2)

-- 		progressBar.styled = true
-- 	end

-- 	bar.IconBG:Hide()
-- 	bar.newIconBg:SetShown(icon:IsShown())
-- end)



-- Objective Tracker
F.ReskinExpandOrCollapse(_G.ObjectiveTrackerFrame.HeaderMenu.MinimizeButton)
for _, headerName in next, {"QuestHeader", "AchievementHeader", "ScenarioHeader"} do
	local header = _G.ObjectiveTrackerFrame.BlocksFrame[headerName]
	header.Background:Hide()

	local bg = header:CreateTexture(nil, "ARTWORK")
	bg:SetTexture([[Interface\LFGFrame\UI-LFG-SEPARATOR]])
	bg:SetTexCoord(0, 0.6640625, 0, 0.3125)
	bg:SetVertexColor(r * 0.7, g * 0.7, b * 0.7)
	bg:SetPoint("BOTTOMLEFT", -30, -4)
	bg:SetSize(210, 30)
end

--
ScenarioStageBlock:HookScript("OnShow", function()
	if not ScenarioStageBlock.skinned then
		ScenarioStageBlock.NormalBG:SetAlpha(.6)
	--	ScenarioStageBlock.NormalBG:SetTexture([[Interface\Tooltips\UI-Tooltip-Background]])
	--	ScenarioStageBlock.NormalBG:SetVertexColor(0, 0, 0, 1)
		ScenarioStageBlock.FinalBG:SetAlpha(.6)
		ScenarioStageBlock.GlowTexture:SetTexture(nil)
		ScenarioStageBlock.Stage:SetFont(C.media.font.normal, 15, "OUTLINE")
		ScenarioStageBlock.Stage:SetTextColor(1, 1, 1)
		ScenarioStageBlock.Name:SetFont(C.media.font.normal, 12, "OUTLINE")
		ScenarioStageBlock.CompleteLabel:SetFont(C.media.font.normal, 15, "OUTLINE")
		ScenarioStageBlock.CompleteLabel:SetTextColor(1, 1, 1)
		ScenarioStageBlock.skinned = true
	end
end)



--ScenarioChallengeModeBlock
--ScenarioProvingGroundsBlock


-- [[ Init ]]

F.RegisterEvent("VARIABLES_LOADED", function()
	if not FreeUIConfig.objectiveTracker then FreeUIConfig.objectiveTracker = {} end

	if C.quests.rememberObjectiveTrackerState and (FreeUIConfig.objectiveTracker.collapsed or C.quests.alwaysCollapseObjectiveTracker) then
		ObjectiveTracker_Collapse()
	end
end)