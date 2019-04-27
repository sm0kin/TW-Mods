local function sr_corsairraid()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			core:add_listener(
				"spawnnaggarothraids",
				"FactionRoundStart",
				function(context)
					return context:faction():name() == "wh2_main_def_naggarond"
				end,
				function()
					SR_spawn_naggaroth_raids()
				end,
				true
			)
		end

		core:add_listener(
			"corsairstartmesslistner",
			"FactionRoundStart",
			function(context)
				return context:faction():is_human() and cm:model():turn_number() == 2
			end,
			function()
				corsairstartmess()
			end,
			false
		)
	else
		core:add_listener(
			"spawnnaggarothraids",
			"FactionRoundStart",
			function(context)
				return context:faction():name() == "wh2_main_def_naggarond"
			end,
			function()
				SR_spawn_naggaroth_raids()
			end,
			true
		)
	end
end

function SR_spawn_naggaroth_raids(context)
	local naggarond_region = cm:get_region("wh2_main_iron_mountains_naggarond")
	local karond_region = cm:get_region("wh2_main_the_broken_land_karond_kar")
	local arnheim_region = cm:get_region("wh2_main_the_black_coast_arnheim")
	local startower_region = cm:get_region("wh2_main_volcanic_islands_the_star_tower")

	if
		naggarond_region:owning_faction():name() == "wh2_main_def_naggarond" and
			karond_region:owning_faction():name() == "wh2_main_def_naggarond" and
			arnheim_region:owning_faction():name() == "wh2_main_def_naggarond" and
			startower_region:owning_faction():name() == "wh2_main_def_naggarond"
	 then
		supreme_raid()
	elseif
		naggarond_region:owning_faction():name() == "wh2_main_def_naggarond" and
			karond_region:owning_faction():name() == "wh2_main_def_naggarond" and
			arnheim_region:owning_faction():name() == "wh2_main_def_naggarond"
	 then
		strong_raid()
	elseif
		naggarond_region:owning_faction():name() == "wh2_main_def_naggarond" and
			karond_region:owning_faction():name() == "wh2_main_def_naggarond"
	 then
		north_raid()
	elseif
		naggarond_region:owning_faction():name() == "wh2_main_def_naggarond" and
			arnheim_region:owning_faction():name() == "wh2_main_def_naggarond"
	 then
		south_raid()
	elseif naggarond_region:owning_faction():name() == "wh2_main_def_naggarond" then
		weak_raid()
	end
end

function supreme_raid()
	if 1 == cm:random_number(66, 1) then
		spawn_army_lustria_coast()
	end

	if 2 == cm:random_number(66, 1) then
		spawn_army_estallia_coast()
	end

	if 3 == cm:random_number(66, 1) then
		spawn_army_empire_coast()
	end

	if 4 == cm:random_number(66, 1) then
		spawn_army_araby_coast()
	end

	if 5 == cm:random_number(50, 1) then
		spawn_army_beast_coast()
	end
end

function strong_raid()
	if 1 == cm:random_number(66, 1) then
		spawn_army_lustria_coast()
	end

	if 2 == cm:random_number(66, 1) then
		spawn_army_estallia_coast()
	end

	if 3 == cm:random_number(66, 1) then
		spawn_army_empire_coast()
	end

	if 4 == cm:random_number(66, 1) then
		spawn_army_araby_coast()
	end
end

function north_raid()
	if 2 == cm:random_number(40, 1) then
		spawn_army_estallia_coast()
	end

	if 3 == cm:random_number(40, 1) then
		spawn_army_empire_coast()
	end
end

function south_raid()
	if 1 == cm:random_number(40, 1) then
		spawn_army_lustria_coast()
	end

	if 2 == cm:random_number(40, 1) then
		spawn_army_araby_coast()
	end
end

function weak_raid()
	if 1 == cm:random_number(66, 1) then
		spawn_army_lustria_coast()
	end

	if 2 == cm:random_number(66, 1) then
		spawn_army_estallia_coast()
	end
end

function spawn_army_araby_coast()
	corsairspawnmess()
	cm:force_declare_war("wh2_main_vmp_strygos_empire", "wh2_main_def_naggarond", true, true)

	if cm:get_faction("wh2_main_def_naggarond"):is_human() then
		cm:create_force(
			"wh2_main_def_naggarond",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			470,
			170,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh2_main_def_naggarond",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			470,
			170,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local zandri_region = cm:get_region("wh2_main_land_of_the_dead_zandri")
		local human_players = cm:get_human_factions()

		if zandri_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh2_main_def_naggarond", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_land_of_the_dead_zandri", "wh2_main_def_naggarond")
			cm:force_declare_war("wh2_dlc09_tmb_khemri", "wh2_main_def_naggarond", true, true)
		end
	end
end

function spawn_army_lustria_coast()
	corsairspawnmess()
	cm:force_declare_war("wh2_main_grn_blue_vipers", "wh2_main_def_naggarond", true, true)

	if cm:get_faction("wh2_main_def_naggarond"):is_human() then
		cm:create_force(
			"wh2_main_def_naggarond",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_cav_cold_one_chariot,wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0",
			"wh2_main_land_of_the_dead_zandri",
			117,
			320,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh2_main_def_naggarond",
			"wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_cav_cold_one_chariot,wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0",
			"wh2_main_land_of_the_dead_zandri",
			117,
			320,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local pahualaxa_region = cm:get_region("wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel")
		local human_players = cm:get_human_factions()

		if pahualaxa_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh2_main_def_naggarond", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel", "wh2_main_def_naggarond")
			cm:force_declare_war("wh2_main_lzd_hexoatl", "wh2_main_def_naggarond", true, true)
		end
	end
end

function spawn_army_beast_coast()
	corsairspawnmess()
	cm:force_declare_war("wh2_main_lzd_last_defenders", "wh2_main_def_naggarond", true, true)

	if cm:get_faction("wh2_main_def_naggarond"):is_human() then
		cm:create_force(
			"wh2_main_def_naggarond",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_cav_cold_one_chariot,wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0",
			"wh2_main_kingdom_of_beasts_serpent_coast",
			913,
			66,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh2_main_def_naggarond",
			"wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_cav_cold_one_chariot,wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0",
			"wh2_main_kingdom_of_beasts_serpent_coast",
			913,
			66,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local cursed_jungle_region = cm:get_region("wh2_main_kingdom_of_beasts_the_cursed_jungle")
		local human_players = cm:get_human_factions()

		if cursed_jungle_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh2_main_def_naggarond", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_kingdom_of_beasts_the_cursed_jungle", "wh2_main_def_naggarond")
			cm:force_declare_war("wh2_dlc09_tmb_lybaras", "wh2_main_def_naggarond", true, true)
		end
	end
end

function spawn_army_empire_coast()
	corsairspawnmess()
	if cm:get_faction("wh2_main_def_naggarond"):is_human() then
		cm:create_force(
			"wh2_main_def_naggarond",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			400,
			530,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		cm:force_declare_war("wh_main_emp_nordland", "wh2_main_def_naggarond", true, true)
	else
		cm:create_force(
			"wh2_main_def_naggarond",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			400,
			530,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local troll_fjord_region = cm:get_region("wh_main_vanaheim_mountains_troll_fjord")
		local human_players = cm:get_human_factions()

		if troll_fjord_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh2_main_def_naggarond", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh_main_vanaheim_mountains_troll_fjord", "wh2_main_def_naggarond")
			cm:force_declare_war("wh_main_emp_ostland", "wh2_main_def_naggarond", true, true)
			cm:force_declare_war("wh_dlc08_nor_vanaheimlings", "wh2_main_def_naggarond", true, true)
		end
	end
end

function spawn_army_estallia_coast()
	corsairspawnmess()
	cm:force_declare_war("wh_main_teb_estalia", "wh2_main_def_naggarond", true, true)

	if cm:get_faction("wh2_main_def_naggarond"):is_human() then
		cm:create_force(
			"wh2_main_def_naggarond",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			360,
			310,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh2_main_def_naggarond",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			360,
			310,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local bilbali_region = cm:get_region("wh_main_estalia_bilbali")
		local human_players = cm:get_human_factions()

		if bilbali_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh2_main_def_naggarond", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh_main_estalia_bilbali", "wh2_main_def_naggarond")
			cm:force_declare_war("wh_main_brt_carcassonne", "wh2_main_def_naggarond", true, true)
		end
	end
end

function corsairspawnmess()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_corsairspawn_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_corsairspawn_secondary_detail",
			true,
			773
		)
	end
end

function corsairstartmess()
	if cm:get_faction("wh2_main_def_naggarond"):is_human() then
		local human_factions = cm:get_human_factions()

		for i = 1, #human_factions do
			cm:show_message_event(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_corsairstart_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_corsairstart_secondary_detail",
				true,
				773
			)
		end
	end
end

local mcm = _G.mcm

if not not mcm then
	local ovn = nil;
	local chance = 100;
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn");
	else
		ovn = mcm:register_mod("ovn", "OvN - Overhaul", "Let's you enable/disable various parts of the compilation.")
	end
	local corsairraid = ovn:add_tweaker("corsairraid", "Corsair Raids", "")
	corsairraid:add_option("enable", "Enable", "")
	corsairraid:add_option("disable", "Disable", "")
	corsairraid:add_option("chance", "by Chance", "")
	ovn:add_variable("corsairraid_chance", 5, 95, 50, 5, "Corsair Raids Chance", "Chance this \"event\" is happening."):add_callback(
		function(context)
        	chance = context:get_mod("ovn"):get_variable_with_key("corsairraid_chance"):current_value()
		end
	)

	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_corsairraid_value") == "enable" then
				sr_corsairraid()
			elseif cm:get_saved_value("mcm_tweaker_ovn_corsairraid_value") == "chance" and cm:random_number(100) <= chance then
				sr_corsairraid()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_corsairraid_value") == "enable" then sr_corsairraid() end
	end
)