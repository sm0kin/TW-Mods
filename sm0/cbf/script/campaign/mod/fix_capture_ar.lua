-- DONT USE THIS

function lair_BattleCompleted(context)
    local pending_battle = cm:model():pending_battle();

    if pending_battle:is_auto_resolved() == true then
        local warden = cm:model():world():faction_by_key("wh2_main_hef_yvresse");

        if warden:is_human() == true then
            local prison_system = cm:model():prison_system();
            local prisoners = prison_system:get_faction_prisoners(warden);

            if prisoners:num_items() < lair_max_prisoners then
                if cm:pending_battle_cache_faction_is_attacker("wh2_main_hef_yvresse") then
                    local fought = pending_battle:has_been_fought();
                    local attacker_battle_result = pending_battle:attacker_battle_result();
                    local defender_battle_result = pending_battle:defender_battle_result();
                    local retreat = attacker_battle_result == defender_battle_result;

                    if fought == true and retreat == false then
                        if cm:model():random_percent(lair_autoresolve_caputre_chance) then
                            local num_defenders = cm:pending_battle_cache_num_defenders();
                            if pb:night_battle() == true then 
                                num_defenders = 1
                            end
                            for i = 1, num_defenders do
                                local defender_cqi, defender_force_cqi, defender_name = cm:pending_battle_cache_get_defender(i);
                                local enemy = cm:model():character_for_command_queue_index(defender_cqi);

                                if enemy:is_null_interface() == false and enemy:has_military_force() == true and enemy:military_force():is_armed_citizenry() == false then
                                    cm:faction_imprison_character(warden, enemy);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
