-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- Spawn Zacharias and Genevieve from the start
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

function Why_Vampires_add()
	if cm:model():campaign_name("main_warhammer") then
		if cm:is_new_game() then
			cm:create_force_with_general(
				"wh2_main_vmp_necrarch_brotherhood",
				"wh_main_vmp_inf_zombie",
				"wh2_main_ash_river_springs_of_eternal_life",
				690,
				35,
				"general",
				"zacharias",
				"names_name_3330891160",
				"",
				"names_name_3330891161",
				"",
				false,
				function(cqi)
					-- cm:add_agent_experience(cm:char_lookup_str(cqi), 1000);
				end
			);
			cm:create_agent(
				"wh_main_emp_empire",
				"wizard",
				"genevieve",
				491,
				454,
				false,
				function(cqi)
					cm:force_add_trait(cm:char_lookup_str(cqi), "grudge_trait_name_dummy_genevieve", false);
					cm:replenish_action_points(cm:char_lookup_str(cqi));
				end
			);
		end;
	end;
end;


-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- LISTENERS
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

local dilemma = "why_lords_helsnicht_dilemma"
local lyonesse = "wh_main_lyonesse_lyonesse"

function Why_Lords_Listeners()

-- Mallobaude mission and spawn

	core:add_listener(
		"MalloMission",
		"FactionTurnStart",
		function(context) return context:faction():is_human() and context:faction():name() == "wh_main_vmp_mousillon" and cm:model():turn_number() == 2 end,
		function(context) cm:trigger_mission("wh_main_vmp_mousillon", "mallo_conquer_settlement", true) end, 		
		false
	);	
	
	core:add_listener(
        "WhySpawnMallo",
        "GarrisonOccupiedEvent",
        function(context)
            return ((context:garrison_residence():region():name() == lyonesse) and (context:character():faction():name() == "wh_main_vmp_mousillon"))
        end,
        function(context)
			if not cm:get_saved_value("mallo_spawn_only_one") then
		        cm:spawn_character_to_pool("wh_main_vmp_mousillon", "names_name_3330891147", "names_name_3330891148", "", "", 18, true, "general", "mallobaude", true, "");
				cm:show_message_event(
					"wh_main_vmp_mousillon",
					"event_feed_strings_text_wh_mallo_unlocked_title",
					"event_feed_strings_text_wh_unlocked_mallo_primary_detail",
					"event_feed_strings_text_wh_unlocked_mallo_secondary_detail",
					true,
					584
				);
				cm:set_saved_value("mallo_spawn_only_one", true);
			end;	
        end,
        false
    );	


-- Dieter Helsnicht dilemma and spawn
	
	core:add_listener(
		"HelsnichtDilemma",
		"FactionTurnStart",
		function(context) return context:faction():is_human() and context:faction():name() == "wh_main_vmp_vampire_counts" and cm:model():turn_number() == 16 end,
		function(context) cm:trigger_dilemma("wh_main_vmp_vampire_counts", dilemma, true) end, 		
		false
	);

    core:add_listener(
        "WhyHelsnichtDilemmaChoice",
        "DilemmaChoiceMadeEvent",
        function(context)
            return context:dilemma() == dilemma
        end,
        function(context)
            local choice = context:choice()

            if choice == 0 then
                cm:spawn_character_to_pool("wh_main_vmp_vampire_counts", "names_name_3330891143", "names_name_3330891144", "", "", 18, true, "general", "helsnicht", true, "");
				cm:show_message_event(
					"wh_main_vmp_vampire_counts",
					"event_feed_strings_text_wh_dieter_unlocked_title",
					"event_feed_strings_text_wh_dieter_unlocked_primary_detail",
					"event_feed_strings_text_wh_dieter_unlocked_secondary_detail",
					true,
					585
				);
            elseif choice == 1 then
				cm:create_force_with_general(
					"wh_main_vmp_vampire_counts",
					"wh_main_vmp_cav_black_knights_3,wh_main_vmp_cav_black_knights_1,wh_main_vmp_inf_skeleton_warriors_0,wh_main_vmp_inf_zombie",
					"wh_main_ostland_wolfenburg",
					551,
					575,
					"general",
					"helsnicht",
					"names_name_3330891143",
					"",
					"names_name_3330891144",
					"",
					false,
					function(cqi)
						-- cm:add_agent_experience(cm:char_lookup_str(cqi), 1000);
					end
				);
				cm:show_message_event(
					"wh_main_vmp_vampire_counts",
					"event_feed_strings_text_wh_dieter_unlocked_title",
					"event_feed_strings_text_wh_dieter_unlocked_primary_detail",
					"event_feed_strings_text_wh_dieter_unlocked_alt_secondary_detail",
					true,
					585
				);              
            end;
        end,
        false       	
	);

-- Konrad von Carstein	
	
	core:add_listener(
		"Why_Spawn_Konrad",
		"BuildingCompleted",
		function(context)
			local faction = context:garrison_residence():faction();
			
			return faction:name() == "wh_main_vmp_schwartzhafen";
		end,
		function(context)
			local building_name = context:building():name();
			local faction_name = context:garrison_residence():faction():name();
			local mallo_id = "why_konrad_"..cm:model():turn_number()..faction_name;	
			
			if building_name == "wh_pro02_VAMPIRES_isabella_unique" and not cm:get_saved_value("konrad_spawn_only_one") then
		        cm:spawn_character_to_pool("wh_main_vmp_schwartzhafen", "names_name_3330891145", "names_name_3330891145", "", "", 18, true, "general", "konrad", true, "");
				cm:show_message_event(
					"wh_main_vmp_schwartzhafen",
					"event_feed_strings_text_wh_konrad_unlocked_title",
					"event_feed_strings_text_wh_unlocked_konrad_primary_detail",
					"event_feed_strings_text_wh_unlocked_konrad_secondary_detail",
					true,
					586
				);
				cm:set_saved_value("konrad_spawn_only_one", true);
			end;
		end,
		true
	);	


-- Sycamo

	-- core:add_listener(
		--"Why_Sycamo",
		--"FactionTurnStart",
		--true,
		--function(context)
			--local faction = context:faction();
			--local faction_name = faction:name();
				
			--if context:faction():culture() == "wh_main_vmp_vampire_counts" and cm:model():campaign_name("main_warhammer") then
				--if not cm:get_saved_value("why_sycamo_spawned") then
					--if faction:holds_entire_province("wh_main_estalia", true) then
						--if faction:is_human() == true then	
							--cm:spawn_character_to_pool(faction_name, "names_name_3330891163", "names_name_3330891164", "", "", 18, true, "general", "sycamo", true, "");	
							--cm:show_message_event(
								--faction_name,
								--"event_feed_strings_text_syc_unlocked_title",
								--"event_feed_strings_text_syc_unlocked_primary_detail",
								--"event_feed_strings_text_syc_unlocked_secondary_detail",
								--true,
								--587
							--);
							--cm:set_saved_value("why_sycamo_spawned", true);						
						--end;							
					--end;
				--end;
			--end;
		--end,
		--true
	--);	
end;

cm.first_tick_callbacks[#cm.first_tick_callbacks+1] =
function(context) 
	Why_Vampires_add();
	Why_Lords_Listeners();
end