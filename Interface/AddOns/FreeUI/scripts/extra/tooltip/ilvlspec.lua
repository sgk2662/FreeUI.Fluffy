local F, C = unpack(select(2, ...))
if C.tooltip.enable ~= true or C.tooltip.ilvlspec ~= true then return end


--- Variables ---
local currentUNIT, currentGUID, scanTip
local GearDB, SpecDB, ItemDB = {}, {}, {}

local nextInspectRequest = 0
lastInspectRequest = 0

local prefixColor = '|cffffeeaa'
local detailColor = '|cffffffff'

local gearPrefix = STAT_AVERAGE_ITEM_LEVEL .. ': '
local specPrefix = SPECIALIZATION .. ': '
local lvlPattern = gsub(ITEM_LEVEL, '%%d', '(%%d+)')


--- Create Frame ---
local f = CreateFrame('Frame', 'CloudyUnitInfo')
f:RegisterEvent('UNIT_INVENTORY_CHANGED')
f:RegisterEvent('INSPECT_READY')


--- Set Unit Info ---
local function SetUnitInfo(gear, spec)
	if (not gear) and (not spec) then return end

	local _, unit = GameTooltip:GetUnit()
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local gearLine, specLine
	for i = 2, GameTooltip:NumLines() do
		local line = _G['GameTooltipTextLeft' .. i]
		local text = line:GetText()

		if text and strfind(text, gearPrefix) then
			gearLine = line
		elseif text and strfind(text, specPrefix) then
			specLine = line
		end
	end

	if gear then
		gear = prefixColor .. gearPrefix .. detailColor .. gear
		if gearLine then
			gearLine:SetText(gear)
		else
			GameTooltip:AddLine(gear)
		end
	end

	if spec and UnitLevel(unit) > 10 then
		spec = prefixColor .. specPrefix .. detailColor .. spec
		if specLine then
			specLine:SetText(spec)
		else
			GameTooltip:AddLine(spec)
		end
	end

	GameTooltip:Show()
end


--- BOA Items ---
local BOAItems = {
	['133585'] = 1, ['133595'] = 1, ['133596'] = 1,
	['133597'] = 1, ['133598'] = 1,
}


--- BOA Item Level ---
local function BOALevel(level, id)
	if (level > 100) then level = 100 end
	if (level > 97) then
		if BOAItems[id] then
			level = 715
		else
			level = 605 - (100 - level) * 5
		end
	elseif (level > 90) then
		level = 590 - (97 - level) * 10
	elseif (level > 85) then
		level = 463 - (90 - level) * 19.5
	elseif (level > 80) then
		level = 333 - (85 - level) * 13.5
	elseif (level > 67) then
		level = 187 - (80 - level) * 4
	elseif (level > 57) then
		level = 105 - (67 - level) * 2.8
	elseif (level > 10) then
		level = level + 5
	else
		level = 10
	end

	return floor(level + 0.5)
end


--- PVP Item Detect ---
local function IsPVPItem(link)
	local itemStats = GetItemStats(link)

	for stat in pairs(itemStats) do
		if (stat == 'ITEM_MOD_RESILIENCE_RATING_SHORT') or (stat == 'ITEM_MOD_PVP_POWER_SHORT') then
			return true
		end
	end

	return false
end


--- Scan Item Level ---
local function scanItemLevel(link)
	if ItemDB[link] then return ItemDB[link] end

	if not scanTip then
		scanTip = CreateFrame('GameTooltip', 'CUnitScan', nil, 'GameTooltipTemplate')
 		scanTip:SetOwner(UIParent, 'ANCHOR_NONE')
	end
	scanTip:ClearLines()
 	scanTip:SetHyperlink(link)

	for i = 2, scanTip:NumLines() do
		local textLine = _G['CUnitScanTextLeft' .. i]
		if textLine and textLine:GetText() then
			local level = strmatch(textLine:GetText(), lvlPattern)
			if level then
				ItemDB[link] = tonumber(level)
				return ItemDB[link]
			end
		end
	end
end


--- Unit Gear Info ---
local function UnitGear(unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local ulvl = UnitLevel(unit)
	local class = select(2, UnitClass(unit))

	local boa, pvp, twohand = 0, 0, 1
	local ilvl, total, delay = 0, 0, nil

	for i = 1, 17 do
		if (i ~= 4) then
			local itemTexture = GetInventoryItemTexture(unit, i)

			if itemTexture then
				local itemLink = GetInventoryItemLink(unit, i)

				if (not itemLink) then
					delay = true
				else
					local _, _, quality, level, _, _, _, _, slot = GetItemInfo(itemLink)

					if (not quality) or (not level) then
						delay = true
					else
						if (quality == 7) then
							boa = boa + 1
							local id = strmatch(itemLink, 'item:(%d+)')
							level = BOALevel(ulvl, id)
						else
							if IsPVPItem(itemLink) then
								pvp = pvp + 1
							end

							level = scanItemLevel(itemLink) or level
						end

						if (i == 16) then
							if (slot == 'INVTYPE_2HWEAPON') or (slot == 'INVTYPE_RANGED') or ((slot == 'INVTYPE_RANGEDRIGHT') and (class == 'HUNTER')) then
								twohand = 2
							end
						end

						total = total + level * twohand
					end
				end
			end
		end
	end

	if (not delay) then
		if (unit == 'player') and (GetAverageItemLevel() > 0) then
			ilvl = select(2, GetAverageItemLevel())
		else
			ilvl = total / 16
		end

		if (ilvl > 0) then ilvl = string.format('%.1f', ilvl) end
		if (boa > 0) then ilvl = ilvl .. '  |cffe6cc80' .. boa .. ' BOA' end
		if (pvp > 0) then ilvl = ilvl .. '  |cffa335ee' .. pvp .. ' PVP' end
	else
		ilvl = nil
	end

	return ilvl
end


--- Unit Specialization ---
local function UnitSpec(unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local specName
	if (unit == 'player') then
		local specIndex = GetSpecialization()

		if specIndex then
			specName = select(2, GetSpecializationInfo(specIndex))
		else
			specName = NONE
		end
	else
		local specID = GetInspectSpecialization(unit)

		if specID and (specID > 0) then
			specName = select(2, GetSpecializationInfoByID(specID))
		elseif (specID == 0) then
			specName = NONE
		end
	end

	return specName
end


--- Scan Current Unit ---
local function ScanUnit(unit, forced)
	local cachedGear, cachedSpec

	if UnitIsUnit(unit, 'player') then
		cachedGear = UnitGear('player')
		cachedSpec = UnitSpec('player')

		SetUnitInfo(cachedGear or CONTINUED, cachedSpec or CONTINUED)
	else
		if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

		cachedGear = GearDB[currentGUID]
		cachedSpec = SpecDB[currentGUID]

		if cachedGear or forced then
			SetUnitInfo(cachedGear or CONTINUED, cachedSpec)
		end

		if not (IsShiftKeyDown() or forced) then
			if cachedGear and cachedSpec then return end
			if UnitAffectingCombat('player') then return end
		end

		if (not UnitIsVisible(unit)) then return end
		if UnitIsDeadOrGhost('player') or UnitOnTaxi('player') then return end
		if InspectFrame and InspectFrame:IsShown() then return end

		SetUnitInfo(CONTINUED, cachedSpec or CONTINUED)

		local timeSinceLastInspect = GetTime() - lastInspectRequest
		if (timeSinceLastInspect >= 1.5) then
			nextInspectRequest = 0
		else
			nextInspectRequest = 1.5 - timeSinceLastInspect
		end
		f:Show()
	end
end


--- Character Info Sheet ---
hooksecurefunc('PaperDollFrame_SetArmor', function(_, unit)
	if (unit ~= 'player') then return end

	local total, equip = GetAverageItemLevel()
	if (total > 0) then total = string.format('%.1f', total) end
	if (equip > 0) then equip = string.format('%.1f', equip) end

	local ilvl = equip
	if (equip ~= total) then
		ilvl = equip .. ' / ' .. total
	end

	PaperDollFrame_SetItemLevel(CharacterStatsPane.ItemLevelFrame, unit)
	CharacterStatsPane.ItemLevelCategory:Show()
	CharacterStatsPane.ItemLevelFrame:Show()
	CharacterStatsPane.ItemLevelFrame.Value:SetText(ilvl)
	CharacterStatsPane.AttributesCategory:SetPoint('TOP', CharacterStatsPane.ItemLevelFrame, 'BOTTOM', 0, -10)
end)


--- Handle Events ---
f:SetScript('OnEvent', function(self, event, ...)
	if (event == 'UNIT_INVENTORY_CHANGED') then
		local unit = ...
		if (UnitGUID(unit) == currentGUID) then
			ScanUnit(unit, true)
		end
	elseif (event == 'INSPECT_READY') then
		local guid = ...
		if (guid ~= currentGUID) then return end

		local gear = UnitGear(currentUNIT)
		GearDB[currentGUID] = gear

		local spec = UnitSpec(currentUNIT)
		SpecDB[currentGUID] = spec

		if (not gear) or (not spec) then
			ScanUnit(currentUNIT, true)
		else
			SetUnitInfo(gear, spec)
		end
	end
end)

f:SetScript('OnUpdate', function(self, elapsed)
	nextInspectRequest = nextInspectRequest - elapsed
	if (nextInspectRequest > 0) then return end

	self:Hide()

	if currentUNIT and (UnitGUID(currentUNIT) == currentGUID) then
		lastInspectRequest = GetTime()
		NotifyInspect(currentUNIT)
	end
end)

GameTooltip:HookScript('OnTooltipSetUnit', function(self)
	local _, unit = self:GetUnit()
	if (not unit) or (not CanInspect(unit)) then return end

	currentUNIT, currentGUID = unit, UnitGUID(unit)
	ScanUnit(unit)
end)