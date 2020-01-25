local function repair_the_ship()
    local wulfrikFaction --:CA_FACTION
    local wulfrikChar --:CA_CHAR
    local wulfrikCQI --:CA_CQI
    local wulfrikLookupStr --:string
    local wulfrikArmy = "" --:string
    local wulfrikRegion --:CA_REGION
    local wulfrikX --:number
    local wulfrikY --:number
    local factionList = cm:model():world():faction_list()
    for i = 0, factionList:num_items() - 1 do 
        local currentFaction = factionList:item_at(i)
        local mfList = currentFaction:military_force_list()
        for i = 0, mfList:num_items() - 1 do
            local mf = mfList:item_at(i)	
            if mf:has_general() then
                local general = mf:general_character()
                if general:character_subtype("wh_dlc08_nor_wulfrik") then
                    wulfrikFaction = currentFaction
                    if general:is_at_sea() then
                        wulfrikRegion = general:faction():home_region()
                    else
                        wulfrikRegion = general:region()
                    end                        
                    wulfrikCQI = general:command_queue_index()
                    wulfrikX = general:logical_position_x()
                    wulfrikY = general:logical_position_y()
                    local unitList = mf:unit_list()
                    for i = 1, unitList:num_items() - 1 do
                        local unit = unitList:item_at(i)
                        if wulfrikArmy ~= "" then wulfrikArmy = wulfrikArmy.."," end
                        wulfrikArmy = wulfrikArmy..unit:unit_key()	
                    end
                    break
                end
            end
        end
        if wulfrikFaction then break end
    end
    if wulfrikFaction and wulfrikCQI and wulfrikArmy and wulfrikRegion and wulfrikX and wulfrikY then
        cm:disable_event_feed_events(true, "all", "", "")
        cm:kill_character(wulfrikCQI, true, false)
        cm:callback(function()
            local charList =  wulfrikFaction:character_list()
            for i = 0, charList:num_items() - 1 do
                local char = charList:item_at(i)
                if char:character_subtype("wh_dlc08_nor_wulfrik") and char:is_wounded() then
                    wulfrikCQI = char:command_queue_index()
                    wulfrikLookupStr = cm:char_lookup_str(wulfrikCQI)
                    cm:stop_character_convalescing(wulfrikCQI) 
                end
            end
            cm:create_force_with_existing_general(
                wulfrikLookupStr,
                wulfrikFaction:name(), 
                wulfrikArmy,
                wulfrikRegion:name(),
                wulfrikX,
                wulfrikY,
                function(cqi)
                    cm:disable_event_feed_events(false, "all", "", "")
                end
            )
        end, 1)
    else
        out("new_wulfrik/ERROR - wulfrik not found.")
    end
end

function new_wulfrik()
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