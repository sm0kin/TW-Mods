core:add_listener(
    "sm0_loadBattleSpeed_preBattle",
    "PanelOpenedCampaign", 
    function(context) 
        return context.string == "popup_pre_battle"
    end,
    function(context)
        local battleSpeed = cm:get_saved_value("battleSpeed")
        out("sm0/PreBattlePanel = "..tostring(battleSpeed).."/cm:is_processing_battle() = "..tostring(cm:is_processing_battle()))
        if battleSpeed and core:svr_load_string("svr_battleSpeed") == "" then core:svr_save_string("svr_battleSpeed", tostring(battleSpeed)) end
    end,
    true
)

core:add_listener(
    "sm0_saveBattleSpeed_postBattle",
    "BattleCompleted",
    function(context) 
        return cm:pending_battle_cache_human_is_involved()
    end,
    function(context)
        local svr_battleSpeed = core:svr_load_string("svr_battleSpeed")
        out("sm0/BattleCompleted = "..tostring(svr_battleSpeed).."/cm:is_processing_battle() = "..tostring(cm:is_processing_battle()))
        if svr_battleSpeed ~= "" then
            cm:set_saved_value("battleSpeed", svr_battleSpeed)
        end
    end,
    true
)