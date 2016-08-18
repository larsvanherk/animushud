--SUPPORTED WEAPONS:
	
	SupportedW = {}
	
	--Standard
	SupportedW[1] = "gmod_tool"
	
	--HL2
	SupportedW[2] = "weapon_crowbar"
	SupportedW[3] = "weapon_physgun"
	SupportedW[4] = "weapon_physcannon"
	SupportedW[5] = "weapon_pistol"
	SupportedW[6] = "weapon_357"
	SupportedW[7] = "weapon_smg1"
	SupportedW[8] = "weapon_ar2"
	SupportedW[9] = "weapon_shotgun"
	SupportedW[10] = "weapon_crossbow"
	SupportedW[11] = "weapon_frag"
	SupportedW[12] = "weapon_rpg"
	SupportedW[13] = "weapon_stunstick"
	SupportedW[14] = "weapon_bugbait"
	SupportedW[15] = "weapon_slam"
	
--SWEPS:
	
	function listSWEPS()
		SWEPS = {}
		
		print("\nANIMUS HUD\nRegistering SWEPS...\n")
		for k,v in pairs(weapons.GetList()) do 
			SWEPS[((v.PrintName == nil or v.PrintName == "" or v.PrintName == " " or (not SWEPS[v.ThisClass] == nil)) and v.ThisClass or (SWEPS[v.PrintName] == nil and v.PrintName or v.PrintName.." (VARIANT)"))] = v.ThisClass
			print(k.." -- Registered SWEP: " .. ((v.PrintName == nil or v.PrintName == "" or v.PrintName == " ") and v.ThisClass or v.PrintName) .. " (" .. v.ThisClass .. ")") 
		end
		print("\nDone registering SWEPS!\n")
	end
	
	hook.Add("OnGamemodeLoaded","AnimusListSWEPS", listSWEPS)
	
--SCREEN POSITIONS:

	ScrPosX = {}
	ScrPosY = {}
	ScrPosW = {}
	ScrPosH = {}
	
	--Standard
	ScrPosX[1] = 91
	ScrPosY[1] = 127
	ScrPosW[1] = 55
	ScrPosH[1] = 35
	
	--HL2
	ScrPosX[2] = 98
	ScrPosY[2] = 137
	ScrPosW[2] = 50
	ScrPosH[2] = 50
	
	ScrPosX[3] = 80
	ScrPosY[3] = 132
	ScrPosW[3] = 80
	ScrPosH[3] = 50
	
	ScrPosX[4] = 87
	ScrPosY[4] = 128
	ScrPosW[4] = 70
	ScrPosH[4] = 40
	
	ScrPosX[5] = 86
	ScrPosY[5] = 124
	ScrPosW[5] = 70
	ScrPosH[5] = 40
	
	ScrPosX[6] = 86
	ScrPosY[6] = 121
	ScrPosW[6] = 70
	ScrPosH[6] = 30
	
	ScrPosX[7] = 86
	ScrPosY[7] = 121
	ScrPosW[7] = 70
	ScrPosH[7] = 33
	
	ScrPosX[8] = 86
	ScrPosY[8] = 121
	ScrPosW[8] = 70
	ScrPosH[8] = 32
	
	ScrPosX[9] = 86
	ScrPosY[9] = 117
	ScrPosW[9] = 70
	ScrPosH[9] = 22
	
	ScrPosX[10] = 86
	ScrPosY[10] = 117
	ScrPosW[10] = 70
	ScrPosH[10] = 24
	
	ScrPosX[11] = 100
	ScrPosY[11] = 125
	ScrPosW[11] = 40
	ScrPosH[11] = 40
	
	ScrPosX[12] = 86
	ScrPosY[12] = 117
	ScrPosW[12] = 70
	ScrPosH[12] = 24
	
	ScrPosX[13] = 85
	ScrPosY[13] = 127
	ScrPosW[13] = 70
	ScrPosH[13] = 32
	
	ScrPosX[14] = 94
	ScrPosY[14] = 127
	ScrPosW[14] = 50
	ScrPosH[14] = 40
	
	ScrPosX[15] = 82
	ScrPosY[15] = 127
	ScrPosW[15] = 75
	ScrPosH[15] = 39
	
--Weapon wheel slot positions

	SlotPosX = {}
	SlotPosY = {}
	SlotAng1 = {}
	SlotAng2 = {}
	
	SlotPosX[1] = -31
	SlotPosY[1] = 184
	SlotAng1[1] = 285
	SlotAng2[1] = 255
	
	SlotPosX[2] = -22
	SlotPosY[2] = -234
	SlotAng1[2] = 105
	SlotAng2[2] = 75
	
	SlotPosX[3] = 62
	SlotPosY[3] = -200
	SlotAng1[3] = 75
	SlotAng2[3] = 45
	
	SlotPosX[4] = -135
	SlotPosY[4] = -198
	SlotAng1[4] = 135
	SlotAng2[4] = 105
	
	SlotPosX[5] = 141
	SlotPosY[5] = -116
	SlotAng1[5] = 45
	SlotAng2[5] = 15
	
	SlotPosX[6] = -211
	SlotPosY[6] = -117
	SlotAng1[6] = 165
	SlotAng2[6] = 135
	
	SlotPosX[7] = 165
	SlotPosY[7] = -15
	SlotAng1[7] = 15
	SlotAng2[7] = -15
	
	SlotPosX[8] = -240
	SlotPosY[8] = -15
	SlotAng1[8] = 195
	SlotAng2[8] = 165
	
	SlotPosX[9] = 138
	SlotPosY[9] = 94
	SlotAng1[9] = -15
	SlotAng2[9] = -45
	
	SlotPosX[10] = -213
	SlotPosY[10] = 91
	SlotAng1[10] = 225
	SlotAng2[10] = 195
	
	SlotPosX[11] = 80
	SlotPosY[11] = 158
	SlotAng1[11] = -45
	SlotAng2[11] = -75
	
	SlotPosX[12] = -142
	SlotPosY[12] = 164
	SlotAng1[12] = 255
	SlotAng2[12] = 225
	
	--SWEP icon slots:
	SWEPSlotPosX = {}
	SWEPSlotPosY = {}
	
	SWEPSlotPosX[1] = -27
	SWEPSlotPosY[1] = 180
	
	SWEPSlotPosX[2] = -25.5
	SWEPSlotPosY[2] = -228
	
	SWEPSlotPosX[3] = 77
	SWEPSlotPosY[3] = -197.5
	
	SWEPSlotPosX[4] = -125.5
	SWEPSlotPosY[4] = -201
	
	SWEPSlotPosX[5] = 150
	SWEPSlotPosY[5] = -123
	
	SWEPSlotPosX[6] = -201.1
	SWEPSlotPosY[6] = -127.5
	
	SWEPSlotPosX[7] = 175
	SWEPSlotPosY[7] = -25
	
	SWEPSlotPosX[8] = -230
	SWEPSlotPosY[8] = -25
	
	SWEPSlotPosX[9] = 148
	SWEPSlotPosY[9] = 80.5
	
	SWEPSlotPosX[10] = -204
	SWEPSlotPosY[10] = 78.5
	
	SWEPSlotPosX[11] = 73.5
	SWEPSlotPosY[11] = 153
	
	SWEPSlotPosX[12] = -132.5
	SWEPSlotPosY[12] = 150
	
--Weapon select positions
	SelPosX = {}
	SelPosY = {}
	
	SelPosX[1] = -42
	SelPosY[1] = 165
	
	SelPosX[2] = -41
	SelPosY[2] = -244
	
	SelPosX[3] = 61
	SelPosY[3] = -213
	
	SelPosX[4] = -141
	SelPosY[4] = -217
	
	SelPosX[5] = 135
	SelPosY[5] = -140
	
	SelPosX[6] = -217
	SelPosY[6] = -143
	
	SelPosX[7] = 160
	SelPosY[7] = -40
	
	SelPosX[8] = -246
	SelPosY[8] = -40
	
	SelPosX[9] = 133
	SelPosY[9] = 65
	
	SelPosX[10] = -219
	SelPosY[10] = 63
	
	SelPosX[10] = -219
	SelPosY[10] = 63
	
	SelPosX[11] = 57
	SelPosY[11] = 137
	
	SelPosX[12] = -147
	SelPosY[12] = 136