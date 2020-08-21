--# assume global reveal_all_sea_regions: function(faction_name: string)
local ship_art_sets = {
	["wh2_main_horde_def_settlement_1"] = "wh2_sm0_art_set_def_black_ark_lokhir_1",
	["wh2_main_horde_def_settlement_2"] = "wh2_sm0_art_set_def_black_ark_lokhir_1",
	["wh2_main_horde_def_settlement_3"] = "wh2_sm0_art_set_def_black_ark_lokhir_2",
	["wh2_main_horde_def_settlement_4"] = "wh2_sm0_art_set_def_black_ark_lokhir_2",
	["wh2_main_horde_def_settlement_5"] = "wh2_sm0_art_set_def_black_ark_lokhir_3"
} --:map<string, string>

local movement_correction_value = true

--v function(char: CA_CHAR)
local function respawn_character_with_army(char)
	local subtype = char:character_subtype_key()
	local faction = char:faction()
    local region = char:region()
    local x = char:logical_position_x()
	local y = char:logical_position_y()
	local army = ""
	local unit_list = char:military_force():unit_list()
	for i = 1, unit_list:num_items() - 1 do
		local unit = unit_list:item_at(i)
		if army ~= "" then army = army.."," end
		army = army..unit:unit_key()	
	end
	core:add_listener(
		"respawn_character_with_army_CharacterConvalescedOrKilled",
		"CharacterConvalescedOrKilled",
		function(context)
			return context:character():character_subtype_key() == subtype
		end,
			function(context)
			cm:callback(function()
				local cqi
        	    local char_list =  faction:character_list()
        	    for i = 0, char_list:num_items() - 1 do
        	        local current_char = char_list:item_at(i)
        	        if current_char:character_subtype(subtype) and current_char:is_wounded() then
        	            cqi = current_char:command_queue_index()
						cm:stop_character_convalescing(cqi) 
						break
        	        end
        	    end
			cm:create_force_with_existing_general(
                "character_cqi:"..cqi,
                faction:name(), 
                army,
                region:name(),
                x,
                y,
                function(cqi)
                    cm:disable_event_feed_events(false, "all", "", "")
                end
			)
			end, 0.1)
		end,
		false
	)
    if army and region and x and y then
        cm:disable_event_feed_events(true, "all", "", "")
        cm:kill_character(char:command_queue_index(), true, false)
    else
        out("ERROR | respawn_character_with_army - Something went wrong.")
    end
end
--v function(char: CA_CHAR)
local function manage_naval_movement_range(char)
	local custom_upkeep_bundle = cm:create_new_custom_effect_bundle("wh_sm0_increased_movement_range")
	custom_upkeep_bundle:set_duration(-1)
	local additional_range
	if cm:get_saved_value("black_ark_lokhir_replenish_action_points") == 4 then -- == "wh2_sm0_special_ship_lokhir_1"
		custom_upkeep_bundle:add_effect("wh_sm0_effect_force_all_naval_movement_range", "force_to_force_own", 10)
		additional_range = 0.1
	elseif cm:get_saved_value("black_ark_lokhir_replenish_action_points") == 2 then -- == "wh2_sm0_special_ship_lokhir_1"
		custom_upkeep_bundle:add_effect("wh_sm0_effect_force_all_naval_movement_range", "force_to_force_own", 15)
		additional_range = 0.15
	elseif cm:get_saved_value("black_ark_lokhir_replenish_action_points") == 1 then -- == "wh2_sm0_special_ship_lokhir_1"
		custom_upkeep_bundle:add_effect("wh_sm0_effect_force_all_naval_movement_range", "force_to_force_own", 20)
		additional_range = 0.2
	end
	if char:is_at_sea() then
		if not char:military_force():has_effect_bundle("wh_sm0_increased_movement_range") then
			cm:callback(function()
				cm:apply_custom_effect_bundle_to_force(custom_upkeep_bundle, char:military_force())
				if cm:get_saved_value("sm0_movement_range_correction_sea_needed") and movement_correction_value then 
					--out("sm0/SEA/action_points_remaining_percent = "..tostring(char:action_points_remaining_percent()))
					--out("sm0/SEA/additional_range = "..tostring(additional_range))
					--out("sm0/SEA/movement_correction = "..tostring(movement_correction))
					local movement_correction = (char:action_points_remaining_percent() / 100) + additional_range
					cm:replenish_action_points("character_cqi:"..char:command_queue_index(), movement_correction)
					cm:set_saved_value("sm0_movement_range_correction_sea", false)
					cm:set_saved_value("sm0_movement_range_correction_land", true)
				end
			end, 0.1)
		end
	else
		cm:remove_effect_bundle_from_characters_force("wh_sm0_increased_movement_range", char:command_queue_index())
		--if not cm:get_saved_value("sm0_movement_range_correction_land_needed") and char:faction():is_human() and movement_correction_value then
		--	cm:callback(function()
		--		out("sm0/LAND/action_points_remaining_percent = "..tostring(char:action_points_remaining_percent()))
		--		out("sm0/LAND/additional_range = "..tostring(additional_range))
		--		out("sm0/LAND/movement_correction = "..tostring(movement_correction))
		--		local movement_correction = (char:action_points_remaining_percent() / 100) - additional_range
		--		if movement_correction > 0 then 
		--		cm:replenish_action_points("character_cqi:"..char:command_queue_index(), movement_correction)
		--		end
		--		cm:set_saved_value("sm0_movement_range_correction_land", false)
		--		cm:set_saved_value("sm0_movement_range_correction_sea", true)
		--	end, 0.1)
		--end
	end
end

function black_ark_lokhir()
	if not cm:get_saved_value("black_ark_lokhir") then
		local faction_list = cm:model():world():faction_list()
		for i = 0, faction_list:num_items() - 1 do
			local current_faction = faction_list:item_at(i)
			local char_list = current_faction:character_list()
			for j = 0, char_list:num_items() - 1 do
				local current_char = char_list:item_at(j)
				if current_char:character_subtype_key() == "wh2_dlc11_def_lokhir" then
					if not cm:is_new_game() then
						cm:convert_force_to_type(current_char:military_force(), "CHARACTER_BOUND_HORDE")
					else
						cm:callback(function() respawn_character_with_army(current_char) end, 1)
					end
					cm:set_saved_value("black_ark_lokhir", true)
				end
			end      
		end
	end
	core:add_listener(
		"black_ark_lokhir_MilitaryForceBuildingCompleteEvent",
		"MilitaryForceBuildingCompleteEvent",
		function(context)
			return not context:character():is_null_interface() and context:character():character_subtype_key() == "wh2_dlc11_def_lokhir"
		end,
		function(context) 
			local art_set = ship_art_sets[context:building()]
			local cqi = context:character():command_queue_index()
			if art_set and cqi then
				cm:add_unit_model_overrides("character_cqi:"..cqi, art_set)
				cm:set_saved_value("black_ark_lokhir_ship_art_sets", art_set)
			end
			if context:building() == "wh2_sm0_special_ship_lokhir_1" then
				cm:set_saved_value("black_ark_lokhir_replenish_action_points", 4) --25%
				manage_naval_movement_range(context:character())
			elseif context:building() == "wh2_sm0_special_ship_lokhir_2" then
				cm:set_saved_value("black_ark_lokhir_replenish_action_points", 2) --50%
				manage_naval_movement_range(context:character())
			elseif context:building() == "wh2_sm0_special_ship_lokhir_3" then
				reveal_all_sea_regions(context:character():faction():name())
				cm:set_saved_value("black_ark_lokhir_replenish_action_points", 1) --100%
				manage_naval_movement_range(context:character())
			end
		end,
		true
	)	
	core:add_listener(
		"black_ark_lokhir_FactionJoinsConfederation",
		"FactionJoinsConfederation",
		true,
		function(context)
			local faction = context:confederation()
			local char_list = faction:character_list()
			for i = 0, char_list:num_items() - 1 do
				local current_char = char_list:item_at(i)
				if current_char:character_subtype_key() == "wh2_dlc11_def_lokhir" then
					local art_set = cm:get_saved_value("black_ark_lokhir_replenish_action_points") or "wh2_sm0_art_set_def_black_ark_lokhir_1"
					if cm:get_saved_value("rd_confed") then art_set = "wh2_sm0_art_set_def_black_ark_lokhir_1" end
					cm:add_unit_model_overrides("character_cqi:"..current_char:command_queue_index(), art_set)
				end
			end
		end,
		true
	)
	core:add_listener(
		"black_ark_lokhir_CharacterSackedSettlement",
		"CharacterSackedSettlement",
		function(context)
			return not context:character():is_null_interface() and context:character():character_subtype_key() == "wh2_dlc11_def_lokhir"
		end,
		function(context) 
			local cqi = context:character():command_queue_index()
			local settlement = context:garrison_residence():region():settlement()
			if settlement:is_port() and cm:random_number(cm:get_saved_value("black_ark_lokhir_replenish_action_points")) == 1 then
				cm:replenish_action_points("character_cqi:"..cqi)
			end
		end,
		true
	)	
	core:add_listener(
		"black_ark_lokhir_CharacterFinishedMovingEvent",
		"CharacterFinishedMovingEvent",
		function(context)
			local current_faction = cm:whose_turn_is_it()
			return context:character():character_subtype("wh2_dlc11_def_lokhir") and current_faction == context:character():faction():name()
		end,
		function(context)
			manage_naval_movement_range(context:character())
		end,
		true
	)
	core:add_listener(
		"black_ark_lokhir_CCharacterTurnStart",
		"CharacterTurnStart",
		function(context)
			return context:character():character_subtype("wh2_dlc11_def_lokhir")
		end,
		function(context)
			if context:character():is_at_sea() then 
				cm:set_saved_value("sm0_movement_range_correction_sea_needed", false) 
				cm:set_saved_value("sm0_movement_range_correction_land", true)
			else
				cm:set_saved_value("sm0_movement_range_correction_sea_needed", true) 
				cm:set_saved_value("sm0_movement_range_correction_land", false)
			end
		end,
		true
	)
end