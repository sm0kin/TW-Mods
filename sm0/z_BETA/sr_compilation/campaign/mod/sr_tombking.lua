local function sr_tombking()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh2_main_headhunters_jungle_mangrove_coast", "wh2_dlc09_tmb_lybaras")
			cm:transfer_region_to_faction("wh_main_the_vaults_zarakzil", "wh2_dlc09_tmb_khemri")
			cm:transfer_region_to_faction("wh_main_western_badlands_bitterstone_mine", "wh2_dlc09_tmb_exiles_of_nehek")
			cm:transfer_region_to_faction("wh_main_desolation_of_nagash_spitepeak", "wh2_dlc09_tmb_followers_of_nagash")

			cm:instantly_upgrade_building("wh_main_desolation_of_nagash_spitepeak:0", "wh2_dlc09_tmb_settlement_minor_3")
			cm:instantly_upgrade_building("wh_main_desolation_of_nagash_spitepeak:2", "wh2_dlc09_tmb_defence_minor_2")

			cm:create_force(
				"wh2_dlc09_tmb_lybaras",
				"wh2_dlc09_tmb_mon_sepulchral_stalkers_0,wh2_dlc09_tmb_cav_necropolis_knights_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_skeleton_archers_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				215,
				15,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh2_dlc09_tmb_khemri",
				"wh2_dlc09_tmb_mon_ushabti_0,wh2_pro06_tmb_mon_bone_giant_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_skeleton_archers_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				512,
				266,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh2_dlc09_tmb_exiles_of_nehek",
				"wh2_dlc09_tmb_mon_ushabti_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_archers_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				628,
				268,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force_with_general(
				"wh2_dlc09_tmb_followers_of_nagash",
				"wh2_dlc09_tmb_mon_ushabti_0,wh2_pro06_tmb_mon_bone_giant_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_nehekhara_warriors_0,wh2_dlc09_tmb_inf_skeleton_archers_0",
				"wh2_main_land_of_assassins_sorcerers_islands",
				783,
				235,
				"general",
				"wh2_dlc09_tmb_tomb_king",
				"names_name_999982297",
				"",
				"",
				"",
				false,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:force_declare_war("wh2_dlc09_tmb_lybaras", "wh2_main_skv_clan_pestilens", false, false)
			cm:force_declare_war("wh2_dlc09_tmb_exiles_of_nehek", "wh_main_grn_scabby_eye", false, false)
			cm:force_declare_war("wh2_dlc09_tmb_khemri", "wh_main_grn_broken_nose", false, false)
			cm:force_declare_war("wh2_dlc09_tmb_followers_of_nagash", "wh_main_dwf_karak_azul", false, false)
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
	local tombking = ovn:add_tweaker("tombking", "Restoration of Nehekhara", "")
	tombking:add_option("enable", "Enable", "")
	tombking:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_tombking_value") == "enable" then
				sr_tombking()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_tombking_value") == "enable" then sr_tombking() end
	end
)