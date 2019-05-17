local uc_units = {
	["chs_archaon"] = {
		"chs_swordmaster",
		"wh_dlc01_chs_inf_chaos_warriors_2",
		"wh_main_chs_inf_chaos_warriors_0",
		"Cult_Swords",
		"Cult_Swords",
		"Cult_Swords",
		"Cult_Swords",
		"wh_main_chs_cav_chaos_knights_0",
		"Cult_Riders",
		"Cult_Riders",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_mon_chaos_spawn"
	},
	["chs_kholek_suneater"] = {
		"Norse_Huskarls",
		"Norse_Huskarls",
		"Cult_Swords",
		"Cult_Swords",
		"Cult_Swords",
		"Cult_Swords",
		"Cult_Riders",
		"Cult_Riders",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_dlc01_chs_mon_dragon_ogre",
		"wh_dlc01_chs_mon_dragon_ogre",
		"wh_main_chs_mon_chaos_spawn"
	},
	["chs_prince_sigvald"] = {
		"Blessed",
		"Slaanesh_warriors",
		"Cult_Swords",
		"Cult_Swords",
		"Cult_Swords",
		"Cult_Swords",
		"Cult_Riders",
		"Cult_Riders",
		"Slaanesh_Riders",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_mon_chaos_spawn",
		"Slaanesh_Pleasure_Cannon"
	}
} --:map<string, vector<string>>

local unlocker_units = {
	["chs_archaon"] = {
		"wh_main_chs_inf_chosen_1",
		"wh_dlc01_chs_inf_chaos_warriors_2",
		"wh_pro04_chs_cav_chaos_knights_ror_0",
		"wh_main_chs_inf_chaos_marauders_0",
		"wh_main_chs_inf_chaos_marauders_0",
		"wh_main_chs_inf_chaos_warriors_0",
		"wh_main_chs_inf_chaos_warriors_0",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_cav_marauder_horsemen_0",
		"wh_main_chs_cav_marauder_horsemen_0",
		"wh_main_chs_mon_chaos_spawn"
	},
	["chs_kholek_suneater"] = {
		"wh_main_chs_inf_chaos_warriors_1",
		"wh_dlc01_chs_mon_dragon_ogre",
		"wh_pro04_chs_mon_dragon_ogre_ror_0",
		"wh_main_chs_inf_chaos_marauders_0",
		"wh_main_chs_inf_chaos_marauders_0",
		"wh_main_chs_inf_chaos_warriors_0",
		"wh_main_chs_inf_chaos_warriors_0",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_cav_marauder_horsemen_0",
		"wh_main_chs_cav_marauder_horsemen_0",
		"wh_main_chs_mon_chaos_spawn"
	},
	["chs_prince_sigvald"] = {
		"wh_dlc01_chs_inf_chosen_2",
		"wh_main_chs_inf_chosen_0",
		"wh_pro04_chs_inf_chaos_warriors_ror_0",
		"wh_main_chs_art_hellcannon",
		"wh_main_chs_inf_chaos_marauders_0",
		"wh_main_chs_inf_chaos_warriors_0",
		"wh_main_chs_inf_chaos_warriors_0",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_mon_chaos_warhounds_0",
		"wh_main_chs_cav_marauder_horsemen_0",
		"wh_main_chs_cav_marauder_horsemen_0",
		"wh_main_chs_mon_chaos_spawn"
	}
} --:map<string, vector<string>>

--v function(units: map<string, vector<string>>)
local function editChaosStartingUnits(units)
	local chaosFaction = cm:get_faction("wh_main_chs_chaos")
	if chaosFaction then
		local characterList = chaosFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)		
			if currentChar and units[currentChar:character_subtype_key()] then
				cm:remove_all_units_from_general(currentChar)
				local cqi = currentChar:command_queue_index()
				for _, unit in ipairs(units[currentChar:character_subtype_key()]) do
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), unit)
				end
			end
		end
	end
end

--v function()
local function uc_Brass_Legion_Lock()
	cm:add_event_restricted_building_record_for_faction("_steel_altar_1", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_altar_2", "wh_main_chs_the_brass_legion")

	cm:add_event_restricted_building_record_for_faction("_steel_chaos_warriors_1", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_chaos_warriors_2", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_chaos_warriors_3", "wh_main_chs_the_brass_legion")

	cm:add_event_restricted_building_record_for_faction("_steel_forge_1", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_forge_2", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_forge_3", "wh_main_chs_the_brass_legion")

	cm:add_event_restricted_building_record_for_faction("_steel_khorne_1", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_khorne_2", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_khorne_3", "wh_main_chs_the_brass_legion")

	cm:add_event_restricted_building_record_for_faction("_steel_monsters_1", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_monsters_2", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_monsters_3", "wh_main_chs_the_brass_legion")

	cm:add_event_restricted_building_record_for_faction("_steel_nurgle_1", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_nurgle_2", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_nurgle_3", "wh_main_chs_the_brass_legion")

	cm:add_event_restricted_building_record_for_faction("_steel_rift_1", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_rift_2", "wh_main_chs_the_brass_legion")

	cm:add_event_restricted_building_record_for_faction("_steel_slaanesh_1", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_slaanesh_2", "wh_main_chs_the_brass_legion")

	cm:add_event_restricted_building_record_for_faction("_steel_tzeentch_1", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_tzeentch_2", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_tzeentch_3", "wh_main_chs_the_brass_legion")

	cm:add_event_restricted_building_record_for_faction("_steel_weapons_1", "wh_main_chs_the_brass_legion")
	cm:add_event_restricted_building_record_for_faction("_steel_weapons_2", "wh_main_chs_the_brass_legion")

	--cm:add_event_restricted_building_record_for_faction("wh_main_horde_chaos_dragon_ogres_1", "wh_main_chs_the_brass_legion")
	--cm:add_event_restricted_building_record_for_faction("wh_main_horde_chaos_dragon_ogres_2", "wh_main_chs_the_brass_legion")

	--cm:add_event_restricted_building_record_for_faction("wh_main_horde_chaos_settlement_4", "wh_main_chs_the_brass_legion")
	--cm:add_event_restricted_building_record_for_faction("wh_main_horde_chaos_settlement_5", "wh_main_chs_the_brass_legion")

	cm:add_event_restricted_building_record_for_faction("_steel_main_6", "wh_main_chs_the_brass_legion")	
end

--v function()
local function uc_Brass_Legion_Unlock()
	local brass_keep = cm:get_region("wh_main_hochland_brass_keep")
	if brass_keep:building_exists("wh_main_special_brass_keep_barracks_3") and brass_keep:building_exists("wh_main_special_brass_keep_monsters_3") and brass_keep:building_exists("wh_main_special_brass_keep_worship_3") then
		cm:remove_event_restricted_building_record_for_faction("_steel_altar_1", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_altar_2", "wh_main_chs_the_brass_legion")
	
		cm:remove_event_restricted_building_record_for_faction("_steel_chaos_warriors_1", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_chaos_warriors_2", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_chaos_warriors_3", "wh_main_chs_the_brass_legion")
	
		cm:remove_event_restricted_building_record_for_faction("_steel_forge_1", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_forge_2", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_forge_3", "wh_main_chs_the_brass_legion")
	
		cm:remove_event_restricted_building_record_for_faction("_steel_khorne_1", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_khorne_2", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_khorne_3", "wh_main_chs_the_brass_legion")
	
		cm:remove_event_restricted_building_record_for_faction("_steel_monsters_1", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_monsters_2", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_monsters_3", "wh_main_chs_the_brass_legion")
	
		cm:remove_event_restricted_building_record_for_faction("_steel_nurgle_1", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_nurgle_2", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_nurgle_3", "wh_main_chs_the_brass_legion")
	
		cm:remove_event_restricted_building_record_for_faction("_steel_rift_1", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_rift_2", "wh_main_chs_the_brass_legion")
	
		cm:remove_event_restricted_building_record_for_faction("_steel_slaanesh_1", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_slaanesh_2", "wh_main_chs_the_brass_legion")
	
		cm:remove_event_restricted_building_record_for_faction("_steel_tzeentch_1", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_tzeentch_2", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_tzeentch_3", "wh_main_chs_the_brass_legion")
	
		cm:remove_event_restricted_building_record_for_faction("_steel_weapons_1", "wh_main_chs_the_brass_legion")
		cm:remove_event_restricted_building_record_for_faction("_steel_weapons_2", "wh_main_chs_the_brass_legion")
	
		--cm:remove_event_restricted_building_record_for_faction("wh_main_horde_chaos_dragon_ogres_1", "wh_main_chs_the_brass_legion")
		--cm:remove_event_restricted_building_record_for_faction("wh_main_horde_chaos_dragon_ogres_2", "wh_main_chs_the_brass_legion")
	
		--cm:remove_event_restricted_building_record_for_faction("wh_main_horde_chaos_settlement_4", "wh_main_chs_the_brass_legion")
		--cm:remove_event_restricted_building_record_for_faction("wh_main_horde_chaos_settlement_5", "wh_main_chs_the_brass_legion")

		cm:remove_event_restricted_building_record_for_faction("_steel_main_6", "wh_main_chs_the_brass_legion")
		core:remove_listener("uc_Brass_Keep")
	end
end

core:add_listener(
	"uc_Brass_Keep",
	"BuildingCompleted",
	true,
	function(context) uc_Brass_Legion_Unlock() end,
	true
)

local mcm = _G.mcm

--(mcm) init
--v function()
local function uc_mcm()
	local settings = mcm:register_mod("unlocker_uc", "Ultimate Chaos - Faction Unlocker", "Ultimate Chaos - Faction Unlocker: Options")
	local startingUnits = settings:add_tweaker("starting_units", "Chaos - Starting Units", "Enables Ultimate Chaos or Faction Unlocker Starting units.")
	startingUnits:add_option("uc_units", "Ultimate Chaos", "Enables Ultimate Chaos starting units.")
	startingUnits:add_option("unlocker_units", "Faction Unlocker", "Enables Faction Unlocker starting units.")
	mcm:add_new_game_only_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_unlocker_uc_starting_units_value") == "unlocker_units" then
				editChaosStartingUnits(unlocker_units)
			end
		end
	)
end

function unlocker_uc()
	if cm:is_new_game() then
		uc_Brass_Legion_Lock()
		if cm:get_faction("wh_main_chs_chaos"):is_human() then
			editChaosStartingUnits(uc_units)
			if not not mcm then uc_mcm() end
		end
	end
end