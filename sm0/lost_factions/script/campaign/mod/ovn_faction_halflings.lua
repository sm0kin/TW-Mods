local function setup_diplo()
	cm:force_diplomacy("faction:wh2_main_emp_the_moot", "faction:wh_main_emp_empire", "all", true, true, true);
    cm:force_diplomacy("faction:wh2_main_emp_the_moot", "faction:wh_main_emp_empire", "war", false, false, true);
    cm:force_diplomacy("faction:wh2_main_emp_the_moot", "faction:wh_main_emp_empire", "break alliance", false, false, true);
end

local function halflings_init()
    local faction_key = "wh2_main_emp_the_moot"
    local faction_obj = cm:get_faction(faction_key)

    if not faction_obj or faction_obj:is_null_interface() then
      -- faction doesn't exist in this campaign or has already died
      return false
    end

    if faction_obj:is_human() then
        core:add_listener(
            "halfling_gift_listener",
            "CharacterPerformsSettlementOccupationDecision",
            function(context)
                return context:character():faction():name() == faction_key 
                and context:occupation_decision() == "2205198931"
            end,
            function(context)
                if cm:model():turn_number() < 25 then
                    ovn_early_imperial_reinforcements(faction_key)
                else
                    ovn_late_imperial_reinforcements(faction_key)
                end
            end,
            true
        )           
    end;
end

cm:add_first_tick_callback(
    function() 
        halflings_init()
    end
)