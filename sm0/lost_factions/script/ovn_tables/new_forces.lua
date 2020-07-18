local new_forces = {
    ["main_warhammer"] = {

        wh2_main_arb_caliphate_of_araby = {
            faction_key = "wh2_main_arb_caliphate_of_araby",
            unit_list = "ovn_cat_knights,ovn_jez,wh_main_arb_cav_magic_carpet_0,OtF_khemri_swordsmen,OtF_khemri_archers,ovn_arb_art_grand_bombard",
            region_key = "wh2_main_great_desert_of_araby_el-kalabad",
            x = 450,
            y = 135,
            type = "general",
            subtype = "Sultan_Jaffar",
            name1 = "names_name_999982322",
            name2 = "",
            name3 = "names_name_999982323",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("character_cqi:"..cqi, 2000)
                    cm:set_character_unique("character_cqi:"..cqi, true);

                end
        },

        wh2_main_arb_aswad_scythans = {
            faction_key = "wh2_main_arb_aswad_scythans",
            unit_list = "ovn_arb_cav_lancer_camel,ovn_arb_cav_lancer_camel,ovn_arb_cav_archer_camel,wh_main_arb_mon_war_elephant,OtF_khemri_rangers,ovn_scor",
            region_key = "wh2_main_great_desert_of_araby_el-kalabad",
            x = 690,
            y = 125,
            type = "general",
            subtype = "ovn_araby_ll",
            name1 = "names_name_999982308",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("faction:wh2_main_arb_aswad_scythans,forename:999982308", 2000)
                    cm:set_character_immortality("faction:wh2_main_arb_aswad_scythans,forename:999982308", true)
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },

        wh2_main_arb_flaming_scimitar = {
            faction_key = "wh2_main_arb_flaming_scimitar",
            unit_list = "wh_main_arb_cav_magic_carpet_0,ovn_jez,OtF_khemri_kepra_guard,ovn_glad,OtF_khemri_swordsmen,ovn_ifreet,ovn_corsairs,ovn_prometheans",
            region_key = "wh2_main_great_desert_of_araby_el-kalabad",
            x = 255,
            y = 185,
            type = "general",
            subtype = "ovn_araby_ll",
            name1 = "names_name_999982318",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("character_cqi:"..cqi, 2000)
                    cm:set_character_immortality("character_cqi:"..cqi, true)
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },

        wh2_dlc11_cst_vampire_coast_rebels = {
            faction_key = "wh2_dlc11_cst_vampire_coast_rebels",
            unit_list = "wh2_dlc11_cst_inf_depth_guard_0,wh2_dlc11_cst_inf_depth_guard_1,wh2_dlc11_cst_mon_rotting_leviathan_0,wh2_dlc11_cst_mon_scurvy_dogs,wh2_dlc11_cst_inf_syreens,wh2_dlc11_cst_mon_mournguls_0,wh2_dlc11_cst_inf_zombie_deckhands_mob_1",
            region_key = "wh2_main_southern_jungle_of_pahualaxa_monument_of_the_moon",
            x = 160,
            y = 175,
            type = "general",
            subtype = "wh2_dlc11_vmp_bloodline_lahmian",
            name1 = "names_name_999982306",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:set_character_unique("character_cqi:"..cqi, true);
                    cm:add_agent_experience("faction:wh2_dlc11_cst_vampire_coast_rebels,forename:999982306", 2000)
                    cm:set_character_immortality("faction:wh2_dlc11_cst_vampire_coast_rebels,forename:999982306", true)
                    cm:add_unit_model_overrides("faction:wh2_dlc11_cst_vampire_coast_rebels,forename:999982306", "wh2_dlc11_art_set_vmp_bloodline_lahmian_01");
                    -- MODEL OVERRIDE NESSCARY OR WILL DEFAULT TO BRIGHT WIZARD
                end
        },

        wh2_main_hef_citadel_of_dusk = {
            faction_key = "wh2_main_hef_citadel_of_dusk",
            unit_list = "wh2_dlc10_hef_inf_the_storm_riders_ror_0,wh2_main_hef_inf_spearmen_0,wh2_main_hef_inf_swordmasters_of_hoeth_0,wh2_main_hef_inf_lothern_sea_guard_1,wh2_main_hef_cav_ellyrian_reavers_1,wh2_main_hef_art_eagle_claw_bolt_thrower,wh2_main_hef_mon_great_eagle",
            region_key = "wh2_main_land_of_assassins_sorcerers_islands",
            x = 215,
            y = 15,
            type = "general",
            subtype = "ovn_stormrider",
            name1 = "names_name_999982321",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },

        wh2_main_wef_treeblood = {
            faction_key = "wh2_main_wef_treeblood",
            unit_list = "wh_dlc08_nor_mon_fimir_1,ovn_shearl,elo_river_trolls,ovn_fimm,ovn_boglar,ovn_boglar,ovn_boglar,elo_fenbeast",
            region_key = "wh2_main_great_desert_of_araby_el-kalabad",
            x = 373,
            y = 634,
            type = "general",
            subtype = "aky_chief_fimir_great_weapons",
            name1 = "names_name_999982319",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("faction:wh2_main_wef_treeblood,forename:999982319", 2000)
                    cm:set_character_immortality("faction:wh2_main_wef_treeblood,forename:999982319", true);
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },

        wh_dlc08_nor_goromadny_tribe = {
            faction_key = "wh_dlc08_nor_goromadny_tribe",
            unit_list = "wh_dlc08_nor_mon_fimir_1,ovn_shearl,elo_river_trolls,ovn_fimm,ovn_boglar,ovn_boglar,ovn_boglar,elo_fenbeast",
            region_key = "wh2_main_great_desert_of_araby_el-kalabad",
            x = 653,
            y = 170,
            type = "general",
            subtype = "aky_chief_fimir_great_weapons",
            name1 = "names_name_999982314",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("faction:wh_dlc08_nor_goromadny_tribe,forename:999982314", 2000)
                    cm:set_character_immortality("faction:wh_dlc08_nor_goromadny_tribe,forename:999982314", true);
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },

        wh2_dlc09_tmb_the_sentinels = {
            faction_key = "wh2_dlc09_tmb_the_sentinels",
            unit_list = "wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,elo_tomb_guardian_2h_waepons,wh2_dlc09_tmb_inf_tomb_guard_1,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_crypt_ghouls,wh2_dlc09_tmb_cav_hexwraiths",
            region_key = "wh2_main_great_desert_of_araby_el-kalabad",
            x = 585,
            y = 85,
            type = "general",
            subtype = "Dread_King",
            name1 = "names_name_247259235",
            name2 = "",
            name3 = "names_name_247259236",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    local str = "character_cqi:"..cqi
                    cm:add_agent_experience(str, 2000)
                    cm:set_character_immortality(str, true)
                    cm:add_unit_model_overrides(str, "Dread_King");
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },

        wh2_main_emp_grudgebringers = {
            faction_key = "wh2_main_emp_grudgebringers",
            unit_list = "grudgebringer_infantry,grudgebringer_cannon,grudgebringer_crossbow,wh_dlc04_emp_inf_flagellants_0,wh2_dlc13_emp_inf_greatswords_ror_0",
            region_key = "wh2_main_great_desert_of_araby_el-kalabad",
            x = 675,
            y = 200,
            type = "general",
            subtype = "morgan_bernhardt",
            name1 = "names_name_3110890001",
            name2 = "",
            name3 = "names_name_3110890002",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("faction:wh2_main_emp_grudgebringers,forename:3110890001", 2000)
                    --cm:set_character_immortality("faction:wh2_main_emp_grudgebringers,surname:3110890002", true);
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },

        wh2_main_nor_albion = {
            faction_key = "wh2_main_nor_albion",
            unit_list = "elo_youngbloods,albion_giant,albion_swordmaiden,elo_albion_warriors,elo_albion_warriors_spears",
            region_key = "wh2_main_great_desert_of_araby_el-kalabad",
            x = 330,
            y = 566,
            type = "general",
            subtype = "albion_morrigan",
            name1 = "names_name_77777001",
            name2 = "",
            name3 = "names_name_77777002",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("character_cqi:"..cqi, 2000)
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },

        wh2_main_nor_trollz1 = {
            faction_key = "wh2_main_nor_trollz",
            unit_list = "elo_mountain_trolls,elo_river_trolls,elo_river_trolls,elo_bile_trolls",
            region_key = "wh_main_southern_badlands_galbaraz",
            x = 643,
            y = 150,
            type = "general",
            subtype = "elo_chief_ugma",
            name1 = "names_name_77779001",
            name2 = "",
            name3 = "names_name_77779002",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force("ovn_troll_devour", cqi, 7, true);
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },
        wh2_rogue_troll0 = {
            faction_key = "wh2_main_rogue_troll_skullz",
            unit_list = "elo_mountain_trolls,elo_southern_trolls,elo_southern_trolls,elo_southern_trolls,elo_bile_trolls",
            region_key = "wh2_main_great_desert_of_araby_bel_aliad",
            x = 485,
            y = 75,
            type = "general",
            subtype = "elo_cha_troll_lord",
            name1 = "names_name_2147344497",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = false,
            callback = 
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force("ovn_troll_devour", cqi, 0, true);
                end
        },

        wh2_rogue_troll = {
            faction_key = "wh2_main_rogue_troll_skullz",
            unit_list = "elo_mountain_trolls,wh_main_grn_mon_trolls,elo_forest_trolls,elo_river_trolls",
            region_key = "wh_main_averland_grenzstadt",
            x = 600,
            y = 390,
            type = "general",
            subtype = "elo_cha_troll_lord",
            name1 = "names_name_2147344529",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force("ovn_troll_devour", cqi, 0, true);
                end
        },

        wh2_rogue_troll2 = {
            faction_key = "wh2_main_rogue_troll_skullz",
            unit_list = "elo_mountain_trolls,elo_forest_trolls,wh_main_grn_mon_trolls,elo_river_trolls",
            region_key = "wh_main_talabecland_kappelburg",
            x = 530, 
            y = 545,
            type = "general",
            subtype = "elo_cha_troll_lord",
            name1 = "names_name_2147344759",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = false,
            callback = 
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force("ovn_troll_devour", cqi, 0, true);
                end
        },

    
        wh2_rogue_troll3 = {
            faction_key = "wh2_main_rogue_troll_skullz",
            unit_list = "elo_mountain_trolls,wh_main_grn_mon_trolls,elo_forest_trolls,elo_snow_troll",
            region_key = "wh_main_troll_country_zoishenk",
            x = 660,
            y = 580,
            type = "general",
            subtype = "elo_cha_troll_lord",
            name1 = "names_name_2147344489",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = false,
            callback = 
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force("ovn_troll_devour", cqi, 0, true);
                end
        },

        wh2_rogue_troll4 = {
            faction_key = "wh2_main_rogue_troll_skullz",
            unit_list = "elo_mountain_trolls,elo_southern_trolls,elo_southern_trolls,elo_southern_trolls",
            region_key = "wh2_main_great_desert_of_araby_bel_aliad",
            x = 685,
            y = 75,
            type = "general",
            subtype = "elo_cha_troll_lord",
            name1 = "names_name_2147344443",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = false,
            callback = 
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force("ovn_troll_devour", cqi, 0, true);
                end
        },

        wh2_rogue_troll5 = {
            faction_key = "wh2_main_rogue_troll_skullz",
            unit_list = "elo_mountain_trolls,elo_southern_trolls,elo_southern_trolls,elo_southern_trolls",
            region_key = "wh2_main_great_desert_of_araby_bel_aliad",
            x = 680,
            y = 328,
            type = "general",
            subtype = "elo_cha_troll_lord",
            name1 = "names_name_2147344501",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = false,
            callback = 
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force("ovn_troll_devour", cqi, 0, true);
                end
        },

        wh2_main_emp_the_moot = {
            faction_key = "wh2_main_emp_the_moot",
            unit_list = "halfling_archer,ovn_mtl_cav_poultry_riders_0,sr_ogre,halfling_cook,halfling_spear,halfling_inf",
            region_key = "wh2_main_northern_great_jungle_temple_of_tlencan",
            x = 620,
            y = 407,
            type = "general",
            subtype = "ovn_hlf_moot_general",
            name1 = "names_name_999982316",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("faction:wh2_main_emp_the_moot,forname:999982316", 2000)
                    cm:set_character_immortality("faction:wh2_main_emp_the_moot,forename:999982316", true);
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        }   
    },

    ["wh2_main_great_vortex"] = {
        wh2_dlc09_tmb_the_sentinels = {
            faction_key = "wh2_dlc09_tmb_the_sentinels",
            unit_list = "wh2_dlc09_tmb_inf_skeleton_archers_0,wh2_dlc09_tmb_inf_skeleton_warriors_0,elo_tomb_guardian_2h_waepons,wh2_dlc09_tmb_inf_tomb_guard_1,wh2_dlc09_tmb_inf_skeleton_spearmen_0,wh2_dlc09_tmb_inf_crypt_ghouls,wh2_dlc09_tmb_cav_hexwraiths",
            region_key = "wh2_main_vor_ash_river_quatar",
            x = 630,
            y = 275,
            type = "general",
            subtype = "Dread_King",
            name1 = "names_name_247259235",
            name2 = "",
            name3 = "names_name_247259236",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("faction:wh2_dlc09_tmb_the_sentinels,forename:247259235", 2000)
                    cm:set_character_immortality("faction:wh2_dlc09_tmb_the_sentinels,forename:247259235", true)
                    cm:add_unit_model_overrides("faction:wh2_dlc09_tmb_the_sentinels,forename:247259235", "Dread_King")
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },
        
        wh2_main_arb_caliphate_of_araby = {
            faction_key = "wh2_main_arb_caliphate_of_araby",
            unit_list = "ovn_cat_knights,ovn_jez,wh_main_arb_cav_magic_carpet_0,OtF_khemri_swordsmen,OtF_khemri_archers,ovn_arb_art_grand_bombard",
            region_key = "wh2_main_vor_coast_of_araby_al_haikk",
            x = 560,
            y = 330,
            type = "general",
            subtype = "Sultan_Jaffar",
            name1 = "names_name_999982322",
            name2 = "",
            name3 = "names_name_999982323",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:set_character_unique("character_cqi:"..cqi, true);
                    cm:add_agent_experience("faction:wh2_main_arb_caliphate_of_araby,forename:247258412", 2000)
                    cm:set_character_immortality("faction:wh2_main_arb_caliphate_of_araby,forename:247258412", true)
                end
        },

        wh2_main_arb_aswad_scythans = {
            faction_key = "wh2_main_arb_aswad_scythans",
            unit_list = "ovn_arb_cav_lancer_camel,ovn_arb_cav_lancer_camel,ovn_arb_cav_archer_camel,wh_main_arb_mon_war_elephant,OtF_khemri_rangers,ovn_scor",
            region_key = "wh2_main_vor_coast_of_araby_al_haikk",
            x = 700,
            y = 265, 
            type = "general",
            subtype = "ovn_araby_ll",
            name1 = "names_name_999982308",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:set_character_unique("character_cqi:"..cqi, true);
                    cm:add_agent_experience("faction:wh2_main_arb_aswad_scythans,forename:999982308", 2000)
                    cm:set_character_immortality("faction:wh2_main_arb_aswad_scythans,forename:999982308", true)
                end
        },

        wh2_main_arb_flaming_scimitar = {
            faction_key = "wh2_main_arb_flaming_scimitar",
            unit_list = "wh_main_arb_cav_magic_carpet_0,ovn_jez,OtF_khemri_kepra_guard,ovn_glad,OtF_khemri_swordsmen,ovn_ifreet,ovn_corsairs,ovn_prometheans",
            region_key = "wh2_main_vor_coast_of_araby_al_haikk",
            x = 277,
            y = 310,
            type = "general",	
            subtype = "ovn_araby_ll",
            name1 = "names_name_999982318",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:set_character_unique("character_cqi:"..cqi, true);
                    cm:add_agent_experience("faction:wh2_main_arb_flaming_scimitar,forename:999982318", 2000)
                    cm:set_character_immortality("faction:wh2_main_arb_flaming_scimitar,forename:999982318", true)
                end
        },

        wh2_dlc11_cst_vampire_coast_rebels = {
            faction_key = "wh2_dlc11_cst_vampire_coast_rebels",
            unit_list = "wh2_dlc11_cst_inf_depth_guard_0,wh2_dlc11_cst_inf_depth_guard_1,wh2_dlc11_cst_mon_rotting_leviathan_0,wh2_dlc11_cst_mon_scurvy_dogs,wh2_dlc11_cst_inf_syreens,wh2_dlc11_cst_mon_mournguls_0,wh2_dlc11_cst_inf_zombie_deckhands_mob_1",
            region_key = "wh2_main_vor_coast_of_araby_copher",
            x = 240,
            y = 315,
            type = "general",
            subtype = "wh2_dlc11_vmp_bloodline_lahmian",
            name1 = "names_name_999982306",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:set_character_unique("character_cqi:"..cqi, true);
                    cm:add_agent_experience("faction:wh2_dlc11_cst_vampire_coast_rebels,forename:999982306", 2000)
                    cm:set_character_immortality("faction:wh2_dlc11_cst_vampire_coast_rebels,forename:999982306", true)
                    cm:add_unit_model_overrides("faction:wh2_dlc11_cst_vampire_coast_rebels,forename:999982306", "wh2_dlc11_art_set_vmp_bloodline_lahmian_01");
                    -- MODEL OVERRIDE NECESSCARY OR WILL DEFAULT TO BRIGHT WIZARD
                end
        },

        wh2_main_hef_citadel_of_dusk = {
            faction_key = "wh2_main_hef_citadel_of_dusk",
            unit_list = "wh2_dlc10_hef_inf_the_storm_riders_ror_0,wh2_main_hef_inf_spearmen_0,wh2_main_hef_inf_swordmasters_of_hoeth_0,wh2_main_hef_inf_lothern_sea_guard_1,wh2_main_hef_cav_ellyrian_reavers_1,wh2_main_hef_art_eagle_claw_bolt_thrower,wh2_main_hef_mon_great_eagle",
            region_key = "wh2_main_vor_cothique_mistnar",
            x = 330,
            y = 57,   
            type = "general",	
            subtype = "ovn_stormrider",
            name1 = "names_name_999982321",
            name2 = "",
            name3 = "",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },

        wh2_main_nor_albion = {
            faction_key = "wh2_main_nor_albion",
            unit_list = "elo_youngbloods,albion_giant,albion_swordmaiden,elo_albion_warriors,elo_albion_warriors_spears",
            region_key = "wh2_main_vor_coast_of_araby_al_haikk",
            x = 655,
            y = 660,
            type = "general",
            subtype = "albion_morrigan",
            name1 = "names_name_77777001",
            name2 = "",
            name3 = "names_name_77777002",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("character_cqi:"..cqi, 2000)
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        },

        wh2_main_emp_grudgebringers = {
            faction_key = "wh2_main_emp_grudgebringers",
            unit_list = "grudgebringer_infantry,grudgebringer_cannon,grudgebringer_crossbow,wh_dlc04_emp_inf_flagellants_0,wh2_dlc13_emp_inf_greatswords_ror_0",
            region_key = "wh2_main_vor_ash_river_quatar",
            x = 715,
            y = 305,
            type = "general",
            subtype = "morgan_bernhardt",
            name1 = "names_name_3110890001",
            name2 = "",
            name3 = "names_name_3110890002",
            name4 = "",
            make_faction_leader = true,
            callback = 
                function(cqi)
                    cm:add_agent_experience("faction:wh2_main_emp_grudgebringers,forename:3110890001", 2000)
                    --cm:set_character_immortality("faction:wh2_main_emp_grudgebringers,surname:3110890002", true);
                    cm:set_character_unique("character_cqi:"..cqi, true);
                end
        }
    }
}

return new_forces