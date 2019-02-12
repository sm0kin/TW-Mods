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
end