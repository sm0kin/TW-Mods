--# assume global reveal_all_sea_regions: function(faction_name: string)
local ship_art_sets = {
	["wh2_main_horde_def_settlement_1"] = "wh2_sm0_art_set_def_black_ark_lokhir_1",
	["wh2_main_horde_def_settlement_2"] = "wh2_sm0_art_set_def_black_ark_lokhir_1",
	["wh2_main_horde_def_settlement_3"] = "wh2_sm0_art_set_def_black_ark_lokhir_2",
	["wh2_main_horde_def_settlement_4"] = "wh2_sm0_art_set_def_black_ark_lokhir_2",
	["wh2_main_horde_def_settlement_5"] = "wh2_sm0_art_set_def_black_ark_lokhir_3"
} --:map<string, string>

function black_ark_lokhir()
	if not cm:get_saved_value("black_ark_lokhir") then
		local faction_list = cm:model():world():faction_list()
		for i = 0, faction_list:num_items() - 1 do
			local current_faction = faction_list:item_at(i)
			local char_list = current_faction:character_list()
			for j = 0, char_list:num_items() - 1 do
				local current_char = char_list:item_at(j)
				if current_char:character_subtype_key() == "wh2_dlc11_def_lokhir" then
					cm:convert_force_to_type(current_char:military_force(), "CHARACTER_BOUND_HORDE")
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
		"black_ark_lokhir_CharacterSackedSettlement",
		"CharacterSackedSettlement",
		function(context)
			return not context:character():is_null_interface() and context:character():character_subtype_key() == "wh2_dlc11_def_lokhir"
		end,
		function(context) 
			local cqi = context:character():command_queue_index()
			local rnd = cm:random_number(100)
			local settlement = context:garrison_residence():region():settlement()
			if settlement:is_port() and cm:random_number(cm:get_saved_value("black_ark_lokhir_replenish_action_points")) == 1 then
				cm:replenish_action_points("character_cqi:"..cqi)
			end
		end,
		true
	)	
end