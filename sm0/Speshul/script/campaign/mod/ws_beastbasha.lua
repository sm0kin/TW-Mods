function ws_beastbasha()
    if not cm:get_saved_value("ws_beastbasha_dilemma") then
        core:add_listener(
            "ws_beastbasha_FactionJoinsConfederation",
            "FactionJoinsConfederation",
            function(context)
                return context:confederation():subculture() == "wh_main_sc_grn_savage_orcs"
            end,
            function(context)
                -- save faction key if beastbasha was confederated into another faction (in case a mod enables savage orc confederations)
                local char_list = context:confederation():character_list()
                for i = 0, char_list:num_items() - 1 do
                    local current_char = char_list:item_at(i)
                    if current_char:character_subtype("ws_grn_grak_beastbasha") then
                        cm:set_saved_value("ws_beastbasha_confederation", context:confederation():name())
                    end
                end
            end,
            true
        )
        core:add_listener(
            "ws_beastbasha_FactionTurnStart",
            "FactionTurnStart",
            function(context)
                return cm:model():turn_number() >= 2 and context:faction():is_human() and context:faction():subculture() == "wh_main_sc_grn_greenskins"
            end,
            function(context)
                local human_faction = context:faction()
                -- find beastbasha's faction and determine if it's dead         
                local beastbasha_faction = cm:get_faction("wh2_main_grn_blue_vipers")
                local savage_orc_confederation = cm:get_saved_value("ws_beastbasha_confederation")
                if savage_orc_confederation then
                    beastbasha_faction = cm:get_faction(savage_orc_confederation)
                end

                if beastbasha_faction and beastbasha_faction:is_dead() then
                    -- if his faction is_dead revive it somewhere (ME 90, 252 | VOR 109, 287)
                    local x, y = 109, 287 -- vortex
                    local starting_region = "wh2_main_vor_jungles_of_green_mist_spektazuma" -- vortex
                    if cm:model():campaign_name("main_warhammer") then
                        x, y = 90, 252
                        starting_region = "wh2_main_southern_jungle_of_pahualaxa_the_high_sentinel"
                    end
                    local beastbasha
                    cm:create_force(
                        beastbasha_faction:name(),
                        "wh_main_grn_inf_savage_orcs",
                        starting_region,
                        x,
                        y,
                        true,
                        function(cqi)
                            beastbasha = beastbasha_faction:faction_leader()
                            if not beastbasha:character_subtype("ws_grn_grak_beastbasha") then
                                local char_list = beastbasha_faction:character_list()
                                for i = 0, char_list:num_items() - 1 do
                                    local current_char = char_list:item_at(i)
                                    if current_char:character_subtype("ws_grn_grak_beastbasha") then
                                        beastbasha = current_char
                                    end
                                end
                            end
                            core:add_listener(
                                "ws_beastbasha_DilemmaChoiceMadeEvent",
                                "DilemmaChoiceMadeEvent",
                                function(context)
                                    return context:dilemma():starts_with("ws_beastbasha")
                                end,
                                function(context)
                                    local choice = context:choice()
                                    if choice == 0 then
                                        -- delete beastbasha from ai faction and spawn him to human recruitment pool 
                                        cm:set_character_immortality(cm:char_lookup_str(beastbasha:command_queue_index()), false)
                                        cm:kill_character(beastbasha:command_queue_index())
                                        cm:spawn_character_to_pool(context:faction():name(), "names_name_2020000", "names_name_2020001", "", "", 18, true, "general", "ws_grn_grak_beastbasha", true, "")
                                        cm:set_saved_value("ws_beastbasha_dilemma", 0)
                                    else -- choice == 1
                                        cm:set_saved_value("ws_beastbasha_dilemma", 1)
                                    end                                  
                                    core:remove_listener("ws_beastbasha_FactionTurnStart")
                                    core:remove_listener("ws_beastbasha_FactionJoinsConfederation")
                                    kill_faction(beastbasha_faction:name())
                                end,
                                false
                            )
                            cm:trigger_dilemma_with_targets(human_faction:command_queue_index(), "ws_beastbasha", beastbasha_faction:command_queue_index())
                        end,
                        true
                    )
                end
            end,
            true
        )
    elseif cm:get_saved_value("ws_beastbasha_dilemma") == 0 then
        core:add_listener(
            "ws_beastbasha_backup_CharacterCreated",
            "CharacterCreated",
            function(context)
                return context:character():character_subtype_key() == "ws_grn_grak_beastbasha" and not context:character():faction():is_human()
            end,
            function(context) 
                cm:set_character_immortality(cm:char_lookup_str(context:character():command_queue_index()), false)
                cm:kill_character(context:character():command_queue_index())            
            end,
            true
        )
    end
end
