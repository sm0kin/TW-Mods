function ws_beastbasha()
    -- when his faction is_dead revive his faction somewhere (ME 90, 252 | VOR 109, 287)
    -- kill him and his faction
    -- trigger dilemma for the player
    if not cm:get_saved_value("ws_beastbasha_dilemma") then
        core:add_listener(
            "ws_beastbasha_FactionJoinsConfederation",
            "FactionJoinsConfederation",
            function(context)
                return context:confederation():subculture() == "wh_main_sc_grn_savage_orcs"
            end,
            function(context)
                local char_list = context:confederation():character_list()
                for i = 0, char_list:num_items() - 1 do
                    local current_char = char_list:item_at(i)
                    out("current_char = "..current_char:character_subtype_key())

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
                return cm:model():turn_number() >= 1 and context:faction():is_human() and context:faction():subculture() == "wh_main_sc_grn_greenskins"
            end,
            function(context)
                out("ws_beastbasha_FactionTurnStart")

                if cm:model():turn_number() == 2 then
                    kill_faction("wh2_main_grn_blue_vipers")
                    kill_faction("wh_dlc03_bst_beastmen")
                end
                -- find beastbasha's faction and determine if it's dead         
                local beastbasha_faction = cm:get_faction("wh2_main_grn_blue_vipers")
                if cm:get_saved_value("ws_beastbasha_confederation") then
                    beastbasha_faction = cm:get_faction(cm:get_saved_value("ws_beastbasha_confederation"))
                end

                if beastbasha_faction then
                    out("beastbasha_faction = "..beastbasha_faction:name())
                    local beastbasha --= beastbasha_faction:faction_leader()
                    --out("beastbasha = "..tostring(beastbasha:character_subtype_key()))
                    out("beastbasha_faction:is_dead() = "..tostring(beastbasha_faction:is_dead()))

                    local char_list = beastbasha_faction:character_list()
                    for i = 0, char_list:num_items() - 1 do
                        local current_char = char_list:item_at(i)
                        out("current_char = "..current_char:character_subtype_key())

                        if current_char:character_subtype("ws_grn_grak_beastbasha") then
                            beastbasha_faction = current_char:faction()
                            out("beastbasha_faction2 = "..beastbasha_faction:name())
                            beastbasha = current_char
                            out("beastbasha = "..beastbasha:character_subtype_key())

                        end
                    end

                    local bst = cm:get_faction("wh_dlc03_bst_beastmen")
                    local char_list = bst:character_list()
                    for i = 0, char_list:num_items() - 1 do
                        local current_char = char_list:item_at(i)
                        out("current_char = "..current_char:character_subtype_key())

                    end

                    if not beastbasha:character_subtype("ws_grn_grak_beastbasha") then
                        local faction_list = beastbasha_faction:factions_of_same_subculture()
                        for i = 0, faction_list:num_items() - 1 do
                            local current_faction = faction_list:item_at(i)            
                            local char_list = current_faction:character_list()
                            for j = 0, char_list:num_items() - 1 do
                                local current_char = char_list:item_at(j)
                                if current_char:character_subtype("ws_grn_grak_beastbasha") then
                                    beastbasha_faction = current_char:faction()
                                    out("beastbasha_faction2 = "..beastbasha_faction:name())
                                    beastbasha = current_char
                                end
                            end
                        end
                    end
                    out("beastbasha = "..beastbasha:character_subtype_key())
                    out("beastbasha_faction:is_dead() = "..tostring(beastbasha_faction:is_dead()))

                    if beastbasha:character_subtype("ws_grn_grak_beastbasha") and beastbasha_faction:is_dead() then
                        out("trigger_dilemma_with_targets")
                        core:add_listener(
                            "ws_beastbasha_DilemmaChoiceMadeEvent",
                            "DilemmaChoiceMadeEvent",
                            function(context)
                                return context:dilemma():starts_with("ws_beastbasha")
                            end,
                            function(context)
                                out("ws_beastbasha_DilemmaChoiceMadeEvent")
                                local choice = context:choice()
                                if choice == 0 then
                                    -- delete beastbasha from ai faction and spawn him to human recruitment pool 
                                    cm:set_character_immortality(cm:char_lookup_str(beastbasha:command_queue_index()), false)
                                    cm:kill_character(beastbasha:command_queue_index())
                                    cm:spawn_character_to_pool(context:faction():name(), "names_name_2020000", "names_name_2020001", "", "", 18, true, "general", "ws_grn_grak_beastbasha", true, "")
                                else -- choice == 1
                                    -- do nothing
                                end
                                cm:set_saved_value("ws_beastbasha_dilemma", true)
                                core:remove_listener("ws_beastbasha_FactionTurnStart")
                            end,
                            false
                        )
                        cm:trigger_dilemma_with_targets(context:faction():command_queue_index(), "ws_beastbasha", beastbasha_faction:command_queue_index())
                    end
                end
            end,
            true
        )
    end
end
