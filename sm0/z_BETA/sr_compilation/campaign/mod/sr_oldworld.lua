local function sr_oldworld()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh_main_southern_grey_mountains_karak_norn", "wh_main_vmp_rival_sylvanian_vamps")
			cm:transfer_region_to_faction("wh_main_talabecland_kemperbad", "wh_main_grn_broken_nose")

			cm:instantly_upgrade_building("wh_main_southern_grey_mountains_grimhold:0", "wh_main_dwf_settlement_minor_3")
			cm:instantly_upgrade_building("wh_main_southern_grey_mountains_grimhold:1", "wh_main_dwf_garrison_2")
			cm:instantly_upgrade_building("wh_main_talabecland_kemperbad:0", "wh_main_grn_settlement_minor_3")
			cm:instantly_upgrade_building("wh_main_talabecland_kemperbad:1", "wh_main_grn_garrison_2")
			cm:instantly_upgrade_building("wh_main_southern_grey_mountains_karak_norn:0", "wh_main_vmp_settlement_major_2")
			cm:instantly_upgrade_building("wh_main_southern_grey_mountains_karak_norn:1", "wh2_main_special_blood_keep")

			cm:create_force_with_general(
				"wh_main_vmp_rival_sylvanian_vamps",
				"wh_dlc02_vmp_cav_blood_knights_0,wh_dlc02_vmp_cav_blood_knights_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_1",
				"wh2_main_land_of_assassins_sorcerers_islands",
				510,
				380,
				"general",
				"vmp_lord",
				"names_name_2147345217",
				"",
				"names_name_2147345172",
				"",
				true,
				function(cqi)
					cm:set_character_unique("faction:wh_main_vmp_rival_sylvanian_vamps,surname:2147345313", true)
					cm:set_character_immortality("faction:wh_main_vmp_rival_sylvanian_vamps,surname:2147345313", true)
				end
			)

			cm:create_force(
				"wh_main_grn_broken_nose",
				"wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_big_uns,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_cav_orc_boar_boyz",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				536,
				452,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
				end
			)

			cm:force_declare_war("wh_main_vmp_rival_sylvanian_vamps", "wh_main_emp_wissenland", false, false)
			cm:force_declare_war("wh_main_grn_broken_nose", "wh_main_emp_talabecland", false, false)
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
	local oldworld = ovn:add_tweaker("oldworld", "Evils of the Old World", "")
	oldworld:add_option("enable", "Enable", "")
	oldworld:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_oldworld_value") == "enable" then
				sr_oldworld()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_oldworld_value") == "enable" then sr_oldworld() end
	end
)