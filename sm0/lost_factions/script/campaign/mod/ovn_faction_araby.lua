local function setup_diplo()
	cm:force_diplomacy("faction:wh2_main_arb_caliphate_of_araby", "culture:wh_main_brt_bretonnia", "military alliance", false, false, true)
    cm:force_diplomacy("faction:wh2_main_arb_caliphate_of_araby", "culture:wh_main_brt_bretonnia", "defensive alliance", false, false, true)
    
	cm:force_diplomacy("faction:wh2_main_arb_aswad_scythans", "culture:wh_main_brt_bretonnia", "military alliance", false, false, true)
    cm:force_diplomacy("faction:wh2_main_arb_aswad_scythans", "culture:wh_main_brt_bretonnia", "defensive alliance", false, false, true)
    
	cm:force_diplomacy("faction:wh2_main_arb_flaming_scimitar", "culture:wh_main_brt_bretonnia", "military alliance", false, false, true)
	cm:force_diplomacy("faction:wh2_main_arb_flaming_scimitar", "culture:wh_main_brt_bretonnia", "defensive alliance", false, false, true)

    cm:force_diplomacy("faction:wh2_main_arb_aswad_scythans", "faction:wh2_dlc09_tmb_numas", "all", true, true, true);
    cm:force_diplomacy("faction:wh2_main_arb_aswad_scythans", "faction:wh2_dlc09_tmb_numas", "war", false, false, true);
    cm:force_diplomacy("faction:wh2_main_arb_aswad_scythans", "faction:wh2_dlc09_tmb_numas", "break alliance", false, false, true);

    cm:force_diplomacy("subculture:wh_main_sc_emp_araby", "culture:wh_main_chs_chaos", "all", true, true, true);

end

local function araby_init()
    setup_diplo()
end

cm:add_first_tick_callback(
    function()
        araby_init()
    end
)