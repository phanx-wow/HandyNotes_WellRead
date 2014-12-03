--[[--------------------------------------------------------------------
	HandyNotes: Well Read
	Shows the books you still need for the Well Read achievement.
	Copyright (c) 2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info-HandyNotes-WellRead.html
	http://www.curse.com/addons/wow/handynotes-well-read
	https://github.com/Phanx/HandyNotes_WellRead
----------------------------------------------------------------------]]
-- TODO:
-- * Option to show/hide books in high level opposite faction areas

local ADDON_NAME, data = ...
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")

local ACHIEVEMENT_ID = 1244
local ICON = "Interface\\AddOns\\HandyNotes_WellRead\\Book"
local ADDON_TITLE = GetAddOnMetadata(ADDON_NAME, "Title")
local ACHIEVEMENT_NAME = select(2, GetAchievementInfo(ACHIEVEMENT_ID))

local L = setmetatable({}, { __index = function(t, k) t[k] = k return k end })
if GetLocale() == "deDE" then
	-- Main
	L["<Right-Click to set a waypoint in TomTom.>"] = "<Rechtsklick, um eine Zielpunkt in TomTom zu setzen.>"
	L["<Ctrl-Right-Click for additional waypoint options.>"] = "<STRG-Rechtsklick für mehr Zielpunksoptionen.>"
	L["Set waypoints for..."] = "Setz Zielpunkte für..."
	L["All books in this zone"] = "Alle Bücher in diesem Gebiet"
	L["All books everywhere"] = "Alle Bücher überall"
	-- Notes
	L["Around back"] = "Hinter dem Gebäude"
	L["Halfway down, in the Tavern of Time"] = "Halbwegs nach unten, in der Taverne der Zeit"
	L["Level %s Alliance area"] = "Allianzstelle der Stufe %s"
	L["Level %s Horde area"] = "Hordestelle der Stufe %s"
	L["On the balcony"] = "Auf dem Balkon"
	L["Upstairs"] = "Nach oben"
elseif GetLocale():match("^es") then
	-- Main
	L["<Right-Click to set a waypoint in TomTom.>"] = "<Clic derecho para establecer un waypoint en TomTom.>"
	L["<Ctrl-Right-Click for additional waypoint options.>"] = "<Ctrl-clic derecho para más opciones de waypoints.>"
	L["Set waypoints for..."] = "Establecer waypoints para..."
	L["All books in this zone"] = "Todos libros en esta zona"
	L["All books everywhere"] = "Todos libros en todas zonas"
	-- Notes
	L["Around back"] = "Por detrás"
	L["Halfway down, in the Tavern of Time"] = "A mitad de la bajada, en la Taberna del Tiempo"
	L["Level %s Alliance area"] = "Lugar de la Alianza de nivel %s"
	L["Level %s Horde area"] = "Lugar de la Horda de nivel %s"
	L["On the balcony"] = "En el balcón"
	L["Upstairs"] = "Arriba"
end

local data = {
	["Ashenvale"] = { -- TODO
		[34804970] = { criteria = 3767, zone = 43, faction = "Alliance" }, -- Charge of the Dragonflights (Astranaar)
		[34504950] = { criteria = 3780, zone = 43, faction = "Alliance" }, -- Sargeras and the Betrayal (Astranaar)
		[34505000] = { criteria = 3781, zone = 43, faction = "Alliance" }, -- Sunwell - The Fall of Quel'Thalas (Astranaar)
		[34804980] = { criteria = 3795, zone = 43, faction = "Alliance" }, -- The Scourge of Lordaeron (Astranaar)
	},
	["Arathi"] = { -- DONE
		[69233317] = { criteria = 3778, zone = 16, faction = "Horde", note = L["Upstairs"] }, -- Rise of the Blood Elves (Hammerfall)
		[69343288] = { criteria = 3780, zone = 16, faction = "Horde" }, -- Sargeras and the Betrayal (Hammerfall)
	},
	["BlackrockDepths"] = {
		[55507000] = { criteria = 3772, zone = 704 }, -- Ironforge - the Awakening of the Dwarves -- NEEDS CHECK
		[58503830] = { criteria = 3794, zone = 704 }, -- The Old Gods and the Ordering of Azeroth -- NEEDS CHECK
		[58707260] = { criteria = 3802, zone = 704 }, -- War of the Three Hammers
	},
	["BlastedLands_terrain1"] = {
		[60101360] = { criteria = 3763, zone = 19 }, -- Aftermath of the Second War (Nethergarde Keep)
		[60902020] = { criteria = 3766, zone = 19 }, -- Beyond the Dark Portal (Nethergarde Keep)
		[62501610] = { criteria = 3786, zone = 19 }, -- The Dark Portal and the Fall of Stormwind (Nethergarde Keep)
	},
	["TheCapeOfStranglethorn"] = {
		[40707380] = { criteria = 3766, zone = 673 }, -- Beyond the Dark Portal (Booty Bay)
		[42107370] = { criteria = 3769, zone = 673 }, -- Empires' Fall (Booty Bay)
		[41007450] = { criteria = 3781, zone = 673 }, -- Sunwell - The Fall of Quel'Thalas (Booty Bay)
		[41907350] = { criteria = 3795, zone = 673 }, -- The Scourge of Lordaeron (Booty Bay)
		[42107360] = { criteria = 3796, zone = 673 }, -- The Sentinels and the Long Vigil (Booty Bay)
		[42107370] = { criteria = 3798, zone = 673 }, -- The Twin Empires (Booty Bay)
		[42107370] = { criteria = 3803, zone = 673 }, -- Wrath of the Soulflayer (Booty Bay)
	},
	["Dalaran"] = {
		[37103590] = { criteria = 3788, zone = 504 }, -- The Guardians of Tirisfal
	},
	["Darnassus"] = { -- TODO
		[54203100] = { criteria = 3763, zone = 381, faction = "Alliance" }, -- Aftermath of the Second War
		[39703980] = { criteria = 3770, zone = 381, faction = "Alliance" }, -- Exile of the High Elves -- NEEDS CHECK
		[49501660] = { criteria = 3778, zone = 381, faction = "Alliance" }, -- Rise of the Blood Elves -- NEEDS CHECK
		[50003350] = { criteria = 3778, zone = 381, faction = "Alliance" }, -- Rise of the Blood Elves -- NEEDS CHECK
		[62007460] = { criteria = 3784, zone = 381, faction = "Alliance" }, -- The Betrayer Ascendant
		[54303860] = { criteria = 3794, zone = 381, faction = "Alliance" }, -- The Old Gods and the Ordering of Azeroth
		[49803300] = { criteria = 3799, zone = 381, faction = "Alliance" }, -- The War of the Ancients
		[55002470] = { criteria = 3800, zone = 381, faction = "Alliance" }, -- The World Tree and the Emerald Dream
	},
	["Desolace"] = {
		[66300770] = { criteria = 3765, zone = 101 }, -- Archimonde's Return and the Flight to Kalimdor
	},
	["DunMorogh"] = {
		[49944492] = { criteria = 3782, zone = 27, note = L["Upstairs"] }, -- The Alliance of Lordaeron (Kharanos)
	},
	["Durotar"] = { -- DONE
		[59605820] = { criteria = 3779, zone = 4 }, -- Rise of the Horde (Tiragarde Keep)
	},
	["Duskwood"] = {
		[74204530] = { criteria = 3774, zone = 34 }, -- Kil'jaeden and the Shadow Pact (Darkshire)
		[73704460] = { criteria = 3776, zone = 34 }, -- Mount Hyjal and Illidan's Gift (Darkshire)
		[72104790] = { criteria = 3782, zone = 34 }, -- The Alliance of Lordaeron (Darkshire)
		[72104660] = { criteria = 3785, zone = 34 }, -- The Birth of the Lich King (Darkshire)
		[73704510] = { criteria = 3787, zone = 34 }, -- The Founding of Quel'Thalas (Darkshire)
	},
	["Elwynn"] = {
		[49503960] = { criteria = 3768, zone = 30 }, -- Civil War in the Plaguelands (Northshire)
		[43806580] = { criteria = 3771, zone = 30 }, -- Icecrown and the Frozen Throne (Goldshire)
		[85306970] = { criteria = 3775, zone = 30 }, -- Lethargy of the Orcs (Eastvale Logging Camp)
	},
	["Feralas"] = { -- DONE
		[30904282] = { criteria = 3796, zone = 121 }, -- The Sentinels and the Long Vigil (Ruins of Feathermoon)
	},
	["HillsbradFoothills"] = { -- DONE
		[56714754] = { criteria = 3764, zone = 24 }, -- Arathor and the Troll Wars (Tarren Mill)
		[56614754] = { criteria = 3773, zone = 24 }, -- Kel'thuzad and the Forming of the Scourge (Tarren Mill)
		[57414538] = { criteria = 3768, zone = 24, note = L["Around back"] }, -- Civil War in the Plaguelands (Tarren Mill)
		[57194547] = { criteria = 3782, zone = 24, note = L["On the balcony"] }, -- The Alliance of Lordaeron (Tarren Mill)
		[58004607] = { criteria = 3785, zone = 24 }, -- The Birth of the Lich King (Tarren Mill)
	},
	["Ironforge"] = {
		[77000950] = { criteria = 3764, zone = 341, faction = "Alliance" }, -- Arathor and the Troll Wars
		[76501060] = { criteria = 3767, zone = 341, faction = "Alliance" }, -- Charge of the Dragonflights
		[76801230] = { criteria = 3768, zone = 341, faction = "Alliance" }, -- Civil War in the Plaguelands
		[75100920] = { criteria = 3772, zone = 341, faction = "Alliance" }, -- Ironforge - the Awakening of the Dwarves
		[76801230] = { criteria = 3779, zone = 341, faction = "Alliance" }, -- Rise of the Horde
		[77001200] = { criteria = 3782, zone = 341, faction = "Alliance" }, -- The Alliance of Lordaeron
		[76201080] = { criteria = 3783, zone = 341, faction = "Alliance" }, -- The Battle of Grim Batol -- NEEDS CHECK
		[76551065] = { criteria = 3794, zone = 341, faction = "Alliance" }, -- The Old Gods and the Ordering of Azeroth -- NEEDS CHECK
		[75100930] = { criteria = 3802, zone = 341, faction = "Alliance" }, -- War of the Three Hammers
	},
	["LochModan"] = {
		[35604900] = { criteria = 3772, zone = 35 }, -- Ironforge - the Awakening of the Dwarves (Thelsamar)
		[37204700] = { criteria = 3791, zone = 35 }, -- The Last Guardian (Thelsamar)
	},
	["Mulgore"] = { -- DONE
		[32634949] = { criteria = 3772, zone = 9 }, -- Ironforge - the Awakening of the Dwarves (Bael'dun Digsite)
		[32584946] = { criteria = 3783, zone = 9 }, -- The Battle of Grim Batol (Bael'dun Digsite)
		[32634944] = { criteria = 3802, zone = 9 }, -- War of the Three Hammers (Bael'dun Digsite)
	},
	["Northshire"] = {
--		[] = { criteria = 3768, zone = 864, faction = "Alliance" }, -- Civil War in the Plaguelands -- NEEDS CHECK
	},
	["Barrens"] = { -- DONE
		[67987354] = { criteria = 3765, zone = 11 }, -- Archimonde's Return and the Flight to Kalimdor (Ratchet)
		[68366909] = { criteria = 3767, zone = 11 }, -- Charge of the Dragonflights (Ratchet)
		[67097336] = { criteria = 3770, zone = 11, note = L["On the balcony"] }, -- Exile of the High Elves (Ratchet)
		[66877465] = { criteria = 3776, zone = 11 }, -- Mount Hyjal and Illidan's Gift (Ratchet)
		[67037501] = { criteria = 3780, zone = 11 }, -- Sargeras and the Betrayal (Ratchet)
	},
	["Redridge"] = {
		[26204220] = { criteria = 3786, zone = 36 }, -- The Dark Portal and the Fall of Stormwind (Lakeshire)
		[28904120] = { criteria = 3802, zone = 36 }, -- War of the Three Hammers (Lakeshire)
	},
	["Scholomance"] = {
		[56584126] = { criteria = 3789, zone = 898, level = 2 }, -- The Invasion of Draenor (Chamber of Summoning)
	},
	["SilvermoonCity"] = {
		[66807380] = { criteria = 3782, zone = 480, faction = "Horde" }, -- The Alliance of Lordaeron
		[68706450] = { criteria = 3784, zone = 480, faction = "Horde" }, -- The Betrayer Ascendant
	},
	["SouthernBarrens"] = { -- DONE
		[50498689] = { criteria = 3772, zone = 607 }, -- Ironforge - the Awakening of the Dwarves (Bael Modan)
		[65514673] = { criteria = 3775, zone = 607 }, -- Lethargy of the Orcs (Northwatch Hold)
		[65504672] = { criteria = 3793, zone = 607 }, -- The New Horde (Northwatch Hold)
		[50058654] = { criteria = 3802, zone = 607, note = L["Downstairs"] }, -- War of the Three Hammers (Bael Modan)
	},
	["StormwindCity"] = {
		[76402960] = { criteria = 3762, zone = 301, faction = "Alliance" }, -- Aegwynn and the Dragon Hunt
		[85702370] = { criteria = 3762, zone = 301, faction = "Alliance" }, -- Aegwynn and the Dragon Hunt
		[85202610] = { criteria = 3763, zone = 301, faction = "Alliance" }, -- Aftermath of the Second War
		[51807450] = { criteria = 3765, zone = 301, faction = "Alliance" }, -- Archimonde's Return and the Flight to Kalimdor
		[44007170] = { criteria = 3766, zone = 301, faction = "Alliance" }, -- Beyond the Dark Portal
		[84602430] = { criteria = 3766, zone = 301, faction = "Alliance" }, -- Beyond the Dark Portal
		[44007160] = { criteria = 3768, zone = 301, faction = "Alliance" }, -- Civil War in the Plaguelands
		[85003240] = { criteria = 3768, zone = 301, faction = "Alliance" }, -- Civil War in the Plaguelands
		[51807460] = { criteria = 3776, zone = 301, faction = "Alliance" }, -- Mount Hyjal and Illidan's Gift
		[85252615] = { criteria = 3782, zone = 301, faction = "Alliance" }, -- The Alliance of Lordaeron
		[86503600] = { criteria = 3783, zone = 301, faction = "Alliance" }, -- The Battle of Grim Batol
		[87103590] = { criteria = 3786, zone = 301, faction = "Alliance" }, -- The Dark Portal and the Fall of Stormwind
		[76203180] = { criteria = 3788, zone = 301, faction = "Alliance" }, -- The Guardians of Tirisfal -- NEEDS CHECK
		[85002610] = { criteria = 3788, zone = 301, faction = "Alliance" }, -- The Guardians of Tirisfal -- NEEDS CHECK
		[75303000] = { criteria = 3790, zone = 301, faction = "Alliance" }, -- The Kaldorei and the Well of Eternity -- NEEDS CHECK
		[84702590] = { criteria = 3790, zone = 301, faction = "Alliance" }, -- The Kaldorei and the Well of Eternity -- NEEDS CHECK
		[86102550] = { criteria = 3793, zone = 301, faction = "Alliance" }, -- The New Horde
		[85002350] = { criteria = 3799, zone = 301, faction = "Alliance" }, -- The War of the Ancients
		[85502350] = { criteria = 3800, zone = 301, faction = "Alliance" }, -- The World Tree and the Emerald Dream
		[44107210] = { criteria = 3801, zone = 301, faction = "Alliance" }, -- War of the Spider
		[86703580] = { criteria = 3801, zone = 301, faction = "Alliance" }, -- War of the Spider
		[66607340] = { criteria = 3802, zone = 301, faction = "Alliance" }, -- War of the Three Hammers
	},
	["Stratholme"] = {
		[25807070] = { criteria = 3768, zone = 765 }, -- Civil War in the Plaguelands -- NEEDS CHECK
		[39003780] = { criteria = 3768, zone = 765 }, -- Civil War in the Plaguelands -- NEEDS CHECK
		[25807150] = { criteria = 3771, zone = 765 }, -- Icecrown and the Frozen Throne -- NEEDS CHECK
		[39003790] = { criteria = 3771, zone = 765 }, -- Icecrown and the Frozen Throne -- NEEDS CHECK
		[25507040] = { criteria = 3773, zone = 765 }, -- Kel'thuzad and the Forming of the Scourge -- NEEDS CHECK
		[38903770] = { criteria = 3773, zone = 765 }, -- Kel'thuzad and the Forming of the Scourge -- NEEDS CHECK
		[30504070] = { criteria = 3774, zone = 765 }, -- Kil'jaeden and the Shadow Pact -- NEEDS CHECK
		[39903160] = { criteria = 3774, zone = 765 }, -- Kil'jaeden and the Shadow Pact -- NEEDS CHECK
		[25507060] = { criteria = 3785, zone = 765 }, -- The Birth of the Lich King -- NEEDS CHECK
		[28903770] = { criteria = 3785, zone = 765 }, -- The Birth of the Lich King -- NEEDS CHECK
		[25557065] = { criteria = 3792, zone = 765 }, -- The Lich King Triumphant -- NEEDS CHECK
		[38953775] = { criteria = 3792, zone = 765 }, -- The Lich King Triumphant -- NEEDS CHECK
		[27804790] = { criteria = 3795, zone = 765 }, -- The Scourge of Lordaeron
		[30554075] = { criteria = 3797, zone = 765 }, -- The Seven Kingdoms -- NEEDS CHECK
		[39953165] = { criteria = 3797, zone = 765 }, -- The Seven Kingdoms -- NEEDS CHECK
		[25857155] = { criteria = 3801, zone = 765 }, -- War of the Spider -- NEEDS CHECK
		[39053795] = { criteria = 3801, zone = 765 }, -- War of the Spider -- NEEDS CHECK
	},
	["SwampOfSorrows"] = {
		[49405520] = { criteria = 3779, zone = 38 }, -- Rise of the Horde (Stonard)
		[49305550] = { criteria = 3786, zone = 38 }, -- The Dark Portal and the Fall of Stormwind (Stonard)
		[49355555] = { criteria = 3793, zone = 38 }, -- The New Horde (Stonard)
	},
	["Tanaris"] = { -- DONE
		[52472689] = { criteria = 3769, zone = 161 }, -- Empires' Fall (Gadgetzan)
		[39987686] = { criteria = 3772, zone = 161, note = format(L["Level %s Alliance area"], 50) }, -- Ironforge - the Awakening of the Dwarves (Valley of the Watchers)
		[50973029] = { criteria = 3777, zone = 161 }, -- Old Hatreds - The Colonization of Kalimdor (Gadgetzan)
		[88401481] = { criteria = 3790, zone = 161, note = L["Halfway down, in the Tavern of Time"] }, -- The Kaldorei and the Well of Eternity (Caverns of Time)
		[52492689] = { criteria = 3798, zone = 161 }, -- The Twin Empires (Gadgetzan)
		[52472687] = { criteria = 3803, zone = 161 }, -- Wrath of the Soulflayer (Gadgetzan)
	},
	["Tirisfal"] = { -- DONE, TODO: check alliance access
		[60905210] = { criteria = 3762, zone = 20 }, -- Aegwynn and the Dragon Hunt (Brill)
		[60855058] = { criteria = 3767, zone = 20, note = L["Around back"] }, -- Charge of the Dragonflights (Brill)
	},
	["Undercity"] = {
		[67623726] = { criteria = 3768, zone = 382 }, -- Civil War in the Plaguelands
		[61855780] = { criteria = 3770, zone = 382 }, -- Exile of the High Elves
		[56125079] = { criteria = 3771, zone = 382 }, -- Icecrown and the Frozen Throne
		[56205089] = { criteria = 3773, zone = 382 }, -- Kel'thuzad and the Forming of the Scourge
		[56025063] = { criteria = 3794, zone = 382 }, -- The Old Gods and the Ordering of Azeroth
	},
	["Westfall"] = {
		[56503020] = { criteria = 3762, zone = 39 }, -- Aegwynn and the Dragon Hunt (Saldean's Farm)
		[52605310] = { criteria = 3791, zone = 39 }, -- The Last Guardian (Sentinel Hill)
		[56904750] = { criteria = 3795, zone = 39 }, -- The Scourge of Lordaeron (Sentinel Hill)
	},
}

------------------------------------------------------------------------

local pluginHandler = {}

function pluginHandler:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	if self:GetCenter() > UIParent:GetCenter() then
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	mapFile = gsub(mapFile, "_terrain%d+$", "")
	local book = data[mapFile] and data[mapFile][coord]
	if book then
		tooltip:AddLine(ACHIEVEMENT_NAME, 1, 1, 1)
		tooltip:AddLine(GetAchievementCriteriaInfoByID(ACHIEVEMENT_ID, book.criteria), 1, 1, 1)
		
		if book.note then
			tooltip:AddLine(book.note, r, g, b)
		end

		if book.faction and book.faction ~= UnitFactionGroup("player") then
			if book.faction == "Alliance" then
				tooltip:AddLine(format(L["Level %s Alliance area"], "??"), 1, 0.2, 0.2)
			else
				tooltip:AddLine(format(L["Level %s Horde area"], "??"), 1, 0.2, 0.2)
			end
		end
		
		local zone = GetMapNameByID(book.zone)
		local x, y = HandyNotes:getXY(coord)
		tooltip:AddLine(format("%s (%s, %s)", zone, x, y), 0.7, 0.7, 0.7)
		
		if TomTom then
			tooltip:AddLine(L["<Right-Click to set a waypoint in TomTom.>"])
			tooltip:AddLine(L["<Ctrl-Right-Click for additional waypoint options.>"])
		end
		tooltip:Show()
	end
end

function pluginHandler:OnLeave(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	tooltip:Hide()
end

do
	local function setWaypoint(mapFile, coord)
		local book = data[mapFile] and data[mapFile][coord]
		if not book then return end

		local waypoint = book.waypoint
		if waypoint and TomTom:IsValidWaypoint(waypoint) then
			return
		end

		local x, y = HandyNotes:getXY(coord)
		local name = GetAchievementCriteriaInfoByID(ACHIEVEMENT_ID, book.criteria)
		waypoints[coord] = TomTom:AddMFWaypoint(book.zone, nil, x, y, {
			title = name,
			cleardistance = 0, -- don't auto clear
			minimap = true,
			world = true
		})
	end

	local CURRENT_MAP, CURRENT_COORD

	local function setAllWaypoints()
		for mapFile, coords in pairs(data) do
			for coord in pairs(coords) do
				setWaypoint(mapFile, coord)
			end
		end
		local waypoint = data[CURRENT_MAP][CURRENT_COORD].waypoint
		TomTom:SetCrazyArrow(waypoint, TomTom.profile.arrow.arrival, waypoint.title)
	end

	local function setAllZoneWaypoints()
		local coords = data[CURRENT_MAP]
		for coord in pairs(coords) do
			setWaypoint(CURRENT_MAP, coord)
		end
		local waypoint = coords[CURRENT_COORD].waypoint
		TomTom:SetCrazyArrow(waypoint, TomTom.profile.arrow.arrival, waypoint.title)
	end

	local menu = CreateFrame("Frame", "HandyNotesWellReadMenu", nil, "UIDropDownMenuTemplate")
	menu.displayMode = "MENU"
	menu.initialize = function(menu, level)
		if level ~= 1 then return end
		local info = UIDropDownMenu_CreateInfo()

		info.text = L["Set waypoints for..."]
		info.isTitle = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		info.isTitle = nil

		info.text = L["All books in this zone"]
		info.func = setAllZoneWaypoints
		UIDropDownMenu_AddButton(info, level)

		info.text = L["All books everywhere"]
		info.func = setAllWaypoints
		UIDropDownMenu_AddButton(info, level)

		info.text = CANCEL
		info.func = CloseDropDownMenus
		UIDropDownMenu_AddButton(info, level)
	end

	function pluginHandler:OnClick(button, down, mapFile, coord)
		if button ~= "RightButton" or not TomTom then
			return
		end
		if IsCtrlKeyDown() then
			CURRENT_MAP, CURRENT_COORD = mapFile, coord
			ToggleDropDownMenu(1, nil, menu, button, 0, 0)
		else
			mapFile = gsub(mapFile, "_terrain%d+$", "")
			setWaypoint(mapFile, coord)
		end
	end
end

do
	local function iterator(data, prev)
		if not data then return end
		local k, v = next(data, prev)
		while k do
			if v then
				-- coord, mapFile2, iconpath, scale, alpha, level2
				return k, nil, ICON, 1, 1
			end
			k, v = next(data, k)
		end
	end

	function pluginHandler:GetNodes(mapFile, minimap, dungeonLevel)
		mapFile = gsub(mapFile, "_terrain%d+$", "")
		return iterator, data[mapFile]
	end
end

------------------------------------------------------------------------

local Addon = CreateFrame("Frame")
Addon:RegisterEvent("PLAYER_LOGIN")
Addon:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)

function Addon:PLAYER_LOGIN()
	--print("PLAYER_LOGIN")
	local Astrolabe = DongleStub("Astrolabe-1.0")
	for mapFile, coords in pairs(data) do
		local mapID = Astrolabe:GetMapFilename
		for coord, book in pairs(coords) do
		end
	end
	HandyNotes:RegisterPluginDB(ACHIEVEMENT_NAME, pluginHandler)
	self:RegisterEvent("CRITERIA_COMPLETE")
	self:CRITERIA_COMPLETE()
end

function Addon:CRITERIA_COMPLETE(...)
	--print("CRITERIA_COMPLETE", ...)
	local changed
	for mapFile, coords in pairs(data) do
		for coord, book in pairs(coords) do
			local name, _, complete = GetAchievementCriteriaInfoByID(ACHIEVEMENT_ID, book.criteria)
			if complete then
				--print("COMPLETED:", name)
				local waypoint = book.waypoint
				if waypoint and TomTom:IsValidWaypoint(waypoint) then
					TomTomTom:RemoveWaypoint(waypoint)
				end
				coords[coord] = nil
				changed = true
			end
		end
	end
	if changed then
		HandyNotes:SendMessage("HandyNotes_NotifyUpdate", ACHIEVEMENT_NAME)
	end
end
