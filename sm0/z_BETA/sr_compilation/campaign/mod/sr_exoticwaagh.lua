local function sr_exoticwaagh()
	if cm:model():campaign_name("main_warhammer") then
		exoticwaaghstart()
	end
end

function exoticwaaghstart()
	core:add_listener(
		"spawnexoticwaaghraids",
		"FactionRoundStart",
		function(context)
			return context:faction():name() == "wh_main_grn_greenskins"
		end,
		function()
			SR_spawn_exoticwaagh_raids()
		end,
		true
	)
end

core:add_listener(
	"exoticwaaghstartmesslistner",
	"FactionRoundStart",
	function(context)
		return context:faction():is_human() and cm:model():turn_number() >= 2
	end,
	function()
		exoticwaaghstartmess()
	end,
	false
)

function SR_spawn_exoticwaagh_raids(context)
	local blackcrag_region = cm:get_region("wh_main_death_pass_karak_drazh")
	local karaz_a_karak_region = cm:get_region("wh_main_the_silver_road_karaz_a_karak")
	local k8p_region = cm:get_region("wh_main_eastern_badlands_karak_eight_peaks")
	local altdorf_region = cm:get_region("wh_main_reikland_altdorf")

	if
		blackcrag_region:owning_faction():name() == "wh_main_grn_greenskins" and
			karaz_a_karak_region:owning_faction():name() == "wh_main_grn_greenskins" and
			k8p_region:owning_faction():name() == "wh_main_grn_greenskins" and
			altdorf_region:owning_faction():name() == "wh_main_grn_greenskins"
	 then
		ewsupreme_raid()
	elseif
		blackcrag_region:owning_faction():name() == "wh_main_grn_greenskins" and
			karaz_a_karak_region:owning_faction():name() == "wh_main_grn_greenskins" and
			altdorf_region:owning_faction():name() == "wh_main_grn_greenskins"
	 then
		ewstrong_raid()
	elseif
		blackcrag_region:owning_faction():name() == "wh_main_grn_greenskins" and
			karaz_a_karak_region:owning_faction():name() == "wh_main_grn_greenskins"
	 then
		ewnorth_raid()
	elseif
		blackcrag_region:owning_faction():name() == "wh_main_grn_greenskins" and
			altdorf_region:owning_faction():name() == "wh_main_grn_greenskins"
	 then
		ewsouth_raid()
	elseif blackcrag_region:owning_faction():name() == "wh_main_grn_greenskins" then
		ewweak_raid()
	end
end

function ewsupreme_raid()
	if 1 == cm:random_number(66, 1) then
		exoticwaaghspawn_army_lustria_coast()
	end

	if 2 == cm:random_number(66, 1) then
		exoticwaaghspawn_army_estallia_coast()
	end

	if 3 == cm:random_number(66, 1) then
		exoticwaaghspawn_army_empire_coast()
	end

	if 4 == cm:random_number(66, 1) then
		exoticwaaghspawn_army_araby_coast()
	end

	if 5 == cm:random_number(50, 1) then
		exoticwaaghspawn_army_beast_coast()
	end
end

function ewstrong_raid()
	if 1 == cm:random_number(66, 1) then
		exoticwaaghspawn_army_lustria_coast()
	end

	if 2 == cm:random_number(66, 1) then
		exoticwaaghspawn_army_estallia_coast()
	end

	if 3 == cm:random_number(66, 1) then
		exoticwaaghspawn_army_empire_coast()
	end

	if 4 == cm:random_number(66, 1) then
		exoticwaaghspawn_army_araby_coast()
	end
end

function ewnorth_raid()
	if 2 == cm:random_number(40, 1) then
		exoticwaaghspawn_army_estallia_coast()
	end

	if 3 == cm:random_number(40, 1) then
		exoticwaaghspawn_army_empire_coast()
	end
end

function ewsouth_raid()
	if 1 == cm:random_number(40, 1) then
		exoticwaaghspawn_army_lustria_coast()
	end

	if 2 == cm:random_number(40, 1) then
		exoticwaaghspawn_army_araby_coast()
	end
end

function ewweak_raid()
	if 1 == cm:random_number(66, 1) then
		exoticwaaghspawn_army_lustria_coast()
	end

	if 2 == cm:random_number(66, 1) then
		exoticwaaghspawn_army_estallia_coast()
	end
end

function exoticwaaghspawn_army_araby_coast()
	exoticwaaghspawnmess()
	cm:force_declare_war("wh2_main_vmp_strygos_empire", "wh_main_grn_greenskins", true, true)

	if cm:get_faction("wh_main_grn_greenskins"):is_human() then
		cm:create_force(
			"wh_main_grn_greenskins",
			"wh_main_grn_mon_giant,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orc_big_uns,wh_main_grn_inf_savage_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_0,wh_main_grn_cav_goblin_wolf_riders_1",
			"wh2_main_land_of_the_dead_zandri",
			420,
			100,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh_main_grn_greenskins",
			"wh_main_grn_mon_giant,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orc_big_uns,wh_main_grn_inf_savage_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_0,wh_main_grn_cav_goblin_wolf_riders_1",
			"wh2_main_land_of_the_dead_zandri",
			420,
			100,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local martek_region = cm:get_region("wh2_main_atalan_mountains_martek")
		local human_players = cm:get_human_factions()

		if martek_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh_main_grn_greenskins", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_atalan_mountains_martek", "wh_main_grn_greenskins")
			cm:force_declare_war("wh2_main_dwf_greybeards_prospectors", "wh_main_grn_greenskins", true, true)
		end
	end
end

function exoticwaaghspawn_army_lustria_coast()
	exoticwaaghspawnmess()
	cm:force_declare_war("wh2_main_grn_blue_vipers", "wh_main_grn_greenskins", true, true)

	if cm:get_faction("wh_main_grn_greenskins"):is_human() then
		cm:create_force(
			"wh_main_grn_greenskins",
			"wh_main_grn_mon_arachnarok_spider_0,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orc_big_uns,wh_main_grn_inf_savage_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_0,wh_main_grn_cav_goblin_wolf_riders_1",
			"wh2_main_land_of_the_dead_zandri",
			36,
			248,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh_main_grn_greenskins",
			"wh_main_grn_mon_arachnarok_spider_0,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orc_big_uns,wh_main_grn_inf_savage_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_0,wh_main_grn_cav_goblin_wolf_riders_1",
			"wh2_main_land_of_the_dead_zandri",
			36,
			248,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local sotek_region = cm:get_region("wh2_main_northern_jungle_of_pahualaxa_shrine_of_sotek")
		local human_players = cm:get_human_factions()

		if sotek_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh_main_grn_greenskins", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_northern_jungle_of_pahualaxa_shrine_of_sotek", "wh_main_grn_greenskins")
			cm:force_declare_war("wh2_main_lzd_hexoatl", "wh_main_grn_greenskins", true, true)
		end
	end
end

function exoticwaaghspawn_army_beast_coast()
	exoticwaaghspawnmess()
	cm:force_declare_war("wh2_main_lzd_last_defenders", "wh_main_grn_greenskins", true, true)

	if cm:get_faction("wh_main_grn_greenskins"):is_human() then
		cm:create_force(
			"wh_main_grn_greenskins",
			"wh_dlc06_grn_inf_squig_herd_0,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orc_big_uns,wh_main_grn_inf_savage_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_0,wh_main_grn_cav_goblin_wolf_riders_1",
			"wh2_main_kingdom_of_beasts_serpent_coast",
			910,
			67,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh_main_grn_greenskins",
			"wh_dlc06_grn_inf_squig_herd_0,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orcs,wh_main_grn_inf_savage_orc_big_uns,wh_main_grn_inf_savage_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_savage_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_0,wh_main_grn_cav_goblin_wolf_riders_1",
			"wh2_main_kingdom_of_beasts_serpent_coast",
			910,
			67,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local cursed_jungle_region = cm:get_region("wh2_main_kingdom_of_beasts_the_cursed_jungle")
		local human_players = cm:get_human_factions()

		if cursed_jungle_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh_main_grn_greenskins", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_kingdom_of_beasts_the_cursed_jungle", "wh_main_grn_greenskins")
			cm:force_declare_war("wh2_dlc09_tmb_lybaras", "wh_main_grn_greenskins", true, true)
		end
	end
end

function exoticwaaghspawn_army_empire_coast()
	exoticwaaghspawnmess()
	if cm:get_faction("wh_main_grn_greenskins"):is_human() then
		cm:create_force(
			"wh_main_grn_greenskins",
			"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_big_uns,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_orc_arrer_boyz,wh_main_grn_mon_trolls,wh_main_grn_mon_trolls,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_1",
			"wh2_main_land_of_the_dead_zandri",
			610,
			595,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		cm:force_declare_war("wh_main_ksl_kislev", "wh_main_grn_greenskins", true, true)
	else
		cm:create_force(
			"wh_main_grn_greenskins",
			"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_big_uns,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_orc_arrer_boyz,wh_main_grn_mon_trolls,wh_main_grn_mon_trolls,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_1",
			"wh2_main_land_of_the_dead_zandri",
			610,
			595,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local zoishenk_region = cm:get_region("wh_main_troll_country_zoishenk")
		local human_players = cm:get_human_factions()

		if zoishenk_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh_main_grn_greenskins", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh_main_troll_country_zoishenk", "wh_main_grn_greenskins")
			cm:force_declare_war("wh_main_emp_ostland", "wh_main_grn_greenskins", true, true)
			cm:force_declare_war("wh_main_ksl_kislev", "wh_main_grn_greenskins", true, true)
		end
	end
end

function exoticwaaghspawn_army_estallia_coast()
	exoticwaaghspawnmess()
	cm:force_declare_war("wh_main_brt_carcassonne", "wh_main_grn_greenskins", true, true)

	if cm:get_faction("wh_main_grn_greenskins"):is_human() then
		cm:create_force(
			"wh_main_grn_greenskins",
			"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_big_uns,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_orc_arrer_boyz,wh_dlc06_grn_cav_squig_hoppers_0,wh_main_grn_cav_forest_goblin_spider_riders_1,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_1",
			"wh2_main_land_of_the_dead_zandri",
			415,
			315,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh_main_grn_greenskins",
			"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_big_uns,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_orc_arrer_boyz,wh_dlc06_grn_cav_squig_hoppers_0,wh_main_grn_cav_forest_goblin_spider_riders_1,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_1",
			"wh2_main_land_of_the_dead_zandri",
			415,
			315,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local brionne_region = cm:get_region("wh_main_carcassone_et_brionne_brionne")
		local human_players = cm:get_human_factions()

		if brionne_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh_main_grn_greenskins", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh_main_carcassone_et_brionne_brionne", "wh_main_grn_greenskins")
			cm:force_declare_war("wh_main_teb_estalia", "wh_main_grn_greenskins", true, true)
		end
	end
end

function exoticwaaghspawnmess()
	if cm:get_faction("wh_main_grn_greenskins"):is_human() then
		local human_factions = cm:get_human_factions()

		for i = 1, #human_factions do
			cm:show_message_event(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_exoticwaaghspawn_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_exoticwaaghspawn_secondary_detail",
				true,
				593
			)
		end
	else
		local human_factions = cm:get_human_factions()

		for i = 1, #human_factions do
			cm:show_message_event(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_exoticwaaghspawnnongrn_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_exoticwaaghspawnnongrn_secondary_detail",
				true,
				593
			)
		end
	end
end

function exoticwaaghstartmess()
	if cm:get_faction("wh_main_grn_greenskins"):is_human() then
		local human_factions = cm:get_human_factions()

		for i = 1, #human_factions do
			cm:show_message_event(
				human_factions[i],
				"event_feed_strings_text_wh_event_feed_string_scripted_event_exoticwaaghstart_primary_detail",
				"",
				"event_feed_strings_text_wh_event_feed_string_scripted_event_exoticwaaghstart_secondary_detail",
				true,
				593
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
	local exoticwaagh = ovn:add_tweaker("exoticwaagh", "Exotic WAAAGH!", "")
	exoticwaagh:add_option("enable", "Enable", "")
	exoticwaagh:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_exoticwaagh_value") == "enable" then
				sr_exoticwaagh()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_exoticwaagh_value") == "enable" then sr_exoticwaagh() end
	end
)