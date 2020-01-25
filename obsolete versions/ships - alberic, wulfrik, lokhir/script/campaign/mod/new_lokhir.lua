local function repair_the_ship()
    local lokhirFaction --:CA_FACTION
    local lokhirChar --:CA_CHAR
    local lokhirCQI --:CA_CQI
    local lokhirLookupStr --:string
    local lokhirArmy = "" --:string
    local lokhirRegion --:CA_REGION
    local lokhirX --:number
    local lokhirY --:number
    local factionList = cm:model():world():faction_list()
    for i = 0, factionList:num_items() - 1 do 
        local currentFaction = factionList:item_at(i)
        local mfList = currentFaction:military_force_list()
        for i = 0, mfList:num_items() - 1 do
            local mf = mfList:item_at(i)	
            if mf:has_general() then
                local general = mf:general_character()
                if general:character_subtype("wh2_dlc11_def_lokhir") then
                    lokhirFaction = currentFaction
                    if general:is_at_sea() then
                        lokhirRegion = general:faction():home_region()
                    else
                        lokhirRegion = general:region()
                    end
                    lokhirCQI = general:command_queue_index()
                    lokhirX = general:logical_position_x()
                    lokhirY = general:logical_position_y()
                    local unitList = mf:unit_list()
                    for i = 1, unitList:num_items() - 1 do
                        local unit = unitList:item_at(i)
                        if lokhirArmy ~= "" then lokhirArmy = lokhirArmy.."," end
                        lokhirArmy = lokhirArmy..unit:unit_key()	
                    end
                    break
                end
            end
        end
        if lokhirFaction then break end
    end
    if lokhirFaction and lokhirCQI and lokhirArmy and lokhirRegion and lokhirX and lokhirY then
        cm:disable_event_feed_events(true, "all", "", "")
        cm:kill_character(lokhirCQI, true, false)
        cm:callback(function()
            local charList =  lokhirFaction:character_list()
            for i = 0, charList:num_items() - 1 do
                local char = charList:item_at(i)
                if char:character_subtype("wh2_dlc11_def_lokhir") and char:is_wounded() then
                    lokhirCQI = char:command_queue_index()
                    lokhirLookupStr = cm:char_lookup_str(lokhirCQI)
                    cm:stop_character_convalescing(lokhirCQI) 
                end
            end
            cm:create_force_with_existing_general(
                lokhirLookupStr,
                lokhirFaction:name(), 
                lokhirArmy,
                lokhirRegion:name(),
                lokhirX,
                lokhirY,
                function(cqi)
                    cm:disable_event_feed_events(false, "all", "", "")
                end
            )
        end, 1)
    else
        out("new_lokhir/ERROR - Lokhir not found.")
    end
end

function new_lokhir()
    mcm = _G.mcm
    if cm:is_new_game() and not not mcm then
        mcm:add_new_game_only_callback(
            function()
                repair_the_ship()
            end
        )
    elseif cm:is_new_game()and not mcm then
        repair_the_ship()
    end
end