core:add_listener(
    "sm0_saveBattleSpeed",
    "SavingGame",
    true,
    function(context)
        local svr_battleSpeed = core:svr_load_string("svr_battleSpeed");
        if svr_battleSpeed ~= "" then
            cm:set_saved_value("battleSpeed", svr_battleSpeed);
        end
    end,
    true
)

core:add_listener(
    "sm0_loadBattleSpeed",
    "LoadingGame",
    true,
    function(context)
        local battleSpeed = cm:get_saved_value("battleSpeed");
        core:svr_save_string("svr_battleSpeed", tostring(battleSpeed));
    end,
    true
)

core:add_listener(
    "sm0_battleCompleted",
    "BattleCompleted",
    function(context) 
        return cm:pending_battle_cache_human_is_involved();
    end,
    function(context)
        local svr_battleSpeed = core:svr_load_string("svr_battleSpeed");
        if svr_battleSpeed ~= "" then
            cm:set_saved_value("battleSpeed", svr_battleSpeed);
        end
    end,
    true
)
