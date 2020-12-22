function naval_expedition()
	if not cm:get_saved_value("markers_set") then cm:set_saved_value("markers_set", 0) end
	if cm:get_saved_value("markers_set") == 0 and cm:model():campaign_name("main_warhammer") then
		cm:add_interactable_campaign_marker("naval_expedition_marker_1", "teleport_marker", 1000, 50, 4, "", "")
		cm:add_interactable_campaign_marker("naval_expedition_marker_2", "teleport_marker", 573, 12, 4, "", "")
		cm:add_interactable_campaign_marker("naval_expedition_marker_3", "teleport_marker", 361, 13, 4, "", "")
		cm:set_saved_value("markers_set", 1)
		out("Set down sea markers!")
	end
end

core:add_listener(
	"area_entered_naval_exped",
	"AreaEntered",
	true,
	function(context)
		local area_key = context:area_key()
		local character = context:character()
		local cqi = context:character():cqi()
		local faction_name = cm:get_local_faction_name()
		local faction = cm:get_faction(faction_name)
		local char_str = cm:char_lookup_str(cqi)
		if area_key == "naval_expedition_marker_1" and context:character():faction():is_human() then 
			cm:trigger_dilemma(faction_name, "naval_exped_dilemma_1") 
			cm:set_saved_value("temp_char_naval_exped", cqi)
			cm:teleport_to(char_str, 1000, 53, true)
		end
		if area_key == "naval_expedition_marker_2" and context:character():faction():is_human() then 
			cm:trigger_dilemma(faction_name, "naval_exped_dilemma_2") 
			cm:set_saved_value("temp_char_naval_exped", cqi)
			cm:teleport_to(char_str, 573, 17, true)
		end
		if area_key == "naval_expedition_marker_3" and context:character():faction():is_human() then 
			cm:trigger_dilemma(faction_name, "naval_exped_dilemma_3") 
			cm:set_saved_value("temp_char_naval_exped", cqi)
			cm:teleport_to(char_str, 361, 13, true)
		end
	end,	
	true
)

core:add_listener(
	"dilemma_choice_naval_exped",
	"DilemmaChoiceMadeEvent",
	true,
	function(context)
		local choice = context:choice()
		local dilemma = context:dilemma()
		if dilemma == "naval_exped_dilemma_1" then 
			if choice == 0 then
				local char_cqi = cm:get_saved_value("temp_char_naval_exped")
				local char_str = cm:char_lookup_str(char_cqi)
				cm:disable_movement_for_character(char_str)
				cm:apply_effect_bundle_to_characters_force("naval_exped_travelling", char_cqi, 3, false)
				cm:set_saved_value("serpent_to_sudenburg_travel_"..char_cqi, 2)
				out("Set saved value of serpent_to_sudenburg_travel_"..char_cqi.." to")
				out(cm:get_saved_value("serpent_to_sudenburg_travel_"..char_cqi))
			end
			if choice == 1 then
				local char_cqi = cm:get_saved_value("temp_char_naval_exped")
				local char_str = cm:char_lookup_str(char_cqi)
				cm:disable_movement_for_character(char_str)
				cm:apply_effect_bundle_to_characters_force("naval_exped_travelling", char_cqi, 4, false)
				cm:set_saved_value("serpent_to_shark_travel_"..char_cqi, 3)
				out("Set saved value of serpent_to_shark_travel_"..char_cqi.." to")
				out(cm:get_saved_value("serpent_to_shark_travel_"..char_cqi))
			end
		end
		if dilemma == "naval_exped_dilemma_2" then 
			if choice == 0 then
				local char_cqi = cm:get_saved_value("temp_char_naval_exped")
				local char_str = cm:char_lookup_str(char_cqi)
				cm:disable_movement_for_character(char_str)
				cm:apply_effect_bundle_to_characters_force("naval_exped_travelling", char_cqi, 3, false)
				cm:set_saved_value("sudenburg_to_serpent_travel_"..char_cqi, 2)
				out("Set saved value of sudenburg_to_serpent_travel_"..char_cqi.." to")
				out(cm:get_saved_value("sudenburg_to_serpent_travel_"..char_cqi))
			end
			if choice == 1 then
				local char_cqi = cm:get_saved_value("temp_char_naval_exped")
				local char_str = cm:char_lookup_str(char_cqi)
				cm:disable_movement_for_character(char_str)
				cm:apply_effect_bundle_to_characters_force("naval_exped_travelling", char_cqi, 3, false)
				cm:set_saved_value("sudenburg_to_shark_travel_"..char_cqi, 2)
				out("Set saved value of sudenburg_to_shark_travel_"..char_cqi.." to")
				out(cm:get_saved_value("sudenburg_to_shark_travel_"..char_cqi))
			end
		end
		if dilemma == "naval_exped_dilemma_3" then 
			if choice == 0 then
				local char_cqi = cm:get_saved_value("temp_char_naval_exped")
				local char_str = cm:char_lookup_str(char_cqi)
				cm:disable_movement_for_character(char_str)
				cm:apply_effect_bundle_to_characters_force("naval_exped_travelling", char_cqi, 3, false)
				cm:set_saved_value("shark_to_sudenburg_travel_"..char_cqi, 2)
				out("Set saved value of shark_to_sudenburg_travel "..char_cqi.." to")
				out(cm:get_saved_value("shark_to_sudenburg_travel_"..char_cqi))
			end
			if choice == 1 then
				local char_cqi = cm:get_saved_value("temp_char_naval_exped")
				local char_str = cm:char_lookup_str(char_cqi)
				cm:disable_movement_for_character(char_str)
				cm:apply_effect_bundle_to_characters_force("naval_exped_travelling", char_cqi, 4, false)
				cm:set_saved_value("shark_to_serpent_travel_"..char_cqi, 3)
				out("Set saved value of shark_to_serpent_travel_"..char_cqi.." to")
				out(cm:get_saved_value("shark_to_serpent_travel_"..char_cqi))
			end
		end
	end,
	true
)

core:add_listener (
	"check_for_travel",
	"CharacterTurnStart",
	function(context)
		return (context:character():faction():is_human()) 
	end,
	function(context)
		local faction_key = context:character():faction():name()
		local char = context:character()
		local char_cqi = char:command_queue_index()
		local char_str = cm:char_lookup_str(char_cqi)
		if cm:get_saved_value("serpent_to_sudenburg_travel_"..char_cqi) then 
			out("char has travelled or is travelling! serpent_to_sudenburg_travel_")
			if cm:get_saved_value("serpent_to_sudenburg_travel_"..char_cqi) == 0 then
				local viable_x, viable_y = cm:find_valid_spawn_location_for_character_from_position(cm:model():world():whose_turn_is_it():name(), 576, 19, false, 2)
				cm:teleport_to(char_str, viable_x, viable_y, true)
				cm:enable_movement_for_character(char_str)
				cm:show_message_event_located(cm:model():world():whose_turn_is_it():name(), "event_feed_strings_text_navalexped_title", "event_feed_strings_text_navalexped_primary_detail", "event_feed_strings_text_navalexped_secondary_detail", 576, 19, false, 1017)
				cm:set_saved_value("serpent_to_sudenburg_travel_"..char_cqi, -1)
			else
				out("Cooldown still going!")
			end
		end
		if cm:get_saved_value("serpent_to_shark_travel_"..char_cqi) then
			out("char has travelled or is travelling! serpent_to_shark_travel_")
			if cm:get_saved_value("serpent_to_shark_travel_"..char_cqi) == 0 then
				local viable_x, viable_y = cm:find_valid_spawn_location_for_character_from_position(cm:model():world():whose_turn_is_it():name(), 365, 18, false, 2)
				cm:teleport_to(char_str, viable_x, viable_y, true)
				cm:enable_movement_for_character(char_str)
				cm:show_message_event_located(cm:model():world():whose_turn_is_it():name(), "event_feed_strings_text_navalexped_title", "event_feed_strings_text_navalexped_primary_detail", "event_feed_strings_text_navalexped_secondary_detail", 365, 18, false, 1017)
				cm:set_saved_value("serpent_to_shark_travel_"..char_cqi, -1)
			else
				out("Cooldown still going!")
			end
		end
		if cm:get_saved_value("sudenburg_to_serpent_travel_"..char_cqi) then
			out("char has travelled or is travelling! sudenburg_to_serpent_travel_")
			if cm:get_saved_value("sudenburg_to_serpent_travel_"..char_cqi) == 0 then
			local viable_x, viable_y = cm:find_valid_spawn_location_for_character_from_position(cm:model():world():whose_turn_is_it():name(), 989, 50, false, 2)
			cm:teleport_to(char_str, viable_x, viable_y, true)
			cm:enable_movement_for_character(char_str)
			cm:show_message_event_located(cm:model():world():whose_turn_is_it():name(), "event_feed_strings_text_navalexped_title", "event_feed_strings_text_navalexped_primary_detail", "event_feed_strings_text_navalexped_secondary_detail", 989,50, false, 1017)
			cm:set_saved_value("sudenburg_to_serpent_travel_"..char_cqi, -1)
			else
				out("Cooldown still going!")
			end
		end
		if cm:get_saved_value("sudenburg_to_shark_travel_"..char_cqi) then
			out("char has travelled or is travelling! sudenburg_to_shark_travel_")
			if cm:get_saved_value("sudenburg_to_shark_travel_"..char_cqi) == 0 then
				local viable_x, viable_y = cm:find_valid_spawn_location_for_character_from_position(cm:model():world():whose_turn_is_it():name(), 365, 18, false, 2)
				cm:teleport_to(char_str, viable_x, viable_y, true)
				cm:enable_movement_for_character(char_str)
				cm:show_message_event_located(cm:model():world():whose_turn_is_it():name(), "event_feed_strings_text_navalexped_title", "event_feed_strings_text_navalexped_primary_detail", "event_feed_strings_text_navalexped_secondary_detail", 365, 18, false, 1017)
				cm:set_saved_value("sudenburg_to_shark_travel_"..char_cqi, -1)
			else
				out("Cooldown still going!")
			end
		end
		if cm:get_saved_value("shark_to_sudenburg_travel_"..char_cqi) then
			out("char has travelled or is travelling! shark_to_sudenburg_travel_")
			if cm:get_saved_value("shark_to_sudenburg_travel_"..char_cqi) == 0 then
				local viable_x, viable_y = cm:find_valid_spawn_location_for_character_from_position(cm:model():world():whose_turn_is_it():name(), 576, 19, false, 2)
				cm:teleport_to(char_str, viable_x, viable_y, true)
				cm:enable_movement_for_character(char_str)
				cm:show_message_event_located(cm:model():world():whose_turn_is_it():name(), "event_feed_strings_text_navalexped_title", "event_feed_strings_text_navalexped_primary_detail", "event_feed_strings_text_navalexped_secondary_detail", 576, 19, false, 1017)
				cm:set_saved_value("shark_to_sudenburg_travel_"..char_cqi, -1)
			else
				out("Cooldown still going!")
			end
		end
		if cm:get_saved_value("shark_to_serpent_travel_"..char_cqi) then
			out("char has travelled or is travelling! shark_to_serpent_travel_")
			if cm:get_saved_value("shark_to_serpent_travel_"..char_cqi) == 0 then
				local viable_x, viable_y = cm:find_valid_spawn_location_for_character_from_position(cm:model():world():whose_turn_is_it():name(), 989, 50, false, 2)
				cm:teleport_to(char_str, viable_x, viable_y, true)
				cm:enable_movement_for_character(char_str)
				cm:show_message_event_located(cm:model():world():whose_turn_is_it():name(), "event_feed_strings_text_navalexped_title", "event_feed_strings_text_navalexped_primary_detail", "event_feed_strings_text_navalexped_secondary_detail", 989, 50, false, 1017)
				cm:set_saved_value("shark_to_serpent_travel_"..char_cqi, -1)
			else
				out("Cooldown still going!")
			end
		end			
	end,
	true
)

core:add_listener (
	"check_for_travel_cooldowns",
	"CharacterTurnStart",
	function(context)
		return (context:character():faction():is_human()) 
	end,
	function(context)
		local char = context:character()
		local char_cqi = char:command_queue_index()
		local char_str = cm:char_lookup_str(char_cqi)
		if cm:get_saved_value("serpent_to_sudenburg_travel_"..char_cqi) then
			if cm:get_saved_value("serpent_to_sudenburg_travel_"..char_cqi) > 0 then
				local cooldown =  cm:get_saved_value("serpent_to_sudenburg_travel_"..char_cqi)
				cm:set_saved_value("serpent_to_sudenburg_travel_"..char_cqi, cooldown - 1) out("set value of "..char_cqi.." to") out(cm:get_saved_value("serpent_to_sudenburg_travel_"..char_cqi))
			end
		end
		if cm:get_saved_value("serpent_to_shark_travel_"..char_cqi) then
			if cm:get_saved_value("serpent_to_shark_travel_"..char_cqi) > 0 then
				local cooldown =  cm:get_saved_value("serpent_to_shark_travel_"..char_cqi)
				cm:set_saved_value("serpent_to_shark_travel_"..char_cqi, cooldown - 1) out("set value of "..char_cqi.." to") out(cm:get_saved_value("serpent_to_shark_travel_"..char_cqi)) 
			end
		end
		if cm:get_saved_value("sudenburg_to_serpent_travel_"..char_cqi) then
			if cm:get_saved_value("sudenburg_to_serpent_travel_"..char_cqi) > 0 then
				local cooldown =  cm:get_saved_value("sudenburg_to_serpent_travel_"..char_cqi)
				cm:set_saved_value("sudenburg_to_serpent_travel_"..char_cqi, cooldown - 1)  out("set value of "..char_cqi.." to") out(cm:get_saved_value("sudenburg_to_serpent_travel_"..char_cqi)) 
			end
		end
		if cm:get_saved_value("sudenburg_to_shark_travel_"..char_cqi) then
			if cm:get_saved_value("sudenburg_to_shark_travel_"..char_cqi) > 0 then
				local cooldown =  cm:get_saved_value("sudenburg_to_shark_travel_"..char_cqi)
				cm:set_saved_value("sudenburg_to_shark_travel_"..char_cqi, cooldown - 1) out("set value of "..char_cqi.." to") out(cm:get_saved_value("sudenburg_to_shark_travel_"..char_cqi)) 
			end
		end
		if cm:get_saved_value("shark_to_sudenburg_travel_"..char_cqi) then
			if cm:get_saved_value("shark_to_sudenburg_travel_"..char_cqi) > 0 then
				local cooldown =  cm:get_saved_value("shark_to_sudenburg_travel_"..char_cqi)
				cm:set_saved_value("shark_to_sudenburg_travel_"..char_cqi, cooldown - 1) out("set value of "..char_cqi.." to") out(cm:get_saved_value("shark_to_sudenburg_travel_"..char_cqi)) 
			end
		end
		if cm:get_saved_value("shark_to_serpent_travel_"..char_cqi) then
			if cm:get_saved_value("shark_to_serpent_travel_"..char_cqi) > 0 then
				local cooldown =  cm:get_saved_value("shark_to_serpent_travel_"..char_cqi)
				cm:set_saved_value("shark_to_serpent_travel_"..char_cqi, cooldown - 1) out("set value of "..char_cqi.." to") out(cm:get_saved_value("shark_to_serpent_travel_"..char_cqi))
			end
		end	
	end,
	true
)
		

core:add_listener(
   	"redisable_movement_navalexp",
  	"CharacterSelected",
	function(context)
		return (context:character():faction():is_human()) 
	end,
   	function(context)
		local char_cqi = context:character():cqi()
		local char_str = cm:char_lookup_str(char_cqi)
		if cm:get_saved_value("serpent_to_sudenburg_travel_"..char_cqi) then if cm:get_saved_value("serpent_to_sudenburg_travel_"..char_cqi) > 0 then cm:disable_movement_for_character(char_str) end end
		if cm:get_saved_value("serpent_to_shark_travel_"..char_cqi) then if cm:get_saved_value("serpent_to_shark_travel_"..char_cqi) > 0 then cm:disable_movement_for_character(char_str) end end
		if cm:get_saved_value("sudenburg_to_serpent_travel_"..char_cqi) then if cm:get_saved_value("sudenburg_to_serpent_travel_"..char_cqi) > 0 then cm:disable_movement_for_character(char_str) end end
		if cm:get_saved_value("sudenburg_to_shark_travel_"..char_cqi) then if cm:get_saved_value("sudenburg_to_shark_travel_"..char_cqi) > 0 then cm:disable_movement_for_character(char_str) end end
		if cm:get_saved_value("shark_to_sudenburg_travel_"..char_cqi) then if cm:get_saved_value("shark_to_sudenburg_travel_"..char_cqi) > 0 then cm:disable_movement_for_character(char_str) end end
		if cm:get_saved_value("shark_to_serpent_travel_"..char_cqi) then if cm:get_saved_value("shark_to_serpent_travel_"..char_cqi) > 0 then cm:disable_movement_for_character(char_str) end end
    end,
    true
)











