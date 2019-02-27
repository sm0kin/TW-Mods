local function sr_vermintide()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh_main_the_wasteland_gorssel", "wh2_main_skv_clan_pestilens")
			cm:transfer_region_to_faction("wh_main_the_silver_road_mount_squighorn", "wh2_dlc09_skv_clan_rictus")
			cm:transfer_region_to_faction("wh_main_black_mountains_mighdal_vongalbarak", "wh2_main_skv_clan_mors")
			cm:transfer_region_to_faction("wh_main_northern_worlds_edge_mountains_khazid_irkulaz", "wh2_main_skv_clan_moulder")

			cm:create_force(
				"wh2_main_skv_clan_pestilens",
				"wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_plague_monks,wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrat_spearmen_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				430,
				500,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh2_dlc09_skv_clan_rictus",
				"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrat_spearmen_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				763,
				345,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh2_main_skv_clan_moulder",
				"wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_inf_skavenslave_spearmen_0,wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrat_spearmen_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				765,
				490,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			cm:create_force(
				"wh2_main_skv_clan_mors",
				"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				618,
				370,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			if not cm:get_faction("wh_main_grn_crooked_moon"):is_human() then
				cm:teleport_to("faction:wh_main_grn_crooked_moon,forename:2147358016", 710, 270, true)

				cm:transfer_region_to_faction("wh_main_southern_grey_mountains_karak_azgaraz", "wh2_main_skv_clan_skyre")

				cm:create_force(
					"wh2_main_skv_clan_skyre",
					"wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_poison_wind_globadiers,wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrat_spearmen_1",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					471,
					406,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
					end
				)

				cm:instantly_upgrade_building("wh_main_southern_grey_mountains_karak_azgaraz:0", "wh2_main_skv_settlement_minor_3")
				cm:instantly_upgrade_building("wh_main_southern_grey_mountains_karak_azgaraz:1", "wh2_main_skv_defence_minor_2")
				
				local k8p_region = cm:get_region("wh_main_eastern_badlands_karak_eight_peaks")
				if k8p_region:owning_faction():name() == "wh_main_grn_necksnappers" then
					cm:transfer_region_to_faction("wh_main_eastern_badlands_karak_eight_peaks", "wh_main_grn_crooked_moon")
				end
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
	local vermintide = ovn:add_tweaker("vermintide", "Vermintide Under Empire", "")
	vermintide:add_option("enable", "Enable", "")
	vermintide:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_vermintide_value") == "enable" then
				sr_vermintide()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_vermintide_value") == "enable" then sr_vermintide() end
	end
)