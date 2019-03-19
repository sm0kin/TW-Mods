local applyButton = nil --:CA_UIC
local speedBox = nil --:CA_UIC
local bm = get_bm();
local savedEntry = 1 --:number

--v function(uic: CA_UIC)
function deleteUIC(uic)
    local root = core:get_ui_root();
    root:CreateComponent("Garbage", "UI/campaign ui/script_dummy");
    local component = root:Find("Garbage");
    local garbage = UIComponent(component);
    garbage:Adopt(uic:Address());
    garbage:DestroyChildren();
end

--v function()
function createSpeedUI()
    local speed_buttons = find_uicomponent(core:get_ui_root(), "layout", "radar_holder", "speed_controls", "speed_buttons");
    local referenceButton = find_uicomponent(speed_buttons, "pause");
    local referenceButtonW, referenceButtonH = referenceButton:Bounds();
    local referenceButtonX, referenceButtonY = referenceButton:Position();

    if speedBox then
        deleteUIC(speedBox);
        speedBox = nil;
    end
    speed_buttons:CreateComponent("speedBox", "ui/common ui/text_box");
    speedBox = UIComponent(speed_buttons:Find("speedBox"));
    speed_buttons:Adopt(speedBox:Address());
    speedBox:PropagatePriority(referenceButton:Priority());
    speedBox:SetCanResizeHeight(true);
    speedBox:SetCanResizeWidth(true);
    speedBox:Resize(1.5*referenceButtonW, referenceButtonH);
    speedBox:SetCanResizeHeight(false);
    speedBox:SetCanResizeWidth(false);
    speedBox:MoveTo(referenceButtonX - 1.5*referenceButtonW, referenceButtonY)

    if applyButton then
        deleteUIC(applyButton);
        core:remove_listener("sm0_applyButton");
        applyButton = nil;
    end
    speed_buttons:CreateComponent("applyButton", "ui/templates/square_medium_button");
    applyButton = UIComponent(speed_buttons:Find("applyButton"));
    speed_buttons:Adopt(applyButton:Address());
    applyButton:PropagatePriority(referenceButton:Priority());
    if (core:svr_load_bool("primary_defender_is_player") and string.find(core:svr_load_string("primary_defender_subculture"), "wh_")) or 
            (core:svr_load_bool("primary_attacker_is_player") and string.find(core:svr_load_string("primary_attacker_subculture"), "wh_")) then
        applyButton:SetImage("ui/skins/default/icon_check.png"); 
    else
        applyButton:SetImage("ui/skins/warhammer2/icon_check.png"); 
    end
    applyButton:Resize(referenceButtonW, referenceButtonH);
    applyButton:MoveTo(referenceButtonX - 1.5*referenceButtonW, referenceButtonY + referenceButtonH)
    applyButton:SetState("hover");
    applyButton:SetStateText("")
    applyButton:SetState("active")
    core:add_listener(
        "sm0_applyButton",
        "ComponentLClickUp",
        function(context)
            return context.string == "applyButton";
        end,
        function(context)
            local speedButton --: CA_UIC
            local stateText = speedBox:GetStateText();
            stateText = string.gsub(stateText, "%[%[col:green%]%]", "");
            stateText = string.gsub(stateText, "%[%[/col%]%]", "");
            local number = stateText;
            if not tonumber(number) then
                speedButton = find_uicomponent(speed_buttons, "pause");
            elseif number == "0" then
                speedButton = find_uicomponent(speed_buttons, "pause");
                -- logical operations as string because tonumber isn't precise with float, e.g. tonumber("22.31") --> 22.310000000000002
                --#assume number: number
                if speedButton:CurrentState() == "selected" then number = savedEntry; end
            else
                speedButton = find_uicomponent(speed_buttons, "play");
            end
            -- replay speed control doesn't recognise modify_battle_speed
            speedButton:SimulateLClick();
            if tonumber(number) then
                -- a battle speed of less than 100ms will cause problems since the game ticks every 100ms
                if tonumber(number) < 0.1 and number ~= "0" then number = "0.1"; end
                --#assume number: number
                bm:modify_battle_speed(number);
                speedBox:SetStateText("[[col:green]]"..number.."[[/col]]");
                --bm:set_volume(VOLUME_TYPE_MUSIC, 100);
                --bm:set_volume(VOLUME_TYPE_SFX, 100);
                --bm:set_volume(VOLUME_TYPE_VO, 100);
                if number ~= "0" then savedEntry = number; end
            else
                speedBox:SetStateText("[[col:red]]Invalid![[/col]]");
            end

        end,
        true
    )
end

core:add_listener(
    "sm0_battleStart",
    "ComponentLClickUp",
    function(context)
        return context.string == "pause" or context.string == "slow_mo" or context.string == "play" 
        or context.string == "fwd" or context.string == "ffwd" or context.string == "button_battle_start";
	end,
    function(context)
        createSpeedUI();
    end,
    true
)


core:add_listener(
    "sm0_speedButtons",
    "ComponentLClickUp",
    true,
    function(context)
        if context.string == "pause" then
            speedBox:SetStateText("0");
        elseif context.string == "slow_mo" then
            speedBox:SetStateText("0.5");
        elseif context.string == "play" then
            speedBox:SetStateText("1");
        elseif context.string == "fwd" then
            speedBox:SetStateText("2");
        elseif context.string == "ffwd" then
            speedBox:SetStateText("3");
        end
    end,
    true
)

core:add_listener(
    "sm0_unselectAll",
    "ShortcutPressed",
    function(context)
        return context.string == "toggle_ui_with_borders" or context.string == "toggle_ui";
    end,
    function(context)
        if applyButton then
            deleteUIC(applyButton);
            core:remove_listener("sm0_applyButton");
            applyButton = nil;
        end
        if speedBox then
            deleteUIC(speedBox);
            speedBox = nil;
        end
    end,
    true
)