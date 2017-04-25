local F, C, L = unpack(select(2, ...))

local function InitStyleLT()

	local T = unpack(ls_Toasts)

	function T:SkinToast(toast, toastType)
		toast.Border:SetAlpha(0)
		toast.TextBG:SetAlpha(0.5)
		toast.BG:SetAlpha(0.35)

		if not toast.skinned then
			local bg = toast:CreateTexture(nil, 'BACKGROUND', nil, -1)
			bg:SetPoint('TOPLEFT', toast, 4, -4)
			bg:SetPoint('BOTTOMRIGHT', toast, -4, 4)
			bg:SetColorTexture(0, 0, 0, 1)

			local tr = toast:CreateTexture(nil, 'BACKGROUND', nil, -2)
			tr:SetPoint('TOPLEFT', toast, 1, -1)
			tr:SetPoint('BOTTOMRIGHT', toast, -1, 1)
			tr:SetColorTexture(0, 0, 0, 0.3)

			toast.skinned = true
		end

		toast.Icon:SetTexCoord(.08, .92, .08, .92)

		-- toast.Title:SetFont([[]], 11)

		if toast.IconBorder then
			local r, g, b = toast.IconBorder:GetVertexColor()
			if r > 0.99 and g > 0.99 and b > 0.99 then
				toast.IconBorder:SetVertexColor(0.1, 0.1, 0.1, 1)
			end
			toast.IconBorder:SetTexture([[Interface\AddOns\FreeUI\media\border.tga]])
			toast.IconBorder:SetTexCoord(0, 1, 0, 1)
		end
	end
end

if IsAddOnLoaded("ls_Toasts") then
	InitStyleLT()
else
	local load = CreateFrame("Frame")
	load:RegisterEvent("ADDON_LOADED")
	load:SetScript("OnEvent", function(self, _, addon)
		if addon ~= "ls_Toasts" then return end
		self:UnregisterEvent("ADDON_LOADED")

		InitStyleLT()

		load = nil
	end)
end
