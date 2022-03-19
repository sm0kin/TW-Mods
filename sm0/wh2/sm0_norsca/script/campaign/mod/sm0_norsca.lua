--core:add_listener(
--	"UnitTrained_player_army_count",
--	"UnitTrained",
--	function(context)
--		local unit = context:unit()
--		local has_unit_commander = unit:has_unit_commander()
--
--		return has_unit_commander == true and upkeep_penalty_condition(unit:faction())
--	end,
--	function(context)
--		local unit = context:unit()
--		apply_upkeep_penalty(unit:faction())
--	end,
--	true
--)

-- wh_campaign_setup.lua upkeep_penalty_condition function override
--v function(faction: CA_FACTION) --> boolean
--function upkeep_penalty_condition(faction)
--	local culture = faction:culture()
--	local subculture = faction:subculture()
--	out("sm0/upkeep_penalty_condition/culture = "..culture)
--	out("sm0/upkeep_penalty_condition/subculture = "..subculture)
--	return faction:is_human() and not wh_faction_is_horde(faction) and culture ~= "wh_main_brt_bretonnia" and culture ~= "wh2_dlc09_tmb_tomb_kings" and subculture ~= "wh_main_sc_nor_norsca"
--end

local leader_subtype_upkeep_exclusions = {
	["wh2_main_def_black_ark"] = true,
	["wh2_pro08_neu_gotrek"] = true
}

-- loop through the player's armys and apply
function apply_upkeep_penalty(faction)
	local difficulty = cm:model():combined_difficulty_level()
	
	local effect_bundle = "wh_main_bundle_force_additional_army_upkeep_easy"				-- easy
	if faction:subculture() ~= "wh_main_sc_nor_norsca"  then
		if difficulty == 0 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_normal"				-- normal
		elseif difficulty == -1 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_hard"					-- hard
		elseif difficulty == -2 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_very_hard"			-- very hard
		elseif difficulty == -3 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_legendary"			-- legendary
		end
	else
		if difficulty == 0 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_easy"				-- normal
		elseif difficulty == -1 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_normal"					-- hard
		elseif difficulty == -2 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_hard"			-- very hard
		elseif difficulty == -3 then
			effect_bundle = "wh_main_bundle_force_additional_army_upkeep_hard"			-- legendary
		end
	end
	
	local mf_list = faction:military_force_list()
	local army_list = {}
	
	for i = 0, mf_list:num_items() - 1 do
		local current_mf = mf_list:item_at(i)
		local force_type = current_mf:force_type():key()
		
		if current_mf:is_armed_citizenry() == false and current_mf:has_general() == true and force_type ~= "SUPPORT_ARMY" then
			local general = current_mf:general_character()
			local character_subtype_key = general:character_subtype_key()
			local cqi = general:command_queue_index()
			--local unit_count = current_mf:unit_list():num_items()

			--if leader_subtype_upkeep_exclusions[character_subtype_key] == nil and (faction:subculture() ~= "wh_main_sc_nor_norsca" or unit_count > 8) then
			if leader_subtype_upkeep_exclusions[character_subtype_key] == nil then
				table.insert(army_list, current_mf)
				cm:remove_effect_bundle_from_characters_force(effect_bundle, cqi)
			end
		end
	end
	
	if #army_list > 1 then
		for i = 1, #army_list - 1 do
			local current_mf = army_list[i]
			
			if not current_mf:has_effect_bundle(effect_bundle) then
				cm:apply_effect_bundle_to_characters_force(effect_bundle, army_list[i]:general_character():cqi(), 0, true)
			end
		end
	end
end