--v function(char: CA_CHAR)
local function respawn_character_with_army(char)
	local subtype = char:character_subtype_key()
	local faction = char:faction()
	local region = char:region()
	if char:is_at_sea() then
		region = char:faction():home_region()
	end  
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

function alberic_ship()
	cm:callback(function() 
		if not cm:get_saved_value("alberic_ship") then
			local faction_list = cm:model():world():faction_list()
			for i = 0, faction_list:num_items() - 1 do
				local current_faction = faction_list:item_at(i)
				local char_list = current_faction:character_list()
				for j = 0, char_list:num_items() - 1 do
					local current_char = char_list:item_at(j)
					if current_char:character_subtype_key() == "dlc07_brt_alberic" then
						if not cm:is_new_game() then
							cm:convert_force_to_type(current_char:military_force(), "CHARACTER_BOUND_HORDE")
						else
							respawn_character_with_army(current_char) 						
						end
						cm:set_saved_value("alberic_ship", true)
					end
				end      
			end
		end
	end, 1)
end