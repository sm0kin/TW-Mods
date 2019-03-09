function battle_speed()
    --root > layout > radar_holder > speed_controls > speed_buttons > play
    local speed = Button.new("speed", find_uicomponent(core:get_ui_root(), "layout", "radar_holder", "speed_controls"), "SQUARE", "ui/skins/default/icon_speed_controls_play.png");
    local speed_controls = find_uicomponent(core:get_ui_root(), "speed_controls");
    local referenceButton = find_uicomponent(speed_controls, "play");
    speed:Resize(referenceButton:Width(), referenceButton:Height());
    speed:PositionRelativeTo(referenceButton, 0, referenceButton:Height() + 1);
    speed:SetState("hover");
    speed.uic:SetTooltipText("speed");			
    speed:SetState("active");
end

--root > finish_deployment > deployment_end_sp > button_battle_start
core:add_listener(
    "battleComponentLClickUp",
    "ComponentLClickUp",
    function(context)
		return context.string == "button_battle_start";
	end,
    function(context)
        battle_speed();
    end,
    true
)


output_uicomponent_on_click();


--[[
core:add_listener(
    "battleComponentMouseOn",
    "ComponentMouseOn",
    true,
    function(context)
        local component = UIComponent(context.component);
        output_uicomponent(component);
    end,
    true
)

cm:add_custom_battlefield(
		"generic",											-- string identifier
		0,													-- x co-ord
		0,													-- y co-ord
		5000,												-- radius around position
		false,												-- will campaign be dumped
		"",													-- loading override
		"script/battle/campaign_battle/battle_start.lua",	-- script override
		"",													-- entire battle override
		0,													-- human alliance when battle override
		false,												-- launch battle immediately
		true,												-- is land battle (only for launch battle immediately)
		false												-- force application of autoresolver result
	);
--]]
--D:\Modding\scripts\vanilla\campaign\wh_campaign_mod_scripting.lua
--D:\Modding\VScode\TW-Mods\backup\battle\campaign_battle\battle_start.lua

--[[
core:add_listener(
    "battleComponentLClickUp",
    "ComponentLClickUp",
    true,
    function(context)
        local component = UIComponent(context.component);
        output_uicomponent(component);
    end,
    true
)
]]