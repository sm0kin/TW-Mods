function sm0_chaos()
	core:add_listener(
		"sm0_rank_up_chaos_units_listener",
		"CharacterCreated",
		function(context)
			return true
		end,
		function(context)
			local current_character = context:character()
			local current_character_cqi = context:character():command_queue_index()
			local current_character_faction = context:character():faction():name()
			local character_type = context:character():character_subtype_key()
			if (current_character_faction == "wh2_main_chs_chaos_incursion_def"
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
			or current_character_faction == "wh_main_nor_bjornling")
			and not cm:get_faction("wh_main_chs_chaos"):is_human() and not current_character_faction:is_human() then
				cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(current_character_cqi), 9)
			end
		end,
		true
	)
end