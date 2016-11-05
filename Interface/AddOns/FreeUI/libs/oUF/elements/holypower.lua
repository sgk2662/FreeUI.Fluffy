local F, C = unpack(select(2, ...))

if not C.unitframes.enable then return end

if(select(2, UnitClass('player')) ~= 'PALADIN') then return end

local parent, ns = ...
local oUF = ns.oUF

local Colors = { 231/255, 211/255, 117/255}

local Update = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= "HOLY_POWER")) then return end

	local hpb = self.HolyPowerBars
	if(hpb.PreUpdate) then hpb:PreUpdate(unit) end

	local numShards = UnitPower("player", SPELL_POWER_HOLY_POWER)
	local maxShards = UnitPowerMax("player", SPELL_POWER_HOLY_POWER)

	for i = 1, maxShards do
		if i <= numShards then
			hpb[i]:GetStatusBarTexture():SetAlpha(1)
		else
			hpb[i]:GetStatusBarTexture():SetAlpha(.2)
		end
	end

	if(hpb.PostUpdate) then
		return hpb:PostUpdate(spec)
	end
end

local init = true

local function Visibility(self, event, unit)
	local hpb = self.HolyPowerBars
	local spacing = select(4, hpb[4]:GetPoint())
	local w = hpb:GetWidth()
	local s = 0

	if not hpb:IsShown() then
		hpb:Show()
	end

	if init then
		for i = 1, UnitPowerMax("player", SPELL_POWER_HOLY_POWER) do
			local max = select(2, hpb[i]:GetMinMaxValues())
			hpb[i]:SetValue(max)
			hpb[i]:GetStatusBarTexture():SetAlpha(1)
			hpb[i]:Show()
		end
		init = false
	end

	local maxShards = UnitPowerMax("player", SPELL_POWER_HOLY_POWER)

	for i = 1, maxShards do
		if i ~= maxShards then
			hpb[i]:SetWidth(w / maxShards - spacing)
			s = s + (w / maxShards)
		else
			hpb[i]:SetWidth(w - s)
		end
		hpb[i]:SetStatusBarColor(unpack(Colors))
	end

	-- force an update each time we respec
	Update(self, nil, "player")
end

local Path = function(self, ...)
	return (self.HolyPowerBars.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, 'HOLY_POWER')
end

local function Enable(self)
	local hpb = self.HolyPowerBars
	if(hpb) then
		hpb.__owner = self
		hpb.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER", Path)
		self:RegisterEvent("UNIT_DISPLAYPOWER", Path)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Visibility)
		self:RegisterEvent("PLAYER_TALENT_UPDATE", Visibility)

		for i = 1, 4 do
			local Point = hpb[i]
			if not Point:GetStatusBarTexture() then
				Point:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end

			Point:SetFrameLevel(hpb:GetFrameLevel() + 1)
			Point:GetStatusBarTexture():SetHorizTile(false)
		end

		hpb:Hide()

		return true
	end
end

local function Disable(self)
	local hpb = self.HolyPowerBars
	if(hpb) then
		self:UnregisterEvent("UNIT_POWER", Path)
		self:UnregisterEvent("UNIT_DISPLAYPOWER", Path)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Visibility)
		self:UnregisterEvent("PLAYER_TALENT_UPDATE", Visibility)
	end
end

oUF:AddElement('HolyPowerBars', Path, Enable, Disable)