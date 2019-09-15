local mcm --:MCM

local alastar_quests = {
    { "wh2_main_anc_armour_lions_pelt", 1}
} --:vector<{string, number}>

-- factions with legendary lords
local subcultures_factions = {
    ["wh2_main_sc_hef_high_elves"] = {"wh2_main_hef_eataine", "wh2_main_hef_order_of_loremasters", "wh2_main_hef_avelorn", "wh2_main_hef_nagarythe"},
    ["wh2_main_sc_lzd_lizardmen"] = {"wh2_main_lzd_hexoatl", "wh2_main_lzd_last_defenders", "wh2_dlc12_lzd_cult_of_sotek", "wh2_main_lzd_tlaqua", "wh2_main_lzd_itza"}, --, "wh2_dlc13_lzd_spirits_of_the_jungle"},
    ["wh2_main_sc_def_dark_elves"] = {"wh2_main_def_naggarond", "wh2_main_def_cult_of_pleasure", "wh2_main_def_har_ganeth", "wh2_dlc11_def_the_blessed_dread"},
    ["wh2_main_sc_skv_skaven"] = {"wh2_main_skv_clan_skyre", "wh2_main_skv_clan_mors", "wh2_main_skv_clan_pestilens", "wh2_dlc09_skv_clan_rictus"},
    ["wh2_dlc09_sc_tmb_tomb_kings"] = {"wh2_dlc09_tmb_khemri", "wh2_dlc09_tmb_lybaras", "wh2_dlc09_tmb_exiles_of_nehek"}, --, "wh2_dlc09_tmb_followers_of_nagash"
    --cst
    ["wh_main_sc_nor_norsca"] = {"wh_dlc08_nor_norsca", "wh_dlc08_nor_wintertooth"},
    ["wh_main_sc_emp_empire"] = {"wh_main_emp_empire", "wh_main_emp_middenland", "wh2_dlc13_emp_golden_order", "wh2_dlc13_emp_the_huntmarshals_expedition"},
    ["wh_main_sc_dwf_dwarfs"] = {"wh_main_dwf_dwarfs", "wh_main_dwf_karak_kadrin", "wh_main_dwf_karak_izor"},
    ["wh_main_sc_brt_bretonnia"] = {"wh_main_brt_bretonnia", "wh_main_brt_bordeleaux", "wh_main_brt_carcassonne"},
    ["wh_dlc05_sc_wef_wood_elves"] = {"wh_dlc05_wef_wood_elves", "wh_dlc05_wef_argwylon"},
    ["wh_main_sc_grn_greenskins"] = {"wh_main_grn_greenskins", "wh_main_grn_crooked_moon", "wh_main_grn_orcs_of_the_bloody_hand"},
    ["wh_main_sc_vmp_vampire_counts"] = {"wh_main_vmp_vampire_counts", "wh_main_vmp_schwartzhafen", "wh2_dlc11_vmp_the_barrow_legion", "wh_main_vmp_mousillon"}
} --: map<string, vector<string>>

local mixu1_subcultures_factions = {
    ["wh2_main_sc_hef_high_elves"] = {},
    ["wh2_main_sc_lzd_lizardmen"] = {},
    ["wh2_main_sc_def_dark_elves"] = {},
    ["wh2_main_sc_skv_skaven"] = {},
    ["wh2_dlc09_sc_tmb_tomb_kings"] = {},
    --cst
    ["wh_main_sc_nor_norsca"] = {},
    ["wh_main_sc_emp_empire"] = {"wh_main_emp_stirland", "wh_main_emp_hochland", "wh_main_emp_marienburg", "wh_main_emp_wissenland", "wh_main_emp_talabecland", "wh_main_emp_averland", "wh_main_emp_nordland", "wh_main_emp_ostland", "wh_main_emp_ostermark"},
    ["wh_main_sc_dwf_dwarfs"] = {"wh_main_dwf_karak_azul"},
    ["wh_main_sc_brt_bretonnia"] = {"wh_main_brt_bastonne", "wh_main_brt_parravon", "wh_main_brt_artois", "wh_main_brt_lyonesse"},
    ["wh_dlc05_sc_wef_wood_elves"] = {"wh_dlc05_wef_torgovann"},
    ["wh_main_sc_grn_greenskins"] = {},
    ["wh_main_sc_vmp_vampire_counts"] = {}
} --: map<string, vector<string>>

local mixu2_subcultures_factions = {
    ["wh2_main_sc_hef_high_elves"] = {"wh2_main_hef_saphery", "wh2_main_hef_caledor", "wh2_main_hef_chrace"},
    ["wh2_main_sc_lzd_lizardmen"] = {"wh2_main_lzd_xlanhuapec", "wh2_main_lzd_tlaxtlan", "wh2_main_lzd_tlaqua"},
    ["wh2_main_sc_def_dark_elves"] = {"wh2_main_def_scourge_of_khaine"},
    ["wh2_main_sc_skv_skaven"] = {},
    ["wh2_dlc09_sc_tmb_tomb_kings"] = {"wh2_dlc09_tmb_numas"},
    --cst
    ["wh_main_sc_nor_norsca"] = {},
    ["wh_main_sc_emp_empire"] = {},
    ["wh_main_sc_dwf_dwarfs"] = {},
    ["wh_main_sc_brt_bretonnia"] = {"wh2_main_brt_knights_of_origo"},
    ["wh_dlc05_sc_wef_wood_elves"] = {"wh_dlc05_wef_wydrioth"},
    ["wh_main_sc_grn_greenskins"] = {"wh_main_grn_red_fangs"},
    ["wh_main_sc_vmp_vampire_counts"] = {}
} --: map<string, vector<string>>

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
                local char = cm:get_character_by_cqi(cqi)
                if char:character_subtype(subtype) then
                    cm:set_character_immortality(cm:char_lookup_str(cqi), true)
                    cm:set_saved_value(subtype.."_spawned", faction) 
                end
                cm:kill_character(cqi, true, false)
                --cm:callback(function()
                    if char:is_wounded() then cm:stop_character_convalescing(cqi) end
                --end, 0.5)
            end
        )
    end
end

--v function(faction: string)
local function spawnMissingLords(faction)
    local ai_starting_generals = {
		{["id"] = "2140784160",	["forename"] = "names_name_2147358917",	["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "pro01_dwf_grombrindal"},			            -- Grombrindal
		{["id"] = "2140783606",	["forename"] = "names_name_2147345906",	["faction"] = "wh_main_grn_greenskins", ["subtype"] = "grn_azhag_the_slaughterer"},		        -- Azhag the Slaughterer
		{["id"] = "2140784146",	["forename"] = "names_name_2147358044",	["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "dlc04_vmp_helman_ghorst"},	        -- Helman Ghorst
        {["id"] = "2140784202",	["forename"] = "names_name_2147345124",	["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "pro02_vmp_isabella_von_carstein"}    -- Isabella von Carstein
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

--v function(faction: string, home_region: CA_REGION, regionList: CA_REGION_LIST, x: number, y: number, army: string)
local function reviveFaction(faction, home_region, regionList, x, y, army)
    local subculture = cm:get_faction(faction):subculture()
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

--v function(subcultures_factions_table: map<string, vector<string>>)
local function confed(subcultures_factions_table)
    local humanFactions = cm:get_human_factions()
    for i = 1, #humanFactions do
        spawnMissingLords(humanFactions[i])
        local humanFaction = cm:get_faction(humanFactions[i])
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
                if faction then
                    local factionCA = cm:get_faction(faction)
                    if factionCA and not factionCA:is_human() and cm:get_saved_value("mcm_tweaker_frostyConfed_player"..i.."|"..faction.."_value") ~= "disable" then
                        local regionList = factionCA:region_list()
                        local home_region 
                        if factionCA:has_home_region() then 
                            home_region = factionCA:home_region()
                        else
                            home_region = factionCA:military_force_list():item_at(0):general_character():region() 
                        end
                        local xPos, yPos
                        local army = ""
                        local char_cqi_table = {} --:vector<CA_CQI>
                        if cm:get_saved_value("mcm_tweaker_frostyConfed_theatre_value") ~= "enable" then
                            local mfList = factionCA:military_force_list()
                            for j = 0, mfList:num_items() - 1 do
                                local mf = mfList:item_at(j)	
                                if mf:has_general() and not mf:is_armed_citizenry() then
                                    local general = mf:general_character()
                                    xPos = general:logical_position_x()
                                    yPos = general:logical_position_y()
                                    local unitList = mf:unit_list()
                                    for k = 1, unitList:num_items() - 1 do
                                        local unit = unitList:item_at(k)
                                        if army ~= "" then army = army.."," end
                                        army = army..unit:unit_key()	
                                    end
                                end
                            end
                            local charList = factionCA:character_list()
                            for l = 0, charList:num_items() - 1 do
                                local char = charList:item_at(l)
                                local cqi = char:command_queue_index()
                                if not wh_faction_is_horde(factionCA) then
                                    cm:kill_character(cqi, true, false)
                                else
                                    table.insert(char_cqi_table, cqi)
                                end
                            end
                        end
                        if wh_faction_is_horde(factionCA) then
                            core:add_listener(
                                "frosty_horde_FactionJoinsConfederation",
                                "FactionJoinsConfederation",
                                function(context)
                                    return context:confederation():name() == humanFactions[i] and context:faction():name() == faction
                                end,
                                function(context)
                                    for _, char_cqi in ipairs(char_cqi_table) do
                                        cm:kill_character(char_cqi, true, false) 
                                    end        
                                end,
                                false
                            )
                        end
                        if subculture == "wh2_dlc09_sc_tmb_tomb_kings" then 
                            if not not mcm or (humanFactions[i] ~= "wh2_dlc09_tmb_followers_of_nagash" and faction ~= "wh2_dlc09_tmb_khemri" and faction ~= "wh2_dlc09_tmb_followers_of_nagash") then 
                                if vfs.exists("script/campaign/mod/legendary_confeds_tk.lua") then 
                                    local charList = factionCA:character_list()
                                    for n = 0, charList:num_items() - 1 do
                                        local char = charList:item_at(n)
                                        local cqi = char:command_queue_index()
                                        cm:kill_character(cqi, true, false)
                                        --cm:callback(function()
                                            if char:is_wounded() then cm:stop_character_convalescing(cqi) end
                                        --end, 0.5)
                                    end
                                    cm:force_confederation(humanFactions[i], faction) 
                                end
                            end
                        else
                            cm:force_confederation(humanFactions[i], faction)
                        end
                        if cm:get_saved_value("mcm_tweaker_frostyConfed_theatre_value") ~= "enable" and not faction == "wh2_dlc13_lzd_spirits_of_the_jungle" then
                            cm:callback(function()
                                reviveFaction(faction, home_region, regionList, xPos, yPos, army)
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
                            end, 1)
                        end
                    end
                end
            end
        end
        cm:callback(function()
            local charList =  humanFaction:character_list()
            for p = 0, charList:num_items() - 1 do
                local char = charList:item_at(p)
                local cqi = char:command_queue_index()
                if char:is_wounded() then cm:stop_character_convalescing(cqi) end
            end
        end, 1)
    end
    if cm:get_saved_value("mcm_tweaker_frostyConfed_deadlyAlliances_value") == "enable" then
        for subculture, factions in pairs(subcultures_factions_table) do
            if subculture ~= "wh2_dlc09_sc_tmb_tomb_kings" or (vfs.exists("script/campaign/mod/legendary_confeds_tk.lua") and subculture == "wh2_dlc09_sc_tmb_tomb_kings") then 
                if (not cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() ~= subculture) or
                    (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() ~= subculture and cm:get_faction(humanFactions[2]):subculture() ~= subculture) then
                    if factions[1] and cm:get_faction(factions[1]) then spawnMissingLords(factions[1]) end
                    for i = 1, #factions do
                        if factions[i] and subcultures_factions[subculture][1] ~= factions[i] then 
                            if subculture == "wh2_dlc09_sc_tmb_tomb_kings" then 
                                local factionCA = cm:get_faction(factions[i])
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
                            cm:force_confederation(subcultures_factions[subculture][1], factions[i])
                        end
                    end
                end
            end
        end
    end
end

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
                    if factionCA and factionCA:has_effect_bundle(bundles[i]) then cm:remove_effect_bundle(bundles[i], faction) end
                end
            end
        end
    end
end

--v function()
function legendary_confeds()
    local humanFactions = cm:get_human_factions()
    mcm = _G.mcm
	if not not mcm then
        local frostyConfed = mcm:register_mod("frostyConfed", "Legendary Confederations", "This is the Civ-style checkbox that lets you start the campaign with the legendary lords already rallied to your side.")
        local theatre = frostyConfed:add_tweaker("theatre", "Theatres of War", "The legendary lords are confederated through regular confederations. You gain control over their settlements, both near and far away. Consider them \"outposts\" to either keep or abandon.")
        theatre:add_option("disable", "Disable", "")
        theatre:add_option("enable", "Enable", "")
        local deadlyAlliances = frostyConfed:add_tweaker("deadlyAlliances", "Deadly Alliances", "All playable AI factions with legendary lords confederate and form large factions.")
        deadlyAlliances:add_option("disable", "Disable", "")
        deadlyAlliances:add_option("enable", "Enable", "")
        for i = 1, #humanFactions do
            local humanFaction = cm:get_faction(humanFactions[i])
            local subculture = humanFaction:subculture()
            if subculture ~= "wh2_dlc09_sc_tmb_tomb_kings" or (vfs.exists("script/campaign/mod/legendary_confeds_tk.lua") and subculture == "wh2_dlc09_sc_tmb_tomb_kings") then 
                if subcultures_factions[subculture]  then 
                    for _, faction in ipairs(subcultures_factions[subculture]) do
                        if faction and not cm:get_faction(faction):is_human() then 
                            local playerConfederations = frostyConfed:add_tweaker("player"..i.."|"..faction, "Player-"..i.." Confederation with "..effect.get_localised_string("factions_screen_name_"..faction), "")
                            if (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() == cm:get_faction(humanFactions[2]):subculture())
                            or (humanFactions[1] == "wh2_dlc09_tmb_followers_of_nagash") or (humanFactions[2] == "wh2_dlc09_tmb_followers_of_nagash")
                            or (faction == "wh2_dlc09_tmb_khemri") or faction == "wh2_dlc09_tmb_followers_of_nagash" then 
                                playerConfederations:add_option("disable", "Disable", "")
                                playerConfederations:add_option("enable", "Enable", "")
                            else
                                playerConfederations:add_option("enable", "Enable", "")
                                playerConfederations:add_option("disable", "Disable", "")
                            end
                        end
                    end
                end
                if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") and mixu1_subcultures_factions[subculture] then -- compatibility for mixu's legendary lords 1 (script path might change)
                    for _, faction in ipairs(mixu1_subcultures_factions[subculture]) do
                        if faction and not cm:get_faction(faction):is_human() then
                            local playerConfederations = frostyConfed:add_tweaker("player"..i.."|"..faction, "Player-"..i.." Confederation with "..effect.get_localised_string("factions_screen_name_"..faction), "")
                            playerConfederations:add_option("disable", "Disable", "")
                            playerConfederations:add_option("enable", "Enable", "")
                        end
                    end
                end
                if vfs.exists("script/campaign/mod/mixu_darkhand.lua") and mixu2_subcultures_factions[subculture] then -- compatibility for mixu's legendary lords 2 (script path might change)
                    for _, faction in ipairs(mixu2_subcultures_factions[subculture]) do
                        if faction and not cm:get_faction(faction):is_human() then 
                            local playerConfederations = frostyConfed:add_tweaker("player"..i.."|"..faction, "Player-"..i.." Confederation with "..effect.get_localised_string("factions_screen_name_"..faction), "")
                            playerConfederations:add_option("disable", "Disable", "")
                            playerConfederations:add_option("enable", "Enable", "")
                        end
                    end
                end
            end
        end
		mcm:add_post_process_callback(
            function()
                local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc09_tmb_tomb_kings_value")
                if not confed_option_tmb or confed_option_tmb == "yield" then
                    cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
                end
                if cm:is_new_game() then 
                    cm:disable_event_feed_events(true, "all", "", "")
                    confed(subcultures_factions)
                    if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") then confed(mixu1_subcultures_factions) end -- compatibility for mixu's legendary lords 1 (script path might change)
                    if vfs.exists("script/campaign/mod/mixu_darkhand.lua") then confed(mixu2_subcultures_factions) end -- compatibility for mixu's legendary lords 2 (script path might change)
                    cm:callback(function() remove_confed_penalties(subcultures_factions) end, 1)
                    cm:callback(function() cm:disable_event_feed_events(false, "all", "", "") end, 2)
                end
			end
        )
    else
        local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc09_tmb_tomb_kings_value")
		if not confed_option_tmb or confed_option_tmb == "yield" then
            cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
        end
        if cm:is_new_game() then
            if not cm:is_multiplayer() or (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() ~= cm:get_faction(humanFactions[2]):subculture()) then
                cm:disable_event_feed_events(true, "all", "", "")
                confed(subcultures_factions)
                if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") then confed(mixu1_subcultures_factions) end -- compatibility for mixu's legendary lords 1 (script path might change)
                if vfs.exists("script/campaign/mod/mixu_darkhand.lua") then confed(mixu2_subcultures_factions) end -- compatibility for mixu's legendary lords 2 (script path might change)
                cm:callback(function() remove_confed_penalties(subcultures_factions) end, 1)
                cm:callback(function() cm:disable_event_feed_events(false, "all", "", "") end, 2)
            end
        end
    end

    -- vandy confed options compatibility
    core:add_listener(
        "frosty_confed_expired",
        "ScriptEventConfederationExpired",
        function(context)
            local faction_name = context.string
            local faction = cm:get_faction(faction_name)
            return faction:is_human()
        end,
        function(context)
            local faction_name = context.string
            local faction = cm:get_faction(faction_name)
            local subculture = faction:subculture()
            local culture = faction:culture()
            local confed_option = cm:get_saved_value("mcm_tweaker_confed_tweaks_" .. culture .."_value")
            local option = {}
            if confed_option == "enabled" or confed_option == "player_only" then
                option.offer = true
                option.accept = true
                option.enable_payment = true
            elseif confed_option == "disabled" then
                option.offer = false
                option.accept = false
                option.enable_payment = false				
            elseif (confed_option == "yield" or confed_option == nil) and subculture == "wh2_dlc09_sc_tmb_tomb_kings" then
                option.offer = false
                option.accept = false
                option.enable_payment = false	
            elseif (confed_option == "yield" or confed_option == nil) and subculture == "wh_dlc05_sc_wef_wood_elves" then
                option.accept = false
                option.enable_payment = false	
                oak_region = cm:get_region("wh_main_yn_edri_eternos_the_oak_of_ages")
                if oak_region:building_exists("wh_dlc05_wef_oak_of_ages_3") then
                    option.offer = true
                else
                    option.offer = false
                end
            elseif (confed_option == "yield" or confed_option == nil) and subculture ~= "wh_dlc05_sc_wef_wood_elves" and subculture ~= "wh2_dlc09_sc_tmb_tomb_kings" then
                option.offer = true
                option.accept = true
                option.enable_payment = false
            end
            cm:callback(
                function(context)
                    cm:force_diplomacy("faction:" .. faction_name, "subculture:" .. subculture, "form confederation", option.offer, option.accept, option.enable_payment)
                end, 1, "changeDiplomacyOptions"
            )
        end,
        true
    )
end

-- vanilla function override (wh_dlc06_karak_eight_peaks.lua)
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