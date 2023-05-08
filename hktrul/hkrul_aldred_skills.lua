core:add_listener(
    "hkrul_aldred_special_3_1_CharacterSkillPointAllocated",
    "CharacterSkillPointAllocated",
    function(context)
        local skill = context:skill_point_spent_on()
        return skill == "hkrul_aldred_special_3_1"
    end,
    function(context)
        local character = context:character()
        local faction = character:faction()
        
        cm:add_unit_to_faction_mercenary_pool(
            faction,
            "wh2_dlc13_emp_inf_greatswords_ror_0",
            "imperial_supply",
            1,
            100, 
            2,
            0.51, --change to 0.0667 for 1 ror in 15 turns
            "",
            "",
            "",
            true,
            "wh2_dlc13_emp_inf_greatswords_ror_0"
        )
    end,
    true
)