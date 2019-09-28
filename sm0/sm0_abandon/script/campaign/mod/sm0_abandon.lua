local abandonButton = nil --:BUTTON
local abandonFrame = nil --:FRAME
local buildingCost = {800, 1600, 3200, 4800, 7200} --:vector<number>
local regionStr = ""
local frameName = "Abandon Region"
local abandonText1 = "If the enemy is getting too close and it looks likely you may lose control of a region, it is possible to abandon a settlement – enacting a scorched earth policy to deny the invaders their prize. When you leave, a small amount will be added to your treasury as the population save their valuables from the destruction. Although other regions won't approve of your decision..."
local abandonText2 = "Do you really want to abandon the settlement of"
local abandonText3 = "this turn?"
local abandonText4 = "next turn?"
local confirmButtonText = "Abandon"
local confirmButtonTooltipHover1 = "Abandoning the settlement of"
local confirmButtonTooltipHover2 = "nets you"
local confirmButtonTooltipHover3 = "will be abandoned at the beginning of the next turn."
local confirmButtonTooltipDisabled = "Besieged Settlements can't be abandoned!"
local abandonButtonTooltip = "Abandon selected settlement"
local penalty_value                  
local iconPath = "ui/icon_raze.png"
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

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--v function()
local function initMCMabandon()
    penalty_value = cm:get_saved_value("mcm_tweaker_abandon_region_penalty_value")
    if penalty_value ~= "penalty" then penalty_value = "nopenalty" end
    local mcm = _G.mcm
    if not not mcm then
        local abandon = mcm:register_mod("abandon_region", "Abandon Region", "Adds the possibility to abandon a settlement.")
        local restriction = abandon:add_tweaker("penalty", "Public Order - Penalty", "Enable/Disable the public order penalty for abandoning one of your regions.")
        restriction:add_option("penalty", "Public Order - Penalty", "If you choose to enact a scorched earth policy you have to suffer the consequences.")
        restriction:add_option("nopenalty", "No Penalty", "Abandoning Regions has no consequences!")
        local delay = abandon:add_tweaker("delay", "Turns until Regions are abandoned", "Choose between instant and single turn delay until Regions are abandoned.")
        delay:add_option("instant", "Instant", "Regions can be abandoned instantly.")
        delay:add_option("oneTurn", "One Turn", "Abandoning a region takes one turn.")
        mcm:add_new_game_only_callback(
            function()
                penalty_value = cm:get_saved_value("mcm_tweaker_abandon_region_penalty_value")
            end
        )
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--v [NO_CHECK] function(slot: CA_SLOT) --> string
local function getSlotType(slot)
    return slot:type()
end

--v function(region: CA_REGION) --> number
local function calcCost(region)
    local money = 0 --:number
    local slotList = region:settlement():slot_list()
    for i = 0, slotList:num_items() - 1 do
        local currentSlot = slotList:item_at(i)
        if getSlotType(currentSlot) == "primary" then
                if currentSlot:has_building() then
                local building = currentSlot:building()
                local buildingName = building:name()
                for k, cost in ipairs(buildingCost) do
                    if string.match(buildingName, "ruin") then
                        money = 0.6 * 400 
                    elseif string.match(buildingName, "_"..k) then
                        money = 0.6 * cost
                    end
                end
            end
        end
    end
    return money
end

--v function(abandonRegionStr: string)
local function createAbandonFrame(abandonRegionStr)
    if abandonFrame then
		return
    end
    abandonFrame = Frame.new(frameName)
    abandonFrame:Resize(720, 340)
	abandonFrame.uic:PropagatePriority(100)
    Util.centreComponentOnScreen(abandonFrame)
    abandonFrame.uic:RegisterTopMost()
    local regionOnscreenName = effect.get_localised_string("regions_onscreen_" .. abandonRegionStr) 
    local region = cm:get_region(abandonRegionStr)
    local money = calcCost(region)
    money = math.floor(money)
    abandonText = Text.new("abandonText", abandonFrame, "NORMAL", "test1")
    abandonText:Resize(640, 225)
    if cm:get_saved_value("mcm_tweaker_abandon_region_delay_value") ~= "oneTurn" then 
        abandonText:SetText(abandonText1 .. "\n\n\n" ..abandonText2.. " " ..regionOnscreenName.. " " ..abandonText4)
    else
        abandonText:SetText(abandonText1 .. "\n\n\n" ..abandonText2.. " " ..regionOnscreenName.. " " ..abandonText3)
    end
    abandonText:SetText(abandonText1 .. "\n\n\n" ..abandonText2.. " " ..regionOnscreenName.. " " ..abandonText3)
    Util.centreComponentOnComponent(abandonText, abandonFrame)
	abandonFrame:AddCloseButton(
        function()
            abandonText:Delete()
			abandonFrame = nil
        end,
        true
    )
    local confirmButton = TextButton.new("confirmButton", abandonFrame, "TEXT_TOGGLE", confirmButtonText.. " " .. regionOnscreenName)
    confirmButton.uic:PropagatePriority(100)
    abandonFrame:AddComponent(confirmButton)
    confirmButton:SetState("hover")

    confirmButton.uic:SetTooltipText(confirmButtonTooltipHover1.." " .. regionOnscreenName .. " " ..confirmButtonTooltipHover2.. " " .. money .. ".")
    confirmButton:SetState("active")
    if region:garrison_residence():is_under_siege() then
        confirmButton:SetDisabled(true)
        confirmButton.uic:SetTooltipText(confirmButtonTooltipDisabled)
    end
    local region = cm:get_region(regionStr)
    local regionOwner = region:owning_faction()
    if cm:get_saved_value("abandon_"..regionStr.."_"..regionOwner:name()) then
        confirmButton:SetState("selected_hover")
        confirmButton.uic:SetTooltipText(regionOnscreenName.." "..confirmButtonTooltipHover3)
    end

    --Changed this to campaignUI trigger
    confirmButton:RegisterForClick( 
        function(context)
            local regionToSend = regionStr
            local moneyToSend = calcCost(cm:get_region(regionToSend))
            if cm:get_saved_value("mcm_tweaker_abandon_region_delay_value") ~= "oneTurn" then
                CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "burnitdown|"..regionToSend.."<"..moneyToSend..">"..penalty_value.."~")
                abandonFrame:Delete()
                abandonFrame = nil
                abandonButton:SetDisabled(true)
            else
                if not cm:get_saved_value("abandon_"..regionStr.."_"..regionOwner:name()) then
                    confirmButton:SetState("selected_hover")
                    confirmButton.uic:SetTooltipText(regionOnscreenName.." "..confirmButtonTooltipHover3)
                    CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "burnitdown|"..regionToSend.."<"..moneyToSend..">"..penalty_value.."~")
                else
                    confirmButton:SetState("active")
                    CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "burnitdown|"..regionToSend.."<"..moneyToSend..">"..penalty_value.."~remove")
                end
            end
        end 
    )
    Util.centreComponentOnComponent(confirmButton, abandonFrame)
    local confirmButtonX, confirmButtonY = confirmButton:Position() --:number, number
	confirmButton:MoveTo(confirmButtonX, confirmButtonY + 80)
end

--v function()
local function createAbandonButton()
    if not abandonButton then
        abandonButton = Button.new("abandonButton", find_uicomponent(core:get_ui_root(), "settlement_panel"), "SQUARE", iconPath)
        local renameButton = find_uicomponent(core:get_ui_root(), "settlement_panel", "button_rename")
        abandonButton:Resize(renameButton:Width(), renameButton:Height())
        abandonButton:PositionRelativeTo(renameButton, renameButton:Width() + 1, 0)
        abandonButton:SetState("hover")
        abandonButton.uic:SetTooltipText(abandonButtonTooltip)
        abandonButton:SetState("active")
        abandonButton:RegisterForClick(
            function(context)
                abandonRegionStr = regionStr
                createAbandonFrame(abandonRegionStr)
            end 
        )		
    end
end

--v function()
local function closeAbandonUI()
	if abandonButton then
		abandonButton:Delete()
		abandonButton = nil
	end
	if abandonFrame then
		abandonFrame:Delete()
		abandonFrame = nil
	end
end

--v function() --init
function sm0_abandon()
    frameName = effect.get_localised_string("sm0_frame_name") --"Abandon Region"
    abandonText1 = effect.get_localised_string("sm0_text_string1") --"If the enemy is getting too close and it looks likely you may lose control of a region, it is possible to abandon a settlement – enacting a scorched earth policy to deny the invaders their prize. When you leave, a small amount will be added to your treasury as the population save their valuables from the destruction. Although other regions won't approve of your decision..."
    abandonText2 = effect.get_localised_string("sm0_text_string2") --"Do you really want to abandon the settlement of"
    abandonText3 = effect.get_localised_string("sm0_text_string3") --"this turn?"
    abandonText4 = effect.get_localised_string("sm0_text_string4") --"next turn?"
    confirmButtonText = effect.get_localised_string("sm0_confirm_button_text") --"Abandon"
    confirmButtonTooltipHover1 = effect.get_localised_string("sm0_confirm_button_tooltip_hover1") --"Abandoning the settlement of"
    confirmButtonTooltipHover2 = effect.get_localised_string("sm0_confirm_button_tooltip_hover2") --"nets you"
    confirmButtonTooltipHover3 = effect.get_localised_string("sm0_confirm_button_tooltip_hover3") --" will be abandoned at the beginning of the next turn."
    confirmButtonTooltipDisabled = effect.get_localised_string("sm0_confirm_button_tooltip_disabled") --"Besieged Settlements can't be abandoned!"
    abandonButtonTooltip = effect.get_localised_string("sm0_abandon_button_tooltip_hover") --"Abandon selected settlement"
    local playerFaction = cm:get_faction(cm:get_local_faction(true))
    local playerFactionStr = playerFaction:name()
    local playerCultureStr = playerFaction:culture()
    if string.find(playerCultureStr, "wh2_") then
        iconPath = "ui/icon_raze2.png"
    end
    initMCMabandon()

    core:add_listener(
        "AbandonSettlement_PanelOpenedCampaign",
        "PanelOpenedCampaign",
        function(context)
            return context.string == "settlement_panel"
        end,
        function(context)
            createAbandonButton()
            local region = cm:get_region(regionStr)
            local currentFactionStr = region:owning_faction():name()
            if currentFactionStr ~= playerFactionStr then
                abandonButton:SetDisabled(true)
                abandonButton.uic:SetTooltipText(abandonButtonTooltip)
            else
                abandonButton:SetDisabled(false)
            end
        end,
        true
    )

    core:add_listener(
        "AbandonSettlement_PanelClosedCampaign",
        "PanelClosedCampaign",
        function(context)
            return context.string == "settlement_panel"
        end,
        function(context)
            closeAbandonUI()
        end,
        true
    )

    core:add_listener(
        "AbandonSettlementSelected",
        "SettlementSelected",
        true,
        function(context)
            regionStr = context:garrison_residence():region():name()
            
            local currentFactionStr = context:garrison_residence():faction():name()
            local currentGarrison = context:garrison_residence()
            cm:callback(
                function(context)
                    if abandonFrame then
                        abandonFrame:Delete()
                        abandonFrame = nil
                    end
                    if abandonButton then
                        local renameButton = find_uicomponent(core:get_ui_root(), "settlement_panel", "button_rename")
                        abandonButton:PositionRelativeTo(renameButton, renameButton:Width() + 1, 0)
                        if currentFactionStr ~= playerFactionStr then
                            abandonButton:SetDisabled(true)
                            abandonButton.uic:SetTooltipText(abandonButtonTooltip)
                        else
                            abandonButton:SetDisabled(false)
                        end
                    end
                end, 0, "waitForUI"
            )
        end,
        true
    )

    --Multiplayer listener
    core:add_listener(
        "AbandonMultiplayerCompatible",
        "UITriggerScriptEvent",
        function(context)
            return context:trigger():starts_with("burnitdown|")
        end,
        function(context)
            local str = context:trigger() --:string
            local info = string.gsub(str, "burnitdown|", "")
            local faction = cm:model():faction_for_command_queue_index(context:faction_cqi()):name()
            local regionNameEnd = string.find(info, "<")
            local regionName = string.sub(info, 1, regionNameEnd - 1)
            local regionToAbandon = cm:get_region(regionName)
            local cashEnd = string.find(info, ">")
            local cash = tonumber(string.sub(info, regionNameEnd + 1, cashEnd - 1))
            local penaltyEnd = string.find(info, "~")
            local penalty = string.sub(info, cashEnd + 1, penaltyEnd - 1)
            local remove = string.sub(info, penaltyEnd + 1)
            
            if cm:get_saved_value("mcm_tweaker_abandon_region_delay_value") ~= "oneTurn" then
                cm:show_message_event(
                    faction,
                    "event_feed_targeted_events_title_provinces_settlement_abandonedevent_feed_target_settlement_faction",
                    "regions_onscreen_"..regionName,
                    "event_feed_strings_text_wh_event_feed_string_provinces_settlement_abandoned_description",
                    true,
                    id_from_subculture[cm:get_faction(faction):subculture()]
                )
                cm:set_region_abandoned(regionName)
                cm:treasury_mod(faction, cash)
                if penalty ~= "nopenalty" then cm:apply_effect_bundle("wh2_sm0_abandon_public_order_down", faction, 5) end
            else
                if remove == "remove" then
                    core:remove_listener("Abandon_"..regionName.."_"..faction)
                    cm:set_saved_value("abandon_"..regionName.."_"..faction, false)
                else
                    cm:set_saved_value("abandon_"..regionName.."_"..faction, context:trigger())
                    core:add_listener(
                        "Abandon_"..regionName.."_"..faction,
                        "FactionTurnStart",
                        function(context)
                            return context:faction():name() == faction
                        end,
                        function(context)
                            local region = cm:get_region(regionName)
                            local regionOwner = region:owning_faction()
                            if regionOwner:name() == context:faction():name() then
                                cm:show_message_event(
                                    faction,
                                    "event_feed_targeted_events_title_provinces_settlement_abandonedevent_feed_target_settlement_faction",
                                    "regions_onscreen_"..regionName,
                                    "event_feed_strings_text_wh_event_feed_string_provinces_settlement_abandoned_description",
                                    true,
                                    id_from_subculture[cm:get_faction(faction):subculture()]
                                )
                                cm:set_region_abandoned(regionName)
                                cm:treasury_mod(faction, cash)
                                if penalty ~= "nopenalty" then cm:apply_effect_bundle("wh2_sm0_abandon_public_order_down", faction, 5) end
                                cm:set_saved_value("abandon_"..regionName.."_"..regionOwner:name(), false)
                            end
                        end,
                        false
                    )
                end
            end
        end,
        true
    )

    if cm:get_saved_value("mcm_tweaker_abandon_region_delay_value") == "oneTurn" then
        local regionList = playerFaction:region_list()
        for i = 0, regionList:num_items() - 1 do
            local currentRegion = regionList:item_at(i)
            if cm:get_saved_value("abandon_"..currentRegion:name().."_"..playerFaction:name()) then
                CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), cm:get_saved_value("abandon_"..currentRegion:name().."_"..playerFaction:name()))
            end
        end
    end
end