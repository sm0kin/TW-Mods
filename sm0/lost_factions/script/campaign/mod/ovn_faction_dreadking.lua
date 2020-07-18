--------------------------------------------------------------
--------- DREAD KING LEGIONS GROWING POWER MECHANIC ----------
--------------------------------------------------------------

--[[   if not cm:get_saved_value("dk_power_one") then
    core:add_listener(
                "dk_power_one_listener", 
                "FactionRoundStart", 
                function(context) return context:faction():name() == "wh2_dlc09_tmb_the_sentinels" and cm:model():turn_number() == 25 end, 
                function() 
                local human_players = cm:get_human_factions();		
                cm:apply_effect_bundle("dk_power_one", "wh2_dlc09_tmb_the_sentinels", -1)
                cm:set_saved_value("dk_power_one", true);
                end,
                false 
                );
end;

if not cm:get_saved_value("dk_power_two") then
    core:add_listener(
                "dk_power_two_listener", 
                "FactionRoundStart", 
                function(context) return context:faction():name() == "wh2_dlc09_tmb_the_sentinels" and cm:model():turn_number() == 55 end, 
                function() 
                local human_players = cm:get_human_factions();
                cm:remove_effect_bundle("dk_power_one", "wh2_dlc09_tmb_the_sentinels", -1)
                cm:apply_effect_bundle("dk_power_two", "wh2_dlc09_tmb_the_sentinels", -1)
                cm:set_saved_value("dk_power_two", true);
                end,
                false 
                );
end;

if not cm:get_saved_value("dk_power_three") then
    core:add_listener(
                "dk_power_three_listener", 
                "FactionRoundStart", 
                function(context) return context:faction():name() == "wh2_dlc09_tmb_the_sentinels" and cm:model():turn_number() == 90 end, 
                function() 
                local human_players = cm:get_human_factions();
                cm:remove_effect_bundle("dk_power_two", "wh2_dlc09_tmb_the_sentinels", -1)
                cm:apply_effect_bundle("dk_power_three", "wh2_dlc09_tmb_the_sentinels", -1)
                cm:set_saved_value("dk_power_three", true);
                end,
                false
                );
end;]]

local function setup_diplo(is_human)
	-- allow diplomacy with all (can't make peace with Grudgebringers, defined in grudgebringers_setup())
    cm:force_diplomacy("faction:wh2_dlc09_tmb_the_sentinels", "all", "all", true, true, true);
end


local function dreadking_init()
    local faction_key = "wh2_dlc09_tmb_the_sentinels"
    local faction_obj = cm:get_faction(faction_key)

    if faction_obj:is_null_interface() then
        return false
    end

    -- remove vanilla nerf
    cm:remove_effect_bundle("wh2_main_negative_research_speed_50", "wh2_dlc09_tmb_the_sentinels", -1)
    
    setup_diplo(faction_obj:is_human())
end


cm:add_first_tick_callback(
    function()
        dreadking_init()
    end
)