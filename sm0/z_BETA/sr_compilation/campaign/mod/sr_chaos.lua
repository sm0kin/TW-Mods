local function sr_chaos()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:instantly_dismantle_building("wh_main_hochland_brass_keep:1")

			cm:transfer_region_to_faction("wh_main_blightwater_kradtommen", "wh_dlc08_nor_naglfarlings")
			cm:transfer_region_to_faction("wh_main_ostermark_essen", "wh_dlc08_nor_naglfarlings")
			cm:transfer_region_to_faction("wh2_main_northern_great_jungle_xahutec", "wh_dlc08_nor_naglfarlings")

			cm:instantly_upgrade_building("wh_main_blightwater_kradtommen:0", "wh_main_nor_outpost_minor_human_3")
			cm:instantly_upgrade_building("wh_main_ostermark_essen:0", "wh_main_nor_outpost_minor_human_3")
			cm:instantly_upgrade_building("wh2_main_northern_great_jungle_xahutec:0", "wh_main_nor_outpost_minor_human_3")

			--Brass Keep

			local brasskeep_region = cm:get_region("wh_main_hochland_brass_keep")

			if brasskeep_region:owning_faction():name() == "wh_main_chs_the_brass_legion" then
			else
				cm:transfer_region_to_faction("wh_main_hochland_brass_keep", "wh_dlc08_nor_naglfarlings")
				cm:instantly_upgrade_building("wh_main_hochland_brass_keep:0", "wh_main_nor_outpost_minor_human_3")
				cm:instantly_upgrade_building("wh_main_hochland_brass_keep:1", "wh_main_nor_outpost_military_1")

				cm:create_force_with_general(
					"wh_dlc08_nor_naglfarlings",
					"wh_main_chs_inf_chaos_warriors_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_dlc01_chs_inf_forsaken_0",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					563,
					537,
					"general",
					"chs_lord",
					"names_name_789473183",
					"",
					"names_name_2147356186",
					"",
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)
			end

			--Mordheim
			cm:create_force(
				"wh_dlc08_nor_naglfarlings",
				"wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_dlc01_chs_inf_forsaken_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				660,
				480,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
				end
			)
			--Badlands
			cm:create_force(
				"wh_dlc08_nor_naglfarlings",
				"wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_cav_chaos_knights_0,wh_dlc01_chs_inf_forsaken_0,wh_main_chs_mon_trolls",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				740,
				194,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
				end
			)
			--Lustria
			cm:create_force(
				"wh_dlc08_nor_naglfarlings",
				"wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				170,
				155,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
				end
			)

			cm:transfer_region_to_faction("wh_main_mountains_of_hel_altar_of_spawns", "wh_main_nor_skaeling")
			cm:transfer_region_to_faction("wh_main_mountains_of_hel_aeslings_conclave", "wh_main_nor_skaeling")

			if cm:get_faction("wh_dlc08_nor_naglfarlings"):has_faction_leader() and cm:get_faction("wh_dlc08_nor_naglfarlings"):faction_leader():has_military_force() then
				local oldleader = cm:get_faction("wh_dlc08_nor_naglfarlings"):faction_leader():command_queue_index()

				cm:kill_character(oldleader, true, true)
			end

			cm:force_make_peace("wh_dlc08_nor_wintertooth", "wh_dlc08_nor_naglfarlings")
			cm:force_change_cai_faction_personality("wh_dlc08_nor_naglfarlings", "wh_norsca_default_hard")

			---- Start Event Message Pop Up

			core:add_listener(
				"chshordestartmesslistner",
				"FactionRoundStart",
				function(context)
					return context:faction():is_human() and cm:model():turn_number() >= 15
				end,
				function()
					chshordestartmess()
				end,
				false
			)

			---- Chaos Army Spawn Script listener

			core:add_listener(
				"chshordespawnlistener",
				"FactionRoundStart",
				function(context)
					return context:faction():name() == "wh_dlc08_nor_naglfarlings" and cm:model():turn_number() > 16
				end,
				function()
					chshordespawn()
				end,
				true
			)
		else
			----- Chaos Army Spawn Script listener loaded on saved game

			core:add_listener(
				"chshordespawnlistener",
				"FactionRoundStart",
				function(context)
					return context:faction():name() == "wh_dlc08_nor_naglfarlings" and cm:model():turn_number() > 16
				end,
				function()
					chshordespawn()
				end,
				true
			)
		end
	end
end

function chshordespawn()
	local kradtommen_region = cm:get_region("wh_main_blightwater_kradtommen")
	local essen_region = cm:get_region("wh_main_ostermark_essen")
	local xahutec_region = cm:get_region("wh2_main_northern_great_jungle_xahutec")
	local brass_keep_region = cm:get_region("wh_main_hochland_brass_keep")

	if kradtommen_region:owning_faction():name() == "wh_dlc08_nor_naglfarlings" then
		if 1 == cm:random_number(100, 1) then
			----  Badlands
			if cm:get_saved_value("deco_chsdwf") then
				chshordespawnmessdwf()

				cm:create_force_with_general(
					"wh2_main_chs_chaos_incursion_hef",
					"hobgoblin_cuthroats,chaos_dwarf_warriors,chaos_dwarf_warriors,chaos_dwarf_warriors_great_weapons,hobgoblin_wolf_bow_raider,slave_ogre,lava_troll,chaos_dwarf_warriors_rifles,infernal_guard,k'daai_fireborn,great_taurus,bull_centaur_render,bull_centaur_ba'hal,deathshrieker_rocket_launcher,magma_cannon",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					767,
					251,
					"general",
					"chs_lord",
					"names_name_2147346030",
					"",
					"names_name_2147350583",
					"",
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)
			else
				chshordespawnmess()

				cm:create_force(
					"wh2_main_chs_chaos_incursion_hef",
					"wh_main_chs_cav_chaos_knights_1,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_1,wh_main_chs_art_hellcannon,wh_main_chs_mon_giant,wh_dlc06_chs_feral_manticore,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					767,
					251,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)
			end

			cm:force_declare_war("wh2_main_chs_chaos_incursion_hef", "wh_main_dwf_karak_azul", true, true)

			if cm:get_faction("wh_main_dwf_dwarfs"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_hef", "wh_main_dwf_dwarfs", true, true)
			end

			if cm:get_faction("wh_main_grn_greenskins"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_hef", "wh_main_grn_greenskins", true, true)
			end
		elseif 2 == cm:random_number(100, 1) then
			---- Kingdom of the Beasts

			if cm:get_saved_value("deco_chsdwf") then
				chshordespawnmessdwf()

				cm:create_force_with_general(
					"wh2_main_chs_chaos_incursion_hef",
					"hobgoblin_cuthroats,chaos_dwarf_warriors,chaos_dwarf_warriors,chaos_dwarf_warriors_great_weapons,hobgoblin_wolf_bow_raider,slave_ogre,lava_troll,chaos_dwarf_warriors_rifles,infernal_guard,k'daai_fireborn,great_taurus,bull_centaur_render,bull_centaur_ba'hal,deathshrieker_rocket_launcher,magma_cannon",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					809,
					173,
					"general",
					"chs_lord",
					"names_name_2147353672",
					"",
					"names_name_2147357465",
					"",
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)
			else
				chshordespawnmess()

				cm:create_force(
					"wh2_main_chs_chaos_incursion_hef",
					"wh_main_chs_cav_chaos_knights_1,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_1,wh_main_chs_art_hellcannon,wh_main_chs_mon_giant,wh_dlc06_chs_feral_manticore,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					809,
					173,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)
			end

			cm:force_declare_war("wh2_main_chs_chaos_incursion_hef", "wh2_dlc09_tmb_lybaras", true, true)

			if cm:get_faction("wh2_main_lzd_last_defenders"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_hef", "wh2_main_lzd_last_defenders", true, true)
			end
		end
	end

	if essen_region:owning_faction():name() == "wh_dlc08_nor_naglfarlings" then
		if 3 == cm:random_number(100, 1) then
			--- Sylvannia
			chshordespawnmess()

			cm:create_force(
				"wh2_main_chs_chaos_incursion_def",
				"wh_main_chs_cav_chaos_knights_1,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_1,wh_main_chs_art_hellcannon,wh_main_chs_mon_giant,wh_dlc06_chs_feral_manticore,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				696,
				415,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
				end
			)

			cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_vmp_vampire_counts", true, true)

			if cm:get_faction("wh_main_dwf_dwarfs"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_dwf_dwarfs", true, true)
			end
		elseif 4 == cm:random_number(100, 1) then
			---- World Edge Mountains
			chshordespawnmessgrn()

			cm:create_force(
				"wh2_main_chs_chaos_incursion_def",
				"wh_main_chs_cav_chaos_knights_1,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_1,wh_main_chs_art_hellcannon,wh_main_chs_mon_giant,wh_dlc06_chs_feral_manticore,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				775,
				450,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
				end
			)

			cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_dwf_karak_kadrin", true, true)

			if cm:get_faction("wh_main_dwf_dwarfs"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_dwf_dwarfs", true, true)
			end

			if cm:get_faction("wh_main_grn_greenskins"):is_human() then
				cm:create_force(
					"wh_main_grn_bloody_spearz",
					"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_big_uns,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_1",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					770,
					400,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)

				cm:force_declare_war("wh_main_grn_bloody_spearz", "wh_main_dwf_karak_kadrin", true, true)
				cm:force_declare_war("wh_main_grn_bloody_spearz", "wh2_main_chs_chaos_incursion_def", true, true)
			else
				cm:teleport_to("faction:wh_main_grn_greenskins,surname:2147343867", 770, 410, true)

				cm:create_force(
					"wh_main_grn_greenskins",
					"wh_main_grn_inf_night_goblins,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_boyz,wh_main_grn_inf_orc_big_uns,wh_main_grn_inf_night_goblin_fanatics,wh_main_grn_inf_orc_arrer_boyz,wh_main_grn_inf_goblin_archers,wh_main_grn_inf_goblin_spearmen,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_orc_boar_boyz,wh_main_grn_cav_goblin_wolf_riders_1",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					770,
					400,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)
				cm:force_declare_war("wh_main_grn_greenskins", "wh_main_dwf_karak_kadrin", true, true)
				cm:force_declare_war("wh_main_grn_greenskins", "wh2_main_chs_chaos_incursion_def", true, true)

				local mountgunbad_region = cm:get_region("wh_main_rib_peaks_mount_gunbad")
				local human_players = cm:get_human_factions()

				if mountgunbad_region:owning_faction():name() == human_players[1] then
				else
					cm:transfer_region_to_faction("wh_main_rib_peaks_mount_gunbad", "wh_main_grn_greenskins")
				end
			end
		end
	end

	if brass_keep_region:owning_faction():name() == "wh_dlc08_nor_naglfarlings" then
		if 5 == cm:random_number(100, 1) then
			----- Brass Keep
			chshordespawnmessvalten()

			cm:create_force(
				"wh2_main_chs_chaos_incursion_def",
				"wh_main_chs_cav_chaos_knights_1,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_1,wh_main_chs_art_hellcannon,wh_main_chs_mon_giant,wh_dlc06_chs_feral_manticore,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				563,
				532,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
				end
			)

			cm:create_force_with_general(
				"wh_main_emp_middenland",
				"wh_main_emp_inf_spearmen_0,wh_main_emp_inf_handgunners,wh_main_emp_inf_handgunners,wh_main_emp_inf_swordsmen,wh_main_emp_inf_halberdiers,wh_main_emp_inf_halberdiers,wh_dlc04_emp_inf_flagellants_0,wh_dlc04_emp_inf_flagellants_0,wh_main_emp_inf_greatswords,wh_dlc04_emp_inf_free_company_militia_0,wh_main_emp_inf_crossbowmen,wh_dlc04_emp_cav_knights_blazing_sun_0,wh_main_emp_art_helblaster_volley_gun,wh_main_emp_art_great_cannon",
				"wh2_main_northern_great_jungle_temple_of_tlencan",
				529,
				520,
				"general",
				"dlc04_emp_arch_lector",
				"names_name_999982294",
				"",
				"",
				"",
				false,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					cm:add_agent_experience("faction:wh_main_emp_middenland,forname:999982294", 5000)
				end
			)

			cm:create_force(
				"wh2_main_skv_clan_eshin",
				"wh2_main_skv_inf_gutter_runners_0,wh2_main_skv_inf_stormvermin_0,wh2_main_skv_inf_gutter_runners_1,wh2_main_skv_inf_clanrats_1,wh2_main_skv_inf_night_runners_0,wh2_main_skv_inf_clanrat_spearmen_1,wh2_main_skv_mon_rat_ogres,wh2_main_skv_inf_plague_monk_censer_bearer,wh2_main_skv_inf_warpfire_thrower,wh2_main_skv_veh_doomwheel,wh2_main_skv_art_warp_lightning_cannon",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				495,
				520,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
				end
			)

			cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_emp_middenland", true, true)
			cm:force_declare_war("wh2_main_skv_clan_eshin", "wh_main_emp_middenland", false, false)

			if cm:get_faction("wh_main_emp_empire"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_emp_empire", true, true)
			end

			local weismund_region = cm:get_region("wh_main_middenland_weismund")
			local human_players = cm:get_human_factions()

			if weismund_region:owning_faction():name() == human_players[1] then
			else
				cm:transfer_region_to_faction("wh_main_middenland_weismund", "wh2_main_skv_clan_eshin")
			end
		elseif 6 == cm:random_number(100, 1) then
			----- West Kislev

			if cm:get_saved_value("deco_chsdwf") then
				cm:create_force_with_general(
					"wh2_main_chs_chaos_incursion_def",
					"hobgoblin_cuthroats,chaos_dwarf_warriors,chaos_dwarf_warriors,chaos_dwarf_warriors_great_weapons,hobgoblin_wolf_bow_raider,slave_ogre,lava_troll,chaos_dwarf_warriors_rifles,infernal_guard,k'daai_fireborn,great_taurus,bull_centaur_render,bull_centaur_ba'hal,deathshrieker_rocket_launcher,magma_cannon",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					610,
					617,
					"general",
					"chs_lord",
					"names_name_2147346073",
					"",
					"names_name_2147350560",
					"",
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)
			else
				cm:create_force(
					"wh2_main_chs_chaos_incursion_def",
					"wh_main_chs_cav_chaos_knights_1,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_1,wh_main_chs_art_hellcannon,wh_main_chs_mon_giant,wh_dlc06_chs_feral_manticore,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					610,
					617,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)
			end

			cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_ksl_kislev", true, true)
			cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh2_main_hef_order_of_loremasters", true, true)

			local bayblade_region = cm:get_region("wh_main_trollheim_mountains_bay_of_blades")
			local human_players = cm:get_human_factions()

			if bayblade_region:owning_faction():name() == human_players[1] then
			else
				cm:transfer_region_to_faction("wh_main_trollheim_mountains_bay_of_blades", "wh2_main_hef_order_of_loremasters")
			end

			if bayblade_region:owning_faction():name() == "wh2_main_hef_order_of_loremasters" then
				chshordespawnmesself()
			else
				chshordespawnmesselffail()
			end

			if not cm:get_faction("wh2_main_hef_order_of_loremasters"):is_human() then
				cm:create_force(
					"wh2_main_hef_order_of_loremasters",
					"wh2_main_hef_inf_swordmasters_of_hoeth_0,wh2_main_hef_inf_white_lions_of_chrace_0,wh2_main_hef_cav_dragon_princes,wh2_main_hef_inf_archers_1,wh2_main_hef_mon_great_eagle,wh2_main_hef_mon_phoenix_frostheart,wh2_main_hef_inf_lothern_sea_guard_1,wh2_main_hef_inf_lothern_sea_guard_1,wh2_main_hef_inf_lothern_sea_guard_1,wh2_dlc10_hef_inf_shadow_walkers_0,wh2_dlc10_hef_inf_shadow_walkers_0,wh2_dlc10_hef_inf_shadow_walkers_0,wh2_main_hef_art_eagle_claw_bolt_thrower,wh2_main_hef_art_eagle_claw_bolt_thrower",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					560,
					600,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)
			end
		end
	end

	if xahutec_region:owning_faction():name() == "wh_dlc08_nor_naglfarlings" then
		if 7 == cm:random_number(100, 1) then
			---- Lustria
			chshordespawnmessliz()

			cm:create_force(
				"wh2_main_chs_chaos_incursion_lzd",
				"wh_main_chs_cav_chaos_knights_1,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_1,wh_main_chs_art_hellcannon,wh_main_chs_mon_giant,wh_dlc06_chs_feral_manticore,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
				"wh2_main_kingdom_of_beasts_serpent_coast",
				170,
				150,
				true,
				function(cqi)
					cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
				end
			)

			cm:force_declare_war("wh2_main_chs_chaos_incursion_lzd", "wh2_main_lzd_itza", true, true)

			if cm:get_faction("wh2_main_lzd_hexoatl"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_lzd", "wh2_main_lzd_hexoatl", true, true)
			end
		elseif 8 == cm:random_number(100, 1) then
			----	Naggaroth/Ulthuan Sea

			if cm:get_faction("wh2_main_def_cult_of_pleasure"):is_human() then
				chshordespawnmessdelf()

				cm:create_force(
					"wh2_main_chs_chaos_incursion_lzd",
					"wh_main_chs_cav_chaos_knights_1,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_1,wh_main_chs_art_hellcannon,wh_main_chs_mon_giant,wh_dlc06_chs_feral_manticore,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
					"wh2_main_kingdom_of_beasts_serpent_coast",
					160,
					450,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)

				cm:force_declare_war("wh2_main_chs_chaos_incursion_lzd", "wh2_main_hef_eataine", true, true)
			else
				chshordespawnmessdelf()

				cm:create_force(
					"wh2_main_def_cult_of_pleasure",
					"wh_main_chs_inf_chaos_marauders_1,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_main_chs_cav_chaos_knights_1,wh2_main_def_inf_witch_elves_0,wh2_main_def_inf_witch_elves_0,wh_main_chs_inf_chaos_warriors_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_0,wh2_main_def_inf_black_ark_corsairs_1,wh2_main_def_cav_cold_one_knights_0,wh2_main_def_cav_cold_one_knights_1",
					"wh2_main_land_of_the_dead_zandri",
					110,
					400,
					true,
					function(cqi)
						cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, -1, true)
					end
				)

				cm:force_declare_war("wh2_main_def_cult_of_pleasure", "wh2_main_lzd_hexoatl", true, true)
			end
		end
	end
end

function chshordestartmess()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosstart_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosstart_secondary_detail",
			true,
			595
		)
	end
end

function chshordespawnmess()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawn_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawn_secondary_detail",
			true,
			595
		)
	end
end

function chshordespawnmessvalten()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawnvalten_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawnvalten_secondary_detail",
			true,
			591
		)
	end
end

function chshordespawnmessdwf()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawndwf_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawndwf_secondary_detail",
			true,
			595
		)
	end
end

function chshordespawnmessgrn()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawngrn_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawngrn_secondary_detail",
			true,
			593
		)
	end
end

function chshordespawnmessliz()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawnliz_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawnliz_secondary_detail",
			true,
			775
		)
	end
end

function chshordespawnmesself()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawnelf_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawnelf_secondary_detail",
			true,
			771
		)
	end
end

function chshordespawnmesselffail()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawnelffail_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawnelffail_secondary_detail",
			true,
			771
		)
	end
end

function chshordespawnmessdelf()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawndelf_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_chaosspawndelf_secondary_detail",
			true,
			773
		)
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
	local chaos = ovn:add_tweaker("chaos", "Hordes of Chaos", "")
	chaos:add_option("enable", "Enable", "")
	chaos:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_chaos_value") == "enable" then
				sr_chaos()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_chaos_value") == "enable" then sr_chaos() end
	end
)