function expCheat()
    local playerFaction = cm:get_faction(cm:get_local_faction(true));
    local characterList = playerFaction:character_list();
    for i = 0, characterList:num_items() - 1 do
        local currentChar = characterList:item_at(i);	
        local cqi = currentChar:cqi();
        cm:add_agent_experience(cm:char_lookup_str(cqi), 70000);
    end
end

function sm0_test()
    expCheat();
end