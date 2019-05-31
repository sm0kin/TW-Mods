local mcm --:MCM

local grombrindal_quests = {
    {"wh_pro01_dwf_grombrindal_amour_of_glimril_scales", 8},
    {"wh_pro01_dwf_grombrindal_rune_axe_of_grombrindal", 13},
    {"wh_pro01_dwf_grombrindal_rune_cloak_of_valaya", 18},
    {"wh_pro01_dwf_grombrindal_rune_helm_of_zhufbar", 23}
} --:vector<{string, number}>

local isabella_quests = {
    {"wh_pro02_anc_enchanted_item_blood_chalice_of_bathori", 9}
} --:vector<{string, number}>

local helman_ghorst_quests = {
    { "wh_dlc04_anc_arcane_item_the_liber_noctus", 8}
} --:vector<{string, number}>

local azhag_the_slaughterer_quests = {
    {"wh_main_anc_enchanted_item_the_crown_of_sorcery", 8},
    {"wh_main_anc_armour_azhags_ard_armour", 13},
    {"wh_main_anc_weapon_slaggas_slashas", 18}
} --:vector<{string, number}>

-- factions with legendary lords
local subcultures_factions = {
    ["wh2_main_sc_hef_high_elves"] = {"wh2_main_hef_eataine", "wh2_main_hef_order_of_loremasters", "wh2_main_hef_avelorn", "wh2_main_hef_nagarythe"},
    ["wh2_main_sc_lzd_lizardmen"] = {"wh2_main_lzd_hexoatl", "wh2_main_lzd_last_defenders", "wh2_dlc12_lzd_cult_of_sotek", "wh2_main_lzd_tlaqua"},
    ["wh2_main_sc_def_dark_elves"] = {"wh2_main_def_naggarond", "wh2_main_def_cult_of_pleasure", "wh2_main_def_har_ganeth", "wh2_dlc11_def_the_blessed_dread"},
    ["wh2_main_sc_skv_skaven"] = {"wh2_main_skv_clan_skyre", "wh2_main_skv_clan_mors", "wh2_main_skv_clan_pestilens", "wh2_dlc09_skv_clan_rictus"},
    ["wh2_dlc09_sc_tmb_tomb_kings"] = {"wh2_dlc09_tmb_khemri", "wh2_dlc09_tmb_lybaras", "wh2_dlc09_tmb_exiles_of_nehek", "wh2_dlc09_tmb_followers_of_nagash"},
    --cst
    ["wh_main_sc_nor_norsca"] = {"wh_dlc08_nor_norsca", "wh_dlc08_nor_wintertooth"},
    ["wh_main_sc_emp_empire"] = {"wh_main_emp_empire", "wh_main_emp_middenland"},
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
    ["wh2_main_sc_lzd_lizardmen"] = {"wh2_main_lzd_xlanhuapec", "wh2_main_lzd_itza", "wh2_main_lzd_tlaxtlan", "wh2_main_lzd_tlaqua", "wh2_main_lzd_konquata"},
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
                cm:force_add_ancillary(cm:char_lookup_str(context:character()), ancillary)
            end,
            false
        )
	end
end

--v function(faction: CA_FACTION, subtype: string) --> boolean
local function has_agent_subtype(faction, subtype)
    local charList = faction:character_list()
    local has_agent = false
    for i = 0, charList:num_items() - 1 do
        local char = charList:item_at(i)
        if char:character_subtype(subtype) then
            has_agent = true
            break
        end
    end
    return has_agent
end

--v function(faction: string, region: string, x: number, y: number, subtype: string, forename: string, surname: string)
function createNewLord(faction, region, x, y, subtype, forename, surname)
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
                cm:set_character_immortality(cm:char_lookup_str(cqi), true)
                cm:kill_character(cqi, true, false)
                cm:stop_character_convalescing(cqi)
        end
        )
end

--v function(faction: string)
local function spawnMissingLords(faction)
    local factionCA = cm:get_faction(faction)
    local x, y
    if factionCA:has_home_region() then x, y = cm:find_valid_spawn_location_for_character_from_settlement(faction, factionCA:home_region():name(), false, false, 9) end
    if not vfs.exists("script/export_helpers__llr_core.lua") and not vfs.exists("script/campaign/mod/viemzee_unlock_all_ll.lua") then -- compatibility for df's legendary lord respec (script path might change)
        if factionCA:subculture() == "wh_main_sc_dwf_dwarfs" and faction ~= "wh_main_dwf_dwarfs" and not has_agent_subtype(factionCA, "pro01_dwf_grombrindal") and not cm:get_saved_value("pro01_dwf_grombrindal_spawned") then
            --cm:spawn_character_to_pool(faction, "names_name_2147358917", "names_name_2147358935", "", "", 18, true, "general", "pro01_dwf_grombrindal", true, "") 
            createNewLord(faction, factionCA:home_region():name(), x, y, "pro01_dwf_grombrindal", "names_name_2147358917", "names_name_2147358935")
            ancillaryOnRankUp(grombrindal_quests, "pro01_dwf_grombrindal")
            cm:set_saved_value("pro01_dwf_grombrindal".."_spawned", faction) 
        elseif factionCA:subculture() == "wh_main_sc_grn_greenskins" and faction ~= "wh_main_grn_greenskins" and not has_agent_subtype(factionCA, "grn_azhag_the_slaughterer") and not cm:get_saved_value("grn_azhag_the_slaughterer_spawned") then
            --cm:spawn_character_to_pool(faction, "names_name_2147345906", "names_name_2147357356", "", "", 18, true, "general", "grn_azhag_the_slaughterer", true, "")
            createNewLord(faction, factionCA:home_region():name(), x, y, "grn_azhag_the_slaughterer", "names_name_2147345906", "names_name_2147357356")
            ancillaryOnRankUp(azhag_the_slaughterer_quests, "grn_azhag_the_slaughterer")    
            cm:set_saved_value("grn_azhag_the_slaughterer".."_spawned", faction) 
        elseif factionCA:subculture() == "wh_main_sc_vmp_vampire_counts" then
            if faction ~= "wh_main_vmp_vampire_counts" and not has_agent_subtype(factionCA, "dlc04_vmp_helman_ghorst") and not cm:get_saved_value("dlc04_vmp_helman_ghorst_spawned") then
                --cm:spawn_character_to_pool(faction, "names_name_2147358044", "names_name_2147345294", "", "", 18, true, "general", "dlc04_vmp_helman_ghorst", true, "")
                createNewLord(faction, factionCA:home_region():name(), x, y, "dlc04_vmp_helman_ghorst", "names_name_2147358044", "names_name_2147345294")
                ancillaryOnRankUp(helman_ghorst_quests, "dlc04_vmp_helman_ghorst")  
                cm:set_saved_value("dlc04_vmp_helman_ghorst".."_spawned", faction) 
            end --elseif won't work for some reason
            if faction ~= "wh_main_vmp_schwartzhafen" and not has_agent_subtype(factionCA, "pro02_vmp_isabella_von_carstein") and not cm:get_saved_value("pro02_vmp_isabella_von_carstein_spawned") then
                --cm:spawn_character_to_pool(faction, "names_name_2147345124", "names_name_2147343895", "", "", 18, true, "general", "pro02_vmp_isabella_von_carstein", true, "")
                createNewLord(faction, factionCA:home_region():name(), x, y, "pro02_vmp_isabella_von_carstein", "names_name_2147345124", "names_name_2147343895")
                ancillaryOnRankUp(isabella_quests, "pro02_vmp_isabella_von_carstein") 
                cm:set_saved_value("pro02_vmp_isabella_von_carstein".."_spawned", faction) 
            end
        elseif factionCA:subculture() == "wh2_main_sc_hef_high_elves" and faction ~= "wh2_main_hef_eataine" and not has_agent_subtype(factionCA, "wh2_main_hef_prince_alastar") and not cm:get_saved_value("wh2_main_hef_prince_alastar_spawned") then
            --cm:spawn_character_to_pool(faction, "names_name_2147360555", "names_name_2147360560", "", "", 18, true, "general", "wh2_main_hef_prince_alastar", true, "")
            createNewLord(faction, factionCA:home_region():name(), x, y, "wh2_main_hef_prince_alastar", "names_name_2147360555", "names_name_2147360560")
            cm:set_saved_value("wh2_main_hef_prince_alastar".."_spawned", faction) 
        end
    end
end

--v function(faction: string, regionList: CA_REGION_LIST, x: number, y: number, army: string)
local function reviveFaction(faction, regionList, x, y, army)
    local subculture = cm:get_faction(faction):subculture()
    local startRegion = regionList:item_at(0)
    cm:create_force(
        faction,
        army,
        startRegion:name(),
        x,
        y,
        true,
        function(cqi)
            cm:callback(function()
                for i = 0, regionList:num_items() - 1 do
                    local currentRegion = regionList:item_at(i)
                    cm:transfer_region_to_faction(currentRegion:name(), faction)
                end
                end, 1
            )
        end
    )
end

--v function(subcultures_factions_table: map<string, vector<string>>)
local function confed(subcultures_factions_table)
    local humanFactions = cm:get_human_factions()
    for i = 1, #humanFactions do
        spawnMissingLords(humanFactions[i])
        local humanFaction = cm:get_faction(humanFactions[i])
        local subculture = humanFaction:subculture()
        for _, faction in ipairs(subcultures_factions_table[subculture]) do
            local factionCA = cm:get_faction(faction)
            if factionCA and not factionCA:is_human() and cm:get_saved_value("mcm_tweaker_frostyConfed_player"..i.."|"..faction.."_value") ~= "disable" then
                local regionList = factionCA:region_list()
                local xPos, yPos
                local army = ""
                if cm:get_saved_value("mcm_tweaker_frostyConfed_theatre_value") ~= "enable" then
                    local mfList = factionCA:military_force_list()
                    for i = 0, mfList:num_items() - 1 do
                        local mf = mfList:item_at(i)	
                        if mf:has_general() and not mf:is_armed_citizenry() then
                            local general = mf:general_character()
                            xPos = general:logical_position_x()
                            yPos = general:logical_position_y()
                            local unitList = mf:unit_list()
                            for i = 1, unitList:num_items() - 1 do
                                local unit = unitList:item_at(i)
                                if army ~= "" then army = army.."," end
                                army = army..unit:unit_key()	
                            end
                        end
                    end
                    local charList = factionCA:character_list()
                    for i = 0, charList:num_items() - 1 do
                        local char = charList:item_at(i)
                        local cqi = char:command_queue_index()
                        cm:kill_character(cqi, true, false)
                    end
                end
                if subculture == "wh2_dlc09_sc_tmb_tomb_kings" then 
                    if not not mcm or (humanFactions[i] ~= "wh2_dlc09_tmb_followers_of_nagash" and faction ~= "wh2_dlc09_tmb_khemri" and faction ~= "wh2_dlc09_tmb_followers_of_nagash") then 
                        cm:force_confederation(humanFactions[i], faction)
                    end
                else
                    cm:force_confederation(humanFactions[i], faction)
                end
                if cm:get_saved_value("mcm_tweaker_frostyConfed_theatre_value") ~= "enable" then
                    cm:callback(function()
                        reviveFaction(faction, regionList, xPos, yPos, army)
                        local charList =  humanFaction:character_list()
                        for i = 0, charList:num_items() - 1 do
                            local char = charList:item_at(i)
                            local cqi = char:command_queue_index()
                            if char:is_wounded() then cm:stop_character_convalescing(cqi) end
                        end
                    end, 1)
                end
            end
        end
    end
    if cm:get_saved_value("mcm_tweaker_frostyConfed_deadlyAlliances_value") == "enable" then
        for subculture, factions in pairs(subcultures_factions_table) do
            if (not cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() ~= subculture) or
                (cm:is_multiplayer() and cm:get_faction(humanFactions[1]):subculture() ~= subculture and cm:get_faction(humanFactions[2]):subculture() ~= subculture) then
                if cm:get_faction(factions[1]) then spawnMissingLords(factions[1]) end
                for i = 1, #factions do
                    if subcultures_factions[subculture][1] ~= factions[i] then cm:force_confederation(subcultures_factions[subculture][1], factions[i]) end
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
        "wh_main_bundle_confederation_wef"
    } --:vector<string>
    for i = 1, #bundles do
        for _, factions in pairs(subcultures_factions_table) do
            for _, faction in ipairs(factions) do
                local factionCA = cm:get_faction(faction)
                if factionCA and factionCA:has_effect_bundle(bundles[i]) then cm:remove_effect_bundle(bundles[i], faction) end
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
            for _, faction in ipairs(subcultures_factions[subculture]) do
                if not cm:get_faction(faction):is_human() then 
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
            if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") then -- compatibility for mixu's legendary lords 1 (script path might change)
                for _, faction in ipairs(mixu1_subcultures_factions[subculture]) do
                    if not cm:get_faction(faction):is_human() then 
                        local playerConfederations = frostyConfed:add_tweaker("player"..i.."|"..faction, "Player-"..i.." Confederation with "..effect.get_localised_string("factions_screen_name_"..faction), "")
                        playerConfederations:add_option("disable", "Disable", "")
                        playerConfederations:add_option("enable", "Enable", "")
                    end
                end
            end
            if vfs.exists("script/campaign/mod/mixu_darkhand.lua") then -- compatibility for mixu's legendary lords 2 (script path might change)
                for _, faction in ipairs(mixu2_subcultures_factions[subculture]) do
                    if not cm:get_faction(faction):is_human() then 
                        local playerConfederations = frostyConfed:add_tweaker("player"..i.."|"..faction, "Player-"..i.." Confederation with "..effect.get_localised_string("factions_screen_name_"..faction), "")
                        playerConfederations:add_option("disable", "Disable", "")
                        playerConfederations:add_option("enable", "Enable", "")
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

    -- no clone wars
    core:add_listener(
        "doppelganger_CharacterCreated",
        "CharacterCreated",
        function(context)
            local charSubtype = context:character():character_subtype_key()
            local doppelganger = false
            if charSubtype == "pro01_dwf_grombrindal" or charSubtype == "grn_azhag_the_slaughterer" or charSubtype == "dlc04_vmp_helman_ghorst" or charSubtype == "pro02_vmp_isabella_von_carstein" or charSubtype == "wh2_main_hef_prince_alastar" then
                local originalFaction = context:character():faction()
                local factionList = originalFaction:factions_of_same_subculture()
                for i = 0, factionList:num_items() - 1 do
                    local currentFaction = factionList:item_at(i)
                    local charList = currentFaction:character_list()
                    for j = 0, charList:num_items() - 1 do
                        local currentChar = charList:item_at(j)
                        if currentChar:character_subtype_key() == charSubtype then
                            doppelganger = true
                        end
                    end
                end
            end
            return doppelganger
        end,
        function(context) 
            local char_cqi = context:character():command_queue_index()
            cm:set_character_immortality(cm:char_lookup_str(char_cqi), false)
            cm:kill_character(char_cqi, true, true)
        end,
        true
    )

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