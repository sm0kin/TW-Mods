local function sr_worldroots()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh2_main_spine_of_sotek_monument_of_izzatal", "wh_dlc05_wef_argwylon")
			cm:transfer_region_to_faction("wh_main_nordland_dietershafen", "wh_dlc05_wef_wydrioth")

			if cm:get_faction("wh_dlc05_wef_wood_elves"):is_human() then
				cm:teleport_to("faction:wh2_main_vmp_necrarch_brotherhood,forename:2147359170", 675, 65, true)

				cm:transfer_region_to_faction("wh2_main_shifting_sands_ka-sabar", "wh_dlc05_wef_wood_elves")
				cm:instantly_upgrade_building("wh2_main_shifting_sands_ka-sabar:0", "wh_dlc05_wef_outpost_major_human_1")

				cm:create_force(
					"wh_dlc05_wef_wood_elves",
					"wh_dlc05_wef_cav_glade_riders_0,wh_dlc05_wef_inf_deepwood_scouts_0,wh_dlc05_wef_inf_deepwood_scouts_0,wh_dlc05_wef_inf_wildwood_rangers_0,wh_dlc05_wef_inf_dryads_0,wh_dlc05_wef_mon_great_eagle_0",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					710,
					40,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)
			end

			cm:create_force_with_general(
				"wh2_main_wef_bowmen_of_oreon",
				"wh_dlc05_wef_cav_glade_riders_0,wh_dlc05_wef_inf_deepwood_scouts_0,wh_dlc05_wef_inf_deepwood_scouts_0,wh_dlc05_wef_inf_wildwood_rangers_0,wh_dlc05_wef_inf_dryads_0,wh_dlc05_wef_mon_great_eagle_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				705,
				25,
				"general",
				"dlc05_wef_glade_lord",
				"names_name_999982299",
				"",
				"",
				"",
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					cm:add_agent_experience("faction:wh2_main_wef_bowmen_of_oreon,forename:999982299", 3200)
				end
			)

			cm:create_force(
				"wh_dlc05_wef_argwylon",
				"wh_dlc05_wef_cav_glade_riders_0,wh_dlc05_wef_inf_deepwood_scouts_0,wh_dlc05_wef_inf_deepwood_scouts_0,wh_dlc05_wef_inf_wildwood_rangers_0,wh_dlc05_wef_inf_dryads_0,wh_dlc05_wef_mon_great_eagle_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				73,
				95,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)
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
	local worldroots = ovn:add_tweaker("worldroots", "Worldroots", "")
	worldroots:add_option("enable", "Enable", "")
	worldroots:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_worldroots_value") == "enable" then
				sr_worldroots()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_worldroots_value") == "enable" then sr_worldroots() end
	end
)