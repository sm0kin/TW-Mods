local function sr_deadawaken()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			core:add_listener(
				"sr_deadawaken_startlistner",
				"FactionRoundStart",
				function(context)
					return context:faction():is_human() and cm:model():turn_number() == 3
				end,
				function()
					sr_deadawaken_start()
				end,
				false
			)
		else
			core:add_listener(
				"undeadspawnall",
				"FactionRoundStart",
				function(context)
					return context:faction():name() == "wh_main_vmp_vampire_counts"
				end,
				function()
					SR_undeadspawn_all()
				end,
				true
			)
		end
	end
end

function sr_deadawaken_start()
	if 1 == cm:random_number(3, 1) then
		spawn_start_army_araby()
	elseif 2 == cm:random_number(3, 1) then
		spawn_start_army_naggaroth()
	else
		spawn_start_army_lustria()
	end
end

function spawn_start_army_araby()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event_located(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadstart_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadstart_secondary_detail",
			712,
			165,
			true,
			594
		)
	end

	cm:create_force(
		"wh_main_vmp_vampire_counts",
		"wh_dlc02_vmp_cav_blood_knights_0,wh_dlc04_vmp_veh_corpse_cart_2,wh_main_vmp_cav_black_knights_0,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0",
		"wh_main_blightwater_deff_gorge",
		710,
		170,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
		end
	)
	cm:transfer_region_to_faction("wh_main_blightwater_deff_gorge", "wh_main_vmp_vampire_counts")
	cm:force_declare_war("wh_main_grn_red_fangs", "wh_main_vmp_vampire_counts", true, true)

	core:add_listener(
		"undeadspawnaraby",
		"FactionRoundStart",
		function(context)
			return context:faction():name() == "wh_main_vmp_vampire_counts"
		end,
		function()
			SR_undeadspawn_araby()
		end,
		true
	)
end

function spawn_start_army_naggaroth()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event_located(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadstart_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadstart_secondary_detail",
			290,
			665,
			true,
			594
		)
	end

	cm:create_force(
		"wh_main_vmp_vampire_counts",
		"wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_dire_wolves,wh_main_vmp_mon_dire_wolves,wh_main_vmp_inf_grave_guard_1,wh_main_vmp_mon_crypt_horrors",
		"wh2_main_deadwood_shagrath",
		295,
		670,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
		end
	)
	cm:transfer_region_to_faction("wh2_main_deadwood_shagrath", "wh_main_vmp_vampire_counts")
	cm:force_declare_war("wh2_main_nor_aghol", "wh_main_vmp_vampire_counts", true, true)

	core:add_listener(
		"undeadspawnnaggaroth",
		"FactionRoundStart",
		function(context)
			return context:faction():name() == "wh_main_vmp_vampire_counts"
		end,
		function()
			SR_undeadspawn_naggaroth()
		end,
		true
	)
end

function spawn_start_army_lustria()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event_located(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadstart_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadstart_secondary_detail",
			35,
			100,
			true,
			594
		)
	end

	cm:create_force(
		"wh_main_vmp_vampire_counts",
		"wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_fell_bats,wh_main_vmp_cav_black_knights_3,wh_main_vmp_mon_dire_wolves,wh_main_vmp_inf_grave_guard_0,wh_main_vmp_inf_crypt_ghouls",
		"wh2_main_jungles_of_green_mists_wellsprings_of_eternity",
		40,
		100,
		true,
		function(cqi)
			cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
		end
	)
	cm:transfer_region_to_faction("wh2_main_jungles_of_green_mists_wellsprings_of_eternity", "wh_main_vmp_vampire_counts")
	cm:force_declare_war("wh2_main_lzd_sentinels_of_xeti", "wh_main_vmp_vampire_counts", true, true)

	core:add_listener(
		"undeadspawnlustria",
		"FactionRoundStart",
		function(context)
			return context:faction():name() == "wh_main_vmp_vampire_counts"
		end,
		function()
			SR_undeadspawn_lustria()
		end,
		true
	)
end

function SR_undeadspawn_lustria()
	local wellsprings_region = cm:get_region("wh2_main_jungles_of_green_mists_wellsprings_of_eternity")
	if wellsprings_region:owning_faction():name() == "wh_main_vmp_vampire_counts" then
		if 1 == cm:random_number(66, 1) then
			spawn_army_arabyd()
		else
			if 2 == cm:random_number(66, 1) then
				spawn_army_bretonniad()
			else
				if 3 == cm:random_number(66, 1) then
					spawn_army_naggarothd()
				end
			end
		end
	end
end

function SR_undeadspawn_naggaroth()
	local shagrath_region = cm:get_region("wh2_main_deadwood_shagrath")
	if shagrath_region:owning_faction():name() == "wh_main_vmp_vampire_counts" then
		if 1 == cm:random_number(66, 1) then
			spawn_army_arabyd()
		else
			if 2 == cm:random_number(66, 1) then
				spawn_army_lustriad()
			else
				if 3 == cm:random_number(66, 1) then
					spawn_army_bretonniad()
				end
			end
		end
	end
end

function SR_undeadspawn_araby()
	local deff_region = cm:get_region("wh_main_blightwater_deff_gorge")
	if deff_region:owning_faction():name() == "wh_main_vmp_vampire_counts" then
		if 1 == cm:random_number(66, 1) then
			spawn_army_bretonniad()
		else
			if 2 == cm:random_number(66, 1) then
				spawn_army_lustriad()
			else
				if 3 == cm:random_number(66, 1) then
					spawn_army_naggarothd()
				end
			end
		end
	end
end

function SR_undeadspawn_all()
	local wellsprings_region = cm:get_region("wh2_main_jungles_of_green_mists_wellsprings_of_eternity")
	local deff_region = cm:get_region("wh_main_blightwater_deff_gorge")
	local shagrath_region = cm:get_region("wh2_main_deadwood_shagrath")

	if
		wellsprings_region:owning_faction():name() == "wh_main_vmp_vampire_counts" or
			deff_region:owning_faction():name() == "wh_main_vmp_vampire_counts" or
			shagrath_region:owning_faction():name() == "wh_main_vmp_vampire_counts"
	 then
		if 1 == cm:random_number(80, 1) then
			spawn_army_arabyd()
		else
			if 2 == cm:random_number(80, 1) then
				spawn_army_bretonniad()
			elseif 3 == cm:random_number(80, 1) then
				spawn_army_lustriad()
			else
				if 4 == cm:random_number(80, 1) then
					spawn_army_naggarothd()
				end
			end
		end
	end
end

function spawn_army_arabyd()
	announce_spawna()

	cm:force_declare_war("wh_main_grn_red_fangs", "wh_main_vmp_vampire_counts", true, true)
	cm:force_declare_war("wh_main_dwf_karak_azul", "wh_main_vmp_vampire_counts", true, true)

	if cm:get_faction("wh_main_vmp_vampire_counts"):is_human() then
		cm:create_force(
			"wh_main_vmp_vampire_counts",
			"wh_dlc02_vmp_cav_blood_knights_0,wh_dlc02_vmp_cav_blood_knights_0,wh_main_vmp_cav_black_knights_0,wh_main_vmp_cav_black_knights_3,wh_main_vmp_cav_black_knights_3,wh_dlc04_vmp_veh_corpse_cart_2,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_grave_guard_0,wh_main_vmp_inf_grave_guard_0",
			"wh_main_blightwater_deff_gorge",
			710,
			170,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh_main_vmp_vampire_counts",
			"wh_dlc02_vmp_cav_blood_knights_0,wh_dlc02_vmp_cav_blood_knights_0,wh_dlc02_vmp_cav_blood_knights_0,wh_main_vmp_cav_black_knights_0,wh_main_vmp_cav_black_knights_3,wh_main_vmp_cav_black_knights_3,wh_dlc04_vmp_veh_corpse_cart_2,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_grave_guard_0,wh_main_vmp_inf_grave_guard_0",
			"wh_main_blightwater_deff_gorge",
			710,
			170,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local deff_gorge_region = cm:get_region("wh_main_blightwater_deff_gorge")
		local human_players = cm:get_human_factions()

		if deff_gorge_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh_main_vmp_vampire_counts", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh_main_blightwater_deff_gorge", "wh_main_vmp_vampire_counts")
		end
	end
end

function spawn_army_naggarothd()
	announce_spawnn()

	cm:force_declare_war("wh2_main_nor_aghol", "wh_main_vmp_vampire_counts", true, true)
	cm:force_declare_war("wh2_main_def_deadwood_sentinels", "wh_main_vmp_vampire_counts", true, true)

	if cm:get_faction("wh_main_vmp_vampire_counts"):is_human() then
		cm:create_force(
			"wh_main_vmp_vampire_counts",
			"wh_main_vmp_mon_fell_bats,wh_main_vmp_inf_grave_guard_0,wh_main_vmp_mon_varghulf,wh_main_vmp_mon_vargheists,wh_main_vmp_inf_grave_guard_1,wh_dlc04_vmp_veh_mortis_engine_0,wh_main_vmp_mon_crypt_horrors,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_mon_dire_wolves,wh_main_vmp_mon_dire_wolves,wh_main_vmp_mon_varghulf,wh_main_vmp_inf_skeleton_warriors_0",
			"wh2_main_deadwood_shagrath",
			295,
			670,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh_main_vmp_vampire_counts",
			"wh_main_vmp_mon_fell_bats,wh_main_vmp_inf_grave_guard_0,wh_main_vmp_mon_varghulf,wh_main_vmp_mon_vargheists,wh_main_vmp_inf_grave_guard_1,wh_dlc04_vmp_veh_mortis_engine_0,wh_main_vmp_mon_crypt_horrors,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_mon_dire_wolves,wh_main_vmp_mon_dire_wolves,wh_main_vmp_mon_varghulf,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_mon_varghulf",
			"wh2_main_deadwood_shagrath",
			295,
			670,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local shagrath_region = cm:get_region("wh2_main_deadwood_shagrath")
		local human_players = cm:get_human_factions()

		if shagrath_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh_main_vmp_vampire_counts", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh2_main_deadwood_shagrath", "wh_main_vmp_vampire_counts")
		end
	end
end

function spawn_army_lustriad()
	announce_spawnl()

	cm:force_declare_war("wh2_main_lzd_sentinels_of_xeti", "wh_main_vmp_vampire_counts", true, true)
	cm:force_declare_war("wh2_main_lzd_itza", "wh_main_vmp_vampire_counts", true, true)

	if cm:get_faction("wh_main_vmp_vampire_counts"):is_human() then
		cm:create_force(
			"wh_main_vmp_vampire_counts",
			"wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_dire_wolves,wh_main_vmp_inf_grave_guard_0,wh_main_vmp_inf_grave_guard_0,wh_main_vmp_cav_black_knights_3,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_mon_terrorgheist,wh_dlc04_vmp_veh_corpse_cart_0,wh_main_vmp_cav_hexwraiths",
			"wh2_main_jungles_of_green_mists_wellsprings_of_eternity",
			40,
			100,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh_main_vmp_vampire_counts",
			"wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_fell_bats,wh_main_vmp_mon_dire_wolves,wh_main_vmp_inf_grave_guard_0,wh_main_vmp_inf_grave_guard_0,wh_main_vmp_cav_black_knights_3,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_mon_terrorgheist,wh_dlc04_vmp_veh_corpse_cart_0,wh_main_vmp_cav_hexwraiths,wh_main_vmp_cav_hexwraiths",
			"wh2_main_jungles_of_green_mists_wellsprings_of_eternity",
			40,
			100,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local wellsprings_region = cm:get_region("wh2_main_jungles_of_green_mists_wellsprings_of_eternity")
		local human_players = cm:get_human_factions()

		if wellsprings_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh_main_vmp_vampire_counts", human_players[1], true, true)
		else
			cm:transfer_region_to_faction(
				"wh2_main_jungles_of_green_mists_wellsprings_of_eternity",
				"wh_main_vmp_vampire_counts"
			)
		end
	end
end

function spawn_army_bretonniad()
	announce_spawnb()

	cm:force_declare_war("wh_main_brt_bretonnia", "wh_main_vmp_vampire_counts", true, true)
	cm:force_declare_war("wh_main_brt_carcassonne", "wh_main_vmp_vampire_counts", true, true)

	if cm:get_faction("wh_main_vmp_vampire_counts"):is_human() then
		cm:create_force(
			"wh_main_vmp_vampire_counts",
			"wh_main_vmp_cav_hexwraiths,wh_main_vmp_inf_cairn_wraiths,wh_main_vmp_veh_black_coach,wh_main_vmp_cav_black_knights_3,wh_main_vmp_cav_black_knights_3,wh_main_vmp_cav_black_knights_3,wh_dlc02_vmp_cav_blood_knights_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_cairn_wraiths",
			"wh_main_carcassone_et_brionne_castle_carcassonne",
			460,
			320,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)
	else
		cm:create_force(
			"wh_main_vmp_vampire_counts",
			"wh_main_vmp_cav_hexwraiths,wh_main_vmp_cav_hexwraiths,wh_main_vmp_inf_cairn_wraiths,wh_main_vmp_veh_black_coach,wh_main_vmp_cav_black_knights_3,wh_main_vmp_cav_black_knights_3,wh_main_vmp_cav_black_knights_3,wh_dlc02_vmp_cav_blood_knights_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_skeleton_warriors_1,wh_main_vmp_inf_cairn_wraiths",
			"wh_main_carcassone_et_brionne_castle_carcassonne",
			460,
			320,
			true,
			function(cqi)
				cm:apply_effect_bundle_to_characters_force("wh2_main_sr_fervour", cqi, 25, true)
			end
		)

		local brionne_region = cm:get_region("wh_main_carcassone_et_brionne_brionne")
		local human_players = cm:get_human_factions()

		if brionne_region:owning_faction():name() == human_players[1] then
			cm:force_declare_war("wh_main_vmp_vampire_counts", human_players[1], true, true)
		else
			cm:transfer_region_to_faction("wh_main_carcassone_et_brionne_brionne", "wh_main_vmp_vampire_counts")
		end
	end
end

function announce_spawna()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event_located(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadspawn_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadspawn_secondary_detail",
			710,
			170,
			true,
			594
		)
	end
end

function announce_spawnb()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event_located(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadspawn_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadspawn_secondary_detail",
			460,
			320,
			true,
			594
		)
	end
end

function announce_spawnl()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event_located(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadspawn_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadspawn_secondary_detail",
			40,
			100,
			true,
			594
		)
	end
end

function announce_spawnn()
	local human_factions = cm:get_human_factions()

	for i = 1, #human_factions do
		cm:show_message_event_located(
			human_factions[i],
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadspawn_primary_detail",
			"",
			"event_feed_strings_text_wh_event_feed_string_scripted_event_undeadspawn_secondary_detail",
			295,
			670,
			true,
			594
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
	local deadawaken = ovn:add_tweaker("deadawaken", "The Dead Rise", "")
	deadawaken:add_option("enable", "Enable", "")
	deadawaken:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_deadawaken_value") == "enable" then
				sr_deadawaken()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_deadawaken_value") == "enable" then sr_deadawaken() end
	end
)