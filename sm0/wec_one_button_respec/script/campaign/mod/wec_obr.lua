local llr = {}
llr.button = nil --:BUTTON
--# assume llr.enable: WHATEVER
--# assume llr.limit: WHATEVER
--# assume llr.en_cost: WHATEVER
--# assume llr.cost: WHATEVER

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
    ConfirmFrame:Resize(600, 300)
    Util.centreComponentOnScreen(ConfirmFrame)
    local parchment = find_uicomponent(ConfirmFrame.uic, "parchment")
    local fX, fY = ConfirmFrame.uic:Position()
    local fW, fH = ConfirmFrame.uic:Bounds()
    local pW, pH = parchment:Bounds()
    local gapX, gapY = fW - pW, fH - pH
    parchment:MoveTo(fX + gapX/2, fY + gapY/2)
    local ConfirmText = Text.new("confirm_txt", ConfirmFrame, "HEADER", "Would you like to fully respec this character?")
    ConfirmText:Resize(420, 100)
    tW, tH = ConfirmText:Bounds()
    local ButtonYes = TextButton.new("confirm_yes", ConfirmFrame, "TEXT", "Yes")
    local char = cm:get_character_by_cqi(cqi)
    if llr.en_cost == "enabled" or (llr.en_cost == "firstforfree" and cm:get_saved_value("llr_respec_" .. tostring(cqi))) then
        local respec_cost = (char:rank() - 1) * llr.cost
        if respec_cost <= char:faction():treasury() then
            ButtonYes:SetState("hover")
            ButtonYes.uic:SetTooltipText("Respeccing this character would cost you: "..respec_cost.."[[img:icon_money]]!", "", false)
            ButtonYes:SetState("active")
        else
            ButtonYes:SetDisabled(true)
            ButtonYes.uic:SetTooltipText("[[col:red]]You don't have enough funds![[/col]] \n Respeccing this character would cost you: "..respec_cost.."[[img:icon_money]]", "", false)
        end
    else
        ButtonYes:SetState("hover")
        ButtonYes.uic:SetTooltipText("Respec your lord/hero.", "", false)
        ButtonYes:SetState("active")
    end
    if char:rank() == 1 then
        ButtonYes:SetDisabled(true)
        ButtonYes.uic:SetTooltipText("No skill points allocated.", "", false)
    end
    ButtonYes:Resize(300, 45)
    local ButtonNo = TextButton.new("confirm_no", ConfirmFrame, "TEXT", "No")
    ButtonNo:SetState("hover")
    ButtonNo.uic:SetTooltipText("Cancel", "", true)
    ButtonNo:SetState("active")
    ButtonNo:Resize(300, 45)
    ConfirmFrame:AddComponent(ConfirmText)
    ConfirmFrame:AddComponent(ButtonYes)
    ConfirmFrame:AddComponent(ButtonNo)
    --v function()
    local function onYes()
        ConfirmFrame:Delete()
        --this is meant to be used to send a CQI, but it can take any integer!
        CampaignUI.TriggerCampaignScriptEvent(cqi, "LegendaryLordRespec|" ..llr.en_cost.."<"..tostring(llr.cost))
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
    Util.centreComponentOnComponent(ConfirmText, parchment)
    local tX, tY = ConfirmText:Position()
    ConfirmText:MoveTo(tX, tY - tH/2)
    ButtonYes:PositionRelativeTo(ConfirmText, tW/2 - 150, 60)
    ButtonNo:PositionRelativeTo(ButtonYes, 0, 60)
end

--v function(cqi: CA_CQI)
function llr.create_button(cqi)
    local character_details_panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
    if character_details_panel then
        if llr.button then
            llr.button:Delete()
        end
        local char = cm:get_character_by_cqi(cqi)

        local icon_path = effect.get_skinned_image_path("icon_home.png")

        llr.button = Button.new("RespecButtonLLR", character_details_panel, "CIRCULAR", icon_path)
        local button_ok = find_uicomponent(core:get_ui_root(), "character_details_panel", "button_ok")
        local bW, bH = button_ok:Bounds()
        llr.button:Resize(bW, bH)
        llr.button:PositionRelativeTo(button_ok, llr.button:Width() - character_details_panel:Width() / 2, 0)
        local effects_window = find_uicomponent(core:get_ui_root(),"character_details_panel", "effects_parent", "campaign_effects_window")
        local effects_window_XPos = effects_window:Position()
        llr.button:MoveTo(effects_window_XPos + effects_window:Width() / 2 - llr.button:Width() / 2, llr.button:YPos())
        if llr.en_cost ~= "disabled" then
            if cm:get_saved_value("llr_respec_" .. tostring(cqi)) and llr.limit then
                llr.button:SetDisabled(true)
                llr.button.uic:SetTooltipText("[[col:red]]You have already respec'd this character. This cannot be done twice! [[/col]]", "", false)
            else
                llr.button:SetState("hover")
                llr.button.uic:SetTooltipText("[[col:green]]Respec your lord/hero. This can only be done once! [[/col]]", "", false)
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
        else
            llr.button:SetState("hover")
            llr.button.uic:SetTooltipText("[[col:green]]Respec your lord/hero. [[/col]]", "", false)
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
local function get_selected_char_CQI()
    local charCQI = cm:get_campaign_ui_manager():get_char_selected_cqi()
    local char = cm:get_character_by_cqi(charCQI)
    if char:has_military_force() then
        local unitsUIC = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "units")
        for i = 0, unitsUIC:ChildCount() - 1 do
            local uic_child = UIComponent(unitsUIC:Find(i))
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

--v function(enable_value: WHATEVER)
local function init_obr_listeners(enable_value)
    core:remove_listener("abadon_region_PanelOpenedCampaign")
    core:remove_listener("abadon_region_PanelClosedCampaign")
    core:remove_listener("abadon_region_SettlementSelected")
    core:remove_listener("abadon_region_UITriggerScriptEvent")
    if enable_value then
        core:add_listener(
            "obr_cycle_LeftLClickUp",
            "ComponentLClickUp",
            function(context)
                local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
                return (context.string == "button_cycle_right" or context.string == "button_cycle_left") and is_uicomponent(panel) and not cm:model():pending_battle():is_active()
            end,
            function(context)
                cm:callback(
                    function(context)
                        llr.current_lord = get_selected_char_CQI()
                        if llr.current_lord then llr.create_button(llr.current_lord) end
                    end, 0, "waitForUI"
                )	
            end,
            true
        )

        core:add_listener(
            "obr_next_ShortcutPressed",
            "ShortcutPressed",
            function(context)
                local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
                return (context.string == "select_next" or context.string == "select_prev") and is_uicomponent(panel) and not cm:model():pending_battle():is_active()
            end,
            function(context)
                cm:callback(
                    function(context)
                        llr.current_lord = get_selected_char_CQI()
                        if llr.current_lord then llr.create_button(llr.current_lord) end
                    end, 0, "waitForUI"
                )		
            end,
            true
        )

        core:add_listener(
            "obr_PanelOpenedCampaign",
            "PanelOpenedCampaign",
            function(context)
                return context.string == "character_details_panel" and not cm:model():pending_battle():is_active()
            end,
            function(context)
                cm:callback(
                    function(context)
                        llr.current_lord = get_selected_char_CQI()
                        if llr.current_lord then llr.create_button(llr.current_lord) end
                    end, 0, "waitForUI"
                )
            end,
            true
        )

        core:add_listener(
            "obr_PanelClosedCampaign",
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
            "obr_UITriggerScriptEvent",
            "UITriggerScriptEvent",
            function(context)
                return context:trigger() == "LegendaryLordRespec|"
            end,
            function(context)
                local str = context:trigger() --:string
                local info = string.gsub(str, "LegendaryLordRespec|", "")
                local en_cost_end = string.find(info, "<")
                local en_cost = string.sub(info, 1, en_cost_end - 1)
                local cost = string.sub(info, en_cost_end + 1)   

                local cqi = context:faction_cqi() --: CA_CQI
                local char = cm:get_character_by_cqi(cqi)
                if en_cost or (en_cost == "firstforfree" and cm:get_saved_value("llr_respec_" .. tostring(cqi))) then
                    local respec_cost = (char:rank() - 1) * tonumber(cost)
                    if respec_cost <= char:faction():treasury() then
                        cm:treasury_mod(char:faction():name(), -1*respec_cost)
                        cm:set_saved_value("llr_respec_" .. tostring(cqi), true)
                        cm:force_reset_skills(cm:char_lookup_str(cqi))
                    end
                else
                    cm:set_saved_value("llr_respec_" .. tostring(cqi), true)
                    cm:force_reset_skills(cm:char_lookup_str(cqi))
                end
            end,
            true
        )
    end
end

core:add_listener(
    "obr_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        local mct = get_mct()
        local obr_mod = mct:get_mod_by_key("obr")
        --local settings_table = obr_mod:get_settings() 
        --llr.enable = settings_table.a_enable
        --llr.limit = settings_table.a_limit
        --llr.en_cost = settings_table.b_en_cost
        --llr.cost = settings_table.c_cost

        local a_enable = obr_mod:get_option_by_key("a_enable")
        llr.enable = a_enable:get_finalized_setting()
        local a_limit = obr_mod:get_option_by_key("a_limit")
        llr.limit = a_limit:get_finalized_setting()
        local b_en_cost = obr_mod:get_option_by_key("b_en_cost")
        llr.en_cost = b_en_cost:get_finalized_setting()
        --local c_cost = obr_mod:get_option_by_key("c_cost")
        --llr.cost = c_cost:get_finalized_setting()
   
        llr.log("obr_MctInitialized/llr.enable = "..tostring(llr.enable))
        llr.log("obr_MctInitialized/llr.limit = "..tostring(llr.limit))
        llr.log("obr_MctInitialized/llr.en_cost = "..tostring(llr.en_cost))
        --llr.log("obr_MctInitialized/llr.cost = "..tostring(llr.cost))
    end,
    true
)

core:add_listener(
    "obr_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        local mct = get_mct()
        local obr_mod = mct:get_mod_by_key("obr")
        local settings_table = obr_mod:get_settings() 
        llr.enable = settings_table.a_enable
        llr.limit = settings_table.a_limit
        llr.en_cost = settings_table.b_en_cost
        --llr.cost = settings_table.c_cost
        
        init_obr_listeners(llr.enable)
    end,
    true
)

function wec_obr()
    local mcm = _G.mcm
    local mct = core:get_static_object("mod_configuration_tool")

    if mct and not cm:is_multiplayer() then
        -- MCT new --
    else
        llr.enable = true
        if cm:get_saved_value("mcm_tweaker_obr_limit_value") ~= "disabled" then
            llr.limit = true
        else
            llr.limit = false
        end
        llr.en_cost = cm:get_saved_value("mcm_tweaker_obr_en_cost_value") or "disabled"
        llr.cost = cm:get_saved_value("mcm_variable_obr_cost_value") or 200

        -- MCT old --
        if not not mcm then
            local obr = mcm:register_mod("obr", "One Button Respec", "Allows the player respec lords & heroes.")
            local limit = obr:add_tweaker("limit","Respec Limit", "Limits the number of respecs per character.")
            limit:add_option("enabled", "Enable", "Only one respec per lord or hero.")
            limit:add_option("disabled", "Disable", "Unlimited respecs.")
            local en_cost = obr:add_tweaker("en_cost", "Respec Cost", "Decide whether respecs are free or not.")
            en_cost:add_option("disabled", "Disable", "Disable respec cost.")
            en_cost:add_option("firstforfree", "Free 1st Respec", "Respeccing a Character is free the 1st time.")
            en_cost:add_option("enabled", "Enable", "Respeccing always entails costs.")
            local cost = obr:add_variable("cost", 100, 1000, 500, 100, "Respec Cost per level:", "Decide on the respec cost per character level.")
            mcm:add_new_game_only_callback(
                function()
                    if cm:get_saved_value("mcm_tweaker_obr_limit_value") ~= "disabled" then
                        llr.limit = true
                    else
                        llr.limit = false
                    end
                    llr.en_cost = cm:get_saved_value("mcm_tweaker_obr_en_cost_value") or "disabled"
                    llr.cost = cm:get_saved_value("mcm_variable_obr_cost_value") or 200
                end
            )
        end
    end
    init_obr_listeners(llr.enable)
end