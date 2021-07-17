local llr = {}
--# assume llr.enable: WHATEVER
--# assume llr.limit: WHATEVER
--# assume llr.en_cost: WHATEVER
--# assume llr.cost: WHATEVER

local names_of_power_traits = {
    "wh2_main_trait_def_name_of_power_co_01_blackstone",
    "wh2_main_trait_def_name_of_power_co_02_wyrmscale",
    "wh2_main_trait_def_name_of_power_co_03_poisonblade",
    "wh2_main_trait_def_name_of_power_co_04_headreaper",
    "wh2_main_trait_def_name_of_power_co_05_spiteheart",
    "wh2_main_trait_def_name_of_power_co_06_soulblaze",
    "wh2_main_trait_def_name_of_power_co_07_bloodscourge",
    "wh2_main_trait_def_name_of_power_co_08_griefbringer",
    "wh2_main_trait_def_name_of_power_co_09_the_hand_of_wrath",
    "wh2_main_trait_def_name_of_power_co_10_fatedshield",
    "wh2_main_trait_def_name_of_power_co_11_drakecleaver",
    "wh2_main_trait_def_name_of_power_co_12_hydrablood",
    "wh2_main_trait_def_name_of_power_ar_01_lifequencher",
    "wh2_main_trait_def_name_of_power_ar_02_the_tempest_of_talons",
    "wh2_main_trait_def_name_of_power_ar_03_shadowdart",
    "wh2_main_trait_def_name_of_power_ar_04_barbstorm",
    "wh2_main_trait_def_name_of_power_ar_05_beastbinder",
    "wh2_main_trait_def_name_of_power_ar_06_fangshield",
    "wh2_main_trait_def_name_of_power_ar_07_wrathbringer",
    "wh2_main_trait_def_name_of_power_ar_08_moonshadow",
    "wh2_main_trait_def_name_of_power_ar_09_granitestance",
    "wh2_main_trait_def_name_of_power_ar_10_the_grey_vanquisher",
    "wh2_main_trait_def_name_of_power_ar_11_krakenclaw",
    "wh2_main_trait_def_name_of_power_ar_12_grimgaze",
    "wh2_main_trait_def_name_of_power_ca_01_dreadtongue",
    "wh2_main_trait_def_name_of_power_ca_02_darkpath",
    "wh2_main_trait_def_name_of_power_ca_03_khainemarked",
    "wh2_main_trait_def_name_of_power_ca_04_the_black_conqueror",
    "wh2_main_trait_def_name_of_power_ca_05_leviathanrage",
    "wh2_main_trait_def_name_of_power_ca_06_emeraldeye",
    "wh2_main_trait_def_name_of_power_ca_07_barbedlash",
    "wh2_main_trait_def_name_of_power_ca_08_pathguard",
    "wh2_main_trait_def_name_of_power_ca_09_the_dark_marshall",
    "wh2_main_trait_def_name_of_power_ca_10_the_dire_overseer",
    "wh2_main_trait_def_name_of_power_ca_11_gatesmiter",
    "wh2_main_trait_def_name_of_power_ca_12_the_tormentor"
} --:vector<string>

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

--v function(uic: CA_UIC)
local function deleteUIC(uic)
    local root = core:get_ui_root()
    root:CreateComponent("Garbage", "UI/campaign ui/script_dummy")
    local component = root:Find("Garbage")
    local garbage = UIComponent(component)
    garbage:Adopt(uic:Address())
    garbage:DestroyChildren()
end

--v function(cqi: CA_CQI)
local function are_you_sure(cqi)
    llr.ConfirmFrame = core:get_or_create_component("obr_ConfirmFrame", "ui/common ui/dialogue_box")
    dy_text = find_uicomponent(llr.ConfirmFrame, "DY_text")
    dy_text:SetStateText("")
    local event_messages = find_uicomponent(core:get_ui_root(), "layout", "radar_things", "dropdown_parent", "events_dropdown", "panel", "panel_clip", "header", "tx_title")
    llr.ConfirmText = UIComponent(event_messages:CopyComponent("obr_tx_title"))
    local ConfirmFrame_X, ConfirmFrame_Y = llr.ConfirmFrame:Bounds()
    dy_text:Adopt(llr.ConfirmText:Address())
    llr.ConfirmText:SetStateText(effect.get_localised_string("obr_ConfirmText"))
    local dy_text_X, dy_text_Y = dy_text:Position()   
    llr.ConfirmText:ResizeTextResizingComponentToInitialSize(dy_text:Width(), llr.ConfirmText:Height() * 1.5)
    local test_text_W, test_text_H, test_text_L = dy_text:TextDimensionsForText("test123")
    llr.ConfirmText:MoveTo(dy_text_X, dy_text_Y - test_text_H + dy_text:Height() / 2)
    llr.ConfirmText:PropagatePriority(dy_text:Priority())

    core:remove_listener("obr_ConfirmFrame_yes_no_ComponentLClickUp") 
    core:add_listener(
        "obr_ConfirmFrame_yes_no_ComponentLClickUp",
        "ComponentLClickUp",
        function(context)
            local button = UIComponent(context.component)
            return (button:Id() == "button_tick" or button:Id() == "button_cancel") and UIComponent(UIComponent(button:Parent()):Parent()):Id() == "obr_ConfirmFrame"
        end,
        function(context)
            local button = UIComponent(context.component)
            local id = context.string

            if id == "button_tick" then
                CampaignUI.TriggerCampaignScriptEvent(cqi, "LegendaryLordRespec|" ..llr.en_cost.."<"..tostring(llr.cost))
            else
               --close  
               core:remove_listener("obr_ConfirmFrame_yes_no_ComponentLClickUp")                       
            end
        end,
        true
    )
    local char = cm:get_character_by_cqi(cqi)
    local ButtonYes = find_uicomponent(llr.ConfirmFrame, "button_tick")

    if llr.en_cost == "enabled" or (llr.en_cost == "firstforfree" and cm:get_saved_value("llr_respec_" .. tostring(cqi))) then
        local respec_cost = (char:rank() - 1) * llr.cost
        if respec_cost <= char:faction():treasury() then
            ButtonYes:SetState("hover")
            ButtonYes:SetTooltipText(effect.get_localised_string("obr_confirm_yes_money1_tt")..respec_cost..effect.get_localised_string("obr_confirm_yes_money2_tt"), "", true)
            --ButtonYes:SetTooltipText("Respeccing this character would cost you: "..respec_cost.."[[img:icon_money]]!", "", false)
            ButtonYes:SetState("active")
        else
            --ButtonYes:SetDisabled(true)
            ButtonYes:SetState("inactive")
            ButtonYes:SetTooltipText(effect.get_localised_string("obr_confirm_yes_no_money1_tt").."\n"..effect.get_localised_string("obr_confirm_yes_no_money2_tt")
            ..respec_cost..effect.get_localised_string("obr_confirm_yes_no_money3_tt"), "", false)
            --ButtonYes:SetTooltipText("[[col:red]]You don't have enough funds![[/col]] \n Respeccing this character would cost you: "..respec_cost.."[[img:icon_money]]", "", false)
        end
    else
        ButtonYes:SetState("hover")
        ButtonYes:SetTooltipText(effect.get_localised_string("obr_confirm_yes_free_tt"), "", true)
        --ButtonYes:SetTooltipText("Respec your lord/hero.", "", false)
        ButtonYes:SetState("active")
    end
    if char:rank() == 1 then
        ButtonYes:SetState("inactive")
        ButtonYes:SetTooltipText(effect.get_localised_string("obr_confirm_yes_no_skills_tt"), "", false)
        --ButtonYes:SetTooltipText("No skill points allocated.", "", false)
    end
end

--v function(cqi: CA_CQI)
function llr.create_button(cqi)
    local character_details_panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
    if character_details_panel then
        llr.button = find_uicomponent(core:get_ui_root(), "obr_button")
        if llr.button then return end
        llr.button = core:get_or_create_component("obr_button", "ui/templates/square_medium_button") -- round_medium_button
        local char = cm:get_character_by_cqi(cqi)
        local bottom_buttons = find_uicomponent(core:get_ui_root(), "character_details_panel", "background", "bottom_buttons")
        bottom_buttons:Adopt(llr.button:Address())
        local icon_path = effect.get_skinned_image_path("icon_home.png")
        llr.button:SetImagePath(icon_path) 
        local button_replace_general = find_uicomponent(core:get_ui_root(), "character_details_panel", "button_replace_general")
        local bW, bH = button_replace_general:Bounds()
        local bX, bY = button_replace_general:Position()
        llr.button:Resize(bW, bH)

        llr.button:MoveTo(bX - bW - 1, bY)       
        llr.button:PropagatePriority(button_replace_general:Priority())

        if llr.limit then
            if cm:get_saved_value("llr_respec_" .. tostring(cqi)) then
                llr.button:SetState("inactive")
                llr.button:SetTooltipText(effect.get_localised_string("obr_RespecButtonLLR_disabled_tt"), "", false)
                --llr.button:SetTooltipText("[[col:red]]You have already respec'd this character. This cannot be done twice! [[/col]]", "", false)
            else
                llr.button:SetState("hover")
                llr.button:SetTooltipText(effect.get_localised_string("obr_RespecButtonLLR_limited_tt"), "", true)
                --llr.button:SetTooltipText("[[col:green]]Respec your lord/hero. This can only be done once! [[/col]]", "", false)
                llr.button:SetState("active")
            end
        else
            llr.button:SetState("hover")
            llr.button:SetTooltipText(effect.get_localised_string("obr_RespecButtonLLR_unlimited_tt"), "", true)
            --llr.button:SetTooltipText("[[col:green]]Respec your lord/hero. [[/col]]", "", false)
            llr.button:SetState("active")
        end
        core:remove_listener("obr_button_yes_no_ComponentLClickUp")
        core:add_listener(
            "obr_button_yes_no_ComponentLClickUp",
            "ComponentLClickUp",
            function(context)
                return context.string == "obr_button"
            end,
            function(context)
                local button_ok = find_uicomponent(core:get_ui_root(), "character_details_panel", "button_ok")
                if button_ok then
                    button_ok:SimulateLClick()
                end
                are_you_sure(cqi)
            end,
            true
        )
        if not core.svr:LoadPersistentBool("obr highlight") then 
            llr.button:StartPulseHighlight(2) 
            core.svr:SavePersistentBool("obr highlight", true)
        else
            llr.button:StopPulseHighlight()
        end
    end
end

--v function() --> CA_CQI
local function get_selected_char_CQI()
    local charCQI = cm:get_campaign_ui_manager():get_char_selected_cqi()
    local char = cm:get_character_by_cqi(charCQI)
    if char and char:has_military_force() then
        local unitsUIC = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "units")
        for i = 0, unitsUIC:ChildCount() - 1 do
            local uic_child = UIComponent(unitsUIC:Find(i))
            if uic_child:CurrentState() == "selected" and string.find(uic_child:Id(), "Agent") then
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
    core:remove_listener("obr_cycle_LeftLClickUp")
    core:remove_listener("obr_next_ShortcutPressed")
    core:remove_listener("obr_PanelOpenedCampaign")
    core:remove_listener("obr_PanelClosedCampaign")
    core:remove_listener("obr_UITrigger")

    if enable_value then
        core:add_listener(
            "obr_cycle_LeftLClickUp",
            "ComponentLClickUp",
            function(context)
                local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
                return (context.string == "button_cycle_right" or context.string == "button_cycle_left") and is_uicomponent(panel) and not cm:model():pending_battle():is_active()
            end,
            function(context)
                real_timer.register_singleshot("obr_ComponentLClickUp_next_tick", 0)
                core:add_listener(
                    "obr_next_tick",
                    "RealTimeTrigger",
                    function(context)
                        return context.string == "obr_ComponentLClickUp_next_tick"
                    end,
                    function(context)
                            llr.current_lord = get_selected_char_CQI()
                            if llr.current_lord then llr.create_button(llr.current_lord) end
                        end,
                    false
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
                real_timer.register_singleshot("obr_ShortcutPressed_next_tick", 0)
                core:add_listener(
                    "obr_next_tick",
                    "RealTimeTrigger",
                    function(context)
                        return context.string == "obr_ShortcutPressed_next_tick"
                    end,
                    function(context)
                            llr.current_lord = get_selected_char_CQI()
                            if llr.current_lord then llr.create_button(llr.current_lord) end
                        end,
                    false
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
                real_timer.register_singleshot("obr_PanelOpenedCampaign_next_tick", 0)
                core:add_listener(
                    "obr_next_tick",
                    "RealTimeTrigger",
                    function(context)
                        return context.string == "obr_PanelOpenedCampaign_next_tick"
                    end,
                    function(context)
                            llr.current_lord = get_selected_char_CQI()
                            if llr.current_lord then llr.create_button(llr.current_lord) end
                        end,
                    false
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
                    deleteUIC(llr.button)
                    llr.button = nil
                end
            end,
            true
        )

        core:add_listener(
            "obr_UITrigger",
            "UITrigger",
            function(context)
                return context:trigger():starts_with("LegendaryLordRespec|")
            end,
            function(context)
                local str = context:trigger() --:string
                local info = string.gsub(str, "LegendaryLordRespec|", "")
                local en_cost_end = string.find(info, "<")
                local en_cost = string.sub(info, 1, en_cost_end - 1)
                local cost = string.sub(info, en_cost_end + 1)  

                local cqi = context:faction_cqi() --: CA_CQI
                local char = cm:get_character_by_cqi(cqi)
                if en_cost == "enabled" or (en_cost == "firstforfree" and cm:get_saved_value("llr_respec_" .. tostring(cqi))) then
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
                for i = 1, #names_of_power_traits do
                    if char:has_trait(names_of_power_traits[i]) then 
                        cm:force_remove_trait(cm:char_lookup_str(cqi), names_of_power_traits[i])
                    end
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
        local c_cost = obr_mod:get_option_by_key("c_cost")
        llr.cost = c_cost:get_finalized_setting()
   
        --llr.log("obr_MctInitialized/llr.enable = "..tostring(llr.enable))
        --llr.log("obr_MctInitialized/llr.limit = "..tostring(llr.limit))
        --llr.log("obr_MctInitialized/llr.en_cost = "..tostring(llr.en_cost))
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
        llr.cost = settings_table.c_cost
        
        init_obr_listeners(llr.enable)
    end,
    true
)

function wec_obr()
    local mcm = _G.mcm
    local mct = core:get_static_object("mod_configuration_tool")

    if mct then
        -- MCT new --
        --llr.log("wec_obr/llr.enable = "..tostring(llr.enable))
        --llr.log("wec_obr/llr.limit = "..tostring(llr.limit))
        --llr.log("wec_obr/llr.en_cost = "..tostring(llr.en_cost))
        --llr.log("wec_obr/llr.cost = "..tostring(llr.cost))
    else
        llr.enable = true
        if cm:get_saved_value("mcm_tweaker_obr_limit_value") ~= "disabled" then
            llr.limit = true
        else
            llr.limit = false
        end
        llr.en_cost = cm:get_saved_value("mcm_tweaker_obr_en_cost_value") or "disabled"
        llr.cost = cm:get_saved_value("mcm_variable_obr_cost_value") or 500

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