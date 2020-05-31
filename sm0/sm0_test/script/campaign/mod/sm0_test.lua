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
	local playerFaction = cm:get_faction(cm:get_local_faction(true))
    local characterList = playerFaction:character_list()
    for i = 0, characterList:num_items() - 1 do
        local currentChar = characterList:item_at(i)	
        local cqi = currentChar:command_queue_index()
		cm:add_agent_experience(cm:char_lookup_str(cqi), 70000)
		--cm:add_agent_experience(cm:char_lookup_str(cqi), 9940)
		--if currentChar:character_subtype("wh2_main_skv_lord_skrolk") then cm:force_add_ancillary(currentChar, "wh2_main_anc_arcane_item_the_liber_bubonicus", true, false) end
	end
	--if cm:is_new_game() then
		local factionList = cm:model():world():faction_list()
		for i = 0, factionList:num_items() - 1 do
			local faction = factionList:item_at(i)
			local characterList = faction:character_list()
			for i = 0, characterList:num_items() - 1 do
				local currentChar = characterList:item_at(i)	
				local cqi = currentChar:command_queue_index()
				cm:add_agent_experience(cm:char_lookup_str(cqi), 70000)
				--cm:add_agent_experience(cm:char_lookup_str(cqi), 9940)
			end
		end
	--end
end

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
	local LZDunitstring = {"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1",
						"wh2_dlc12_lzd_mon_ancient_stegadon_1"} --:vector<string>
						
	local playerFaction = cm:get_faction(cm:get_local_faction(true))
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
		cm:spawn_agent_at_settlement(cm:get_faction(cm:get_local_faction(true)), playerFaction:home_region():settlement(), "spy", "wh2_main_skv_assassin")
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
	elseif playerFaction:name() == "wh2_dlc12_lzd_cult_of_sotek" or playerFaction:name() == "wh2_dlc13_lzd_spirits_of_the_jungle"
	or playerFaction:name() == "wh2_main_lzd_hexoatl" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)	
			if currentChar:character_subtype("wh2_dlc12_lzd_tehenhauin") or currentChar:character_subtype("wh2_dlc13_lzd_nakai") 
			or currentChar:character_subtype("wh2_main_lzd_lord_mazdamundi") then
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
	if cm:model():turn_number() == 1 then cm:force_confederation("wh2_main_hef_caledor", "wh2_main_hef_avelorn") end
	local playerFaction = cm:get_faction(cm:get_local_faction(true))
	local factionList2 = playerFaction:factions_of_same_subculture()
	local factionList = cm:model():world():faction_list()
	for i = 0, factionList2:num_items() - 1 do
		local faction = factionList2:item_at(i)
		if faction and not faction:is_dead() and not faction:is_human() and cm:model():turn_number() == 2 then
			--cm:force_confederation(playerFaction:name(), faction:name())	
		end
		if faction and not faction:is_dead() and not faction:is_human() and cm:model():turn_number() == 3 then
			if faction:name() == "wh_main_teb_tilea" or faction:name() == "wh2_dlc09_tmb_followers_of_nagash" or faction:name() == "wh2_dlc11_cst_noctilus" or faction:name() == "wh_main_grn_greenskins" 	
			--or faction:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" 
			or ((--faction:name() == "wh2_main_hef_caledor" or 
			faction:name() == "wh2_dlc11_cst_vampire_coast"
			or faction:name() == "wh_main_emp_marienburg" or faction:name() == "wh2_main_hef_avelorn" or faction:name() == "wh_main_brt_lyonesse") and cm:model():turn_number() <= 3) then
				--if playerFaction:subculture() == faction:subculture() and cm:model():turn_number() == 2 then cm:force_confederation(cm:get_local_faction(true), faction:name()) end
			else
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
	for i = 0, factionList:num_items() - 1 do
		local faction = factionList:item_at(i)
		if faction and not faction:is_dead() and not faction:is_human() then
			if faction:name() == "wh_main_teb_tilea" or faction:name() == "wh2_dlc09_tmb_followers_of_nagash" or faction:name() == "wh2_dlc11_cst_noctilus" or faction:name() == "wh_main_grn_greenskins" 	
			or faction:subculture() == playerFaction:subculture()--or faction:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" 
			or ((faction:name() == "wh2_main_hef_caledor" or faction:name() == "wh2_dlc11_cst_vampire_coast"
			or faction:name() == "wh_main_emp_marienburg" or faction:name() == "wh2_main_hef_avelorn" or faction:name() == "wh_main_brt_lyonesse") and cm:model():turn_number() <= 3) then
				--if playerFaction:subculture() == faction:subculture() and cm:model():turn_number() == 2 then cm:force_confederation(cm:get_local_faction(true), faction:name()) end
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
local function spamLords()
	local faction = "wh_main_dwf_dwarfs"--cm:get_local_faction(true)
	local factionCA = cm:get_faction(faction)
    local x, y
    if factionCA:has_home_region() then x, y = cm:find_valid_spawn_location_for_character_from_settlement(faction, factionCA:home_region():name(), false, false, 9) end
	cm:create_force(
        faction,
        "wh_main_dwf_inf_hammerers",
        factionCA:home_region():name(),
        x,
        y,
        false,
        function(cqi)

        end
	)
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



-- init
--v function()
function sm0_test()
	if cm:is_new_game() and not cm:get_saved_value("sm0_log_reset") then
		sm0_log_reset()
		cm:set_saved_value("sm0_log_reset", true)
	end	
	--cm:transfer_region_to_faction("wh2_main_land_of_the_dead_zandri", "wh2_dlc09_tmb_khemri")
	cm:transfer_region_to_faction("wh2_main_eagle_gate", cm:get_local_faction(true))
	--cm:spawn_agent_at_settlement(cm:get_faction(cm:get_local_faction(true)), cm:get_region("wh2_main_skavenblight_skavenblight"):settlement(), "wizard", "wh2_main_skv_plague_priest")
	--local characterList = cm:get_faction(cm:get_local_faction(true)):character_list()
    --for i = 0, characterList:num_items() - 1 do
    --    local currentChar = characterList:item_at(i)	
    --    local cqi = currentChar:command_queue_index()
	--	cm:replenish_action_points(cm:char_lookup_str(cqi))
	--end
	--cm:force_make_peace(cm:get_local_faction(true), "wh_dlc03_bst_beastmen")
	--cm:force_alliance(cm:get_local_faction(true), "wh_dlc03_bst_beastmen", true)
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
	--cm:faction_set_food_factor_value(cm:get_local_faction(true), "wh_dlc07_chivalry_events", 1600)
	cm:faction_add_pooled_resource(cm:get_local_faction(true), "cst_infamy", "wh2_dlc11_resource_factor_other", 5000)
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

	core:add_listener(
		"refugee_FactionTurnStart",
		"FactionTurnStart",
		true,
		function(context)
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
			end
			--sm0_log("sm0/faction = "..context:faction():name())
		end,
		true
	)
	expCheat()
	unitCheat()
	--unlockLords()
	--spamLords()
	cm:treasury_mod(cm:get_local_faction(true), 100000)
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
	--cm:win_next_autoresolve_battle(cm:get_local_faction())
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
end