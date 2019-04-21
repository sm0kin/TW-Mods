function frosty_horde()
    if cm:is_new_game() then 
        local factionList = cm:model():world():faction_list();
        for i = 0, factionList:num_items() - 1 do
            local currentFaction = factionList:item_at(i);
            if currentFaction and currentFaction:is_human() and currentFaction:culture() == "wh_main_chs_chaos" then
                local characterList = currentFaction:character_list();
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j);
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index();
                        cm:add_building_to_force(mfCQI, "wh_main_horde_chaos_settlement_4"); 
                    end
                end
            elseif currentFaction and currentFaction:is_human() and currentFaction:culture() == "wh_dlc03_bst_beastmen" then
                local characterList = currentFaction:character_list();
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j);
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index();
                        cm:add_building_to_force(mfCQI, "wh_dlc03_horde_beastmen_herd_4"); 
                    end
                end
            elseif currentFaction and currentFaction:is_human() and currentFaction:culture() == "wh2_dlc11_cst_vampire_coast" then
                local characterList = currentFaction:character_list();
                for j = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(j);
                    if currentChar and currentChar:has_military_force() then
                        local mfCQI = currentChar:military_force():command_queue_index();
                        cm:add_building_to_force(mfCQI, "wh2_dlc11_vampirecoast_ship_captains_cabin_4"); 
                    end
                end
            end
        end
    end
end