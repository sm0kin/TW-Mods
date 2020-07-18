cm:add_first_tick_callback(function()



    -- only load the listener if it's below turn 3
    if cm:model():turn_number() > 2 then
        return
    end

    local ai_changes = {
        ["wh2_dlc09_tmb_the_sentinels"] = "wh2_dlc09_tmb_followers_of_nagash",
        ["wh2_main_arb_caliphate_of_araby"] = "wh_empire_subjugator_hard_allied",
        ["wh2_main_rogue_troll_skullz"] = "ovn_troll_hard_random"
    }

    local change_if_ai = {
        ["wh2_dlc09_tmb_the_sentinels"] = true,
        ["wh2_main_arb_caliphate_of_araby"] = true,
        ["wh2_main_rogue_troll_skullz"] = true
    }

    core:add_listener(
        "ovn_faction_personality_change", 
        "FactionRoundStart", 
        function(context) 
            local faction_obj = context:faction()
            return cm:model():turn_number() == 2 and change_if_ai[faction_obj:name()] and not faction_obj:is_human()
        end, 
        function()
            local faction_key = context:faction():name()
            local ai_personality_key = ai_changes[faction_key]
            cm:force_change_cai_faction_personality(faction_key, ai_personality_key)
        end,
        false 
    )

end)