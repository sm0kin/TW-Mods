-- only load this script for campaign
if __game_mode ~= __lib_type_campaign then
    return
end

local function no_unit_mess(faction_key)                                    
    cm:show_message_event(
        faction_key,
        "event_feed_strings_text_wh_event_feed_string_scripted_event_no_unit_primary_detail",
        "",
        "event_feed_strings_text_wh_event_feed_string_scripted_event_no_unit_secondary_detail",
        true,
        591
    );
end

local function imperial_unit_gained_mess(faction_key)                                   
    cm:show_message_event(
        faction_key,
        "event_feed_strings_text_wh_event_feed_string_scripted_event_imperial_unit_gained_primary_detail",
        "",
        "event_feed_strings_text_wh_event_feed_string_scripted_event_imperial_unit_gained_secondary_detail",
        true,
        591
    );                                      
end

local function merc_unit_gained_mess(faction_key)                                   
    cm:show_message_event(
        faction_key,
        "event_feed_strings_text_wh_event_feed_string_scripted_event_merc_unit_gained_primary_detail",
        "",
        "event_feed_strings_text_wh_event_feed_string_scripted_event_merc_unit_gained_secondary_detail",
        true,
        591
    );                                      
end

local function ror_unit_gained_mess(faction_key)          
    cm:show_message_event(
        faction_key,
        "event_feed_strings_text_wh_event_feed_string_scripted_event_ror_unit_gained_primary_detail",
        "",
        "event_feed_strings_text_wh_event_feed_string_scripted_event_ror_unit_gained_secondary_detail",
        true,
        591
    );                                         
end

--------------------------------------------------------------
------------------- CONQUEST MECHANICS --------------------------
--------------------------------------------------------------

function ovn_grudge_dilemma_reinforcements(faction_key)
    if not is_string(faction_key) then
        -- error
        return false
    end

    local faction_obj = cm:get_faction(faction_key)
       
    local ovn_reinforcement_unit_pool = {
        "wh2_dlc13_emp_art_great_cannon_imperial_supply",
        "wh2_dlc13_emp_cav_empire_knights_imperial_supply",
        "wh2_dlc13_emp_cav_pistoliers_1_imperial_supply",
        "wh2_dlc13_emp_inf_greatswords_imperial_supply",
        "wh2_dlc13_emp_inf_halberdiers_imperial_supply",
        "wh2_dlc13_emp_inf_handgunners_imperial_supply",
        "wh2_dlc13_emp_veh_war_wagon_0_imperial_supply",
        "wh2_dlc13_emp_veh_war_wagon_1_imperial_supply",
        "wh2_dlc13_emp_inf_huntsmen_0_imperial_supply",
        "wh2_dlc13_emp_art_helblaster_volley_gun_imperial_supply",
        "wh2_dlc13_emp_art_helstorm_rocket_battery_imperial_supply",
        "wh2_dlc13_emp_cav_demigryph_knights_0_imperial_supply",
        "wh2_dlc13_emp_cav_outriders_1_imperial_supply",
        "wh2_dlc13_emp_cav_demigryph_knights_1_imperial_supply",
        "wh2_dlc13_emp_cav_reiksguard_imperial_supply",
        "wh2_dlc13_emp_veh_luminark_of_hysh_0_imperial_supply",
        "wh2_dlc13_emp_cav_knights_blazing_sun_0_imperial_supply",
        "black_avangers", -- INDEX 18
        "carlsson_cavalry",
        "carlsson_guard",
        "countess_guard",
        "vannheim_75th",
        "helmgart_bowmen",
        "keelers_longbows", -- INDEX 24
    }

    if cm:get_saved_value("Cataph_TEB") == true then
        local cataph_units = {
            "teb_ricco",
            "teb_alcatani",
            "teb_pirazzo",
            "teb_pirazzo_xbows",
            "teb_leopard",
            "teb_venators",
            "teb_vespero",
            "teb_marksmen",
            "teb_besiegers",
            "teb_muktar",
            "teb_amazons",
            "teb_origo",
            "teb_manflayers",
            "teb_asarnil" ---- INDEX 38
        }
        for i = 1, #cataph_units do
            table.insert(ovn_reinforcement_unit_pool, cataph_units [i])
        end;
    end

    local random_number = cm:random_number(#ovn_reinforcement_unit_pool, 1)
    local unit_key = ovn_reinforcement_unit_pool[random_number]
    
    
        if random_number < 18 then
            cm:add_unit_to_faction_mercenary_pool(faction_obj, unit_key, 1, 0, 5, 0, 0, "", "", "", true);
        else
            cm:add_unit_to_faction_mercenary_pool(faction_obj, unit_key, 1, 20, 1, 0.1, 0, "", "", "", true);
        end;
        if cm:get_saved_value("Cataph_TEB") == true then
            if random_number < 18 then
                merc_unit_gained_mess(faction_key)
            elseif random_number < 39 then
                ror_unit_gained_mess(faction_key)	
            end
        elseif random_number < 19 then
                 merc_unit_gained_mess(faction_key)
        elseif random_number < 26 then
                ror_unit_gained_mess(faction_key)
        end
    end;


function ovn_late_imperial_reinforcements(faction_key)
    if not is_string(faction_key) then
        -- error
        return false
    end

    local faction_obj = cm:get_faction(faction_key)
       
    local ovn_reinforcement_unit_pool = {
        "wh2_dlc13_emp_art_great_cannon_imperial_supply",
        "wh2_dlc13_emp_cav_empire_knights_imperial_supply",
        "wh2_dlc13_emp_cav_pistoliers_1_imperial_supply",
        "wh2_dlc13_emp_inf_greatswords_imperial_supply",
        "wh2_dlc13_emp_inf_halberdiers_imperial_supply",
        "wh2_dlc13_emp_inf_handgunners_imperial_supply",
        "wh2_dlc13_emp_veh_war_wagon_0_imperial_supply",
        "wh2_dlc13_emp_veh_war_wagon_1_imperial_supply",
        "wh2_dlc13_emp_inf_huntsmen_0_imperial_supply",
        "wh2_dlc13_emp_art_helblaster_volley_gun_imperial_supply",
        "wh2_dlc13_emp_art_helstorm_rocket_battery_imperial_supply",
        "wh2_dlc13_emp_cav_demigryph_knights_0_imperial_supply",
        "wh2_dlc13_emp_cav_outriders_1_imperial_supply",
        "wh2_dlc13_emp_cav_demigryph_knights_1_imperial_supply",
        "wh2_dlc13_emp_cav_reiksguard_imperial_supply",
        "wh2_dlc13_emp_veh_luminark_of_hysh_0_imperial_supply",
        "wh2_dlc13_emp_cav_knights_blazing_sun_0_imperial_supply",
        "black_avangers", -- INDEX 18
        "carlsson_cavalry",
        "carlsson_guard",
        "countess_guard",
        "vannheim_75th",
        "helmgart_bowmen",
        "keelers_longbows", -- INDEX 24
    }

    if cm:get_saved_value("Cataph_TEB") == true then
        local cataph_units = {
            "teb_ricco",
            "teb_alcatani",
            "teb_pirazzo",
            "teb_pirazzo_xbows",
            "teb_leopard",
            "teb_venators",
            "teb_vespero",
            "teb_marksmen",
            "teb_besiegers",
            "teb_muktar",
            "teb_amazons",
            "teb_origo",
            "teb_manflayers",
            "teb_asarnil" ---- INDEX 38
        }
        for i = 1, #cataph_units do
            table.insert(ovn_reinforcement_unit_pool, cataph_units [i])
        end;
    end

    local random_number = cm:random_number(#ovn_reinforcement_unit_pool, 1)
    local unit_key = ovn_reinforcement_unit_pool[random_number]
    
    if  1 ~= cm:random_number(3, 1) then
        if random_number < 18 then
            cm:add_unit_to_faction_mercenary_pool(faction_obj, unit_key, 1, 0, 5, 0, 0, "", "", "", true);
        else
            cm:add_unit_to_faction_mercenary_pool(faction_obj, unit_key, 1, 20, 1, 0.1, 0, "", "", "", true);
        end;
        if cm:get_saved_value("Cataph_TEB") == true then
            if random_number < 18 then
                imperial_unit_gained_mess(faction_key)
            elseif random_number < 39 then
                ror_unit_gained_mess(faction_key)	
            end
        elseif random_number < 19 then
                imperial_unit_gained_mess(faction_key)
        elseif random_number < 26 then
                ror_unit_gained_mess(faction_key)
        end
    else
        cm:treasury_mod(faction_key, 400)
        no_unit_mess(faction_keys)
    end;
end
    
    

function ovn_early_imperial_reinforcements(faction_key)
     if not is_string(faction_key) then
        -- error
        return false
    end

    out("OVN TEST ZERO FBBEOIBEFO")
    local faction_obj = cm:get_faction(faction_key)
    
    local ovn_reinforcement_unit_pool = {
        "wh2_dlc13_emp_art_great_cannon_imperial_supply",
        "wh2_dlc13_emp_cav_empire_knights_imperial_supply",
        "wh2_dlc13_emp_cav_pistoliers_1_imperial_supply",
        "wh2_dlc13_emp_inf_greatswords_imperial_supply",
        "wh2_dlc13_emp_inf_halberdiers_imperial_supply",
        "wh2_dlc13_emp_inf_handgunners_imperial_supply",
        "wh2_dlc13_emp_veh_war_wagon_0_imperial_supply",
        "wh2_dlc13_emp_veh_war_wagon_1_imperial_supply",
        "wh2_dlc13_emp_inf_huntsmen_0_imperial_supply",
        "black_avangers", -- INDEX 10
        "carlsson_cavalry",
        "carlsson_guard",
        "countess_guard",
        "vannheim_75th",
        "helmgart_bowmen",
        "keelers_longbows", -- INDEX 16
    }
    if cm:get_saved_value("Cataph_TEB") == true then
        local cataph_units = {
            "teb_ricco",
            "teb_alcatani",
            "teb_leopard",
            "teb_vespero",
            "teb_marksmen",
            "teb_besiegers",
            "teb_muktar",
            "teb_origo" ---- INDEX 24
        }
        for i = 1, #cataph_units do
            table.insert(ovn_reinforcement_unit_pool, cataph_units [i])
        end
    end

    local random_number = cm:random_number(#ovn_reinforcement_unit_pool, 1)
    local unit_key = ovn_reinforcement_unit_pool[random_number]

    if  1 ~= cm:random_number(3, 1) then
        if random_number < 10 then
            cm:add_unit_to_faction_mercenary_pool(faction_obj, unit_key, 1, 0, 5, 0, 0, "", "", "", true)
        else
            cm:add_unit_to_faction_mercenary_pool(faction_obj, unit_key, 1, 20, 1, 0.1, 0, "", "", "", true)
        end;
        if cm:get_saved_value("Cataph_TEB") == true then
            if random_number < 10 then
                imperial_unit_gained_mess(faction_key)
            elseif random_number < 25 then
                ror_unit_gained_mess(faction_key)
            end
        elseif random_number < 10 then
            imperial_unit_gained_mess(faction_key)
        elseif random_number < 17 then
            ror_unit_gained_mess(faction_key)
        end
    else
        cm:treasury_mod(faction_key, 400)
        no_unit_mess(faction_key)
    end
end