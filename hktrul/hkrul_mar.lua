local marienburg_faction_key = "wh_main_emp_marienburg"


--new and fancy Jaan
local jaan_details = {
    general_faction = marienburg_faction_key,
    unit_list = "wh_main_emp_art_mortar,hkrul_privateers,wh2_dlc11_cst_inf_sartosa_free_company_0,wh2_dlc11_cst_inf_sartosa_militia_0,hkrul_pion,hkrul_carriers,hkrul_burgher,hkrul_burgher", -- unit keys from main_units table
    region_key = "",
    type = "general",																				-- Agent type
    subtype = "hkrul_jk",																	-- Agent subtype
    forename = "names_name_7470711888",															-- From local_en names table, Bernhoff the Butcher is now ruler of Reikland
    clanname = "",																					-- From local_en names table
    surname = "names_name_7470711866",																-- From local_en names table
    othername = "",																					-- From local_en names table
    is_faction_leader = true																		-- Bool for whether the general being replaced is the new faction leader
}


    core:add_listener(
        "hkrul_jk_weapon_unlock",
        "CharacterRankUp",
        function(context)
            local character = context:character()
            local faction = character:faction()
            return character:character_subtype("hkrul_jk") and character:rank() >= 14 and faction:ancillary_exists("hkrul_mar_coin") == false
        end,
        function(context)
            cm:force_add_ancillary(
                context:character(),
                "hkrul_mar_coin",
                true,
                false
            )
        end,
        false
    )
    
    
    core:add_listener(
        "hkrul_jk_follower1_unlock",
        "CharacterRankUp",
        function(context)
            local character = context:character()
            local faction = character:faction()
            return character:character_subtype("hkrul_jk") and character:rank() >= 10 and faction:ancillary_exists("hkrul_mar_anc_araby") == false
        end,
        function(context)
            cm:force_add_ancillary(
                context:character(),
                "hkrul_mar_anc_araby",
                true,
                false
            )
        end,
        false
    )

    core:add_listener(
        "hkrul_pg_follower1_unlock",
        "CharacterRankUp",
        function(context)
            local character = context:character()
            local faction = character:faction()
            return character:character_subtype("hkrul_pg") and character:rank() >= 10 and faction:ancillary_exists("hkrul_mar_anc_norscan") == false
        end,
        function(context)
            cm:force_add_ancillary(
                context:character(),
                "hkrul_mar_anc_norscan",
                true,
                false
            )
        end,
        false
    )
    core:add_listener(
        "hkrul_hendrik_follower1_unlock",
        "CharacterRankUp",
        function(context)
            local character = context:character()
            local faction = character:faction()
            return character:character_subtype("hkrul_hendrik") and character:rank() >= 8 and faction:ancillary_exists("hkrul_mar_anc_sander") == false
        end,
        function(context)
            cm:force_add_ancillary(
                context:character(),
                "hkrul_mar_anc_sander",
                true,
                false
            )
        end,
        false
    )

-- make sure Jaan doesn't have the "wh3_main_bundle_character_restrict_experience_gain" EB
core:add_listener(
    "hkrul_CharacterTurnStart",
    "CharacterTurnStart",
    function(context)
        return context:character():character_subtype(jaan_details.subtype)
    end,
    function(context)    
        local character = context:character()
        cm:callback(
            function()
                if character:has_effect_bundle("wh3_main_bundle_character_restrict_experience_gain") then
                    cm:remove_effect_bundle_from_character("wh3_main_bundle_character_restrict_experience_gain", character)
                end
            end,
            0.1
        )
    end,
    true
)


-- Replaces the starting general for a specific faction
local function hkrul_mar()
    local marienburg_faction =  cm:get_faction(marienburg_faction_key)
	if cm:is_new_game() then
        cm:callback(
			function() 
                if marienburg_faction:is_null_interface() == false and marienburg_faction:is_dead() == false then
                    -- Shaping starting setup
                    if marienburg_faction:is_human() then
                        local marienburg_region = cm:get_region("wh3_main_combi_region_marienburg")
                        local marienburg_settlement = marienburg_region:settlement()
                        local marienburg_slot_list = marienburg_region:slot_list()
                        for i = 2, marienburg_slot_list:num_items() - 1 do
                        local slot = marienburg_slot_list:item_at(i)
                        cm:instantly_dismantle_building_in_region(slot)
                        end
                        cm:instantly_set_settlement_primary_slot_level(marienburg_settlement , 2)
                        cm:transfer_region_to_faction("wh3_main_combi_region_fort_bergbres","wh_main_grn_skullsmasherz") 
                        cm:create_force_with_general(
                            "wh_main_nor_graeling",
                            "wh_dlc08_nor_inf_marauder_spearman_0,wh_main_nor_inf_chaos_marauders_0,wh_dlc08_nor_inf_marauder_spearman_0,wh_dlc08_nor_inf_marauder_spearman_0,wh_main_nor_cav_marauder_horsemen_0,wh_dlc08_nor_inf_marauder_hunters_0",
                            "wh3_main_combi_region_gorssel",
                            465,
                            662,
                            "general",
                            "wh_main_nor_marauder_chieftain",
                            "names_name_1758696990",
                            "",
                            "names_name_1914019835",
                            "",
                            false,
                            function(cqi)
                                cm:transfer_region_to_faction("wh3_main_combi_region_gorssel","wh_main_nor_graeling")
                                local gorssel_region = cm:get_region("wh3_main_combi_region_gorssel")
                                local gorssel_cqi = gorssel_region:cqi()
                                cm:heal_garrison(gorssel_cqi)
                                cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "")
                                 cm:force_declare_war(marienburg_faction_key, "wh_main_nor_graeling", false, false)
                                cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "") end, 0.5)
                            end
                        )
                    end

                    local general_x_pos, general_y_pos = cm:find_valid_spawn_location_for_character_from_settlement(jaan_details.general_faction, marienburg_faction:home_region():name(), false, true, 8)
                    general_x_pos = 466
                    general_y_pos  = 655
                    out(marienburg_faction_key .. " home region name is " .. jaan_details.region_key)

                    -- Creating replacement Emil with new fancy Jaan
                    cm:create_force_with_general(
                        jaan_details.general_faction,
                        jaan_details.unit_list,
                        marienburg_faction:home_region():name(),
                        general_x_pos,
                        general_y_pos,
                        jaan_details.type,
                        jaan_details.subtype,
                        jaan_details.forename,
                        jaan_details.clanname,
                        jaan_details.surname,
                        jaan_details.othername,
                        jaan_details.is_faction_leader,
                        function(cqi)
                            local char_str = cm:char_lookup_str(cqi)
                            cm:set_character_unique(char_str, true) --makes Jaan a undisbandable "Legendary Lord"
                            --cm:set_character_immortality(char_str, true) --not needed since immortality is enabled in db
                        end
                    )
                    out("Created replacement Lord " .. jaan_details.forename .. " for " .. marienburg_faction_key)

                    -- Killing old (generic) Emil permanently
                    local char_list = marienburg_faction:character_list()
                    local char_subtype = "wh_main_emp_lord" -- old (generic) Emil's agent subtype
                    local char_forename = "names_name_2147344088" -- old (generic) Emil's forename

                    for i = 0, char_list:num_items() - 1 do
                        local current_char = char_list:item_at(i)
                        local char_str = cm:char_lookup_str(current_char)

                        if current_char:is_null_interface() == false and current_char:character_subtype_key() == char_subtype and current_char:get_forename() == char_forename and current_char:has_military_force() == true then
                            cm:set_character_immortality(char_str, false)
                            cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
                            cm:kill_character(current_char:command_queue_index(), true, true)
                            cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 0.5)
                            out("Killing original " .. char_subtype .. " with forename " .. char_forename .. " for " .. marienburg_faction_key .. " permanently")
                        end
                    end
                end
            end, 0.1 --delay to make sure this runs after wh2_campaign_custom_starts.lua
        )
	end
end


cm:add_first_tick_callback(function() hkrul_mar() end)