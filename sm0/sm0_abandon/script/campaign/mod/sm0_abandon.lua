local abandon_button = nil --:BUTTON
local abandon_frame = nil --:FRAME
local building_cost = {800, 1600, 3200, 4800, 7200} --:vector<number>
local region_key = ""
local frame_name = "Abandon Region"
local abandon_text1 = "If the enemy is getting too close and it looks likely you may lose control of a region, it is possible to abandon a settlement – enacting a scorched earth policy to deny the invaders their prize. When you leave, a small amount will be added to your treasury as the population save their valuables from the destruction. Although residents of other regions won't approve of your decision..."
local abandon_text2 = "Do you really want to abandon the settlement of"
local abandon_text3 = "this turn?"
local abandon_text4 = "next turn?"
local confirm_button_text = "Abandon"
local confirm_button_tooltip_hover1 = "Abandoning the settlement of"
local confirm_button_tooltip_hover2 = "nets you"
local confirm_button_tooltip_hover3 = "will be abandoned at the beginning of the next turn."
local confirm_button_tooltip_disabled = "Besieged Settlements can't be abandoned!"
local abandon_button_tooltip = "Abandon selected settlement"
local icon_path = ""
local mct_settings      
local enable_value --:WHATEVER
local penalty_value --:WHATEVER
local penalty_scope_value --:WHATEVER
local penalty_tier_value --:WHATEVER
local delay_value --:WHATEVER 
local id_from_subculture = {
    ["wh_dlc03_sc_bst_beastmen"] = 19130,
    ["wh_dlc05_sc_wef_wood_elves"] = 19131,
    ["wh_main_sc_brt_bretonnia"] = 19132,
    ["wh_main_sc_chs_chaos"] = 19133,
    ["wh_main_sc_dwf_dwarfs"] = 19134,
    ["wh_main_sc_emp_empire"] = 19135,
    ["wh_main_sc_grn_greenskins"] = 19136,
    ["wh_main_sc_grn_savage_orcs"] = 19137,
    ["wh_main_sc_ksl_kislev"] = 19138,
    ["wh_main_sc_nor_norsca"] = 19139,
    ["wh_main_sc_teb_teb"] = 19140,
    ["wh_main_sc_vmp_vampire_counts"] = 19141,
    ["wh2_dlc09_sc_tmb_tomb_kings"] = 19142,
    ["wh2_main_sc_def_dark_elves"] = 19143,
    ["wh2_main_sc_hef_high_elves"] = 19144,
    ["wh2_main_sc_lzd_lizardmen"] = 19145,
    ["wh2_main_sc_skv_skaven"]  = 19146,
    ["wh2_dlc11_sc_cst_vampire_coast"] = 19147
} --: map<string, number>

--v function(region: CA_REGION) --> number
local function calc_cost(region)
    local money = 0 --:number
    local primary_slot = region:settlement():primary_slot()
    if primary_slot:has_building() then
        local building = primary_slot:building()
        local building_name = building:name()
        for k, cost in ipairs(building_cost) do
            if string.match(building_name, "ruin") and penalty_value ~= "false" and penalty_scope_value ~= "local" and penalty_tier_value ~= "false" then
                money = 0.6 * 400 
            elseif string.match(building_name, "_"..k) then
                money = 0.6 * cost
            end
        end
    end
    return money
end

--v function(abandon_region_key: string)
local function create_abandon_frame(abandon_region_key)
    if abandon_frame then
		return
    end
    abandon_frame = Frame.new(frame_name)
    abandon_frame:Resize(720, 340)
    local parchment = find_uicomponent(abandon_frame.uic, "parchment")
    local frame_X, frame_Y = abandon_frame.uic:Position()
    local frame_W, frame_H = abandon_frame.uic:Bounds()
    local parchment_W, parchment_H = parchment:Bounds()
    local gap_X, gap_Y = frame_W - parchment_W, frame_H - parchment_H
    parchment:MoveTo(frame_X + gap_X/2, frame_Y + gap_Y/2)
	abandon_frame.uic:PropagatePriority(100)
    Util.centreComponentOnScreen(abandon_frame)
    abandon_frame.uic:RegisterTopMost()
    local region_onscreen_name = effect.get_localised_string("regions_onscreen_" .. abandon_region_key) 
    local region = cm:get_region(abandon_region_key)
    local money = calc_cost(region)
    money = math.floor(money)
    abandon_text = Text.new("abandon_text", abandon_frame, "NORMAL", "test1")
    abandon_text:Resize(640, 225)
    abandon_text:SetText(abandon_text1)
    abandon_frame:AddComponent(abandon_text)
    local confirm_text = Text.new("confirm_text", abandon_frame, "HEADER", "test12") --WRAPPED --HEADER
    confirm_text:Resize(620, 100)
    if delay_value ~= "one_turn" then 
        confirm_text:SetText(abandon_text2.. " " ..region_onscreen_name.. " " ..abandon_text3)
    else
        confirm_text:SetText(abandon_text2.. " " ..region_onscreen_name.. " " ..abandon_text4)
    end
    abandon_frame:AddComponent(confirm_text)
    Util.centreComponentOnComponent(abandon_text, abandon_frame)
	abandon_frame:AddCloseButton(
        function()
			abandon_frame = nil
        end,
        true
    )
    local confirm_button = TextButton.new("confirm_button", abandon_frame, "TEXT_TOGGLE", confirm_button_text.. " " .. region_onscreen_name)
    confirm_button.uic:PropagatePriority(100)
    abandon_frame:AddComponent(confirm_button)
    confirm_button:SetState("hover")

    confirm_button.uic:SetTooltipText(confirm_button_tooltip_hover1.." " .. region_onscreen_name .. " " ..confirm_button_tooltip_hover2.. " " .. money .. ".", "", false)
    confirm_button:SetState("active")
    if region:garrison_residence():is_under_siege() then
        confirm_button:SetDisabled(true)
        confirm_button.uic:SetTooltipText(confirm_button_tooltip_disabled, "", false)
    end
    local region_owner = region:owning_faction()
    if cm:get_saved_value("abandon_"..region_key.."_"..region_owner:name()) then
        confirm_button:SetState("selected_hover")
        confirm_button.uic:SetTooltipText(region_onscreen_name.." "..confirm_button_tooltip_hover3, "", false)
    end

    --Changed this to campaignUI trigger
    confirm_button:RegisterForClick( 
        function(context)
            local region_to_send = region_key
            local money_to_send = calc_cost(cm:get_region(region_to_send))
            if delay_value ~= "one_turn" then
                CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "burnitdown|"
                ..region_to_send.."<"..money_to_send..">"..tostring(penalty_value).."~".."^"..tostring(penalty_scope_value).."°"..tostring(penalty_tier_value).."$"..tostring(delay_value))
                abandon_frame:Delete()
                abandon_frame = nil
                abandon_button:SetDisabled(true)
            else
                if not cm:get_saved_value("abandon_"..region_key.."_"..region_owner:name()) then
                    confirm_button:SetState("selected_hover")
                    confirm_button.uic:SetTooltipText(region_onscreen_name.." "..confirm_button_tooltip_hover3, "", false)
                    CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "burnitdown|"
                    ..region_to_send.."<"..money_to_send..">"..tostring(penalty_value).."~".."^"..tostring(penalty_scope_value).."°"..tostring(penalty_tier_value).."$"..tostring(delay_value))
                else
                    confirm_button:SetState("active")
                    CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "burnitdown|"
                    ..region_to_send.."<"..money_to_send..">"..tostring(penalty_value).."~remove".."^"..tostring(penalty_scope_value).."°"..tostring(penalty_tier_value).."$"..tostring(delay_value))
                end
            end
        end 
    )
    Util.centreComponentOnComponent(confirm_button, abandon_frame)
    local confirm_button_X, confirm_button_Y = confirm_button:Position() --:number, number
    confirm_button:MoveTo(confirm_button_X, confirm_button_Y + 80)
    Util.centreComponentOnComponent(confirm_text, abandon_frame)
    local confirm_text_X, confirm_text_Y = confirm_text:Position() --:number, number
    confirm_text:MoveTo(confirm_text_X, confirm_text_Y + 65)
end

--v function()
local function create_abandon_button()
    if not abandon_button then
        abandon_button = Button.new("abandon_button", find_uicomponent(core:get_ui_root(), "settlement_panel"), "SQUARE", icon_path)
        local rename_button = find_uicomponent(core:get_ui_root(), "settlement_panel", "button_rename")
        abandon_button:Resize(rename_button:Width(), rename_button:Height())
        abandon_button:PositionRelativeTo(rename_button, rename_button:Width() + 1, 0)
        abandon_button:SetState("hover")
        abandon_button.uic:SetTooltipText(abandon_button_tooltip, "", false)
        abandon_button:SetState("active")
        abandon_button:RegisterForClick(
            function(context)
                abandon_region_key = region_key
                create_abandon_frame(abandon_region_key)
            end 
        )		
    end
end

--v function()
local function close_abandon_ui()
	if abandon_button then
		abandon_button:Delete()
		abandon_button = nil
	end
	if abandon_frame then
		abandon_frame:Delete()
		abandon_frame = nil
	end
end

--v function(faction: CA_FACTION)
local function kill_colonels(faction)
    local char_list = faction:character_list()
    for i = 0, char_list:num_items() - 1 do
        local character = char_list:item_at(i)
        if character:character_type("colonel") then
            if not character:has_military_force() and not character:is_politician() and not character:has_garrison_residence() then
                cm:kill_character(character:command_queue_index(), true, true)
            end
        end
    end
end

--v function(enable_value: boolean)
local function init_abandon_region_listeners(enable_value)
    core:remove_listener("abadon_region_PanelOpenedCampaign")
    core:remove_listener("abadon_region_PanelClosedCampaign")
    core:remove_listener("abadon_region_SettlementSelected")
    core:remove_listener("abadon_region_UITriggerScriptEvent")
    if enable_value then
        local player_faction = cm:get_faction(cm:get_local_faction(true))
        local player_faction_key = player_faction:name()
        core:add_listener(
            "abadon_region_PanelOpenedCampaign",
            "PanelOpenedCampaign",
            function(context)
                return context.string == "settlement_panel"
            end,
            function(context)
                create_abandon_button()
                local region = cm:get_region(region_key)
                local current_faction_key = region:owning_faction():name()
                if current_faction_key ~= player_faction_key then
                    abandon_button:SetDisabled(true)
                    abandon_button.uic:SetTooltipText(abandon_button_tooltip, "", false)
                else
                    abandon_button:SetDisabled(false)
                end
            end,
            true
        )

        core:add_listener(
            "abadon_region_PanelClosedCampaign",
            "PanelClosedCampaign",
            function(context)
                return context.string == "settlement_panel"
            end,
            function(context)
                close_abandon_ui()
            end,
            true
        )

        core:add_listener(
            "abadon_region_SettlementSelected",
            "SettlementSelected",
            true,
            function(context)
                region_key = context:garrison_residence():region():name()
                
                local current_faction_key = context:garrison_residence():faction():name()
                cm:callback(
                    function(context)
                        if abandon_frame then
                            abandon_frame:Delete()
                            abandon_frame = nil
                        end
                        if abandon_button then
                            local rename_button = find_uicomponent(core:get_ui_root(), "settlement_panel", "button_rename")
                            abandon_button:PositionRelativeTo(rename_button, rename_button:Width() + 1, 0)
                            if current_faction_key ~= player_faction_key then
                                abandon_button:SetDisabled(true)
                                abandon_button.uic:SetTooltipText(abandon_button_tooltip, "", false)
                            else
                                abandon_button:SetDisabled(false)
                            end
                        end
                    end, 0, "waitForUI"
                )
            end,
            true
        )

        --Multiplayer listener
        core:add_listener(
            "abadon_region_UITriggerScriptEvent",
            "UITriggerScriptEvent",
            function(context)
                return context:trigger():starts_with("burnitdown|")
            end,
            function(context)
                local str = context:trigger() --:string
                local info = string.gsub(str, "burnitdown|", "")
                local faction = cm:model():faction_for_command_queue_index(context:faction_cqi()):name()
                local region_name_end = string.find(info, "<")
                local region_name = string.sub(info, 1, region_name_end - 1)
                local money_end = string.find(info, ">")
                local money = tonumber(string.sub(info, region_name_end + 1, money_end - 1))
                local penalty_end = string.find(info, "~")
                local penalty = string.sub(info, money_end + 1, penalty_end - 1)
                local remove_end = string.find(info, "^")
                local remove = string.sub(info, penalty_end + 1, remove_end - 1)
                local penalty_scope_end  = string.find(info, "°")
                local penalty_scope = string.sub(info, remove_end + 1, penalty_scope_end - 1)
                local penalty_tier_end = string.find(info, "$")
                local penalty_tier = string.sub(info, penalty_scope_end + 1, penalty_tier_end - 1)
                local delay = string.sub(info, penalty_tier_end + 1)       
                
                if delay ~= "one_turn" then
                    cm:show_message_event(
                        faction,
                        "event_feed_targeted_events_title_provinces_settlement_abandonedevent_feed_target_settlement_faction",
                        "regions_onscreen_"..region_name,
                        "event_feed_strings_text_wh_event_feed_string_provinces_settlement_abandoned_description",
                        true,
                        id_from_subculture[cm:get_faction(faction):subculture()]
                    )
                    if penalty ~= "false" then 
                        local turns = 5
                        local effect_bundle = "wh2_sm0_abandon_public_order_down"
                        if penalty_scope == "local" then effect_bundle = "wh2_sm0_abandon_public_order_down_local" end
                        local region = cm:get_region(region_name)
                        if penalty_tier ~= "false" then 
                            local settlement_building = region:settlement():primary_slot():building():name()
                            for i = 1, 5 do
                                if string.match(settlement_building, "ruin") then
                                    effect_bundle = ""
                                elseif string.match(settlement_building, "_"..i) then
                                    effect_bundle = effect_bundle.."_t"..i
                                end
                            end
                        end
                        if effect_bundle ~= "" then
                            if penalty_scope ~= "local" then
                                cm:apply_effect_bundle(effect_bundle, faction, turns)
                            else
                                cm:apply_effect_bundle_to_faction_province(effect_bundle, region, turns)
                            end
                        end
                    end
                    cm:set_region_abandoned(region_name)
                    cm:treasury_mod(faction, money)
                    kill_colonels(cm:get_faction(faction))
                else
                    if remove == "remove" then
                        core:remove_listener("Abandon_"..region_name.."_"..faction)
                        cm:set_saved_value("abandon_"..region_name.."_"..faction, false)
                    else
                        cm:set_saved_value("abandon_"..region_name.."_"..faction, context:trigger())
                        core:add_listener(
                            "Abandon_"..region_name.."_"..faction,
                            "FactionTurnStart",
                            function(context)
                                return context:faction():name() == faction
                            end,
                            function(context)
                                local region = cm:get_region(region_name)
                                local region_owner = region:owning_faction()
                                if region_owner:name() == context:faction():name() then
                                    cm:show_message_event(
                                        faction,
                                        "event_feed_targeted_events_title_provinces_settlement_abandonedevent_feed_target_settlement_faction",
                                        "regions_onscreen_"..region_name,
                                        "event_feed_strings_text_wh_event_feed_string_provinces_settlement_abandoned_description",
                                        true,
                                        id_from_subculture[cm:get_faction(faction):subculture()]
                                    )
                                    if penalty ~= "false" then 
                                        local turns = 5
                                        local effect_bundle = "wh2_sm0_abandon_public_order_down"
                                        if penalty_scope == "local" then effect_bundle = "wh2_sm0_abandon_public_order_down_local" end
                                        local region = cm:get_region(region_name)
                                        if penalty_tier ~= "false" then 
                                            --turns = 1 
                                            local settlement_building = region:settlement():primary_slot():building():name()
                                            for i = 1, 5 do
                                                if string.match(settlement_building, "ruin") then
                                                    effect_bundle = ""
                                                elseif string.match(settlement_building, "_"..i) then
                                                    effect_bundle = effect_bundle.."_t"..i
                                                end
                                            end
                                        end
                                        if effect_bundle ~= "" then
                                            if penalty_scope ~= "local" then
                                                cm:apply_effect_bundle(effect_bundle, faction, turns)
                                            else
                                                cm:apply_effect_bundle_to_faction_province(effect_bundle, region, turns)
                                            end
                                        end
                                    end
                                    cm:set_region_abandoned(region_name)
                                    cm:treasury_mod(faction, money)
                                    cm:set_saved_value("abandon_"..region_name.."_"..region_owner:name(), false)
                                    kill_colonels(context:faction())
                                end
                            end,
                            false
                        )
                    end
                end
            end,
            true
        )

        if delay_value == "one_turn" then
            local region_list = player_faction:region_list()
            for i = 0, region_list:num_items() - 1 do
                local current_region = region_list:item_at(i)
                if cm:get_saved_value("abandon_"..current_region:name().."_"..player_faction:name()) then
                    CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), cm:get_saved_value("abandon_"..current_region:name().."_"..player_faction:name()))
                end
            end
        end
    end
end

core:add_listener(
    "abandon_region_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        local mct = get_mct()
        local abandon_region_mod = mct:get_mod_by_key("abandon_region")
        --local settings_table = abandon_region_mod:get_settings() 
        --enable_value = settings_table.a_enable
        --penalty_value = settings_table.a_penalty
        --penalty_scope_value = settings_table.c_penalty_scope
        --penalty_tier_value = settings_table.b_penalty_tier
        --delay_value = settings_table.b_delay

        local a_enable = abandon_region_mod:get_option_by_key("a_enable")
        enable_value = a_enable:get_finalized_setting()
        local a_penalty = abandon_region_mod:get_option_by_key("a_penalty")
        penalty_value = a_penalty:get_finalized_setting()
        local c_penalty_scope = abandon_region_mod:get_option_by_key("c_penalty_scope")
        penalty_scope_value = c_penalty_scope:get_finalized_setting()
        local b_penalty_tier = abandon_region_mod:get_option_by_key("b_penalty_tier")
        penalty_tier_value = b_penalty_tier:get_finalized_setting()
        local b_delay = abandon_region_mod:get_option_by_key("b_delay")
        delay_value = b_delay:get_finalized_setting()
        
        --out("sm0/abandon_region_MctInitialized/enable_value = "..tostring(enable_value))
        --out("sm0/abandon_region_MctInitialized/penalty_value = "..tostring(penalty_value))
        --out("sm0/abandon_region_MctInitialized/penalty_scope_value = "..tostring(penalty_scope_value))
        --out("sm0/abandon_region_MctInitialized/penalty_tier_value = "..tostring(penalty_tier_value))
        --out("sm0/abandon_region_MctInitialized/delay_value = "..tostring(delay_value))
    end,
    true
)

core:add_listener(
    "abandon_region_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        local mct = get_mct()
        local abandon_region_mod = mct:get_mod_by_key("abandon_region")
        local settings_table = abandon_region_mod:get_settings() 
        enable_value = settings_table.a_enable
        penalty_value = settings_table.a_penalty
        penalty_scope_value = settings_table.c_penalty_scope
        penalty_tier_value = settings_table.b_penalty_tier
        delay_value = settings_table.b_delay
        
        init_abandon_region_listeners(enable_value)
    end,
    true
)

--v function() --init
function sm0_abandon()
    frame_name = effect.get_localised_string("sm0_frame_name") --"Abandon Region"
    abandon_text1 = effect.get_localised_string("sm0_text_string1") --"If the enemy is getting too close and it looks likely you may lose control of a region, it is possible to abandon a settlement – enacting a scorched earth policy to deny the invaders their prize. When you leave, a small amount will be added to your treasury as the population save their valuables from the destruction. Although other regions won't approve of your decision..."
    abandon_text2 = effect.get_localised_string("sm0_text_string2") --"Do you really want to abandon the settlement of"
    abandon_text3 = effect.get_localised_string("sm0_text_string3") --"this turn?"
    abandon_text4 = effect.get_localised_string("sm0_text_string4") --"next turn?"
    confirm_button_text = effect.get_localised_string("sm0_confirm_button_text") --"Abandon"
    confirm_button_tooltip_hover1 = effect.get_localised_string("sm0_confirm_button_tooltip_hover1") --"Abandoning the settlement of"
    confirm_button_tooltip_hover2 = effect.get_localised_string("sm0_confirm_button_tooltip_hover2") --"nets you"
    confirm_button_tooltip_hover3 = effect.get_localised_string("sm0_confirm_button_tooltip_hover3") --" will be abandoned at the beginning of the next turn."
    confirm_button_tooltip_disabled = effect.get_localised_string("sm0_confirm_button_tooltip_disabled") --"Besieged Settlements can't be abandoned!"
    abandon_button_tooltip = effect.get_localised_string("sm0_abandon_button_tooltip_hover") --"Abandon selected settlement"
    icon_path = effect.get_skinned_image_path("icon_raze.png")

    local mcm = _G.mcm
    local mct = core:get_static_object("mod_configuration_tool")

    if mct and not cm:is_multiplayer() then
        -- MCT new --
        --out("sm0/mct and not cm:is_multiplayer()/enable_value = "..tostring(enable_value))
        --out("sm0/mct and not cm:is_multiplayer()/penalty_value = "..tostring(penalty_value))
        --out("sm0/mct and not cm:is_multiplayer()/penalty_scope_value = "..tostring(penalty_scope_value))
        --out("sm0/mct and not cm:is_multiplayer()/penalty_tier_value = "..tostring(penalty_tier_value))
        --out("sm0/mct and not cm:is_multiplayer()/delay_value = "..tostring(delay_value))
    else
        enable_value = true
        if cm:get_saved_value("mcm_tweaker_abandon_region_penalty_value") ~= "no_penalty" then
            penalty_value = true
        else
            penalty_value = false
        end
        penalty_scope_value = cm:get_saved_value("mcm_tweaker_abandon_region_penalty_scope_value") or "global"
        if cm:get_saved_value("mcm_tweaker_abandon_region_penalty_tier_value") ~= "disabled" then
            penalty_tier_value = true
        else
            penalty_tier_value = false
        end
        delay_value = cm:get_saved_value("mcm_tweaker_abandon_region_delay_value") or "instant"

        -- MCT old --
        if mcm then
            local abandon = mcm:register_mod("abandon_region", "Abandon Region", "Adds the possibility to abandon a settlement.")
            local penalty = abandon:add_tweaker("penalty", "Public Order - Penalty", "Enable/Disable the public order penalty for abandoning one of your regions.")
            penalty:add_option("penalty", "Public Order - Penalty", "If you choose to enact a scorched earth policy you have to suffer the consequences.")
            penalty:add_option("no_penalty", "No Penalty", "Abandoning Regions has no consequences!")
            local penalty_scope = abandon:add_tweaker("penalty_scope", "Public Order - Penalty Scope", "Local/Global public order penalty for abandoning one of your regions.")
            penalty_scope:add_option("global", "Global Penalty", "Global Public Order penalty.")
            penalty_scope:add_option("local", "Local Penalty", "Local Public Order penalty.")
            local penalty_tier = abandon:add_tweaker("penalty_tier", "Public Order - Penalty settlement tier based", "Public order penalty for abandoning one of your regions based on the settlement tier.")
            penalty_tier:add_option("enabled", "Enable", "")
            penalty_tier:add_option("disabled", "Disable", "")
            local delay = abandon:add_tweaker("delay", "Turns until Regions are abandoned", "Choose between instant and single turn delay until Regions are abandoned.")
            delay:add_option("instant", "Instant", "Regions can be abandoned instantly.")
            delay:add_option("one_turn", "One Turn", "Abandoning a region takes one turn.")
            mcm:add_new_game_only_callback(
                function()
                    if cm:get_saved_value("mcm_tweaker_abandon_region_penalty_value") ~= "no_penalty" then
                        penalty_value = true
                    else
                        penalty_value = false
                    end
                    penalty_scope_value = cm:get_saved_value("mcm_tweaker_abandon_region_penalty_scope_value") or "global"
                    if cm:get_saved_value("mcm_tweaker_abandon_region_penalty_tier_value") ~= "disabled" then
                        penalty_tier_value = true
                    else
                        penalty_tier_value = false
                    end
                    delay_value = cm:get_saved_value("mcm_tweaker_abandon_region_delay_value") or "instant"
                end
            )
        end
    end

    init_abandon_region_listeners(enable_value)
end