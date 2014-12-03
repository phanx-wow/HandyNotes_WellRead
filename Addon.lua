--[[--------------------------------------------------------------------
	HandyNotes: Well Read
	Shows the books you still need for the Higher Learning achievement.
	Copyright (c) 2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info23267-HandyNotes-HigherLearning.html
	http://www.curse.com/addons/wow/handynotes-higher-learning
	https://github.com/Phanx/HandyNotes_HigherLearning
----------------------------------------------------------------------]]

local ADDON_NAME = ...
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")

local ACHIEVEMENT_ID = 1956
local ICON = "Interface\\Minimap\\Tracking\\Class"
local ADDON_TITLE = GetAddOnMetadata(ADDON_NAME, "Title")
local ACHIEVEMENT_NAME = select(2, GetAchievementInfo(ACHIEVEMENT_ID))

local L = {
	["<Right-Click to set a waypoint in TomTom.>"] = "<Right-Click to set a waypoint in TomTom.>",
	["<Ctrl-Right-Click for additional waypoint options.>"] = "<Ctrl-Right-Click for additional waypoint options.>",
	["Set waypoints for..."] = "Set waypoints for...",
	["All books in this zone"] = "All books in this zone",
	["All books everywhere"] = "All books everywhere",
}
if GetLocale() == "deDE" then
	L["<Right-Click to set a waypoint in TomTom.>"] = "<Rechtsklick, um eine Zielpunkt in TomTom zu setzen.>"
	L["<Ctrl-Right-Click for additional waypoint options.>"] = "<STRG-Rechtsklick für mehr Zielpunksoptionen.>",
	["Set waypoints for..."] = "Setz Zielpunkte für...",
	["All books in this zone"] = "Alle Bücher in diesem Gebiet",
	["All books everywhere"] = "Alle Bücher überall",
elseif GetLocale():match("^es") then
	L["<Right-Click to set a waypoint in TomTom.>"] = "<Clic derecho para establecer un waypoint en TomTom.>"
	L["<Ctrl-Right-Click for additional waypoint options.>"] = "<Ctrl-clic derecho para más opciones de waypoints.>",
	["Set waypoints for..."] = "Establecer waypoints para...",
	["All books in this zone"] = "Todos libros en esta zona",
	["All books everywhere"] = "Todos libros en todas zonas",
end

local books = {
	[""] = {
		[66907460] = { criteria = 3776, zone = 11 }, -- Mount Hyjal and Illidan's Gift (Ratchet, Northern Barrens)
		[67007500] = { criteria = 3780, zone = 11 }, -- Sargeras and the Betrayal (Ratchet, Northern Barrens)
		[67107340] = { criteria = 3770, zone = 11 }, -- Exile of the High Elves (Ratchet, Northern Barrens)
		[68007350] = { criteria = 3765, zone = 11 }, -- Archimonde's Return and the Flight to Kalimdor (Ratchet, Northern Barrens)
		[68406910] = { criteria = 3767, zone = 11 }, -- Charge of the Dragonflights (Ratchet, Northern Barrens)
	},
	[""] = {
		[69203310] = { criteria = 3778, zone = 16 }, -- Rise of the Blood Elves (Hammerfall, Arathi Highlands)
	},
	[""] = {
		[51003020] = { criteria = 3777, zone = 161 }, -- Old Hatreds - The Colonization of Kalimdor (Gadgetzan, Tanaris)
		[52602780] = { criteria = 3769, zone = 161 }, -- Empires' Fall (Gadgetzan, Tanaris)
		[52602780] = { criteria = 3798, zone = 161 }, -- The Twin Empires (Gadgetzan, Tanaris)
		[52602780] = { criteria = 3803, zone = 161 }, -- Wrath of the Soulflayer (Gadgetzan, Tanaris)
		[67304980] = { criteria = 3790, zone = 161 }, -- The Kaldorei and the Well of Eternity (Caverns of Time, Tanaris)
	},
	[""] = {
		[60905210] = { criteria = 3762, zone = 20 }, -- Aegwynn and the Dragon Hunt (Brill, Tirisfal Glades)
	},
	[""] = {
		[56704750] = { criteria = 3764, zone = 24 }, -- Arathor and the Troll Wars (Tarren Mill, Hillsbrad Foothills)
		[56704750] = { criteria = 3773, zone = 24 }, -- Kel'thuzad and the Forming of the Scourge (Tarren Mill, Hillsbrad Foothills)
		[57404540] = { criteria = 3768, zone = 24 }, -- Civil War in the Plaguelands (Tarren Mill, Hillsbrad Foothills)
		[58004610] = { criteria = 3785, zone = 24 }, -- The Birth of the Lich King (Tarren Mill, Hillsbrad Foothills)
	},
	[""] = {
		[85002300] = { criteria = 3763, zone = 301 }, -- Aftermath of the Second War (Stormwind City)
		[85002300] = { criteria = 3788, zone = 301 }, -- The Guardians of Tirisfal (Stormwind City)
		[85002300] = { criteria = 3799, zone = 301 }, -- The War of the Ancients (Stormwind City)
		[85002300] = { criteria = 3800, zone = 301 }, -- The World Tree and the Emerald Dream (Stormwind City)
	},
	[""] = {
		[73604510] = { criteria = 3787, zone = 34 }, -- The Founding of Quel'Thalas (Darkshire, Duskwood)
		[74104540] = { criteria = 3774, zone = 34 }, -- Kil'jaeden and the Shadow Pact (Darkshire, Duskwood)
	},
	[""] = {
		[49305540] = { criteria = 3786, zone = 38 }, -- The Dark Portal and the Fall of Stormwind (Stonard, Swamp of Sorrows)
		[49405510] = { criteria = 3779, zone = 38 }, -- Rise of the Horde (Stonard, Swamp of Sorrows)
		[49405510] = { criteria = 3793, zone = 38 }, -- The New Horde (Northwatch Hold, Southern Barrens)
	},
	[""] = {
		[56105070] = { criteria = 3771, zone = 382 }, -- Icecrown and the Frozen Throne (Undercity)
		[56105070] = { criteria = 3794, zone = 382 }, -- The Old Gods and the Ordering of Azeroth (Undercity)
	},
	[""] = {
		[52605310] = { criteria = 3791, zone = 39 }, -- The Last Guardian (Sentinel Hill, Westfall)
	},
	[""] = {
		[58706420] = { criteria = 3784, zone = 480 }, -- The Betrayer Ascendant (Silvermoon City)
		[66807390] = { criteria = 3782, zone = 480 }, -- The Alliance of Lordaeron (Silvermoon City)
	},
	[""] = {
		[65504670] = { criteria = 3775, zone = 607 }, -- Lethargy of the Orcs (Northwatch Hold, Southern Barrens)
	},
	[""] = {
		[40607380] = { criteria = 3766, zone = 673 }, -- Beyond the Dark Portal (Booty Bay, Cape of Stranglethorn)
		[41007440] = { criteria = 3781, zone = 673 }, -- Sunwell - The Fall of Quel'Thalas (Booty Bay, Cape of Stranglethorn)
		[41907350] = { criteria = 3795, zone = 673 }, -- The Scourge of Lordaeron (Booty Bay, Cape of Stranglethorn)
		[42207360] = { criteria = 3796, zone = 673 }, -- The Sentinels and the Long Vigil (Booty Bay, Cape of Stranglethorn)
	},
	[""] = {
		[25507090] = { criteria = 3792, zone = 765 }, -- The Lich King Triumpant (Stratholme)
		[25507090] = { criteria = 3801, zone = 765 }, -- War of the Spider (Stratholme)
		[30304120] = { criteria = 3797, zone = 765 }, -- The Seven Kingdoms (Stratholme)
	},
	[""] = {
		[32704950] = { criteria = 3772, zone = 9 }, -- Ironforge - the Awakening of the Dwarves (Bael'dun Digsite, Mulgore)
		[32704950] = { criteria = 3783, zone = 9 }, -- The Battle of Grim Batol (Bael'dun Digsite, Mulgore)
		[32704950] = { criteria = 3802, zone = 9 }, -- War of the Three Hammers (Bael'dun Digsite, Mulgore)
	},
	[""] = {
		[56004150] = { criteria = 3789, zone = 98 }, -- The Invasion of Draenor (Scholomance)
	}
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
	local book = books[mapFile] and books[mapFile][coord]
	if book then
		tooltip:AddLine(ACHIEVEMENT_NAME, 1, 1, 1)
		tooltip:AddLine(GetAchievementCriteriaInfoByID(ACHIEVEMENT_ID, book.criteria), 1, 1, 1)
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
		local book = books[mapFile] and books[mapFile][coord]
		if not book then return end

		local waypoint = book.waypoint
		if waypoint and TomTom:IsValidWaypoint(waypoint) then
			return
		end

		local x, y = HandyNotes:getXY(coord)
		local name = GetAchievementCriteriaInfoByID(ACHIEVEMENT_ID, book.criteria)
		waypoints[coord] = TomTom:AddMFWaypoint(book.zone, nil, x, y, {
			title = name,
			persistent = nil,
			minimap = true,
			world = true
		})
	end

	function pluginHandler:OnClick(button, down, mapFile, coord)
		if button ~= "RightButton" or not TomTom then
			return
		end
		if IsCtrlKeyDown() then
			--[[ TODO open menu
			for map, coords in pairs(books) do
				for coord in pairs(books) do
					setWaypoint(coord)
				end
			end
			local data = waypoints[coord]
			TomTom:SetCrazyArrow(data, TomTom.profile.arrow.arrival, data.title)
			]]
		else
			setWaypoint(mapFile, coord)
		end
	end
end

do
	local function iterator(books, prev)
		if not books then return end
		local k, v = next(books, prev)
		while k do
			if v then
				-- coord, mapFile2, iconpath, scale, alpha, level2
				return k, nil, ICON, 1, 1
			end
			k, v = next(books, k)
		end
	end

	function pluginHandler:GetNodes(mapFile, minimap, dungeonLevel)
		mapFile = gsub(mapFile, "_terrain%d+$", "")
		return iterator, books[mapFile]
	end
end

------------------------------------------------------------------------

local Addon = CreateFrame("Frame")
Addon:RegisterEvent("PLAYER_LOGIN")
Addon:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)

function Addon:PLAYER_LOGIN()
	--print("PLAYER_LOGIN")
	HandyNotes:RegisterPluginDB(ACHIEVEMENT_NAME, pluginHandler)
	self:RegisterEvent("CRITERIA_COMPLETE")
	self:CRITERIA_COMPLETE()
end

function Addon:CRITERIA_COMPLETE(...)
	--print("CRITERIA_COMPLETE", ...)
	local changed
	for map, coords in pairs(books) do
		for coord, book in pairs(coords) do
			local name, _, complete = GetAchievementCriteriaInfoByID(ACHIEVEMENT_ID, book.criteria)
			if complete then
				--print("COMPLETED:", name)
				local waypoint = book.waypoint
				if waypoint and TomTom:IsValidWaypoint(waypoint) then
					TomTomTom:RemoveWaypoint(waypoints[criteriaID])
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
