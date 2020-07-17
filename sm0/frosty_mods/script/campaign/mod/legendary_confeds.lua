-------------------------------------------------------------------------------------
--LEGENDARY CONFEDERATIONS
-------------------------------------------------------------------------------------
--contact Frosty or Sm0kin for permission to re-purpose/utilize script 
-------------------------------------------------------------------------------------
-- patch notes
-------------------------------------------------------------------------------------
-- code revision
-- mct 2.0 implementation
-- compatibility update for vandy's confederation option mod
-- ...
------------------------------------------------------------------------------------------------------------------------------------
--- DEFINITIONS
------------------------------------------------------------------------------------------------------------------------------------

local enable_value --:WHATEVER
local zzz03_tHeatre_value --:WHATEVER
local zzz04_deadlyAlliances_value --:WHATEVER
local zzz05_restriction_value --:WHATEVER
local enabled_factions --:map<string, string> -- {["faction]" = "human_faction"}

-- factions with legendary lords
------------------------------------------------------------------

local subcultures_factions = {
    ["wh2_main_sc_hef_high_elves"] = {"wh2_main_hef_eataine", "wh2_main_hef_order_of_loremasters", "wh2_main_hef_avelorn", "wh2_main_hef_nagarythe", "wh2_main_hef_yvresse", "wh2_dlc15_hef_imrik"},
    ["wh2_main_sc_lzd_lizardmen"] = {"wh2_main_lzd_hexoatl", "wh2_main_lzd_last_defenders", "wh2_dlc12_lzd_cult_of_sotek", "wh2_main_lzd_tlaqua", "wh2_main_lzd_itza", "wh2_dlc13_lzd_spirits_of_the_jungle"},
    ["wh2_main_sc_def_dark_elves"] = {"wh2_main_def_naggarond", "wh2_main_def_cult_of_pleasure", "wh2_main_def_har_ganeth", "wh2_dlc11_def_the_blessed_dread", "wh2_main_def_hag_graef"},
    ["wh2_main_sc_skv_skaven"] = {"wh2_main_skv_clan_skyre", "wh2_main_skv_clan_mors", "wh2_main_skv_clan_pestilens", "wh2_dlc09_skv_clan_rictus", "wh2_main_skv_clan_eshin"},
    ["wh2_dlc09_sc_tmb_tomb_kings"] = {"wh2_dlc09_tmb_khemri", "wh2_dlc09_tmb_lybaras", "wh2_dlc09_tmb_exiles_of_nehek", "wh2_dlc09_tmb_followers_of_nagash"},
    ["wh2_dlc11_sc_cst_vampire_coast"] = {"wh2_dlc11_cst_vampire_coast", "wh2_dlc11_cst_noctilus", "wh2_dlc11_cst_pirates_of_sartosa", "wh2_dlc11_cst_the_drowned"},
    ["wh_main_sc_nor_norsca"] = {"wh_dlc08_nor_norsca", "wh_dlc08_nor_wintertooth"},
    ["wh_main_sc_emp_empire"] = {"wh_main_emp_empire", "wh_main_emp_middenland", "wh2_dlc13_emp_golden_order", "wh2_dlc13_emp_the_huntmarshals_expedition"},
    ["wh_main_sc_dwf_dwarfs"] = {"wh_main_dwf_dwarfs", "wh_main_dwf_karak_kadrin", "wh_main_dwf_karak_izor"},
    ["wh_main_sc_brt_bretonnia"] = {"wh_main_brt_bretonnia", "wh_main_brt_bordeleaux", "wh_main_brt_carcassonne", "wh2_dlc14_brt_chevaliers_de_lyonesse"},
    ["wh_dlc05_sc_wef_wood_elves"] = {"wh_dlc05_wef_wood_elves", "wh_dlc05_wef_argwylon"},
    ["wh_main_sc_grn_greenskins"] = {"wh_main_grn_greenskins", "wh_main_grn_crooked_moon", "wh_main_grn_orcs_of_the_bloody_hand", "wh2_dlc15_grn_bonerattlaz", "wh2_dlc15_grn_broken_axe"},
    ["wh_main_sc_vmp_vampire_counts"] = {"wh_main_vmp_schwartzhafen", "wh_main_vmp_vampire_counts", "wh2_dlc11_vmp_the_barrow_legion", "wh_main_vmp_mousillon"}
    -- ["wh_dlc03_sc_bst_beastmen"] = {"",}
    -- ["wh_main_sc_chs_chaos"] = {""}
} --: map<string, vector<string>>

local leaderFactions = {
    "wh2_main_hef_eataine",
    "wh2_main_lzd_hexoatl", 
    "wh2_main_def_naggarond", 
    "wh2_main_skv_clan_skyre",
    "wh2_dlc09_tmb_khemri",
    "wh2_dlc11_cst_vampire_coast",
    "wh_dlc08_nor_norsca",
    "wh_main_emp_empire",
    "wh_main_dwf_dwarfs",
    "wh_main_brt_bretonnia",
    "wh_dlc05_wef_wood_elves",
    "wh_main_grn_greenskins",
    "wh_main_vmp_schwartzhaf"
} --:vector<string>

-- alastar items
------------------------------------------------------------------

local alastar_quests = {
    { "wh2_main_anc_armour_lions_pelt", 1}
} --:vector<{string, number}>

---- mixu compatibility bridge
------------------------------------------------------------------

local mixu1_subcultures_factions = {
    ["wh2_main_sc_hef_high_elves"] = {},
    ["wh2_main_sc_lzd_lizardmen"] = {},
    ["wh2_main_sc_def_dark_elves"] = {},
    ["wh2_main_sc_skv_skaven"] = {},
    ["wh2_dlc09_sc_tmb_tomb_kings"] = {},
    -- wh2_dlc11_sc_cst_vampire_coast
    ["wh_main_sc_nor_norsca"] = {},
    ["wh_main_sc_emp_empire"] = {"wh_main_emp_stirland", "wh_main_emp_hochland", "wh_main_emp_marienburg", "wh_main_emp_wissenland", "wh_main_emp_talabecland", "wh_main_emp_averland", "wh_main_emp_nordland", "wh_main_emp_ostland", "wh_main_emp_ostermark"},
    ["wh_main_sc_dwf_dwarfs"] = {"wh_main_dwf_karak_azul"},
    ["wh_main_sc_brt_bretonnia"] = {"wh_main_brt_bastonne", "wh_main_brt_parravon", "wh_main_brt_artois", "wh_main_brt_lyonesse"},
    ["wh_dlc05_sc_wef_wood_elves"] = {"wh_dlc05_wef_torgovann"},
    ["wh_main_sc_grn_greenskins"] = {},
    ["wh_main_sc_vmp_vampire_counts"] = {},
    ["wh_dlc03_sc_bst_beastmen"] = {"wh2_main_bst_manblight"}
} --: map<string, vector<string>>

local mixu2_subcultures_factions = {
    ["wh2_main_sc_hef_high_elves"] = {"wh2_main_hef_saphery", "wh2_main_hef_chrace"},
    ["wh2_main_sc_lzd_lizardmen"] = {"wh2_main_lzd_xlanhuapec", "wh2_main_lzd_tlaxtlan"},
    ["wh2_main_sc_def_dark_elves"] = {"wh2_main_def_scourge_of_khaine"},
    ["wh2_main_sc_skv_skaven"] = {"wh2_main_skv_clan_mordkin"},
    ["wh2_dlc09_sc_tmb_tomb_kings"] = {"wh2_dlc09_tmb_numas"},
    -- wh2_dlc11_sc_cst_vampire_coast
    ["wh_main_sc_nor_norsca"] = {"wh_main_nor_skaeling"},
    ["wh_main_sc_emp_empire"] = {},
    ["wh_main_sc_dwf_dwarfs"] = {},
    ["wh_main_sc_brt_bretonnia"] = {"wh2_main_brt_knights_of_origo"},
    ["wh_dlc05_sc_wef_wood_elves"] = {"wh_dlc05_wef_wydrioth"},
    ["wh_main_sc_grn_greenskins"] = {"wh_main_grn_red_fangs"},
    ["wh_main_sc_vmp_vampire_counts"] = {},
    ["wh_dlc03_sc_bst_beastmen"] = {"wh2_main_bst_ripper_horn"}
    --["wh_main_sc_chs_chaos"] = {"wh2_main_chs_the_cabal"}
} --: map<string, vector<string>>

------------------------------------------------------------------------------------------------------------------------------------
--- MISC
------------------------------------------------------------------------------------------------------------------------------------

--v function(quests: vector<{string, number}>, subtype: string)
local function ancillaryOnRankUp(quests, subtype)
    for i = 1, #quests do
        local currentQuest= quests[i]
        local ancillary = currentQuest[1]
        local rank = currentQuest[2]			
        core:add_listener(
            ancillary,
            "CharacterTurnStart",
            function(context)
                return context:character():character_subtype(subtype) and context:character():rank() >= rank 
            end,
            function(context)
                cm:force_add_ancillary(context:character(), ancillary, true, false)
            end,
            false
        )
    end
end

--v function(faction: string, region: string, x: number, y: number, subtype: string, forename: string, surname: string)
local function createNewLord(faction, region, x, y, subtype, forename, surname) -- not used atm
    cm:create_force_with_general(
        faction,
        "wh_main_dwf_inf_hammerers", -- dummy unit
        region,
        x,
        y,
        "general",
        subtype, --subtype
        forename, --forename
        "",
        surname, --surname
        "",
        false,
        function(cqi)
            local char = cm:get_character_by_cqi(cqi)
            cm:set_character_immortality(cm:char_lookup_str(cqi), true)
            cm:kill_character(cqi, true, false)
            --cm:callback(function()
                if char:is_wounded() then cm:stop_character_convalescing(cqi) end
            --end, 0.5)        
        end
    )
end

---- sm0kin's locked lords solution
------------------------------------------------------------------

--v function(subtype: string, faction: string)
local function spamLords(subtype, faction)
    local factionCA = cm:get_faction(faction)
    local x, y
    if factionCA:has_home_region() then x, y = cm:find_valid_spawn_location_for_character_from_settlement(faction, factionCA:home_region():name(), false, true, 5) end
    for i = 1, 20 do
        cm:create_force(
            faction,
            "wh_main_dwf_inf_hammerers",
            factionCA:home_region():name(),
            x,
            y,
            false,
            function(cqi)
                out("test_a_"..i)
                local char = cm:get_character_by_cqi(cqi)
                if char:character_subtype(subtype) then
                    cm:set_character_immortality(cm:char_lookup_str(cqi), true)
                    cm:set_saved_value(subtype.."_spawned", faction) 
                end
                cm:kill_character(cqi, true, false)
                out("test_b_"..i)
                --cm:callback(function()
                    if char:is_wounded() then cm:stop_character_convalescing(cqi) end
                --end, 0.5)
            end,
            false
        )
    end
end

--v function(faction: string)
local function spawnMissingLords(faction)
    local ai_starting_generals = {
        {["id"] = "2140784160",	["forename"] = "names_name_2147358917",	["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "pro01_dwf_grombrindal"},                 -- Grombrindal
        {["id"] = "2140784136",	["forename"] = "names_name_2147358013",	["faction"] = "wh_main_emp_empire", ["subtype"] = "dlc04_emp_volkmar"},                     -- Volkmar
        {["id"] = "2140783606",	["forename"] = "names_name_2147345906",	["faction"] = "wh_main_grn_greenskins", ["subtype"] = "grn_azhag_the_slaughterer"},         -- Azhag
        {["id"] = "2140784146",	["forename"] = "names_name_2147358044",	["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "dlc04_vmp_helman_ghorst"},       -- Ghorst
        {["id"] = "2140784202",	["forename"] = "names_name_2147345124",	["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "pro02_vmp_isabella_von_carstein"} -- Isabella
    } --:vector<map<string, string>>

    for i = 1, #ai_starting_generals do
        local aiFaction = cm:get_faction(ai_starting_generals[i].faction)
        local factionCA = cm:get_faction(faction)

        if aiFaction and not aiFaction:is_human() and factionCA:subculture() == aiFaction:subculture() and not cm:get_saved_value(ai_starting_generals[i].subtype.."_spawned") then
            cm:unlock_starting_general_recruitment(ai_starting_generals[i].id, ai_starting_generals[i].faction)
            spamLords(ai_starting_generals[i].subtype, ai_starting_generals[i].faction)
        end
    end
end

---- revive faction function
------------------------------------------------------------------

--v function(faction: string, home_region: CA_REGION, regionList: CA_REGION_LIST, x: number, y: number, army: string)
local function reviveFaction(faction, home_region, regionList, x, y, army)
    cm:create_force(
        faction,
        army,
        home_region:name(),
        x,
        y,
        true,
        function(cqi)
            if regionList then
                cm:callback(function()
                    for i = 0, regionList:num_items() - 1 do
                        local currentRegion = regionList:item_at(i)
                        cm:transfer_region_to_faction(currentRegion:name(), faction)
                    end
                end, 1)
            end
        end
    )
end

-- Tomb King army cap bypass
--v function(faction: string) 
local function delete_armies(faction)
    local factionCA = cm:get_faction(faction)
    local charList = factionCA:character_list()
    for j = 0, charList:num_items() - 1 do
        local char = charList:item_at(j)
        local cqi = char:command_queue_index()
        cm:kill_character(cqi, true, false)
        --cm:callback(function()
            if char:is_wounded() then cm:stop_character_convalescing(cqi) end
        --end, 0.5)
    end
end
    
------------------------------------------------------------------------------------------------------------------------------------
---- confed function (rework needed)
------------------------------------------------------------------------------------------------------------------------------------

--v function(subcultures_factions_table: map<string, vector<string>>)
local function confed_factions(subcultures_factions_table)
    local humanFactions = cm:get_human_factions()
    for i = 1, #humanFactions do
        spawnMissingLords(humanFactions[i])
        local humanFaction = cm:get_faction(humanFactions[i])
        --Don't forget Alastar!
        if humanFaction:subculture() == "wh2_main_sc_hef_high_elves" and not cm:get_saved_value("v_wh2_main_hef_prince_alastar_LL_unlocked") then
            if humanFactions[1] ~= "wh2_main_hef_eataine" and humanFactions[2] ~= "wh2_main_hef_eataine" then
                cm:spawn_character_to_pool(humanFactions[i], "names_name_2147360555", "names_name_2147360560", "", "", 18, true, "general", "wh2_main_hef_prince_alastar", true, "")
                cm:set_saved_value("v_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked", true)
                ancillaryOnRankUp(alastar_quests, "wh2_main_hef_prince_alastar")
                if cm:model():campaign_name("main_warhammer") then
                    cm:lock_starting_general_recruitment("1065845653", "wh2_main_hef_eataine")
                else
                    cm:lock_starting_general_recruitment("2140785181", "wh2_main_hef_eataine")
                end
            end
        end

        local subculture = humanFaction:subculture()
        if subcultures_factions_table[subculture] then 
            for _, faction in ipairs(subcultures_factions_table[subculture]) do
                local factionCA = cm:get_faction(faction)
                if factionCA and not factionCA:is_dead() and not factionCA:is_human() and cm:get_saved_value("mcm_tweaker_frostyConfed_player"..i.."|"..faction.."_value") ~= "b2_Disable" then
                    local army_table = {} --:WHATEVER
                    local char_cqi_table --:vector<CA_CQI>
                    local faction_home_region
                    local regionList = factionCA:region_list()
                    if factionCA:has_home_region() then 
                        faction_home_region = factionCA:home_region()
                    else
                        faction_home_region = factionCA:military_force_list():item_at(0):general_character():region() 
                    end
                    -- faction respawn prep
                    if cm:get_saved_value("mcm_tweaker_frostyConfed_zzz03_tHeatre_value") ~= "c1_theatre_Enable" then      
                        local mfList = factionCA:military_force_list()
                        for j = 0, mfList:num_items() - 1 do
                            local mf = mfList:item_at(j)    
                            if mf:has_general() and not mf:is_armed_citizenry() then
                                local army = {}
                                army.home_region = mf:general_character():region():name() 
                                local general = mf:general_character()
                                army.xPos = general:logical_position_x()
                                army.yPos = general:logical_position_y()
                                local unitList = mf:unit_list()
                                local units = ""
                                for k = 1, unitList:num_items() - 1 do
                                    local unit = unitList:item_at(k)
                                    if units ~= "" then units = units.."," end
                                    units = units..unit:unit_key()     
                                end
                                army.units = units
                                table.insert(army_table, army)
                            end
                        end
                        local charList = factionCA:character_list()
                        for l = 0, charList:num_items() - 1 do
                            local char = charList:item_at(l)
                            local cqi = char:command_queue_index()
                            if not wh_faction_is_horde(factionCA) then
                                --HERO KILL EXCEPTION LIST
                                if not char:has_trait("wh2_dlc15_trait_white_wolf") then 
                                    cm:kill_character(cqi, true, false) 
                                end
                            else
                                table.insert(char_cqi_table, cqi)
                            end
                        end
                    end
                    core:add_listener(
                        "frosty_post_confed_"..faction.."_FactionJoinsConfederation",
                        "FactionJoinsConfederation",
                        function(context)
                            return context:confederation():name() == humanFactions[i] and context:faction():name() == faction
                        end,
                        function(context)
                            if cm:get_saved_value("mcm_tweaker_frostyConfed_zzz03_tHeatre_value") ~= "c1_theatre_Enable" then
                                if wh_faction_is_horde(factionCA) then
                                    for _, char_cqi in ipairs(char_cqi_table) do
                                        cm:kill_character(char_cqi, true, false) 
                                    end  
                                else
                                    -- faction respawn
                                    if faction ~= "wh2_dlc13_lzd_spirits_of_the_jungle" then 
                                        reviveFaction(faction, faction_home_region, regionList, army_table[1].xPos, army_table[1].yPos, army_table[1].units)
                                    end
                                    for q = 2, #army_table do
                                        cm:create_force(
                                            faction,
                                            army_table[q].units,
                                            army_table[q].home_region,
                                            army_table[q].xPos,
                                            army_table[q].yPos,
                                            true,
                                            function(cqi)
                                                --
                                            end
                                        )
                                    end
                                    local charList =  humanFaction:character_list()
                                    local spawn_offset = 3
                                    for o = 0, charList:num_items() - 1 do
                                        local char = charList:item_at(o)
                                        local cqi = char:command_queue_index()
                                        if char:is_wounded() then cm:stop_character_convalescing(cqi) end
                                        if not char:is_wounded() and cm:char_is_agent(char) and humanFaction:name() ~= "wh_main_dwf_karak_izor" then
                                            local x, y
                                            if humanFaction:faction_leader():has_military_force() then 
                                                x, y = humanFaction:faction_leader():logical_position_x(), humanFaction:faction_leader():logical_position_y()
                                            else
                                                local mfList =  humanFaction:military_force_list()
                                                for p = 0, mfList:num_items() - 1 do
                                                    local mf = mfList:item_at(p)
                                                    if not mf:is_armed_citizenry() and mf:has_general() and mf:general_character():region():name() == humanFaction:home_region():name() then
                                                        x, y = mf:general_character():logical_position_x(), mf:general_character():logical_position_y()
                                                        break
                                                    end
                                                end
                                            end
                                            local spawnX, spawnY = cm:find_valid_spawn_location_for_character_from_position(humanFactions[i], x, y, true, spawn_offset)
                                            spawn_offset = spawn_offset + 1
                                            --local valid = false
                                            --while not valid do
                                            --    if spawnX ~= -1 then
                                            --        valid = true
                                            --        break
                                            --    end
                                            --    local square = {x - 5, x + 5, y - 5, y + 5}
                                            --    spawnX, spawnY = cm:find_valid_spawn_location_for_character_from_position(humanFactions[i], cm:random_number(square[2], square[1]), cm:random_number(square[4], square[3]), true)
                                            --end
                                            --if valid then
                                                cm:teleport_to(cm:char_lookup_str(cqi), spawnX, spawnY, true)
                                            --end
                                        end
                                    end
                                end
                            end
                            local charList = context:confederation():character_list()
                            for p = 0, charList:num_items() - 1 do
                                local char = charList:item_at(p)
                                local cqi = char:command_queue_index()
                                if char:is_wounded() then cm:stop_character_convalescing(cqi) end
                            end
                        end,
                        false
                    )
                    if subculture == "wh2_dlc09_sc_tmb_tomb_kings" then 
                        if (cm:get_saved_value("mcm_tweaker_frostyConfed_zzz05_restriction_value") ~= "restricted") or (humanFactions[i] ~= "wh2_dlc09_tmb_followers_of_nagash" 
                        and faction ~= "wh2_dlc09_tmb_khemri" and faction ~= "wh2_dlc09_tmb_followers_of_nagash") or cm:get_saved_value("mcm_tweaker_frostyConfed_zzz05_restriction_value") == "unrestricted" then 
                            if vfs.exists("script/campaign/mod/legendary_confeds_tk.lua") then 
                                delete_armies(faction)
                                cm:force_confederation(humanFactions[i], faction) 
                            end
                        end
                    else
                        cm:force_confederation(humanFactions[i], faction)
                    end
                end
            end
        end
        --THEATRES OF WAR
        if cm:get_saved_value("mcm_tweaker_frostyConfed_zzz03_tHeatre_value") == "c1_theatre_Enable" then              
            --check
            if humanFaction:subculture() ~= "wh2_dlc09_sc_tmb_tomb_kings" and humanFaction:subculture() ~= "wh2_dlc11_sc_cst_vampire_coast" 
            or (vfs.exists("script/campaign/mod/legendary_confeds_tk.lua") and humanFaction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings") 
            or (vfs.exists("script/campaign/mod/legendary_confeds_cst.lua") and humanFaction:subculture() == "wh2_dlc11_sc_cst_vampire_coast")  then 
            --
                if not cm:is_multiplayer() 
                or cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() ~= cm:get_faction(humanFactions[2]):subculture() then
                    local factions_of_same_subculture = humanFaction:factions_of_same_subculture()
                    for j = 0, factions_of_same_subculture:num_items() - 1 do
                        local faction_of_same_subculture = factions_of_same_subculture:item_at(j)
                        if (humanFaction:name() == "wh2_dlc09_tmb_followers_of_nagash" and faction_of_same_subculture:name() == "wh2_dlc09_tmb_the_sentinels") 
                        or (humanFaction:name() == "wh2_dlc09_tmb_the_sentinels" and faction_of_same_subculture:name() == "wh2_dlc09_tmb_followers_of_nagash") or
                        (humanFaction:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and humanFaction:name() ~= "wh2_dlc09_tmb_the_sentinels" 
                        and faction_of_same_subculture:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and faction_of_same_subculture:name() ~= "wh2_dlc09_tmb_the_sentinels") 
                        or cm:get_saved_value("mcm_tweaker_frostyConfed_zzz05_restriction_value") == "unrestricted" then
                            if humanFaction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then delete_armies(faction_of_same_subculture:name()) end
                            cm:force_confederation(humanFactions[i], faction_of_same_subculture:name())
                        end
                    end
                end
            end
        end
    end
    for subculture, factions in pairs(subcultures_factions_table) do
        --check for submods
        if subculture ~= "wh2_dlc09_sc_tmb_tomb_kings" and subculture ~= "wh2_dlc11_sc_cst_vampire_coast" 
        or (vfs.exists("script/campaign/mod/legendary_confeds_tk.lua") and subculture == "wh2_dlc09_sc_tmb_tomb_kings") 
        or (vfs.exists("script/campaign/mod/legendary_confeds_cst.lua") and subculture == "wh2_dlc11_sc_cst_vampire_coast") then 
            if (not cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() ~= subculture) 
            or (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() ~= subculture and cm:get_faction(humanFactions[2]):subculture() ~= subculture) then
                --DEADLY ALLIANCES
                if cm:get_saved_value("mcm_tweaker_frostyConfed_zzz04_deadlyAlliances_value") == "d1_deadly_Enable" then                     
                    if factions[1] and cm:get_faction(factions[1]) then spawnMissingLords(factions[1]) end
                    for i = 1, #factions do
                        if factions[i] and subcultures_factions[subculture][1] ~= factions[i] and (cm:get_saved_value("mcm_tweaker_frostyConfed_zzz05_restriction_value") == "unrestricted"
                        or (factions[i] ~= "wh2_dlc09_tmb_followers_of_nagash" and factions[i] ~= "wh2_dlc09_tmb_the_sentinels")) then 
                            if subculture == "wh2_dlc09_sc_tmb_tomb_kings" then delete_armies(factions[i]) end
                            cm:force_confederation(subcultures_factions[subculture][1], factions[i])
                        end
                    end
                end
                --WORLD WAR
                if cm:get_saved_value("mcm_tweaker_frostyConfed_zzz04_deadlyAlliances_value") == "d2_deadly_Enable_worldwar" then
                    if factions[1] and cm:get_faction(factions[1]) then 
                        spawnMissingLords(factions[1])
                        local faction1 = cm:get_faction(factions[1])
                        local factions_of_same_subculture = faction1:factions_of_same_subculture()
                        for i = 0, factions_of_same_subculture:num_items() - 1 do
                            local faction_of_same_subculture = factions_of_same_subculture:item_at(i)
                            if cm:get_saved_value("mcm_tweaker_frostyConfed_zzz05_restriction_value") == "unrestricted" or (faction_of_same_subculture:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and faction_of_same_subculture:name() ~= "wh2_dlc09_tmb_the_sentinels") then
                                if subculture == "wh2_dlc09_sc_tmb_tomb_kings" then  delete_armies(faction_of_same_subculture:name()) end
                                cm:force_confederation(subcultures_factions[subculture][1], faction_of_same_subculture:name())
                            end
                        end
                    end
                end
            end
        end
    end
end

---- heal all garrisons (trigger after confederation)
------------------------------------------------------------------

--v function()
local function heal_garrisons()
    local faction_list = cm:model():world():faction_list()
    for i = 0, faction_list:num_items() - 1 do
        local current_faction = faction_list:item_at(i)
        local region_list = current_faction:region_list()
        for i = 0, region_list:num_items() - 1 do
            local current_region = region_list:item_at(i)
            local current_region_cqi = current_region:cqi()
            cm:heal_garrison(current_region_cqi)
        end
    end
end

---- remove confed penalties (trigger after confederation)
------------------------------------------------------------------

--v function(subcultures_factions_table: map<string, vector<string>>)
local function remove_confed_penalties(subcultures_factions_table)
    local bundles = {
        "wh2_main_bundle_confederation_skv",
        "wh2_main_bundle_confederation_lzd",
        "wh2_main_bundle_confederation_hef",
        "wh2_main_bundle_confederation_def",
        "wh_main_bundle_confederation_grn",
        "wh_main_bundle_confederation_vmp",
        "wh_main_bundle_confederation_dwf",
        "wh_main_bundle_confederation_emp",
        "wh_main_bundle_confederation_brt",
        "wh_main_bundle_confederation_wef",
        "wh_dlc03_beastmen_confederation_help",
        "wh2_main_bundle_confederation_tmb"
    } --:vector<string>

    for i = 1, #bundles do
        for _, factions in pairs(subcultures_factions_table) do
            for _, faction in ipairs(factions) do
                if faction then
                    local factionCA = cm:get_faction(faction)
                    if factionCA and factionCA:has_effect_bundle(bundles[i]) then 
                        cm:remove_effect_bundle(bundles[i], faction) 
                    end
                end
            end
        end
    end
end

---- apply effect bundles (deadly alliances equalizer)
------------------------------------------------------------------      
-- can implement a decrementing model if I want to be fancy
-- icons can be hidden in db
-- relevant to leader factions and any factions they confederate, applies after that

--v function(leaderFactions_table: map<string, vector<string>>)
local function apply_bundles(leaderFactions_table)
    local custom_upkeep_bundle = cm:create_new_custom_effect_bundle("frosty_custom_upkeep_key")
    custom_upkeep_bundle:add_effect("wh_main_effect_force_all_campaign_upkeep", "force_to_force_own", -70)
    custom_upkeep_bundle:set_duration(10)
    for i = 1, #leaderFactions do
        local current_leaderFaction = leaderFactions[i];
        local faction_obj = cm:get_faction(current_leaderFaction)
        --set is human true to test 
        if faction_obj and faction_obj:is_human() == false and cm:is_new_game() == true then
            if cm:get_saved_value("mcm_tweaker_frostyConfed_zzz04_deadlyAlliances_value") == "d1_deadly_Enable" or 
            cm:get_saved_value("mcm_tweaker_frostyConfed_zzz04_deadlyAlliances_value") == "d2_deadly_Enable_worldwar" then
                local army_list = faction_obj:military_force_list();
                for j = 0, army_list:num_items() - 1 do
                    local army = army_list:item_at(j);
                    cm:apply_custom_effect_bundle_to_force(custom_upkeep_bundle, army);
                end
            end
        end
    end
end

---- immortality solution (trigger after confederation)
------------------------------------------------------------------

local subtype_immortality = { 
    ["wh2_dlc09_tmb_arkhan"] = true,
    ["wh2_dlc09_tmb_khalida"] = true,
    ["wh2_dlc09_tmb_khatep"] = true,
    ["wh2_dlc09_tmb_settra"] = true,
    ["wh2_dlc11_cst_aranessa"] = true,
    ["wh2_dlc11_cst_cylostra"] = true,
    ["wh2_dlc11_cst_harkon"] = true,
    ["wh2_dlc11_cst_noctilus"] = true
} --: map<string, boolean>

--v function()
local function reapply_immortality()
    local faction_list = cm:model():world():faction_list()
    for i = 0, faction_list:num_items() - 1 do
        local current_faction = faction_list:item_at(i)
        local char_list = current_faction:character_list()
        for j = 0, char_list:num_items() - 1 do 
            local char = char_list:item_at(j)
            if subtype_immortality[char:character_subtype_key()] then 
                cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), true) 
            end 
        end
    end       
end

------------------------------------------------------------------------------------------------------------------------------------
---- legendary_confeds function
------------------------------------------------------------------------------------------------------------------------------------
   
---- MCT OPTIONS
------------------------------------------------------------------

---- sm0kin's deluxe request character name function 
--v function(char: CA_CHAR) --> string
local function get_full_char_name(char)
    local leader_forename = char:get_forename()
    local leader_surname = char:get_surname()
    local loc_leader_forename = effect.get_localised_string(leader_forename)
    local loc_leader_surname = effect.get_localised_string(leader_surname)
    local full_char_name = ""

    if is_string(loc_leader_forename) and loc_leader_forename ~= "" then
        full_char_name = full_char_name..loc_leader_forename
    end
    if is_string(loc_leader_surname) and loc_leader_surname ~= "" then
        if is_string(loc_leader_forename) and loc_leader_forename ~= "" then full_char_name = full_char_name.." " end
        full_char_name = full_char_name..loc_leader_surname
    end
    return full_char_name
end

---- Confed Listeners
------------------------------------------------------------------

--v function(enable: boolean)
local function init_frosty_confeds_listeners(enable)
    core:remove_listener("frosty_confed_expired")
    core:remove_listener("frosty_horde_FactionJoinsConfederation")
    if enable then
        -- COMPATIBILITY BRIDGE: Vandy Confed Options
        core:add_listener(
            "frosty_confed_expired",
            "ScriptEventConfederationExpired",
            true,
            function(context)
                local subculture_confed_disabled = {
                    -- by default
                    "wh_main_sc_chs_chaos",
                    "wh_main_sc_grn_savage_orcs",
                    "wh_main_sc_ksl_kislev",
                    "wh_main_sc_teb_teb",
                    "wh2_dlc09_sc_tmb_tomb_kings",
                    "wh2_main_rogue_abominations",
                    "wh2_main_rogue_beastcatchas",
                    "wh2_main_rogue_bernhoffs_brigands",
                    "wh2_main_rogue_black_spider_tribe",
                    "wh2_main_rogue_boneclubbers_tribe",
                    "wh2_main_rogue_celestial_storm",
                    "wh2_main_rogue_college_of_pyrotechnics",
                    "wh2_main_rogue_doomseekers",
                    "wh2_main_rogue_gerhardts_mercenaries",
                    "wh2_main_rogue_heirs_of_mourkain",
                    "wh2_main_rogue_hung_warband",
                    "wh2_main_rogue_hunters_of_kurnous",
                    "wh2_main_rogue_jerrods_errantry",
                    "wh2_main_rogue_mangy_houndz",
                    "wh2_main_rogue_mengils_manflayers",
                    "wh2_main_rogue_morrsliebs_howlers",
                    "wh2_main_rogue_pirates_of_the_far_sea",
                    "wh2_main_rogue_pirates_of_the_southern_ocean",
                    "wh2_main_rogue_pirates_of_trantio",
                    "wh2_main_rogue_scions_of_tesseninck",
                    "wh2_main_rogue_scourge_of_aquitaine",
                    "wh2_main_rogue_stuff_snatchers",
                    "wh2_main_rogue_teef_snatchaz",
                    "wh2_main_rogue_the_wandering_dead",
                    "wh2_main_rogue_tor_elithis",
                    "wh2_main_rogue_troll_skullz",
                    "wh2_main_rogue_vashnaar",
                    "wh2_main_rogue_vauls_expedition",
                    "wh2_main_rogue_worldroot_rangers",
                    "wh2_main_rogue_wrath_of_nature",
                    --"wh2_dlc11_sc_cst_vampire_coast"
                } --:vector<string>
                local faction_name = context.string
                local faction = cm:get_faction(faction_name)
                if faction then
                    local subculture = faction:subculture()
                    local culture = faction:culture()
                    local confed_option_value 
                    local confederation_options_mod 
                    local mct = core:get_static_object("mod_configuration_tool")
                    if mct then 
                        confederation_options_mod = mct:get_mod_by_key("confederation_options")
                        if confederation_options_mod then 
                            local confed_option = confederation_options_mod:get_option_by_key(culture)
                            if confed_option then 
                                confed_option_value = confed_option:get_finalized_setting()
                            else
                                confed_option = confederation_options_mod:get_option_by_key(subculture)
                                confed_option_value = confed_option:get_finalized_setting()
                            end
                        end
                    end
                    local option = {}
                    local option_sc = {}
                    if confed_option_value == "free_confed" then
                        option.offer = true
                        option.accept = true
                        option.both_directions = true
                    elseif confed_option_value == "player_only" then
                        if faction:is_human() then
                            option.offer = true
                            option.accept = true
                            option.both_directions = false
                        else
                            option.offer = false
                            option.accept = true
                            option.both_directions = false	
                        end
                    elseif confed_option_value == "disabled" then
                        option.offer = false
                        option.accept = false
                        option.both_directions = false				
                    elseif confed_option_value == "no_tweak" or confed_option_value == nil then
                        option.offer = true
                        option.accept = true
                        option.both_directions = false
                        for i, subculture_confed in ipairs(subculture_confed_disabled) do
                            if subculture == subculture_confed then
                                option_sc.offer = false
                                option_sc.accept = false
                                option_sc.both_directions = false
                            end
                        end	
                        if vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") and subculture == "wh_main_sc_teb_teb" then 
                            option_sc.offer = true
                            option_sc.accept = true
                            option_sc.both_directions = false            
                        end
                        if faction:has_pooled_resource("emp_loyalty") == true then
                            option.offer = false
                            option.accept = false
                            option.both_directions = false
                        end
                        if subculture == "wh_dlc05_sc_wef_wood_elves" then
                            option_sc.accept = false
                            option_sc.both_directions = false        	
                            oak_region = cm:get_region("wh_main_yn_edri_eternos_the_oak_of_ages")
                            if oak_region:building_exists("wh_dlc05_wef_oak_of_ages_3") or oak_region:building_exists("wh_dlc05_wef_oak_of_ages_4") or oak_region:building_exists("wh_dlc05_wef_oak_of_ages_5") then
                                option_sc.offer = true
                            else
                                option_sc.offer = false
                            end  
                        end
                    end
                    cm:callback(
                        function(context)
                            if option.offer ~= nil and option.accept ~= nil and option.both_directions ~= nil then
                                cm:force_diplomacy("faction:" .. faction_name, "culture:" .. culture, "form confederation", option.offer, option.accept, option.both_directions)
                            end
                            if option_sc.offer ~= nil and option_sc.accept ~= nil and option_sc.both_directions ~= nil then
                                cm:force_diplomacy("faction:" .. faction_name, "subculture:" .. subculture, "form confederation", option_sc.offer, option_sc.accept, option_sc.both_directions)
                            end
    
                            if faction:name() == "wh_main_vmp_rival_sylvanian_vamps" then
                                cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps", "faction:wh_main_vmp_vampire_counts", "form confederation", false, false, true)
                                cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps", "faction:wh_main_vmp_schwartzhafen", "form confederation", false, false, true)
                            end
                            if (confed_option_value == "no_tweak" or confed_option_value == nil) and subculture == "wh_main_sc_brt_bretonnia" and faction:is_human() 
                            and faction_name ~= "wh2_dlc14_brt_chevaliers_de_lyonesse" then
                                local bret_confederation_tech = {
                                    {tech = "tech_dlc07_brt_heraldry_artois", faction = "wh_main_brt_artois"},
                                    {tech = "tech_dlc07_brt_heraldry_bastonne", faction = "wh_main_brt_bastonne"},
                                    {tech = "tech_dlc07_brt_heraldry_bordeleaux", faction = "wh_main_brt_bordeleaux"},
                                    {tech = "tech_dlc07_brt_heraldry_bretonnia", faction = "wh_main_brt_bretonnia"},
                                    {tech = "tech_dlc07_brt_heraldry_carcassonne", faction = "wh_main_brt_carcassonne"},
                                    {tech = "tech_dlc07_brt_heraldry_lyonesse", faction = "wh_main_brt_lyonesse"},
                                    {tech = "tech_dlc07_brt_heraldry_parravon", faction = "wh_main_brt_parravon"}
                                } --:vector<map<string, string>>
                                for i = 1, #bret_confederation_tech do
                                    local has_tech = faction:has_technology(bret_confederation_tech[i].tech)
                                    cm:force_diplomacy("faction:"..faction:name(), "faction:"..bret_confederation_tech[i].faction, "form confederation", has_tech, has_tech, true)
                                end
                            end
                            if faction:is_human() and faction:has_pooled_resource("emp_loyalty") == true then
                                cm:force_diplomacy("faction:"..faction_name, "faction:wh2_dlc13_emp_the_huntmarshals_expedition", "form confederation", true, true, false)
                                cm:force_diplomacy("faction:"..faction_name, "faction:wh2_main_emp_sudenburg", "form confederation", true, true, false)
                            end
                            ---hack fix to stop this re-enabling confederation when it needs to stay disabled
                            ---please let's make this more robust!
                            if subculture == "wh2_main_sc_hef_high_elves" then
                                local grom_faction = cm:get_faction("wh2_dlc15_grn_broken_axe")
                                if grom_faction ~= false and grom_faction:is_human() then
                                    cm:force_diplomacy("subculture:wh2_main_sc_hef_high_elves","faction:wh2_main_hef_yvresse","form confederation", false, true, false);
                                end
                            end
                        end, 1, "changeDiplomacyOptions"
                    )
                end
            end,
            true
        )
    
        core:add_listener(
            "frosty_horde_FactionJoinsConfederation",
            "FactionJoinsConfederation",
            function(context)
                return cm:turn_number() == 1 and context:confederation():name() == "wh2_dlc13_lzd_spirits_of_the_jungle"
            end,
            function(context)
                cm:callback(function()
                    local defender_faction = cm:model():world():faction_by_key("wh2_dlc13_lzd_defenders_of_the_great_plan")
                    if defender_faction and not defender_faction:is_dead() then    
                        cm:kill_all_armies_for_faction(defender_faction)
                    end
                end, 2)      
            end,
            true
        )
    end
end

--v function()
local function start_confeds()
    init_frosty_confeds_listeners(true)
    --CLEAR EVENT LOG
    cm:disable_event_feed_events(true)
    --FIRE IN THE HOLE
    confed_factions(subcultures_factions)
    if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") then confed_factions(mixu1_subcultures_factions) end -- compatibility for mixu's legendary lords 1 (script path might change)
    if vfs.exists("script/campaign/mod/mixu_darkhand.lua") then confed_factions(mixu2_subcultures_factions) end -- compatibility for mixu's legendary lords 2 (script path might change)     
    --CLEAR EVENT LOG
    cm:callback(function() 
        remove_confed_penalties(subcultures_factions)
        heal_garrisons()
        apply_bundles(subcultures_factions)
        reapply_immortality()
        cm:disable_event_feed_events(false) 
        init_frosty_confeds_listeners(false)
    end, 3)
end

--v function()
function legendary_confeds()
    local mcm = _G.mcm
    local mct = core:get_static_object("mod_configuration_tool")
    local humanFactions = cm:get_human_factions()

    if mct then
        -- MCT new --
        --mct:log("sm0_confed/mct/enable_value = "..tostring(enable_value))
		--mct:log("sm0_confed/mct/restriction_value = "..tostring(restriction_value))
		local confederation_options_mod = mct:get_mod_by_key("confederation_options")
		if confederation_options_mod and cm:is_new_game() then
			local tk_option = confederation_options_mod:get_option_by_key("wh2_dlc09_tmb_tomb_kings")
			tk_value = tk_option:get_finalized_setting()
			if tk_value == "no_tweak" then
				cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
			end
			local emp_option = confederation_options_mod:get_option_by_key("wh_main_emp_empire")
			emp_value = emp_option:get_finalized_setting() -- no teb / kislev subculture?
			if emp_value == "no_tweak" and not vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then
				cm:force_diplomacy("subculture:wh_main_sc_teb_teb", "subculture:wh_main_sc_teb_teb", "form confederation", false, false, false)
			end
        end
        if cm:is_new_game() then
            if not cm:is_multiplayer() or (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() ~= cm:get_faction(humanFactions[2]):subculture()) then
                local frosty_confeds_mod = mct:get_mod_by_key("frosty_confeds")
                local settings_table = frosty_confeds_mod:get_settings() 

                frosty_confeds_mod:add_new_section("faction_options", "Faction Options") 
                test_option = frosty_confeds_mod:add_new_option("test_option", "dropdown")

                for i = 1, #humanFactions do
                    local humanFaction = cm:get_faction(humanFactions[i])
                    local subculture = humanFaction:subculture()
                    if subculture ~= "wh2_dlc09_sc_tmb_tomb_kings" and subculture ~= "wh2_dlc11_sc_cst_vampire_coast" 
                    or (vfs.exists("script/campaign/mod/legendary_confeds_tk.lua") and subculture == "wh2_dlc09_sc_tmb_tomb_kings") 
                    or (vfs.exists("script/campaign/mod/legendary_confeds_cst.lua") and subculture == "wh2_dlc11_sc_cst_vampire_coast")  then 
                        --TOMB KINGS/VAMPIRE COAST MODULE
                        if subcultures_factions[subculture] then 
                            for _, faction in ipairs(subcultures_factions[subculture]) do
                                local faction_CA = cm:get_faction(faction)
                                if faction_CA and not faction_CA:is_dead() and not faction_CA:is_human() then 
                                    local loc_prefix = "mct_frosty_confeds_"
                                    local player_confed_string = "Player-"..i.."Confederation with "..get_full_char_name(faction_CA:faction_leader())
                                    local frosty_confeds_option = frosty_confeds_mod:get_option_by_key("player_faction_"..faction, "dropdown")
                                    if frosty_confeds_option then
                                        frosty_confeds_option:add_dropdown_value("player_"..i, "Player "..i, player_confed_string)
                                    else
                                        frosty_confeds_option = frosty_confeds_mod:add_new_option("player_faction_"..faction, "dropdown")
                                        frosty_confeds_option:set_text("Confederation with "..get_full_char_name(faction_CA:faction_leader()), false)
                                        frosty_confeds_option:set_tooltip_text("Confederation with "..get_full_char_name(faction_CA:faction_leader()), false)
                                        frosty_confeds_option:add_dropdown_value("player_"..i, "Player "..i, player_confed_string, true)
                                        frosty_confeds_option:add_dropdown_value("disabled", "Disabled", "")

                                        if (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() == cm:get_faction(humanFactions[2]):subculture())
                                        or (humanFactions[1] == "wh2_dlc09_tmb_followers_of_nagash") or (humanFactions[2] == "wh2_dlc09_tmb_followers_of_nagash")
                                        or (faction == "wh2_dlc09_tmb_khemri") or faction == "wh2_dlc09_tmb_followers_of_nagash" then 
                                            frosty_confeds_option:set_default_value("disabled")
                                        end
                                    end
                                end
                            end
                        end

                        --COMPATIBILITY BRIDGE: MIXU module
                        if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") and mixu1_subcultures_factions[subculture] then -- compatibility for mixu's legendary lords 1 (script path might change)
                            for _, faction in ipairs(mixu1_subcultures_factions[subculture]) do
                            local faction_CA = cm:get_faction(faction)
                                if faction_CA and not faction_CA:is_dead() and not faction_CA:is_human() then
                                    local loc_prefix = "mct_frosty_confeds_"
                                    local player_confed_string = "Player-"..i.."Confederation with "..get_full_char_name(faction_CA:faction_leader())
                                    local frosty_confeds_option = frosty_confeds_mod:get_option_by_key("player_faction_"..faction, "dropdown")
                                    if frosty_confeds_option then
                                        frosty_confeds_option:add_dropdown_value("player_"..i, "Player "..i, player_confed_string)
                                    else
                                        local frosty_confeds_option = frosty_confeds_mod:add_new_option("player_faction_"..faction, "dropdown")
                                        frosty_confeds_option:set_text("Confederation with "..get_full_char_name(faction_CA:faction_leader()), false)
                                        frosty_confeds_option:set_tooltip_text("Confederation with "..get_full_char_name(faction_CA:faction_leader()), false)
                                        frosty_confeds_option:add_dropdown_value("player_"..i, "Player "..i, player_confed_string, true)
                                        frosty_confeds_option:add_dropdown_value("disabled", "Disabled", "")

                                        if (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() == cm:get_faction(humanFactions[2]):subculture())
                                        or (humanFactions[1] == "wh2_dlc09_tmb_followers_of_nagash") or (humanFactions[2] == "wh2_dlc09_tmb_followers_of_nagash")
                                        or (faction == "wh2_dlc09_tmb_khemri") or faction == "wh2_dlc09_tmb_followers_of_nagash" then 
                                            frosty_confeds_option:set_default_value("disabled")
                                        end
                                    end
                                end
                            end
                        end
                        --COMPATIBILITY BRIDGE: MIXU module 2
                        if vfs.exists("script/campaign/mod/mixu_darkhand.lua") and mixu2_subcultures_factions[subculture] then -- compatibility for mixu's legendary lords 2 (script path might change)
                            for _, faction in ipairs(mixu2_subcultures_factions[subculture]) do
                                local faction_CA = cm:get_faction(faction)
                                if faction_CA and not faction_CA:is_dead() and not faction_CA:is_human() then 
                                    local loc_prefix = "mct_frosty_confeds_"
                                    local player_confed_string = "Player-"..i.."Confederation with "..get_full_char_name(faction_CA:faction_leader())
                                    local frosty_confeds_option = frosty_confeds_mod:get_option_by_key("player_faction_"..faction, "dropdown")
                                    if frosty_confeds_option then
                                        frosty_confeds_option:add_dropdown_value("player_"..i, "Player "..i, player_confed_string)
                                    else
                                        local frosty_confeds_option = frosty_confeds_mod:add_new_option("player_faction_"..faction, "dropdown")
                                        frosty_confeds_option:set_text("Confederation with "..get_full_char_name(faction_CA:faction_leader()), false)
                                        frosty_confeds_option:set_tooltip_text("Confederation with "..get_full_char_name(faction_CA:faction_leader()), false)
                                        frosty_confeds_option:add_dropdown_value("player_"..i, "Player "..i, player_confed_string, true)
                                        frosty_confeds_option:add_dropdown_value("disabled", "Disabled", "")

                                        if (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() == cm:get_faction(humanFactions[2]):subculture())
                                        or (humanFactions[1] == "wh2_dlc09_tmb_followers_of_nagash") or (humanFactions[2] == "wh2_dlc09_tmb_followers_of_nagash")
                                        or (faction == "wh2_dlc09_tmb_khemri") or faction == "wh2_dlc09_tmb_followers_of_nagash" then 
                                            frosty_confeds_option:set_default_value("disabled")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                pulse_uicomponent(find_uicomponent(core:get_ui_root(), "sp_frame", "menu_bar", "button_mct_options"), true, 10, false, "active")
                ---- MCT2 Listener
                ------------------------------------------------------------------
                core:add_listener(
                    "frosty_confeds_MctFinalized",
                    "MctFinalized",
                    true,
                    function(context)
                        local mct = get_mct()
                        local frosty_confeds_mod = mct:get_mod_by_key("frosty_confeds")
                        local settings_table = frosty_confeds_mod:get_settings() 
                        enable_value = settings_table._01_enableorDisable
                        zzz03_tHeatre_value = settings_table.zzz03_tHeatre
                        zzz04_deadlyAlliances_value = settings_table.zzz04_deadlyAlliances
                        zzz05_restriction_value = settings_table.zzz05_restriction

                        pulse_uicomponent(find_uicomponent(core:get_ui_root(), "sp_frame", "menu_bar", "button_mct_options"), false, 10, false, "active")
                        start_confeds()
                        --set_read_only

                    end,
                    false
                )
                -- save game listener to force mctfinalized
            end
        else
            --set_read_only
        end

    else
        local tk_value = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc09_tmb_tomb_kings_value")
		if not tk_value or tk_value == "yield" then
			cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
		end
		local emp_value = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh_main_emp_empire") -- no teb / kislev subculture?
		if (not emp_value or emp_value == "yield") and not vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then
			cm:force_diplomacy("subculture:wh_main_sc_teb_teb", "subculture:wh_main_sc_teb_teb", "form confederation", false, false, false)
		end
		enable_value = true
        -- OPTIONS
        if mcm then
            local frostyConfed = mcm:register_mod("frostyConfed", "Legendary Confederations", "Start your next grand campaign with the legendary lords already rallied to your side or have the enemy legendary lords unite against you!")
            
            --MOD ON/OFF SWITCH
            local _01_enableorDisable = frostyConfed:add_tweaker("_01_enableorDisable", "• Mod Status", "")
            _01_enableorDisable:add_option("a1_mod_Enable", "On", "")
            _01_enableorDisable:add_option("a2_mod_Disable", "Off", "")

            --THEATRES OF WAR MODE
            local zzz03_tHeatre = frostyConfed:add_tweaker("zzz03_tHeatre", "• Theatres of War mode (include regions & armies)", "Factions are confederated through regular confederations. You gain control over their settlements and armies, both near and far away. Tough decisions about what to keep will have to be made, as you will struggle to finance all of it.")
            zzz03_tHeatre:add_option("c2_theatre_Disable", "Off (Normal)", "")
            zzz03_tHeatre:add_option("c1_theatre_Enable", "On", "")

            --DEADLY ALLIANCES MODE (confederates AI (regular way - with armies and regions))
            local zzz04_deadlyAlliances = frostyConfed:add_tweaker("zzz04_deadlyAlliances", "• Deadly Alliances mode (AI confederations) (*experimental*)", "Factions under AI control will set aside differences and form super-factions. For those seeking a radical and fun challenge. Not recommended for first timers as it will throw the intended world balance between factions out of wack!")
            zzz04_deadlyAlliances:add_option("d3_deadly_Disable", "Off (Normal)", "")
            zzz04_deadlyAlliances:add_option("d1_deadly_Enable", "On (Main Factions)", "*Takes a few seconds to load!* The AI-controlled Legendary Lord factions confederates to form super-factions.")
            zzz04_deadlyAlliances:add_option("d2_deadly_Enable_worldwar", "On (World War)", "*Takes a few seconds to load!* ALL AI-controlled factions, major or minor, confederates to form super-super-factions.")

            --TOMB KINGS LORE RESTRICTION
            if vfs.exists("script/campaign/mod/legendary_confeds_tk.lua") then
                local zzz05_restriction = frostyConfed:add_tweaker("zzz05_restriction", "• Tomb Kings - Lore Restrictions", "Settra does not serve... right?")
                zzz05_restriction:add_option("restricted", "On (Loreful)", "Khemri (Settra) and Followers of Nagash (Arkhan) cannot be confederated in this menu.")
                zzz05_restriction:add_option("unrestricted", "Off (Heretic!)", "Khemri (Settra) and Followers of Nagash (Arkhan) can be confederated in this menu.")
            end

            --PIZZA TIME
            for i = 1, #humanFactions do
                local humanFaction = cm:get_faction(humanFactions[i])
                local subculture = humanFaction:subculture()

                --MODULE CHECKS
                if subculture ~= "wh2_dlc09_sc_tmb_tomb_kings" and subculture ~= "wh2_dlc11_sc_cst_vampire_coast" 
                or (vfs.exists("script/campaign/mod/legendary_confeds_tk.lua") and subculture == "wh2_dlc09_sc_tmb_tomb_kings") 
                or (vfs.exists("script/campaign/mod/legendary_confeds_cst.lua") and subculture == "wh2_dlc11_sc_cst_vampire_coast")  then 
                    --TOMB KINGS/VAMPIRE COAST MODULE
                    if subcultures_factions[subculture] then 
                        for _, faction in ipairs(subcultures_factions[subculture]) do
                            local faction_CA = cm:get_faction(faction)
                            if faction_CA and not faction_CA:is_dead() and not faction_CA:is_human() then 
                                local player_confed_string = "Player-"..i.." Confederation with "..get_full_char_name(faction_CA:faction_leader())
                                local _02_playerConfederations = frostyConfed:add_tweaker("player"..i.."|"..faction, player_confed_string, "") 
                                if (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() == cm:get_faction(humanFactions[2]):subculture())
                                or (humanFactions[1] == "wh2_dlc09_tmb_followers_of_nagash") or (humanFactions[2] == "wh2_dlc09_tmb_followers_of_nagash")
                                or (faction == "wh2_dlc09_tmb_khemri") or faction == "wh2_dlc09_tmb_followers_of_nagash" then 
                                    _02_playerConfederations:add_option("b1_Enable", "Accept", "")
                                    _02_playerConfederations:add_option("b2_Disable", "Decline", "")
                                else
                                    _02_playerConfederations:add_option("b1_Enable", "Accept", "")
                                    _02_playerConfederations:add_option("b2_Disable", "Decline", "")
                                end
                            end
                        end
                    end

                    --COMPATIBILITY BRIDGE: MIXU module
                    if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") and mixu1_subcultures_factions[subculture] then -- compatibility for mixu's legendary lords 1 (script path might change)
                        for _, faction in ipairs(mixu1_subcultures_factions[subculture]) do
                        local faction_CA = cm:get_faction(faction)
                            if faction_CA and not faction_CA:is_dead() and not faction_CA:is_human() then
                                local player_confed_string = "Player-"..i.." Confederation with "..get_full_char_name(faction_CA:faction_leader())
                                local _02_playerConfederations = frostyConfed:add_tweaker("player"..i.."|"..faction, player_confed_string, "") 
                                _02_playerConfederations:add_option("b1_Enable", "Accept", "")
                                _02_playerConfederations:add_option("b2_Disable", "Decline", "")
                            end
                        end
                    end
                    --COMPATIBILITY BRIDGE: MIXU module 2
                    if vfs.exists("script/campaign/mod/mixu_darkhand.lua") and mixu2_subcultures_factions[subculture] then -- compatibility for mixu's legendary lords 2 (script path might change)
                        for _, faction in ipairs(mixu2_subcultures_factions[subculture]) do
                            local faction_CA = cm:get_faction(faction)
                            if faction_CA and not faction_CA:is_dead() and not faction_CA:is_human() then 
                                local player_confed_string = "Player-"..i.." Confederation with "..get_full_char_name(faction_CA:faction_leader())
                                local _02_playerConfederations = frostyConfed:add_tweaker("player"..i.."|"..faction, player_confed_string, "") 
                                _02_playerConfederations:add_option("b1_Enable", "Accept", "")
                                _02_playerConfederations:add_option("b2_Disable", "Decline", "")
                            end
                        end
                    end
                end
            end
            --MCM IS ENABLED
            mcm:add_new_game_only_callback(
                function()
                    if cm:get_saved_value("mcm_tweaker_frostyConfed__01_enableorDisable_value") == "a1_mod_Enable" then
                        enable_value = true
                        if cm:get_saved_value("mcm_tweaker_frostyConfed_zzz03_tHeatre_value") == "c1_theatre_Enable" then 
                            zzz03_tHeatre_value = true
                        end
                        zzz04_deadlyAlliances =  cm:get_saved_value("mcm_tweaker_frostyConfed_zzz04_deadlyAlliances_value") 
                        if cm:get_saved_value("mcm_tweaker_frostyConfed_zzz05_restriction_value") == "restricted" then 
                            zzz05_restriction = true
                        end

                        for i = 1, #humanFactions do
                            local humanFaction = cm:get_faction(humanFactions[i])
                            local subculture = humanFaction:subculture()
                            for _, faction in ipairs(subcultures_factions[subculture]) do
                                if cm:get_saved_value("mcm_tweaker_frostyConfed_player"..i.."|"..faction.."_value") ~= "b2_Disable" then
                                    enabled_factions[faction] = humanFactions[i]
                                end
                            end

                            if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") and mixu1_subcultures_factions[subculture] then -- compatibility for mixu's legendary lords 1 (script path might change)
                                for _, faction in ipairs(mixu1_subcultures_factions[subculture]) do
                                    if cm:get_saved_value("mcm_tweaker_frostyConfed_player"..i.."|"..faction.."_value") ~= "b2_Disable" then
                                        enabled_factions[faction] = humanFactions[i]
                                    end
                                end
                            end
                            if vfs.exists("script/campaign/mod/mixu_darkhand.lua") and mixu2_subcultures_factions[subculture] then -- compatibility for mixu's legendary lords 2 (script path might change)
                                for _, faction in ipairs(mixu2_subcultures_factions[subculture]) do
                                    if cm:get_saved_value("mcm_tweaker_frostyConfed_player"..i.."|"..faction.."_value") ~= "b2_Disable" then
                                        enabled_factions[faction] = humanFactions[i]
                                    end
                                end
                            end
                        end
                        start_confeds()
                    end
                end
            )
        else
            if cm:is_new_game() then
                if not cm:is_multiplayer() or (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() ~= cm:get_faction(humanFactions[2]):subculture()) then
                    start_confeds()
                end
            end
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------
---- vanilla function override (wh_dlc06_karak_eight_peaks.lua)
------------------------------------------------------------------------------------------------------------------------------------

local belegar_characters = {
	-- Belegar Ironhammer [Lord]
	{forename = "names_name_2147358029", surname = "names_name_2147358036", start_xp = 0, kill_if_AI = false, start_skills = {}},
	-- King Lunn Ironhammer [Thane]
	{forename = "names_name_2147358979", surname = "names_name_2147358036", start_xp = 4200, kill_if_AI = false, start_skills = {"wh_main_skill_all_all_self_blade_master_starter", "wh_main_skill_all_all_self_devastating_charge", "wh_main_skill_all_all_self_hard_to_hit", "wh_main_skill_all_all_self_deadly_blade"}},
	-- Throni Ironbrow [Runesmith]
	{forename = "names_name_2147358988", surname = "names_name_2147358994", start_xp = 4200, kill_if_AI = false, start_skills = {"wh_main_skill_dwf_runesmith_self_rune_of_hearth_&_home", "wh_main_skill_dwf_runesmith_self_rune_of_oath_&_steel", "wh_main_skill_dwf_runesmith_self_strike_the_runes", "wh_main_skill_dwf_runesmith_self_forgefire"}},
	-- Halkenhaf Stonebeard [Thane]
	{forename = "names_name_2147358982", surname = "names_name_2147358985", start_xp = 4200, kill_if_AI = false, start_skills = {"wh_main_skill_all_all_self_blade_master_starter", "wh_main_skill_all_all_self_devastating_charge", "wh_main_skill_all_all_self_hard_to_hit", "wh_main_skill_all_all_self_deadly_blade"}},
	-- Dramar Hammerfist [Engineer]
	{forename = "names_name_2147359003", surname = "names_name_2147359010", start_xp = 4200, kill_if_AI = false, start_skills = {"wh_main_skill_dwf_engineer_self_standardised_firing_drill", "wh_main_skill_dwf_engineer_self_requisition", "wh_main_skill_dwf_engineer_self_triangulation", "wh_main_skill_dwf_engineer_self_dead_eye"}}
} --: vector<{forename: string, surname: string, start_xp: number, kill_if_AI: boolean, start_skills: vector<string>}>

--# assume global find_belegar_character: function(CA_CHAR) --> integer
--# assume global belegar_give_start_experience: function(CA_CHAR, number)
--# assume global belegar_give_skills: function(CA_CHAR, vector<string>)
--# assume global belegar_kill_start_character: function(CA_CHAR, boolean, boolean)

function belegar_start_experience()	
	local faction = cm:get_faction("wh_main_dwf_karak_izor")
	
	if faction then
		cm:disable_event_feed_events(true, "wh_event_category_traits_ancillaries", "", "")
		cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
		
		local is_human = faction:is_human()
		local character_list = faction:character_list()
		
		for i = 0, character_list:num_items() - 1 do
			local current_char = character_list:item_at(i)
			local char_index = find_belegar_character(current_char)
			
			if char_index > 0 then
				belegar_give_start_experience(current_char, belegar_characters[char_index].start_xp)
				belegar_give_skills(current_char, belegar_characters[char_index].start_skills)
				belegar_kill_start_character(current_char, is_human, belegar_characters[char_index].kill_if_AI)
			end
		end
		
		cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_traits_ancillaries", "", "") end, 1)
		cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 1)
	end
end