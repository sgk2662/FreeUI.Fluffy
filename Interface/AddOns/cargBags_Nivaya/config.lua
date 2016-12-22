local addon, ns = ...
ns.options = {

itemSlotSize = 36,	-- Size of item slots
itemTextColor = 0,	-- item levle text colored by quality

sizes = {
	bags = {
		columnsSmall = 10,
		columnsLarge = 10,
		largeItemCount = 64,	-- Switch to columnsLarge when >= this number of items in your bags
	},
	bank = {
		columnsSmall = 14,
		columnsLarge = 14,
		largeItemCount = 96,	-- Switch to columnsLarge when >= this number of items in the bank
	},	
},

fonts = {
		-- Font to use for bag captions and other strings
		standard = {
			[[Interface\AddOns\cargBags_Nivaya\media\pixel.ttf]], 	-- Font path
			8, 						-- Font Size
			"OUTLINEMONOCHROME",	-- Flags
		},
		
		--Font to use for the dropdown menu
		dropdown = {
			[[Interface\AddOns\cargBags_Nivaya\media\pixel.ttf]], 	-- Font path
			8, 						-- Font Size
			"OUTLINEMONOCHROME",	-- Flags
		},

		-- Font to use for durability and item level
		itemInfo = {
			[[Interface\AddOns\cargBags_Nivaya\media\pixel.ttf]], 	-- Font path
			8, 						-- Font Size
			"OUTLINEMONOCHROME",	-- Flags
		},

		-- Font to use for number of items in a stack
		itemCount = {
			[[Interface\AddOns\cargBags_Nivaya\media\pixel.ttf]], 	-- Font path
			8, 						-- Font Size
			"OUTLINEMONOCHROME",	-- Flags
		},

	},

colors = {
	background = {.05, .05, .05, .8},	-- r, g, b, opacity
},


}