local function sr_vermintide()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:transfer_region_to_faction("wh_main_the_wasteland_gorssel", "wh2_main_skv_clan_septik")
			cm:transfer_region_to_faction("wh_main_the_silver_road_mount_squighorn", "wh2_dlc09_skv_clan_rictus")
			cm:transfer_region_to_faction("wh_main_black_mountains_mighdal_vongalbarak", "wh2_main_skv_clan_eshin")
			cm:transfer_region_to_faction("wh_main_northern_worlds_edge_mountains_khazid_irkulaz", "wh2_main_skv_clan_moulder")
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

			cm:create_force(
				"wh2_main_skv_clan_septik",
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
				"wh2_main_skv_clan_pestilens",
				"wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_plague_monks,wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_clanrats_0,wh2_main_skv_inf_clanrat_spearmen_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				439,
				52,
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
				"wh2_main_skv_clan_eshin",
				"wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				618,
				370,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
				end
			)

			if cm:get_faction("wh2_main_skv_clan_pestilens"):is_human() then
				cm:transfer_region_to_faction("wh2_main_atalan_mountains_eye_of_the_panther", "wh2_main_skv_clan_pestilens")
			else
				cm:transfer_region_to_faction("wh2_main_atalan_mountains_vulture_mountain", "wh2_main_skv_clan_pestilens")
			end

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

				local azgaraz_region = cm:get_region("wh_main_southern_grey_mountains_karak_azgaraz")
				cm:instantly_set_settlement_primary_slot_level(azgaraz_region:settlement(), 3)
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
	local vermintide =
		ovn:add_tweaker(
		"vermintide",
		"Skaven Colonies",
		"Gives major and minor Skaven factions a second settlement in exotic locations, see mod page for exact settlements"
	)
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
		if mct then
			local sr = mct:get_mod_by_key("sr")
			local enable = sr:get_option_by_key("enable")
			enable:set_read_only(true)
			enable_setting = enable:get_finalized_setting()
			local vermintide = sr:get_option_by_key("vermintide")
			vermintide:set_read_only(true)
			vermintide_setting = vermintide:get_finalized_setting()
			if enable_setting and vermintide_setting then 
				sr_vermintide()
			end
		elseif not mcm or cm:get_saved_value("mcm_tweaker_ovn_vermintide_value") == "enable" then
			sr_vermintide()
		end
	end
)
