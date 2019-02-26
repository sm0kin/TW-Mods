events = get_events();

function Supreme_vauls_anvil()
	local human_factions = cm:get_human_factions();
	for i = 1, #human_factions do
		local current_human_faction = cm:get_faction(human_factions[i]);
		if current_human_faction:culture() == "wh2_main_hef_high_elves" and not cm:get_saved_value("supreme_forge_one") then
			cm:faction_add_pooled_resource(current_human_faction:name(), "tmb_canopic_jars", "wh2_main_resource_factor_other", 9999);
			cm:set_saved_value("supreme_forge_one", true);		
		end
	end
end

cm.first_tick_callbacks[#cm.first_tick_callbacks+1] = function(context)
	Supreme_vauls_anvil();
end