--v function(playerFaction: CA_FACTION)
local function deletePlayerSubcultureFactions(playerFaction)
	if cm:model():turn_number() == 1 then cm:force_confederation("wh2_main_hef_caledor", "wh2_main_hef_avelorn") end
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
			faction:name() == "wh2_dlc11_cst_vampire_coast" or faction:name() == "wh_main_emp_middenland" 
			or faction:name() == "wh_main_emp_marienburg" or faction:name() == "wh2_main_hef_avelorn" or faction:name() == "wh_main_brt_lyonesse") and cm:model():turn_number() <= 3) then
				--if playerFaction:subculture() == faction:subculture() and cm:model():turn_number() == 2 then cm:force_confederation(cm:get_local_faction(true), faction:name()) end
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


-- init
--v function()
function sm0_test()	
	core:add_listener(
		"human_FactionTurnEnd",
		"FactionTurnEnd",
		function(context)
			local human_factions = cm:get_human_factions()
			return context:faction():name() == human_factions[1]
		end,
		function(context)
			deletePlayerSubcultureFactions(context:faction())
		end,
		true
	)
end