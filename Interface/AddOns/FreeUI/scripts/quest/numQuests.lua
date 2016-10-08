-- numQuests by Kanegasi

local QuestsHeader = true
local ObjectivesHeader = true
local WorldMapTitle = true

local a=...
local nQ=CreateFrame('frame',a)
local InCombat=false
local MAX_QUESTS=MAX_QUESTS
local TRACKER_HEADER_QUESTS=TRACKER_HEADER_QUESTS
local OBJECTIVES_TRACKER_LABEL=OBJECTIVES_TRACKER_LABEL
local MAP_AND_QUEST_LOG=MAP_AND_QUEST_LOG

local function PRINT_QUEST_LIST()
	local n,q=1
	for i=1,MAX_QUESTS do
		q=GetQuestLink(i)
		if q then print(" "..n..". "..q) n=n+1 end
	end
end

function nQ:LOADING_SCREEN_DISABLED()
	nQ:UnregisterEvent('LOADING_SCREEN_DISABLED')
	if not InCombat and not InCombatLockdown() then
		local WMTBPC=WorldMapTitleButton:GetScript('PostClick')
		WorldMapTitleButton:SetScript('PostClick',function(s,b,d)
			if WMTBPC then WMTBPC(s,b,d) end
			if b=='LeftButton' and not d then PRINT_QUEST_LIST() end
		end)
	end
end

function nQ:PLAYER_REGEN_DISABLED() InCombat=true end

function nQ:PLAYER_REGEN_ENABLED() InCombat=false end

function nQ:QUEST_LOG_UPDATE()
	if not InCombat and not InCombatLockdown() then
		local n=tostring(select(2,GetNumQuestLogEntries()))
		local q=n.."/"..MAX_QUESTS.." "..TRACKER_HEADER_QUESTS
		local o=n.."/"..MAX_QUESTS.." "..OBJECTIVES_TRACKER_LABEL
		local w=MAP_AND_QUEST_LOG.." ("..n.."/"..MAX_QUESTS..")"
		if QuestsHeader then ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(q) end
		if ObjectivesHeader then ObjectiveTrackerFrame.HeaderMenu.Title:SetText(o) end
		if WorldMapTitle then WorldMapFrame.BorderFrame.TitleText:SetText(w) end
	end
end

nQ:RegisterEvent('LOADING_SCREEN_DISABLED')
nQ:RegisterEvent('PLAYER_REGEN_DISABLED')
nQ:RegisterEvent('PLAYER_REGEN_ENABLED')
nQ:RegisterEvent('QUEST_LOG_UPDATE')
nQ:SetScript('OnEvent',function(self,event,...)self[event](self,...)end)