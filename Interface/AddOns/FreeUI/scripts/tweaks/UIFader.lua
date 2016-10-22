-- daftUIFade by tonyis3l33t

local F, C, L = unpack(select(2, ...))

if not C.appearance.uiFader then return end

local addonName, addonTable = ... ;

addonTable.TIMETOFADEIN = 1.0;
addonTable.FADEIN = 0.99;

addonTable.TIMETOFADEOUT = 3.0;
addonTable.FADEOUT = 0.05;
 
local addon = CreateFrame("Frame");
 
 
function addon:FadeIn()
	UIFrameFadeIn(UIParent, addonTable.TIMETOFADEIN, UIParent:GetAlpha(), addonTable.FADEIN);
end;

function addon:FadeOut()
	UIFrameFadeOut(UIParent, addonTable.TIMETOFADEOUT, UIParent:GetAlpha(), addonTable.FADEOUT);
end;


addon:SetScript("OnUpdate", function()
	
	if UnitAffectingCombat("Player")
	or InCombatLockdown() then
		return;
	end;
	
	
	if ChatFrame1EditBox:IsShown()
	or WorldMapFrame:IsShown()
	or MailFrame:IsShown()
	or GossipFrame:IsShown()
	or GameTooltipTextLeft1:GetText()
	or UnitCastingInfo("Player")
	or UnitChannelInfo("Player")
	or UnitExists("Target") then
		addon:FadeIn();
		return;
	end;
 
 
	if GetMouseFocus() then
		if GetMouseFocus():GetName() ~= "WorldFrame" then
			addon:FadeIn();
		else
			addon:FadeOut();
		end;
	end;
end);

