local function sr_crusade_plus()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			if cm:get_faction("wh_main_emp_empire"):is_human() then
				cm:create_force_with_general(
					"wh_main_emp_empire",
					"wh_main_emp_inf_spearmen_0,wh_main_emp_inf_spearmen_0,wh_dlc04_emp_cav_knights_blazing_sun_0,wh_main_emp_art_helstorm_rocket_battery,wh_main_emp_inf_handgunners,wh_dlc04_emp_inf_flagellants_0",
					"wh2_main_great_desert_of_araby_el-kalabad",
					495,
					50,
					"general",
					"emp_lord",
					"names_name_999982293",
					"",
					"",
					"",
					false,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						cm:add_agent_experience("faction:wh_main_emp_empire,forename:999982293", 2500)
					end
				)

				if vfs.exists("script/campaign/mod/imp_navy.lua") then
					cm:create_force_with_general(
						"wh_main_emp_empire",
						"mortar_navy,kmariner_navy,smanann_navy,cannon_crew_navy,wargalley_dual,handgunners_navy,jag_amazon",
						"wh2_main_volcanic_islands_fuming_serpent",
						257,
						90,
						"general",
						"wh_main_emp_cha_admiral",
						"names_name_999982317",
						"",
						"",
						"",
						false,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
							cm:add_agent_experience("faction:wh_main_emp_empire,forename:999982317", 2500)
						end
					)
				else
					cm:create_force(
						"wh_main_emp_empire",
						"wh_main_emp_inf_crossbowmen,wh_main_emp_inf_crossbowmen,wh_main_emp_inf_greatswords,wh_main_emp_inf_halberdiers,wh_main_emp_inf_halberdiers,wh_main_emp_cav_demigryph_knights_0,jag_amazon",
						"wh2_main_volcanic_islands_fuming_serpent",
						257,
						90,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						end
					)
				end

				cm:transfer_region_to_faction("wh2_main_great_desert_of_araby_el-kalabad", "wh_main_emp_empire")
				cm:transfer_region_to_faction("wh2_main_volcanic_islands_fuming_serpent", "wh_main_emp_empire")

				local kalabad_region =
					cm:model():world():region_manager():region_by_key("wh2_main_great_desert_of_araby_el-kalabad")
				cm:instantly_set_settlement_primary_slot_level(kalabad_region:settlement(), 2)

				local serpent_region = cm:model():world():region_manager():region_by_key("wh2_main_volcanic_islands_fuming_serpent")
				cm:instantly_set_settlement_primary_slot_level(serpent_region:settlement(), 2)

				cm:heal_garrison(cm:get_region("wh2_main_great_desert_of_araby_el-kalabad"):cqi())
				cm:heal_garrison(cm:get_region("wh2_main_volcanic_islands_fuming_serpent"):cqi())
			end

			cm:create_force_with_general(
				"wh_main_brt_carcassonne",
				"ovn_cru_knight,ovn_cru_knight,ovn_cru_knight,ovn_cru_knight,ovn_cru_knight_foot,ovn_cru_knight_foot,ovn_cru_knight_foot,ovn_cru_knight_foot,ovn_cru_knight_foot,jag_amazon",
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
					cm:add_agent_experience("faction:wh_main_brt_carcassonne,surname:2147359312", 1200)
				end
			)

			cm:create_agent("wh_main_brt_carcassonne", "wizard", "brt_damsel", 177, 175, false)

			cm:create_force_with_general(
				"wh_main_brt_bretonnia",
				"ovn_cru_knight,ovn_cru_knight,ovn_cru_knight,ovn_cru_knight,ovn_cru_knight_foot,ovn_cru_knight_foot,ovn_cru_knight_foot,ovn_cru_knight_foot,ovn_cru_knight_foot,OtF_khemri_rangers",
				"wh2_main_coast_of_araby_copher",
				660,
				25,
				"general",
				"brt_lord",
				"names_name_1017721779",
				"",
				"names_name_2147359250",
				"",
				false,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					cm:add_agent_experience("faction:wh_main_brt_bretonnia,surname:2147359250", 1200)
				end
			)

			cm:create_agent("wh_main_brt_bretonnia", "wizard", "brt_damsel", 655, 28, false)

			cm:create_force_with_general(
				"wh_main_brt_bordeleaux",
				"ovn_cru_knight,ovn_cru_knight,ovn_cru_knight,ovn_cru_knight,ovn_cru_knight_foot,ovn_cru_knight_foot,ovn_cru_knight_foot,ovn_cru_knight_foot,ovn_cru_knight_foot,jag_amazon",
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
					cm:add_agent_experience("faction:wh_main_brt_bordeleaux,surname:1486457407", 1200)
				end
			)

			cm:create_agent("wh_main_brt_bordeleaux", "wizard", "brt_damsel", 112, 233, false)

			cm:transfer_region_to_faction("wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel", "wh_main_brt_bordeleaux")
			cm:transfer_region_to_faction("wh2_main_northern_great_jungle_temple_of_tlencan", "wh_main_brt_carcassonne")
			cm:transfer_region_to_faction("wh2_main_shifting_sands_antoch", "wh_main_brt_bretonnia")

			--	local tlenclan_region = cm:model():world():region_manager():region_by_key("wh2_main_northern_great_jungle_temple_of_tlencan")
			--	cm:instantly_set_settlement_primary_slot_level(tlenclan_region:settlement(), 2)

			local sentinel_region =
				cm:model():world():region_manager():region_by_key("wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel")
			cm:instantly_set_settlement_primary_slot_level(sentinel_region:settlement(), 2)

			local antoch_region = cm:model():world():region_manager():region_by_key("wh2_main_shifting_sands_antoch")
			cm:instantly_set_settlement_primary_slot_level(antoch_region:settlement(), 3)

			cm:heal_garrison(cm:get_region("wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel"):cqi())
			cm:heal_garrison(cm:get_region("wh2_main_northern_great_jungle_temple_of_tlencan"):cqi())
			cm:heal_garrison(cm:get_region("wh2_main_shifting_sands_antoch"):cqi())

			cm:transfer_region_to_faction("wh2_main_southern_jungle_of_pahualaxa_pahuax", "wh2_main_grn_blue_vipers")

			local pahuax_region =
				cm:model():world():region_manager():region_by_key("wh2_main_southern_jungle_of_pahualaxa_pahuax")
			cm:instantly_set_settlement_primary_slot_level(pahuax_region:settlement(), 2)

			cm:teleport_to("faction:wh2_main_grn_blue_vipers,surname:2147355514", 70, 237, true)

			cm:force_grant_military_access("wh_main_brt_lyonesse", "wh_main_brt_bretonnia", false)

			cm:force_make_vassal("wh_main_emp_empire", "wh2_main_emp_sudenburg")

			cm:force_make_peace("wh_main_emp_marienburg", "wh_main_brt_bretonnia")

			cm:apply_dilemma_diplomatic_bonus("wh2_main_emp_sudenburg", "wh_main_brt_bretonnia", 6)
			cm:apply_dilemma_diplomatic_bonus("wh2_main_emp_sudenburg", "wh_main_brt_carcassonne", 6)
			cm:apply_dilemma_diplomatic_bonus("wh2_main_wef_bowmen_of_oreon", "wh_main_brt_bretonnia", 6)

			if 1 == cm:random_number(3, 1) then
				cm:force_declare_war("wh2_main_lzd_xlanhuapec", "wh_main_emp_empire", false, false)
				cm:force_declare_war("wh2_main_nor_skeggi", "wh_main_brt_bordeleaux", false, false)
				cm:force_declare_war("wh2_main_lzd_tlaxtlan", "wh_main_brt_carcassonne", false, false)
			elseif 2 == cm:random_number(3, 1) then
				cm:force_declare_war("wh2_dlc11_cst_vampire_coast", "wh_main_emp_empire", false, false)
				cm:force_declare_war("wh2_main_emp_new_world_colonies", "wh_main_brt_bordeleaux", false, false)
				cm:force_declare_war("wh2_main_lzd_xlanhuapec", "wh_main_brt_carcassonne", false, false)
			else
				cm:force_declare_war("wh2_dlc09_tmb_rakaph_dynasty", "wh_main_emp_empire", false, false)
				cm:force_declare_war("wh2_main_grn_blue_vipers", "wh_main_brt_bordeleaux", false, false)
				cm:force_declare_war("wh2_dlc11_cst_vampire_coast", "wh_main_brt_carcassonne", false, false)
			end
		end
	end
end

local mcm = _G.mcm
local mct = core:get_static_object("mod_configuration_tool")
if not (not mcm) and not mct then
	local ovn = nil
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn")
	else
		ovn = mcm:register_mod("ovn", "OvN - Second Start", "Let's you enable/disable various parts of the mod.")
	end
	local crusade =
		ovn:add_tweaker(
		"crusade",
		"Human Colonies",
		"Gives the Empire, Tilea and major Bretonnian factions a second settlement in exotic locations, see mod page for exact settlements"
	)
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
		if mct then
			local sr = mct:get_mod_by_key("sr")
			local enable = sr:get_option_by_key("enable")
			enable:set_read_only(true)
			enable_setting = enable:get_finalized_setting()
			local crusade_plus = sr:get_option_by_key("crusade_plus")
			crusade_plus:set_read_only(true)
			crusade_plus_setting = crusade_plus:get_finalized_setting()
			if enable_setting and crusade_plus_setting then 
				sr_crusade_plus()
			end
		elseif not mcm or cm:get_saved_value("mcm_tweaker_ovn_crusade_value") == "enable" then
			sr_crusade_plus()
		end
	end
)
