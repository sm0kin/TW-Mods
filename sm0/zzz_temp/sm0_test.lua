--v function()
local function sm0_log_reset()
	if not __write_output_to_logfile then
		--return
	end
	local logTimeStamp = os.date("%d, %m %Y %X")
	--# assume logTimeStamp: string
	local popLog = io.open("sm0_log.txt","w+")
	popLog :write("NEW LOG ["..logTimeStamp.."] \n")
	popLog :flush()
	popLog :close()
end

--v function(text: string | number | boolean | CA_CQI)
local function sm0_log(text)
	if not __write_output_to_logfile then
		--return
	end
	local logText = tostring(text)
	local logTimeStamp = os.date("%d, %m %Y %X")
	local popLog = io.open("sm0_log.txt","a")
	--# assume logTimeStamp: string
	popLog :write("TEST:  [".. logTimeStamp .. "] [Turn: ".. tostring(cm:model():turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  "..logText .. "  \n")
	popLog :flush()
	popLog :close()
end

--v function()
local function expCheat()
	local playerFaction = cm:get_local_faction(true)
    local characterList = playerFaction:character_list()
    for i = 0, characterList:num_items() - 1 do
        local currentChar = characterList:item_at(i)	
        local cqi = currentChar:command_queue_index()
		cm:add_agent_experience(cm:char_lookup_str(cqi), 70000) 
		--cm:add_agent_experience(cm:char_lookup_str(cqi), 9940)
		--if currentChar:character_subtype("wh2_main_skv_lord_skrolk") then cm:force_add_ancillary(currentChar, "wh2_main_anc_arcane_item_the_liber_bubonicus", true, false) end
		if currentChar:character_subtype("dwf_thorgrim_grudgebearer") then cm:force_add_ancillary(currentChar, "wh2_dlc10_dwf_anc_enchanted_item_horn_of_the_ancestors", true, false) end
		if currentChar:character_subtype("wh2_dlc10_hef_alarielle") then cm:force_add_ancillary(currentChar, "wh_main_anc_enchanted_item_ruby_ring_of_ruin", true, false) end
		--if currentChar:character_subtype("wh2_dlc17_dwf_thorek") then 
			--cm:force_add_ancillary(currentChar, "wh_main_anc_rune_master_rune_of_groth_one", true, false) 
			--cm:force_add_ancillary(currentChar, "wh_main_anc_rune_master_rune_of_grungni", true, false)
		--end
		--if currentChar:character_subtype("wh2_dlc11_cst_harkon") then 
		--	local mf = currentChar:military_force()
		--	local faction = currentChar:faction()
		--	cm:spawn_agent_at_military_force(faction, mf, "dignitary", "wh2_dlc11_cst_fleet_captain_deep")
		--	cm:spawn_agent_at_military_force(faction, mf, "dignitary", "wh2_dlc11_cst_fleet_captain_death")
		--	cm:spawn_agent_at_military_force(faction, mf, "dignitary", "wh2_dlc11_cst_fleet_captain")
		--end
	end
	if cm:is_new_game() then
		local factionList = cm:model():world():faction_list()
		for i = 0, factionList:num_items() - 1 do
			local faction = factionList:item_at(i)
			local characterList = faction:character_list()
			for i = 0, characterList:num_items() - 1 do
				local currentChar = characterList:item_at(i)	
				local cqi = currentChar:command_queue_index()
				cm:add_agent_experience(cm:char_lookup_str(cqi), 70000)
				--cm:add_agent_experience(cm:char_lookup_str(cqi), 70000)
			end
		end
	end
end
--out

--v function()
local function unitCheat()
	local NORSCAunitstring = {"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1",
						"wh_dlc08_nor_mon_war_mammoth_1"} --:vector<string>
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
	local LZDunitstring = {"wh2_dlc13_lzd_mon_sacred_kroxigors_0_nakai",
						"wh2_dlc13_lzd_mon_sacred_kroxigors_0_nakai",
						"wh2_dlc13_lzd_mon_sacred_kroxigors_0_nakai",
						"wh2_dlc13_lzd_mon_sacred_kroxigors_0_nakai",
						"wh2_dlc13_lzd_mon_sacred_kroxigors_0_nakai",
						"wh2_main_lzd_mon_kroxigors",
						"wh2_main_lzd_mon_kroxigors",
						"wh2_main_lzd_mon_kroxigors",
						"wh2_main_lzd_mon_kroxigors",
						"wh2_main_lzd_mon_kroxigors",
						"wh2_main_lzd_mon_kroxigors_nakai",
						"wh2_main_lzd_mon_kroxigors_nakai",
						"wh2_main_lzd_mon_kroxigors_nakai",
						"wh2_main_lzd_mon_kroxigors_nakai",
						"wh2_main_lzd_mon_kroxigors_nakai",
						"wh2_dlc13_lzd_mon_sacred_kroxigors_0",
						"wh2_dlc13_lzd_mon_sacred_kroxigors_0",
						"wh2_dlc13_lzd_mon_sacred_kroxigors_0",
						"wh2_dlc13_lzd_mon_sacred_kroxigors_0"} --:vector<string>
	local GRNunitstring = {"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0",
						"wh2_dlc15_grn_mon_rogue_idol_0"} --:vector<string>					
						
	local playerFaction = cm:get_local_faction(true)
	if playerFaction:subculture() == "wh_main_sc_nor_norsca" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:is_faction_leader() then
				cm:remove_all_units_from_general(currentChar)
				--sm0_log("remove_all_units_from_general/wh2_dlc09_tmb_settra")
				local cqi = currentChar:command_queue_index()
				--cm:grant_unit_to_character(cm:char_lookup_str(cqi), "wh2_dlc12_skv_veh_doom_flayer_ror_tech_lab_0")
				for k, v in pairs(NORSCAunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v)
				end
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true)
			end
		end
	elseif playerFaction:subculture() == "wh2_main_sc_skv_skaven" then
		cm:spawn_agent_at_settlement(playerFaction, playerFaction:home_region():settlement(), "wizard", "wh2_main_skv_plague_priest")
		cm:spawn_agent_at_settlement(cm:get_local_faction(true), playerFaction:home_region():settlement(), "spy", "wh2_main_skv_assassin")
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:is_faction_leader() then
				--cm:remove_all_units_from_general(currentChar)
				--sm0_log("remove_all_units_from_general/wh2_dlc09_tmb_settra")
				local cqi = currentChar:command_queue_index()
				cm:grant_unit_to_character(cm:char_lookup_str(cqi), "wh2_dlc12_skv_veh_doom_flayer_ror_tech_lab_0")
				--for k, v in pairs(TKunitstring) do 
				--	cm:grant_unit_to_character(cm:char_lookup_str(cqi), v)
				--end
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true)
			end
		end
		local spawn_x = playerFaction:home_region():settlement():logical_position_x()
		local spawn_y = playerFaction:home_region():settlement():logical_position_y()
		--cm:create_force(
		--	"wh_main_chs_chaos",
		--	"wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0",
		--	playerFaction:home_region():name(),
		--	spawn_x - 5,
		--	spawn_y - 17,
		--	true,
		--	function(cqi)
		--	end
		--)
	elseif playerFaction:subculture() == "wh_main_sc_grn_greenskins" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:character_subtype("dlc06_grn_skarsnik") or currentChar:is_faction_leader() then
				--cm:remove_all_units_from_general(currentChar)
				sm0_log("remove_all_units_from_general/dlc06_grn_skarsnik")
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(GRNunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), "wh2_dlc15_grn_mon_rogue_idol_0")
				end

			end
		end	
	elseif playerFaction:subculture() == "wh2_main_sc_hef_high_elves" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:is_faction_leader() then
				--cm:remove_all_units_from_general(currentChar)
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(GRNunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), "wh2_main_hef_mon_star_dragon")
				end
			end
		end	
	elseif playerFaction:subculture() == "wh_main_sc_dwf_dwarfs" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if --[[currentChar:character_subtype("dlc06_grn_skarsnik") or]] currentChar:is_faction_leader() then
				--cm:remove_all_units_from_general(currentChar)
				sm0_log("remove_all_units_from_general/is_faction_leader")
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(GRNunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), "wh_main_dwf_inf_ironbreakers") --wh_main_dwf_inf_ironbreakers
				end

			end
		end	
	elseif playerFaction:name() == "wh2_dlc09_tmb_khemri" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:character_subtype("wh2_dlc09_tmb_settra") then
				cm:remove_all_units_from_general(currentChar)
				sm0_log("remove_all_units_from_general/wh2_dlc09_tmb_settra")
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(TKunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v)
				end

			end
		end
	elseif playerFaction:name() == "wh2_dlc09_tmb_followers_of_nagash" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:character_subtype("wh2_dlc09_tmb_arkhan") then
				cm:remove_all_units_from_general(currentChar)
				sm0_log("remove_all_units_from_general/wh2_dlc09_tmb_arkhan")
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(TKunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v)
				end
			end
		end
	elseif playerFaction:name() == "wh2_dlc09_tmb_lybaras" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:character_subtype("wh2_dlc09_tmb_khalida") then
				cm:remove_all_units_from_general(currentChar)
				sm0_log("remove_all_units_from_general/wh2_dlc09_tmb_khalida")
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(TKunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v)
				end
			end
		end
	elseif playerFaction:name() == "wh2_main_def_naggarond" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:character_subtype("wh2_main_def_malekith") then
				cm:remove_all_units_from_general(currentChar)
				sm0_log("remove_all_units_from_general/wh2_main_def_malekith")
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(DEFunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v)
				end
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true)
			end
		end
	elseif playerFaction:name() == "wh2_main_def_cult_of_pleasure" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:character_subtype("wh2_main_def_morathi") then
				cm:remove_all_units_from_general(currentChar)
				sm0_log("remove_all_units_from_general/wh2_main_def_morathi")
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(DEFunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v)
				end
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true)
			end
		end
	elseif playerFaction:name() == "wh_main_vmp_vampire_counts" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:character_subtype("vmp_mannfred_von_carstein") then
				cm:remove_all_units_from_general(currentChar)
				sm0_log("remove_all_units_from_general/vmp_mannfred_von_carstein")
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(VMPunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v)
				end
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true)
			end
		end
	elseif playerFaction:name() == "wh_main_vmp_schwartzhafen" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:character_subtype("dlc04_vmp_vlad_con_carstein") then
				cm:remove_all_units_from_general(currentChar)
				sm0_log("remove_all_units_from_general/dlc04_vmp_vlad_con_carstein")
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(VMPunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v)
				end
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true)
			end
		end
	elseif playerFaction:subculture() == "wh2_main_sc_lzd_lizardmen" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:is_faction_leader() then
				cm:remove_all_units_from_general(currentChar)
				sm0_log("remove_all_units_from_general/wh2_dlc12_lzd_tehenhauin")
				local cqi = currentChar:command_queue_index()
				for k, v in pairs(LZDunitstring) do 
					cm:grant_unit_to_character(cm:char_lookup_str(cqi), v)
				end
				cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, 0, true)
			end
		end
	end
end

--v function()
local function deletePlayerSubcultureFactions()
	if cm:model():turn_number() == 1 and cm:get_local_faction_name(true) ~= "wh2_main_hef_avelorn" then cm:force_confederation("wh2_main_hef_caledor", "wh2_main_hef_avelorn") end
	local playerFaction = cm:get_local_faction(true)
	local factionList2 = playerFaction:factions_of_same_subculture()
	for i = 0, factionList2:num_items() - 1 do
		local faction = factionList2:item_at(i)
		if faction and not faction:is_dead() and not faction:is_human() and cm:model():turn_number() == 2 then
			--cm:force_confederation(playerFaction:name(), faction:name())	
		end
		if faction and not faction:is_dead() and not faction:is_human() and cm:model():turn_number() == 3 then
			if faction:name() == "wh_main_teb_tilea" or faction:name() == "wh2_dlc09_tmb_followers_of_nagash" or faction:name() == "wh2_dlc11_cst_noctilus" or faction:name() == "wh_main_grn_greenskins" 	
			--or faction:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" 
			or ((--faction:name() == "wh2_main_hef_caledor" or 
			faction:name() == "wh2_dlc11_cst_vampire_coast" or faction:name() == "wh_main_emp_middenland" 
			or faction:name() == "wh_main_emp_marienburg" or faction:name() == "wh2_main_hef_avelorn" or faction:name() == "wh_main_brt_lyonesse") and cm:model():turn_number() <= 3) then
				--if playerFaction:subculture() == faction:subculture() and cm:model():turn_number() == 2 then cm:force_confederation(cm:get_local_faction_name(true), faction:name()) end
			else
				if cm:random_number(1, 1) == 1 then
				--local regionList = faction:region_list()
				--for i = 0, regionList:num_items() - 1 do
				--	local currentRegion = regionList:item_at(i)
				--	cm:set_region_abandoned(currentRegion:name())
				--end
				--cm:kill_all_armies_for_faction(faction)
				--if cm:random_number(3, 1) == 1 then 
					kill_faction(faction:name()) 
				--end
				--local charList = faction:character_list()
				--for i = 0, charList:num_items() - 1 do
				--	local currentChar = charList:item_at(i)
				--	if currentChar and not currentChar:is_null_interface() then 
				--		--sm0_log("kill_character/character_type = "..currentChar:character_type_key()) 
				--	end
				--	--if not currentChar:character_type("colonel") then cm:kill_character(currentChar:command_queue_index(), true, false) end
				--	cm:kill_character(currentChar:command_queue_index(), true, false)
				--end
				end
			end
		end
	end
	local factionList = cm:model():world():faction_list()
	for i = 0, factionList:num_items() - 1 do
		local faction = factionList:item_at(i)
		if faction and not faction:is_dead() and not faction:is_human() then
			if faction:name() == "wh_main_teb_tilea" or faction:name() == "wh2_dlc09_tmb_followers_of_nagash" or faction:name() == "wh2_dlc11_cst_noctilus" or faction:name() == "wh_main_grn_greenskins" 	
			or faction:subculture() == playerFaction:subculture()--or faction:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" 
			or ((faction:name() == "wh2_main_hef_caledor" or faction:name() == "wh2_dlc11_cst_vampire_coast"
			or faction:name() == "wh_main_emp_marienburg" or faction:name() == "wh2_main_hef_avelorn" or faction:name() == "wh_main_brt_lyonesse") and cm:model():turn_number() <= 3) then
				--if playerFaction:subculture() == faction:subculture() and cm:model():turn_number() == 2 then cm:force_confederation(cm:get_local_faction_name(true), faction:name()) end
			else		
				if cm:random_number(5, 1) == 1 then --playerFaction:subculture() == faction:subculture() 
					--sm0_log("deleted Faction: "..faction:name())
					--local regionList = faction:region_list()
					--for i = 0, regionList:num_items() - 1 do
					--	local currentRegion = regionList:item_at(i)
					--	cm:set_region_abandoned(currentRegion:name())
					--end
					--cm:kill_all_armies_for_faction(faction)
					if not faction:is_dead() then kill_faction(faction:name()) end
					--local charList = faction:character_list()
					--for i = 0, charList:num_items() - 1 do
					--	local currentChar = charList:item_at(i)
					--	if currentChar and not currentChar:is_null_interface() then 
					--		--sm0_log("kill_character/character_type = "..currentChar:character_type_key()) 
					--	end
					--	--if not currentChar:character_type("colonel") then cm:kill_character(currentChar:command_queue_index(), true, false) end
					--	cm:kill_character(currentChar:command_queue_index(), true, false)
					--end
				else
					--sm0_log("No luck deleting Faction: "..faction:name())
				end
			end
		end
	end
end

--v function()
local function spamLords(faction_key, agent_subtype)
	local factionCA = cm:get_faction(faction_key)
	local faction_leader = cm:get_local_faction(true):faction_leader()
    --local x = faction_leader:logical_position_x()
	--local y = faction_leader:logical_position_y()
	--x, y = cm:find_valid_spawn_location_for_character_from_position(factionCA, x, y, true) 
	--local home_region = faction_leader:region()
	--local home_region_key = faction_leader:region():name()
    --if factionCA:has_home_region() then x, y = cm:find_valid_spawn_location_for_character_from_settlement(faction_key, factionCA:home_region():name(), false, false, 9) end
	--if string.find(faction_key, "_bst_") then
	local x = 116
	local y = 546
	local home_region_key = "wh2_main_obsidian_peaks_circle_of_destruction"
	--end
	if not is_string(agent_subtype) then
		cm:create_force(
			faction_key,
			"wh_main_dwf_inf_hammerers",
			home_region_key,
			x,
			y,
			false,
			function(cqi)

			end
		)
	else
		cm:create_force_with_general(
			faction_key,
			"wh_main_dwf_inf_hammerers",
			home_region_key, --factionCA:home_region():name()
			x,
			y,
			"general",
			agent_subtype, --wh2_dlc16_wef_malicious_ancient_treeman_life --wh2_dlc16_wef_malicious_ancient_treeman_beasts --wh2_dlc16_wef_malicious_ancient_treeman_shadows --dlc05_wef_ancient_treeman
			"",
			"",
			"",
			"",
			false,
			function(cqi)

			end
		)	
	end
end

--v function()
local function unlockLords()
    local ai_starting_generals = {
		{["id"] = "2140784160",	["forename"] = "names_name_2147358917",	["faction"] = "wh_main_dwf_dwarfs"},			-- Grombrindal
		{["id"] = "2140783606",	["forename"] = "names_name_2147345906",	["faction"] = "wh_main_grn_greenskins"},		-- Azhag the Slaughterer
		{["id"] = "2140783651",	["forename"] = "names_name_2147345320",	["faction"] = "wh_main_vmp_vampire_counts"},	-- Heinrich Kemmler
		{["id"] = "2140784146",	["forename"] = "names_name_2147358044",	["faction"] = "wh_main_vmp_vampire_counts"},	-- Helman Ghorst
		{["id"] = "2140784202",	["forename"] = "names_name_2147345124",	["faction"] = "wh_main_vmp_schwartzhafen"}		-- Isabella von Carstein
	} --:vector<map<string, string>>
	
	for i = 1, #ai_starting_generals do
		local faction = cm:get_faction(ai_starting_generals[i].faction)
		
		if not faction:is_human() then
			cm:unlock_starting_general_recruitment(ai_starting_generals[i].id, ai_starting_generals[i].faction)
		end
    end
end

function cbf_char_army_has_unit(character, unit)

	-- allow a table of units to be passed in as a parameter
	if type(unit) == "table" then
		if not character:has_military_force() and not character:is_embedded_in_military_force() then
			out("sm0/not character:has_military_force() or not character:is_embedded_in_military_force() = false")
			return false
		end
	
		for i = 1, #unit do
			out("sm0/unit[i] = "..tostring(unit[i]))
			if char_army_has_unit(character, unit[i]) then
				out("sm0/if char_army_has_unit(character, unit[i]) then = true")
				return true
			end
		end
		out("sm0/if type(unit) == \"table\" then = false")
		return false
	end
	
	if character:has_military_force() then
		out("sm0/character:military_force():unit_list():has_unit(unit) = "..tostring(character:military_force():unit_list():has_unit(unit)))
		return character:military_force():unit_list():has_unit(unit)
	elseif character:is_embedded_in_military_force() then
		out("sm0/character:is_embedded_in_military_force() = "..tostring(character:is_embedded_in_military_force()))
		return character:embedded_in_military_force():unit_list():has_unit(unit)
	end
end


-- init
--v function()
function sm0_test()
	if cm:is_new_game() and not cm:get_saved_value("sm0_log_reset") then
		sm0_log_reset()
		cm:set_saved_value("sm0_log_reset", true)
	end	
	local local_faction = cm:get_local_faction(true)
	--local blessed_dread = cm:get_faction("wh2_dlc11_def_the_blessed_dread")
	local leader = local_faction:faction_leader()
	--if char_army_has_unit(leader, "wh2_main_hef_cav_ithilmar_chariot") or char_army_has_unit(leader, "wh2_main_hef_inf_white_lions_of_chrace_0") then
	if char_army_has_unit(leader, {"wh2_main_hef_cav_ithilmar_chariot", "wh2_main_hef_inf_white_lions_of_chrace_0"}) then
		out("sm0/no bug")
	end
	core:add_listener(
		"ms-autoresolve",
		"PanelOpenedCampaign",
		function(context)
			return context.string == "popup_pre_battle" 
		end,
		function(context)
			local ui_root = core:get_ui_root()
			local pb = cm:model():pending_battle()
			local auto_resolve_btn = find_uicomponent(ui_root,"popup_pre_battle", "mid", "regular_deployment","button_set_attack", "button_autoresolve")
			if auto_resolve_btn and cm:pending_battle_cache_is_quest_battle() then 
				auto_resolve_btn:SetDisabled(false)
				auto_resolve_btn:SetOpacity(false,255)
				auto_resolve_btn:SetTooltipText("",false)
			end
		end,
		true
	)
	--local playerFaction = cm:get_local_faction(true)
	--local factionList2 = playerFaction:factions_of_same_subculture()
	--for i = 0, factionList2:num_items() - 1 do
	--	local faction = factionList2:item_at(i)
	--	cm:force_confederation(playerFaction:name(), faction:name())
	--end
	--core:add_listener(
	--	"testtest_CharacterConvalescedOrKilled",
	--	"CharacterConvalescedOrKilled",
	--	function(context)
	--		return true --context:character():character_subtype_key() == "wh2_main_def_black_ark"
	--	end,
	--		function(context)
	--		--cm:callback(function()
	--			local cqi
    --    	    local char_list = local_faction:character_list()
    --    	    for i = 0, char_list:num_items() - 1 do
    --    	        local current_char = char_list:item_at(i)
    --    	        --if current_char:character_subtype("wh2_main_def_black_ark") and current_char:is_wounded() then
    --    	            cqi = current_char:command_queue_index()
	--					cm:stop_character_convalescing(cqi) 
	--					break
    --    	        --end
    --    	    end
	--		--end, 0.1)
	--	end,
	--	true
	--)
	local char_list =  local_faction:character_list()
	for i = 0, char_list:num_items() - 1 do
		local current_char = char_list:item_at(i)
		if current_char:character_subtype("wh2_pro08_neu_gotrek") or current_char:character_subtype("wh2_pro08_neu_felix") then
			--cm:kill_character(current_char:command_queue_index(), false, false)
			cm:stop_character_convalescing(current_char:command_queue_index()) 
		end
	end
--
	--local char_list =  local_faction:character_list()
	--for i = 0, char_list:num_items() - 1 do
	--	local current_char = char_list:item_at(i)
	--	out("sm0/current_char/subtype = "..current_char:character_subtype_key())
	--end
	--local char_list =  blessed_dread:character_list()
	--for i = 0, char_list:num_items() - 1 do
	--	local current_char = char_list:item_at(i)
	--	if current_char:character_subtype("wh2_dlc11_def_lokhir") and current_char:is_wounded() then
	--		cqi = current_char:command_queue_index()
	--		cm:stop_character_convalescing(cqi) 
	--	end
	--end

	--cm:add_building_to_force(lokhir:military_force():command_queue_index(), "wh2_main_horde_def_settlement_5")	

	--respawn_character_with_army(lokhir)

	--local x
	--local y
	--local mf_list = blessed_dread:military_force_list()
	--local admiral
	--for i = 0, mf_list:num_items() - 1 do
	--	local mf = mf_list:item_at(i)
	--	if mf:general_character():character_subtype("wh2_main_def_black_ark") then
	--		cqi = mf:general_character():command_queue_index()
	--		x = mf:general_character():logical_position_x()
	--		y = mf:general_character():logical_position_y()
	--	end
	--end
	--cm:kill_character(cqi, true, false)



	--local karak = cm:get_region("wh_main_the_silver_road_the_pillars_of_grungni")
	--local x, y = cm:find_valid_spawn_location_for_character_from_settlement(cm:get_local_faction_name(true), "wh2_main_obsidian_peaks_clar_karond", false, true, 8)
	--local char_list = local_faction:character_list()
	--for i = 0, char_list:num_items() - 1 do
	--	local current_char = char_list:item_at(i)
	--	local x, y = cm:find_valid_spawn_location_for_character_from_settlement(cm:get_local_faction_name(true), "wh2_main_obsidian_peaks_clar_karond", false, true, 8 + i)
	--	if current_char:character_type("general") then
	--		cm:teleport_to(cm:char_lookup_str(current_char), x + i, y + i, false)
	--		cm:replenish_action_points(cm:char_lookup_str(current_char))
	--	end
	--end
	
	--local factionList = cm:model():world():faction_list()
	--for i = 0, factionList:num_items() - 1 do
	--	local faction = factionList:item_at(i)
	--	if faction and not faction:is_dead() and not faction:is_human() then
	--		if not faction:is_dead() then kill_faction(faction:name()) end
	--	end
	--end
	--cm:unlock_ritual(local_faction, "wh2_main_ritual_def_khaine")
	
	--cm:add_building_to_force(lokhir:military_force():command_queue_index(), "wh2_main_horde_def_settlement_5")	
	--cm:add_unit_model_overrides("character_cqi:"..lokhir:command_queue_index(), "wh2_sm0_art_set_def_black_ark_lokhir_3")
	--cm:set_saved_value("black_ark_lokhir_ship_art_sets", "wh2_sm0_art_set_def_black_ark_lokhir_3")
	--cm:force_confederation(cm:get_local_faction_name(true),"wh2_dlc11_def_the_blessed_dread")	
	--cm:force_confederation(cm:get_local_faction_name(true),"wh_dlc05_wef_argwylon")	--wh2_dlc15_grn_broken_axe --wh2_dlc15_grn_bonerattlaz
	--cm:force_alliance(cm:get_local_faction_name(true), "wh2_dlc11_def_the_blessed_dread", true)
	--local top_knots = cm:get_faction("wh_main_grn_top_knotz")
	--local mf_list = top_knots:military_force_list()
	--for i = 0, mf_list:num_items() - 1 do
	--	local mf = mf_list:item_at(i)
	--	if not mf:is_armed_citizenry() then 
	--		cm:spawn_agent_at_military_force(top_knots, mf, "wizard", "grn_orc_shaman")
	--		core:add_listener(
	--			"grn_orc_shaman_CharacterCreated",
	--			"CharacterCreated",
	--			function(context)
	--				return true
	--			end,
	--			function(context)
	--				out("sm0/CharacterCreated")
	--				--cm:callback(function() 
	--					cm:embed_agent_in_force(context:character(), mf)
	--				--end, 1)  
	--			end,
	--			false
	--		)
	--	end
	--end
	
	--cm:transfer_region_to_faction("wh2_main_land_of_the_dead_zandri", "wh2_dlc09_tmb_khemri")
	cm:transfer_region_to_faction("wh_main_rib_peaks_mount_gunbad", cm:get_local_faction_name(true))
	cm:transfer_region_to_faction("wh2_main_vor_northern_yvresse_tor_yvresse", "wh2_main_hef_yvresse")
	--cm:transfer_region_to_faction("wh2_main_saphery_tower_of_hoeth", cm:get_local_faction_name(true))
	--cm:transfer_region_to_faction("wh2_main_vor_saphery_tower_of_hoeth", cm:get_local_faction_name(true))

	--local yvresse = cm:get_region("wh2_main_vor_northern_yvresse_tor_yvresse")
	--local yvresse_settlement = yvresse:settlement()
	--cm:instantly_set_settlement_primary_slot_level(yvresse_settlement, 3)	
	cm:transfer_region_to_faction("wh_main_averland_grenzstadt", "wh_main_vmp_vampire_counts")
	--cm:heal_garrison(yvresse:cqi())

	--cm:transfer_region_to_faction("wh2_main_great_mortis_delta_black_pyramid_of_nagash", cm:get_local_faction_name(true))
	--cm:spawn_agent_at_settlement(cm:get_local_faction_name(true), cm:get_region("wh2_main_skavenblight_skavenblight"):settlement(), "wizard", "wh2_main_skv_plague_priest")
	--local characterList = cm:get_local_faction(true):character_list()
    --for i = 0, characterList:num_items() - 1 do
    --    local currentChar = characterList:item_at(i)	
    --    local cqi = currentChar:command_queue_index()
	--	cm:replenish_action_points(cm:char_lookup_str(cqi))
	--end
	--cm:force_make_peace(cm:get_local_faction_name(true), "wh_dlc03_bst_beastmen")
	--cm:force_alliance(cm:get_local_faction_name(true), "wh_dlc03_bst_beastmen", true)
	--local x, y = cm:find_valid_spawn_location_for_character_from_settlement()

	--core:add_listener(
    --    "test123_CharacterCreated",
    --    "CharacterCreated",
	--	function(context)
	--		return context:character():faction():is_human() and context:character():faction():culture() == "wh_main_brt_bretonnia"
	--	end,
    --    function(context)
    --        local character = context:character()
    --        if character:character_type("general") == true then
    --            local faction = context:character():faction()
	--			for i = 1, 6 do
	--				add_vow_progress(character, "wh_dlc07_trait_brt_knights_vow_order_pledge", true, false)
	--			end
	--			for i = 1, 6 do
	--				add_vow_progress(character, "wh_dlc07_trait_brt_questing_vow_heroism_pledge", true, false)
	--			end
    --        end
    --    end,
    --    true
	--)
	cm:modify_faction_slaves_in_a_faction(cm:get_local_faction_name(true), 10000)
	cm:faction_set_food_factor_value(cm:get_local_faction_name(true), "wh_dlc07_chivalry_events", 2000)
	cm:faction_add_pooled_resource(cm:get_local_faction_name(true), "bst_dread", "wh2_dlc17_bst_dread_gain_missions_events", 5000)
	cm:faction_add_pooled_resource(cm:get_local_faction_name(true), "bst_ruination", "wh2_dlc17_bst_ruination_gained_settlement", 5000)
	cm:faction_add_pooled_resource(cm:get_local_faction_name(true), "cst_infamy", "wh2_dlc11_resource_factor_other", 5000)
	cm:faction_add_pooled_resource(cm:get_local_faction_name(true), "grn_salvage", "wh2_dlc13_resource_factor_technology", 500)
	cm:faction_add_pooled_resource(cm:get_local_faction_name(true), "dwf_oathgold", "wh2_main_resource_factor_missions", 5000)
	cm:faction_add_pooled_resource(cm:get_local_faction_name(true), "emp_prestige", "wh2_dlc13_resource_factor_regions", 20000)
	cm:faction_add_pooled_resource("wh2_main_hef_yvresse", "yvresse_defence", "wh2_dlc15_resource_factor_yvresse_defence_settlement", 50)
	cm:faction_add_pooled_resource("wh2_main_hef_yvresse", "wardens_supply", "wh2_dlc15_resource_factor_wardens_supply_executed_prisoners", 100)
	cm:faction_add_pooled_resource(cm:get_local_faction_name(true), "lzd_sacrificial_offerings", "wh2_dlc12_resource_factor_sacrifices_battle", 1200)
	cm:faction_add_pooled_resource(cm:get_local_faction_name(true), "wef_worldroots_athel_loren", "wh2_dlc16_resource_factor_hidden", 1200)

	--cm:trigger_dilemma(cm:get_local_faction_name(true), "wh_dlc05_wef_children_of_eternity")
	

	-- DEBUGGING
	--function empire_event(event_type, event_data_1, event_data_2, event_data_3)
	--	local faction = cm:model():world():whose_turn_is_it()
	--
	--	if event_type == "politics" then
	--		local result = empire_trigger_political_dilemma(faction, event_data_1)
	--		return result
	--	elseif event_type == "invasion" then
	--		local result = empire_trigger_invasion_dilemma(faction, event_data_1, event_data_2, event_data_3)
	--		return result
	--	elseif event_type == "civil_war" then
	--		local result = empire_trigger_civil_war_dilemma(faction, event_data_1)
	--		return result
	--	elseif event_type == "succession" then
	--		local result = empire_trigger_succession_dilemma(faction, event_data_1)
	--		return result
	--	end
	--	return false
	--end

	--cm:create_force(
	--	"wh_main_chs_chaos",
	--	"wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0,wh_main_chs_inf_chaos_marauders_0",
	--	"wh2_main_skavenblight_skavenblight",
	--	445, 270,
	--	true,
	--	function(char_cqi, force_cqi)
		--
	--	end
	--)
	cm:set_region_abandoned("wh2_main_coast_of_araby_al_haikk")
	
	--local region_list = cm:model():world():region_manager():region_list()
	--for i = 0, region_list:num_items() - 1 do
	--	local region = region_list:item_at(i)
	--	--cm:set_region_abandoned(region:name())
	--	cm:transfer_region_to_faction(region:name(), cm:get_local_faction_name(true))	
	--	--cm:heal_garrison(region:cqi())		
	----	local settlement = region:settlement()
	----	cm:instantly_set_settlement_primary_slot_level(settlement, 3)			
	--end

	--if cm:model():turn_number() >= 2 then empire_trigger_invasion_dilemma(local_faction) end
	cm:set_army_trespass_disabled(true)
	--cm:set_character_excluded_from_trespassing(local_faction:faction_leader(), true)

	core:add_listener(
		"refugee_FactionTurnStart",
		"FactionTurnStart",
		true,
		function(context)	
			--cm:transfer_region_to_faction("wh_main_averland_grenzstadt", "wh_main_vmp_vampire_counts")			
			--if cm:model():turn_number() == 2 and context:faction():name() == "wh2_dlc11_def_the_blessed_dread" then 
			--	local blessed_dread = cm:get_faction("wh2_dlc11_def_the_blessed_dread")
			--	local lokhir = blessed_dread:faction_leader()
			--	cm:add_building_to_force(lokhir:military_force():command_queue_index(), "wh2_main_horde_def_settlement_5")
			--	sm0_log("add_building_to_force = wh2_main_horde_def_settlement_5")
			--end

			if context:faction():is_human() then
				local factionList = cm:model():world():faction_list()
				for i = 0, factionList:num_items() - 1 do
					local faction = factionList:item_at(i)
					if faction:subculture() ~= "wh2_main_sc_hef_high_elves" then
						local military_force_list = faction:military_force_list()
						for j = 0, military_force_list:num_items() - 1 do
							local military_force = military_force_list:item_at(j)	
							if not military_force:is_armed_citizenry() then
								local unit_list = military_force:unit_list()
								for k = 0, unit_list:num_items() - 1 do
									local unit = unit_list:item_at(k)	
									if unit:unit_key() == "wh2_main_hef_inf_spearmen_0" then
										sm0_log("wh2_main_hef_inf_spearmen_0 found! | Faction: "..faction:name().." | CQI: "..tostring(military_force:general_character():command_queue_index()))
									end
								end
							end					
						end
					end
				end
				if cm:model():turn_number() == 2 then 
					--empire_attempt_prestige_dilemma(context:faction())
					--[[
					local elector_faction_1 = cm:model():world():faction_by_key("wh_main_emp_nordland")
					local elector_cqi_1 = elector_faction_1:command_queue_index()
					local elector_faction_2 = cm:model():world():faction_by_key("wh_main_emp_ostland")
					local elector_cqi_2 = elector_faction_2:command_queue_index()
					local char_cqi = elector_faction_1:faction_leader():command_queue_index()
					local enemy_faction = cm:model():world():faction_by_key("wh2_dlc13_grn_greenskins_invasion")
					local enemy_cqi = enemy_faction:command_queue_index()
					local region = empire_find_random_elector_region("wh_main_emp_nordland", true)
					local region_cqi = region:cqi()
					
					cm:trigger_dilemma_with_targets(
						context:faction():command_queue_index(),
						"wh2_dlc13_emp_elector_invasion_".."greenskins",
						elector_cqi_1,
						enemy_cqi,
						0,
						0,
						region_cqi,
						0,
						function()

						end
					)
					
					cm:trigger_dilemma_with_targets(
						context:faction():command_queue_index(),
						"wh2_dlc13_emp_elector_civil_war",
						elector_cqi_1,
						elector_cqi_2,
						char_cqi, --
						0,
						0,
						0
					)					
					cm:trigger_dilemma_with_targets(
						context:faction():command_queue_index(),
						"wh2_dlc13_emp_elector_succeeds", 
						elector_cqi_1,
						0,
						char_cqi, --
						0,
						0,
						0
					)
					cm:trigger_dilemma_with_targets(
						context:faction():command_queue_index(),
						"wh2_dlc13_emp_elector_succeeds_fealty", 
						elector_cqi_1,
						0,
						char_cqi, --
						0,
						0,
						0
					)
					cm:trigger_dilemma_with_targets(
						context:faction():command_queue_index(),
						"wh2_dlc13_emp_elector_politics_5",
						elector_cqi_1,
						elector_cqi_2,
						char_cqi, --
						0,
						0,
						0
					)					
					cm:trigger_dilemma_with_targets(
						context:faction():command_queue_index(),
						"wh2_dlc13_emp_elector_politics_7",
						elector_cqi_1,
						elector_cqi_2,
						char_cqi, --
						0,
						0,
						0
					)					
				--]]
				--ci_mid_game_start_setup()
				end
				if cm:model():turn_number() == 4 then 
					--ci_late_game_transition()
				end
				if cm:model():turn_number() == 6 then 
					--ci_spawn_norsca()
					--ci_late_game_start()
				end
			end
			--sm0_log("sm0/faction = "..context:faction():name())
		end,
		true
	)
	expCheat()
	unitCheat()
	--unlockLords()
	for i = 0, 10 do
		--spamLords("wh_dlc05_bst_morghur_herd", false)
		--spamLords("wh_dlc03_bst_beastmen", false)
		--spamLords("wh2_dlc17_bst_malagor", false)
	end
	--local playerFaction = cm:get_local_faction(true)
	--local factionList2 = playerFaction:factions_of_same_subculture()
	--for i = 0, factionList2:num_items() - 1 do
	--	local faction = factionList2:item_at(i)
	--	if faction and not faction:is_dead() then
	--		local characterList = faction:character_list()
	--		for j = 0, characterList:num_items() - 1 do
	--			local currentChar = characterList:item_at(j)
	--			out("sm0/currentChar_subtype["..j.."] = "..currentChar:character_subtype_key())
	--		end
	--	end
	--end

	--cm:show_shroud(true)
	cm:treasury_mod(cm:get_local_faction_name(true), 100000)
	core:add_listener(
		"human_FactionTurnEnd",
		"FactionTurnEnd",
		function(context)
			local human_factions = cm:get_human_factions()
			return context:faction():name() == human_factions[1]
		end,
		function(context)
			--cm:trigger_incident("wh2_main_hef_eataine", "sm0_hef_add_influence", true)
			local human_factions = cm:get_human_factions()

			--if cm:model():turn_number() == 2 then cm:unlock_starting_general_recruitment("2140784146", "wh_main_vmp_vampire_counts") end
			--if cm:model():turn_number() == 2 then cm:force_confederation("wh_main_grn_teef_snatchaz","wh_main_grn_orcs_of_the_bloody_hand") end
			--if cm:model():turn_number() == 4 then kill_faction("wh_main_grn_teef_snatchaz") end
			deletePlayerSubcultureFactions()

			--item test
			--if cm:get_region("wh2_main_vor_kingdom_of_beasts_temple_of_skulls"):is_abandoned() then
			--	cm:transfer_region_to_faction("wh2_main_vor_kingdom_of_beasts_temple_of_skulls", human_factions[1])
			--	local x, y = cm:find_valid_spawn_location_for_character_from_settlement(human_factions[1], "wh2_main_vor_kingdom_of_beasts_temple_of_skulls", false, true, 5)
			--	sm0_log("x = "..x.." | y = "..y)
			--	--cm:force_rebellion_in_region("wh2_main_vor_kingdom_of_beasts_temple_of_skulls", 1, "wh2_main_hef_inf_spearmen_0", x, y, false)
			--	cm:set_public_order_of_province_for_region("wh2_main_vor_kingdom_of_beasts_temple_of_skulls", cm:get_region("wh2_main_vor_kingdom_of_beasts_temple_of_skulls"):public_order() - 300)
			--end
			--cm:force_confederation(human_factions[1],"wh2_main_lzd_last_defenders")
			--cm:show_shroud(true)
		end,
		true
	)
	core:add_listener(
		"test_FactionTurnEnd",
		"FactionTurnStart", 
		function(context)
			return context:faction():is_human()
		end,
		function(context)
			cm:show_shroud(false)
			--local region_list = cm:model():world():region_manager():region_list()
			--for i = 0, region_list:num_items() - 1 do
			--	local region = region_list:item_at(i)
			--	--cm:set_region_abandoned(region:name())
			--	cm:transfer_region_to_faction(region:name(), cm:get_local_faction_name(true))	
			--	cm:heal_garrison(region:cqi())		
			----	local settlement = region:settlement()
			----	cm:instantly_set_settlement_primary_slot_level(settlement, 3)			
			--end
			--expCheat()
			--if cm:model():turn_number() == 2 then expCheat() end
			--sm0_log("Faction: "..context:faction():name().." /is_dead: "..tostring(context:faction():is_dead()))
			--[[
			if cm:model():turn_number() >= 3 then
				local human_factions = cm:get_human_factions()
				local player_1 = cm:get_faction(human_factions[1]) 
				local home_region = player_1:home_region()
				local x, y = cm:find_valid_spawn_location_for_character_from_settlement(player_1:name(), home_region:name(), false, true)
				if cm:model():world():ancillary_exists("wh2_dlc12_anc_weapon_blade_of_the_serpents_tongue") then
					sm0_log("ITEM EXISTS: wh2_dlc12_anc_weapon_blade_of_the_serpents_tongue")
				end
				cm:create_force(
					"wh2_dlc12_lzd_cult_of_sotek",
					"wh2_main_hef_inf_spearmen_0",
					home_region:name(),
					x,
					y,
					true,
					function(cqi)
						--RDLOG("spawn_missing_lords | Faction revived: "..confederated:name().." | Region: "..start_region:name())
						cm:transfer_region_to_faction("wh2_main_southern_great_jungle_axlotl", "wh2_dlc12_lzd_cult_of_sotek")
					end
				)
				cm:force_confederation("wh2_main_lzd_itza", "wh2_dlc12_lzd_cult_of_sotek")	
			end
			--]]
		end,
		true
	)
	--cm:win_next_autoresolve_battle(cm:get_local_faction_name())
	core:add_listener(
        "test_ComponentLClickUp",
        "ComponentLClickUp",
        function(context)
            return true
        end,
        function(context)
            --print_all_uicomponent_children(UIComponent(context.component))
        end,
        true
	)
	core:add_listener(
        "test2_ComponentLClickUp",
        "ComponentLClickUp",
        function(context)
            return true
        end,
		function(context) --wont work!
			--local checkbox_incremental_autosave = find_uicomponent(core:get_ui_root(), "options_game", "panel_campaign", "checkbox_incremental_autosave")
			--local realism_mode = find_uicomponent(core:get_ui_root(), "options_game", "panel_battle", "realism_mode")
			--checkbox_incremental_autosave:SetDisabled(false)
			--realism_mode:SetDisabled(false)
			--if checkbox_incremental_autosave:CurrentState() == "inactive" then checkbox_incremental_autosave:SetState("active") end
			--if realism_mode:CurrentState() == "inactive" then realism_mode:SetState("active") end
		--root > sp_grand_campaign > options > campaign > checkbox_incremental_autosave
		--root > sp_grand_campaign > options > battle_time_limit > realism_mode
		--root > options_game > panel_campaign > checkbox_incremental_autosave
		--root > options_game > panel_battle > realism_mode        
		end,
        true
	)

	--core:add_listener(
    --    "test_CharacterConvalescedOrKilled",
    --    "CharacterConvalescedOrKilled",
    --    function(context)
    --        return true
    --    end,
	--	function(context)
	--		if not context:character():is_null_interface() and context:character():is_wouned() then
	--			sm0_log("CharacterConvalescedOrKilled | "..context:character():faction():name().." | "..context:character():character_subtype_key().." | immortal")
	--		else
	--			sm0_log("CharacterConvalescedOrKilled | dead")
	--		end
    --    end,
    --    true
	--)

	-- trigger a popup to either close with unsaved changes, or cancel the close procedure
	--local uic = core:get_or_create_component("mct_attention", "ui/common ui/dialogue_box")

	-- grey out the rest of the world
	--uic:LockPriority()

	--local tx = find_uicomponent(uic, "DY_text")
	--tx:SetStateText("[[col:red]]New MCT Settings available![[/col]]\n\n"..
	--"There are new campaign specific settings available for \"Legendary Confederations\", \"Example mod 2\" and \"Example mod 3\".\n\nTo open and configure the Mod Configuration Tool, press accept. \nPress Cancel to use default settings!")


	--local button_slaves = find_uicomponent(core:get_ui_root(), "layout", "faction_buttons_docker", "button_group_management", "button_slaves")
	--sm0_log("button_slaves path = "..tostring(button_slaves:GetImagePath()))
	local function check_shit()
		local interface = cm.game_interface
		for k, v in pairs(interface) do
			if is_function(v) then
				sm0_log("Function found: "..k.."()")
			end
		end
	end
	--check_shit()

	--local env = getfenv()
    --
    --for k, v in pairs(env) do
    --    print(tostring(k).."\t"..tostring(v).."\n")
    --    if type(env[k]) == "table" then
    --        for K, V in pairs(env[k]) do
    --            print("\t\t"..tostring(K).."\t"..tostring(V).."\n")
    --        end
    --    end    
    --end


end