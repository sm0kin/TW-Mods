local function sr_dwarfcolonies()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			if cm:get_faction("wh_main_dwf_dwarfs"):is_human() then
				cm:transfer_region_to_faction("wh2_main_spine_of_sotek_hualotal", "wh_main_dwf_dwarfs")

				cm:create_force(
					"wh_main_dwf_dwarfs",
					"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
					"wh2_main_land_of_assassins_sorcerers_islands",
					80,
					60,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)
			end

			if cm:get_faction("wh_main_dwf_karak_kadrin"):is_human() then
				cm:transfer_region_to_faction("wh2_main_southlands_worlds_edge_mountains_lost_plateau", "wh_main_dwf_karak_kadrin")

				cm:create_force(
					"wh_main_dwf_karak_kadrin",
					"wh_main_dwf_inf_miners_0,wh_main_dwf_inf_miners_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_hammerers,wh_main_dwf_inf_dwarf_warrior_0",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					778,
					55,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)
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
	local dwarfcolonies =
		ovn:add_tweaker(
		"dwarfcolonies",
		"Dwarf Colonies",
		"Gives major Dwarf factions a second settlement in exotic locations, see mod page for exact settlements"
	)
	dwarfcolonies:add_option("enable", "Enable", "")
	dwarfcolonies:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_dwarfcolonies_value") == "enable" then
				sr_dwarfcolonies()
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
			local dwarfcolonies = sr:get_option_by_key("dwarfcolonies")
			dwarfcolonies:set_read_only(true)
			dwarfcolonies_setting = dwarfcolonies:get_finalized_setting()
			if enable_setting and dwarfcolonies_setting then 
				sr_dwarfcolonies()
			end
		elseif not mcm or cm:get_saved_value("mcm_tweaker_ovn_dwarfcolonies_value") == "enable" then
			sr_dwarfcolonies()
		end
	end
)
