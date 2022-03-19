local function sr_norraid()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh_main_southern_badlands_gor_gazan", "wh_dlc08_nor_norsca")
			cm:transfer_region_to_faction("wh2_main_doom_glades_vauls_anvil", "wh_dlc08_nor_wintertooth")
			cm:transfer_region_to_faction("wh2_main_tiranoc_whitepeak", "wh_dlc08_nor_helspire_tribe")
			cm:create_force(
				"wh_dlc08_nor_wintertooth",
				"wh_dlc08_nor_mon_norscan_ice_trolls_0,wh_dlc08_nor_mon_fimir_0,wh_dlc08_nor_inf_marauder_spearman_0,wh_dlc08_nor_inf_marauder_berserkers_0,wh_main_nor_inf_chaos_marauders_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				95,
				470,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh_dlc08_nor_norsca",
				"wh_dlc08_nor_inf_marauder_champions_0,wh_dlc08_nor_inf_marauder_champions_1,wh_dlc08_nor_inf_marauder_spearman_0,wh_dlc08_nor_inf_marauder_berserkers_0,wh_main_nor_inf_chaos_marauders_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				527,
				160,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh_dlc08_nor_helspire_tribe",
				"wh_dlc08_nor_inf_marauder_champions_1,wh_dlc08_nor_inf_marauder_spearman_0,wh_dlc08_nor_inf_marauder_berserkers_0,wh_main_nor_inf_chaos_marauders_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				147,
				318,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:force_declare_war("wh_main_grn_top_knotz", "wh_dlc08_nor_norsca", true, true)
			cm:force_declare_war("wh2_main_def_bleak_holds", "wh_dlc08_nor_wintertooth", true, true)
			cm:force_declare_war("wh2_main_hef_tiranoc", "wh_dlc08_nor_helspire_tribe", true, true)
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
	local norraid =
		ovn:add_tweaker(
		"norraid",
		"Norsca Colonies",
		"Gives major and minor Norscan factions a second settlement in exotic locations, see mod page for exact settlements"
	)
	norraid:add_option("enable", "Enable", "")
	norraid:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_norraid_value") == "enable" then
				sr_norraid()
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
			local norraid = sr:get_option_by_key("norraid")
			norraid:set_read_only(true)
			norraid_setting = norraid:get_finalized_setting()
			if enable_setting and norraid_setting then 
				sr_norraid()
			end
		elseif not mcm or cm:get_saved_value("mcm_tweaker_ovn_norraid_value") == "enable" then
			sr_norraid()
		end
	end
)
