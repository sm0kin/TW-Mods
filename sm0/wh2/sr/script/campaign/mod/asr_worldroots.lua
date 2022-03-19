local function sr_worldroots()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh2_main_spine_of_sotek_monument_of_izzatal", "wh_dlc05_wef_argwylon")

			cm:transfer_region_to_faction("wh2_main_gnoblar_country_haunted_forest", "wh_dlc05_wef_wood_elves")

			cm:create_force(
				"wh_dlc05_wef_wood_elves",
				"wh_dlc05_wef_cav_glade_riders_0,wh_dlc05_wef_inf_deepwood_scouts_0,wh_dlc05_wef_inf_deepwood_scouts_0,wh_dlc05_wef_inf_wildwood_rangers_0,wh_dlc05_wef_inf_dryads_0,wh_dlc05_wef_mon_great_eagle_0",
				"wh2_main_gnoblar_country_haunted_forest",
				983,
				275,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

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
					cm:set_character_immortality("faction:wh2_dlc11_cst_vampire_coast_rebels,forename:999982306", true)
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
local mct = core:get_static_object("mod_configuration_tool")
if not (not mcm) and not mct then
	local ovn = nil
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn")
	else
		ovn = mcm:register_mod("ovn", "OvN - Second Start", "Let's you enable/disable various parts of the mod.")
	end
	local worldroots =
		ovn:add_tweaker(
		"worldroots",
		"Wood Elf Colonies",
		"Gives major and minor Wood Elf factions a second settlement in exotic locations, see mod page for exact settlements"
	)
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
		if mct then
			local sr = mct:get_mod_by_key("sr")
			local enable = sr:get_option_by_key("enable")
			enable:set_read_only(true)
			enable_setting = enable:get_finalized_setting()
			local worldroots = sr:get_option_by_key("worldroots")
			worldroots:set_read_only(true)
			worldroots_setting = worldroots:get_finalized_setting()
			if enable_setting and worldroots_setting then 
				sr_worldroots()
			end
		elseif not mcm or cm:get_saved_value("mcm_tweaker_ovn_worldroots_value") == "enable" then
			sr_worldroots()
		end
	end
)
