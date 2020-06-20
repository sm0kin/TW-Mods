function sm0_chaos()
	core:add_listener(
		"sm0_rank_up_chaos_units",
		"CharacterCreated",
		function(context)
			local human_factions = cm:get_human_factions()
			return not context:character():faction():is_human() and cm:get_faction(human_factions[1]):subculture() ~= "wh_main_sc_chs_chaos"
			and not (cm:is_multiplayer() and cm:get_faction(human_factions[2]):subculture() == "wh_main_sc_chs_chaos")
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
				if context:character():character_subtype("chs_kholek_suneater") or context:character():character_subtype("chs_prince_sigvald")
				or context:character():character_subtype("chs_archaon") or context:character():character_subtype("chs_lord_of_change") then
					cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(current_character_cqi), 9)
					out("sm0/add_experience_to_units_commanded_by_character_9/faction: "..current_character_faction.."/cqi: "..current_character_cqi)
				else
					cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(current_character_cqi), 3) -- actually 6, this gets applied twice for some reason (maybe because of the >20 armies)
					out("sm0/add_experience_to_units_commanded_by_character_3/faction: "..current_character_faction.."/cqi: "..current_character_cqi)
				end
				if not context:character():faction():has_effect_bundle("sm0_custom_chaos_bundle") then
					local custom_chaos_bundle = cm:create_new_custom_effect_bundle("sm0_custom_chaos_bundle")
					custom_chaos_bundle:add_effect("wh_main_effect_technology_research_points", "faction_to_faction_own_unseen", 10000)
					cm:apply_custom_effect_bundle_to_faction(custom_chaos_bundle, context:character():faction())
					out("sm0/apply_custom_effect_bundle_to_faction/faction: "..current_character_faction)
				end
			end
		end,
		true
	)
	core:add_listener(
		"sm0_replace_kholek_units",
		"CharacterCreated",
		function(context)
			local human_factions = cm:get_human_factions()
			return cm:model():turn_number() >= 2 and not context:character():faction():is_human() and cm:get_faction(human_factions[1]):subculture() ~= "wh_main_sc_chs_chaos"
			and not (cm:is_multiplayer() and cm:get_faction(human_factions[2]):subculture() == "wh_main_sc_chs_chaos")
		end,
		function(context)
			--cm:callback(function() 
				local ram = random_army_manager
				local character = context:character()
				if character and character:character_subtype("chs_kholek_suneater") and not cm:get_saved_value("sm0_chaos_buffs_chs_kholek_suneater") 
				and character:has_military_force() and not character:military_force():unit_list():is_empty() then
					local army_size = character:military_force():unit_list():num_items()		
					ram:new_force("kholek")
					ram:add_mandatory_unit("kholek", "wh_main_chs_art_hellcannon",					1)	--2
					ram:add_unit("kholek", "wh_main_chs_art_hellcannon",							1)
					ram:add_mandatory_unit("kholek", "wh_dlc01_chs_mon_dragon_ogre_shaggoth",		4)	--7
					ram:add_unit("kholek", "wh_dlc01_chs_mon_dragon_ogre_shaggoth",					3)
					ram:add_mandatory_unit("kholek", "wh_pro04_chs_mon_dragon_ogre_ror_0",			1)	--1
					ram:add_mandatory_unit("kholek", "wh_dlc01_chs_mon_dragon_ogre",				5)	--8
					ram:add_unit("kholek", "wh_dlc01_chs_mon_dragon_ogre",							3)
					ram:add_mandatory_unit("kholek", "wh_dlc01_chs_inf_forsaken_0",					7)	--14
					ram:add_unit("kholek", "wh_dlc01_chs_inf_forsaken_0",							7)
					ram:add_mandatory_unit("kholek", "wh_pro04_chs_inf_forsaken_ror_0",				1)	--1
					ram:add_mandatory_unit("kholek", "wh_dlc06_chs_feral_manticore",				2)	--2
					ram:add_mandatory_unit("kholek", "wh_main_chs_mon_chaos_warhounds_1",			2)	--4
					ram:add_unit("kholek", "wh_main_chs_mon_chaos_warhounds_1",						2)
					local unit_string = ram:generate_force("kholek", army_size, false, true)
					cm:remove_all_units_from_general(character)
					cm:grant_unit_to_character(cm:char_lookup_str(character:command_queue_index()), unit_string)
					cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character:command_queue_index()), 9)
					cm:set_saved_value("sm0_chaos_buffs_chs_kholek_suneater", true)
				elseif character and character:character_subtype("chs_prince_sigvald") and not cm:get_saved_value("sm0_chaos_buffs_chs_prince_sigvald") 
				and character:has_military_force() and not character:military_force():unit_list():is_empty() then
					local army_size = character:military_force():unit_list():num_items()		
					ram:new_force("sigvald")
					ram:add_mandatory_unit("sigvald", "wh_main_chs_art_hellcannon",					1)	--2
					ram:add_unit("sigvald", "wh_main_chs_art_hellcannon",							1)
					ram:add_mandatory_unit("sigvald", "wh_pro04_chs_art_hellcannon_ror_0",			1)	--1
					ram:add_mandatory_unit("sigvald", "wh_main_chs_inf_chosen_1",					5)	--10
					ram:add_unit("sigvald", "wh_main_chs_inf_chosen_1",								5)	
					ram:add_mandatory_unit("sigvald", "wh_main_chs_cav_chaos_knights_1",			3)	--6
					ram:add_unit("sigvald", "wh_main_chs_cav_chaos_knights_1",						3)
					ram:add_mandatory_unit("sigvald", "wh_dlc06_chs_inf_aspiring_champions_0",		3)	--6
					ram:add_unit("sigvald", "wh_dlc06_chs_inf_aspiring_champions_0",				3)
					ram:add_mandatory_unit("sigvald", "wh_dlc01_chs_inf_chosen_2",					2)	--4
					ram:add_unit("sigvald", "wh_dlc01_chs_inf_chosen_2",							2)
					ram:add_mandatory_unit("sigvald", "wh_dlc01_chs_mon_trolls_1",					3)	--5
					ram:add_unit("sigvald", "wh_dlc01_chs_mon_trolls_1",							2)
					ram:add_mandatory_unit("sigvald", "wh_main_chs_mon_giant",						2)	--4
					ram:add_unit("sigvald", "wh_main_chs_mon_giant",								2)
					ram:add_mandatory_unit("sigvald", "wh_pro04_chs_inf_chaos_warriors_ror_0",		1)	--1
					local unit_string = ram:generate_force("sigvald", army_size, false, true)
					cm:remove_all_units_from_general(character)
					cm:grant_unit_to_character(cm:char_lookup_str(character:command_queue_index()), unit_string)
					cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character:command_queue_index()), 9)
					cm:set_saved_value("sm0_chaos_buffs_chs_prince_sigvald", true)
				elseif character and character:character_subtype("chs_archaon") and not cm:get_saved_value("sm0_chaos_buffs_chs_archaon") 
				and character:has_military_force() and not character:military_force():unit_list():is_empty() then
					local army_size = character:military_force():unit_list():num_items()		
					ram:new_force("archaon")
					ram:add_mandatory_unit("archaon", "wh_main_chs_art_hellcannon",					1)	--2
					ram:add_unit("archaon", "wh_main_chs_art_hellcannon",							1)
					ram:add_mandatory_unit("archaon", "wh_main_chs_inf_chosen_0",					3)	--6
					ram:add_unit("archaon", "wh_main_chs_inf_chosen_0",								3)
					ram:add_mandatory_unit("archaon", "wh_main_chs_inf_chosen_1",					3)	--6
					ram:add_unit("archaon", "wh_main_chs_inf_chosen_1",								3)
					ram:add_mandatory_unit("archaon", "wh_dlc01_chs_inf_chosen_2",					1)	--2
					ram:add_unit("archaon", "wh_dlc01_chs_inf_chosen_2",							1)
					ram:add_mandatory_unit("archaon", "wh_dlc01_chs_cav_gorebeast_chariot",			2)	--2	
					ram:add_mandatory_unit("archaon", "wh_main_chs_cav_chaos_knights_1",			3)	--6
					ram:add_unit("archaon", "wh_main_chs_cav_chaos_knights_1",						3)
					ram:add_mandatory_unit("archaon", "wh_pro04_chs_cav_chaos_knights_ror_0",		1)	--1
					ram:add_mandatory_unit("archaon", "wh_main_chs_cav_marauder_horsemen_1",		2)	--4
					ram:add_unit("archaon", "wh_main_chs_cav_marauder_horsemen_1",					2)
					ram:add_mandatory_unit("archaon", "wh_main_chs_mon_chaos_spawn",				2)	--3
					ram:add_unit("archaon", "wh_main_chs_mon_chaos_spawn",							1)
					ram:add_mandatory_unit("archaon", "wh_pro04_chs_mon_chaos_spawn_ror_0",			1)	--1
					ram:add_mandatory_unit("archaon", "wh_main_chs_mon_chaos_warhounds_1",			2)	--2
					--ram:add_unit("archaon", "wh_main_chs_mon_chaos_warhounds_1",					2)
					ram:add_mandatory_unit("archaon", "wh_dlc06_chs_feral_manticore",				1)	--2
					ram:add_unit("archaon", "wh_dlc06_chs_feral_manticore",							1)
					ram:add_mandatory_unit("archaon", "wh_main_chs_mon_giant",						1)	--2
					ram:add_unit("archaon", "wh_main_chs_mon_giant",								1)
					local unit_string = ram:generate_force("archaon", army_size, false, true)
					cm:remove_all_units_from_general(character)
					cm:grant_unit_to_character(cm:char_lookup_str(character:command_queue_index()), unit_string)					
					cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character:command_queue_index()), 9)
					cm:set_saved_value("sm0_chaos_buffs_chs_archaon", true)
				elseif character and character:character_subtype("chs_lord_of_change") and not cm:get_saved_value("sm0_chaos_buffs_chs_lord_of_change") 
				and character:has_military_force() and not character:military_force():unit_list():is_empty() then
					local army_size = character:military_force():unit_list():num_items()		
					ram:new_force("bird")
					ram:add_mandatory_unit("bird", "wh_main_chs_art_hellcannon",					1)	--2
					ram:add_unit("bird", "wh_main_chs_art_hellcannon",								1)
					ram:add_mandatory_unit("bird", "wh_main_chs_inf_chosen_0",						3)	--6
					ram:add_unit("bird", "wh_main_chs_inf_chosen_0",								3)
					ram:add_mandatory_unit("bird", "wh_main_chs_inf_chosen_1",						3)	--6	
					ram:add_unit("bird", "wh_main_chs_inf_chosen_1",								3)
					ram:add_mandatory_unit("bird", "wh_main_chs_cav_chaos_knights_1",				3)	--6
					ram:add_unit("bird", "wh_main_chs_cav_chaos_knights_1",							3)
					ram:add_mandatory_unit("bird", "wh_main_chs_mon_chaos_spawn",					3)	--6
					ram:add_unit("bird", "wh_main_chs_mon_chaos_spawn",								3)
					ram:add_mandatory_unit("bird", "wh_dlc01_chs_inf_chosen_2",						2)	--4
					ram:add_unit("bird", "wh_dlc01_chs_inf_chosen_2",								2)
					ram:add_mandatory_unit("bird", "wh_dlc01_chs_cav_gorebeast_chariot",			3)	--5
					ram:add_unit("bird", "wh_dlc01_chs_cav_gorebeast_chariot",						2)
					ram:add_mandatory_unit("bird", "wh_main_chs_cav_marauder_horsemen_1",			2)	--4
					ram:add_unit("bird", "wh_main_chs_cav_marauder_horsemen_1",						2)
					local unit_string = ram:generate_force("bird", army_size, false, true)
					cm:remove_all_units_from_general(character)
					cm:grant_unit_to_character(cm:char_lookup_str(character:command_queue_index()), unit_string)					
					cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character:command_queue_index()), 9)
					cm:set_saved_value("sm0_chaos_buffs_chs_lord_of_change", true)
				end   
            --end, 1)
		end,
		true
	)
end

--- @function 
--- @desc This generates a force randomly, first taking into account the mandatory unit and then making random selection of units based on weighting. Returns an array of unit keys or a comma separated string for use in the create_force function if the last boolean value is passed as true
--- @p string key of the force
--- @p number amount of units
--- @p boolean pass true to return the force as a table, false to get a comma separated string
--- @return object Either a table containing the unit keys, or a comma separated string of units
function random_army_manager:generate_force(force_key, unit_count, return_as_table, no_limit)
	local force = {};
	local faction = "";
	
	if is_table(unit_count) then
		unit_count = cm:random_number(math.max(unit_count[1], unit_count[2]), math.min(unit_count[1], unit_count[2]));
	end;

	if not no_limit then
		unit_count = math.min(19, unit_count);
	end
	
	out.design("Random Army Manager: Getting Random Force for army [" .. force_key .. "] with size [" .. unit_count .. "]");
	
	for i = 1, #self.force_list do
		if force_key == self.force_list[i].key then			
			local mandatory_units_added = 0;
			
			for j = 1, #self.force_list[i].mandatory_units do
				table.insert(force, self.force_list[i].mandatory_units[j]);
				mandatory_units_added = mandatory_units_added + 1;
			end
			
			for k = 1, unit_count - mandatory_units_added do
				local unit_index = cm:random_number(#self.force_list[i].units);
				table.insert(force, self.force_list[i].units[unit_index]);
			end

			faction = self.force_list[i].faction;
		end
	end
	
	if #force == 0 then
		script_error("Random Army Manager: Did not add any units to force with force_key [" .. force_key .. "] - was the force created?");
		return false;
	elseif return_as_table then
		return force, faction;
	else
		return table.concat(force, ","), faction;
	end
end