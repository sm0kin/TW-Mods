function battle_speed()

end

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