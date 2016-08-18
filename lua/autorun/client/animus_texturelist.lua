--TEXTURE LOADING
		--AnimusHUD/hlthbr:
			hTex = {}
			local count = 1
			for i = 1, 51 do
				hTex[i] = "AnimusHUD/hlthbr/x_hlth_"..count..(i%2==0 and "_5" or "")
				if i%2 == 0 then
					count = count + 1
				end
			end
			
		--Armorbar:
			aTex = {}
			for i = 1, 10 do
				aTex[i] = "AnimusHUD/armorbar/x_armorbar_"..i
			end
			
		--Weaponwheel:
			wepwhl = "AnimusHUD/wepwhl/x_wepwhl"
			wepwhlarrow = "AnimusHUD/wepwhl/x_wepwhlarrow"
			wepwhlmid = "AnimusHUD/wepwhl/x_wepwhlmid"
			
		--AnimusHUD/wepind
			--HL2:
			
			WepIco = {}
			
			WepIco[2] = "AnimusHUD/wepind/hl2/x_cbicon"
			WepIco[3] = "AnimusHUD/wepind/hl2/x_physicon"
			WepIco[4] = "AnimusHUD/wepind/hl2/x_gravicon"
			WepIco[5] = "AnimusHUD/wepind/hl2/x_pstlicon"
			WepIco[6] = "AnimusHUD/wepind/hl2/x_mgnmicon"
			WepIco[7] = "AnimusHUD/wepind/hl2/x_smgicon"
			WepIco[8] = "AnimusHUD/wepind/hl2/x_aricon"
			WepIco[9] = "AnimusHUD/wepind/hl2/x_shtgnicon"
			WepIco[10] = "AnimusHUD/wepind/hl2/x_cbowicon"
			WepIco[11] = "AnimusHUD/wepind/hl2/x_fragicon"
			WepIco[12] = "AnimusHUD/wepind/hl2/x_rpgicon"
			WepIco[13] = "AnimusHUD/wepind/hl2/x_stunsticon"
			WepIco[14] = "AnimusHUD/wepind/hl2/x_bbicon"
			WepIco[15] = "AnimusHUD/wepind/hl2/x_slamicon"
			
			--STANDARD:
			selwepbg = "AnimusHUD/wepind/x_selwepbg"
			otherwep = "AnimusHUD/wepind/x_otherwep"
			WepIco[1] = "AnimusHUD/wepind/x_tlgnicon"