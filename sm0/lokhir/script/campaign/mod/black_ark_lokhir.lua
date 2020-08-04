--local building_list = {}

local function get_horde_buildings_from_ui()
	local building_list = {}
	local settlement_parent = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "horde_building_frame", "settlement_parent")
	if settlement_parent then 
		for i = 0, settlement_parent:ChildCount() - 1 do
			local settlement_child = UIComponent(settlement_parent:Find(i))
			if string.find(settlement_child:Id(), "building_slot_") then 
				for j = 0, settlement_child:ChildCount() - 1 do
					local building = UIComponent(settlement_child:Find(j))
					table.insert(building_list, building:Id()) 					
				end
			end
		end
	end
	if building_list == nil then out("ERROR | building_list == nil") end
	return building_list
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
					cm:convert_force_to_type(current_char:military_force(), "CHARACTER_BOUND_HORDE")
					cm:set_saved_value("black_ark_lokhir", true)
				end
			end      
		end
	end

	core:add_listener(
		"black_ark_lokhir_CharacterFinishedMovingEvent",
		"CharacterFinishedMovingEvent",
		function(context)
			local current_faction = cm:whose_turn_is_it()
			return context:character():character_subtype("wh2_dlc11_def_lokhir") and current_faction == context:character():faction():name()
		end,
		function(context)
			local building_list = {}
			out("sm0/CharacterFinishedMovingEvent")
			building_list = get_horde_buildings_from_ui()
			if context:character():is_at_sea() then
				out("sm0/CharacterFinishedMovingEvent/is_at_sea")
				cm:convert_force_to_type(context:character():military_force(), "SEA_LOCKED_HORDE")
				cm:add_building_to_force(context:character():military_force():command_queue_index(), building_list)
			end
			if context:character():garrison_residence():has_army() then
				out("sm0/CharacterFinishedMovingEvent/has_army")
			end
			if context:character():garrison_residence():has_navy() then
				out("sm0/CharacterFinishedMovingEvent/has_navy")
				cm:convert_force_to_type(context:character():military_force(), "CHARACTER_BOUND_HORDE")
				cm:add_building_to_force(context:character():military_force():command_queue_index(), building_list)			
			end
		end,
		true
	)
	--core:add_listener(
	--	"black_ark_lokhir_BMilitaryForceBuildingCompleteEvent",
	--	"MilitaryForceBuildingCompleteEvent",
	--	function(context)
	--		return context:character():character_subtype("wh2_dlc11_def_lokhir")
	--	end,
	--	function(context)
	--		out("sm0/MilitaryForceBuildingCompleteEvent/"..tostring(context:building()))
	--		table.insert(building_list, context:building())
	--	end,
	--	true
	--)
end


-- can't remove buildings ...
--cm:add_saving_game_callback(
--	function(context)
--		cm:save_named_value("black_ark_lokhir_building_list", building_list, context);
--	end
--)
--
--cm:add_loading_game_callback(
--	function(context)
--		if not cm:is_new_game() then
--			building_list = cm:load_named_value("black_ark_lokhir_building_list", building_list, context)
--		end
--	end
--)