local subculture_levels = {
    ["wh_dlc03_sc_bst_beastmen"] = "35", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_dlc05_sc_wef_wood_elves"] = "0", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_main_sc_brt_bretonnia"] = "0", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_main_sc_chs_chaos"] = "25", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_main_sc_dwf_dwarfs"] = "0", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_main_sc_emp_empire"] = "0", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_main_sc_grn_greenskins"] = "15", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_main_sc_grn_savage_orcs"] = "15", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_main_sc_ksl_kislev"] = "0", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_main_sc_nor_norsca"] = "35", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_main_sc_teb_teb"] = "0", -- 5/10/15/20/25/30/35/40/45/50
    ["wh_main_sc_vmp_vampire_counts"] = "15", -- 5/10/15/20/25/30/35/40/45/50
    ["wh2_dlc09_rogue_black_creek_raiders"] = "0",
    ["wh2_dlc09_rogue_dwellers_of_zardok"] = "0",
    ["wh2_dlc09_rogue_eyes_of_the_jungle"] = "0",
    ["wh2_dlc09_rogue_pilgrims_of_myrmidia"] = "0",
    ["wh2_dlc09_sc_tmb_tomb_kings"] = "0", -- 5/10/15/20/25/30/35/40/45/50
    ["wh2_dlc11_brt_bretonnia_dil"] = "0",
    ["wh2_dlc11_cst_harpoon_the_sunken_land_corsairs"] = "0",
    ["wh2_dlc11_cst_rogue_bleak_coast_buccaneers"] = "0",
    ["wh2_dlc11_cst_rogue_boyz_of_the_forbidden_coast"] = "0",
    ["wh2_dlc11_cst_rogue_freebooters_of_port_royale"] = "0",
    ["wh2_dlc11_cst_rogue_grey_point_scuttlers"] = "0",
    ["wh2_dlc11_cst_rogue_terrors_of_the_dark_straights"] = "0",
    ["wh2_dlc11_cst_rogue_the_churning_gulf_raiders"] = "0",
    ["wh2_dlc11_cst_rogue_tyrants_of_the_black_ocean"] = "0",
    ["wh2_dlc11_cst_shanty_dragon_spine_privateers"] = "0",
    ["wh2_dlc11_cst_shanty_middle_sea_brigands"] = "0",
    ["wh2_dlc11_cst_shanty_shark_straight_seadogs"] = "0",
    ["wh2_dlc11_def_dark_elves_dil"] = "0",
    ["wh2_dlc11_emp_empire_dil"] = "0",
    ["wh2_dlc11_nor_norsca_dil"] = "0",
    ["wh2_dlc11_nor_norsca_qb4"] = "0",
    ["wh2_dlc11_sc_cst_vampire_coast"] = "15", -- 5/10/15/20/25/30/35/40/45/50
    ["wh2_main_rogue_abominations"] = "0",
    ["wh2_main_rogue_beastcatchas"] = "0",
    ["wh2_main_rogue_bernhoffs_brigands"] = "0",
    ["wh2_main_rogue_black_spider_tribe"] = "0",
    ["wh2_main_rogue_boneclubbers_tribe"] = "0",
    ["wh2_main_rogue_celestial_storm"] = "0",
    ["wh2_main_rogue_college_of_pyrotechnics"] = "0",
    ["wh2_main_rogue_doomseekers"] = "0",
    ["wh2_main_rogue_gerhardts_mercenaries"] = "0",
    ["wh2_main_rogue_heirs_of_mourkain"] = "0",
    ["wh2_main_rogue_hung_warband"] = "0",
    ["wh2_main_rogue_hunters_of_kurnous"] = "0",
    ["wh2_main_rogue_jerrods_errantry"] = "0",
    ["wh2_main_rogue_mangy_houndz"] = "0",
    ["wh2_main_rogue_mengils_manflayers"] = "0",
    ["wh2_main_rogue_morrsliebs_howlers"] = "0",
    ["wh2_main_rogue_pirates_of_the_far_sea"] = "0",
    ["wh2_main_rogue_pirates_of_the_southern_ocean"] = "0",
    ["wh2_main_rogue_pirates_of_trantio"] = "0",
    ["wh2_main_rogue_scions_of_tesseninck"] = "0",
    ["wh2_main_rogue_scourge_of_aquitaine"] = "0",
    ["wh2_main_rogue_stuff_snatchers"] = "0",
    ["wh2_main_rogue_teef_snatchaz"] = "0",
    ["wh2_main_rogue_the_wandering_dead"] = "0",
    ["wh2_main_rogue_tor_elithis"] = "0",
    ["wh2_main_rogue_troll_skullz"] = "0",
    ["wh2_main_rogue_vashnaar"] = "0",
    ["wh2_main_rogue_vauls_expedition"] = "0",
    ["wh2_main_rogue_worldroot_rangers"] = "0",
    ["wh2_main_rogue_wrath_of_nature"] = "0",
    ["wh2_main_sc_def_dark_elves"] = "5", -- 5/10/15/20/25/30/35/40/45/50
    ["wh2_main_sc_hef_high_elves"] = "0", -- 5/10/15/20/25/30/35/40/45/50
    ["wh2_main_sc_lzd_lizardmen"] = "0", -- 5/10/15/20/25/30/35/40/45/50
    ["wh2_main_sc_skv_skaven"] = "10" -- 5/10/15/20/25/30/35/40/45/50
} --:map<string, string>

local effect_bundles = {
    "sm0_buff_5",
    "sm0_buff_10",
    "sm0_buff_15",
    "sm0_buff_20",
    "sm0_buff_25",
    "sm0_buff_30",
    "sm0_buff_35",
    "sm0_buff_40",
    "sm0_buff_45",
    "sm0_buff_50"
} --:vector<string>

function sm0_balance()
    core:add_listener(
        "sm0_balance_FactionTurnStart",
        "FactionTurnStart",
        function(context)
            return not context:faction():is_human()
        end,
        function(context)
            local subculture = context:faction():subculture()
            local effect_bundle_key = "sm0_buff_"..subculture_levels[subculture]
            if not context:faction():has_effect_bundle(effect_bundle_key) then
                if subculture_levels[subculture] and subculture_levels[subculture] ~= "0" then
                    cm:apply_effect_bundle(effect_bundle_key, context:faction():name(), -1)
                    out("sm0/apply_effect_bundle|faction = "..context:faction():name().."|effect_bundle_key = "..effect_bundle_key)
                end
                for i = 1, #effect_bundles do
                    if context:faction():has_effect_bundle(effect_bundles[i]) and effect_bundle_key ~= effect_bundles[i] then
                        cm:remove_effect_bundle(effect_bundles[i], context:faction():name())
                        out("sm0/remove_effect_bundle|faction = "..context:faction():name().."|effect_bundle_key = "..effect_bundle_key)
                    end
                end
            else
                out("sm0/has_effect_bundle|faction = "..context:faction():name().."|effect_bundle_key = "..effect_bundle_key)
            end
        end,
        true
    )
end