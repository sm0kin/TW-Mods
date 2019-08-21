local function repair_the_ship()
    local albericFaction --:CA_FACTION
    local albericChar --:CA_CHAR
    local albericCQI --:CA_CQI
    local albericLookupStr --:string
    local albericArmy = "" --:string
    local albericRegion --:CA_REGION
    local albericX --:number
    local albericY --:number
    local factionList = cm:model():world():faction_list()
    for i = 0, factionList:num_items() - 1 do 
        local currentFaction = factionList:item_at(i)
        local mfList = currentFaction:military_force_list()
        for i = 0, mfList:num_items() - 1 do
            local mf = mfList:item_at(i)	
            if mf:has_general() then
                local general = mf:general_character()
                if general:character_subtype("dlc07_brt_alberic") then
                    albericFaction = currentFaction
                    if general:is_at_sea() then
                        albericRegion = general:faction():home_region()
                    else
                        albericRegion = general:region()
                    end                        
                    albericCQI = general:command_queue_index()
                    albericX = general:logical_position_x()
                    albericY = general:logical_position_y()
                    local unitList = mf:unit_list()
                    for i = 1, unitList:num_items() - 1 do
                        local unit = unitList:item_at(i)
                        if albericArmy ~= "" then albericArmy = albericArmy.."," end
                        albericArmy = albericArmy..unit:unit_key()	
                    end
                    break
                end
            end
        end
        if albericFaction then break end
    end
    if albericFaction and albericCQI and albericArmy and albericRegion and albericX and albericY then
        cm:disable_event_feed_events(true, "all", "", "")
        cm:kill_character(albericCQI, true, false)
        cm:callback(function()
            local charList =  albericFaction:character_list()
            for i = 0, charList:num_items() - 1 do
                local char = charList:item_at(i)
                if char:character_subtype("dlc07_brt_alberic") and char:is_wounded() then
                    albericCQI = char:command_queue_index()
                    albericLookupStr = cm:char_lookup_str(albericCQI)
                    cm:stop_character_convalescing(albericCQI) 
                end
            end
            if effect.get_localised_string("land_units_onscreen_name_wh_jmw_brt_inf_truffle_hounds") == "Truffle Hounds" then
                -- different starting unit for The Lady's Calling 
                albericArmy = "wh_dlc07_brt_inf_foot_squires_0,wh_main_brt_cav_knights_of_the_realm,wh_dlc07_brt_cav_knights_errant_0,wh_jmw_brt_inf_buccaneers,wh_jmw_brt_inf_naval_archers,wh_main_brt_cav_knights_of_the_realm,wh_jmw_brt_inf_corsairs_01,wh_jmw_brt_inf_naval_archers,wh_main_brt_cav_knights_of_the_realm,wh_jmw_brt_inf_buccaneers,wh_jmw_brt_inf_corsairs_01,wh_main_brt_cav_knights_of_the_realm"
            end
            cm:create_force_with_existing_general(
                albericLookupStr,
                albericFaction:name(), 
                albericArmy,
                albericRegion:name(),
                albericX,
                albericY,
                function(cqi)
                    Give_Trait(cm:get_character_by_cqi(cqi), "wh_dlc07_trait_brt_knights_vow_knowledge_pledge", 6)                      
                    cm:disable_event_feed_events(false, "all", "", "")
                end
            )
        end, 1)
    else
        out("new_alberic/ERROR - Alberic not found.")
    end
end

function new_alberic()
    mcm = _G.mcm
    if cm:is_new_game() and not not mcm then
        mcm:add_post_process_callback(
            function()
                repair_the_ship()
            end
        )
    elseif cm:is_new_game()and not mcm then
        repair_the_ship()
    end
end