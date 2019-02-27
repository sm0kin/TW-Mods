local function sr_kraken()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			kraidstart()
		else
			raidstart()
		end
	end
end

function kraidstart()
	core:add_listener(
		"spawnkrakenraids",
		"FactionRoundStart",
		function(context)
			return context:faction():name() == "wh2_dlc11_def_the_blessed_dread"
		end,
		function()
			SR_spawn_kraken_raids()
		end,
		true
	)
end

core:add_listener(
	"krakenstartmesslistner",
	"FactionRoundStart",
	function(context)
		return context:faction():is_human() and cm:model():turn_number() >= 2
	end,
	function()
		kcorsairstartmess()
	end,
	false
)

function SR_spawn_kraken_raids(context)
	local chupayotl_region = cm:get_region("wh2_main_headhunters_jungle_chupayotl")
	local sorcerers_islands_region = cm:get_region("wh2_main_land_of_assassins_sorcerers_islands")
	local arnheim_region = cm:get_region("wh2_main_the_black_coast_arnheim")
	local startower_region = cm:get_region("wh2_main_volcanic_islands_the_star_tower")

	if
		chupayotl_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread" and
			sorcerers_islands_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread" and
			arnheim_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread" and
			startower_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread"
	 then
		ksupreme_raid()
	elseif
		chupayotl_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread" and
			sorcerers_islands_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread" and
			startower_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread"
	 then
		kstrong_raid()
	elseif
		chupayotl_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread" and
			sorcerers_islands_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread"
	 then
		knorth_raid()
	elseif
		chupayotl_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread" and
			startower_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread"
	 then
		ksouth_raid()
	elseif chupayotl_region:owning_faction():name() == "wh2_dlc11_def_the_blessed_dread" then
		kweak_raid()
	end
end

function ksupreme_raid()
	if 1 == cm:random_number(66, 1) then
		kspawn_army_lustria_coast()
	end

	if 2 == cm:random_number(66, 1) then
		kspawn_army_estallia_coast()
	end

	if 3 == cm:random_number(66, 1) then
		kspawn_army_empire_coast()
	end

	if 4 == cm:random_number(66, 1) then
		kspawn_army_araby_coast()
	end

	if 5 == cm:random_number(50, 1) then
		kspawn_army_beast_coast()
	end
end

function kstrong_raid()
	if 1 == cm:random_number(66, 1) then
		kspawn_army_lustria_coast()
	end

	if 2 == cm:random_number(66, 1) then
		kspawn_army_estallia_coast()
	end

	if 3 == cm:random_number(66, 1) then
		kspawn_army_empire_coast()
	end

	if 4 == cm:random_number(66, 1) then
		kspawn_army_araby_coast()
	end
end

function knorth_raid()
	if 2 == cm:random_number(40, 1) then
		kspawn_army_estallia_coast()
	end

	if 3 == cm:random_number(40, 1) then
		kspawn_army_empire_coast()
	end
end

function ksouth_raid()
	if 1 == cm:random_number(40, 1) then
		kspawn_army_lustria_coast()
	end

	if 2 == cm:random_number(40, 1) then
		kspawn_army_araby_coast()
	end
end

function kweak_raid()
	if 1 == cm:random_number(66, 1) then
		kspawn_army_lustria_coast()
	end

	if 2 == cm:random_number(66, 1) then
		kspawn_army_estallia_coast()
	end
end

function kspawn_army_araby_coast()
	kcorsairspawnmess()
	cm:force_declare_war("wh2_main_vmp_strygos_empire", "wh2_dlc11_def_the_blessed_dread", true, true)

	if cm:get_faction("wh2_dlc11_def_the_blessed_dread"):is_human() then
		cm:create_force(
			"wh2_dlc11_def_the_blessed_dread",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			473,
			173,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh2_dlc11_def_the_blessed_dread",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			473,
			173,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local zandri_region = cm:get_region("wh2_main_land_of_the_dead_zandri")
		local human_players = cm:get_human_factions()

		if zandri_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh2_dlc11_def_the_blessed_dread", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_land_of_the_dead_zandri", "wh2_dlc11_def_the_blessed_dread")
			cm:force_declare_war("wh2_dlc09_tmb_khemri", "wh2_dlc11_def_the_blessed_dread", true, true)
		end
	end
end

function kspawn_army_lustria_coast()
	kcorsairspawnmess()
	cm:force_declare_war("wh2_main_grn_blue_vipers", "wh2_dlc11_def_the_blessed_dread", true, true)

	if cm:get_faction("wh2_dlc11_def_the_blessed_dread"):is_human() then
		cm:create_force(
			"wh2_dlc11_def_the_blessed_dread",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_cav_cold_one_chariot,wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0",
			"wh2_main_land_of_the_dead_zandri",
			119,
			323,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh2_dlc11_def_the_blessed_dread",
			"wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_cav_cold_one_chariot,wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0",
			"wh2_main_land_of_the_dead_zandri",
			119,
			323,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local pahualaxa_region = cm:get_region("wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel")
		local human_players = cm:get_human_factions()

		if pahualaxa_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh2_dlc11_def_the_blessed_dread", human_players[1], true, true)
		else
			cm:transfer_region_to_faction(
				"wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel",
				"wh2_dlc11_def_the_blessed_dread"
			)
			cm:force_declare_war("wh2_main_lzd_hexoatl", "wh2_dlc11_def_the_blessed_dread", true, true)
		end
	end
end

function kspawn_army_beast_coast()
	kcorsairspawnmess()
	cm:force_declare_war("wh2_main_lzd_last_defenders", "wh2_dlc11_def_the_blessed_dread", true, true)

	if cm:get_faction("wh2_dlc11_def_the_blessed_dread"):is_human() then
		cm:create_force(
			"wh2_dlc11_def_the_blessed_dread",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_cav_cold_one_chariot,wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0",
			"wh2_main_kingdom_of_beasts_serpent_coast",
			915,
			69,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh2_dlc11_def_the_blessed_dread",
			"wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_cav_cold_one_chariot,wh2_main_def_cav_cold_one_knights_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0",
			"wh2_main_kingdom_of_beasts_serpent_coast",
			915,
			69,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local cursed_jungle_region = cm:get_region("wh2_main_kingdom_of_beasts_the_cursed_jungle")
		local human_players = cm:get_human_factions()

		if cursed_jungle_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh2_dlc11_def_the_blessed_dread", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_kingdom_of_beasts_the_cursed_jungle", "wh2_dlc11_def_the_blessed_dread")
			cm:force_declare_war("wh2_dlc09_tmb_lybaras", "wh2_dlc11_def_the_blessed_dread", true, true)
		end
	end
end

function kspawn_army_empire_coast()
	kcorsairspawnmess()
	if cm:get_faction("wh2_dlc11_def_the_blessed_dread"):is_human() then
		cm:create_force(
			"wh2_dlc11_def_the_blessed_dread",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			403,
			533,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		cm:force_declare_war("wh_main_emp_nordland", "wh2_dlc11_def_the_blessed_dread", true, true)
	else
		cm:create_force(
			"wh2_dlc11_def_the_blessed_dread",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			403,
			533,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local troll_fjord_region = cm:get_region("wh_main_vanaheim_mountains_troll_fjord")
		local human_players = cm:get_human_factions()

		if troll_fjord_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh2_dlc11_def_the_blessed_dread", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh_main_vanaheim_mountains_troll_fjord", "wh2_dlc11_def_the_blessed_dread")
			cm:force_declare_war("wh_main_emp_ostland", "wh2_dlc11_def_the_blessed_dread", true, true)
			cm:force_declare_war("wh_dlc08_nor_vanaheimlings", "wh2_dlc11_def_the_blessed_dread", true, true)
		end
	end
end

function kkspawn_army_estallia_coast()
	kcorsairspawnmess()
	cm:force_declare_war("wh_main_teb_estalia", "wh2_dlc11_def_the_blessed_dread", true, true)

	if cm:get_faction("wh2_dlc11_def_the_blessed_dread"):is_human() then
		cm:create_force(
			"wh2_dlc11_def_the_blessed_dread",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			363,
			313,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh2_dlc11_def_the_blessed_dread",
			"wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_dark_riders_1,wh2_main_def_inf_shades_2,wh2_main_def_inf_darkshards_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_har_ganeth_executioners_0,wh2_main_def_inf_dreadspears_0,wh2_main_def_inf_bleakswords_0,wh2_main_def_inf_harpies,wh2_main_def_art_reaper_bolt_thrower",
			"wh2_main_land_of_the_dead_zandri",
			363,
			313,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local bilbali_region = cm:get_region("wh_main_estalia_bilbali")
		local human_players = cm:get_human_factions()

		if bilbali_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh2_dlc11_def_the_blessed_dread", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh_main_estalia_bilbali", "wh2_dlc11_def_the_blessed_dread")
			cm:force_declare_war("wh_main_brt_carcassonne", "wh2_dlc11_def_the_blessed_dread", true, true)
		end
	end
end

function kcorsairspawnmess()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_krakenspawn_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_krakenspawn_secondary_detail",
			true,
			773
		)
	end
end

function kcorsairstartmess()
	if cm:get_faction("wh2_dlc11_def_the_blessed_dread"):is_human() then
		local human_factions = cm:get_human_factions()

		for i = 1, #human_factions do
			cm:show_message_event(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_krakenstart_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_krakenstart_secondary_detail",
				true,
				773
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
	local kraken = ovn:add_tweaker("kraken", "Krakenlord Reavers", "")
	kraken:add_option("enable", "Enable", "")
	kraken:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_kraken_value") == "enable" then
				sr_kraken()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_kraken_value") == "enable" then sr_kraken() end
	end
)