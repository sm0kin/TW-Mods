local new_forces_file = require("script/ovn_tables/new_forces")
local new_forces = new_forces_file["main_warhammer"]

local mct = core:get_static_object("mod_configuration_tool")
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
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh_main_brt_bretonnia", -5)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_brt_thegans_crusaders", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_brt_knights_of_origo", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_brt_knights_of_the_flame", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh_main_brt_carcassonne", -4)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh_main_brt_bordeleaux", -4)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh_main_emp_empire", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_dlc09_tmb_followers_of_nagash", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_dlc09_tmb_exiles_of_nehek", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_dlc09_tmb_khemri", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_dlc09_tmb_lybaras", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_emp_sudenburg", -5)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_arb_aswad_scythans", 2)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_arb_flaming_scimitar", 2)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_caliphate_of_araby", "wh2_main_skv_clan_mors", 6)

	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh_main_brt_bretonnia", -5)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_brt_thegans_crusaders", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_brt_knights_of_origo", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_brt_knights_of_the_flame", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh_main_brt_carcassonne", -5)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh_main_brt_bordeleaux", -5)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh_main_emp_empire", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_followers_of_nagash", -6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_followers_of_nagash", -5)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_exiles_of_nehek", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_khemri", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_lybaras", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_numas", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_emp_sudenburg", -3)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_arb_caliphate_of_araby", 2)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_aswad_scythans", "wh2_main_skv_clan_mors", 6)

	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_skv_clan_pestilens", 6)
	cm:apply_dilemma_diplomatic_bonus("wh2_main_arb_flaming_scimitar", "wh2_main_skv_clan_pestilens", 6)

	cm:apply_dilemma_diplomatic_bonus("wh2_main_hef_citadel_of_dusk", "wh2_main_hef_order_of_loremasters", 6)

	cm:apply_dilemma_diplomatic_bonus("wh2_main_nor_trollz", "wh_main_grn_red_fangs", -6)

	cm:apply_dilemma_diplomatic_bonus("wh_main_emp_empire", "wh2_main_emp_the_moot", 6)
end

--------------------------------------------------------------
------------------------ AMAZONS  ----------------------------
--------------------------------------------------------------

local function amazon_setup()
	local faction_key = "wh2_main_amz_amazons" -- factions key
	local amazon = cm:get_faction(faction_key)
	local amazon_faction_leader_cqi = amazon:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(amazon_faction_leader_cqi)

	if amazon and (amazon:is_human() or not mct or settings_table.amazon and settings_table.enable) then
		-- give Tlanxla to Amazons, do some work for them
		cm:transfer_region_to_faction("wh2_main_the_creeping_jungle_tlanxla", "wh2_main_amz_amazons")
		local tlanxa_region = cm:model():world():region_manager():region_by_key("wh2_main_the_creeping_jungle_tlanxla")
		cm:instantly_set_settlement_primary_slot_level(tlanxa_region:settlement(), 3)
		cm:heal_garrison(tlanxa_region:cqi())
		

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
				"wh2_main_great_desert_of_araby_el-kalabad",
				76,
				160,
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
				"wh2_main_great_desert_of_araby_el-kalabad",
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
	-------- Araby Race (All 3 Factions) Diplomacy Fix ------
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_skv_clan_pestilens", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_skv_clan_mors", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_skv_clan_eshin", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh_main_chs_chaos", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh_dlc08_nor_naglfarlings", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_arb_aswad_scythans", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_arb_flaming_scimitar", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_arb_caliphate_of_araby", -1)
	cm:apply_effect_bundle("sr_arab_bundle", "wh_dlc08_nor_norsca", -1)

	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh_main_brt_bretonnia", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh2_main_brt_knights_of_origo", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh2_main_brt_thegans_crusaders", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh2_main_brt_knights_of_the_flame", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh_main_brt_carcassonne", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh_main_brt_bordeleaux", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh_main_emp_empire", -1)
	cm:apply_effect_bundle("sr_arab_bundle_bad", "wh2_main_emp_sudenburg", -1)

	----------------------Buff Knights of Origo---------------
	--cm:transfer_region_to_faction("wh2_main_atalan_mountains_martek", "wh2_main_brt_knights_of_origo")
	--cm:heal_garrison(cm:get_region("wh2_main_atalan_mountains_martek"):cqi())

	--------------------------------------------------------------
	----------------------- ARABY CALIPHATE-----------------------
	--------------------------------------------------------------

	local flame = cm:get_faction("wh2_main_arb_caliphate_of_araby")
	local flame_faction_leader_cqi = flame:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(flame_faction_leader_cqi)

	if flame and (flame:is_human() or not mct or settings_table.araby and settings_table.enable) then
		cm:create_agent("wh2_main_arb_caliphate_of_araby", "wizard", "arb_magician_desert", 445, 132, false)

		cm:teleport_to("faction:wh2_main_brt_thegans_crusaders", 450, 105, true)

		local martek_region = cm:model():world():region_manager():region_by_key("wh2_main_atalan_mountains_martek")
		cm:instantly_set_settlement_primary_slot_level(martek_region:settlement(), 3)

		local al_haikk_region = cm:get_region("wh2_main_coast_of_araby_al_haikk")
		cm:transfer_region_to_faction("wh2_main_coast_of_araby_al_haikk", "wh2_main_arb_caliphate_of_araby")
		cm:heal_garrison(al_haikk_region:cqi())
		--cm:override_building_chain_display("wh_main_BRETONNIA_settlement_major_coast", "wh_main_special_settlement_kislev", "wh2_main_coast_of_araby_al_haikk")

		local kalabad_region = cm:model():world():region_manager():region_by_key("wh2_main_great_desert_of_araby_el-kalabad")
		cm:transfer_region_to_faction("wh2_main_great_desert_of_araby_el-kalabad", "wh2_main_arb_caliphate_of_araby")
		cm:instantly_set_settlement_primary_slot_level(kalabad_region:settlement(), 2)
		cm:heal_garrison(kalabad_region:cqi())

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
		cm:transfer_region_to_faction("wh2_main_ash_river_quatar", "wh2_main_arb_aswad_scythans")
		cm:transfer_region_to_faction("wh2_main_shifting_sands_ka-sabar", "wh2_main_arb_aswad_scythans")

		cm:heal_garrison(cm:get_region("wh2_main_ash_river_quatar"):cqi())
		cm:heal_garrison(cm:get_region("wh2_main_shifting_sands_ka-sabar"):cqi())

		cm:apply_effect_bundle("sr_arab_bundle", "wh2_main_arb_aswad_scythans", -1)

		cm:teleport_to("faction:wh2_main_vmp_necrarch_brotherhood,forename:2147359170", 675, 65, true)

		cm:force_alliance("wh2_main_arb_aswad_scythans", "wh2_dlc09_tmb_numas", true)

		local faction_key = "wh2_main_arb_aswad_scythans" -- factions key
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
		cm:transfer_region_to_faction("wh2_main_vampire_coast_pox_marsh", "wh2_main_arb_flaming_scimitar")
		--cm:transfer_region_to_faction("wh2_main_great_desert_of_araby_pools_of_despair", "wh2_dlc09_tmb_dune_kingdoms")

		cm:heal_garrison(cm:get_region("wh2_main_vampire_coast_pox_marsh"):cqi())
		--cm:heal_garrison(cm:get_region("wh2_main_great_desert_of_araby_pools_of_despair"):cqi())

		local faction_key = "wh2_main_arb_flaming_scimitar" -- factions key
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
--------------------------------------------------------------
-------------------- SILVER PRINCESS -------------------------
--------------------------------------------------------------

local function silver_setup()
	local silver = cm:get_faction("wh2_dlc11_cst_vampire_coast_rebels")
	local silver_faction_leader_cqi = silver:faction_leader():command_queue_index()

	if silver and (silver:is_human() or not mct or settings_table.silver and settings_table.enable) then
		add_cqi_to_murdered_list(silver_faction_leader_cqi)
		table.insert(factions, "wh2_dlc11_cst_vampire_coast_rebels")
	end
end

--------------------------------------------------------------
--------------------- BLOOD DRAGONS --------------------------
--------------------------------------------------------------

local function blood_dragon_setup()
	local blood_dragons = cm:get_faction("wh_main_vmp_rival_sylvanian_vamps")
	local blood_dragons_leader_cqi = blood_dragons:faction_leader():command_queue_index()

	if blood_dragons and (blood_dragons:is_human() or not mct or settings_table.blood_dragon and settings_table.enable) then
		--add_cqi_to_murdered_list(blood_dragons_leader_cqi)
		cm:set_character_immortality(cm:char_lookup_str(blood_dragons_leader_cqi), false)

		if blood_dragons:is_human() then
			core:add_listener(
				"blood_dragon_missions",
				"FactionTurnStart",
				function(context)
					return context:faction():is_human() and cm:model():turn_number() == 2
				end,
				function(context)
					cm:trigger_mission("wh_main_vmp_rival_sylvanian_vamps", "ovn_blood_dragons_me_take_nuln", true)
					cm:trigger_mission("wh_main_vmp_rival_sylvanian_vamps", "ovn_blood_dragons_me_take_templehof", true)
					cm:trigger_mission("wh_main_vmp_rival_sylvanian_vamps", "ovn_blood_dragons_me_take_altdorf", true)
				end,
				false
			)
		end

		cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_deaths", "")
		--cm:callback(
		--	function()
		--		cm:kill_character(blood_dragons_leader_cqi, true, true)
		--	end,
		--	1
		--)
		cm:callback(
			function()
				cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_deaths", "")
			end,
			1.1
		)

		cm:override_building_chain_display(
			"wh_main_DWARFS_settlement_major",
			"wh_main_VAMPIRES_settlement_major",
			"wh_main_southern_grey_mountains_karak_norn"
		)

		cm:transfer_region_to_faction("wh_main_southern_grey_mountains_karak_norn", "wh_main_vmp_rival_sylvanian_vamps")

		local karaknorn_region = cm:model():world():region_manager():region_by_key("wh_main_southern_grey_mountains_karak_norn")
		local karaknorn_settlement = karaknorn_region:settlement()
		cm:instantly_set_settlement_primary_slot_level(karaknorn_settlement, 2)

		cm:heal_garrison(karaknorn_region:cqi())
		cm:force_religion_factors(
			"wh_main_southern_grey_mountains_karak_norn",
			"wh_main_religion_undeath",
			0.5,
			"wh_main_religion_untainted",
			0.5
		)

		-- KARAK NORN DWARF REHOMING
		if not cm:get_faction("wh_main_dwf_karak_izor"):is_human() then
			cm:transfer_region_to_faction("wh_main_the_vaults_karak_bhufdar", "wh_main_dwf_karak_norn")
			local bhufdar_region = cm:model():world():region_manager():region_by_key("wh_main_the_vaults_karak_bhufdar")
			cm:instantly_set_settlement_primary_slot_level(bhufdar_region:settlement(), 3)
			cm:region_slot_instantly_upgrade_building(
				bhufdar_region:settlement():active_secondary_slots():item_at(2),
				"wh_main_dwf_garrison_2"
			)
			cm:heal_garrison(bhufdar_region:cqi())
			cm:kill_character_and_commanded_unit("faction:wh_main_dwf_karak_norn,surname:2147345835", true, true)
		end

		if not vfs.exists("script/export_helpers_ordo_draconis_why.lua") then
			cm:create_force_with_general(
				"wh_main_vmp_rival_sylvanian_vamps",
				"wh_dlc02_vmp_cav_blood_knights_0,wh_dlc02_vmp_cav_blood_knights_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_1",
				"wh2_main_land_of_assassins_sorcerers_islands",
				510,
				380,
				"general",
				"wh2_dlc11_vmp_bloodline_blood_dragon",
				"names_name_2147345180",
				"",
				"names_name_2147345188",
				"",
				true,
				function(cqi)
					local str = "character_cqi:" .. cqi
					cm:set_character_unique(str, true)
					cm:add_agent_experience(str, 2000)
					cm:force_add_trait(str, "ovn_harkon_lord_trait", true)
				end
			)

			cm:force_declare_war("wh_main_vmp_rival_sylvanian_vamps", "wh_main_emp_wissenland", false, false)
		end

		table.insert(factions, "wh_main_vmp_rival_sylvanian_vamps")
	end
end

--------------------------------------------------------------
------------------- CITADEL OF DUSK --------------------------
--------------------------------------------------------------

local function citadel_setup()
	local dusk = cm:get_faction("wh2_main_hef_citadel_of_dusk")
	local dusk_faction_leader_cqi = dusk:faction_leader():command_queue_index()

	if dusk and (dusk:is_human() or not mct or settings_table.citadel and settings_table.enable) then
		add_cqi_to_murdered_list(dusk_faction_leader_cqi)

		cm:override_building_chain_display(
			"wh2_main_lzd_settlement_minor_coast",
			"wh2_main_hef_settlement_major_coast",
			"wh2_main_headhunters_jungle_mangrove_coast"
		)

		--cm:transfer_region_to_faction("wh2_main_cothique_tor_koruali", "wh2_main_skv_clan_gnaw")
		--cm:heal_garrison(cm:get_region("wh2_main_cothique_tor_koruali"):cqi())

		cm:transfer_region_to_faction("wh2_main_cothique_mistnar", "wh2_main_skv_clan_gnaw")
		cm:heal_garrison(cm:get_region("wh2_main_cothique_mistnar"):cqi())

		if not vfs.exists("script/campaign/mod/sr_vermintide.lua") then
			cm:create_force(
				"wh2_main_skv_clan_gnaw",
				"wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_poison_wind_globadiers,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrat_spearmen_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				290,
				420,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)
		end

		cm:transfer_region_to_faction("wh2_main_headhunters_jungle_mangrove_coast", "wh2_main_hef_citadel_of_dusk")

		local mangrove_region = cm:model():world():region_manager():region_by_key("wh2_main_headhunters_jungle_mangrove_coast")
		cm:instantly_set_settlement_primary_slot_level(mangrove_region:settlement(), 3)
		cm:region_slot_instantly_upgrade_building(
			mangrove_region:settlement():active_secondary_slots():item_at(1),
			"ovn_Citadel_of_dusk"
		)

		cm:heal_garrison(mangrove_region:cqi())

		cm:add_unit_to_faction_mercenary_pool(dusk, "ovn_hef_inf_archers_fire", 1, 0, 5, 0, 0, "", "", "", false)

		table.insert(factions, "wh2_main_hef_citadel_of_dusk")
	end
end

--------------------------------------------------------------
----------------------- HALFLINGS  ---------------------------
--------------------------------------------------------------

local function halflings_setup()
	local moot_string = "wh2_main_emp_the_moot"
	local moot = cm:get_faction(moot_string)
	local moot_faction_leader_cqi = moot:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(moot_faction_leader_cqi)

	if moot and (moot:is_human() or not mct or settings_table.halflings and settings_table.enable) then
		cm:transfer_region_to_faction("wh_main_stirland_the_moot", moot_string)

		local moot_region = cm:model():world():region_manager():region_by_key("wh_main_stirland_the_moot")

		if moot:is_human() then
			cm:instantly_set_settlement_primary_slot_level(moot_region:settlement(), 2)

			cm:treasury_mod("wh2_main_emp_the_moot", -1000)
		else
			cm:instantly_set_settlement_primary_slot_level(moot_region:settlement(), 3)
		end

		cm:heal_garrison(moot_region:cqi())

		if cm:get_faction("wh_main_emp_empire"):is_human() then
			cm:transfer_region_to_faction("wh_main_reikland_helmgart", "wh_dlc08_nor_naglfarlings")
		else
			cm:transfer_region_to_faction("wh_main_reikland_helmgart", "wh_main_emp_empire")
			cm:heal_garrison(cm:get_region("wh_main_reikland_helmgart"):cqi())
		end

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
			"halfling_warfoot",
			"sr_ogre_ror",
			"halfling_cock",
			"wh_main_mtl_veh_soupcart",
			"halfling_cat_ror"
		}
		
		cm:add_unit_to_faction_mercenary_pool(
			moot,
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
				moot,
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

		-- ally with da emprah
		cm:force_alliance("wh2_main_emp_the_moot", "wh_main_emp_empire", true)

		--Halfling Lord for the Empire
		cm:spawn_character_to_pool(
			"wh_main_emp_empire",
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

		table.insert(factions, "wh2_main_emp_the_moot")
	end
end

--------------------------------------------------------------
------------------------- TROLL  -----------------------------
--------------------------------------------------------------

local function trollz_setup()
	local troll_string = "wh2_main_nor_trollz"
	local troll = cm:get_faction("wh2_main_nor_trollz")
	local troll_faction_leader_cqi = troll:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(troll_faction_leader_cqi)

	if troll and (troll:is_human() or not mct or settings_table.trollz and settings_table.enable)then
		add_cqi_to_murdered_list(cm:get_faction("wh2_main_dwf_greybeards_prospectors"):faction_leader():command_queue_index())

		cm:transfer_region_to_faction("wh_main_southern_badlands_agrul_migdhal", "wh2_main_nor_trollz")
		cm:heal_garrison(cm:get_region("wh_main_southern_badlands_agrul_migdhal"):cqi())

		local agrul_region = cm:model():world():region_manager():region_by_key("wh_main_southern_badlands_agrul_migdhal")
		cm:instantly_set_settlement_primary_slot_level(agrul_region:settlement(), 2)

		cm:transfer_region_to_faction("wh2_main_atalan_mountains_eye_of_the_panther", "wh2_main_nor_trollz")
		cm:heal_garrison(cm:get_region("wh2_main_atalan_mountains_eye_of_the_panther"):cqi())

		if not cm:get_faction("wh2_main_nor_trollz"):is_human() then
			cm:transfer_region_to_faction("wh_main_vanaheim_mountains_troll_fjord", "wh2_main_nor_trollz")
			cm:transfer_region_to_faction("wh2_main_misty_hills_wreckers_point", "wh2_main_nor_trollz")
			cm:transfer_region_to_faction("wh_main_rib_peaks_grom_peak", "wh2_main_nor_trollz")
			cm:heal_garrison(cm:get_region("wh_main_vanaheim_mountains_troll_fjord"):cqi())
			cm:heal_garrison(cm:get_region("wh2_main_misty_hills_wreckers_point"):cqi())
			cm:heal_garrison(cm:get_region("wh_main_rib_peaks_grom_peak"):cqi())
		end

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
			"elo_red_avalanche",
			"elo_shipwreckers",
			"elo_kin",
			"elo_night_trolls_ror"
		}
		
		for _, unit in ipairs(units) do
			cm:add_unit_to_faction_mercenary_pool(
				troll,
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

		table.insert(factions, troll_string)
	end
end

--------------------------------------------------------------
----------------------- TREEBLOOD  ---------------------------
--------------------------------------------------------------

local function treeblood_setup()
	local tree = cm:get_faction("wh2_main_wef_treeblood")
	local tree_faction_leader_cqi = tree:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(tree_faction_leader_cqi)

	if tree and (tree:is_human() or not mct or settings_table.treeblood and settings_table.enable) then
		cm:transfer_region_to_faction("wh_main_helspire_mountains_serpent_jetty", "wh2_main_wef_treeblood")
		cm:transfer_region_to_faction("wh_main_the_wasteland_aarnau", "wh2_main_wef_treeblood")
		cm:transfer_region_to_faction("wh2_main_albion_citadel_of_lead", "wh2_main_wef_treeblood")

		local serpent_region = cm:model():world():region_manager():region_by_key("wh_main_helspire_mountains_serpent_jetty")
		cm:instantly_set_settlement_primary_slot_level(serpent_region:settlement(), 2)

		cm:heal_garrison(cm:get_region("wh2_main_albion_citadel_of_lead"):cqi())
		cm:heal_garrison(cm:get_region("wh_main_helspire_mountains_serpent_jetty"):cqi())
		cm:heal_garrison(cm:get_region("wh_main_the_wasteland_aarnau"):cqi())

		local faction_key = "wh2_main_wef_treeblood" -- factions key
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
		local units = {
			"wh_pro04_nor_mon_marauder_warwolves_ror_0",
			"ovn_killing_eye",
			"wh_pro04_nor_mon_fimir_ror_0",
			"ovn_gharnus_demon",
			"wh_pro04_chs_mon_chaos_spawn_ror_0"
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

--------------------------------------------------------------
------------------------- ALBION  ----------------------------
--------------------------------------------------------------

local function albion_setup()
	local albion = cm:get_faction("wh2_main_nor_albion")
	local albion_faction_leader_cqi = albion:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(albion_faction_leader_cqi)

	if albion and (albion:is_human() or not mct or settings_table.albion and settings_table.enable) then
		cm:transfer_region_to_faction("wh2_main_albion_albion", "wh2_main_nor_albion")
		cm:heal_garrison(cm:get_region("wh2_main_albion_albion"):cqi())

		cm:force_religion_factors("wh2_main_albion_albion", "wh_main_religion_untainted", 0.75, "wh_main_religion_chaos", 0.25)
		cm:force_diplomacy("faction:wh2_main_nor_albion", "all", "all", true, true, true)

		local fimir_albion_region = cm:model():world():region_manager():region_by_key("wh2_main_albion_citadel_of_lead")

		if albion:is_human() then
			cm:instantly_set_settlement_primary_slot_level(fimir_albion_region:settlement(), 3)
			cm:force_declare_war("wh_dlc08_nor_naglfarlings", "wh2_main_nor_albion", false, false)

			cm:create_force(
				"wh_dlc08_nor_naglfarlings",
				"wh_main_chs_inf_chaos_warriors_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				333,
				570,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
					cm:disable_movement_for_character("character_cqi:" .. cqi)
				end
			)
		else
			cm:transfer_region_to_faction("wh2_main_albion_isle_of_wights", "wh2_main_nor_albion")
		end

		table.insert(factions, "wh2_main_nor_albion")
	end
end
--------------------------------------------------------------
-------------------------- FIMIR  ----------------------------
--------------------------------------------------------------

local function fimir_setup()
	local fimir = cm:get_faction("wh_dlc08_nor_goromadny_tribe")
	local fimir_faction_leader_cqi = fimir:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(fimir_faction_leader_cqi)

	if fimir and (fimir:is_human() or not mct or settings_table.fimir and settings_table.enable) then
		cm:transfer_region_to_faction("wh2_main_marshes_of_madness_floating_village", "wh_dlc08_nor_goromadny_tribe")
		cm:heal_garrison(cm:get_region("wh2_main_marshes_of_madness_floating_village"):cqi())

		local floating_region =
			cm:model():world():region_manager():region_by_key("wh2_main_marshes_of_madness_floating_village")
		cm:instantly_set_settlement_primary_slot_level(floating_region:settlement(), 2)

		local frozen_region = cm:model():world():region_manager():region_by_key("wh_main_goromandy_mountains_frozen_landing")
		cm:instantly_set_settlement_primary_slot_level(frozen_region:settlement(), 1)

		local baersonlings_region =
			cm:model():world():region_manager():region_by_key("wh_main_goromandy_mountains_baersonlings_camp")
		cm:instantly_set_settlement_primary_slot_level(baersonlings_region:settlement(), 1)
		cm:instantly_set_settlement_primary_slot_level(baersonlings_region:settlement(), 2)

		local faction_key = "wh_dlc08_nor_goromadny_tribe" -- factions key
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
		local units = {
			"wh_pro04_nor_mon_marauder_warwolves_ror_0",
			"ovn_killing_eye",
			"wh_pro04_nor_mon_fimir_ror_0",
			"ovn_gharnus_demon",
			"wh_pro04_chs_mon_chaos_spawn_ror_0"
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

--------------------------------------------------------------
------------------------ STRIGOI  ----------------------------
--------------------------------------------------------------

--[[ local function strygos_setup()
	cm:transfer_region_to_faction("wh_main_southern_badlands_galbaraz", "wh2_main_vmp_strygos_empire")

	cm:override_building_chain_display("wh_main_DWARFS_settlement_major", "wh_main_VAMPIRES_settlement_major", "wh_main_southern_badlands_galbaraz")

	local galbaraz_region = cm:model():world():region_manager():region_by_key("wh_main_southern_badlands_galbaraz")
	local galbaraz_settlement = galbaraz_region:settlement(0)
	cm:instantly_set_settlement_primary_slot_level(galbaraz_settlement, 3)
	cm:region_slot_instantly_upgrade_building(galbaraz_settlement:active_secondary_slots():item_at(1), "wh2_main_special_galbaraz_mourkain_vmp_1")
	cm:region_slot_instantly_upgrade_building(galbaraz_settlement:active_secondary_slots():item_at(2), "wh_main_vmp_walls_1")
		
	cm:heal_garrison(galbaraz_region:cqi())

	cm:teleport_to("faction:wh_main_grn_top_knotz,surname:2147344957", 675, 155, true)
end]]
--------------------------------------------------------------
-------------------- GRUDGEBRINGERS  -------------------------
--------------------------------------------------------------

local function grudgebringers_setup()
	local grudebringers_string = "wh2_main_emp_grudgebringers"
	local gru = cm:get_faction(grudebringers_string)
	local gru_faction_leader_cqi = gru:faction_leader():command_queue_index()

	add_cqi_to_murdered_list(gru_faction_leader_cqi)

	if gru and (gru:is_human() or not mct or settings_table.grudgebringers and settings_table.enable) then
		cm:treasury_mod("wh2_main_emp_grudgebringers", -2000)

		--ADD GRUDGEBRINGER RoR--

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

		cm:force_grant_military_access("wh_main_emp_empire", "wh2_main_emp_grudgebringers", false)
		cm:force_grant_military_access("wh2_main_emp_grudgebringers", "wh_main_brt_bretonnia", true)
		cm:force_grant_military_access("wh2_main_emp_grudgebringers", "wh_main_brt_carcassonne", false)
		cm:force_grant_military_access("wh_main_brt_bordeleaux", "wh2_main_emp_grudgebringers", true)

		table.insert(factions, grudebringers_string)
	end
end

--------------------------------------------------------------
----------------------- DREAD KING  --------------------------
--------------------------------------------------------------

local function dreadking_setup()
	local dread_king = cm:get_faction("wh2_dlc09_tmb_the_sentinels")
	local dread_king_faction_leader_cqi = dread_king:faction_leader():command_queue_index()

	if dread_king and (dread_king:is_human() or not mct or settings_table.dreadking and settings_table.enable) then
		add_cqi_to_murdered_list(dread_king_faction_leader_cqi)

		cm:create_agent(
			"wh2_dlc09_tmb_the_sentinels",
			"wizard",
			"vmp_necromancer",
			590,
			90,
			false,
			function(cqi)
				cm:force_add_trait(cm:char_lookup_str(cqi), "grudge_trait_name_dummy_gunther", false)
				cm:replenish_action_points(cm:char_lookup_str(cqi))
				cm:add_agent_experience("faction:wh2_dlc09_tmb_the_sentinels,type:wizard", 2000)
				cm:add_unit_model_overrides("faction:wh2_dlc09_tmb_the_sentinels,type:wizard", "wh_main_art_set_vmp_necromancer_02")
			end
		)

		local pyramid_region =
			cm:model():world():region_manager():region_by_key("wh2_main_great_mortis_delta_black_pyramid_of_nagash")
		cm:region_slot_instantly_dismantle_building(pyramid_region:settlement():active_secondary_slots():item_at(0))

		if dread_king:is_human() then
			cm:teleport_to("faction:wh2_dlc09_rogue_eyes_of_the_jungle", 157, 20, true)
		else
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
	blood_dragon_setup()
	citadel_setup()
	halflings_setup()
	trollz_setup()
	treeblood_setup()
	albion_setup()
	fimir_setup()
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
			if cm:model():campaign_name("main_warhammer") then
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