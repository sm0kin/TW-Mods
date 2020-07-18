local new_forces_file = require("script/ovn_tables/new_forces")
local new_forces = new_forces_file["wh2_main_great_vortex"]

local settings_table --:map<string, WHATEVER>
local factions = {}

local function spawn_new_forces()
	local i = 0.1
	for _, data in pairs(new_forces) do
		if data and table_contains(factions, data.faction_key) then
			cm:callback(
				function()
					cm:create_force_with_general(
						data.faction_key,
						data.unit_list,
						data.region_key,
						data.x,
						data.y,
						data.type,
						data.subtype,
						data.name1,
						data.name2,
						data.name3,
						data.name4,
						data.make_faction_leader,
						data.callback
					)
				end,
				i
			)

			i = i + 0.1
		end
	end
end

-- list of CQI's for characters to be murdered
local murdered = {}

local function kill_people()
	for i = 1, #murdered do
		local str = "character_cqi:" .. murdered[i]
		cm:set_character_immortality(str, false)
		cm:kill_character_and_commanded_unit(str, true, false)
	end
end

local function add_cqi_to_murdered_list(cqi)
	murdered[#murdered + 1] = cqi
end

local function apply_diplo_bonuses()
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_brt_thegans_crusaders", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_brt_knights_of_origo", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_brt_knights_of_the_flame", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_dlc09_tmb_followers_of_nagash", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_dlc09_tmb_exiles_of_nehek", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_dlc09_tmb_khemri", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_dlc09_tmb_lybaras", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_emp_sudenburg", -5)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_arb_aswad_scythans", 2)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_arb_flaming_scimitar", 2)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_skv_clan_eshin", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_skv_clan_eshin", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_skv_clan_pestilens", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_skv_clan_pestilens", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_skv_clan_mors", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_skv_clan_mors", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh_main_chs_chaos", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh_main_chs_chaos", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh_main_chs_chaos", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_nor_skeggi", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_nor_skeggi", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_nor_aghol", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_nor_aghol", 6)

	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_brt_thegans_crusaders", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_brt_knights_of_origo", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_brt_knights_of_the_flame", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_followers_of_nagash", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_followers_of_nagash", -5)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_exiles_of_nehek", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_khemri", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_lybaras", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_numas", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_emp_sudenburg", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_arb_caliphate_of_araby", 2)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_skv_clan_eshin", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_skv_clan_eshin", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_skv_clan_pestilens", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_skv_clan_pestilens", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_skv_clan_mors", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_skv_clan_mors", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh_main_chs_chaos", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh_main_chs_chaos", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_nor_skeggi", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_nor_skeggi", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_nor_aghol", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_nor_aghol", 6)

	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_brt_thegans_crusaders", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_brt_knights_of_origo", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_brt_knights_of_the_flame", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_dlc09_tmb_followers_of_nagash", -2)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_dlc09_tmb_exiles_of_nehek", -2)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_dlc09_tmb_khemri", -2)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_dlc09_tmb_lybaras", -2)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_emp_sudenburg", -1)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_skv_clan_eshin", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_skv_clan_eshin", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_skv_clan_pestilens", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_skv_clan_pestilens", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_skv_clan_mors", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_skv_clan_mors", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh_main_chs_chaos", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh_main_chs_chaos", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_nor_skeggi", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_nor_skeggi", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_nor_aghol", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_nor_aghol", 6)

	cm:apply_dilemma_diplomatic_bonus("wh2_main_hef_citadel_of_dusk", "wh2_main_hef_order_of_loremasters", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_dlc11_def_the_blessed_dread", "wh2_main_hef_order_of_loremasters", 1)
end

local function amazon_setup()
	local amazon = cm:get_faction("wh2_main_amz_amazons")
	local amazon_faction_leader_cqi = amazon:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(amazon_faction_leader_cqi)

	if amazon and (amazon:is_human() or not mct or settings_table.amazon and settings_table.enable) then
		cm:transfer_region_to_faction("wh2_main_vor_the_creeping_jungle_tlanxla", "wh2_main_amz_amazons")
		local tlanxla_region = cm:model():world():region_manager():region_by_key("wh2_main_vor_the_creeping_jungle_tlanxla")
		cm:instantly_set_settlement_primary_slot_level(tlanxla_region:settlement(), 2)

		cm:heal_garrison(tlanxla_region:cqi())
		local faction_key = "wh2_main_amz_amazons" -- factions key

		if vfs.exists("script/campaign/mod/amazons_missions.lua") then
			local faction_name = cm:model():world():faction_by_key(faction_key) -- FACTION_SCRIPT_INTERFACE faction

			--local ovn_amz = cm:get_faction("wh2_main_amz_amazons")

			--local unit_key = "chosen_asur_lions" -- String unit_record
			local unit_count = 1 -- card32 count
			local rcp = 20 -- float32 replenishment_chance_percentage
			local max_units = 1 -- int32 max_units
			local murpt = 0.1 -- float32 max_units_replenished_per_turn
			local xp_level = 0 -- card32 xp_level
			local frr = "" -- (may be empty) String faction_restricted_record
			local srr = "" -- (may be empty) String subculture_restricted_record
			local trr = "" -- (may be empty) String tech_restricted_record

			cm:add_unit_to_faction_mercenary_pool(
				faction_name,
				"roy_amz_ror_anakondas_amazons",
				unit_count,
				rcp,
				max_units,
				murpt,
				xp_level,
				frr,
				srr,
				trr,
				true
			)

			cm:create_force_with_general(
				"wh2_main_amz_amazons",
				"roy_amz_inf_warriors,roy_amz_inf_scouts,roy_amz_chs_mon_jungle_hounds,roy_amz_inf_scouts,roy_amz_inf_warriors,roy_amz_inf_eagle_warriors,roy_amz_cav_culchan_riders_ranged",
				"wh2_main_vor_the_creeping_jungle_tlanxla",
				135,
				285,
				"general",
				"roy_amz_penthesilea",
				"names_name_3508823034",
				"",
				"",
				"",
				true,
				function(cqi)
					cm:add_agent_experience("character_cqi:" .. cqi, 2000)
					cm:set_character_immortality("character_cqi:" .. cqi, true)
					cm:set_character_unique("character_cqi:" .. cqi, true)
				end
			)
		else
			cm:create_force_with_general(
				"wh2_main_amz_amazons",
				"lzd_amazon,lzd_amazon,lzd_amazon,jag_amazon,jag_amazon,wh2_main_lzd_mon_carnosaur_0,wh2_main_lzd_cav_cold_ones_feral_0,wh2_main_lzd_cav_cold_ones_feral_0",
				"wh2_main_vor_the_creeping_jungle_tlanxla",
				76,
				160,
				"general",
				"dlc05_wef_glade_lord_fem",
				"names_name_999982307",
				"",
				"",
				"",
				true,
				function(cqi)
					cm:add_agent_experience("character_cqi:" .. cqi, 2000)
					cm:set_character_immortality("character_cqi:" .. cqi, true)
					cm:set_character_unique("character_cqi:" .. cqi, true)
				end
			)
		end

		table.insert(factions, faction_key)
	end
end

local function araby_setup()
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_skv_clan_pestilens", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_skv_clan_mors", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_skv_clan_eshin", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh_main_chs_chaos", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_arb_aswad_scythans", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_arb_flaming_scimitar", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_arb_caliphate_of_araby", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_nor_skeggi", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_nor_aghol", -1)

	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh2_main_brt_knights_of_origo", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh2_main_brt_thegans_crusaders", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh2_main_brt_knights_of_the_flame", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh2_dlc13_emp_the_huntmarshals_expedition", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh2_main_emp_sudenburg", -1)

	-- CALIPHATE OF ARABY
	local flame = cm:get_faction("wh2_main_arb_caliphate_of_araby")
	local flame_faction_leader_cqi = flame:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(flame_faction_leader_cqi)

	if flame and (flame:is_human() or not mct or settings_table.araby and settings_table.enable) then
		cm:teleport_to("faction:wh2_main_brt_thegans_crusaders", 525, 335, true)

		local martek_region = cm:model():world():region_manager():region_by_key("wh2_main_vor_coast_of_araby_martek")
		cm:instantly_set_settlement_primary_slot_level(martek_region:settlement(), 3)

		cm:transfer_region_to_faction("wh2_main_vor_coast_of_araby_al_haikk", "wh2_main_arb_caliphate_of_araby")
		cm:heal_garrison(cm:get_region("wh2_main_vor_coast_of_araby_al_haikk"):cqi())

		--cm:override_building_chain_display("wh_main_BRETONNIA_settlement_major_coast", "wh_main_special_settlement_kislev_empire", "wh2_main_vor_coast_of_araby_al_haikk")

		cm:create_agent("wh2_main_arb_caliphate_of_araby", "wizard", "arb_magician_desert", 560, 325, false)

		local faction_key = "wh2_main_arb_caliphate_of_araby" -- factions key
		local faction_name = cm:model():world():faction_by_key(faction_key) -- FACTION_SCRIPT_INTERFACE faction

		--local unit_key = "chosen_asur_lions" -- String unit_record
		local unit_count = 1 -- card32 count
		local rcp = 20 -- float32 replenishment_chance_percentage
		local max_units = 1 -- int32 max_units
		local murpt = 0.1 -- float32 max_units_replenished_per_turn
		local xp_level = 0 -- card32 xp_level
		local frr = "" -- (may be empty) String faction_restricted_record
		local srr = "" -- (may be empty) String subculture_restricted_record
		local trr = "" -- (may be empty) String tech_restricted_record
		local units = {
			"ovn_jag_ror",
			"ovn_jez_ror",
			"ovn_bom_ror",
			"ovn_knights_ror",
			"ovn_cat_knights_ror",
			"ovn_elephant_ror",
			"ovn_arb_mon_war_elephant_ror"
		}
		
		for _, unit in ipairs(units) do
			cm:add_unit_to_faction_mercenary_pool(
				faction_name,
				unit,
				unit_count,
				rcp,
				max_units,
				murpt,
				xp_level,
				frr,
				srr,
				trr,
				true
			)
		end

		table.insert(factions, faction_key)
	end

	--------------------------------------------------------------
	----------------------- SCYTHANS -----------------------------
	--------------------------------------------------------------

	local scythans = cm:get_faction("wh2_main_arb_aswad_scythans")
	local scythans_faction_leader_cqi = scythans:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(scythans_faction_leader_cqi)

	if scythans and (scythans:is_human() or not mct or settings_table.araby and settings_table.enable) then
		cm:transfer_region_to_faction("wh2_main_vor_ash_river_quatar", "wh2_main_arb_aswad_scythans")

		cm:heal_garrison(cm:get_region("wh2_main_vor_ash_river_quatar"):cqi())

		cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_arb_aswad_scythans", -1)

		cm:force_alliance("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_numas", true)

		local faction_key = "wh2_main_arb_aswad_scythans" -- factions key
		local faction_name = cm:model():world():faction_by_key(faction_key) -- FACTION_SCRIPT_INTERFACE faction

		--local unit_key = "chosen_asur_lions" -- String unit_record
		local unit_count = 1 -- card32 count
		local rcp = 20 -- float32 replenishment_chance_percentage
		local max_units = 1 -- int32 max_units
		local murpt = 0.1 -- float32 max_units_replenished_per_turn
		local xp_level = 0 -- card32 xp_level
		local frr = "" -- (may be empty) String faction_restricted_record
		local srr = "" -- (may be empty) String subculture_restricted_record
		local trr = "" -- (may be empty) String tech_restricted_record
		local units = {
			"ovn_jag_ror",
			"ovn_jez_ror",
			"ovn_bom_ror",
			"ovn_knights_ror",
			"ovn_cat_knights_ror",
			"ovn_elephant_ror",
			"ovn_arb_mon_war_elephant_ror"
		}
		
		for _, unit in ipairs(units) do
			cm:add_unit_to_faction_mercenary_pool(
				faction_name,
				unit,
				unit_count,
				rcp,
				max_units,
				murpt,
				xp_level,
				frr,
				srr,
				trr,
				true
			)
		end

		table.insert(factions, faction_key)
	end

	--------------------------------------------------------------
	-------------- FLAMING SCIMITAR  -----------------------------
	--------------------------------------------------------------

	local scimitar = cm:get_faction("wh2_main_arb_flaming_scimitar")
	local scimitar_faction_leader_cqi = scimitar:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(scimitar_faction_leader_cqi)

	if scimitar and (scimitar:is_human() or not mct or settings_table.araby and settings_table.enable) then
		cm:transfer_region_to_faction("wh2_main_vor_the_vampire_coast_pox_marsh", "wh2_main_arb_flaming_scimitar")

		cm:heal_garrison(cm:get_region("wh2_main_vor_the_vampire_coast_pox_marsh"):cqi())

		cm:teleport_to("faction:wh2_dlc11_cst_vampire_coast", 280, 290, true) -- SO HARKON DOESN'T START RIGHT NEXT TO MAGUS

		local faction_key = "wh2_main_arb_flaming_scimitar" -- factions key
		local faction_name = cm:model():world():faction_by_key(faction_key) -- FACTION_SCRIPT_INTERFACE faction

		--local unit_key = "chosen_asur_lions" -- String unit_record
		local unit_count = 1 -- card32 count
		local rcp = 20 -- float32 replenishment_chance_percentage
		local max_units = 1 -- int32 max_units
		local murpt = 0.1 -- float32 max_units_replenished_per_turn
		local xp_level = 0 -- card32 xp_level
		local frr = "" -- (may be empty) String faction_restricted_record
		local srr = "" -- (may be empty) String subculture_restricted_record
		local trr = "" -- (may be empty) String tech_restricted_record
		local units = {
			"ovn_jag_ror",
			"ovn_jez_ror",
			"ovn_bom_ror",
			"ovn_knights_ror",
			"ovn_cat_knights_ror",
			"ovn_elephant_ror",
			"ovn_arb_mon_war_elephant_ror"
		}
		
		for _, unit in ipairs(units) do
			cm:add_unit_to_faction_mercenary_pool(
				faction_name,
				unit,
				unit_count,
				rcp,
				max_units,
				murpt,
				xp_level,
				frr,
				srr,
				trr,
				true
			)
		end

		table.insert(factions, faction_key)
	end
end

local function silver_setup()
	local silver = cm:get_faction("wh2_dlc11_cst_vampire_coast_rebels")
	local silver_faction_leader_cqi = silver:faction_leader():command_queue_index()

	if silver and (silver:is_human() or not mct or settings_table.silver and settings_table.enable) then
		table.insert(factions, "wh2_dlc11_cst_vampire_coast_rebels")
		add_cqi_to_murdered_list(silver_faction_leader_cqi)
	end
end

local function citadel_setup()
	local dusk = cm:get_faction("wh2_main_hef_citadel_of_dusk")
	local dusk_faction_leader_cqi = dusk:faction_leader():command_queue_index()

	if dusk and (dusk:is_human() or not mct or settings_table.citadel and settings_table.enable) then
		cm:set_character_immortality(cm:char_lookup_str(dusk_faction_leader_cqi), false)
		add_cqi_to_murdered_list(dusk_faction_leader_cqi)

		cm:transfer_region_to_faction("wh2_main_vor_cothique_mistnar", "wh2_main_skv_clan_gnaw")
		cm:heal_garrison(cm:get_region("wh2_main_vor_cothique_mistnar"):cqi())

		cm:create_force(
			"wh2_main_skv_clan_gnaw",
			"wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_poison_wind_globadiers,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrat_spearmen_1",
			"wh2_main_vor_cothique_mistnar",
			415,
			570,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		--local unit_key = "chosen_asur_lions" -- String unit_record
		local unit_count = 1 -- card32 count
		local rcp = 0 -- float32 replenishment_chance_percentage
		local max_units = 5 -- int32 max_units
		local murpt = 0 -- float32 max_units_replenished_per_turn
		local xp_level = 0 -- card32 xp_level
		local frr = "" -- (may be empty) String faction_restricted_record
		local srr = "" -- (may be empty) String subculture_restricted_record
		local trr = "" -- (may be empty) String tech_restricted_record

		cm:add_unit_to_faction_mercenary_pool(dusk, "ovn_hef_inf_archers_fire", 1, 0, 5, 0, xp_level, frr, srr, trr, false)

		table.insert(factions, "wh2_main_hef_citadel_of_dusk")
	end
end

local function albion_setup()
	local albion = cm:get_faction("wh2_main_nor_albion")
	local albion_faction_leader_cqi = albion:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(albion_faction_leader_cqi)

	if albion and (albion:is_human() or not mct or settings_table.albion and settings_table.enable) then
		cm:transfer_region_to_faction("wh2_main_vor_albion_albion", "wh2_main_nor_albion")
		local albion_region = cm:model():world():region_manager():region_by_key("wh2_main_vor_albion_albion")
		cm:instantly_set_settlement_primary_slot_level(albion_region:settlement(), 2)
		cm:heal_garrison(albion_region:cqi())

		cm:force_diplomacy("faction:wh2_main_nor_albion", "all", "all", true, true, true)
		cm:force_religion_factors(
			"wh2_main_vor_albion_albion",
			"wh_main_religion_untainted",
			0.75,
			"wh_main_religion_chaos",
			0.25
		)
		cm:force_declare_war("wh_main_nor_skaeling", "wh2_main_nor_albion", false, false)

		table.insert(factions, "wh2_main_nor_albion")
	end
end

local function grudgebringers_setup()
	local gru = cm:get_faction("wh2_main_emp_grudgebringers")
	local gru_faction_leader_cqi = gru:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(gru_faction_leader_cqi)

	if gru and (gru:is_human() or not mct or settings_table.grudgebringers and settings_table.enable) then
		cm:treasury_mod("wh2_main_emp_grudgebringers", -2500)

		--ADD GRUDGEBRINGER RoR--

		local faction_key = "wh2_main_emp_grudgebringers" -- factions key
		local faction_name = cm:model():world():faction_by_key(faction_key) -- FACTION_SCRIPT_INTERFACE faction
		--local unit_key = "chosen_asur_lions" -- String unit_record
		local unit_count = 1 -- card32 count
		local rcp = 20 -- float32 replenishment_chance_percentage
		local max_units = 1 -- int32 max_units
		local murpt = 0.1 -- float32 max_units_replenished_per_turn
		local xp_level = 0 -- card32 xp_level
		local frr = "" -- (may be empty) String faction_restricted_record
		local srr = "" -- (may be empty) String subculture_restricted_record
		local trr = "" -- (may be empty) String tech_restricted_record
		local units = {
			"ragnar_wolves",
			"grudgebringer_infantry",
			"grudgebringer_cannon",
			"grudgebringer_crossbow",
			"treeman_gnarl_fist",
			"urblab_rotgut_mercenary_ogres",
			"galed_elf_archers"
		}

		cm:add_unit_to_faction_mercenary_pool(
			gru,
			"wh2_dlc13_emp_cav_pistoliers_1_imperial_supply",
			1,
			0,
			5,
			0,
			xp_level,
			frr,
			srr,
			trr,
			true
		)

		for _, unit in ipairs(units) do
			cm:add_unit_to_faction_mercenary_pool(
				gru,
				unit,
				unit_count,
				rcp,
				max_units,
				murpt,
				xp_level,
				frr,
				srr,
				trr,
				true
			)
		end

		-- Diplomacy
		cm:force_grant_military_access("wh_main_emp_empire", "wh2_main_emp_grudgebringers", false)
		cm:force_grant_military_access("wh2_main_emp_grudgebringers", "wh_main_brt_bretonnia", true)
		cm:force_grant_military_access("wh2_main_emp_grudgebringers", "wh_main_brt_carcassonne", false)
		cm:force_grant_military_access("wh_main_brt_bordeleaux", "wh2_main_emp_grudgebringers", true)

		if gru:is_human() then
			cm:transfer_region_to_faction("wh2_main_vor_land_of_the_dead_the_salt_plain", "wh_main_grn_top_knotz")

			local salt_region = cm:model():world():region_manager():region_by_key("wh2_main_vor_land_of_the_dead_the_salt_plain")
			cm:instantly_set_settlement_primary_slot_level(salt_region:settlement(), 2)

			local gazan_region = cm:model():world():region_manager():region_by_key("wh2_main_vor_southern_badlands_gor_gazan")
			cm:instantly_set_settlement_primary_slot_level(gazan_region:settlement(), 2)

			cm:heal_garrison(salt_region:cqi())
			cm:heal_garrison(gazan_region:cqi())
		end

		cm:force_declare_war("wh2_dlc09_tmb_the_sentinels", "wh2_main_emp_grudgebringers", false, false)

		-- give Wulfhart a Halflings lord!
		cm:spawn_character_to_pool(
			"wh2_dlc13_emp_the_huntmarshals_expedition",
			"names_name_999982320",
			"",
			"",
			"",
			18,
			true,
			"general",
			"ovn_hlf_ll",
			false,
			""
		)

		table.insert(factions, faction_key)
	end
end

local function dreadking_setup()
	local dread_king = cm:get_faction("wh2_dlc09_tmb_the_sentinels")
	local dread_king_faction_leader_cqi = dread_king:faction_leader():command_queue_index()


	if dread_king and (dread_king:is_human() or not mct or settings_table.dreadking and settings_table.enable) then
		local galbaraz_region = cm:model():world():region_manager():region_by_key("wh2_main_vor_southern_badlands_galbaraz")
		add_cqi_to_murdered_list(dread_king_faction_leader_cqi)
		if dread_king:is_human() then
			cm:transfer_region_to_faction("wh2_main_vor_land_of_the_dead_zandri", "wh2_main_vmp_necrarch_brotherhood")
			cm:transfer_region_to_faction("wh2_main_vor_southern_badlands_galbaraz", "wh2_main_vmp_necrarch_brotherhood")
			local galbaraz_region = cm:model():world():region_manager():region_by_key("wh2_main_vor_southern_badlands_galbaraz")
			cm:instantly_set_settlement_primary_slot_level(galbaraz_region:settlement(), 3)
			cm:region_slot_instantly_upgrade_building(
				galbaraz_region:settlement():active_secondary_slots():item_at(1),
				"wh2_main_special_galbaraz_mourkain_vmp_1"
			)
			cm:region_slot_instantly_upgrade_building(
				galbaraz_region:settlement():active_secondary_slots():item_at(2),
				"wh_main_vmp_walls_1"
			)
		else
			cm:transfer_region_to_faction("wh2_main_vor_land_of_the_dead_zandri", "wh2_dlc09_tmb_the_sentinels")
			cm:transfer_region_to_faction("wh2_main_vor_southern_badlands_galbaraz", "wh2_dlc09_tmb_the_sentinels")

			cm:instantly_set_settlement_primary_slot_level(galbaraz_region:settlement(), 4)
			cm:region_slot_instantly_upgrade_building(
				galbaraz_region:settlement():active_secondary_slots():item_at(1),
				"wh2_main_special_galbaraz_mourkain_tmb_1"
			)
			cm:region_slot_instantly_upgrade_building(
				galbaraz_region:settlement():active_secondary_slots():item_at(2),
				"wh2_dlc09_tmb_defence_major_2"
			)
		end

		local pyramid_region =
			cm:model():world():region_manager():region_by_key("wh2_main_vor_great_mortis_delta_black_pyramid_of_nagash")
		cm:region_slot_instantly_dismantle_building(pyramid_region:settlement():active_secondary_slots():item_at(0))

		cm:override_building_chain_display(
			"wh_main_SAVAGEORC_settlement_major",
			"wh_main_VAMPIRES_settlement_major",
			"wh2_main_vor_southern_badlands_galbaraz"
		)

		local zandri_region = cm:model():world():region_manager():region_by_key("wh2_main_vor_land_of_the_dead_zandri")
		cm:instantly_set_settlement_primary_slot_level(zandri_region:settlement(), 2)

		cm:heal_garrison(zandri_region:cqi())
		cm:heal_garrison(galbaraz_region:cqi())

		cm:teleport_to("faction:wh_main_grn_top_knotz", 690, 295, true)

		cm:create_agent(
			"wh2_dlc09_tmb_the_sentinels",
			"wizard",
			"vmp_necromancer",
			635,
			280,
			false,
			function(cqi)
				cm:force_add_trait(cm:char_lookup_str(cqi), "grudge_trait_name_dummy_gunther", false)
				cm:replenish_action_points(cm:char_lookup_str(cqi))
				cm:add_agent_experience("faction:wh2_dlc09_tmb_the_sentinels,type:wizard", 2000)
				cm:add_unit_model_overrides("faction:wh2_dlc09_tmb_the_sentinels,type:wizard", "wh_main_art_set_vmp_necromancer_02")
			end
		)

		if not dread_king:is_human() then
			cm:add_agent_experience("faction:wh2_dlc09_tmb_the_sentinels,forename:247259235", 5000)
			cm:instantly_set_settlement_primary_slot_level(pyramid_region:settlement(), 4)
		end

		table.insert(factions, "wh2_dlc09_tmb_the_sentinels")
	end
end

local function new_game_startup()
	if mct then
		local lost_factions_mod = mct:get_mod_by_key("lost_factions")
		settings_table = lost_factions_mod:get_settings() 
		-- lock mct options
		local options_list = {
			"enable",
			"amazon",
			"araby",
			"silver",
			"blood_dragon",
			"citadel",
			"halflings",
			"trollz",
			"treeblood",
			"albion",
			"fimir",
			"grudgebringers",
			"dreadking"
		} --:vector<string>
		for i = 1, #options_list do
			local lost_factions_mod = mct:get_mod_by_key("lost_factions")
			local option = lost_factions_mod:get_option_by_key(options_list[i])
			option:set_read_only(true)
		end
	end
	-- turn off event feeds
	cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
	cm:disable_event_feed_events(true, "wh_event_category_conquest", "", "")
	cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "")
	cm:disable_event_feed_events(true, "wh_event_category_faction", "", "")
	cm:disable_event_feed_events(true, "wh_event_category_provinces", "", "")
	cm:disable_event_feed_events(true, "wh_event_category_world", "", "")
	cm:disable_event_feed_events(true, "wh_event_category_military", "", "")
	cm:disable_event_feed_events(true, "wh_event_category_agent", "", "")
	cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_deaths", "")
	cm:disable_event_feed_events(true, "", "", "character_trait_lost")
	cm:disable_event_feed_events(true, "", "", "character_ancillary_lost")
	cm:disable_event_feed_events(true, "", "", "character_wounded")
	cm:disable_event_feed_events(true, "", "", "character_dies_in_action")

	apply_diplo_bonuses()

	amazon_setup()
	araby_setup()
	silver_setup()
	citadel_setup()
	albion_setup()
	grudgebringers_setup()
	dreadking_setup()

	-- spawn new forces for all da factions
	spawn_new_forces()

	-- kill all of the faction leaders that have to go
	cm:callback(
		function()
			kill_people()
		end,
		2.5
	)

	-- turn on event feeds
	cm:callback(
		function()
			cm:disable_event_feed_events(false, "wh_event_category_character", "", "")
			cm:disable_event_feed_events(false, "wh_event_category_conquest", "", "")
			cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "")
			cm:disable_event_feed_events(false, "wh_event_category_faction", "", "")
			cm:disable_event_feed_events(false, "wh_event_category_provinces", "", "")
			cm:disable_event_feed_events(false, "wh_event_category_world", "", "")
			cm:disable_event_feed_events(false, "wh_event_category_military", "", "")
			cm:disable_event_feed_events(false, "wh_event_category_agent", "", "")
			cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_deaths", "")
			cm:disable_event_feed_events(false, "", "", "character_trait_lost")
			cm:disable_event_feed_events(false, "", "", "character_ancillary_lost")
			cm:disable_event_feed_events(false, "", "", "character_wounded")
			cm:disable_event_feed_events(false, "", "", "character_dies_in_action")
		end,
		5
	)
end

cm:add_first_tick_callback(
	function()
		if cm:is_new_game() then
			if cm:model():campaign_name("wh2_main_great_vortex") then
				local ok, err =
					pcall(
					function()
						new_game_startup()
					end
				)
				if not ok then
					script_error(err)
				end
			end
		end
	end
)