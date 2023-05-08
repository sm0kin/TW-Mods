cm:add_first_tick_callback(
	function()
		if cm:get_saved_value("hkrul_pg_enabled") == nil then
			cm:add_faction_turn_start_listener_by_name(
				"hkrul_pg_hero_listener",
				"wh_main_emp_marienburg",
				function(context)
					if cm:get_saved_value("hkrul_pg_enabled") == nil then
						core:add_listener(
							"hkrul_pg_hero_listener_UniqueAgentSpawned",
							"UniqueAgentSpawned",
							function(context)
								return context:unique_agent_details():character():character_subtype_key() == "hkrul_pg"
							end,
							function(context)
								local character = context:unique_agent_details():character()
								local lookup_str = cm:char_lookup_str(character)
								
								cm:replenish_action_points(lookup_str)
							end,
							false
						)
                        local faction = context:faction();                                    
                        local empire_interface = cm:model():world():faction_by_key(faction:name());
                        local empire_faction_cqi = empire_interface:command_queue_index();  
                        cm:spawn_unique_agent(empire_faction_cqi,"hkrul_pg",true);
                        cm:set_saved_value("hkrul_pg_enabled", true);                                                                                           
					end
				end,	
				true
			)
		end
	end
)
