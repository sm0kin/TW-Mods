function sm0_chaos()
	core:add_listener(
		"sm0_rank_up_chaos_units_listener",
		"CharacterCreated",
		function(context)
			local human_factions = cm:get_human_factions()
			return not context:character():faction():is_human() and cm:get_faction(human_factions[1]):subculture() ~= "wh_main_sc_chs_chaos"
			and (cm:is_multiplayer() and cm:get_faction(human_factions[2]):subculture() ~= "wh_main_sc_chs_chaos")
		end,
		function(context)
			local current_character_cqi = context:character():command_queue_index()
			local current_character_faction = context:character():faction():name()
			if current_character_faction == "wh2_main_chs_chaos_incursion_def"
			or current_character_faction == "wh2_main_chs_chaos_incursion_hef"
			or current_character_faction == "wh2_main_chs_chaos_incursion_lzd"
			or current_character_faction == "wh_dlc03_bst_beastmen_chaos"
			or current_character_faction == "wh_dlc03_bst_beastmen_chaos_brayherd"
			or current_character_faction == "wh2_main_chs_chaos_incursion_skv"
			or current_character_faction == "wh_dlc08_chs_chaos_challenger_khorne"
			or current_character_faction == "wh_dlc08_chs_chaos_challenger_nurgle"
			or current_character_faction == "wh_dlc08_chs_chaos_challenger_slaanesh"
			or current_character_faction == "wh_dlc08_chs_chaos_challenger_tzeentch"
			or current_character_faction == "wh_main_chs_chaos"
			or current_character_faction == "wh_main_nor_bjornling" then
				cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(current_character_cqi), 9)
			end
			if not context:character():faction():has_effect_bundle("sm0_custom_chaos_bundle") then
				local custom_chaos_bundle = cm:create_new_custom_effect_bundle("sm0_custom_chaos_bundle")
				custom_chaos_bundle:add_effect("wh_main_effect_technology_research_points", "faction_to_faction_own_unseen", 10000)
				cm:apply_custom_effect_bundle_to_faction(custom_chaos_bundle, context:character():faction())
			end
		end,
		true
	)
end