local function sr_chaos()
	if cm:model():campaign_name("main_warhammer") then
		cm:force_diplomacy("subculture:wh_main_sc_nor_warp", "culture:wh_main_chs_chaos", "all", true, true, true)
		local rotblood_tribe = cm:get_faction("wh_dlc08_nor_naglfarlings")

		local mct = core:get_static_object("mod_configuration_tool")
		local rotblood_value
		local enable_value
		if mct then
			local lost_factions_mod = mct:get_mod_by_key("lost_factions")
			local rotblood_option = lost_factions_mod:get_option_by_key("rotblood")
			rotblood_value = rotblood_option:get_finalized_setting()	
			rotblood_option:set_read_only(true)
			local enable_option = lost_factions_mod:get_option_by_key("enable")
			enable_value = enable_option:get_finalized_setting()	
			enable_option:set_read_only(true)
		end
		if rotblood_tribe and (rotblood_tribe:is_human() or not mct or rotblood_value and enable_value) then
			if cm:is_new_game() then
				if rotblood_tribe:is_human() then
					randomnum = cm:random_number(3, 1)

					if 1 == randomnum then
						cm:transfer_region_to_faction("wh_main_blightwater_kradtommen", "wh_dlc08_nor_naglfarlings")
						local grimhold_region = cm:model():world():region_manager():region_by_key("wh_main_blightwater_kradtommen")
						cm:instantly_set_settlement_primary_slot_level(grimhold_region:settlement(), 1)
						cm:force_religion_factors("wh_main_blightwater_kradtommen", "wh_main_religion_chaos", 1)
						cm:heal_garrison(cm:get_region("wh_main_blightwater_kradtommen"):cqi())

						cm:create_force(
							"wh_dlc08_nor_naglfarlings",
							"wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_cav_chaos_knights_0,wh_dlc01_chs_inf_forsaken_0,wh_main_chs_mon_trolls",
							"wh2_main_kingdom_of_beasts_serpent_coast",
							740,
							194,
							true,
							function(cqi)
								cm:apply_effect_bundle_to_characters_force("ovn_Slaa", cqi, -1, true)
							end
						)
					elseif 2 == randomnum then
						cm:transfer_region_to_faction("wh2_main_northern_great_jungle_xahutec", "wh_dlc08_nor_naglfarlings")
						local xahutec_region = cm:model():world():region_manager():region_by_key("wh2_main_northern_great_jungle_xahutec")
						cm:instantly_set_settlement_primary_slot_level(xahutec_region:settlement(), 2)
						cm:force_religion_factors("wh2_main_northern_great_jungle_xahutec", "wh_main_religion_chaos", 1)
						cm:heal_garrison(cm:get_region("wh2_main_northern_great_jungle_xahutec"):cqi())

						--Lustria
						cm:create_force(
							"wh_dlc08_nor_naglfarlings",
							"wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
							"wh2_main_kingdom_of_beasts_serpent_coast",
							170,
							155,
							true,
							function(cqi)
								cm:apply_effect_bundle_to_characters_force("ovn_Khar", cqi, -1, true)
							end
						)
					elseif 3 == randomnum then
						cm:transfer_region_to_faction("wh_main_hochland_brass_keep", "wh_dlc08_nor_naglfarlings")
						local brasskeep_region = cm:model():world():region_manager():region_by_key("wh_main_hochland_brass_keep")
						cm:instantly_set_settlement_primary_slot_level(brasskeep_region:settlement(), 2)
						cm:heal_garrison(cm:get_region("wh_main_hochland_brass_keep"):cqi())
						cm:force_religion_factors("wh_main_hochland_brass_keep", "wh_main_religion_chaos", 1)
						cm:create_force_with_general(
							"wh_dlc08_nor_naglfarlings",
							"wh_main_chs_inf_chaos_warriors_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0",
							"wh2_main_kingdom_of_beasts_serpent_coast",
							563,
							537,
							"general",
							"chs_lord",
							"names_name_999982317",
							"",
							"",
							"",
							true,
							function(cqi)
								cm:apply_effect_bundle_to_characters_force("ovn_Tzeen", cqi, -1, true)
								cm:set_character_unique("character_cqi:" .. cqi, true)
							end
						)
					end
				else
					cm:transfer_region_to_faction("wh2_main_chrace_elisia", "wh_dlc08_nor_naglfarlings")
					cm:transfer_region_to_faction("wh_main_blightwater_kradtommen", "wh_dlc08_nor_naglfarlings")
					cm:transfer_region_to_faction("wh2_main_northern_great_jungle_xahutec", "wh_dlc08_nor_naglfarlings")

					cm:force_religion_factors("wh_main_blightwater_kradtommen", "wh_main_religion_chaos", 1)
					cm:force_religion_factors("wh2_main_northern_great_jungle_xahutec", "wh_main_religion_chaos", 1)
					cm:force_religion_factors("wh2_main_chrace_elisia", "wh_main_religion_chaos", 1)

					cm:heal_garrison(cm:get_region("wh_main_blightwater_kradtommen"):cqi())
					cm:heal_garrison(cm:get_region("wh2_main_northern_great_jungle_xahutec"):cqi())
					cm:heal_garrison(cm:get_region("wh2_main_chrace_elisia"):cqi())

					local grimhold_region = cm:model():world():region_manager():region_by_key("wh_main_blightwater_kradtommen")
					cm:instantly_set_settlement_primary_slot_level(grimhold_region:settlement(), 1)

					local brasskeep_region = cm:model():world():region_manager():region_by_key("wh_main_hochland_brass_keep")
					cm:instantly_set_settlement_primary_slot_level(brasskeep_region:settlement(), 2)

					cm:force_change_cai_faction_personality("wh_dlc08_nor_naglfarlings", "wh_norsca_default_hard")

					cm:create_force(
						"wh_dlc08_nor_naglfarlings",
						"wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_cav_chaos_knights_0,wh_dlc01_chs_inf_forsaken_0,wh_main_chs_mon_trolls",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						740,
						194,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("ovn_Slaa", cqi, -1, true)
						end
					)

					cm:create_force(
						"wh_dlc08_nor_naglfarlings",
						"wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0,wh_dlc01_chs_inf_forsaken_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						640,
						470,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("ovn_Tzeen", cqi, -1, true)
						end
					)

					cm:create_force(
						"wh_dlc08_nor_naglfarlings",
						"wh_main_chs_inf_chaos_warriors_0,wh_dlc01_chs_inf_chaos_warriors_2,wh_main_chs_mon_chaos_spawn,wh_dlc01_chs_inf_forsaken_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						170,
						155,
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("ovn_Khar", cqi, -1, true)
						end
					)
					cm:create_force_with_general(
						"wh_dlc08_nor_naglfarlings",
						"wh_main_chs_inf_chaos_warriors_0,wh_main_chs_mon_chaos_spawn,wh_main_chs_cav_chaos_knights_0",
						"wh2_main_kingdom_of_beasts_serpent_coast",
						563,
						537,
						"general",
						"chs_lord",
						"names_name_999982317",
						"",
						"",
						"",
						true,
						function(cqi)
							cm:apply_effect_bundle_to_characters_force("ovn_Nurgh", cqi, -1, true)
							cm:set_character_unique("character_cqi:" .. cqi, true)
						end
					)

					if cm:get_faction("wh2_dlc12_lzd_cult_of_sotek"):is_human() then
						local xahutec_region = cm:model():world():region_manager():region_by_key("wh2_main_northern_great_jungle_xahutec")
						cm:instantly_set_settlement_primary_slot_level(xahutec_region:settlement(), 1)
					end
				end

				cm:transfer_region_to_faction("wh_main_mountains_of_hel_altar_of_spawns", "wh_dlc08_nor_helspire_tribe")
				cm:heal_garrison(cm:get_region("wh_main_mountains_of_hel_altar_of_spawns"):cqi())

				local oldleader = cm:get_faction("wh_dlc08_nor_naglfarlings"):faction_leader():command_queue_index()

				cm:kill_character(oldleader, true, true)
				cm:force_make_peace("wh_dlc08_nor_wintertooth", "wh_dlc08_nor_naglfarlings")

				---- Start Event Message Pop Up

				core:add_listener(
					"chshordestartmesslistner",
					"FactionRoundStart",
					function(context)
						return context:faction():is_human() and cm:model():turn_number() == 15
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

				setup_cwd_and_fimir_raze_region_monitor()
			else -- AKA NOT A NEW GAME - Chaos Army Spawn Script listener loaded on saved game
				core:add_listener(
					"chshordespawnlistener2",
					"FactionRoundStart",
					function(context)
						return context:faction():name() == "wh_dlc08_nor_naglfarlings" and cm:model():turn_number() > 16
					end,
					function()
						chshordespawn()
					end,
					true
				)

				setup_cwd_and_fimir_raze_region_monitor()
			end
		end
	end
end

function chshordespawn()
	local kradtommen_region = cm:get_region("wh_main_blightwater_kradtommen")
	local mordheim_region = cm:get_region("wh_main_ostermark_mordheim")
	local xahutec_region = cm:get_region("wh2_main_northern_great_jungle_xahutec")
	local brass_keep_region = cm:get_region("wh_main_hochland_brass_keep")

	----  CWD HOLD KRADTOMMEN - Settlement 1

	if kradtommen_region:owning_faction():name() == "wh_dlc08_nor_naglfarlings" then
		----  Badlands Spawn: Option 1A
		if 1 == cm:random_number(75, 1) then
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
						cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_hef,forename:2147346030", 20000)
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
						cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_hef", 20000)
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

			cm:force_diplomacy(
				"faction:wh_dlc08_nor_naglfarlings",
				"faction:wh2_main_chs_chaos_incursion_hef",
				"military alliance",
				false,
				false,
				true
			)
		elseif 2 == cm:random_number(75, 1) then
			----  Kingdom of Beasts Spawn: Option 1B

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
						cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_hef,forename:2147353672", 20000)
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
						cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_hef", 20000)
					end
				)
			end

			cm:force_declare_war("wh2_main_chs_chaos_incursion_hef", "wh2_dlc09_tmb_lybaras", true, true)

			if cm:get_faction("wh2_main_lzd_last_defenders"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_hef", "wh2_main_lzd_last_defenders", true, true)
			end

			cm:force_diplomacy(
				"faction:wh_dlc08_nor_naglfarlings",
				"faction:wh2_main_chs_chaos_incursion_hef",
				"military alliance",
				false,
				false,
				true
			)
		end
	end

	----  CWD HOLD Mordheim - Settlement 2
	if mordheim_region:owning_faction():name() == "wh_dlc08_nor_naglfarlings" then
		----  Sylvania Spawn: Option 2A
		if 3 == cm:random_number(75, 1) then
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
					cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_def", 20000)
				end
			)

			cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_vmp_vampire_counts", true, true)

			if cm:get_faction("wh_main_dwf_dwarfs"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_dwf_dwarfs", true, true)
			end

			cm:force_diplomacy(
				"faction:wh_dlc08_nor_naglfarlings",
				"faction:wh2_main_chs_chaos_incursion_def",
				"military alliance",
				false,
				false,
				true
			)
		elseif 4 == cm:random_number(75, 1) then
			----  North Worlds Edge Mountains Spawn: Option 2B
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
					cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_def", 20000)
				end
			)

			cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_dwf_karak_kadrin", true, true)

			if cm:get_faction("wh_main_dwf_dwarfs"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_dwf_dwarfs", true, true)
			end

			cm:force_diplomacy(
				"faction:wh_dlc08_nor_naglfarlings",
				"faction:wh2_main_chs_chaos_incursion_def",
				"military alliance",
				false,
				false,
				true
			)
		end
	end

	----  CWD HOLD Brass Keep - Settlement 3
	if brass_keep_region:owning_faction():name() == "wh_dlc08_nor_naglfarlings" then
		----  Brass Keep Spawn: Option 3A
		if 5 == cm:random_number(75, 1) then
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
					cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_def", 20000)
				end
			)

			cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_emp_middenland", true, true)

			if cm:get_faction("wh_main_emp_empire"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_emp_empire", true, true)
			end

			cm:force_diplomacy(
				"faction:wh_dlc08_nor_naglfarlings",
				"faction:wh2_main_chs_chaos_incursion_def",
				"military alliance",
				false,
				false,
				true
			)
		elseif 6 == cm:random_number(75, 1) then
			----  West Kislev Spawn: Option 3B

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
						cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_def,forename:2147346073", 20000)
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
						cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_def", 20000)
					end
				)
			end

			cm:force_declare_war("wh2_main_chs_chaos_incursion_def", "wh_main_ksl_kislev", true, true)

			cm:force_diplomacy(
				"faction:wh_dlc08_nor_naglfarlings",
				"faction:wh2_main_chs_chaos_incursion_def",
				"military alliance",
				false,
				false,
				true
			)
		end
	end

	----  CWD HOLD Xahutec - Settlement 4
	if xahutec_region:owning_faction():name() == "wh_dlc08_nor_naglfarlings" then
		if 7 == cm:random_number(75, 1) then
			----  Xauhutec Spawn: Option 4A

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
					cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_lzd", 20000)
				end
			)

			cm:force_declare_war("wh2_main_chs_chaos_incursion_lzd", "wh2_main_lzd_itza", true, true)

			if cm:get_faction("wh2_main_lzd_hexoatl"):is_human() then
				cm:force_declare_war("wh2_main_chs_chaos_incursion_lzd", "wh2_main_lzd_hexoatl", true, true)
			end

			cm:force_diplomacy(
				"faction:wh_dlc08_nor_naglfarlings",
				"faction:wh2_main_chs_chaos_incursion_lzd",
				"military alliance",
				false,
				false,
				true
			)
		elseif 8 == cm:random_number(75, 1) then
			----  East Ulthuan Sea Spawn: Option 4B

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
					cm:add_agent_experience("faction:wh2_main_chs_chaos_incursion_lzd", 20000)
				end
			)

			cm:force_declare_war("wh2_main_chs_chaos_incursion_lzd", "wh2_main_hef_eataine", true, true)

			cm:force_diplomacy(
				"faction:wh_dlc08_nor_naglfarlings",
				"faction:wh2_main_chs_chaos_incursion_lzd",
				"military alliance",
				false,
				false,
				true
			)
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

function setup_cwd_and_fimir_raze_region_monitor() -- Applies Chaos corruption via an effect bundle to a region that is razed by an army belonging to CWD & Fimir
	core:add_listener(
		"cwd_and_fimir_raze_region_monitor",
		"CharacterRazedSettlement",
		function(context)
			return context:character():faction():subculture() == "wh_main_sc_nor_warp" or
				context:character():faction():subculture() == "wh_main_sc_nor_fimir"
		end,
		function(context)
			local char = context:character()
			if char:has_region() then
				local region = char:region():name()
				cm:apply_effect_bundle_to_region("wh_main_bundle_region_chaos_corruption", region, 5)
			end
		end,
		true
	)
end

cm:add_first_tick_callback(
	function()
		sr_chaos()
	end
)