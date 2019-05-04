cm = get_cm(); events = get_events();
--Kills alberic and respawns him so he correctly updates to use a horde army type.
--Script helpfully made by Vandy and Drunkflamingo mysteriously messaging people with code snippets.
function new_alberic()
    local bordelaux = cm:get_faction("wh_main_brt_bordeleaux")
    if cm:is_new_game() and bordelaux:is_human() then
        local alberic
        local character_list = bordelaux:character_list()
        for i = 0, character_list:num_items() - 1 do
            local char = character_list:item_at(i)
            if char:character_subtype("dlc07_brt_alberic") then
                alberic = char
            end
        end
        local alberic_cqi = bordelaux:faction_leader():command_queue_index()
        local alberic_str = cm:char_lookup_str(alberic_cqi)
        cm:set_character_immortality(alberic_str, false)
		cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_deaths", "");
        cm:kill_character(alberic_cqi, true, true);
		cm:callback(function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_deaths", "") end, 1);
        local bordelaux_str = "wh_main_brt_bordeleaux"
        local x = alberic:logical_position_x()
        local y = alberic:logical_position_y()
        local region = alberic:faction():home_region():name()
        cm:create_force_with_general(
            bordelaux_str,
            "wh_dlc07_brt_inf_foot_squires_0,wh_main_brt_cav_knights_of_the_realm,wh_dlc07_brt_cav_knights_errant_0,wh_dlc07_brt_peasant_mob_0,wh_main_brt_inf_peasant_bowmen,wh_main_brt_cav_knights_of_the_realm,wh_dlc07_brt_inf_spearmen_at_arms_1,wh_main_brt_inf_peasant_bowmen,wh_main_brt_cav_knights_of_the_realm,wh_dlc07_brt_peasant_mob_0,wh_dlc07_brt_inf_spearmen_at_arms_1,wh_main_brt_cav_knights_of_the_realm",
            region,
            x,
            y,
            "general",
            "dlc07_brt_alberic",
            "names_name_2147345888",
            "",
            "names_name_1529663917",
            "",
            true,
            function(cqi)
                --traits and shit
				cm:set_character_immortality(cm:char_lookup_str(cqi), true);
				for i = 1, 6 do
					cm:force_add_trait(cm:char_lookup_str(cqi), "wh_dlc07_trait_brt_knights_vow_knowledge_pledge", false);
				end	
            end

        )
    end
end

function alberic_quest_fix()
    cm:set_saved_value("wh_dlc07_qb_brt_alberic_trident_of_bordeleaux_stage_1_issued", true)
    if not cm:get_saved_value("aberic_item_wili") then
        core:add_listener(
            "Wooo",
            "CharacterTurnStart",
            function(context) return (context:character():character_subtype("dlc07_brt_alberic") and context:character():rank() >= 3) 
            end,
            function(context)
                cm:force_add_and_equip_ancillary(cm:char_lookup_str(context:character():cqi()), "wh_dlc07_anc_weapon_trident_of_manann")
                cm:set_saved_value("aberic_item_wili", true)
            end,
            false
        )
    end
end
alberic_quest_fix()