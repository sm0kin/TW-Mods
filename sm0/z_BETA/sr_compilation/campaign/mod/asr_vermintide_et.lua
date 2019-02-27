local function sr_vermintide_et()
	if cm:model():campaign_name("main_warhammer") then
		core:add_listener(
			"vermintidestartlistner",
			"FactionRoundStart",
			function(context)
				return context:faction():is_human() and cm:model():turn_number() == 153
			end,
			function()
				vermintidestart()
			end,
			false
		)
	end
end

function vermintidestart()
	--- this function spawns skaven armies, displays a message to player,
	---	adds listner for 25 turn destroy event and message event 10 turns before destroy event occurs.

	--- This message states the start of vermintide and includes that they have 25 turns before the endtimes occur

	vtmessstart()
	core:add_listener(
		"etwarningmess10turnlistner",
		"FactionRoundStart",
		function(context)
			return context:faction():is_human() and cm:model():turn_number() == 168
		end,
		function()
			vt_endtimes_warning10()
		end,
		false
	)

	core:add_listener(
		"etwarningmess5turnlistner",
		"FactionRoundStart",
		function(context)
			return context:faction():is_human() and cm:model():turn_number() == 173
		end,
		function()
			vt_endtimes_warning5()
		end,
		false
	)

	core:add_listener(
		"elfinterventionlistner",
		"FactionTurnStart",
		function(context)
			return context:faction():name() == "wh2_main_hef_saphery" and cm:model():turn_number() == 169
		end,
		function()
			order_intervention_elf()
		end,
		false
	)

	core:add_listener(
		"maninterventionlistner",
		"FactionTurnStart",
		function(context)
			return context:faction():name() == "wh_main_teb_tilea" and cm:model():turn_number() == 169
		end,
		function()
			order_intervention_man()
		end,
		false
	)

	core:add_listener(
		"vtendtimesstartlistner",
		"FactionRoundStart",
		function(context)
			return context:faction():is_human() and cm:model():turn_number() == 178
		end,
		function()
			vt_endtimes()
		end,
		false
	)

	core:add_listener(
		"skavenblightoccupylistner",
		"GarrisonOccupiedEvent",
		function(context)
			return context:character():region():name() == "wh2_main_skavenblight_skavenblight" and
				cm:model():turn_number() >= 153 and
				cm:model():turn_number() <= 178
		end,
		function()
			occupy_mess_skavenblight()
		end,
		true
	)

	core:add_listener(
		"oxyloccupylistner",
		"GarrisonOccupiedEvent",
		function(context)
			return context:character():region():name() == "wh2_main_headhunters_jungle_oyxl" and cm:model():turn_number() >= 153 and
				cm:model():turn_number() <= 178
		end,
		function()
			occupy_mess_oxyl()
		end,
		true
	)

	---Spawns the Skaven armies ala VERMINTIDE!!!!
	vermintide_armies()

	---Checks if player is skaven if so does nothing if skaven is AI need to ensure they have the settlements or if settlements controlled by the player an army spawns to help them take it.

	if
		cm:get_faction("wh2_dlc09_skv_clan_rictus"):is_human() or cm:get_faction("wh2_main_skv_clan_mors"):is_human() or
			cm:get_faction("wh2_main_skv_clan_skyre"):is_human() or
			cm:get_faction("wh2_main_skv_clan_pestilens"):is_human()
	 then
	else
		local skavenblight_region = cm:get_region("wh2_main_skavenblight_skavenblight")
		local human_players = cm:get_human_factions()

		if skavenblight_region:owning_faction():name() == human_players[1] then
			cm:create_force_with_general(
				"wh2_main_skv_clan_skyre",
				"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
				"wh2_main_northern_great_jungle_temple_of_tlencan",
				450,
				270,
				"general",
				"wh2_main_skv_warlord",
				"names_name_1601665744",
				"",
				"",
				"",
				false,
				function(cqi)
					cm:add_agent_experience("faction:wh2_main_skv_clan_skyre,forename:1601665744", 20000)
					cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
				end
			)

			cm:force_declare_war("wh2_dlc09_skv_clan_rictus", human_players[1], true, true)
			cm:force_declare_war("wh2_main_skv_clan_mors", human_players[1], true, true)
			cm:force_declare_war("wh2_main_skv_clan_skyre", human_players[1], true, true)
			cm:force_declare_war("wh2_main_skv_clan_pestilens", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_skavenblight_skavenblight", "wh2_main_skv_clan_skyre")

			cm:create_force_with_general(
				"wh2_main_skv_clan_skyre",
				"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
				"wh2_main_northern_great_jungle_temple_of_tlencan",
				450,
				270,
				"general",
				"wh2_main_skv_warlord",
				"names_name_1601665744",
				"",
				"",
				"",
				false,
				function(cqi)
					cm:add_agent_experience("faction:wh2_main_skv_clan_skyre,forename:1601665744", 20000)
					cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
				end
			)
		end
	end

	if
		cm:get_faction("wh2_dlc09_skv_clan_rictus"):is_human() or cm:get_faction("wh2_main_skv_clan_mors"):is_human() or
			cm:get_faction("wh2_main_skv_clan_skyre"):is_human() or
			cm:get_faction("wh2_main_skv_clan_pestilens"):is_human()
	 then
	else
		local oyxl_region = cm:get_region("wh2_main_headhunters_jungle_oyxl")
		local human_players = cm:get_human_factions()

		if oyxl_region:owning_faction():name() == human_players[1] then
			cm:create_force_with_general(
				"wh2_main_skv_clan_pestilens",
				"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
				"wh2_main_land_of_assassins_sorcerers_islands",
				190,
				20,
				"general",
				"wh2_main_skv_warlord",
				"names_name_1305842795",
				"",
				"",
				"",
				false,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
					cm:add_agent_experience("faction:wh2_main_skv_clan_pestilens,forename:1305842795", 20000)
				end
			)

			cm:force_declare_war("wh2_dlc09_skv_clan_rictus", human_players[1], true, true)
			cm:force_declare_war("wh2_main_skv_clan_mors", human_players[1], true, true)
			cm:force_declare_war("wh2_main_skv_clan_skyre", human_players[1], true, true)
			cm:force_declare_war("wh2_main_skv_clan_pestilens", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_headhunters_jungle_oyxl", "wh2_main_skv_clan_pestilens")

			cm:create_force_with_general(
				"wh2_main_skv_clan_pestilens",
				"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
				"wh2_main_land_of_assassins_sorcerers_islands",
				190,
				20,
				"general",
				"wh2_main_skv_warlord",
				"names_name_1305842795",
				"",
				"",
				"",
				false,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
					cm:add_agent_experience("faction:wh2_main_skv_clan_pestilens,forename:1305842795", 20000)
				end
			)
		end
	end
end

function occupy_mess_skavenblight()
	local skavenblight_region = cm:get_region("wh2_main_skavenblight_skavenblight")

	if
		skavenblight_region:owning_faction():name() == "wh2_dlc09_skv_clan_rictus" or
			skavenblight_region:owning_faction():name() == "wh2_main_skv_clan_mors" or
			skavenblight_region:owning_faction():name() == "wh2_main_skv_clan_pestilens" or
			skavenblight_region:owning_faction():name() == "wh2_main_skv_clan_skyre"
	 then
		local human_factions = cm:get_human_factions()

		for i = 1, #human_factions do
			cm:show_message_event(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_ratsoccupyskavenblightmess_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_ratsoccupyskavenblightmess_secondary_detail",
				true,
				778
			)
		end
	else
		local human_factions = cm:get_human_factions()

		for i = 1, #human_factions do
			cm:show_message_event(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_goodoccupyskavenblightmess_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_goodoccupyskavenblightmess_secondary_detail",
				true,
				772
			)
		end
	end
end

function occupy_mess_oxyl()
	local oyxl_region = cm:get_region("wh2_main_headhunters_jungle_oyxl")

	if
		oyxl_region:owning_faction():name() == "wh2_main_skv_clan_skyre" or
			oyxl_region:owning_faction():name() == "wh2_dlc09_skv_clan_rictus" or
			oyxl_region:owning_faction():name() == "wh2_main_skv_clan_mors" or
			oyxl_region:owning_faction():name() == "wh2_main_skv_clan_pestilens"
	 then
		local human_factions = cm:get_human_factions()

		for i = 1, #human_factions do
			cm:show_message_event(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_ratsoccupyoyxlmess_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_ratsoccupyoyxlmess_secondary_detail",
				true,
				778
			)
		end
	else
		local human_factions = cm:get_human_factions()

		for i = 1, #human_factions do
			cm:show_message_event(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_goodoccupyoyxlmess_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_goodoccupyoyxlmess_secondary_detail",
				true,
				772
			)
		end
	end
end

function vt_endtimes_warning10()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_vtwarningmess10_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_vtwarningmess10_secondary_detail",
			true,
			778
		)
	end
end

function vt_endtimes_warning5()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_vtwarningmess5_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_vtwarningmess5_secondary_detail",
			true,
			778
		)
	end
end

function order_intervention_man()
	if
		cm:get_faction("wh2_dlc09_skv_clan_rictus"):is_human() or cm:get_faction("wh2_main_skv_clan_mors"):is_human() or
			cm:get_faction("wh2_main_skv_clan_skyre"):is_human() or
			cm:get_faction("wh2_main_skv_clan_pestilens"):is_human()
	 then
		cm:create_force_with_general(
			"wh_main_teb_tilea",
			"wh_main_emp_veh_steam_tank,wh_main_emp_art_helstorm_rocket_battery,wh_main_emp_cav_reiksguard,wh_main_emp_cav_demigryph_knights_1,wh_main_emp_cav_demigryph_knights_0,wh_main_emp_inf_greatswords,wh_main_emp_inf_handgunners,wh_main_emp_inf_handgunners,wh_main_emp_inf_greatswords,wh_main_emp_inf_halberdiers,wh_main_emp_inf_halberdiers,wh_dlc04_emp_inf_flagellants_0,wh_dlc04_emp_inf_flagellants_0,wh_main_emp_inf_greatswords,wh_main_emp_inf_handgunners,wh_main_emp_inf_crossbowmen,wh_dlc04_emp_cav_knights_blazing_sun_0,wh_main_emp_art_helblaster_volley_gun,wh_main_emp_art_great_cannon",
			"wh2_main_northern_great_jungle_temple_of_tlencan",
			450,
			270,
			"general",
			"emp_lord",
			"names_name_2147356946",
			"",
			"",
			"",
			false,
			function(cqi)
				cm:add_agent_experience("faction:wh_main_teb_tilea,forename:2147356946", 20000)
				cm:replenish_action_points("faction:wh_main_teb_tilea,forename:2147356946")
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
				cm:callback(
					function()
						cm:attack_region("faction:wh_main_teb_tilea,forename:2147356946", "wh2_main_skavenblight_skavenblight", true)
					end,
					0.1
				)
			end
		)
	end
end

function order_intervention_elf()
	if
		cm:get_faction("wh2_dlc09_skv_clan_rictus"):is_human() or cm:get_faction("wh2_main_skv_clan_mors"):is_human() or
			cm:get_faction("wh2_main_skv_clan_skyre"):is_human() or
			cm:get_faction("wh2_main_skv_clan_pestilens"):is_human()
	 then
		cm:force_declare_war("wh2_dlc09_skv_clan_rictus", "wh_main_teb_tilea", true, true)
		cm:force_declare_war("wh2_main_skv_clan_mors", "wh_main_teb_tilea", true, true)
		cm:force_declare_war("wh2_main_skv_clan_skyre", "wh_main_teb_tilea", true, true)
		cm:force_declare_war("wh2_main_skv_clan_pestilens", "wh_main_teb_tilea", true, true)
		cm:force_declare_war("wh2_dlc09_skv_clan_rictus", "wh2_main_hef_saphery", true, true)
		cm:force_declare_war("wh2_main_skv_clan_mors", "wh2_main_hef_saphery", true, true)
		cm:force_declare_war("wh2_main_skv_clan_skyre", "wh2_main_hef_saphery", true, true)
		cm:force_declare_war("wh2_main_skv_clan_pestilens", "wh2_main_hef_saphery", true, true)

		cm:create_force_with_general(
			"wh2_main_hef_saphery",
			"wh2_main_hef_inf_phoenix_guard,wh2_main_hef_inf_phoenix_guard,wh2_main_hef_mon_star_dragon,wh2_main_hef_mon_star_dragon,wh2_main_hef_inf_swordmasters_of_hoeth_0,wh2_main_hef_inf_white_lions_of_chrace_0,wh2_main_hef_cav_dragon_princes,wh2_main_hef_cav_dragon_princes,wh2_main_hef_cav_ithilmar_chariot,wh2_main_hef_mon_great_eagle,wh2_main_hef_mon_phoenix_frostheart,wh2_main_hef_inf_lothern_sea_guard_1,wh2_main_hef_inf_lothern_sea_guard_1,wh2_main_hef_inf_lothern_sea_guard_1,wh2_dlc10_hef_inf_shadow_walkers_0,wh2_dlc10_hef_inf_shadow_walkers_0,wh2_dlc10_hef_inf_sisters_of_avelorn_0,wh2_main_hef_art_eagle_claw_bolt_thrower,wh2_main_hef_art_eagle_claw_bolt_thrower",
			"wh2_main_land_of_assassins_sorcerers_islands",
			190,
			20,
			"general",
			"wh2_main_hef_prince",
			"names_name_2147360449",
			"",
			"",
			"",
			false,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
				cm:add_agent_experience("faction:wh2_main_hef_saphery,forename:2147360449", 20000)
				cm:replenish_action_points("faction:wh2_main_hef_saphery,forename:2147360449")
				cm:callback(
					function()
						cm:attack_region("faction:wh2_main_hef_saphery,forename:2147360449", "wh2_main_headhunters_jungle_oyxl", true)
					end,
					0.1
				)
			end
		)

	--cm:attack_region("faction:wh2_main_hef_saphery,forename:2147360449", "wh2_main_headhunters_jungle_oyxl", false)
	end
end

function vt_endtimes()
	local skavenblight_region = cm:get_region("wh2_main_skavenblight_skavenblight")
	local oyxl_region = cm:get_region("wh2_main_headhunters_jungle_oyxl")
	local human_players = cm:get_human_factions()

	if
		skavenblight_region:owning_faction():name() == "wh2_dlc09_skv_clan_rictus" or
			skavenblight_region:owning_faction():name() == "wh2_main_skv_clan_mors" or
			skavenblight_region:owning_faction():name() == "wh2_main_skv_clan_pestilens" or
			skavenblight_region:owning_faction():name() == "wh2_main_skv_clan_skyre" and
				oyxl_region:owning_faction():name() == "wh2_main_skv_clan_skyre" or
			oyxl_region:owning_faction():name() == "wh2_dlc09_skv_clan_rictus" or
			oyxl_region:owning_faction():name() == "wh2_main_skv_clan_mors" or
			oyxl_region:owning_faction():name() == "wh2_main_skv_clan_pestilens"
	 then
		if
			cm:get_faction("wh2_main_skv_clan_pestilens"):is_human() or cm:get_faction("wh2_main_skv_clan_mors"):is_human() or
				cm:get_faction("wh2_dlc09_skv_clan_rictus"):is_human() or
				cm:get_faction("wh2_main_skv_clan_skyre"):is_human()
		 then
			cm:apply_effect_bundle("wh2_main_skv_ascendancy", human_players[1], -1)
			destoryworld()
		end
	else
		worldsavedmess()

		local skavenblight_region = cm:get_region("wh2_main_skavenblight_skavenblight")
		local oyxl_region = cm:get_region("wh2_main_headhunters_jungle_oyxl")
		local human_players = cm:get_human_factions()

		if skavenblight_region:owning_faction():name() == human_players[1] then
			cm:apply_effect_bundle("wh2_main_world_guardians", human_players[1], -1)
		end

		if oyxl_region:owning_faction():name() == human_players[1] then
			cm:apply_effect_bundle("wh2_main_world_guardians", human_players[1], -1)
		end
	end
end

function worldsavedmess()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_worldsavedmess_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_worldsavedmess_secondary_detail",
			true,
			772
		)
	end
end

function new_world_mess()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_newworldmess_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_newworldmess_secondary_detail",
			true,
			778
		)
	end
end

function destoryworld()
	vermintide_armies()
	new_world_mess()

	cm:force_declare_war("wh2_main_skv_clan_skyre", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_dlc09_skv_clan_rictus", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_skv_clan_mors", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_skv_clan_pestilens", "wh2_main_skv_skaven_qb1", false, true)

	core:remove_listener("oxyloccupylistner")
	core:remove_listener("skavenblightoccupylistner")

	cm:set_region_abandoned("wh_main_athel_loren_vauls_anvil")
	cm:set_region_abandoned("wh_main_averland_grenzstadt")
	cm:set_region_abandoned("wh_main_bastonne_et_montfort_montfort")
	cm:set_region_abandoned("wh_main_black_mountains_karak_angazhar")
	cm:set_region_abandoned("wh_main_blightwater_karak_azgal")
	cm:set_region_abandoned("wh_main_blood_river_valley_barak_varr")
	cm:set_region_abandoned("wh_main_bordeleaux_et_aquitaine_aquitaine")
	cm:set_region_abandoned("wh_main_carcassone_et_brionne_brionne")
	cm:set_region_abandoned("wh_main_couronne_et_languille_languille")
	cm:set_region_abandoned("wh_main_death_pass_karag_dron")
	cm:set_region_abandoned("wh_main_eastern_badlands_valayas_sorrow")
	cm:set_region_abandoned("wh_main_eastern_border_princes_matorca")
	cm:set_region_abandoned("wh_main_eastern_sylvania_waldenhof")
	cm:set_region_abandoned("wh_main_estalia_tobaro")
	cm:set_region_abandoned("wh_main_forest_of_arden_gisoreux")
	cm:set_region_abandoned("wh_main_goromandy_mountains_baersonlings_camp")
	cm:set_region_abandoned("wh_main_helspire_mountains_the_monolith_of_katam")
	cm:set_region_abandoned("wh_main_hochland_hergig")
	cm:set_region_abandoned("wh_main_ice_tooth_mountains_icedrake_fjord")
	cm:set_region_abandoned("wh_main_lyonesse_lyonesse")
	cm:set_region_abandoned("wh_main_middenland_weismund")
	cm:set_region_abandoned("wh_main_mountains_of_hel_altar_of_spawns")
	cm:set_region_abandoned("wh_main_mountains_of_naglfari_varg_camp")
	cm:set_region_abandoned("wh_main_nordland_salzenmund")
	cm:set_region_abandoned("wh_main_northern_grey_mountains_grung_zint")
	cm:set_region_abandoned("wh_main_northern_oblast_fort_straghov")
	cm:set_region_abandoned("wh_main_ostermark_bechafen")
	cm:set_region_abandoned("wh_main_ostland_wolfenburg")
	cm:set_region_abandoned("wh_main_parravon_et_quenelles_parravon")
	cm:set_region_abandoned("wh_main_peak_pass_gnashraks_lair")
	cm:set_region_abandoned("wh_main_rib_peaks_grom_peak")
	cm:set_region_abandoned("wh_main_southern_badlands_agrul_migdhal")
	cm:set_region_abandoned("wh_main_southern_grey_mountains_grimhold")
	cm:set_region_abandoned("wh_main_southern_oblast_fort_jakova")
	cm:set_region_abandoned("wh_main_stirland_wurtbad")
	cm:set_region_abandoned("wh_main_talabecland_kemperbad")
	cm:set_region_abandoned("wh_main_the_silver_road_mount_squighorn")
	cm:set_region_abandoned("wh_main_the_vaults_karak_bhufdar")
	cm:set_region_abandoned("wh_main_the_wasteland_gorssel")
	cm:set_region_abandoned("wh_main_tilea_miragliano")
	cm:set_region_abandoned("wh_main_troll_country_zoishenk")
	cm:set_region_abandoned("wh_main_trollheim_mountains_bay_of_blades")
	cm:set_region_abandoned("wh_main_vanaheim_mountains_bjornlings_gathering")
	cm:set_region_abandoned("wh_main_western_badlands_stonemine_tower")
	cm:set_region_abandoned("wh_main_western_border_princes_myrmidens")
	cm:set_region_abandoned("wh_main_western_sylvania_castle_templehof")
	cm:set_region_abandoned("wh_main_wissenland_pfeildorf")
	cm:set_region_abandoned("wh_main_zhufbar_oakenhammer")
	cm:set_region_abandoned("wh2_main_aghol_wastelands_fortress_of_the_damned")
	cm:set_region_abandoned("wh2_main_albion_albion")
	cm:set_region_abandoned("wh2_main_ash_river_quatar")
	cm:set_region_abandoned("wh2_main_atalan_mountains_martek")
	cm:set_region_abandoned("wh2_main_avelorn_tor_saroir")
	cm:set_region_abandoned("wh2_main_blackspine_mountains_plain_of_spiders")
	cm:set_region_abandoned("wh2_main_caledor_tor_sethai")
	cm:set_region_abandoned("wh2_main_charnel_valley_granite_massif")
	cm:set_region_abandoned("wh2_main_chrace_tor_achare")
	cm:set_region_abandoned("wh2_main_coast_of_araby_al_haikk")
	cm:set_region_abandoned("wh2_main_cothique_tor_koruali")
	cm:set_region_abandoned("wh2_main_crater_of_the_walking_dead_rasetra")
	cm:set_region_abandoned("wh2_main_deadwood_dargoth")
	cm:set_region_abandoned("wh2_main_doom_glades_hag_hall")
	cm:set_region_abandoned("wh2_main_eataine_tower_of_lysean")
	cm:set_region_abandoned("wh2_main_ellyrion_whitefire_tor")
	cm:set_region_abandoned("wh2_main_great_desert_of_araby_bel_aliad")
	cm:set_region_abandoned("wh2_main_headhunters_jungle_marks_of_the_old_ones")
	cm:set_region_abandoned("wh2_main_huahuan_desert_chamber_of_visions")
	cm:set_region_abandoned("wh2_main_iron_mountains_har_kaldra")
	cm:set_region_abandoned("wh2_main_ironfrost_glacier_ironfrost")
	cm:set_region_abandoned("wh2_main_isthmus_of_lustria_ziggurat_of_dawn")
	cm:set_region_abandoned("wh2_main_jungles_of_green_mists_wellsprings_of_eternity")
	cm:set_region_abandoned("wh2_main_kingdom_of_beasts_the_cursed_jungle")
	cm:set_region_abandoned("wh2_main_land_of_assassins_lashiek")
	cm:set_region_abandoned("wh2_main_land_of_the_dead_zandri")
	cm:set_region_abandoned("wh2_main_land_of_the_dervishes_plain_of_tuskers")
	cm:set_region_abandoned("wh2_main_nagarythe_tor_dranil")
	cm:set_region_abandoned("wh2_main_northern_great_jungle_xahutec")
	cm:set_region_abandoned("wh2_main_northern_jungle_of_pahualaxa_macu_peaks")
	cm:set_region_abandoned("wh2_main_obsidian_peaks_storag_kor")
	cm:set_region_abandoned("wh2_main_saphery_tor_finu")
	cm:set_region_abandoned("wh2_main_shifting_sands_ka-sabar")
	cm:set_region_abandoned("wh2_main_southern_great_jungle_subatuun")
	cm:set_region_abandoned("wh2_main_southern_jungle_of_pahualaxa_floating_pyramid")
	cm:set_region_abandoned("wh2_main_southlands_jungle_golden_tower_of_the_gods")
	cm:set_region_abandoned("wh2_main_southlands_worlds_edge_mountains_mount_arachnos")
	cm:set_region_abandoned("wh2_main_spine_of_sotek_monument_of_izzatal")
	cm:set_region_abandoned("wh2_main_the_black_coast_bleak_hold_fortress")
	cm:set_region_abandoned("wh2_main_the_black_flood_shroktak_mount")
	cm:set_region_abandoned("wh2_main_the_broken_land_slavers_point")
	cm:set_region_abandoned("wh2_main_the_chill_road_ashrak")
	cm:set_region_abandoned("wh2_main_the_clawed_coast_the_twisted_glade")
	cm:set_region_abandoned("wh2_main_the_creeping_jungle_tlaxtlan")
	cm:set_region_abandoned("wh2_main_tiranoc_whitepeak")
	cm:set_region_abandoned("wh2_main_titan_peaks_ironspike")
	cm:set_region_abandoned("wh2_main_vampire_coast_pox_marsh")
	cm:set_region_abandoned("wh2_main_volcanic_islands_fuming_serpent")
	cm:set_region_abandoned("wh2_main_yvresse_elessaeli")
end

function vtmessstart()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_vtmessstart_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_vtmessstart_secondary_detail",
			true,
			778
		)
	end
end

function vermintide_armies()
	----near star tower
	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		304,
		58,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	---  south badlands
	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		580,
		180,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	--- between lustria and ulthuan

	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		160,
		240,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	---- between alith anar and morathi

	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		90,
		380,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	---near altdorf

	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		460,
		440,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	---norsca

	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		690,
		480,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	--- VC and Karak kadrin

	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		460,
		620,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	--- greenskins and dwarfs

	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		690,
		340,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	-- kingdom of beasts

	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		860,
		100,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	---- Bretonnia

	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		380,
		400,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	----	Naggaroth

	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		85,
		640,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	---WELF
	cm:create_force(
		"wh2_main_skv_skaven_qb1",
		"wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_inf_death_globe_bombardiers,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_hell_pit_abomination,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_death_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_stormvermin_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
		"wh2_main_kingdom_of_beasts_serpent_coast",
		475,
		350,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
		end
	)

	cm:force_declare_war("wh_main_emp_empire", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_main_brt_bretonnia", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_main_brt_carcassonne", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_main_brt_bordeleaux", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_dlc09_tmb_khemri", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_dlc09_tmb_followers_of_nagash", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_dlc09_tmb_exiles_of_nehek", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_dlc09_tmb_lybaras", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_def_naggarond", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_def_cult_of_pleasure", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_def_hag_graef", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_dlc11_def_the_blessed_dread", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_hef_eataine", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_hef_nagarythe", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_hef_order_of_loremasters", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_hef_avelorn", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_lzd_hexoatl", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_main_lzd_last_defenders", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_main_grn_crooked_moon", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_main_grn_greenskins", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_main_grn_orcs_of_the_bloody_hand", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_dlc05_wef_wydrioth", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_dlc05_wef_wood_elves", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_main_vmp_vampire_counts", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_main_vmp_schwartzhafen", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_dlc03_bst_beastmen", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_dlc08_nor_norsca", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh_dlc08_nor_wintertooth", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_dlc11_cst_noctilus", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_dlc11_cst_pirates_of_sartosa", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_dlc11_cst_the_drowned", "wh2_main_skv_skaven_qb1", false, true)
	cm:force_declare_war("wh2_dlc11_cst_vampire_coast", "wh2_main_skv_skaven_qb1", false, true)
end

local mcm = _G.mcm

if not not mcm then
	local ovn = nil;
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn");
	else
		ovn = mcm:register_mod("ovn", "OvN - Overhaul", "Let's you enable/disable various parts of the compilation.")
	end
	local vermintide_et = ovn:add_tweaker("vermintide_et", "Endtimes - Vermintide", "")
	vermintide_et:add_option("enable", "Enable", "")
	vermintide_et:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_vermintide_et_value") == "enable" then
				sr_vermintide_et()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_vermintide_et_value") == "enable" then sr_vermintide_et() end
	end
)