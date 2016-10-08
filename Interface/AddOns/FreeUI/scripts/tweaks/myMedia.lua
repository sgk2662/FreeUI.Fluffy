local LSM = _G.LibStub("LibSharedMedia-3.0")
local koKR, ruRU, zhCN, zhTW, western = LSM.LOCALE_BIT_koKR, LSM.LOCALE_BIT_ruRU, LSM.LOCALE_BIT_zhCN, LSM.LOCALE_BIT_zhTW, LSM.LOCALE_BIT_western
-- -----
-- BACKGROUND
-- -----
LSM:Register("background", "myMedia_BG_B", 				[[Interface\Addons\FreeUI\media\HalBackgroundB.tga]])
LSM:Register("background", "myMedia_BG_A", 				[[Interface\Addons\FreeUI\media\HalBackgroundA.tga]])
-- -----
--  BORDER
-- ----
LSM:Register("border", "myMedia_border_roth", 			[[Interface\Addons\FreeUI\media\border_roth.tga]])
-- -----
--   FONT
-- -----
LSM:Register("font", "ExocetBlizzardLight", 			[[Interface\Addons\FreeUI\media\ExocetBlizzardLight.ttf]], zhCN + zhTW + western)
LSM:Register("font", "ExocetBlizzardMedium", 			[[Interface\Addons\FreeUI\media\ExocetBlizzardMedium.ttf]], zhCN + zhTW + western)
LSM:Register("font", "FruityMicrofont", 				[[Interface\Addons\FreeUI\media\FruityMicrofont.ttf]], zhCN + zhTW + western)
LSM:Register("font", "supereffective", 					[[Interface\Addons\FreeUI\media\supereffective.ttf]], zhCN + zhTW + western)
LSM:Register("font", "pixel", 							[[Interface\Addons\FreeUI\media\pixel.ttf]], zhCN + zhTW + western)
LSM:Register("font", "pixel_bold", 						[[Interface\Addons\FreeUI\media\pixel_bold.ttf]], zhCN + zhTW + western)
LSM:Register("font", "pixel_large", 					[[Interface\Addons\FreeUI\media\pixel_large.ttf]], zhCN + zhTW + western)
LSM:Register("font", "pixel_condensed", 				[[Interface\Addons\FreeUI\media\pixel_condensed.ttf]], zhCN + zhTW + western)
LSM:Register("font", "SempliceRegular", 				[[Interface\Addons\FreeUI\media\SempliceRegular.ttf]], zhCN + zhTW + western)

LSM:Register("font", "pixfontCN", 						[[Fonts\pixfontCN.ttf]], zhCN + zhTW + western)
LSM:Register("font", "Hiragino", 						[[Fonts\Hiragino.ttf]], zhCN + zhTW + western)
LSM:Register("font", "lihei", 							[[Fonts\lihei.ttf]], zhCN + zhTW + western)
LSM:Register("font", "yaheibold", 						[[Fonts\yaheibold.ttf]], zhCN + zhTW + western)

LSM:Register("font", "张海山草泥马体", 					[[Fonts\CN\zhscnmt.ttf]], zhCN + zhTW + western)
LSM:Register("font", "张海山锐谐体", 						[[Fonts\CN\zhsrxt.ttf]], zhCN + zhTW + western)
LSM:Register("font", "颜体楷书", 							[[Fonts\CN\yanti.ttf]], zhCN + zhTW + western)
LSM:Register("font", "Zfull-GB", 						[[Fonts\CN\Zfull-GB.ttf]], zhCN + zhTW + western)
LSM:Register("font", "苹方", 							[[Fonts\CN\PingFangTC-Semibold.otf]], zhCN + zhTW + western)
LSM:Register("font", "方正柳楷", 							[[Fonts\CN\方正柳楷.ttf]], zhCN + zhTW + western)
LSM:Register("font", "方正粗黑宋简", 						[[Fonts\CN\方正粗黑宋简.otf]], zhCN + zhTW + western)
LSM:Register("font", "方正行黑", 							[[Fonts\CN\方正行黑.ttf]], zhCN + zhTW + western)
LSM:Register("font", "方正跃进体", 						[[Fonts\CN\方正跃进体.ttf]], zhCN + zhTW + western)
LSM:Register("font", "方正邱氏粗瘦金书简体", 				[[Fonts\CN\方正邱氏粗瘦金书简体.ttf]], zhCN + zhTW + western)
LSM:Register("font", "方正黑隶简_粗", 					[[Fonts\CN\方正黑隶简_粗.ttf]], zhCN + zhTW + western)
LSM:Register("font", "書體坊顏體", 						[[Fonts\CN\書體坊顏體.ttf]], zhCN + zhTW + western)




-- -----
--   SOUND
-- -----
LSM:Register("sound", "myMedia_bell", 							[[Interface\Addons\FreeUI\media\bell.ogg]]) 
LSM:Register("sound", "myMedia_bird_flap",		 				[[Interface\Addons\FreeUI\media\bird_flap.ogg]]) 
LSM:Register("sound", "myMedia_buzz", 							[[Interface\Addons\FreeUI\media\buzz.ogg]]) 
LSM:Register("sound", "myMedia_cling", 							[[Interface\Addons\FreeUI\media\cling.ogg]]) 
LSM:Register("sound", "myMedia_ding", 							[[Interface\Addons\FreeUI\media\ding.ogg]]) 
LSM:Register("sound", "myMedia_Evangelism_stacks", 				[[Interface\Addons\FreeUI\media\Evangelism stacks.ogg]]) 
LSM:Register("sound", "myMedia_execute", 						[[Interface\Addons\FreeUI\media\execute.ogg]]) 
LSM:Register("sound", "myMedia_Finisher", 						[[Interface\Addons\FreeUI\media\Finisher.ogg]]) 
LSM:Register("sound", "myMedia_Glint", 							[[Interface\Addons\FreeUI\media\Glint.ogg]]) 
LSM:Register("sound", "myMedia_LightsHammer", 					[[Interface\Addons\FreeUI\media\LightsHammer.ogg]]) 
LSM:Register("sound", "myMedia_LowHealth", 						[[Interface\Addons\FreeUI\media\LowHealth.ogg]]) 
LSM:Register("sound", "myMedia_LowMana", 						[[Interface\Addons\FreeUI\media\LowMana.ogg]]) 
LSM:Register("sound", "myMedia_Mint", 							[[Interface\Addons\FreeUI\media\Mint.ogg]]) 
LSM:Register("sound", "myMedia_miss", 							[[Interface\Addons\FreeUI\media\miss.mp3]]) 
LSM:Register("sound", "myMedia_Proc", 							[[Interface\Addons\FreeUI\media\Proc.ogg]]) 
LSM:Register("sound", "myMedia_ShadowOrbs", 					[[Interface\Addons\FreeUI\media\ShadowOrbs.ogg]]) 
LSM:Register("sound", "myMedia_ShortCircuit", 					[[Interface\Addons\FreeUI\media\ShortCircuit.ogg]]) 
LSM:Register("sound", "myMedia_Shutupfool", 					[[Interface\Addons\FreeUI\media\Shutupfool.ogg]]) 
LSM:Register("sound", "myMedia_SliceDice", 						[[Interface\Addons\FreeUI\media\SliceDice.ogg]]) 
LSM:Register("sound", "myMedia_sound", 							[[Interface\Addons\FreeUI\media\sound.mp3]]) 
LSM:Register("sound", "myMedia_SpeedofLight", 					[[Interface\Addons\FreeUI\media\SpeedofLight.ogg]]) 
LSM:Register("sound", "myMedia_Warning", 						[[Interface\Addons\FreeUI\media\Warning.ogg]]) 
LSM:Register("sound", "myMedia_whisper", 						[[Interface\Addons\FreeUI\media\whisper.ogg]]) 
LSM:Register("sound", "myMedia_whisper1", 						[[Interface\Addons\FreeUI\media\whisper1.ogg]]) 
LSM:Register("sound", "myMedia_whisper2", 						[[Interface\Addons\FreeUI\media\whisper2.ogg]]) 
LSM:Register("sound", "myMedia_swordecho", 						[[Interface\Addons\FreeUI\media\swordecho.ogg]]) 
-- -----
--   STATUSBAR
-- -----
LSM:Register("statusbar", "myMedia_Texture", 			[[Interface\Addons\FreeUI\media\Texture.tga]])
LSM:Register("statusbar", "myMedia_Texture0", 			[[Interface\Addons\FreeUI\media\Texture0.tga]])
LSM:Register("statusbar", "myMedia_Texture1", 			[[Interface\Addons\FreeUI\media\Texture1.tga]])
LSM:Register("statusbar", "myMedia_Texture2", 			[[Interface\Addons\FreeUI\media\Texture2.tga]])
LSM:Register("statusbar", "myMedia_Texture3", 			[[Interface\Addons\FreeUI\media\Texture3.tga]])
LSM:Register("statusbar", "myMedia_Texture4", 			[[Interface\Addons\FreeUI\media\Texture4.tga]])
LSM:Register("statusbar", "myMedia_Texture5", 			[[Interface\Addons\FreeUI\media\Texture5.tga]])
LSM:Register("statusbar", "myMedia_Texture6", 			[[Interface\Addons\FreeUI\media\Texture6.tga]])
LSM:Register("statusbar", "myMedia_Texture7", 			[[Interface\Addons\FreeUI\media\Texture7.tga]])
LSM:Register("statusbar", "myMedia_Texture8", 			[[Interface\Addons\FreeUI\media\Texture8.tga]])
LSM:Register("statusbar", "myMedia_Texture9", 			[[Interface\Addons\FreeUI\media\Texture9.tga]])
LSM:Register("statusbar", "myMedia_Texture10",  		[[Interface\Addons\FreeUI\media\Texture10.tga]])
LSM:Register("statusbar", "myMedia_Texture11",  		[[Interface\Addons\FreeUI\media\Texture11.tga]])
