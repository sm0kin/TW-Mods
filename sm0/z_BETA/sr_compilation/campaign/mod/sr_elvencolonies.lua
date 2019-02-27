local function sr_elvencolonies()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:treasury_mod("wh2_main_hef_avelorn", 10000)

			cm:create_force_with_general(
				"wh2_main_hef_avelorn",
				"wh2_main_hef_inf_lothern_sea_guard_0,wh2_main_hef_mon_moon_dragon,wh2_main_hef_inf_spearmen_0,wh2_main_hef_inf_phoenix_guard,AK_hef_sea_rangers,AK_hef_sea_company",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				973,
				36,
				"general",
				"wh2_main_hef_prince",
				"names_name_999982295",
				"",
				"",
				"",
				false,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			if vfs.exists("script/export_helpers__ak_seahelm_units_recruit_caps.lua") then
				cm:create_force_with_general(
					"wh2_main_hef_order_of_loremasters",
					"wh2_main_hef_inf_lothern_sea_guard_0,AK_hef_sea_silver,AK_hef_sea_rangers,AK_hef_sea_rangers,wh2_main_hef_art_eagle_claw_bolt_thrower,AK_hef_sea_company,AK_hef_sea_roc_riders",
					"wh2_main_land_of_assassins_sorcerers_islands",
					560,
					605,
					"general",
					"AK_hef_seahelm",
					"names_name_999982297",
					"",
					"",
					"",
					false,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_aislinn", cqi, -1, true)
					end
				)
			else
				cm:create_force_with_general(
					"wh2_main_hef_order_of_loremasters",
					"wh2_main_hef_inf_lothern_sea_guard_1,wh2_main_hef_inf_lothern_sea_guard_1,wh2_dlc10_hef_inf_shadow_walkers_0,wh2_dlc10_hef_inf_shadow_walkers_0,wh2_main_hef_art_eagle_claw_bolt_thrower",
					"wh2_main_land_of_assassins_sorcerers_islands",
					560,
					605,
					"general",
					"wh2_main_hef_prince",
					"names_name_999982297",
					"",
					"",
					"",
					false,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_aislinn", cqi, -1, true)
					end
				)
			end
			if cm:get_faction("wh2_main_hef_eataine"):is_human() then
				cm:create_force_with_general(
					"wh2_main_hef_eataine",
					"wh2_dlc10_hef_inf_shadow_walkers_0,wh2_main_hef_inf_archers_1,wh2_main_hef_cav_silver_helms_1,wh2_main_hef_inf_spearmen_0,wh2_main_hef_inf_spearmen_0,wh2_main_hef_art_eagle_claw_bolt_thrower,AK_hef_sea_rangers,AK_hef_sea_company",
					"wh2_main_land_of_assassins_sorcerers_islands",
					610,
					235,
					"general",
					"sr_grim",
					"names_name_999982298",
					"",
					"",
					"",
					false,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						cm:add_agent_experience("faction:wh2_main_hef_eataine,forename:999982298", 800)
						cm:set_character_immortality("faction:wh2_main_hef_eataine,forename:999982298", true)
					end
				)

				cm:transfer_region_to_faction("wh_main_western_badlands_dragonhorn_mines", "wh2_main_hef_eataine")
			else
				cm:create_force_with_general(
					"wh2_main_hef_yvresse",
					"wh2_dlc10_hef_inf_shadow_walkers_0,wh2_main_hef_inf_archers_1,wh2_main_hef_cav_silver_helms_1,wh2_main_hef_inf_spearmen_0,wh2_main_hef_inf_spearmen_0,wh2_main_hef_art_eagle_claw_bolt_thrower,AK_hef_sea_rangers,AK_hef_sea_company",
					"wh2_main_land_of_assassins_sorcerers_islands",
					610,
					235,
					"general",
					"sr_grim",
					"names_name_999982298",
					"",
					"",
					"",
					false,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
						cm:add_agent_experience("faction:wh2_main_hef_yvresse,forename:999982298", 800)
						cm:set_character_immortality("faction:wh2_main_hef_yvresse,forename:999982298", true)
					end
				)

				cm:transfer_region_to_faction("wh_main_western_badlands_dragonhorn_mines", "wh2_main_hef_yvresse")
			end

			if cm:get_faction("wh2_main_hef_nagarythe"):is_human() then
				cm:create_force_with_general(
					"wh2_main_hef_nagarythe",
					"wh2_main_hef_inf_lothern_sea_guard_0,wh2_main_hef_inf_white_lions_of_chrace_0,wh2_main_hef_cav_dragon_princes,wh2_main_hef_inf_white_lions_of_chrace_0,wh2_main_hef_inf_gate_guard,AK_hef_sea_rangers,AK_hef_sea_company",
					"wh2_main_land_of_assassins_sorcerers_islands",
					372,
					48,
					"general",
					"wh2_main_hef_prince_alastar",
					"names_name_999982296",
					"",
					"",
					"",
					false,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)

				cm:transfer_region_to_faction("wh2_main_land_of_assassins_sorcerers_islands", "wh2_main_hef_nagarythe")
			else
				cm:create_force_with_general(
					"wh2_main_hef_saphery",
					"wh2_main_hef_inf_lothern_sea_guard_0,wh2_main_hef_inf_white_lions_of_chrace_0,wh2_main_hef_cav_dragon_princes,wh2_main_hef_inf_white_lions_of_chrace_0,wh2_main_hef_inf_gate_guard,AK_hef_sea_rangers,AK_hef_sea_company",
					"wh2_main_land_of_assassins_sorcerers_islands",
					372,
					48,
					"general",
					"wh2_main_hef_prince_alastar",
					"names_name_999982296",
					"",
					"",
					"",
					false,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)

				cm:transfer_region_to_faction("wh2_main_land_of_assassins_sorcerers_islands", "wh2_main_hef_saphery")
			end

			cm:transfer_region_to_faction("wh2_main_kingdom_of_beasts_serpent_coast", "wh2_main_hef_avelorn")
			cm:transfer_region_to_faction("wh_main_trollheim_mountains_bay_of_blades", "wh2_main_hef_order_of_loremasters")

			cm:force_declare_war("wh2_main_hef_order_of_loremasters", "wh_main_nor_varg", false, false)

			cm:force_make_peace("wh2_main_hef_yvresse", "wh2_main_hef_eataine")
			cm:force_make_peace("wh2_main_hef_yvresse", "wh_main_brt_carcassonne")
			cm:force_make_peace("wh2_main_hef_cothique", "wh2_main_hef_eataine")
			cm:force_make_peace("wh2_main_hef_cothique", "wh_main_brt_lyonesse")

			cm:teleport_to("faction:wh2_dlc09_tmb_followers_of_nagash,forename:1543395740", 400, 40, true)
			cm:teleport_to("faction:wh_main_grn_teef_snatchaz,forename:2147344966", 560, 215, true)

			if not cm:get_faction("wh2_dlc09_tmb_followers_of_nagash"):is_human() then
				cm:teleport_to("faction:wh2_dlc09_tmb_rakaph_dynasty,forename:1531306469", 510, 90, true)
				cm:transfer_region_to_faction(
					"wh2_main_great_desert_of_araby_black_tower_of_arkhan",
					"wh2_dlc09_tmb_followers_of_nagash"
				)
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
	local elvencolonies = ovn:add_tweaker("elvencolonies", "Elven Expedition", "")
	elvencolonies:add_option("enable", "Enable", "")
	elvencolonies:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_elvencolonies_value") == "enable" then
				sr_elvencolonies()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_elvencolonies_value") == "enable" then sr_elvencolonies() end
	end
)