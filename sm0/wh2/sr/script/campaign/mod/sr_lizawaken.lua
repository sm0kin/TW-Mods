local function sr_lizawaken()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh_main_desolation_of_nagash_black_iron_mine", "wh2_main_lzd_last_defenders")

			cm:create_force(
				"wh2_main_lzd_last_defenders",
				"wh2_main_lzd_inf_temple_guards,wh2_main_lzd_inf_skink_skirmishers_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_saurus_spearmen_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				765,
				289,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			if cm:get_faction("wh2_main_lzd_hexoatl"):is_human() then
				cm:transfer_region_to_faction("wh2_main_blackspine_mountains_plain_of_dogs", "wh2_main_lzd_hexoatl")

				cm:create_force(
					"wh2_main_lzd_hexoatl",
					"wh2_main_lzd_inf_temple_guards,wh2_main_lzd_inf_skink_skirmishers_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_saurus_spearmen_0",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					13,
					435,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)
			end

			if cm:get_faction("wh2_main_lzd_tlaqua"):is_human() then
				cm:transfer_region_to_faction("wh2_main_albion_isle_of_wights", "wh2_main_lzd_tlaqua")

				cm:create_force(
					"wh2_main_lzd_tlaqua",
					"wh2_main_lzd_inf_temple_guards,wh2_main_lzd_inf_skink_skirmishers_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_saurus_spearmen_0",
					"wh2_main_land_of_assassins_sorcerers_islands",
					328,
					543,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)
			end

			if cm:get_faction("wh2_dlc12_lzd_cult_of_sotek"):is_human() then
				cm:transfer_region_to_faction("wh2_main_albion_isle_of_wights", "wh2_dlc12_lzd_cult_of_sotek")

				cm:create_force(
					"wh2_dlc12_lzd_cult_of_sotek",
					"wh2_main_lzd_inf_temple_guards,wh2_main_lzd_inf_skink_skirmishers_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_saurus_spearmen_0",
					"wh2_main_land_of_assassins_sorcerers_islands",
					328,
					543,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)
			end

			if cm:get_faction("wh2_main_lzd_itza"):is_human() then
				cm:transfer_region_to_faction("wh2_main_albion_isle_of_wights", "wh2_main_lzd_itza")

				cm:create_force(
					"wh2_main_lzd_itza",
					"wh2_main_lzd_inf_temple_guards,wh2_main_lzd_inf_skink_skirmishers_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_saurus_spearmen_0",
					"wh2_main_land_of_assassins_sorcerers_islands",
					328,
					543,
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
	local lizawaken =
		ovn:add_tweaker(
		"lizawaken",
		"Lizardmen Colonies",
		"Gives major Lizardmen factions a second settlement in exotic locations, see mod page for exact settlements"
	)
	lizawaken:add_option("enable", "Enable", "")
	lizawaken:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_lizawaken_value") == "enable" then
				sr_lizawaken()
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
			local lizawaken = sr:get_option_by_key("lizawaken")
			lizawaken:set_read_only(true)
			lizawaken_setting = lizawaken:get_finalized_setting()
			if enable_setting and lizawaken_setting then 
				sr_lizawaken()
			end
		elseif not mcm or cm:get_saved_value("mcm_tweaker_ovn_lizawaken_value") == "enable" then
			sr_lizawaken()
		end
	end
)
