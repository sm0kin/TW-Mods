cm:set_saved_value("sm0_abandon", true);
local abandonButton = nil --:BUTTON
local abandonFrame = nil --:FRAME
local buildingCost = {800, 1600, 3200, 4800, 7200} --:vector<number>
local playerFaction = cm:get_faction(cm:get_local_faction(true));
local playerFactionStr = playerFaction:name();
local regionStr = "";
local frameName = effect.get_localised_string("sm0_frame_name"); --"Abandon Region"
local abandonText1 = effect.get_localised_string("sm0_text_string1"); --"If the enemy is getting too close and it looks likely you may lose control of a region, it is possible to abandon a settlement – enacting a scorched earth policy to deny the invaders their prize. When you leave, a small amount will be added to your treasury as the population save their valuables from the destruction. Through other regions won't approve of your decision..."
local abandonText2 = effect.get_localised_string("sm0_text_string2"); --"Do you really want to abandon the settlement of"
local abandonText3 = effect.get_localised_string("sm0_text_string3"); --"this turn?"
local confirmButtonText = effect.get_localised_string("sm0_confirm_button_text"); --"Abandon"
local confirmButtonTooltipHover1 = effect.get_localised_string("sm0_confirm_button_tooltip_hover1"); --"Abandoning the settlement of"
local confirmButtonTooltipHover2 = effect.get_localised_string("sm0_confirm_button_tooltip_hover2"); --"nets you"
local confirmButtonTooltipDisabled = effect.get_localised_string("sm0_confirm_button_tooltip_disabled"); --"Besieged Settlements can't be abandoned!"
local abandonButtonTooltip = effect.get_localised_string("sm0_abandom_button_tooltip_hover"); --"Abandon selected settlement"
                    
local iconPath = "ui/icon_raze.png";
if string.find(playerFactionStr, "wh2_") then
    iconPath = "ui/icon_raze2.png";
end

--v function(region: CA_REGION) --> number
function calcCost(region)
    local slotList = region:settlement():slot_list();
    for i = 0, slotList:num_items() - 1 do
        local currentSlot = slotList:item_at(i);
        if currentSlot:type() == "primary" then
            if currentSlot:has_building() then
                local building = currentSlot:building();
                local buildingName = building:name();
                for k, cost in ipairs(buildingCost) do
                    if string.match(buildingName, "ruin") then
                        return 0.6 * 400; 
                    elseif string.match(buildingName, "_"..k) then
                        return 0.6 * cost;
                    end
                end
            end
        end
    end
end

--v function(abandonRegionStr: string)
function createAbandonFrame(abandonRegionStr)
    if abandonFrame then
		return;
    end
    abandonFrame = Frame.new(frameName);
    abandonFrame:Resize(720, 340);
	abandonFrame.uic:PropagatePriority(100);
	abandonFrame:AddCloseButton(
        function()
			abandonFrame = nil;
        end,
        true
    );
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
    local renameButton = find_uicomponent(core:get_ui_root(), "settlement_panel", "button_holder", "button_rename");
    confirmButton:RegisterForClick( 
        function(context)
            abandonFrame:Delete();
            abandonFrame = nil;
            cm:set_region_abandoned(abandonRegionStr);
            cm:treasury_mod(playerFactionStr, money);
            cm:apply_effect_bundle("wh2_sm0_abandon_public_order_down", playerFactionStr, 5);
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
        abandonButton = Button.new("abandonButton", find_uicomponent(core:get_ui_root(), "settlement_panel", "button_holder"), "SQUARE", iconPath);
        local renameButton = find_uicomponent(core:get_ui_root(), "settlement_panel", "button_holder", "button_rename");
        abandonButton:Resize(renameButton:Width(), renameButton:Height());
        abandonButton:PositionRelativeTo(renameButton, renameButton:Width() + 1, 0);
        abandonButton:SetState("hover");
        abandonButton.uic:SetTooltipText(abandonButtonTooltip);
        abandonButton:SetState("active");	
        abandonButton:RegisterForClick(
            function(context)
                local abandonRegionStr = regionStr;
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
                if currentFactionStr ~= playerFactionStr then
                    abandonButton:SetDisabled(true);
                    abandonButton.uic:SetTooltipText(abandonButtonTooltip);
                else
                    abandonButton:SetDisabled(false);
                end
            end, 0, "waitForUI"
        );
    end,
    true
)