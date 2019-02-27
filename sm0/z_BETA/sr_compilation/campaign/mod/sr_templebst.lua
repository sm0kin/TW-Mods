local function sr_templebst()
    if cm:model():campaign_name("main_warhammer") then
        if cm:is_new_game() then
            core:add_listener(
                "templebststartmesslistner",
                "FactionRoundStart",
                function(context)
                    return context:faction():is_human() and cm:model():turn_number() == 5
                end,
                function()
                    templebststartmess()
                end,
                false
            )

            --OLD WORLD SITE "A" POTENIAL SPAWNS

            if 1 == cm:random_number(2, 1) then
                cm:create_force_with_general(
                    "wh_dlc03_bst_redhorn",
                    "wh_bst_inf_khorngor_herd,wh_bst_inf_khorngor_herd,wh_bst_inf_khorngor_herd,wh_dlc03_bst_inf_minotaurs_2,wh_dlc03_bst_mon_giant_0,wh_dlc03_bst_inf_centigors_2,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_minotaurs_2,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                    "wh2_main_great_desert_of_araby_el-kalabad",
                    532,
                    470,
                    "general",
                    "dlc03_bst_beastlord",
                    "names_name_999982302",
                    "",
                    "",
                    "",
                    false,
                    function(cqi)
                        cm:apply_effect_bundle_to_characters_force(
                            "wh_main_bundle_military_upkeep_free_force",
                            cqi,
                            -1,
                            true
                        )
                        cm:apply_effect_bundle_to_characters_force("sr_Khar", cqi, -1, true)
                        cm:add_agent_experience("faction:wh_dlc03_bst_redhorn,forename:999982302", 25000)
                        --cm:force_character_force_into_stance("faction:wh_dlc03_bst_redhorn,forename:999982302", "MILITARY_FORCE_ACTIVE_STANCE_TYPE_AMBUSH")
                        cm:disable_movement_for_character(
                            "faction:wh_dlc03_bst_redhorn,type:dlc03_bst_beastlord,forename:999982302"
                        )
                    end
                )
            else
                cm:create_force_with_general(
                    "wh_dlc03_bst_redhorn",
                    "wh_bst_inf_khorngor_herd,wh_bst_inf_khorngor_herd,wh_bst_inf_khorngor_herd,wh_dlc03_bst_inf_minotaurs_2,wh_dlc03_bst_mon_giant_0,wh_dlc03_bst_inf_centigors_2,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_minotaurs_2,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                    "wh2_main_great_desert_of_araby_el-kalabad",
                    471,
                    533,
                    "general",
                    "dlc03_bst_beastlord",
                    "names_name_999982302",
                    "",
                    "",
                    "",
                    false,
                    function(cqi)
                        cm:apply_effect_bundle_to_characters_force(
                            "wh_main_bundle_military_upkeep_free_force",
                            cqi,
                            -1,
                            true
                        )
                        cm:apply_effect_bundle_to_characters_force("sr_Khar", cqi, -1, true)
                        cm:add_agent_experience("faction:wh_dlc03_bst_redhorn,forename:999982302", 25000)
                        --cm:force_character_force_into_stance("faction:wh_dlc03_bst_redhorn,forename:999982302", "MILITARY_FORCE_ACTIVE_STANCE_TYPE_AMBUSH")
                        cm:disable_movement_for_character(
                            "faction:wh_dlc03_bst_redhorn,type:dlc03_bst_beastlord,forename:999982302"
                        )
                    end
                )
            end

            --OLD WORLD SITE "B" POTENIAL SPAWNS

            if 1 == cm:random_number(2, 1) then
                cm:create_force_with_general(
                    "wh_dlc03_bst_redhorn",
                    "wh_bst_inf_pestigor_herd,wh_bst_inf_pestigor_herd,wh_bst_inf_pestigor_herd,wh_dlc03_bst_mon_chaos_spawn_0,wh_dlc03_bst_mon_chaos_spawn_0,wh_dlc03_bst_inf_centigors_2,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_chaos_warhounds_1,wh_dlc03_bst_inf_chaos_warhounds_1,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_0,wh_dlc03_bst_mon_chaos_spawn_0,wh_dlc03_bst_inf_minotaurs_2,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_chaos_warhounds_1,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                    "wh2_main_great_desert_of_araby_el-kalabad",
                    648,
                    575,
                    "general",
                    "dlc03_bst_beastlord",
                    "names_name_999982303",
                    "",
                    "",
                    "",
                    false,
                    function(cqi)
                        cm:apply_effect_bundle_to_characters_force(
                            "wh_main_bundle_military_upkeep_free_force",
                            cqi,
                            -1,
                            true
                        )
                        cm:apply_effect_bundle_to_characters_force("sr_Nurgh", cqi, -1, true)
                        cm:add_agent_experience("faction:wh_dlc03_bst_redhorn,forename:999982303", 25000)
                        --cm:force_character_force_into_stance("faction:wh_dlc03_bst_redhorn,forename:999982303", "MILITARY_FORCE_ACTIVE_STANCE_TYPE_AMBUSH")
                        cm:disable_movement_for_character(
                            "faction:wh_dlc03_bst_redhorn,type:dlc03_bst_beastlord,forename:999982303"
                        )
                    end
                )
            else
                cm:create_force_with_general(
                    "wh_dlc03_bst_redhorn",
                    "wh_bst_inf_pestigor_herd,wh_bst_inf_pestigor_herd,wh_bst_inf_pestigor_herd,wh_dlc03_bst_mon_chaos_spawn_0,wh_dlc03_bst_mon_chaos_spawn_0,wh_dlc03_bst_inf_centigors_2,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_chaos_warhounds_1,wh_dlc03_bst_inf_chaos_warhounds_1,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_0,wh_dlc03_bst_mon_chaos_spawn_0,wh_dlc03_bst_inf_minotaurs_2,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_chaos_warhounds_1,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                    "wh2_main_great_desert_of_araby_el-kalabad",
                    628,
                    493,
                    "general",
                    "dlc03_bst_beastlord",
                    "names_name_999982303",
                    "",
                    "",
                    "",
                    false,
                    function(cqi)
                        cm:apply_effect_bundle_to_characters_force(
                            "wh_main_bundle_military_upkeep_free_force",
                            cqi,
                            -1,
                            true
                        )
                        cm:apply_effect_bundle_to_characters_force("sr_Nurgh", cqi, -1, true)
                        cm:add_agent_experience("faction:wh_dlc03_bst_redhorn,forename:999982303", 25000)
                        --cm:force_character_force_into_stance("faction:wh_dlc03_bst_redhorn,forename:999982303", "MILITARY_FORCE_ACTIVE_STANCE_TYPE_AMBUSH")
                        cm:disable_movement_for_character(
                            "faction:wh_dlc03_bst_redhorn,type:dlc03_bst_beastlord,forename:999982303"
                        )
                    end
                )
            end

            --NAGGAROND SPAWN (USES wh2_main_bst_manblight FACTION)

            if 1 == cm:random_number(2, 1) then
                cm:create_force_with_general(
                    "wh2_main_bst_manblight",
                    "wh_bst_inf_slaangor_herd,wh_bst_inf_slaangor_herd,wh_bst_inf_slaangor_herd,wh_dlc03_bst_cav_razorgor_chariot_0,wh_dlc03_bst_cav_razorgor_chariot_0,wh_dlc03_bst_inf_centigors_2,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_centigors_1,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_minotaurs_2,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                    "wh2_main_great_desert_of_araby_el-kalabad",
                    163,
                    703,
                    "general",
                    "dlc03_bst_beastlord",
                    "names_name_999982301",
                    "",
                    "",
                    "",
                    false,
                    function(cqi)
                        cm:apply_effect_bundle_to_characters_force(
                            "wh_main_bundle_military_upkeep_free_force",
                            cqi,
                            -1,
                            true
                        )
                        cm:apply_effect_bundle_to_characters_force("sr_Slaa", cqi, -1, true)
                        cm:add_agent_experience("faction:wh2_main_bst_manblight,forename:999982301", 25000)
                        --cm:force_character_force_into_stance("faction:wh2_main_bst_manblight,forename:999982301", "MILITARY_FORCE_ACTIVE_STANCE_TYPE_AMBUSH")
                        cm:disable_movement_for_character(
                            "faction:wh2_main_bst_manblight,type:dlc03_bst_beastlord,forename:999982301"
                        )
                    end
                )
            else
                cm:create_force_with_general(
                    "wh2_main_bst_manblight",
                    "wh_bst_inf_slaangor_herd,wh_bst_inf_slaangor_herd,wh_bst_inf_slaangor_herd,wh_dlc03_bst_cav_razorgor_chariot_0,wh_dlc03_bst_cav_razorgor_chariot_0,wh_dlc03_bst_inf_centigors_2,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_centigors_1,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_minotaurs_2,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                    "wh2_main_great_desert_of_araby_el-kalabad",
                    61,
                    492,
                    "general",
                    "dlc03_bst_beastlord",
                    "names_name_999982301",
                    "",
                    "",
                    "",
                    false,
                    function(cqi)
                        cm:apply_effect_bundle_to_characters_force(
                            "wh_main_bundle_military_upkeep_free_force",
                            cqi,
                            -1,
                            true
                        )
                        cm:apply_effect_bundle_to_characters_force("sr_Slaa", cqi, -1, true)
                        cm:add_agent_experience("faction:wh2_main_bst_manblight,forename:999982301", 25000)
                        --cm:force_character_force_into_stance("faction:wh2_main_bst_manblight,forename:999982301", "MILITARY_FORCE_ACTIVE_STANCE_TYPE_AMBUSH")
                        cm:disable_movement_for_character(
                            "faction:wh2_main_bst_manblight,type:dlc03_bst_beastlord,forename:999982301"
                        )
                    end
                )
            end

            --ARABY SPAWN (USES wh2_main_bst_blooded_axe FACTION)

            if 1 == cm:random_number(2, 1) then
                cm:create_force_with_general(
                    "wh2_main_bst_blooded_axe",
                    "wh_bst_inf_tzaangor_herd,wh_bst_inf_tzaangor_herd,wh_bst_inf_tzaangor_herd,wh_dlc05_bst_mon_harpies_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_centigors_2,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_chaos_warhounds_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_minotaurs_0,wh_dlc03_bst_mon_giant_0,wh_dlc03_bst_inf_minotaurs_2,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                    "wh2_main_great_desert_of_araby_el-kalabad",
                    446,
                    85,
                    "general",
                    "dlc03_bst_beastlord",
                    "names_name_999982304",
                    "",
                    "",
                    "",
                    false,
                    function(cqi)
                        cm:apply_effect_bundle_to_characters_force(
                            "wh_main_bundle_military_upkeep_free_force",
                            cqi,
                            -1,
                            true
                        )
                        cm:apply_effect_bundle_to_characters_force("sr_Tzeen", cqi, -1, true)
                        cm:add_agent_experience("faction:wh2_main_bst_blooded_axe,forename:999982304", 25000)
                        --cm:force_character_force_into_stance("faction:wh2_main_bst_blooded_axe,forename:999982304", "MILITARY_FORCE_ACTIVE_STANCE_TYPE_AMBUSH")
                        cm:disable_movement_for_character(
                            "faction:wh2_main_bst_blooded_axe,type:dlc03_bst_beastlord,forename:999982304"
                        )
                    end
                )
            else
                cm:create_force_with_general(
                    "wh2_main_bst_blooded_axe",
                    "wh_bst_inf_tzaangor_herd,wh_bst_inf_tzaangor_herd,wh_bst_inf_tzaangor_herd,wh_dlc05_bst_mon_harpies_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_centigors_2,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_chaos_warhounds_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_minotaurs_0,wh_dlc03_bst_mon_giant_0,wh_dlc03_bst_inf_minotaurs_2,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                    "wh2_main_great_desert_of_araby_el-kalabad",
                    436,
                    46,
                    "general",
                    "dlc03_bst_beastlord",
                    "names_name_999982304",
                    "",
                    "",
                    "",
                    false,
                    function(cqi)
                        cm:apply_effect_bundle_to_characters_force(
                            "wh_main_bundle_military_upkeep_free_force",
                            cqi,
                            -1,
                            true
                        )
                        cm:apply_effect_bundle_to_characters_force("sr_Tzeen", cqi, -1, true)
                        cm:add_agent_experience("faction:wh2_main_bst_blooded_axe,forename:999982304", 25000)
                        --cm:force_character_force_into_stance("faction:wh2_main_bst_blooded_axe,forename:999982304", "MILITARY_FORCE_ACTIVE_STANCE_TYPE_AMBUSH")
                        cm:disable_movement_for_character(
                            "faction:wh2_main_bst_blooded_axe,type:dlc03_bst_beastlord,forename:999982304"
                        )
                    end
                )
            end

            templebst_listener()
            templebst_nag_listener()
            templebst_araby_listener()
        else
            templebst_listener()
            templebst_nag_listener()
            templebst_araby_listener()
        end
    end
end

function templebst_listener()
    core:add_listener(
        "templebst_listener_add",
        "FactionRoundStart",
        function(context)
            return context:faction():is_human() and cm:model():turn_number() >= 5
        end,
        function()
            templebst_spawn()
        end,
        true
    )
end

function templebst_nag_listener()
    core:add_listener(
        "templebst_nag_listener_add",
        "FactionRoundStart",
        function(context)
            return context:faction():is_human() and cm:model():turn_number() >= 5
        end,
        function()
            templebst_nag_spawn()
        end,
        true
    )
end

function templebst_araby_listener()
    core:add_listener(
        "templebst_araby_listener_add",
        "FactionRoundStart",
        function(context)
            return context:faction():is_human() and cm:model():turn_number() >= 5
        end,
        function()
            templebst_araby_spawn()
        end,
        true
    )
end

function templebst_spawn()
    charA = nil
    charB = nil

    local current_faction = cm:get_faction("wh_dlc03_bst_redhorn")
    local char_list = current_faction:character_list()

    for i = 0, char_list:num_items() - 1 do
        local current_char = char_list:item_at(i)

        if current_char:forename("names_name_999982303") then
            charA = current_char
        elseif current_char:forename("names_name_999982302") then
            charB = current_char
        end
    end

    if not charA and not charB then
        core:remove_listener("templebst_listener_add")
    elseif 1 == cm:random_number(66, 1) then
        cm:create_force(
            "wh_dlc03_bst_redhorn",
            "wh_bst_inf_khorngor_herd,wh_bst_inf_khorngor_herd,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_mon_giant_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_ungor_spearmen_1,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
            "wh2_main_kingdom_of_beasts_serpent_coast",
            470,
            438,
            true,
            function(cqi)
                cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
            end
        )

        templebstspawnmess()
    elseif 2 == cm:random_number(66, 1) then
        cm:create_force(
            "wh_dlc03_bst_redhorn",
            "wh_bst_inf_khorngor_herd,wh_bst_inf_khorngor_herd,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_mon_giant_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_ungor_spearmen_1,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
            "wh2_main_kingdom_of_beasts_serpent_coast",
            650,
            460,
            true,
            function(cqi)
                cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
            end
        )

        templebstspawnmess()
    elseif 3 == cm:random_number(66, 1) then
        cm:create_force(
            "wh_dlc03_bst_redhorn",
            "wh_bst_inf_pestigor_herd,wh_bst_inf_pestigor_herd,wh_dlc03_bst_mon_chaos_spawn_0,wh_dlc03_bst_mon_chaos_spawn_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_chaos_warhounds_1,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_chaos_warhounds_1,wh_dlc03_bst_inf_ungor_spearmen_1,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
            "wh2_main_kingdom_of_beasts_serpent_coast",
            700,
            560,
            true,
            function(cqi)
                cm:apply_effect_bundle_to_characters_force("wh_main_bundle_military_upkeep_free_force", cqi, -1, true)
            end
        )

        templebstspawnmess()
    end
end

function templebst_nag_spawn()
    if cm:get_faction("wh2_main_bst_manblight"):is_dead() then
        core:remove_listener("templebst_nag_listener_add")
    end

    charC = nil
    local current_faction = cm:get_faction("wh2_main_bst_manblight")
    local char_list = current_faction:character_list()

    for i = 0, char_list:num_items() - 1 do
        local current_char = char_list:item_at(i)

        if current_char:forename("names_name_999982301") then
            charC = current_char
        end
    end

    if charC then
        if 1 == cm:random_number(66, 1) then
            cm:create_force(
                "wh2_main_bst_manblight",
                "wh_bst_inf_slaangor_herd,wh_bst_inf_slaangor_herd,wh_dlc03_bst_cav_razorgor_chariot_0,wh_dlc03_bst_inf_centigors_1,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_ungor_spearmen_1,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                "wh2_main_kingdom_of_beasts_serpent_coast",
                140,
                565,
                true,
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force(
                        "wh_main_bundle_military_upkeep_free_force",
                        cqi,
                        -1,
                        true
                    )
                end
            )

            templebstspawnmess()
        elseif 2 == cm:random_number(66, 1) then
            cm:create_force(
                "wh2_main_bst_manblight",
                "wh_bst_inf_slaangor_herd,wh_bst_inf_slaangor_herd,wh_dlc03_bst_cav_razorgor_chariot_0,wh_dlc03_bst_inf_centigors_1,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_ungor_spearmen_1,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                "wh2_main_kingdom_of_beasts_serpent_coast",
                910,
                67,
                true,
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force(
                        "wh_main_bundle_military_upkeep_free_force",
                        cqi,
                        -1,
                        true
                    )
                end
            )

            templebstspawnmess()
        elseif 3 == cm:random_number(66, 1) then
            cm:create_force(
                "wh2_main_bst_manblight",
                "wh_bst_inf_slaangor_herd,wh_bst_inf_slaangor_herd,wh_dlc03_bst_cav_razorgor_chariot_0,wh_dlc03_bst_inf_centigors_1,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc03_bst_inf_centigors_0,wh_dlc03_bst_inf_ungor_spearmen_1,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                "wh2_main_kingdom_of_beasts_serpent_coast",
                130,
                705,
                true,
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force(
                        "wh_main_bundle_military_upkeep_free_force",
                        cqi,
                        -1,
                        true
                    )
                end
            )

            templebstspawnmess()
        end
    end
end

function templebst_araby_spawn()
    if cm:get_faction("wh2_main_bst_blooded_axe"):is_dead() then
        core:remove_listener("templebst_araby_listener_add")
    end

    charD = nil
    local current_faction = cm:get_faction("wh2_main_bst_blooded_axe")
    local char_list = current_faction:character_list()

    for i = 0, char_list:num_items() - 1 do
        local current_char = char_list:item_at(i)

        if current_char:forename("names_name_999982304") then
            charD = current_char
        end
    end

    if charD then
        if 1 == cm:random_number(66, 1) then
            cm:create_force(
                "wh2_main_bst_blooded_axe",
                "wh_bst_inf_tzaangor_herd,wh_bst_inf_tzaangor_herd,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_mon_giant_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc05_bst_mon_harpies_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_ungor_spearmen_1,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                "wh2_main_kingdom_of_beasts_serpent_coast",
                415,
                140,
                true,
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force(
                        "wh_main_bundle_military_upkeep_free_force",
                        cqi,
                        -1,
                        true
                    )
                end
            )

            templebstspawnmess()
        elseif 2 == cm:random_number(66, 1) then
            cm:create_force(
                "wh2_main_bst_blooded_axe",
                "wh_bst_inf_tzaangor_herd,wh_bst_inf_tzaangor_herd,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_mon_giant_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc05_bst_mon_harpies_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_ungor_spearmen_1,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                "wh2_main_kingdom_of_beasts_serpent_coast",
                510,
                60,
                true,
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force(
                        "wh_main_bundle_military_upkeep_free_force",
                        cqi,
                        -1,
                        true
                    )
                end
            )

            templebstspawnmess()
        elseif 3 == cm:random_number(66, 1) then
            cm:create_force(
                "wh2_main_bst_blooded_axe",
                "wh_bst_inf_tzaangor_herd,wh_bst_inf_tzaangor_herd,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_mon_giant_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_gor_herd_0,wh_dlc03_bst_inf_minotaurs_1,wh_dlc03_bst_inf_bestigor_herd_0,wh_dlc03_bst_inf_ungor_raiders_0,wh_dlc05_bst_mon_harpies_0,wh_dlc05_bst_mon_harpies_0,wh_dlc03_bst_inf_ungor_spearmen_1,wh_dlc03_bst_inf_cygor_0,wh_dlc03_bst_inf_razorgor_herd_0",
                "wh2_main_kingdom_of_beasts_serpent_coast",
                590,
                55,
                true,
                function(cqi)
                    cm:apply_effect_bundle_to_characters_force(
                        "wh_main_bundle_military_upkeep_free_force",
                        cqi,
                        -1,
                        true
                    )
                end
            )

            templebstspawnmess()
        end
    end
end

function templebstspawnmess()
    local human_factions = cm:get_human_factions()

    for i = 1, #human_factions do
        cm:show_message_event(
            human_factions[i],
            "event_feed_strings_text_wh_event_feed_string_scripted_event_bsttempspawn_primary_detail",
            "",
            "event_feed_strings_text_wh_event_feed_string_scripted_event_bsttempspawn_secondary_detail",
            true,
            596
        )
    end
end

function templebststartmess()
    local human_factions = cm:get_human_factions()

    for i = 1, #human_factions do
        cm:show_message_event(
            human_factions[i],
            "event_feed_strings_text_wh_event_feed_string_scripted_event_bsttempstart_primary_detail",
            "",
            "event_feed_strings_text_wh_event_feed_string_scripted_event_bsttempstart_secondary_detail",
            true,
            596
        )
    end
end

local mcm = _G.mcm

if not not mcm then
	local ovn = nil;
	if mcm:has_mod("ovn") then
		ovn = mcm:get_mod("ovn");
	else
		ovn = mcm:register_mod("ovn", "OvN - Overhaul", "Let's you enable/disable various parts of the compilation.")
	end
	local templebst = ovn:add_tweaker("templebst", "Khaos Dhar Akami", "")
	templebst:add_option("enable", "Enable", "")
	templebst:add_option("disable", "Disable", "")
	mcm:add_post_process_callback(
		function(context)
			if cm:get_saved_value("mcm_tweaker_ovn_templebst_value") == "enable" then
                sr_templebst()
			end
		end
	)
end

cm:add_first_tick_callback(
	function()
		if not mcm or cm:get_saved_value("mcm_tweaker_ovn_templebst_value") == "enable" then sr_templebst() end
	end
)