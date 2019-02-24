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
--]]