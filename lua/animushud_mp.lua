//////////////////////////////////////
// Animus HUD						//
//   Made by:						//
//     Abstergo						//
//									//
//   Version:						//
//     BETA V2       				//
//									//
//   Contact/Bug Reporting			//
//	   larsvanherk@outlook.com		//
//////////////////////////////////////

--Include databases
include( "autorun/client/animus_texturelist.lua" )
include( "autorun/client/animus_weaponlist.lua" )

--Variables
	--Weapon wheel
local WheelVar = false
local SWEPWhlVar = false
HeldWeapons = {}
SelectedSWEPS = {}
	--Main function
local Ply
local healthCount
local mag_left
local mag_extra
local mag_left_x
local mag_extra_x
local ActiveWeapon
local CurWepIco
local CurScrPosX
local CurScrPosY
local CurScrPosZ
local CurScrPosH
local mouseX, mouseY
local mouseAng
local DispName
local wheelTimer = 0
local wheelVis = false

--Console variables:
local AllWepAmmo = CreateClientConVar("animus_AllWepAmmo", "0", true)
local EnableHUD = CreateClientConVar("animus_Display", "1", true)
	local EnableHUDch = false
local NumericHA = CreateClientConVar("animus_Numeric", "0", true)
	--SWEP wheel slots:
CreateClientConVar("animus_Slot1", "", true)
CreateClientConVar("animus_Slot2", "", true)
CreateClientConVar("animus_Slot3", "", true)
CreateClientConVar("animus_Slot4", "", true)
CreateClientConVar("animus_Slot5", "", true)
CreateClientConVar("animus_Slot6", "", true)
CreateClientConVar("animus_Slot7", "", true)
CreateClientConVar("animus_Slot8", "", true)
CreateClientConVar("animus_Slot9", "", true)
CreateClientConVar("animus_Slot10", "", true)
CreateClientConVar("animus_Slot11", "", true)
CreateClientConVar("animus_Slot12", "", true)

--Functions
	--Simple table analyzation
function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

	--Weapon wheel functions
local function WeaponWheel()
	concommand.Add("+weaponwheel", function()
		WheelVar = true
	end)
	concommand.Add("-weaponwheel", function()
		WheelVar = false
	end)
		
		--SWEP wheel variant
	concommand.Add("+swepwheel", function()
		WheelVar = true
		SWEPWhlVar = true
	end)
	concommand.Add("-swepwheel", function()
		WheelVar = false
	end)
	
	if (not wheelVis) and (not WheelVar) then
		SWEPWhlVar = false
	end
	
	gui.EnableScreenClicker(wheelVis)
end
hook.Add("Think","WeaponWheel",WeaponWheel)

local function CheckCurWep()
	HeldWeapons = {}
	for k, v in pairs(LocalPlayer():GetWeapons()) do
			table.insert(HeldWeapons, v:GetClass())
	end
	SelectedSWEPS = {}
	for I = 1,12 do
		SelectedSWEPS[I] = GetConVar("animus_Slot"..I):GetString()
	end
end
hook.Add("Think","CurWepTable",CheckCurWep)

local function WheelTimer()
	if WheelVar and wheelTimer < 1 and wheelTimer + (1/FrameTime() >= 60 and 0.05 or (1/FrameTime() >= 30 and 0.2 or 0.25)) <= 1 then
		wheelTimer = wheelTimer + (1/FrameTime() >= 60 and 0.05 or (1/FrameTime() >= 30 and 0.2 or 0.25))
	elseif WheelVar and (wheelTimer > 1 or wheelTimer + (1/FrameTime() >= 60 and 0.05 or (1/FrameTime() >= 30 and 0.2 or 0.25)) > 1) then
		wheelTimer = 1
	elseif (not WheelVar) and wheelTimer > 0 and wheelTimer + (1/FrameTime() >= 60 and 0.05 or (1/FrameTime() >= 30 and 0.2 or 0.25)) >= 0 then
		wheelTimer = wheelTimer - (1/FrameTime() >= 60 and 0.05 or (1/FrameTime() >= 30 and 0.2 or 0.25))
	elseif (not WheelVar) and wheelTimer < 0 and (wheelTimer > 1 or wheelTimer + (1/FrameTime() >= 60 and 0.05 or (1/FrameTime() >= 30 and 0.2 or 0.25)) < 0) then
		wheelTimer = 0
	end
end
hook.Add("Think","WheelTimer",WheelTimer)

	--Draw rectangle
local function drawRect(colour, texture, x, y, w, h)
	surface.SetDrawColor(colour)
	surface.SetTexture(surface.GetTextureID(texture))
	surface.DrawTexturedRect( x, y, w, h )
end

--MAIN:
local function animushud()
	--Initialize basic in HUD functions
	Ply = LocalPlayer()
	if !Ply:Alive() then return end
	if(Ply:GetActiveWeapon() == NULL or Ply:GetActiveWeapon() == "Camera") then return end
	
	--Health and armour bar (Woo, finally it's some decent code!)
		--Health bar:
	surface.SetDrawColor(255, 255, 255, 210)
	for i = 0, 50 do
		if Ply:Health() <= 100-(2*i) and Ply:Health() > 98-(2*i) then 
			surface.SetTexture(surface.GetTextureID(hTex[1+i])) 
			break
		elseif Ply:Health() > 100 or Ply:Health() < 0 then
			surface.SetTexture(surface.GetTextureID(hTex[1]))
			break
		end
	end
	if not WheelVar then
		surface.DrawTexturedRect( 0, 40, 600, 76 )
		
			--Numeric health:
		if NumericHA:GetBool() then
			drawRect(Color(255, 255, 255, 115), selwepbg, 10, 57.99, 45, 45 )
			draw.DrawText(Ply:Health().."","HudHintTextLarge",31.55,71.5, Color(245,245,245),1)
		end
	end
	
		--Armor bar
	if Ply:Armor() > 0 then
		surface.SetDrawColor(255, 255, 255, 210)
		for i = 0, 9 do
			if Ply:Armor() <= 100-(10*i) and Ply:Armor() > 90-(10*i) then 
				surface.SetTexture(surface.GetTextureID(aTex[10-(i)])) 
				break
			end
		end
		if not WheelVar then
			surface.DrawTexturedRect( 176, 116, 380, 18 )
				--Numeric armor:
			if NumericHA:GetBool() then
				drawRect(Color(255, 255, 255, 115), selwepbg, 40, 86, 30, 30 )
				draw.DrawText(Ply:Armor().."","DermaDefaultBold",54.5,93.01, Color(245,245,245),1)
			end
		end
	end
	
	--Weapon display
	if not WheelVar then
		--Draw the background
	drawRect(Color(255, 255, 255, 210), selwepbg, 75, ScrH()-150, 90, 90)
	
		--Get ammo values
	mag_left = Ply:GetActiveWeapon():Clip1()
	mag_extra = Ply:GetAmmoCount(Ply:GetActiveWeapon():GetPrimaryAmmoType())
	
		--AmmoBox function
		local function ammobox()		
			if mag_left >= 100 then
				mag_left_x = 142
			end
			if mag_left >= 10 and mag_left < 100 then
				mag_left_x = 151
			end
			if mag_left < 10 then
				mag_left_x = 155
			end
			
			if mag_extra >= 100 then
				mag_extra_x = 147
			end
			if mag_extra >= 10 and mag_extra < 100 then
				mag_extra_x = 151
			end
			if mag_extra < 10 then
				mag_extra_x = 155
			end
			
			drawRect(Color(255, 255, 255, 210), selwepbg, 140, (ScrH()-163), 40, 40 )
			draw.DrawText(mag_left,"TargetIDSmall",mag_left_x,(ScrH()-151), Color(245,245,245),0,0)
		
			if mag_extra > 0 then
				drawRect(Color(255, 255, 255, 210), selwepbg, 140, (ScrH()-88), 40, 40 )
				draw.DrawText(mag_extra,"TargetIDSmall",mag_extra_x,(ScrH()-76), Color(245,245,245),0,0)
			end
		end
	
		--Weapon icon support and display
		ActiveWeapon = Ply:GetActiveWeapon():GetClass()
		
		if table.contains(SupportedW, ActiveWeapon) then
			for I = 1,15 do
				if ActiveWeapon == SupportedW[I] then
					--Get icon and its position from database.
					CurWepIco = WepIco[I]
					CurScrPosX = ScrPosX[I]
					CurScrPosY = (ScrH()-ScrPosY[I])
					CurScrPosW = ScrPosW[I]
					CurScrPosH = ScrPosH[I]
					
					--List weapons that need an ammobox. Set indexes here.
					if I >= 5 and I <= 10 then
						ammobox()
					end
					
					--RPG and frag are special little icons, aren't they...
					if I == 11 or I == 12 then
			
						if mag_extra >= 100 then
							mag_extra_x = 147
						end
						if mag_extra >= 10 and mag_extra < 100 then
							mag_extra_x = 151
						end
						if mag_extra < 10 then
							mag_extra_x = 155
						end
					
						drawRect(Color(255, 255, 255, 210), selwepbg, 140, (ScrH()-163), 40, 40 ) 
						draw.DrawText(mag_extra,"TargetIDSmall",mag_extra_x,(ScrH()-151), Color(245,245,245),0,0)
					end
					break
				end
			end
		else
			CurWepIco = otherwep
			CurScrPosX = 95
			CurScrPosY = (ScrH()-131)
			CurScrPosW = 50
			CurScrPosH = 50
			
				--Let the user choose to display unsupported ammoboxes.
			if AllWepAmmo:GetBool() then
				ammobox()
			end
		end
			--Draw the weapon's icon.
			drawRect(Color(255, 255, 255, 210), CurWepIco, CurScrPosX, CurScrPosY, CurScrPosW, CurScrPosH )
	end
	
	--Weapon wheel	
	if wheelTimer > 0 then
		wheelVis = true
		
		surface.SetDrawColor(50,50,50,175*wheelTimer)
		surface.DrawRect( 0, 0, ScrW(), ScrH() )
		drawRect(Color(255, 255, 255, 150*wheelTimer), wepwhl, (ScrW()/2)-306*wheelTimer, (ScrH()/2)-306*wheelTimer, 609*wheelTimer, 611*wheelTimer )
			
			--Calculate mouse angle
			mouseX = gui.MouseX()
			mouseY = gui.MouseY()
			if mouseX >= (ScrW()/2) then
				mouseAng = -((math.atan((mouseY - (ScrH()/2)) / (mouseX - (ScrW()/2))) * 180) / math.pi)
			else
				mouseAng = -((math.atan((mouseY - (ScrH()/2)) / (mouseX - (ScrW()/2))) * 180) / math.pi - 180)
			end
			
		surface.SetDrawColor(255, 255, 255, 255*wheelTimer)
		surface.SetTexture(surface.GetTextureID(wepwhlarrow))
		surface.DrawTexturedRectRotated( (ScrW()/2) , (ScrH()/2) , 250 , 250 , mouseAng + 90 )
		
		drawRect(Color(255, 255, 255, 255*wheelTimer), wepwhlmid, (ScrW()/2)-50, (ScrH()/2)-51, 100, 101 )
		drawRect(Color(255, 255, 255, 255*wheelTimer), CurWepIco, (ScrW()/2)-(CurScrPosW/2), (ScrH()/2)-(CurScrPosH/2), CurScrPosW, CurScrPosH )
		
		for I = 1, 12 do
			if table.contains(HeldWeapons,(SWEPWhlVar and SelectedSWEPS[I] or SupportedW[I])) then
				if mouseAng < SlotAng1[I] and mouseAng >= SlotAng2[I] then
					drawRect(Color(255, 255, 255, 255*wheelTimer), wepwhlmid, (ScrW()/2)+SelPosX[I]*wheelTimer, (ScrH()/2)+SelPosY[I]*wheelTimer, 81*wheelTimer, 82*wheelTimer )
					RunConsoleCommand( "use", (SWEPWhlVar and SelectedSWEPS[I] or SupportedW[I]) )
				elseif SupportedW[I] == "gmod_tool" and mouseAng < -75 and mouseAng >= -90 then
					drawRect(Color(255, 255, 255, 255*wheelTimer), wepwhlmid, (ScrW()/2)+SelPosX[I]*wheelTimer, (ScrH()/2)+SelPosY[I]*wheelTimer, 81*wheelTimer, 82*wheelTimer )
					RunConsoleCommand( "use", (SWEPWhlVar and SelectedSWEPS[I] or SupportedW[I]) )
				end
				if not SWEPWhlVar then
					drawRect(Color(255, 255, 255, 210*wheelTimer), WepIco[I], (ScrW()/2)+SlotPosX[I]*wheelTimer, (ScrH()/2)+SlotPosY[I]*wheelTimer, ScrPosW[I]*wheelTimer, ScrPosH[I]*wheelTimer )
				else
					for k,v in pairs(SWEPS) do if v == SelectedSWEPS[I] then DispName = k end end
					draw.DrawText(DispName,"HudSelectionText",(ScrW()/2)+(SWEPSlotPosX[I]+((I == 1 or I == 2) and 25 or (I%2 == 0 and -20 or 71)))*wheelTimer, (ScrH()/2)+(SWEPSlotPosY[I]+(I == 1 and 70 or (I == 2 and -40 or 15.5)))*wheelTimer, Color(245,245,245),(I == 1 or I == 2) and 1 or (I%2 == 0 and 2 or 0))
					drawRect(Color(255, 255, 255, 210*wheelTimer), otherwep, (ScrW()/2)+SWEPSlotPosX[I]*wheelTimer, (ScrH()/2)+SWEPSlotPosY[I]*wheelTimer, 50*wheelTimer, 50*wheelTimer )
				end
			end
		end
	else
		wheelVis = false
	end
end

local function drawHUD()
	--Draw AnimusHUD or standard HUD:
	if (not EnableHUD:GetBool() == EnableHUDch) and EnableHUD:GetBool() then
		--Draw Animus HUD:
		hook.Add("HUDPaint", "animusDraw", animushud)
		
		--Kill standard HUD:
		function hidehud(name)
			for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
				if name == v then return false end
			end
		end
		hook.Add("HUDShouldDraw", "hidehud", hidehud)
		
		--Prevent loop:
		EnableHUDch = true
	elseif (not EnableHUD:GetBool() == EnableHUDch) and (not EnableHUD:GetBool()) then
		hook.Remove("HUDPaint", "animusDraw")
		hook.Remove("HUDShouldDraw", "hidehud")
		
		EnableHUDch = false
	end
end
hook.Add("Think","checkDisplay",drawHUD)

--Options panel:
local function animus_Options( cpanel )
    cpanel:ClearControls()
    cpanel:AddControl( "Header", { Text = "Animus HUD", Description = "================================\nWelcome to the Animus HUD settings!\n\nAnimus HUD created by Abstergo\n================================\nGeneral settings:" })
	cpanel:AddControl( "Checkbox", { Label = "Enable HUD", Command = "animus_Display" }  )
	cpanel:AddControl( "Checkbox", { Label = "Enable numeric health and armor", Command = "animus_Numeric" } )
	cpanel:AddControl( "Checkbox", { Label = "Enable ammo counter for unsupported weapons", Command = "animus_AllWepAmmo" } )
	
	cpanel:AddControl( "Label", {Text = "================================\nCustom SWEP wheel configuration:"} )
	local slot1 = {["None"] = {["animus_Slot1"] = ""}}
	local slot2 = {["None"] = {["animus_Slot2"] = ""}}
	local slot3 = {["None"] = {["animus_Slot3"] = ""}}
	local slot4 = {["None"] = {["animus_Slot4"] = ""}}
	local slot5 = {["None"] = {["animus_Slot5"] = ""}}
	local slot6 = {["None"] = {["animus_Slot6"] = ""}}
	local slot7 = {["None"] = {["animus_Slot7"] = ""}}
	local slot8 = {["None"] = {["animus_Slot8"] = ""}}
	local slot9 = {["None"] = {["animus_Slot9"] = ""}}
	local slot10 = {["None"] = {["animus_Slot10"] = ""}}
	local slot12 = {["None"] = {["animus_Slot12"] = ""}}
	local slot11 = {["None"] = {["animus_Slot11"] = ""}}
    for name, class in pairs(SWEPS) do
        slot1[name] = {["animus_Slot1"] = class}
		slot2[name] = {["animus_Slot2"] = class}
		slot3[name] = {["animus_Slot3"] = class}
		slot4[name] = {["animus_Slot4"] = class}
		slot5[name] = {["animus_Slot5"] = class}
		slot6[name] = {["animus_Slot6"] = class}
		slot7[name] = {["animus_Slot7"] = class}
		slot8[name] = {["animus_Slot8"] = class}
		slot9[name] = {["animus_Slot9"] = class}
		slot10[name] = {["animus_Slot10"] = class}
		slot11[name] = {["animus_Slot11"] = class}
		slot12[name] = {["animus_Slot12"] = class}
    end	
	cpanel:AddControl( "ListBox", { Label = "Slot 1:", Options = slot1 } ) 
	cpanel:AddControl( "ListBox", { Label = "Slot 2:", Options = slot2 } )
	cpanel:AddControl( "ListBox", { Label = "Slot 3:", Options = slot3 } ) 
	cpanel:AddControl( "ListBox", { Label = "Slot 4:", Options = slot4 } ) 
	cpanel:AddControl( "ListBox", { Label = "Slot 5:", Options = slot5 } ) 
	cpanel:AddControl( "ListBox", { Label = "Slot 6:", Options = slot6 } ) 
	cpanel:AddControl( "ListBox", { Label = "Slot 7:", Options = slot7 } ) 
	cpanel:AddControl( "ListBox", { Label = "Slot 8:", Options = slot8 } ) 
	cpanel:AddControl( "ListBox", { Label = "Slot 9:", Options = slot9 } ) 
	cpanel:AddControl( "ListBox", { Label = "Slot 10:", Options = slot10 } ) 
	cpanel:AddControl( "ListBox", { Label = "Slot 11:", Options = slot11 } ) 
	cpanel:AddControl( "ListBox", { Label = "Slot 12:", Options = slot12 } ) 
end

function populateToolMenu()
    spawnmenu.AddToolMenuOption( "Options", "HUD", "Animus HUD", "Animus HUD", "", "", animus_Options )
end
hook.Add( "PopulateToolMenu", "animusPopulateToolMenu", populateToolMenu )

--Console display on boot:
print("\n")
print("//////////////////////////////")
print("// ANIMUS HUD               //")
print("//   Version:               //")
print("//      BETA v2             //")
print("//   Contact:               //")
print("//      Abstergo (Steam)    //")
print("//////////////////////////////")
print("\n")

--Fix SWEP wheel in multiplayer.
listSWEPS()