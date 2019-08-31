local v_debug_mode = false;
local chaos_separatists_faction_str = "wh_main_chs_chaos_separatists";


function init()
	core:add_listener(
		"lord_of_change_defeated",
		"BattleCompleted",
		function()
			local loc_faction = cm:get_faction(chaos_separatists_faction_str);
			
			return (loc_faction:faction_leader():is_null_interface() or not loc_faction:faction_leader():has_military_force()) and cm:pending_battle_cache_faction_is_involved(chaos_separatists_faction_str);
		end,
		function(context)			
			if not cm:get_saved_value("sarthorael_unlocked") then 
				cm:spawn_character_to_pool("wh_main_chs_chaos", "names_name_2147357518", "", "", "", 18, true, "general", "chs_lord_of_change", true, "");    
				cm:set_saved_value("sarthorael_unlocked", true);
			end;    
		end,
		false
	);

end

init();