function sm0_ai_exp()
    core:add_listener (
        "CharactersGetEXP",
        "CharacterTurnStart",
        function(context)
            return not context:character():faction():is_human()
        end,
        function(context)
            local char = context:character()
            if cm:char_is_general(char) and 
            ((char:has_military_force() and not char:military_force():is_armed_citizenry() and char:rank() < 20) or (char:is_faction_leader() and char:rank() <= 30)) then
                cm:add_agent_experience(cm:char_lookup_str(char:command_queue_index()), 500, false)
            end
        end,
        true
    )
end