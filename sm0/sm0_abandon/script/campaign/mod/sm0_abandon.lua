local abandonButton = nil --:BUTTON
local abandonFrame = nil --:FRAME
local buildingCost = {800, 1600, 3200, 4800, 7200} --:vector<number>
local regionStr = "";
local frameName = effect.get_localised_string("sm0_frame_name"); --"Abandon Region"
local abandonText1 = effect.get_localised_string("sm0_text_string1"); --"If the enemy is getting too close and it looks likely you may lose control of a region, it is possible to abandon a settlement – enacting a scorched earth policy to deny the invaders their prize. When you leave, a small amount will be added to your treasury as the population save their valuables from the destruction. Although other regions won't approve of your decision..."
local abandonText2 = effect.get_localised_string("sm0_text_string2"); --"Do you really want to abandon the settlement of"
local abandonText3 = effect.get_localised_string("sm0_text_string3"); --"this turn?"
local confirmButtonText = effect.get_localised_string("sm0_confirm_button_text"); --"Abandon"
local confirmButtonTooltipHover1 = effect.get_localised_string("sm0_confirm_button_tooltip_hover1"); --"Abandoning the settlement of"
local confirmButtonTooltipHover2 = effect.get_localised_string("sm0_confirm_button_tooltip_hover2"); --"nets you"
local confirmButtonTooltipDisabled = effect.get_localised_string("sm0_confirm_button_tooltip_disabled"); --"Besieged Settlements can't be abandoned!"
local abandonButtonTooltip = effect.get_localised_string("sm0_abandom_button_tooltip_hover"); --"Abandon selected settlement"
local penaltyEnable = true --:bool                    
local iconPath = "ui/icon_raze.png";

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--v function()
function initMCMabandon()
    local mcm = _G.mcm;
    if not not mcm then
        local abandon = mcm:register_mod("abandon_region", "Abandon Region", "Adds the possibility to abandon a settlement.");
        local restriction = abandon:add_tweaker("penalty", "Public Order - Penalty", "Enable/Disable the public order penalty for abandoning one of your regions.");
        restriction:add_option("penalty", "Public Order - Penalty", "If you choose to enact a scorched earth policy you have to suffer the consequences.");
        restriction:add_option("nopenalty", "No Penalty", "Abandoning Regions has no consequences!");
        mcm:add_post_process_callback(
            function()
                penalty = cm:get_saved_value("mcm_tweaker_abandon_region_penalty_value");
                if penalty == "penalty" then
                    penaltyEnable = true;
                elseif penalty == "nopenalty" then
                    penaltyEnable = false;
                end
            end
        )
    end
    local penalty_value = cm:get_saved_value("mcm_tweaker_abandon_region_penalty_value");
    if penalty_value == "nopenalty" then
        penaltyEnable = false;
    else
        penaltyEnable = true;
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--v [NO_CHECK] function(slot: CA_SLOT) --> string
function getSlotType(slot)
    return slot:type();
end

--v function(region: CA_REGION) --> number
function calcCost(region)
    local money = 0 --:number
    local slotList = region:settlement():slot_list();
    for i = 0, slotList:num_items() - 1 do
        local currentSlot = slotList:item_at(i);
        if getSlotType(currentSlot) == "primary" then
                if currentSlot:has_building() then
                local building = currentSlot:building();
                local buildingName = building:name();
                for k, cost in ipairs(buildingCost) do
                    if string.match(buildingName, "ruin") then
                        money = 0.6 * 400; 
                    elseif string.match(buildingName, "_"..k) then
                        money = 0.6 * cost;
                    end
                end
            end
        end
    end
    return money;
end

--v function(abandonRegionStr: string)
function createAbandonFrame(abandonRegionStr)
    if abandonFrame then
		return;
    end
    abandonFrame = Frame.new(frameName);
    abandonFrame:Resize(720, 340);
	abandonFrame.uic:PropagatePriority(100);
    Util.centreComponentOnScreen(abandonFrame);
    abandonFrame.uic:RegisterTopMost();
    local regionOnscreenName = effect.get_localised_string("regions_onscreen_" .. abandonRegionStr); 
    local region = cm:get_region(abandonRegionStr);
    local money = calcCost(region);
    money = math.floor(money);
    abandonText = Text.new("abandonText", abandonFrame, "NORMAL", "test1");
    abandonText:Resize(640, 225);
    abandonText:SetText(abandonText1 .. "\n\n\n" ..abandonText2.. " " ..regionOnscreenName.. " " ..abandonText3);
    Util.centreComponentOnComponent(abandonText, abandonFrame);
	abandonFrame:AddCloseButton(
        function()
            abandonText:Delete();
			abandonFrame = nil;
        end,
        true
    );
    local confirmButton = TextButton.new("confirmButton", abandonFrame, "TEXT", confirmButtonText.. " " .. regionOnscreenName);
    confirmButton.uic:PropagatePriority(100);
    abandonFrame:AddComponent(confirmButton);
    confirmButton:SetState("hover");

    confirmButton.uic:SetTooltipText(confirmButtonTooltipHover1.." " .. regionOnscreenName .. " " ..confirmButtonTooltipHover2.. " " .. money .. ".");
    confirmButton:SetState("active");
    if region:garrison_residence():is_under_siege() then
        confirmButton:SetDisabled(true);
        confirmButton.uic:SetTooltipText(confirmButtonTooltipDisabled);
    end
    --Changed this to campaignUI trigger
    confirmButton:RegisterForClick( 
        function(context)
            local regionToSend = regionStr;
            local moneyToSend = calcCost(cm:get_region(regionToSend));
            CampaignUI.TriggerCampaignScriptEvent(cm:get_faction(cm:get_local_faction(true)):command_queue_index(), "burnitdown|"..regionToSend.."<"..moneyToSend..">"..tostring(penaltyEnable));
            abandonFrame:Delete();
            abandonFrame = nil;
            abandonButton:SetDisabled(true);
        end 
    );
    Util.centreComponentOnComponent(confirmButton, abandonFrame);
    local confirmButtonX, confirmButtonY = confirmButton:Position() --:number, number
	confirmButton:MoveTo(confirmButtonX, confirmButtonY + 80);
end

--v function()
function createAbandonButton()
    if not abandonButton then
        abandonButton = Button.new("abandonButton", find_uicomponent(core:get_ui_root(), "settlement_panel"), "SQUARE", iconPath);
        local renameButton = find_uicomponent(core:get_ui_root(), "settlement_panel", "button_rename");
        abandonButton:Resize(renameButton:Width(), renameButton:Height());
        abandonButton:PositionRelativeTo(renameButton, renameButton:Width() + 1, 0);
        abandonButton:SetState("hover");
        abandonButton.uic:SetTooltipText(abandonButtonTooltip);
        abandonButton:SetState("active");
        abandonButton:RegisterForClick(
            function(context)
                abandonRegionStr = regionStr;
                createAbandonFrame(abandonRegionStr);
            end 
        )		
    end
end

--v function()
function closeAbandonUI()
	if abandonButton then
		abandonButton:Delete();
		abandonButton = nil;
	end
	if abandonFrame then
		abandonFrame:Delete();
		abandonFrame = nil;
	end
end

--v function() --init
function sm0_abandon_init()
    local playerFaction = cm:get_faction(cm:get_local_faction(true));
    local playerFactionStr = playerFaction:name();
    local playerCultureStr = playerFaction:culture();
    cm:set_saved_value("sm0_abandon", true);
    if string.find(playerCultureStr, "wh2_") then
        iconPath = "ui/icon_raze2.png";
    end
    initMCMabandon();

    core:add_listener(
        "AbandonSettlementPanelOpened",
        "PanelOpenedCampaign",
        function(context)
            return context.string == "settlement_panel"
        end,
        function(context)
            createAbandonButton();
        end,
        true
    )

    core:add_listener(
        "AbandonSettlementPanelOpened",
        "PanelClosedCampaign",
        function(context)
            return context.string == "settlement_panel"
        end,
        function(context)
            regionStr = "";
            closeAbandonUI();
        end,
        true
    )

    core:add_listener(
        "AbandonSettlementSelected",
        "SettlementSelected",
        true,
        function(context)
            regionStr = context:garrison_residence():region():name();
            local currentFactionStr = context:garrison_residence():faction():name();
            local currentGarrison = context:garrison_residence();
            cm:callback(
                function(context)
                    if abandonFrame then
                        abandonFrame:Delete();
                        abandonFrame = nil;
                    end
                    if abandonButton then
                        local renameButton = find_uicomponent(core:get_ui_root(), "settlement_panel", "button_rename");
                        abandonButton:PositionRelativeTo(renameButton, renameButton:Width() + 1, 0);
                        if currentFactionStr ~= playerFactionStr then
                            abandonButton:SetDisabled(true);
                            abandonButton.uic:SetTooltipText(abandonButtonTooltip);
                        else
                            abandonButton:SetDisabled(false);
                        end
                    end
                end, 0, "waitForUI"
            );
        end,
        true
    )

    --Multiplayer listener
    core:add_listener(
        "AbandonMultiplayerCompatible",
        "UITriggerScriptEvent",
        function(context)
            return context:trigger():starts_with("burnitdown|");
        end,
        function(context)
            local str = context:trigger() --:string
            local info = string.gsub(str, "burnitdown|", "");
            local faction = cm:model():faction_for_command_queue_index(context:faction_cqi()):name();
            local regionNameEnd = string.find(info, "<")
            local regionName = string.sub(info, 1, regionNameEnd - 1);
            local regionToAbandon = cm:get_region(regionName);
            local cashEnd = string.find(info, ">")
            local cash = tonumber(string.sub(info, regionNameEnd + 1, cashEnd - 1));
            local penalty = string.sub(info, cashEnd + 1)
            cm:set_region_abandoned(regionName);
            cm:treasury_mod(faction, cash);
            if penalty == "true" then cm:apply_effect_bundle("wh2_sm0_abandon_public_order_down", faction, 5); end
        end,
        true
    )
end

cm.first_tick_callbacks[#cm.first_tick_callbacks+1] = 
function(context) 
    sm0_abandon_init();
end