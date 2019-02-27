local function sr_crusade_plus()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			if cm:get_faction("wh_main_emp_empire"):is_human() then
				cm:create_force_with_general(
					"wh_main_emp_empire",
					"wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_dlc04_emp_cav_knights_blazing_sun_0,wh_main_emp_art_helstorm_rocket_battery,wh_main_emp_inf_handgunners,wh_dlc04_emp_inf_flagellants_0",
					"wh2_main_great_desert_of_araby_el-kalabad",
					465,
					15,
					"general",
					"emp_lord",
					"names_name_999982293",
					"",
					"",
					"",
					false,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						cm:add_agent_experience("faction:wh_main_emp_empire,forename:999982293", 10000)
					end
				)

				cm:create_force(
					"wh_main_emp_empire",
					"wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_greatswords,wh_main_emp_inf_halberdiers,wh_main_emp_inf_halberdiers,wh_main_emp_cav_demigryph_knights_0",
					"wh2_main_volcanic_islands_fuming_serpent",
					257,
					90,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)

				cm:transfer_region_to_faction("wh2_main_great_desert_of_araby_el-kalabad", "wh_main_emp_empire")
				cm:transfer_region_to_faction("wh2_main_volcanic_islands_fuming_serpent", "wh_main_emp_empire")

				cm:instantly_upgrade_building("wh2_main_great_desert_of_araby_el-kalabad:0", "wh_main_emp_settlement_minor_2")
				cm:instantly_upgrade_building("wh2_main_volcanic_islands_fuming_serpent:0", "wh_main_emp_settlement_minor_2_coast")
			end

			cm:create_force(
				"wh_main_teb_tilea",
				"wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_main_emp_inf_handgunners,wh_main_emp_inf_handgunners,wh_main_emp_inf_swordsmen,wh_main_emp_inf_halberdiers",
				"wh2_main_the_creeping_jungle_temple_of_kara",
				113,
				195,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)
			cm:create_force_with_general(
				"wh_main_brt_bretonnia",
				"wh_dlc07_brt_inf_grail_reliquae_0,wh_dlc07_brt_inf_peasant_bowmen_2,wh_dlc07_brt_inf_peasant_bowmen_2,wh_dlc07_brt_inf_men_at_arms_1,wh_dlc07_brt_cav_knights_errant_0,wh_main_brt_inf_men_at_arms",
				"wh2_main_northern_great_jungle_temple_of_tlencan",
				175,
				180,
				"general",
				"brt_lord",
				"names_name_2147352541",
				"",
				"names_name_2147359312",
				"",
				false,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					cm:add_agent_experience("faction:wh_main_brt_bretonnia,surname:2147359312", 1000)
					cm:callback(
						function()
							cm:force_add_skill("faction:wh_main_brt_bretonnia,surname:2147359312", "wh_dlc07_skill_brt_knight_vow")
						end,
						0.1
					)
				end
			)

			cm:create_force_with_general(
				"wh_main_brt_bretonnia",
				"wh_dlc07_brt_cav_knights_errant_0,wh_dlc07_brt_inf_men_at_arms_2,wh_main_brt_inf_peasant_bowmen,wh_main_brt_art_field_trebuchet,wh_main_brt_cav_knights_of_the_realm,wh_dlc07_brt_inf_battle_pilgrims_0",
				"wh2_main_coast_of_araby_copher",
				420,
				100,
				"general",
				"brt_lord",
				"names_name_1017721779",
				"",
				"names_name_2147359250",
				"",
				false,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					cm:add_agent_experience("faction:wh_main_brt_bretonnia,surname:2147359250", 1000)
					cm:callback(
						function()
							cm:force_add_skill("faction:wh_main_brt_bretonnia,surname:2147359250", "wh_dlc07_skill_brt_knight_vow")
						end,
						0.1
					)
				end
			)

			cm:create_force_with_general(
				"wh_main_brt_bordeleaux",
				"wh_dlc07_brt_inf_foot_squires_0,wh_dlc07_brt_inf_peasant_bowmen_2,wh_dlc07_brt_inf_peasant_bowmen_2,wh_dlc07_brt_inf_men_at_arms_1,wh_dlc07_brt_cav_knights_errant_0,wh_main_brt_inf_men_at_arms",
				"wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon",
				107,
				230,
				"general",
				"brt_lord",
				"names_name_1017721779",
				"",
				"names_name_1486457407",
				"",
				false,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					cm:add_agent_experience("faction:wh_main_brt_bordeleaux,surname:1486457407", 1000)
					cm:callback(
						function()
							cm:force_add_skill("faction:wh_main_brt_bordeleaux,surname:1486457407", "wh_dlc07_skill_brt_knight_vow")
						end,
						0.1
					)
				end
			)

			cm:transfer_region_to_faction("wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel", "wh_main_brt_bordeleaux")
			cm:transfer_region_to_faction("wh2_main_the_creeping_jungle_temple_of_kara", "wh_main_teb_tilea")
			cm:transfer_region_to_faction("wh2_main_northern_great_jungle_temple_of_tlencan", "wh_main_brt_bretonnia")
			cm:transfer_region_to_faction("wh2_main_coast_of_araby_copher", "wh_main_brt_bretonnia")

			cm:instantly_upgrade_building(
				"wh2_main_the_creeping_jungle_temple_of_kara:0",
				"wh_main_emp_settlement_minor_2_coast"
			)
			cm:instantly_upgrade_building(
				"wh2_main_northern_great_jungle_temple_of_tlencan:0",
				"wh_main_brt_settlement_minor_2_coast"
			)
			cm:instantly_upgrade_building(
				"wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel:0",
				"wh_main_brt_settlement_minor_2_coast"
			)
			cm:instantly_upgrade_building("wh2_main_vampire_coast_pox_marsh:0", "wh_main_emp_settlement_minor_2_coast")
			cm:instantly_upgrade_building("wh2_main_coast_of_araby_copher:0", "wh_main_brt_settlement_minor_2_coast")
			cm:instantly_upgrade_building("wh2_main_northern_great_jungle_temple_of_tlencan:1", "wh_main_brt_port_1")
			cm:instantly_upgrade_building("wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel:1", "wh_main_brt_port_1")
			cm:instantly_upgrade_building("wh2_main_the_creeping_jungle_temple_of_kara:1", "wh_main_teb_port_1")

			cm:transfer_region_to_faction("wh2_main_southern_jungle_of_pahualaxa_pahuax", "wh2_main_grn_blue_vipers")
			cm:instantly_upgrade_building("wh2_main_southern_jungle_of_pahualaxa_pahuax:0", "wh_main_grn_settlement_major_2")

			cm:teleport_to("faction:wh2_main_grn_blue_vipers,surname:2147355514", 70, 237, true)

			cm:force_make_vassal("wh_main_emp_empire", "wh2_main_emp_sudenburg")

			if 1 == cm:random_number(3, 1) then
				cm:force_declare_war("wh2_main_lzd_xlanhuapec", "wh_main_emp_empire", false, false)
				cm:force_declare_war("wh2_main_nor_skeggi", "wh_main_brt_bordeleaux", false, false)
				cm:force_declare_war("wh2_main_lzd_tlaxtlan", "wh_main_brt_bretonnia", false, false)
				cm:force_declare_war("wh2_main_grn_blue_vipers", "wh_main_teb_tilea", false, false)
			elseif 2 == cm:random_number(3, 1) then
				cm:force_declare_war("wh2_main_vmp_vampire_coast", "wh_main_emp_empire", false, false)
				cm:force_declare_war("wh2_main_emp_new_world_colonies", "wh_main_brt_bordeleaux", false, false)
				cm:force_declare_war("wh2_main_lzd_xlanhuapec", "wh_main_brt_bretonnia", false, false)
				cm:force_declare_war("wh2_main_lzd_tlaxtlan", "wh_main_teb_tilea", false, false)
			else
				cm:force_declare_war("wh2_dlc09_tmb_rakaph_dynasty", "wh_main_emp_empire", false, false)
				cm:force_declare_war("wh2_main_grn_blue_vipers", "wh_main_brt_bordeleaux", false, false)
				cm:force_declare_war("wh2_main_vmp_vampire_coast", "wh_main_brt_bretonnia", false, false)
				cm:force_declare_war("wh2_main_lzd_xlanhuapec", "wh_main_teb_tilea", false, false)
			end
		end
	end
end

local mcm = _G.mcm

if not not mcm then
	local ovn = nil;
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn");
	else
		ovn = mcm:register_mod("ovn", "OvN - Overhaul", "Let's you enable/disable various parts of the compilation.")
	end
	local crusade = ovn:add_tweaker("crusade", "Crusade", "")
	crusade:add_option("enable", "Enable", "")
	crusade:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_crusade_value") == "enable" then
				sr_crusade_plus()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_crusade_value") == "enable" then sr_crusade_plus() end
	end
)