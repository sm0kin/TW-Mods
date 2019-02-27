local function sr_lizawaken()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh_main_desolation_of_nagash_black_iron_mine", "wh2_main_lzd_last_defenders")
			cm:transfer_region_to_faction("wh2_main_shifting_sands_antoch", "wh2_main_lzd_itza")
			cm:transfer_region_to_faction("wh2_main_blackspine_mountains_plain_of_dogs", "wh2_main_lzd_tlaxtlan")

			cm:create_force(
				"wh2_main_lzd_tlaxtlan",
				"wh2_main_lzd_inf_temple_guards,wh2_main_lzd_inf_skink_skirmishers_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_saurus_spearmen_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				13,
				435,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

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
			cm:create_force(
				"wh2_main_lzd_itza",
				"wh2_main_lzd_inf_temple_guards,wh2_main_lzd_inf_skink_skirmishers_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_saurus_spearmen_0",
				"wh2_main_land_of_assassins_sorcerers_islands",
				660,
				25,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			if cm:get_faction("wh2_main_lzd_hexoatl"):is_human() then
				cm:transfer_region_to_faction("wh2_main_cothique_mistnar", "wh2_main_lzd_hexoatl")

				cm:create_force(
					"wh2_main_lzd_hexoatl",
					"wh2_main_lzd_inf_temple_guards,wh2_main_lzd_inf_skink_skirmishers_0,wh2_main_lzd_inf_skink_cohort_1,wh2_main_lzd_inf_saurus_warriors_0,wh2_main_lzd_inf_saurus_spearmen_0",
					"wh2_main_land_of_assassins_sorcerers_islands",
					290,
					420,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)
			else
				cm:transfer_region_to_faction("wh2_main_cothique_mistnar", "wh2_main_skv_clan_gnaw")

				cm:create_force(
					"wh2_main_skv_clan_gnaw",
					"wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_poison_wind_globadiers,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrat_spearmen_1",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					290,
					420,
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

if not not mcm then
	local ovn = nil;
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn");
	else
		ovn = mcm:register_mod("ovn", "OvN - Overhaul", "Let's you enable/disable various parts of the compilation.")
	end
	local lizawaken = ovn:add_tweaker("lizawaken", "Lizardmen Awaken", "")
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
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_lizawaken_value") == "enable" then sr_lizawaken() end
	end
)