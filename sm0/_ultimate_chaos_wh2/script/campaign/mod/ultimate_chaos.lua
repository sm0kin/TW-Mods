local wizardbuttons = {"chs_chaos_sorcerer_death", "chs_chaos_sorcerer_fire", "chs_chaos_sorcerer_metal", "dlc07_chs_chaos_sorcerer_shadow"}

function hideWizardButtons()
    cm:callback(
        function(context)
            for _, wizardbutton in ipairs(wizardbuttons) do
                local button = find_uicomponent(core:get_ui_root(), "character_panel", "agent_parent", "wizard_type", "type_list", wizardbutton);
                if button then button:SetVisible(false); end
            end
        end, 0, "waitForUI"
    );
end

function addChaosHordeBuildings()
    local factionList = cm:model():world():faction_list();
    for i = 0, factionList:num_items() - 1 do
        local currentFaction = factionList:item_at(i);
        if currentFaction and currentFaction:culture() == "wh_main_chs_chaos" then
            local characterList = currentFaction:character_list();
            for j = 0, characterList:num_items() - 1 do
                local currentChar = characterList:item_at(j);
                if currentChar and currentChar:has_military_force() then
                    local mfCQI = currentChar:military_force():command_queue_index();
                    cm:add_building_to_force(mfCQI, "_steel_cult_1");
                end
            end
        end
    end
end

function ultimate_chaos()
    local playerFaction = cm:get_faction(cm:get_local_faction(true));
    if playerFaction:culture() == "wh_main_chs_chaos" then
        core:add_listener(
            "wizardComponentLClickUp",
            "ComponentLClickUp",
            function(context)
                return (context.string == "button_agents" or context.string == "wizard" or context.string == "button_cycle_right" or context.string == "button_cycle_left");
            end,
            function(context)
                hideWizardButtons();
            end,
            true
        );
        core:add_listener(
            "ml_nextShortcutPressed",
            "ShortcutPressed",
            function(context)
                return (context.string == "select_next" or context.string == "select_prev");
            end,
            function(context)
                hideWizardButtons();	
            end,
            true
        );
    end
    if cm:is_new_game() then
        addChaosHordeBuildings();
    end
end