
cm = get_cm(); events = get_events();
function new_lokhir()
    local blesseddread = cm:get_faction("wh2_dlc11_def_the_blessed_dread")
    if cm:is_new_game() then
        local lokhir
        local character_list = blesseddread:character_list()
        for i = 0, character_list:num_items() - 1 do
            local char = character_list:item_at(i)
            if char:character_subtype("wh2_dlc11_def_lokhir") then
                lokhir = char
            end
        end
        local lokhir_cqi = blesseddread:faction_leader():command_queue_index()
        local lokhir_str = cm:char_lookup_str(lokhir_cqi)
        core:add_listener(
            "FactionTurnEnd",
            "FactionTurnEnd",
            function(context)		
                return true; --cm:turn_number() == 1; 
            end,
            function(context)
                core:add_listener(
                    "event_appoint_new_general",
                    "PanelOpenedCampaign",
                    function(context)		
                        return context.string == "event_appoint_new_general"; 
                    end,
                    function(context)
                        cm:disable_event_feed_events(true, "", "wh_event_subcategory_agent_recruited", "");
                        local hireButton = find_uicomponent(core:get_ui_root(), "panel_manager", "appoint_new_general", "event_appoint_new_general", "button_hire");
                        hireButton:SimulateLClick();
                    end,
                    false
                );
                core:add_listener(
                    "event_appoint_new_general",
                    "ScriptEventPlayerFactionCharacterCreated",
                    function(context)		
                        return context:character():faction():is_human(); 
                    end,
                    function(context)
                        --cm:set_saved_value("lokhirReplacementChar", context:character():name()); --save char name
                    end,
                    false
                );
                
                cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_deaths", "");
                cm:wound_character(cm:char_lookup_str(lokhirCQI), 1, true);
                cm:callback(function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_deaths", "") end, 1);
                cm:treasury_mod(blesseddread, 825);
                core:add_listener(
                    "FactionNextTurnStart",
                    "FactionTurnStart",
                    function(context)		
                        return true; --cm:turn_number() == 2; 
                    end,
                    function(context)
                        cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_development", "");                        
                        -- load saved value
                        -- select replacement lord
                        -- simulateclick char panel
                        -- simulateclick replace lord
                        -- simuateclick lokhir
                        -- simulateclick replace
                        cm:callback(function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_agent_recruited", "") end, 1);
                        cm:callback(function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_development", "") end, 1);

                    end,
                    false
                );
            end,
            false
        );
    end
end


--local blesseddread = cm:get_faction("wh2_dlc11_def_the_blessed_dread");
--local lokhirCQI = blesseddread:faction_leader():command_queue_index();
--cm:apply_effect_bundle_to_characters_force("wh_dlc08_bundle_god_bar_nurgle_2", lokhirCQI, -1, false);
--cm:wound_character(cm:char_lookup_str(lokhirCQI), 0, true);