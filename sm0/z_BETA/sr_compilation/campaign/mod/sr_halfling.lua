local function sr_halfling()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			if cm:get_faction("wh_main_emp_empire_separatists"):is_human() then
				cm:scroll_camera_with_cutscene_to_settlement(6, end_callback, "wh_main_stirland_the_moot")

			--local moot_region = "wh_main_stirland_the_moot";
			--cm:make_region_visible_in_shroud(local_faction, moot_region);
			end

			cm:transfer_region_to_faction("wh_main_reikland_eilhart", "wh_main_emp_empire")
			cm:transfer_region_to_faction("wh_main_reikland_grunburg", "wh_main_emp_empire")
			cm:transfer_region_to_faction("wh_main_wissenland_wissenburg", "wh_main_emp_wissenland")
			cm:transfer_region_to_faction("wh_main_stirland_the_moot", "wh_main_emp_empire_separatists")

			if cm:get_saved_value("ovn_comp") then
				cm:transfer_region_to_faction("wh_main_reikland_helmgart", "wh_dlc08_nor_naglfarlings")

				cm:force_declare_war("wh_main_emp_empire", "wh_dlc08_nor_naglfarlings", true, true)
			else
				cm:transfer_region_to_faction("wh_main_reikland_helmgart", "wh_main_grn_skullsmasherz")
			end

			cm:instantly_dismantle_building("wh_main_reikland_eilhart:0")
			cm:instantly_dismantle_building("wh_main_reikland_eilhart:1")
			cm:instantly_dismantle_building("wh_main_reikland_eilhart:2")
			cm:instantly_upgrade_building("wh_main_reikland_eilhart:0", "wh_main_emp_settlement_minor_1")

			cm:force_make_peace("wh_main_emp_empire_separatists", "wh_main_emp_empire")
			cm:force_make_peace("wh_main_emp_empire_separatists", "wh_main_emp_wissenland")

			local moot = cm:get_faction("wh_main_emp_empire_separatists")

			if moot:has_faction_leader() and moot:faction_leader():has_military_force() then
				local moot_faction_leader_cqi = moot:faction_leader():command_queue_index()
				cm:set_character_immortality(cm:char_lookup_str(moot_faction_leader_cqi), false)

				cm:kill_character(moot_faction_leader_cqi, true, true)
			end

			cm:create_force_with_general(
				"wh_main_emp_empire_separatists",
				"wh_main_emp_inf_spearmen_0,wh_main_emp_inf_handgunners,wh_main_emp_inf_handgunners,wh_main_emp_inf_swordsmen,wh_main_emp_inf_halberdiers,wh_main_emp_inf_halberdiers,wh_dlc04_emp_inf_flagellants_0,wh_dlc04_emp_inf_flagellants_0,wh_main_emp_inf_greatswords,wh_dlc04_emp_inf_free_company_militia_0,wh_main_emp_inf_crossbowmen,wh_dlc04_emp_cav_knights_blazing_sun_0,wh_main_emp_art_helblaster_volley_gun,wh_main_emp_art_great_cannon",
				"wh2_main_northern_great_jungle_temple_of_tlencan",
				620,
				407,
				"general",
				"dlc04_emp_arch_lector",
				"names_name_1904032251",
				"",
				"",
				"",
				true,
				function(cqi)
					cm:add_agent_experience("faction:wh_main_emp_empire_separatists,forname:1904032251", 5000)
				end
			)

			--local secessionists = cm:get_faction("wh_main_emp_empire_separatists");
			--local secessionists_cqi = secessionists:faction_leader():command_queue_index();

			--local mootfl = Get_Character("names_name_2147344019", "wh_main_emp_empire_separatists");

			--cm:remove_unit_from_character(cm:char_lookup_str(mootfl), "wh_main_emp_inf_swordsmen");
			--cm:remove_unit_from_character(cm:char_lookup_str(mootfl), "wh_main_emp_inf_swordsmen");
			--cm:remove_unit_from_character(cm:char_lookup_str(mootfl), "wh_main_emp_inf_spearmen_0");
			--cm:remove_unit_from_character(cm:char_lookup_str(mootfl), "wh_main_emp_inf_crossbowmen");
			--cm:grant_unit_to_character(cm:char_lookup_str(mootfl), "wh2_dlc10_hef_mon_treeman_0");
			--cm:grant_unit_to_character(cm:char_lookup_str(mootfl), "wh2_main_hef_mon_great_eagle");
			--	cm:grant_unit_to_character(cm:char_lookup_str(mootfl), "halfling_archer");
			--cm:grant_unit_to_character(cm:char_lookup_str(mootfl), "halfling_archer");

			--out("017 - Starting_Units_Reikland_Secessionists");

			cm.game_interface:kill_character_and_commanded_unit(
				"faction:wh_main_emp_empire_separatists,surname:2147344019",
				true,
				true
			)
		--cm:teleport_to("faction:wh_main_emp_empire_separatists,surname:2147344019", 620, 407, true);
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
	local halfling = ovn:add_tweaker("halfling", "Halfling", "")
	halfling:add_option("enable", "Enable", "")
	halfling:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_halfling_value") == "enable" then
				sr_halfling()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_halfling_value") == "enable" then sr_halfling() end
	end
)