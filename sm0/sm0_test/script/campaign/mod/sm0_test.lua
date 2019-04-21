--v function()
function expCheat()
	local playerFaction = cm:get_faction(cm:get_local_faction(true));
    local characterList = playerFaction:character_list();
    for i = 0, characterList:num_items() - 1 do
        local currentChar = characterList:item_at(i);	
        local cqi = currentChar:command_queue_index();
        cm:add_agent_experience(cm:char_lookup_str(cqi), 70000);
    end
end

--v function()
function unitCheat()
	local TKunitstring = {"wh2_dlc09_tmb_inf_tomb_guard_1",
						"wh2_dlc09_tmb_inf_tomb_guard_1",
						"wh2_dlc09_tmb_inf_tomb_guard_1",
						"wh2_dlc09_tmb_inf_tomb_guard_1",
						"wh2_dlc09_tmb_inf_tomb_guard_1",
						"wh2_dlc09_tmb_inf_tomb_guard_1",
						"wh2_dlc09_tmb_inf_tomb_guard_1",
						"wh2_dlc09_tmb_inf_tomb_guard_1",
						"wh2_dlc09_tmb_inf_tomb_guard_1",
						"wh2_dlc09_tmb_inf_tomb_guard_1",
						"wh2_dlc09_tmb_veh_khemrian_warsphinx_0",
						"wh2_dlc09_tmb_veh_khemrian_warsphinx_0",
						"wh2_dlc09_tmb_mon_necrosphinx_0",
						"wh2_dlc09_tmb_mon_necrosphinx_0",
						"wh2_pro06_tmb_mon_bone_giant_0",
						"wh2_pro06_tmb_mon_bone_giant_0",
						"wh2_pro06_tmb_mon_bone_giant_0",
						"wh2_pro06_tmb_mon_bone_giant_0",
						"wh2_pro06_tmb_mon_bone_giant_0"} --:vector<string>
	local DEFunitstring = {"wh2_main_def_inf_black_guard_0",
						"wh2_main_def_inf_black_guard_0",
						"wh2_main_def_inf_black_guard_0",
						"wh2_main_def_inf_black_guard_0",
						"wh2_main_def_inf_black_guard_0",
						"wh2_main_def_inf_black_guard_0",
						"wh2_main_def_inf_black_guard_0",
						"wh2_main_def_inf_black_guard_0",
						"wh2_main_def_inf_black_guard_0",
						"wh2_main_def_mon_black_dragon",
						"wh2_main_def_mon_black_dragon",
						"wh2_main_def_mon_black_dragon",
						"wh2_main_def_mon_black_dragon",
						"wh2_main_def_mon_black_dragon",
						"wh2_main_def_mon_black_dragon",
						"wh2_main_def_mon_black_dragon",
						"wh2_main_def_mon_black_dragon",
						"wh2_main_def_mon_black_dragon",
						"wh2_main_def_mon_black_dragon"} --:vector<string>
	local VMPunitstring = {"wh_main_vmp_inf_grave_guard_0",
						"wh_main_vmp_inf_grave_guard_0",
						"wh_main_vmp_inf_grave_guard_0",
						"wh_main_vmp_inf_grave_guard_0",
						"wh_main_vmp_inf_grave_guard_0",
						"wh_main_vmp_inf_grave_guard_0",
						"wh_main_vmp_inf_grave_guard_0",
						"wh_main_vmp_inf_grave_guard_0",
						"wh_main_vmp_inf_grave_guard_0",
						"wh_main_vmp_mon_terrorgheist",
						"wh_main_vmp_mon_terrorgheist",
						"wh_main_vmp_mon_terrorgheist",
						"wh_main_vmp_mon_terrorgheist",
						"wh_main_vmp_mon_terrorgheist",
						"wh_main_vmp_mon_terrorgheist",
						"wh_main_vmp_mon_terrorgheist",
						"wh_main_vmp_mon_terrorgheist",
						"wh_main_vmp_mon_terrorgheist",
						"wh_main_vmp_mon_terrorgheist"} --:vector<string>
						
	local playerFaction = cm:get_faction(cm:get_local_faction(true));
	if playerFaction:name() == "wh2_dlc09_tmb_khemri" then
		local characterList = playerFaction:character_list();
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i);	
			if currentChar:character_subtype("wh2_dlc09_tmb_settra") then
				cm:remove_all_units_from_general(currentChar);
				out("sm0/test bestanden")
				local cqi = currentChar:command_queue_index();
				for k, v in pairs(TKunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v);
				end
			end
		end
	elseif playerFaction:name() == "wh2_dlc09_tmb_followers_of_nagash" then
		local characterList = playerFaction:character_list();
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i);	
			if currentChar:character_subtype("wh2_dlc09_tmb_arkhan") then
				cm:remove_all_units_from_general(currentChar);
				out("sm0/test bestanden")
				local cqi = currentChar:command_queue_index();
				for k, v in pairs(TKunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v);
				end
			end
		end
	elseif playerFaction:name() == "wh2_dlc09_tmb_lybaras" then
		local characterList = playerFaction:character_list();
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i);	
			if currentChar:character_subtype("wh2_dlc09_tmb_khalida") then
				cm:remove_all_units_from_general(currentChar);
				out("sm0/test bestanden")
				local cqi = currentChar:command_queue_index();
				for k, v in pairs(TKunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v);
				end
			end
		end
	elseif playerFaction:name() == "wh2_main_def_naggarond" then
		local characterList = playerFaction:character_list();
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i);	
			if currentChar:character_subtype("wh2_main_def_malekith") then
				cm:remove_all_units_from_general(currentChar);
				out("sm0/test bestanden")
				local cqi = currentChar:command_queue_index();
				for k, v in pairs(DEFunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v);
				end
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true);
			end
		end
	elseif playerFaction:name() == "wh2_main_def_cult_of_pleasure" then
		local characterList = playerFaction:character_list();
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i);	
			if currentChar:character_subtype("wh2_main_def_morathi") then
				cm:remove_all_units_from_general(currentChar);
				out("sm0/test bestanden")
				local cqi = currentChar:command_queue_index();
				for k, v in pairs(DEFunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v);
				end
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true);
			end
		end
	elseif playerFaction:name() == "wh_main_vmp_vampire_counts" then
		local characterList = playerFaction:character_list();
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i);	
			if currentChar:character_subtype("vmp_mannfred_von_carstein") then
				cm:remove_all_units_from_general(currentChar);
				out("sm0/test bestanden")
				local cqi = currentChar:command_queue_index();
				for k, v in pairs(VMPunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v);
				end
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true);
			end
		end
	end
end

-- init
--v function()
function sm0_test()
	expCheat();
	unitCheat();
	--cm:win_next_autoresolve_battle(cm:get_local_faction());
end