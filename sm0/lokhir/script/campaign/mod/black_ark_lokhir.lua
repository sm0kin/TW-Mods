--# assume global reveal_all_sea_regions: function(faction_name: string)
local ship_art_sets = {
	["wh2_main_horde_def_settlement_1"] = "wh2_sm0_art_set_def_black_ark_lokhir_1",
	["wh2_main_horde_def_settlement_2"] = "wh2_sm0_art_set_def_black_ark_lokhir_1",
	["wh2_main_horde_def_settlement_3"] = "wh2_sm0_art_set_def_black_ark_lokhir_2",
	["wh2_main_horde_def_settlement_4"] = "wh2_sm0_art_set_def_black_ark_lokhir_2",
	["wh2_main_horde_def_settlement_5"] = "wh2_sm0_art_set_def_black_ark_lokhir_3"
} --:map<string, string>

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
						respawn_character_with_army(current_char)
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
			elseif context:building() == "wh2_sm0_special_ship_lokhir_2" then
				cm:set_saved_value("black_ark_lokhir_replenish_action_points", 2) --50%
			elseif context:building() == "wh2_sm0_special_ship_lokhir_3" then
				reveal_all_sea_regions(context:character():faction():name())
				cm:set_saved_value("black_ark_lokhir_replenish_action_points", 1) --100%
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
end