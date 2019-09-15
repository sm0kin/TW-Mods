local additional_starting_units = {
	"wh_main_emp_inf_greatswords",
	"wh_main_emp_inf_greatswords"
} 
function make_karl_great_again()
	if cm:is_new_game() then
		local player_faction = cm:get_faction(cm:get_local_faction(true))
		local character_list = player_faction:character_list()
		if player_faction:subculture() == "wh_main_sc_emp_empire" then
			for i = 0, character_list:num_items() - 1 do
				local current_char = character_list:item_at(i) 
				if current_char:has_military_force() and not current_char:military_force():is_armed_citizenry() then
					local cqi = current_char:command_queue_index()
					for _, unit in ipairs(additional_starting_units) do 
						cm:grant_unit_to_character(cm:char_lookup_str(cqi), unit)
					end
				end
			end
		end
	end
end