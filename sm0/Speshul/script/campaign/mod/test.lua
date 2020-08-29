--[[Script by Aexrael Dex and Lost2Insanity]]
--If you are going to copy any section of this script then remember to rename your functions, variables, saved values, etc or get krumped.

function ws_start()
	if cm:is_new_game() then

		-- Setting saved value
		local ws_saved_value = "wez_speshul_enabled";

		cm:set_saved_value(ws_saved_value, true);
		out("Setting saved value " .. ws_saved_value);

		-- Custom starts setup
		ws_custom_starts();
		out("Initiating We'z Speshul custom starts");
	end;
end;

function ws_custom_starts()

	-- Custom Campaign Changes for Mortal Empires
	if cm:model():campaign_name("main_warhammer") then

		-- Setting saved value so that the custom_table later uses the Mortal Empire settings
		local ws_me_saved_value = "ws_me_custom_start";

		cm:set_saved_value(ws_me_saved_value, true);
		out("Setting saved value " .. ws_me_saved_value);

		-- Starting custom start changes for Mortal Empire
		ws_custom_start_run();
		out("We'z Speshul Mortal Empire custom start changes executed");
	end;

	-- Custom Campaign Changes for Vortex
	if cm:model():campaign_name("wh2_main_great_vortex") then

		-- Setting saved value so that the custom_table later uses the vortex settings
		local ws_vor_saved_value = "ws_vor_custom_start";

		cm:set_saved_value(ws_vor_saved_value, true);
		out("Setting saved value " .. ws_vor_saved_value);

		-- Starting custom start changes for Vortex
		ws_custom_start_run();
		out("We'z Speshul Vortex custom start changes executed");
	end;
end;

-- Mortal Empires Changes
local ws_me_changes = {
	-- Always execute
	{faction = "all",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					-- Blue Vipers
					{"secondary_slot_change", "wh2_main_southern_jungle_of_pahualaxa_floating_pyramid", 0, "wh_main_grn_farm_1"},
					{"add_development_points", "wh2_main_southern_jungle_of_pahualaxa_floating_pyramid", 1},
					{"spawn_agent_position", "wh2_main_grn_blue_vipers", 83, 223, "champion", "ws_grn_savage_orc_big_boss"},
					-- The Bloody Hand
					{"spawn_agent_position", "wh_main_grn_orcs_of_the_bloody_hand", 615,257, "champion", "ws_grn_savage_orc_big_boss"},
					{"perma_kill_character", "wh_main_grn_orcs_of_the_bloody_hand", "grn_night_goblin_shaman", "names_name_563282649", false},
					-- Ard Boyz
					{"spawn_agent_position", "wh_main_grn_greenskins", 710,277, "champion", "wh2_pro09_grn_black_orc_big_boss"},
					-- Top Knotz
					{"secondary_slot_change", "wh_main_southern_badlands_galbaraz", 0, "wh_main_grn_farm_1"},
					-- Leaf-Cutterz
					{"secondary_slot_change", "wh2_main_misty_hills_the_black_pit", 0, "ws_grn_forest_beasts_0"}
				}
			},
			{
				exceptions = {"wh2_main_grn_blue_vipers"},
				changes = {
					-- Exclude if Blue Vipers are human
					{"spawn_new_faction_leader", "wh2_main_grn_blue_vipers", "wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_inf_savage_orc_arrer_boyz,ws_grn_inf_savage_orc_stikkas,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,", 90, 252, "ws_grn_grak_beastbasha", "names_name_2020000", "names_name_2020001"},
					{"perma_kill_character", "wh2_main_grn_blue_vipers", "grn_orc_warboss", "names_name_2147345011", true},
					{"add_restricted_building_faction", "ws_grn_military_1", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "ws_grn_military_2", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "ws_grn_military_3", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "ws_grn_military_4", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_boars_1", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_boars_2", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_1", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_2", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_3", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_1", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_2", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_3", "wh2_main_grn_blue_vipers"},
					{"add_restricted_unit_faction", "wh_dlc06_grn_cav_squig_hoppers_0", "wh2_main_grn_blue_vipers"}
				}
			},
			{
				exceptions = {"wh2_main_lzd_hexoatl"},
				changes = {
					-- Exclude if Hexoatl are human
					{"force_diplomacy", "wh2_main_grn_blue_vipers", "wh2_main_lzd_hexoatl", "peace"}
				}
			},
			{
				exceptions = {"wh_main_grn_top_knotz"},
				changes = {
					-- Exclude if Top Knotz are human
					{"add_restricted_building_faction", "ws_grn_military_1", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "ws_grn_military_2", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "ws_grn_military_3", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "ws_grn_military_4", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_boars_1", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_boars_2", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_1", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_2", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_3", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_1", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_2", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_3", "wh_main_grn_top_knotz"},
					{"add_restricted_unit_faction", "wh_dlc06_grn_cav_squig_hoppers_0", "wh_main_grn_top_knotz"}
				}
			},
			{
				exceptions = {"wh_main_grn_skull-takerz"},
				changes = {
					-- Exclude if Skull-Takerz are human
					{"add_restricted_building_faction", "ws_grn_military_1", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "ws_grn_military_2", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "ws_grn_military_3", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "ws_grn_military_4", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "wh_main_grn_boars_1", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "wh_main_grn_boars_2", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_1", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_2", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_3", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_1", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_2", "wh_main_grn_skull-takerz"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_3", "wh_main_grn_skull-takerz"},
					{"add_restricted_unit_faction", "wh_dlc06_grn_cav_squig_hoppers_0", "wh_main_grn_skull-takerz"}
				}
			},
			{
				exceptions = {"wh2_dlc12_grn_leaf_cutterz_tribe"},
				changes = {
					-- Exclude if Leaf-Cutterz are human
					{"spawn_new_faction_leader", "wh2_dlc12_grn_leaf_cutterz_tribe", "ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblin_hunters,wh_main_grn_cav_forest_goblin_spider_riders_0,wh_main_grn_cav_forest_goblin_spider_riders_0,wh_main_grn_cav_forest_goblin_spider_riders_1", 470, 511, "ws_grn_snagla_grobspit", "names_name_2020004", "names_name_2020005"},
					{"perma_kill_character", "wh2_dlc12_grn_leaf_cutterz_tribe", "grn_goblin_great_shaman", "names_name_2031515018", true}
				}
			},
			{
				exceptions = {"wh_main_grn_black_venom"},
				changes = {
					-- Exclude if Black Venom are human
					{"spawn_new_faction_leader", "wh_main_grn_black_venom", "ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblin_hunters,wh_main_grn_cav_forest_goblin_spider_riders_0", 569, 370, "ws_grn_tinitt_foureyes", "names_name_2020008", "names_name_2020009"},
					{"perma_kill_character", "wh_main_grn_black_venom", "grn_goblin_great_shaman", "names_name_2147345022", true}
				}
			}
		}
	},
	-- Blue Vipers are human
	{faction = "wh2_main_grn_blue_vipers",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"region_change", "wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel", "wh2_dlc11_cst_the_drowned"},
					{"spawn_new_faction_leader", "wh2_main_grn_blue_vipers", "wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_inf_savage_orc_arrer_boyz,ws_grn_inf_savage_orc_stikkas,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,", 79, 219, "ws_grn_grak_beastbasha", "names_name_2020000", "names_name_2020001"},
					{"perma_kill_character", "wh2_main_grn_blue_vipers", "grn_orc_warboss", "names_name_2147345011", true}
				}
			},
			{
				exceptions = {"wh2_dlc11_cst_the_drowned"},
				changes = {
					-- Exclude if The Drowned are human
					{"force_religion_factors", "wh2_main_southern_jungle_of_pahualaxa_floating_pyramid", "wh_main_religion_undeath", 0.3, "wh_main_religion_untainted", 0.7},
					{"force_religion_factors", "wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon", "wh_main_religion_undeath", 0.3, "wh_main_religion_untainted", 0.7},
					{"force_religion_factors", "wh2_main_southern_jungle_of_pahualaxa_pahuax", "wh_main_religion_undeath", 0.3, "wh_main_religion_untainted", 0.7},
					{"force_religion_factors", "wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel", "wh_main_religion_undeath", 0.3, "wh_main_religion_untainted", 0.7}
				}
			},
			{
				exceptions = {"wh2_dlc11_cst_the_drowned", "wh2_dlc13_emp_the_huntmarshals_expedition"},
				changes = {
					-- Exclude if The Drowned or The Huntsmarshals Expedition are human
					{"force_diplomacy", "wh2_main_grn_blue_vipers", "wh2_dlc13_emp_the_huntmarshals_expedition", "peace"}
				}
			}
		}
	},
	-- Leaf-Cutterz are human
	{faction = "wh2_dlc12_grn_leaf_cutterz_tribe",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"spawn_new_faction_leader", "wh2_dlc12_grn_leaf_cutterz_tribe", "ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblin_hunters,wh_main_grn_cav_forest_goblin_spider_riders_0,wh_main_grn_cav_forest_goblin_spider_riders_0,wh_dlc06_grn_cav_deff_creepers_0", 470, 511, "ws_grn_snagla_grobspit", "names_name_2020004", "names_name_2020005"},
					{"perma_kill_character", "wh2_dlc12_grn_leaf_cutterz_tribe", "grn_goblin_great_shaman", "names_name_2031515018", true},
					{"region_change", "wh2_main_misty_hills_wreckers_point", "wh_main_emp_empire_separatists"},
					{"region_change", "wh2_main_misty_hills_the_black_pit", "wh2_main_grn_arachnos"},
					{"region_change", "wh2_main_misty_hills_the_black_pit", "wh2_dlc12_grn_leaf_cutterz_tribe"}
				}
			}
		}
	},
	-- Black Venom are human
	{faction = "wh_main_grn_black_venom",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"spawn_new_faction_leader", "wh_main_grn_black_venom", "ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblin_hunters,wh_dlc06_grn_mon_spider_hatchlings_0,wh_main_grn_mon_arachnarok_spider_0", 587, 335, "ws_grn_tinitt_foureyes", "names_name_2020008", "names_name_2020009"},
					{"perma_kill_character", "wh_main_grn_black_venom", "grn_goblin_great_shaman", "names_name_2147345022", true},
					{"region_change", "wh2_main_solland_steingart", "wh2_dlc13_emp_golden_order"},
				}
			},
			{
				exceptions = {"wh2_dlc13_emp_golden_order"},
				changes = {
					-- Exclude if The Golden Order are human
					{"force_diplomacy", "wh_main_grn_black_venom", "wh2_dlc13_emp_golden_order", "peace"}
				}
			},
			{
				exceptions = {"wh_main_teb_border_princes"},
				changes = {
					-- Exclude if The Border Princes are human
					{"force_diplomacy", "wh_main_grn_black_venom", "wh_main_teb_border_princes", "war"}
				}
			}
		}
	}
};

-- Eye of the Vortex changes
local ws_vor_changes = {
	-- Always execute
	{faction = "all",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					-- Blue Vipers
					{"secondary_slot_change", "wh2_main_vor_jungles_of_green_mist_spektazuma", 0, "wh_main_grn_farm_1"},
					-- Top Knotz
					{"secondary_slot_change", "wh2_main_vor_southern_badlands_galbaraz", 0, "wh_main_grn_farm_1"},
					{"secondary_slot_change", "wh2_main_vor_land_of_the_dead_the_salt_plain", 0, "wh_main_grn_farm_1"},
					-- Leaf-Cutterz
					{"secondary_slot_change", "wh2_main_vor_the_red_rivers_cuexotl", 0, "ws_grn_forest_beasts_0"}
				}
			},
			{
				exceptions = {"wh2_main_grn_blue_vipers"},
				changes = {
					-- Exclude if Blue Vipers are human
					{"spawn_new_faction_leader", "wh2_main_grn_blue_vipers", "wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_inf_savage_orc_arrer_boyz,ws_grn_inf_savage_orc_stikkas,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,", 109, 287, "ws_grn_grak_beastbasha", "names_name_2020000", "names_name_2020001"},
					{"perma_kill_character", "wh2_main_grn_blue_vipers", "grn_orc_warboss", "names_name_2147345011", true},
					{"spawn_agent_position", "wh2_main_grn_blue_vipers", 102, 299, "champion", "ws_grn_savage_orc_big_boss"},
					{"add_restricted_building_faction", "ws_grn_military_1", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "ws_grn_military_2", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "ws_grn_military_3", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "ws_grn_military_4", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_boars_1", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_boars_2", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_1", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_2", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_3", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_1", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_2", "wh2_main_grn_blue_vipers"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_3", "wh2_main_grn_blue_vipers"},
					{"add_restricted_unit_faction", "wh_dlc06_grn_cav_squig_hoppers_0", "wh2_main_grn_blue_vipers"}
				}
			},
			{
				exceptions = {"wh_main_grn_top_knotz"},
				changes = {
					-- Exclude if Top Knotz are human
					{"add_restricted_building_faction", "ws_grn_military_1", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "ws_grn_military_2", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "ws_grn_military_3", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "ws_grn_military_4", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_boars_1", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_boars_2", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_1", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_2", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_forest_beasts_3", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_1", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_2", "wh_main_grn_top_knotz"},
					{"add_restricted_building_faction", "wh_main_grn_workshop_3", "wh_main_grn_top_knotz"},
					{"add_restricted_unit_faction", "wh_dlc06_grn_cav_squig_hoppers_0", "wh_main_grn_top_knotz"}
				}
			},
			{
				exceptions = {"wh2_dlc12_grn_leaf_cutterz_tribe"},
				changes = {
					-- Exclude if Leaf-Cutterz are human
					{"spawn_new_faction_leader", "wh2_dlc12_grn_leaf_cutterz_tribe", "ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblin_hunters,wh_main_grn_cav_forest_goblin_spider_riders_0,wh_main_grn_cav_forest_goblin_spider_riders_0,wh_main_grn_cav_forest_goblin_spider_riders_1", 597, 159, "ws_grn_snagla_grobspit", "names_name_2020004", "names_name_2020005"},
					{"perma_kill_character", "wh2_dlc12_grn_leaf_cutterz_tribe", "grn_goblin_great_shaman", "names_name_2031515018", true}
				}
			}
		}
	},
	-- Blue Vipers are human
	{faction = "wh2_main_grn_blue_vipers",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"spawn_new_faction_leader", "wh2_main_grn_blue_vipers", "wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_inf_savage_orc_arrer_boyz,ws_grn_inf_savage_orc_stikkas,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,", 93, 311, "ws_grn_grak_beastbasha", "names_name_2020000", "names_name_2020001"},
					{"perma_kill_character", "wh2_main_grn_blue_vipers", "grn_orc_warboss", "names_name_2147345011", true},
					{"region_change", "wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", "wh2_main_grn_blue_vipers"},
					{"primary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", "wh_main_savage_settlement_minor_1"},
					{"region_change", "wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", "wh2_main_emp_new_world_colonies"}, -- Work around to enable unit recruitment on turn 1
					{"region_change", "wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", "wh2_main_grn_blue_vipers"}, -- Work around to enable unit recruitment on turn 1
					{"secondary_slot_change", "wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", 0, "wh_main_grn_farm_1"},
					{"abandon_region", "wh2_main_vor_the_creeping_jungle_temple_of_kara"},
					{"abandon_region", "wh2_main_vor_jungle_of_pahualaxa_the_high_sentinel"},
					{"abandon_region", "wh2_main_vor_jungles_of_green_mist_spektazuma"},
					{"add_development_points", "wh2_main_vor_jungle_of_pahualaxa_floating_pyramid", 1},
					{"spawn_agent_position", "wh2_main_grn_blue_vipers", 98, 317, "champion", "ws_grn_savage_orc_big_boss"}
				}
			},
			{
				exceptions = {"wh2_main_lzd_tlaxtlan"},
				changes = {
					-- Exclude if Tlaxtlan are human
					{"region_change", "wh2_main_vor_the_creeping_jungle_tlanxla", "wh2_main_lzd_tlaxtlan"}
				}
			}
		}
	},
	-- Leaf-Cutterz are human
	{faction = "wh2_dlc12_grn_leaf_cutterz_tribe",
		custom_start = {
			{
				exceptions = nil,
				changes = {
					{"spawn_new_faction_leader", "wh2_dlc12_grn_leaf_cutterz_tribe", "ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblins,ws_grn_inf_forest_goblin_hunters,wh_main_grn_cav_forest_goblin_spider_riders_0,wh_main_grn_cav_forest_goblin_spider_riders_0,wh_dlc06_grn_cav_deff_creepers_0", 562, 169, "ws_grn_snagla_grobspit", "names_name_2020004", "names_name_2020005"},
					{"perma_kill_character", "wh2_dlc12_grn_leaf_cutterz_tribe", "grn_goblin_great_shaman", "names_name_2031515018", true},
					{"region_change", "wh2_main_vor_the_red_rivers_sun-tree_glades", "wh2_main_wef_bowmen_of_oreon"},
					{"abandon_region", "wh2_main_vor_the_red_rivers_nahuontl"},
					{"force_diplomacy", "wh2_dlc12_grn_leaf_cutterz_tribe", "wh2_main_wef_bowmen_of_oreon", "war"},
					{"region_change", "wh2_main_vor_the_red_rivers_cuexotl", "wh2_main_grn_arachnos"},
					{"region_change", "wh2_main_vor_the_red_rivers_cuexotl", "wh2_dlc12_grn_leaf_cutterz_tribe"}
				}
			}
		}
	}
};

-- Executes the changes from the above tables, piggybacks off CAs functions in wh2_campaign_custom_starts
function ws_custom_start_run()

	-- Setting starting table undefined
	local human_factions = cm:get_human_factions();

	if human_factions[1] ~= nil then
		local custom_table = {};

		-- Checking which saved value was set
		if cm:get_saved_value("ws_me_custom_start") == true then
			custom_table = ws_me_changes;
		elseif  cm:get_saved_value("ws_vor_custom_start") == true then
			custom_table = ws_vor_changes;
		end;

		for i = 1, #human_factions do 
			for j = 1, #custom_table do
				if human_factions[i] == custom_table[j].faction or custom_table[j].faction == "all" then
					local custom_faction = custom_table[j];
					for k = 1, #custom_faction.custom_start do
						local current_custom_start = custom_faction.custom_start;
						local exception_list = current_custom_start[k].exceptions;

						if not exception_list or not cm:are_any_factions_human(exception_list) then
							local custom_changes = current_custom_start[k].changes;

							for l = 1, #custom_changes do
								local changes = custom_changes[l];
								if cm:is_new_game() == true then
									cm:disable_event_feed_events(true,"all","","")
									if changes[1] == "region_change" then
										region_change(changes[2], changes[3]);
									elseif changes[1] == "primary_slot_change" then 
										primary_slot_change(changes[2], changes[3]);
									elseif changes[1] == "port_slot_change" then 
										port_slot_change(changes[2], changes[3]);
									elseif changes[1] == "secondary_slot_change" then 
										secondary_slot_change(changes[2], changes[3], changes[4]);
									elseif changes[1] == "create_army" then 
										create_army(changes[2], changes[3], changes[4], changes[5], changes[6], changes[7], changes[8], changes[9], changes[10]);
									elseif changes[1] == "create_army_for_leader" then
										create_army_for_faction_leader(changes[2], changes[3], changes[4], changes[5], changes[6]);
									elseif changes[1] == "teleport_character" then 
										teleport_character(changes[2], changes[3], changes[4], changes[5], changes[6], changes[7]);
									elseif changes[1] == "teleport_character_faction_leader" then
										teleport_character_faction_leader(changes[2], changes[3], changes[4]);
									elseif changes[1] == "hide_faction_leader" then
										hide_faction_leader(changes[2], changes[3], changes[4]);
									elseif changes[1] == "add_units" then 
										add_units_to_army(changes[2], changes[3], changes[4], changes[5]);
									elseif changes[1] == "force_diplomacy" then 
										force_diplomacy_change(changes[2], changes[3], changes[4]);
									elseif changes[1] == "abandon_region" then 
										abandon_region(changes[2]);
									elseif changes[1] == "kill_faction" then 
										kill_faction(changes[2]);
									elseif changes[1] == "char_effect_bundle" then 
										apply_effect_bundle_character(changes[2], changes[3], changes[4], changes[5], changes[6]);
									elseif changes[1] == "add_development_points" then 
										cm:add_development_points_to_region(changes[2], changes[3]);
									elseif changes[1] == "spawn_agent_settlement" then
										spawn_agent_settlement(changes[2], changes[3], changes[4], changes[5]);
									elseif changes[1] == "spawn_agent_faction_leader" then
										spawn_agent_faction_leader(changes[2], changes[3], changes[4]);
									elseif changes[1] == "spawn_agent_position" then
										spawn_agent_position(changes[2], changes[3], changes[4], changes[5], changes[6]);
									elseif changes[1] == "confederate" then
										confederate(changes[2], changes[3]);
									elseif changes[1] == "force_rebellion" then
										force_rebellion(changes[2], changes[3], changes[4], changes[5], changes[6]);
									elseif changes[1] == "change_corruption" then
										change_corruption(changes[2], changes[3], changes[4], changes[5], changes[6]);
									elseif changes[1] == "faction_effect_bundle" then
										faction_effect_bundle(changes[2], changes[3], changes[4]);
									elseif changes[1] == "perma_kill_character" then
										perma_kill_character(changes[2], changes[3], changes[4], changes[5]);
									elseif changes[1] == "spawn_new_faction_leader" then
										spawn_new_faction_leader(changes[2], changes[3], changes[4], changes[5], changes[6], changes[7], changes[8]);
									elseif changes[1] == "add_restricted_building_faction" then
										add_restricted_building_faction(changes[2], changes[3]);
									elseif changes[1] == "add_restricted_unit_faction" then
										add_restricted_unit_faction(changes[2], changes[3]);
									end;
									cm:callback(function() 
										cm:disable_event_feed_events(false, "all", "", "");
									end, 0.5);
								end;
								if changes[1] == "block_diplomacy" then 
									block_diplomacy(changes[2], changes[3], changes[4], changes[5], changes[6]);
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end;

--Additional Custom Start functions below this point, remember to rename functions if you make edits or the choppas come out.
--pass this function a faction(string), region(string), type(string), subtype(string)
function spawn_agent_settlement(faction_name, region_name, agent_type, agent_subtype)

	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: spawn_agent_settlement() called but supplied faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end;

	--check the region key is a string
	if not is_string(region_name) then
		script_error("ERROR: spawn_agent_settlement() called but supplied region key [" .. tostring(region_name) .. "] is not a string");
		return false;
	end;

	--check the agent type is a string
	if not is_string(agent_type) then
		script_error("ERROR: spawn_agent_settlement() called but supplied agent subtype [" .. tostring(agent_type) .. "] is not a string");
		return false;
	end;

	--check the agent subtype is a string
	if not is_string(agent_subtype) then
		script_error("ERROR: spawn_agent_settlement() called but supplied agent subtype [" .. tostring(agent_subtype) .. "] is not a string");
		return false;
	end;

	local faction = cm:get_faction(faction_name); 
	local settlement = cm:get_region(region_name):settlement();

	cm:spawn_agent_at_settlement(
		faction, 
		settlement, 
		agent_type, 
		agent_subtype
	);
end;

--pass this function a faction(string), type(string), subtype(string)
function spawn_agent_faction_leader(faction_name, agent_type, agent_subtype)

	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: spawn_agent_faction_leader() called but supplied faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end	;

	--check the agent type is a string
	if not is_string(agent_type) then
		script_error("ERROR: spawn_agent_faction_leader() called but supplied agent subtype [" .. tostring(agent_type) .. "] is not a string");
		return false;
	end;

	--check the agent subtype is a string
	if not is_string(agent_subtype) then
		script_error("ERROR: spawn_agent_faction_leader() called but supplied agent subtype [" .. tostring(agent_subtype) .. "] is not a string");
		return false;
	end;

	local faction = cm:get_faction(faction_name); 
	local mf_list = faction:military_force_list();
	local target_mf = nil;

	--loop through list of all military force if one is faction leader
	for i = 0, mf_list:num_items() - 1 do
		local force = mf_list:item_at(i);
		local character = force:general_character();
		if character:is_faction_leader() then
			target_mf = force;
		end;
	end;

	cm:spawn_agent_at_military_force(
		faction, 
		target_mf, 
		type_key, 
		subtype_key
	);
end;

--pass this function a faction(string), x(number), y(number), type(string), subtype(string)
function spawn_agent_position(faction_name, x_pos, y_pos, agent_type, agent_subtype)

	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: spawn_agent_position() called but supplied faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end;

	--check the x position is a number
	if not is_number(x_pos) then
		script_error("ERROR: spawn_agent_position() called but supplied x position [" .. tostring(x_pos) .. "] is not a number");
		return false;
	end;

	--check the y position is a number
	if not is_number(y_pos) then
		script_error("ERROR: spawn_agent_position() called but supplied y position [" .. tostring(y_pos) .. "] is not a number");
		return false;
	end;

	--check the agent type is a string
	if not is_string(agent_type) then
		script_error("ERROR: spawn_agent_position() called but supplied agent type [" .. tostring(agent_type) .. "] is not a string");
		return false;
	end;

	--check the agent subtype is a string
	if not is_string(agent_subtype) then
		script_error("ERROR: spawn_agent_position() called but supplied agent subtype [" .. tostring(agent_subtype) .. "] is not a string");
		return false;
	end;

	local faction = cm:get_faction(faction_name);

	cm:spawn_agent_at_position(
		faction,
		x_pos,
		y_pos,
		agent_type,
		agent_subtype
	);

	local char_list = faction:character_list();
    
    for i = 0, char_list:num_items() - 1 do
    local current_char = char_list:item_at(i);
    local char_str = cm:char_lookup_str(current_char);
    
        if current_char:is_null_interface() == false and current_char:character_subtype_key() == agent_subtype then
            cm:replenish_action_points(char_str);
        end;
    end;
end;

--pass this function a faction(string), faction(string)
function confederate(faction_name_proposer, faction_name_target)

	--check the faction key is a string
	if not is_string(faction_name_proposer) then
		script_error("ERROR: confederate() called but supplied faction key [" .. tostring(faction_name_proposer) .. "] is not a string");
		return false;
	end;

	--check the faction key is a string
	if not is_string(faction_name_target) then
		script_error("ERROR: confederate() called but supplied faction key [" .. tostring(faction_name_target) .. "] is not a string");
		return false;
	end;

	cm:force_confederation(faction_name_proposer, faction_name_target);
end;

-- pass this function a region(string), unit(number), x(number), y(number), bool(boolean)
function force_rebellion(region_name, unit_number, x_pos, y_pos, suppress_event)

	--check the faction key is a string
	if not is_string(region_name) then
		script_error("ERROR: force_rebellion() called but supplied region name [" .. tostring(region_name) .. "] is not a string");
		return false;
	end;

	--check the x position is a number
	if not is_number(unit_number) then
		script_error("ERROR: force_rebellion() called but supplied unit number [" .. tostring(unit_number) .. "] is not a number");
		return false;
	end;

	--check the x position is a number
	if not is_number(x_pos) then
		script_error("ERROR: force_rebellion() called but supplied x position [" .. tostring(x_pos) .. "] is not a number");
		return false;
	end;

	--check the y position is a number
	if not is_number(y_pos) then
		script_error("ERROR: force_rebellion() called but supplied y position [" .. tostring(y_pos) .. "] is not a number");
		return false;
	end;

	--check the faction leader boolean is a boolean
	if not is_boolean(suppress_event) then
		script_error("ERROR: force_rebellion() called but supplied suppress event [" .. tostring(suppress_event) .. "] is not a boolean");
		return false;
	end;

	cm:force_rebellion_in_region(region_name, unit_number, x_pos, y_pos, suppress_event);
end;

-- pass this function a region(string), religion_key(string), proportion(number), religion_key(string), proportion(number)
function change_corruption(region_name, religion_key_one, proportion_one, religion_key_two, proportion_two)

	--check the faction key is a string
	if not is_string(region_name) then
		script_error("ERROR: change_corruption() called but supplied region name [" .. tostring(region_name) .. "] is not a string");
		return false;
	end;

	--check the religion_key_one is a string
	if not is_string(religion_key_one) then
		script_error("ERROR: change_corruption() called but supplied religion key [" .. tostring(religion_key_one) .. "] is not a string");
		return false;
	end;

	--check the proportion_one is a number
	if not is_number(proportion_one) then
		script_error("ERROR: change_corruption() called but supplied proportion [" .. tostring(proportion_one) .. "] is not a number");
		return false;
	end;

	--check the religion_key_two is a string
	if not is_string(religion_key_two) then
		script_error("ERROR: change_corruption() called but supplied religion keyy [" .. tostring(religion_key_two) .. "] is not a string");
		return false;
	end;

	--check the proportion_two is a number
	if not is_number(proportion_two) then
		script_error("ERROR: change_corruption() called but supplied proportion [" .. tostring(proportion_two) .. "] is not a number");
		return false;
	end;

	cm:force_religion_factors(region_name, religion_key_one, proportion_one, religion_key_two, proportion_two);
end;

-- pass this function a effect_bundle_key(string), faction_key(string), turn number(number)
function faction_effect_bundle(effect_bundle_key, faction_name, number_turns)

	--check the effect_bundle_key is a string
	if not is_string(effect_bundle_key) then
		script_error("ERROR: faction_effect_bundle() called but supplied effect bundle key [" .. tostring(effect_bundle_key) .. "] is not a string");
		return false;
	end;

	--check the faction_name is a string
	if not is_string(faction_name) then
		script_error("ERROR: faction_effect_bundle() called but supplied faction name [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end;

	--check the proportion_one is a number
	if not is_number(number_turns) then
		script_error("ERROR: faction_effect_bundle() called but supplied number of turns [" .. tostring(number_turns) .. "] is not a number");
		return false;
	end;

	cm:apply_effect_bundle(effect_bundle_key, faction_name, number_turns);
end;

-- pass this function a faction_name(string), forename(string), kill_army(boolean)
function perma_kill_character(faction_name, agent_subtype, forename, kill_army)

	--check the faction_name is a string
	if not is_string(faction_name) then
		script_error("ERROR: perma_kill_character() called but supplied proposing faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end;

	--check the faction_name is a string
	if not is_string(forename) then
		script_error("ERROR: perma_kill_character() called but supplied proposing faction key [" .. tostring(forename) .. "] is not a string");
		return false;
	end;

	--check the kill army boolean is a boolean
	if not is_boolean(kill_army) then
		script_error("ERROR: perma_kill_character() called but supplied faction leader boolean [" .. tostring(kill_army) .. "] is not a boolean");
		return false;
	end;

    local faction = cm:model():world():faction_by_key(faction_name);
    local char_list = faction:character_list();

    for i = 0, char_list:num_items() - 1 do
		 local current_char = char_list:item_at(i);
		 local char_str = cm:char_lookup_str(current_char);

        if current_char:is_null_interface() == false and current_char:character_subtype_key() == agent_subtype and current_char:get_forename() == forename and current_char:has_military_force() == kill_army then
			cm:disable_event_feed_events(true, "wh_event_category_character", "", "");
			cm:disable_event_feed_events(true, "wh_event_category_agent", "", "");
			cm:set_character_immortality(char_str, false);
            cm:kill_character(current_char:command_queue_index(), kill_army, true);
			cm:callback(
                function()
                    cm:disable_event_feed_events(false, "wh_event_category_character", "", "");
                    cm:disable_event_feed_events(false, "wh_event_category_agent", "", "");
                end,
                0.5
            );
            out("Killing character with " ..forename);
        end;
	end;
end;

-- pass this function a faction_name(string), unit_list(strings), x_pos(number), y_pos(number), agent_subtype(String), agent_forename(string), agent_surname(string)
function spawn_new_faction_leader(faction_name, unit_list, x_pos, y_pos, agent_subtype, agent_forename, agent_surname)

	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: spawn_new_faction_leader() called but supplied target faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end;

	--check the unit_list is a list of strings or nil (if nil then we will generate a random army)
	if is_number(unit_list) then
		local num_units = unit_list; 
		if num_units > 19 then
			num_units = 19;
		end;
		unit_list = generate_random_army(cm:get_faction(faction_name):subculture(), num_units);
	elseif not is_string(unit_list) then
		script_error("ERROR: spawn_new_faction_leader() called but supplied unit_list [" .. tostring(unit_list) .. "] is not a number or table");
		return false;
	end;

	--check the agent subtype is a string
	if not is_string(agent_subtype) then
		script_error("ERROR: spawn_new_faction_leader() called but supplied agent subtype [" .. tostring(agent_subtype) .. "] is not a string");
		return false;
	end;

	--check the agent forename is a string
	if not is_string(agent_forename) then
		script_error("ERROR: spawn_new_faction_leader() called but supplied agent forename [" .. tostring(agent_forename) .. "] is not a string");
		return false;
	end;

	--check the agent surname is a string
	if not is_string(agent_surname) then
		script_error("ERROR: spawn_new_faction_leader() called but supplied agent surname [" .. tostring(agent_surname) .. "] is not a string");
		return false;
	end;

	local faction = cm:get_faction(faction_name);
	local region_key = faction:home_region():name();
	-- local x_pos, y_pos = cm:find_valid_spawn_location_for_character_from_settlement(faction_name, region_key, false, true);

	cm:create_force_with_general(
		faction_name,
		unit_list,
		region_key,
		x_pos,
		y_pos,
		"general",
		agent_subtype,
		agent_forename,
		"",
		agent_surname,
		"",
		true,

		function(cqi)
			local char_str = cm:char_lookup_str(cqi);
			cm:set_character_immortality(char_str, true);
		end
	);
end;

-- pass this function a building_key(string), faction_name(string)
function add_restricted_building_faction(building_key, faction_name)

	--check the building key is a string
	if not is_string(building_key) then
		script_error("ERROR: add_restricted_building_faction() called but supplied building key [" .. tostring(building_key) .. "] is not a string");
		return false;
	end;

	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: add_restricted_building_faction() called but supplied faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end;

	cm:add_event_restricted_building_record_for_faction(
		building_key, 
		faction_name
	);
end;

-- pass this function a unit_key(string), faction_name(string)
function add_restricted_unit_faction(unit_key, faction_name)

	--check the unit key is a string
	if not is_string(unit_key) then
		script_error("ERROR: add_restricted_unit_faction() called but supplied unit key [" .. tostring(unit_key) .. "] is not a string");
		return false;
	end;

	--check the faction key is a string
	if not is_string(faction_name) then
		script_error("ERROR: add_restricted_unit_faction() called but supplied faction key [" .. tostring(faction_name) .. "] is not a string");
		return false;
	end;

	cm:add_event_restricted_unit_record_for_faction(
		unit_key, 
		faction_name
	);
end;