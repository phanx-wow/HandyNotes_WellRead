--[[--------------------------------------------------------------------
	HandyNotes: Well Read
	Shows the books you still need for the Well Read achievement.
	Copyright (c) 2014-2018 Phanx <addons@phanx.net>. All rights reserved.
	https://www.wowinterface.com/downloads/info-HandyNotes-WellRead.html
	https://www.curseforge.com/wow/addons/handynotes-well-read
	https://github.com/Phanx/HandyNotes_WellRead
----------------------------------------------------------------------]]

local ADDON_NAME = ...
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")

local ACHIEVEMENT_ID = 1244
local ICON = "Interface\\AddOns\\HandyNotes_WellRead\\Book"
local ADDON_TITLE = GetAddOnMetadata(ADDON_NAME, "Title")
local ACHIEVEMENT_NAME = select(2, GetAchievementInfo(ACHIEVEMENT_ID))

local L = setmetatable({}, { __index = function(t, k) t[k] = k return k end })
if GetLocale() == "deDE" then
	-- Main
	L["<Right-Click to set a waypoint in TomTom.>"] = "<Rechtsklick, um eine Zielpunkt in TomTom zu setzen.>"
	L["<Ctrl-Right-Click for additional waypoint options.>"] = "<STRG-Rechtsklick für mehr Zielpunktoptionen.>"
	L["Set waypoints for..."] = "Setz Zielpunkte für..."
	L["Just this book"] = "Nur dieses Büch"
	L["All books in this zone"] = "Alle Bücher in diesem Gebiet"
	L["All books everywhere"] = "Alle Bücher überall"
	L["Unread unique books in: %s"] = "Es gibt ungelesene einzigartige Bücher in: %s"
	-- Notes
	L["Alliance area"] = "Allianzgegend"
	L["Around back"] = "Hinter dem Gebäude"
	L["Bottom level"] = "Im Untergeschoss"
	L["Enter from the north"] = "Vom Norden kommend"
	L["Halfway down, in the Tavern of Time"] = "Halbwegs nach unten, in der Taverne der Zeit"
	L["Ground floor"] = "Im Erdgeschoss"
	L["Horde area"] = "Hordegegend"
	L["On the balcony"] = "Auf dem Balkon"
	L["Second floor"] = "Im ersten Stock" -- ersten vs zweiten ???
	L["Talk to Zidormi for phasing"] = "Sprich mit Zidormi, um die Phase zu wechseln"
	L["Top level"] = "Im Dachgeschoss"
	L["Underground"] = "Unterirdisch"
	L["Unique"] = "Einzigartig"
	L["Upstairs"] = "Nach oben"
elseif GetLocale():match("^es") then
	-- Main
	L["<Right-Click to set a waypoint in TomTom.>"] = "<Clic derecho para establecer un waypoint en TomTom.>"
	L["<Ctrl-Right-Click for additional waypoint options.>"] = "<Ctrl-clic derecho para más opciones de waypoints.>"
	L["Set waypoints for..."] = "Establecer waypoints para..."
	L["Just this book"] = "Sólo este libro"
	L["All books in this zone"] = "Todos libros en esta zona"
	L["All books everywhere"] = "Todos libros en todas zonas"
	L["Unread unique books in: %s"] = "Hay libros únicos no leídos en: %s"
	-- Notes
	L["Alliance area"] = "Zona de la Alianza"
	L["Around back"] = "Por detrás"
	L["Bottom level"] = "En el piso inferior"
	L["Enter from the north"] = "Ingresa desde el norte"
	L["Halfway down, in the Tavern of Time"] = "A mitad de la bajada, en la Taberna del Tiempo"
	L["Ground floor"] = "En la planta baja"
	L["Horde area"] = "Zona de la Horda"
	L["On the balcony"] = "En el balcón"
	L["Second floor"] = "En el segundo piso"
	L["Talk to Zidormi for phasing"] = "Habla con Zidormi para cambiar la fase"
	L["Top level"] = "En el último piso"
	L["Underground"] = "Subterráneo"
	L["Unique"] = "Único"
	L["Upstairs"] = "Arriba"
end

local data = {
	-- Ashenvale
	[63] = {
		[34834972] = { criteria = 3767, faction = "Alliance", note = L["Upstairs"] }, -- Charge of the Dragonflights (Astranaar)
		[34534947] = { criteria = 3780, faction = "Alliance", note = L["Ground level"] }, -- Sargeras and the Betrayal (Astranaar)
		[34475001] = { criteria = 3781, faction = "Alliance", note = L["Ground level"] }, -- Sunwell - The Fall of Quel'Thalas (Astranaar)
		[34834982] = { criteria = 3795, faction = "Alliance", note = L["Upstairs"] }, -- The Scourge of Lordaeron (Astranaar)
	},
	-- Arathi Highlands
	[14] = {
		[69233317] = { criteria = 3778, faction = "Horde", note = L["Upstairs"] }, -- Rise of the Blood Elves (Hammerfall)
		[69343288] = { criteria = 3780, faction = "Horde" }, -- Sargeras and the Betrayal (Hammerfall)
	},
	-- Blackrock Depths
	[243] = {
		[55247001] = { criteria = 3772 }, -- Ironforge - the Awakening of the Dwarves
		[58616807] = { criteria = 3794 }, -- The Old Gods and the Ordering of Azeroth
		[58787282] = { criteria = 3802 }, -- War of the Three Hammers
	},
	-- Blasted Lands
	[17] = {
		[60141344] = { criteria = 3763, faction = "Alliance", note = L["Upstairs"] .. "\n" .. L["Talk to Zidormi for phasing"] }, -- Aftermath of the Second War (Nethergarde Keep)
		[60922022] = { criteria = 3766, faction = "Alliance", note = L["Upstairs"] .. "\n" .. L["Talk to Zidormi for phasing"] }, -- Beyond the Dark Portal (Nethergarde Keep)
		[62401604] = { criteria = 3786, faction = "Alliance", note = L["Top level"] .. "\n" .. L["Talk to Zidormi for phasing"] }, -- The Dark Portal and the Fall of Stormwind (Nethergarde Keep)
	},
	-- The Cape of Stranglethorn
	[210] = {
		[40597380] = { criteria = 3766, note = L["Top level"] }, -- Beyond the Dark Portal (Booty Bay)
		[42107376] = { criteria = 3769, note = L["Bottom level"] }, -- Empires' Fall (Booty Bay)
		[41007450] = { criteria = 3781 }, -- Sunwell - The Fall of Quel'Thalas (Booty Bay)
		[41047444] = { criteria = 3795, note = L["Second floor"] }, -- The Scourge of Lordaeron (Booty Bay)
		[42217363] = { criteria = 3796, note = L["Top level"] }, -- The Sentinels and the Long Vigil (Booty Bay)
		[42097377] = { criteria = 3798, note = L["Bottom level"] }, -- The Twin Empires (Booty Bay)
		[42067380] = { criteria = 3803, note = L["Bottom level"] }, -- Wrath of the Soulflayer (Booty Bay)
	},
	--[[
	["Dalaran"] = {
		[37103590] = { criteria = 3788, zone = 504 }, -- The Guardians of Tirisfal
	},
	]]
	-- Darnassus
	[89] = {
		[54253113] = { criteria = 3763, faction = "Alliance", note = L["Ground floor"] }, -- Aftermath of the Second War
		[39623986] = { criteria = 3770, faction = "Alliance", note = L["Underground"] }, -- Exile of the High Elves
		[49923352] = { criteria = 3778, faction = "Alliance", note = L["Ground floor"] }, -- Rise of the Blood Elves
		[61877467] = { criteria = 3784, faction = "Alliance", note = L["Ground floor"] }, -- The Betrayer Ascendant
		[54233867] = { criteria = 3794, faction = "Alliance", note = L["Upstairs"] }, -- The Old Gods and the Ordering of Azeroth
		[49913310] = { criteria = 3799, faction = "Alliance", note = L["Upstairs"] }, -- The War of the Ancients
		[54832476] = { criteria = 3800, faction = "Alliance", note = L["Ground floor"] }, -- The World Tree and the Emerald Dream
	},
	-- Desolace
	[66] = {
		[66290769] = { criteria = 3765, faction = "Alliance" }, -- Archimonde's Return and the Flight to Kalimdor
	},
	-- Dun Morogh
	[27] = {
		[54745031] = { criteria = 3782, faction = "Alliance" }, -- The Alliance of Lordaeron (Kharanos)
	},
	-- Durotar
	[1] = {
		[59605820] = { criteria = 3779 }, -- Rise of the Horde (Tiragarde Keep)
	},
	-- Duskwood
	[47] = {
		[74094536] = { criteria = 3774, faction = "Alliance", note = L["Upstairs"] }, -- Kil'jaeden and the Shadow Pact (Darkshire)
		[73664450] = { criteria = 3776, faction = "Alliance", note = L["Upstairs"] }, -- Mount Hyjal and Illidan's Gift (Darkshire)
		[72124801] = { criteria = 3782, faction = "Alliance" }, -- The Alliance of Lordaeron (Darkshire)
		[72104639] = { criteria = 3785, faction = "Alliance" }, -- The Birth of the Lich King (Darkshire)
		[73624507] = { criteria = 3787, faction = "Alliance", note = L["Upstairs"], unique = true }, -- The Founding of Quel'Thalas (Darkshire)
	},
	-- Elwynn Forest
	[37] = {
		[38394427] = { criteria = 3768, faction = "Alliance", note = L["Ground floor"] }, -- Civil War in the Plaguelands (Northshire)
		[43786574] = { criteria = 3771, faction = "Alliance", note = L["Upstairs"] }, -- Icecrown and the Frozen Throne (Goldshire)
		[85296975] = { criteria = 3775, faction = "Alliance", note = L["Upstairs"] }, -- Lethargy of the Orcs (Eastvale Logging Camp)
	},
	-- Feralas
	[69] = {
		[30904282] = { criteria = 3796 }, -- The Sentinels and the Long Vigil (Ruins of Feathermoon)
	},
	-- Hillsbrad Foothills
	[25] = {
		[56714754] = { criteria = 3764, faction = "Horde" }, -- Arathor and the Troll Wars (Tarren Mill)
		[56614754] = { criteria = 3773, faction = "Horde" }, -- Kel'thuzad and the Forming of the Scourge (Tarren Mill)
		[57414538] = { criteria = 3768, faction = "Horde", note = L["Around back"] }, -- Civil War in the Plaguelands (Tarren Mill)
		[57194547] = { criteria = 3782, faction = "Horde", note = L["On the balcony"] }, -- The Alliance of Lordaeron (Tarren Mill)
		[58004607] = { criteria = 3785, faction = "Horde" }, -- The Birth of the Lich King (Tarren Mill)
	},
	-- Ironforge
	[87] = {
		[77040917] = { criteria = 3764, faction = "Alliance" }, -- Arathor and the Troll Wars
		[76111051] = { criteria = 3767, faction = "Alliance" }, -- Charge of the Dragonflights
		[76821278] = { criteria = 3768, faction = "Alliance" }, -- Civil War in the Plaguelands
		[74790911] = { criteria = 3772, faction = "Alliance" }, -- Ironforge - the Awakening of the Dwarves
		[77041286] = { criteria = 3779, faction = "Alliance" }, -- Rise of the Horde
		[77061239] = { criteria = 3782, faction = "Alliance" }, -- The Alliance of Lordaeron
		[75711089] = { criteria = 3783, faction = "Alliance" }, -- The Battle of Grim Batol
		[76081077] = { criteria = 3794, faction = "Alliance" }, -- The Old Gods and the Ordering of Azeroth
		[74990898] = { criteria = 3802, faction = "Alliance" }, -- War of the Three Hammers
	},
	-- Loch Modan
	[48] = {
		[35464901] = { criteria = 3772, faction = "Alliance" }, -- Ironforge - the Awakening of the Dwarves (Thelsamar)
		[37204692] = { criteria = 3791, faction = "Alliance", note = L["Downstairs"] }, -- The Last Guardian (Thelsamar)
	},
	-- Mulgore
	[7] = {
		[32634949] = { criteria = 3772 }, -- Ironforge - the Awakening of the Dwarves (Bael'dun Digsite)
		[32584946] = { criteria = 3783 }, -- The Battle of Grim Batol (Bael'dun Digsite)
		[32634944] = { criteria = 3802 }, -- War of the Three Hammers (Bael'dun Digsite)
	},
	-- Northern Barrens
	[10] = {
		[67987354] = { criteria = 3765 }, -- Archimonde's Return and the Flight to Kalimdor (Ratchet)
		[68366909] = { criteria = 3767 }, -- Charge of the Dragonflights (Ratchet)
		[67097336] = { criteria = 3770, note = L["On the balcony"] }, -- Exile of the High Elves (Ratchet)
		[66877465] = { criteria = 3776 }, -- Mount Hyjal and Illidan's Gift (Ratchet)
		[67037501] = { criteria = 3780 }, -- Sargeras and the Betrayal (Ratchet)
	},
	-- Redridge Mountains
	[49] = {
		[26214226] = { criteria = 3786, faction = "Alliance", note = L["Upstairs"] }, -- The Dark Portal and the Fall of Stormwind (Lakeshire)
		[28914128] = { criteria = 3802, faction = "Alliance" }, -- War of the Three Hammers (Lakeshire)
	},
	-- Scholomance
	[477] = {
		[56574115] = { criteria = 3789, unique = true }, -- The Invasion of Draenor (Chamber of Summoning)
	},
	-- Silvermoon City
	[110] = {
		[66837393] = { criteria = 3782, faction = "Horde", note = L["Upstairs"] }, -- The Alliance of Lordaeron
		[68576414] = { criteria = 3784, faction = "Horde" }, -- The Betrayer Ascendant
	},
	-- Southern Barrens
	[199] = {
		[50498689] = { criteria = 3772 }, -- Ironforge - the Awakening of the Dwarves (Bael Modan)
		[65514673] = { criteria = 3775 }, -- Lethargy of the Orcs (Northwatch Hold)
		[65504672] = { criteria = 3793 }, -- The New Horde (Northwatch Hold)
		[50058654] = { criteria = 3802, note = L["Downstairs"] }, -- War of the Three Hammers (Bael Modan)
	},
	-- Stormwind City
	[84] = {
		[85772369] = { criteria = 3762, faction = "Alliance" }, -- Aegwynn and the Dragon Hunt
		[85112617] = { criteria = 3763, faction = "Alliance" }, -- Aftermath of the Second War
		[51937458] = { criteria = 3765, faction = "Alliance", note = L["Enter from the north"] }, -- Archimonde's Return and the Flight to Kalimdor
		[84612448] = { criteria = 3766, faction = "Alliance" }, -- Beyond the Dark Portal
		[84832353] = { criteria = 3768, faction = "Alliance" }, -- Civil War in the Plaguelands
		[51867466] = { criteria = 3776, faction = "Alliance", note = L["Enter from the north"] }, -- Mount Hyjal and Illidan's Gift
		[85172628] = { criteria = 3782, faction = "Alliance" }, -- The Alliance of Lordaeron
		[86533611] = { criteria = 3783, faction = "Alliance" }, -- The Battle of Grim Batol
		[87103600] = { criteria = 3786, faction = "Alliance" }, -- The Dark Portal and the Fall of Stormwind
		[85052626] = { criteria = 3788, faction = "Alliance" }, -- The Guardians of Tirisfal
		[84632592] = { criteria = 3790, faction = "Alliance" }, -- The Kaldorei and the Well of Eternity
		[86122546] = { criteria = 3793, faction = "Alliance" }, -- The New Horde
		[85322329] = { criteria = 3799, faction = "Alliance" }, -- The War of the Ancients
		[85372332] = { criteria = 3800, faction = "Alliance" }, -- The World Tree and the Emerald Dream
		[86723588] = { criteria = 3801, faction = "Alliance" }, -- War of the Spider
		[66794345] = { criteria = 3802, faction = "Alliance" }, -- War of the Three Hammers
	},
	-- Stratholme
	[317] = {
		[26117079] = { criteria = 3768 }, -- Civil War in the Plaguelands
		[25977172] = { criteria = 3771 }, -- Icecrown and the Frozen Throne
		[25096990] = { criteria = 3773 }, -- Kel'thuzad and the Forming of the Scourge
		[30334121] = { criteria = 3774 }, -- Kil'jaeden and the Shadow Pact
		[25197015] = { criteria = 3785 }, -- The Birth of the Lich King
		[24977001] = { criteria = 3792, unique = true }, -- The Lich King Triumphant
		[27737456] = { criteria = 3795 }, -- The Scourge of Lordaeron
		[30154148] = { criteria = 3797, unique = true }, -- The Seven Kingdoms
		[25827187] = { criteria = 3801 }, -- War of the Spider
	},
	-- Swamp of Sorrows
	[51] = {
		[49375512] = { criteria = 3779, faction = "Horde", note = L["Upstairs"] }, -- Rise of the Horde (Stonard)
		[49255541] = { criteria = 3786, faction = "Horde" }, -- The Dark Portal and the Fall of Stormwind (Stonard)
		[49225541] = { criteria = 3793, faction = "Horde", note = L["Upstairs"] }, -- The New Horde (Stonard)
	},
	-- Tanaris
	[71] = {
		[52472689] = { criteria = 3769 }, -- Empires' Fall (Gadgetzan)
		[39987686] = { criteria = 3772 }, -- Ironforge - the Awakening of the Dwarves (Valley of the Watchers)
		[50973029] = { criteria = 3777 }, -- Old Hatreds - The Colonization of Kalimdor (Gadgetzan)
		[66554980] = { criteria = 3790, note = L["Halfway down, in the Tavern of Time"] }, -- The Kaldorei and the Well of Eternity (Caverns of Time)
	-- CavernsofTime map not useful since coords are off the art area
	--	[88401481] = { criteria = 3790, zone = 161, note = L["Halfway down, in the Tavern of Time"] }, -- The Kaldorei and the Well of Eternity (Caverns of Time)
		[52492689] = { criteria = 3798 }, -- The Twin Empires (Gadgetzan)
		[52472687] = { criteria = 3803 }, -- Wrath of the Soulflayer (Gadgetzan)
	},
	-- Tirisfal Glades
	[18] = {
		[60905210] = { criteria = 3762, faction = "Horde" }, -- Aegwynn and the Dragon Hunt (Brill)
		[60855058] = { criteria = 3767, faction = "Horde", note = L["Around back"] }, -- Charge of the Dragonflights (Brill)
	},
	-- Undercity
	[90] = {
		[67623726] = { criteria = 3768, faction = "Horde" }, -- Civil War in the Plaguelands
		[61855780] = { criteria = 3770, faction = "Horde" }, -- Exile of the High Elves
		[56125079] = { criteria = 3771, faction = "Horde" }, -- Icecrown and the Frozen Throne
		[56205089] = { criteria = 3773, faction = "Horde" }, -- Kel'thuzad and the Forming of the Scourge
		[56025063] = { criteria = 3794, faction = "Horde" }, -- The Old Gods and the Ordering of Azeroth
	},
	-- Westfall
	[52] = {
		[56463016] = { criteria = 3762, note = L["Upstairs"] }, -- Aegwynn and the Dragon Hunt (Saldean's Farm)
		[52625306] = { criteria = 3791, faction = "Alliance" }, -- The Last Guardian (Sentinel Hill)
		[56924747] = { criteria = 3795, faction = "Alliance" }, -- The Scourge of Lordaeron (Sentinel Hill)
	},
}

------------------------------------------------------------------------

local pluginHandler = {}

function pluginHandler:OnEnter(mapID, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	if self:GetCenter() > UIParent:GetCenter() then
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	local book = data[mapID] and data[mapID][coord]
	if book then
		tooltip:AddLine(book.name)
		tooltip:AddLine(ACHIEVEMENT_NAME)

		if book.note then
			tooltip:AddLine(book.note, 1, 1, 1)
		end

		if book.faction and book.faction ~= UnitFactionGroup("player") then
			if book.faction == "Alliance" then
				tooltip:AddLine(L["Alliance area"], 1, 0.2, 0.2)
			else
				tooltip:AddLine(L["Horde area"], 1, 0.2, 0.2)
			end
		end

		local zoneName = C_Map.GetMapInfo(mapID).name
		local x, y = HandyNotes:getXY(coord)
		tooltip:AddLine(format("%s (%s, %s)", zoneName, x * 100, y * 100), 0.7, 0.7, 0.7)

		if TomTom and not Minimap:IsMouseOver() then -- can't right-click on the minimap?
			tooltip:AddLine(L["<Right-Click to set a waypoint in TomTom.>"])
			tooltip:AddLine(L["<Ctrl-Right-Click for additional waypoint options.>"])
		end

		tooltip:Show()
	end
end

function pluginHandler:OnLeave(mapID, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
	tooltip:Hide()
end

------------------------------------------------------------------------

if TomTom then
	local function setWaypoint(mapID, coord)
		local book = data[mapID] and data[mapID][coord]
		if not book then return end

		local waypoint = book.waypoint
		if waypoint and TomTom:IsValidWaypoint(waypoint) then
			return
		end

		local x, y = HandyNotes:getXY(coord)
		local name = GetAchievementCriteriaInfoByID(ACHIEVEMENT_ID, book.criteria)
		book.waypoint = TomTom:AddWaypoint(mapID, x, y, {
			title = name,
			cleardistance = 0, -- don't auto clear
			minimap = true,
			world = true
		})
	end

	local CURRENT_MAP, CURRENT_COORD

	local function setThisWaypoint()
		setWaypoint(CURRENT_MAP, CURRENT_COORD)
	end

	local function setAllZoneWaypoints()
		local coords = data[CURRENT_MAP]
		for coord, book in pairs(coords) do
			if book.name and not book.read then
				setWaypoint(CURRENT_MAP, coord)
			end
		end
		--local waypoint = coords[CURRENT_COORD].waypoint
		--TomTom:SetCrazyArrow(waypoint, TomTom.profile.arrow.arrival, waypoint.title)
		TomTom:SetClosestWaypoint()
	end

	local function setAllWaypoints()
		local uniqueZones = {}
		for mapID, coords in pairs(data) do
			for coord, book in pairs(coords) do
				if book.name and not book.read then
					setWaypoint(mapID, coord)
					if book.unique then
						local zoneName = C_Map.GetMapInfo(mapID).name
						if not uniqueZones[zoneName] then
							tinsert(uniqueZones, zoneName)
							uniqueZones[zoneName] = true
						end
					end
				end
			end
		end
		if #uniqueZones > 0 then
			sort(uniqueZones)
			DEFAULT_CHAT_FRAME:AddMessage("|cff00ddba"..ACHIEVEMENT_NAME..":|r "..format(L["Unread unique books in: %s"], table.concat(uniqueZones, ", ")))
		end
		--local waypoint = data[CURRENT_MAP][CURRENT_COORD].waypoint
		--TomTom:SetCrazyArrow(waypoint, TomTom.profile.arrow.arrival, waypoint.title)
		TomTom:SetClosestWaypoint()
	end

	local slashState
	SLASH_HNWELLREAD1 = "/wellread"
	SLASH_HNWELLREAD2 = "/" .. strlower(gsub(ACHIEVEMENT_NAME, "%s", ""))
	SlashCmdList.HNWELLREAD = function()
		if slashState then
			for mapID, coords in pairs(data) do
				for coord, book in pairs(coords) do
					local waypoint = book.waypoint
					if waypoint and TomTom:IsValidWaypoint(waypoint) then
						TomTom:RemoveWaypoint(waypoint)
					end
					book.waypoint = nil
				end
			end
			slashState = nil
			--print("unset")
		else
			setAllWaypoints()
			slashState = true
			--print("set")
		end
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

		info.disabled = nil -- isTitle also sets disabled
		info.isTitle = nil

		info.text = L["Just this book"]
		info.func = setWaypoint
		UIDropDownMenu_AddButton(info, level)

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

	function pluginHandler:OnClick(button, down, mapID, coord)
		if down or button ~= "RightButton" then
			return
		end
		if IsControlKeyDown() then
			CURRENT_MAP, CURRENT_COORD = mapID, coord
			ToggleDropDownMenu(1, nil, menu, self, 0, 0)
		else
			setWaypoint(mapID, coord)
		end
	end
end

------------------------------------------------------------------------

do
	local function iterator(data, prev)
		if not data then return end
		local coord, book = next(data, prev)
		while book do
			if book.name and not book.read then
				-- coord, mapID, iconpath, scale, alpha
				return coord, nil, ICON, 1, 1
			end
			coord, book = next(data, coord)
		end
	end

	function pluginHandler:GetNodes2(mapID, minimap)
		return iterator, data[mapID]
	end
end

------------------------------------------------------------------------

local Addon = CreateFrame("Frame")
Addon:RegisterEvent("PLAYER_LOGIN")
Addon:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)

function Addon:PLAYER_LOGIN()
	--print("PLAYER_LOGIN")
	HandyNotes:RegisterPluginDB(ACHIEVEMENT_NAME, pluginHandler)
	self:RegisterEvent("ITEM_TEXT_BEGIN")
	self:RegisterEvent("ITEM_TEXT_CLOSED")
	self:CRITERIA_UPDATE()
end

function Addon:ITEM_TEXT_BEGIN()
	--print("ITEM_TEXT_BEGIN")
	self:RegisterEvent("CRITERIA_UPDATE")
end

function Addon:ITEM_TEXT_CLOSED()
	--print("ITEM_TEXT_CLOSED")
	self:UnregisterEvent("CRITERIA_UPDATE")
end

function Addon:CRITERIA_UPDATE()
	--print("CRITERIA_UPDATE")
	local changed
	for mapID, coords in pairs(data) do
		for coord, book in pairs(coords) do
			local name, _, complete = GetAchievementCriteriaInfoByID(ACHIEVEMENT_ID, book.criteria)
			if complete then
				if book.name and not book.read then
					--print("COMPLETE:", name)
					changed = true
				end
				local waypoint = book.waypoint
				if waypoint and TomTom:IsValidWaypoint(waypoint) then
					TomTom:RemoveWaypoint(waypoint)
				end
				book.waypoint = nil
				book.read = true
			end
			book.name = name
		end
	end
	if changed then
		--print("CHANGED")
		HandyNotes:SendMessage("HandyNotes_NotifyUpdate", ACHIEVEMENT_NAME)
	end
end
