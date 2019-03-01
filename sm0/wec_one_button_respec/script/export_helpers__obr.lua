local llr = {}
llr.button = nil --:BUTTON

--v function(text: string)
function llr.log(text)
    if not __write_output_to_logfile then
        return
    end

    local logText = tostring(text)
    local logTimeStamp = os.date("%d, %m %Y %X")
    local popLog = io.open("warhammer_expanded_log.txt", "a")
    --# assume logTimeStamp: string
    popLog:write("LLR:  [" .. logTimeStamp .. "]:  " .. logText .. "  \n")
    popLog:flush()
    popLog:close()
end

--v function(cqi: CA_CQI)
local function are_you_sure(cqi)
    local ConfirmFrame = Frame.new("Respec?")
    ConfirmFrame:Resize(600, 400)
    Util.centreComponentOnScreen(ConfirmFrame)
    local ConfirmText = Text.new("confirm_txt", ConfirmFrame, "HEADER", "Would you like to fully respec this lord?")
    ConfirmText:Resize(420, 100)
    local ButtonYes = TextButton.new("confirm_yes", ConfirmFrame, "TEXT", "Yes")
    ButtonYes:SetState("hover")
    ButtonYes.uic:SetTooltipText("This can only be done once!")
    ButtonYes:SetState("active")
    ButtonYes:Resize(300, 45)
    local ButtonNo = TextButton.new("confirm_no", ConfirmFrame, "TEXT", "No")
    ButtonNo:SetState("hover")
    ButtonNo.uic:SetTooltipText("Cancel")
    ButtonNo:SetState("active")
    ButtonNo:Resize(300, 45)
    ConfirmFrame:AddComponent(ConfirmText)
    ConfirmFrame:AddComponent(ButtonYes)
    ConfirmFrame:AddComponent(ButtonNo)
    --v function()
    local function onYes()
        ConfirmFrame:Delete()
        --this is meant to be used to send a CQI, but it can take any integer!
        CampaignUI.TriggerCampaignScriptEvent(cqi, "LegendaryLordRespec")
    end
    ButtonYes:RegisterForClick(
        function()
            local ok, err = pcall(onYes)
            if not ok then
                llr.log("Error in reset function!")
                llr.log(tostring(err))
            end
        end
    )
    --v function()
    local function onNo()
        ConfirmFrame:Delete()
    end
    ButtonNo:RegisterForClick(
        function()
            onNo()
        end
    )
    Util.centreComponentOnComponent(ConfirmText, ConfirmFrame)
    local nudgeX, nudgeY = ConfirmText:Position()
    ConfirmText:MoveTo(nudgeX, nudgeY - 100)
    local offset = ConfirmText:Width() / 2
    local fY = ConfirmFrame:Height()
    ButtonYes:PositionRelativeTo(ConfirmText, offset - 150, 60)
    ButtonNo:PositionRelativeTo(ButtonYes, 0, 60)
end

--v function(cqi: CA_CQI)
function llr.create_button(cqi)
    local uic = find_uicomponent(core:get_ui_root(), "character_details_panel")
    if uic then
        if llr.button then
            llr.button:Delete()
        end
        llr.button = Button.new("RespecButtonLLR", uic, "CIRCULAR", "ui/skins/default/icon_home.png")
        local button_ok = find_uicomponent(core:get_ui_root(), "character_details_panel", "button_ok")
        llr.button:Resize(56, 56)
        llr.button:PositionRelativeTo(button_ok, llr.button:Width() - uic:Width() / 2, 0)
        local effects_window = find_uicomponent(core:get_ui_root(),"character_details_panel", "effects_parent", "campaign_effects_window")
        local effects_window_XPos = effects_window:Position()
        llr.button:MoveTo(effects_window_XPos + effects_window:Width() / 2 - llr.button:Width() / 2, llr.button:YPos())
        if cm:get_saved_value("llr_respec_" .. tostring(cqi)) then
            llr.button:SetDisabled(true)
            llr.button.uic:SetTooltipText("[[col:red]]You have already respec'd this lord. This cannot be done twice! [[/col]]")
        else
            llr.button:SetState("hover")
            llr.button.uic:SetTooltipText("[[col:green]]Respec your Lord. This can only be done once! [[/col]]")
            llr.button:SetState("active")
            llr.button:RegisterForClick(
                function(context)
                    local button_ok = find_uicomponent(core:get_ui_root(), "character_details_panel", "button_ok")
                    if button_ok then
                        button_ok:SimulateLClick()
                    end
                    are_you_sure(cqi)
                end
            )
        end
    end
end

--v function() --> CA_CQI
function getselectedCharCQI()
    local charCQI = cm:get_campaign_ui_manager():get_char_selected_cqi()
    local char = cm:get_character_by_cqi(charCQI)
    if char:has_military_force() then
        local unitsUIC = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "units")
        for i = 0, unitsUIC:ChildCount() - 1 do
            local uic_child = UIComponent(unitsUIC:Find(i));
            if uic_child:CurrentState() == "Selected" and string.find(uic_child:Id(), "Agent") then
                local charList = char:military_force():character_list()
                local agentIndex = string.match(uic_child:Id(), "%d")
                local selectedChar = charList:item_at(tonumber(agentIndex))
                charCQI = selectedChar:command_queue_index()
                break
            end     
        end
    end
    return charCQI
end

core:add_listener(
    "ml_cycleLeftLClickUp",
    "ComponentLClickUp",
    function(context)
        local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
        return (context.string == "button_cycle_right" or context.string == "button_cycle_left") and is_uicomponent(panel) and not cm:model():pending_battle():is_active()
    end,
    function(context)
        cm:callback(
            function(context)
                llr.current_lord = getselectedCharCQI()
                if llr.current_lord then llr.create_button(llr.current_lord) end
            end, 0, "waitForUI"
        )	
    end,
    true
)

core:add_listener(
    "ml_nextShortcutPressed",
    "ShortcutPressed",
    function(context)
        local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
        return (context.string == "select_next" or context.string == "select_prev") and is_uicomponent(panel) and not cm:model():pending_battle():is_active()
    end,
    function(context)
        cm:callback(
            function(context)
                llr.current_lord = getselectedCharCQI()
                if llr.current_lord then llr.create_button(llr.current_lord) end
            end, 0, "waitForUI"
        )		
    end,
    true
)

core:add_listener(
    "llr_PanelOpenedCampaign",
    "PanelOpenedCampaign",
    function(context)
        return context.string == "character_details_panel" and not cm:model():pending_battle():is_active()
    end,
    function(context)
        cm:callback(
            function(context)
                llr.current_lord = getselectedCharCQI()
                if llr.current_lord then llr.create_button(llr.current_lord) end
            end, 0, "waitForUI"
        )
    end,
    true
)

core:add_listener(
    "llr_PanelClosedCampaign",
    "PanelClosedCampaign",
    function(context)
        return context.string == "character_details_panel" and not cm:model():pending_battle():is_active()
    end,
    function(context)
        if llr.button then
            llr.button:Delete()
            llr.button = nil
        end
    end,
    true
)

core:add_listener(
    "Respec",
    "UITriggerScriptEvent",
    function(context)
        return context:trigger() == "LegendaryLordRespec"
    end,
    function(context)
        local cqi = context:faction_cqi() --: CA_CQI
        cm:set_saved_value("llr_respec_" .. tostring(cqi), true)
        cm:force_reset_skills(cm:char_lookup_str(cqi))
    end,
    true
)