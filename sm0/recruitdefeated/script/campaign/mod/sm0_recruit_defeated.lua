mcm = _G.mcm

local EVENT_PICS = {
    ["wh_main_emp_empire"] = 591,
    ["wh_main_vmp_vampire_counts"] = 594,
    ["wh_main_vmp_schwartzhafen"] = 770,
    ["wh2_dlc11_vmp_the_barrow_legion"] = 594,
    ["wh_main_dwf_dwarfs"] = 592,
    ["wh_main_dwf_karak_izor"] = 592,
    ["wh_main_dwf_karak_kadrin"] = 592,
    ["wh_main_grn_greenskins"] = 593,
    ["wh_main_grn_crooked_moon"] = 593,
    ["wh_main_grn_orcs_of_the_bloody_hand"] = 593,
    ["wh2_dlc09_tmb_khemri"] = 606,
    ["wh2_dlc09_tmb_exiles_of_nehek"] = 606,
    ["wh2_dlc09_tmb_lybaras"] = 606,
    ["wh2_dlc09_tmb_followers_of_nagash"] = 606,
    ["wh_main_brt_bretonnia"] = 751,
    ["wh_main_brt_bordeleaux"] = 752,
    ["wh_main_brt_carcassonne"] = 753,
    ["wh2_main_hef_avelorn"] = 780,
    ["wh2_main_hef_eataine"] = 771,
    ["wh2_main_hef_order_of_loremasters"] = 772,
    ["wh2_main_hef_nagarythe"] = 781,
    ["wh2_main_def_naggarond"] = 773,
    ["wh2_main_def_har_ganeth"] = 779,
    ["wh2_main_def_cult_of_pleasure"] = 774,
    ["wh2_main_lzd_hexoatl"] = 775,
	["wh2_main_lzd_last_defenders"] = 776,
	["wh2_dlc12_lzd_cult_of_sotek"] = 788,
	["wh2_main_lzd_tlaqua"] = 788,
    ["wh2_main_skv_clan_mors"] = 777,
    ["wh2_dlc09_skv_clan_rictus"] = 778,
	["wh2_main_skv_clan_pestilens"] = 778,
	["wh2_main_skv_clan_skyre"] = 787,
    ["wh_dlc05_wef_argwylon"] = 605,
    ["wh_dlc05_wef_wood_elves"] = 605,
    ["wh_dlc08_nor_norsca"] = 800,
    ["wh_dlc08_nor_wintertooth"] = 800,
    ["wh2_dlc11_def_the_blessed_dread"] = 782,
    ["wh2_dlc11_cst_vampire_coast"] = 786,
    ["wh2_dlc11_cst_noctilus"] = 785,
    ["wh2_dlc11_cst_pirates_of_sartosa"] = 783,
	["wh2_dlc11_cst_the_drowned"] = 784,
	
	--MIXU Part 1--
	["wh_main_brt_artois"] = 751,
    ["wh_main_brt_bastonne"] = 751,
    ["wh_main_brt_lyonesse"] = 751,
    ["wh_main_brt_parravon"] = 751,
    ["wh_main_dwf_karak_azul"] = 592,
    ["wh_main_emp_wissenland"] = 591,
    --["wh_main_ksl_kislev"] = 591,
    ["wh_dlc05_wef_torgovann"] = 591,
    ["wh_main_emp_averland"] = 591,
    ["wh_main_emp_hochland"] = 591,
    ["wh_main_emp_marienburg"] = 591,
    ["wh_main_emp_nordland"] = 591,
    ["wh_main_emp_ostermark"] = 591,
    ["wh_main_emp_ostland"] = 591,
    ["wh_main_emp_stirland"] = 591,
	["wh_main_emp_talabecland"] = 591,

	--MIXU Part 2--
    ["wh2_main_brt_knights_of_origo"] = 751,
    ["wh2_main_def_scourge_of_khaine"] = 773,
    ["wh_main_grn_red_fangs"] = 593,
    ["wh2_main_hef_saphery"] = 771,
    ["wh2_main_hef_chrace"] = 771,
    ["wh2_main_hef_caledor"] = 771,
    ["wh2_main_lzd_itza"] = 775,
    ["wh2_main_lzd_tlaxtlan"] = 775,
    ["wh_main_nor_skaeling"] = 800,
    ["wh2_dlc09_tmb_numas"] = 606,
    ["wh_dlc05_wef_wydrioth"] = 605
} --: map<string, number>

local LORDS_FACTIONS = {
    ["dlc03_emp_boris_todbringer"] = "wh_main_emp_middenland",
    ["dlc04_emp_volkmar"] = "wh_main_emp_empire",
    ["emp_balthasar_gelt"] = "wh_main_emp_empire",
    ["emp_karl_franz"] = "wh_main_emp_empire",
    ["dlc04_vmp_helman_ghorst"] = "wh_main_vmp_vampire_counts",
    ["dlc04_vmp_vlad_con_carstein"] = "wh_main_vmp_schwartzhafen",
    ["pro02_vmp_isabella_von_carstein"] = "wh_main_vmp_schwartzhafen",
    ["vmp_heinrich_kemmler"] = "wh2_dlc11_vmp_the_barrow_legion",
    ["vmp_mannfred_von_carstein"] = "wh_main_vmp_vampire_counts",
    ["wh_dlc05_vmp_red_duke"] = "wh_main_vmp_mousillon",
    ["dwf_thorgrim_grudgebearer"] = "wh_main_dwf_dwarfs",
    ["dwf_ungrim_ironfist"] = "wh_main_dwf_karak_kadrin",
    ["dlc06_dwf_belegar"] = "wh_main_dwf_karak_izor",
    ["pro01_dwf_grombrindal"] = "wh_main_dwf_dwarfs",
    ["dlc06_grn_skarsnik"] = "wh_main_grn_crooked_moon",
    ["grn_azhag_the_slaughterer"] = "wh_main_grn_greenskins",
    ["grn_grimgor_ironhide"] = "wh_main_grn_greenskins",
    ["dlc06_grn_wurrzag_da_great_prophet"] = "wh_main_grn_orcs_of_the_bloody_hand",
    ["wh2_dlc09_tmb_arkhan"] = "wh2_dlc09_tmb_followers_of_nagash",
    ["wh2_dlc09_tmb_khalida"] = "wh2_dlc09_tmb_lybaras",
    ["wh2_dlc09_tmb_khatep"] = "wh2_dlc09_tmb_exiles_of_nehek",
    ["wh2_dlc09_tmb_settra"] = "wh2_dlc09_tmb_khemri",
    ["brt_louen_leoncouer"] = "wh_main_brt_bretonnia",
    ["dlc07_brt_alberic"] = "wh_main_brt_bordeleaux",
    ["dlc07_brt_fay_enchantress"] = "wh_main_brt_carcassonne",
    ["wh2_main_hef_teclis"] = "wh2_main_hef_order_of_loremasters",
	["wh2_main_hef_tyrion"] = "wh2_main_hef_eataine",
	["wh2_main_hef_prince_alastar"] = "wh2_main_hef_eataine",
    ["wh2_dlc10_hef_alarielle"] = "wh2_main_hef_avelorn",
    ["wh2_dlc10_hef_alith_anar"] = "wh2_main_hef_nagarythe",
    ["wh2_dlc11_def_lokhir"] = "wh2_dlc11_def_the_blessed_dread",
    ["wh2_main_def_malekith"] = "wh2_main_def_naggarond",
    ["wh2_main_def_morathi"] = "wh2_main_def_cult_of_pleasure",
    ["wh2_main_lzd_lord_mazdamundi"] = "wh2_main_lzd_hexoatl",
	["wh2_main_lzd_kroq_gar"] = "wh2_main_lzd_last_defenders",
	["wh2_dlc12_lzd_tehenhauin"] = "wh2_dlc12_lzd_cult_of_sotek",
	["wh2_dlc12_lzd_tiktaqto"] = "wh2_main_lzd_tlaqua",
    ["wh2_main_skv_lord_skrolk"] = "wh2_main_skv_clan_pestilens",
    ["wh2_dlc09_skv_tretch_craventail"] = "wh2_dlc09_skv_clan_rictus",
	["wh2_main_skv_queek_headtaker"] = "wh2_main_skv_clan_mors",
	["wh2_dlc12_skv_ikit_claw"] = "wh2_main_skv_clan_skyre",
    ["dlc05_wef_durthu"] = "wh_dlc05_wef_argwylon",
    ["dlc05_wef_orion"] = "wh_dlc05_wef_wood_elves",
    ["wh_dlc08_nor_throgg"] = "wh_dlc08_nor_wintertooth",
    ["wh_dlc08_nor_wulfrik"] = "wh_dlc08_nor_norsca",
    ["wh2_dlc10_def_crone_hellebron"] = "wh2_main_def_har_ganeth",
    ["wh2_dlc11_cst_aranessa"] = "wh2_dlc11_cst_pirates_of_sartosa",
    ["wh2_dlc11_cst_cylostra"] = "wh2_dlc11_cst_the_drowned",
    ["wh2_dlc11_cst_harkon"] = "wh2_dlc11_cst_vampire_coast",
    ["wh2_dlc11_cst_noctilus"] = "wh2_dlc11_cst_noctilus",
    ["wh2_main_bst_ripper_horn"] = "bst_ghorros_warhoof"
} --: map<string, string>
    --MIXU Part 1--
local MIXU1_FACTIONS = {
    ["brt_chilfroy"] = "wh_main_brt_artois",
    ["brt_bohemond"] = "wh_main_brt_bastonne",
    ["brt_adalhard"] = "wh_main_brt_lyonesse",
    ["brt_cassyon"] = "wh_main_brt_parravon",
    ["dwf_kazador_dragonslayer"] = "wh_main_dwf_karak_azul",
    ["dwf_thorek_ironbrow"] = "wh_main_dwf_karak_azul",
    ["mixu_elspeth_von_draken"] = "wh_main_emp_wissenland",
    ["ksl_katarin_the_ice_queen"] = "wh_main_ksl_kislev",
    ["wef_daith"] = "wh_dlc05_wef_torgovann",
    ["emp_marius_leitdorf"] = "wh_main_emp_averland",
    ["emp_aldebrand_ludenhof"] = "wh_main_emp_hochland",
    ["emp_edward_van_der_kraal"] = "wh_main_emp_marienburg",
    ["emp_theoderic_gausser"] = "wh_main_emp_nordland",
    ["emp_wolfram_hertwig"] = "wh_main_emp_ostermark",
    ["emp_valmir_von_raukov"] = "wh_main_emp_ostland",
    ["emp_alberich_haupt_anderssen"] = "wh_main_emp_stirland",
	["emp_helmut_feuerbach"] = "wh_main_emp_talabecland",
	--["emp_markus_wulfhart"] = "wh_main_emp_middenland",
	--["emp_alberich_von_korden"] = "",
    ["wef_drycha"] = "wh_dlc05_wef_wydrioth"
} --: map<string, string>
    --MIXU Part 2--
local MIXU2_FACTIONS = {
    ["brt_john_tyreweld"] = "wh2_main_brt_knights_of_origo",
    --["chs_egrimm_van_horstmann"] = "wh_main_chs_chaos_separatists",
    ["def_tullaris_dreadbringer"] = "wh2_main_def_scourge_of_khaine",
    --["dwf_grimm_burloksson"] = "wh_main_dwf_zhufbar",
    ["grn_gorfang_rotgut"] = "wh_main_grn_red_fangs",
    ["hef_belannaer"] = "wh2_main_hef_saphery",
    --["hef_caradryan"] = "wh2_main_hef_eataine",
    ["hef_korhil"] = "wh2_main_hef_chrace",
    ["hef_prince_imrik"] = "wh2_main_hef_caledor",
    ["lzd_gor_rok"] = "wh2_main_lzd_itza",
    --["lzd_lord_huinitenuchli"] = "wh2_main_lzd_xlanhuapec",
    --["lzd_oxyotl"] = "wh2_main_lzd_tlaqua",
    ["lzd_tetto_eko"] = "wh2_main_lzd_tlaxtlan",
    ["nor_egil_styrbjorn"] = "wh_main_nor_skaeling",
    ["tmb_tutankhanut"] = "wh2_dlc09_tmb_numas",
	["wef_naieth_the_prophetess"] = "wh_dlc05_wef_wydrioth"
} --: map<string, string>

local alastar_quests = {
    { "wh2_main_anc_armour_lions_pelt", 1}
} --:vector<{string, number}>

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

--v function(subtype: string, confederator: string, confederated: string)
local function spamLords(subtype, confederator, confederated)
    local factionCA = cm:get_faction(confederator)
    local startRegion = factionCA:region_list():item_at(0)
    local x, y
    for i = 1, 20 do
        if startRegion then x, y = cm:find_valid_spawn_location_for_character_from_settlement(confederator, startRegion:name(), false, false, 9) end
        cm:create_force(
            confederated,
            "wh_main_dwf_inf_hammerers",
            startRegion:name(),
            x,
            y,
            false,
            function(cqi)
                local char = cm:get_character_by_cqi(cqi)
                if char:character_subtype(subtype) then
                    cm:set_character_immortality(cm:char_lookup_str(cqi), true)
                    cm:set_saved_value(subtype.."_spawned", confederated) 
                end
                cm:kill_character(cqi, true, false)
                --cm:callback(function()
                    if char:is_wounded() then cm:stop_character_convalescing(cqi) end
                --end, 0.5)
            end
        )
    end
end

--v function(confederator: string, confederated: string)
local function spawnMissingLords(confederator, confederated)
    local ai_starting_generals = {
		{["id"] = "2140784160",	["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "pro01_dwf_grombrindal"},			           -- Grombrindal
		{["id"] = "2140783606",	["faction"] = "wh_main_grn_greenskins", ["subtype"] = "grn_azhag_the_slaughterer"},		       -- Azhag the Slaughterer
		{["id"] = "2140784146",	["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "dlc04_vmp_helman_ghorst"},	       -- Helman Ghorst
        {["id"] = "2140784202",	["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "pro02_vmp_isabella_von_carstein"},   -- Isabella von Carstein
        {["id"] = "2140783648",	["faction"] = "wh_main_emp_empire", ["subtype"] = "emp_balthasar_gelt"},                       -- Balthasar Gelt
        {["id"] = "2140784136",	["faction"] = "wh_main_emp_empire", ["subtype"] = "dlc04_emp_volkmar"}                         -- Volkmar the Grim
    } --:vector<map<string, string>> 
    local factionCA = cm:get_faction(confederated)
	for i = 1, #ai_starting_generals do
        if confederated == ai_starting_generals[i].faction then
            if factionCA and not cm:get_saved_value(ai_starting_generals[i].subtype.."_spawned") then
                local charList = factionCA:character_list()
                local charFound = false
                for j = 0, charList:num_items() - 1 do
                    local currentChar = charList:item_at(j)
                    if currentChar:character_subtype_key() == ai_starting_generals[i].subtype then
                        charFound = true
                    end
                end
                if not charFound then
                    cm:unlock_starting_general_recruitment(ai_starting_generals[i].id, ai_starting_generals[i].faction)
                    spamLords(ai_starting_generals[i].subtype, confederator, ai_starting_generals[i].faction)
                end
            end
        end
    end
    local humanFactions = cm:get_human_factions()
    if confederated == "wh2_main_hef_eataine" and humanFactions[1] ~= "wh2_main_hef_eataine" and humanFactions[2] ~= "wh2_main_hef_eataine" then
        local charList = factionCA:character_list()
        local charFound = false
        for k = 0, charList:num_items() - 1 do
            local currentChar = charList:item_at(k)
            if currentChar:character_subtype_key() == "wh2_main_hef_prince_alastar" then
                charFound = true
            end
        end      
        if not charFound then           
            cm:spawn_character_to_pool(confederator, "names_name_2147360555", "names_name_2147360560", "", "", 18, true, "general", "wh2_main_hef_prince_alastar", true, "")
            cm:set_saved_value("v_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked", true)
            ancillaryOnRankUp(alastar_quests, "wh2_main_hef_prince_alastar")
            if cm:model():campaign_name("main_warhammer") then
                cm:lock_starting_general_recruitment("1065845653", "wh2_main_hef_eataine")
            else
                cm:lock_starting_general_recruitment("2140785181", "wh2_main_hef_eataine")
            end
        end
    end
end

--v function(faction: CA_FACTION) --> string
local function confed_penalty(faction)
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
    local has_confed_bundle = ""
    for i = 1, #bundles do
        if faction and faction:has_effect_bundle(bundles[i]) then has_confed_bundle = bundles[i] end
    end
    return has_confed_bundle
end

--v function(confederator: string, confederated: string, lords_factions: map<string, string>)
local function lordEvent(confederator, confederated, lords_factions)
    for subtype, faction in pairs(lords_factions) do
        if faction == confederated then
            cm:show_message_event(
                confederator,
                "event_feed_strings_text_title_event_legendary_lord_available",
                "event_feed_strings_text_title_event_" .. subtype .. "_LL_unlocked",
                "event_feed_strings_text_description_event_" .. subtype .. "_LL_unlocked",
                true,
                EVENT_PICS[confederator]
            )
        end
    end    
end

--v function(faction_name: string)
local function applyDiplomacy(faction_name)
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
    elseif (confed_option == "yield" or confed_option == nil) and (subculture == "wh2_dlc09_sc_tmb_tomb_kings" or subculture == "wh2_dlc11_sc_cst_vampire_coast") then
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
    elseif (confed_option == "yield" or confed_option == nil) and subculture ~= "wh_dlc05_sc_wef_wood_elves" and subculture ~= "wh2_dlc09_sc_tmb_tomb_kings" and subculture ~= "wh2_dlc11_sc_cst_vampire_coast" then
        option.offer = true
        option.accept = true
        option.enable_payment = false
    end
    cm:callback(
        function(context)
            cm:force_diplomacy("faction:" .. faction_name, "subculture:" .. subculture, "form confederation", option.offer, option.accept, option.enable_payment)
        end, 1, "changeDiplomacyOptions"
    )
end

--v function(confederator: CA_FACTION, confederated: CA_FACTION)
local function confedRevived(confederator, confederated)
    local startRegion = confederator:region_list():item_at(0)
    local x, y = cm:find_valid_spawn_location_for_character_from_settlement(confederator:name(), startRegion:name(), false, false, 9)
    cm:create_force(
        confederated:name(),
        "wh_main_dwf_inf_hammerers",
        startRegion:name(),
        x,
        y,
        true,
        function(cqi)
            local charList = confederated:character_list()
            for i = 0, charList:num_items() - 1 do 
                local char = charList:item_at(i)
                local command_queue_index = char:command_queue_index()
                if not char:has_military_force() and (cm:char_is_general(char) or cm:char_is_agent(char)) then cm:kill_character(command_queue_index, true, false) end
                --if char:is_wounded() then cm:stop_character_convalescing(command_queue_index) end
            end
            spawnMissingLords(confederator:name(), confederated:name())
            cm:force_confederation(confederator:name(), confederated:name())
            cm:callback(function() 
                if confed_penalty(confederator) ~= "" then cm:remove_effect_bundle(confed_penalty(confederator), confederator:name()) end 
            end, 0.5)
            if confederator:is_human() then 
                lordEvent(confederator:name(), confederated:name(), LORDS_FACTIONS)
                if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") then lordEvent(confederator:name(), confederated:name(), MIXU1_FACTIONS) end
                if vfs.exists("script/campaign/mod/mixu_darkhand.lua") then lordEvent(confederator:name(), confederated:name(), MIXU2_FACTIONS) end
            end
            cm:callback(function() 
                cm:kill_character(cqi, true, false)
            end, 0.5)
            applyDiplomacy(confederator:name())
        end
    )
end

--v function()
local function init()
    local human_factions = cm:get_human_factions()
    local factionP1 = cm:get_faction(human_factions[1])
    local factionP2
    if cm:is_multiplayer() then
        factionP2 = cm:get_faction(human_factions[2])
    end
    if not not mcm then
        mcm:add_post_process_callback(
            function()
                local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc09_tmb_tomb_kings_value")
                if not confed_option_tmb or confed_option_tmb == "yield" then
                    cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
                end
                local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc11_cst_vampire_coast_value")
                if not confed_option_tmb or confed_option_tmb == "yield" then
                    cm:force_diplomacy("subculture:wh2_dlc11_sc_cst_vampire_coast", "subculture:wh2_dlc11_sc_cst_vampire_coast", "form confederation", false, false, false)
                end
            end
        )
    else
        local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc09_tmb_tomb_kings_value")
        if not confed_option_tmb or confed_option_tmb == "yield" then
            cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
        end
        local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc11_cst_vampire_coast_value")
        if not confed_option_tmb or confed_option_tmb == "yield" then
            cm:force_diplomacy("subculture:wh2_dlc11_sc_cst_vampire_coast", "subculture:wh2_dlc11_sc_cst_vampire_coast", "form confederation", false, false, false)
        end
    end
    core:add_listener(
        "refugee_FactionTurnStart",
        "ScriptEventPlayerFactionTurnStart",
        function(context)
            return cm:model():turn_number() >= 2
        end,
        function(context)
            cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_negotiated", "")
            cm:disable_event_feed_events(true, "", "", "character_dies_in_action")
            local factionList = cm:model():world():faction_list()
            for i = 0, factionList:num_items() - 1 do
                local currentFaction = factionList:item_at(i)
                if currentFaction:is_dead() and not cm:get_saved_value("took_refuge_"..currentFaction:name()) then -- confederated?
                        -- faction exceptions
                    if currentFaction:subculture() ~= "wh_main_sc_chs_chaos" and not currentFaction:name():find("_waaagh") and not currentFaction:name():find("_brayherd") 
                    and not currentFaction:name():find("_qb") and not currentFaction:name():find("_separatists") and not currentFaction:name():find("_dil") 
                    and not currentFaction:name():find("_blood_voyage") and not currentFaction:name():find("_encounters") then --and not currentFaction:subculture() == "wh_main_sc_nor_norsca"
                        if currentFaction:subculture() == factionP1:subculture() and not factionP1:is_dead() then
                            if not cm:get_saved_value("factionP1") and confed_penalty(factionP1) == "" then
                                if currentFaction:name() == "wh_main_emp_empire" then cm:set_saved_value("refugee_confed", true) end
                                confedRevived(factionP1, currentFaction)
                                if cm:is_multiplayer() and factionP1:subculture() == factionP2:subculture() then
                                    cm:set_saved_value("factionP1", true)
                                    cm:set_saved_value("factionP2", false)
                                end
                            end
                        elseif cm:is_multiplayer() and currentFaction:subculture() == factionP2:subculture() and not factionP2:is_dead() then
                            if not cm:get_saved_value("factionP2") and confed_penalty(factionP2) == "" then
                                if currentFaction:name() == "wh_main_emp_empire" then cm:set_saved_value("refugee_confed", true) end
                                confedRevived(factionP2, currentFaction)
                                if cm:is_multiplayer() and factionP1:subculture() == factionP2:subculture() then
                                    cm:set_saved_value("factionP2", true)
                                    cm:set_saved_value("factionP1", false)                                
                                end
                            end
                        else -- ai
                            local subFactionList = currentFaction:factions_of_same_subculture()
                            for j = 0, subFactionList:num_items() - 1 do
                                local currentSubFaction = subFactionList:item_at(j)
                                if not currentSubFaction:is_dead() then -- confederated?
                                    confedRevived(currentSubFaction, currentFaction)
                                    break
                                end
                            end
                        end
                    end
                end
            end
            cm:callback(function() 
                cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_negotiated", "")
                cm:disable_event_feed_events(false, "", "", "character_dies_in_action")                
            end, 2)
        end,
        true
    )

    core:add_listener(
        "refugee_FactionTurnStart",
        "FactionJoinsConfederation",
        true,
        function(context)
            cm:set_saved_value("took_refuge_"..context:faction():name(), context:confederation():name())
            if context:confederation():subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
                local characterList = context:confederation():character_list()
                for i = 0, characterList:num_items() - 1 do
                    local currentChar = characterList:item_at(i)			
                    if cm:char_is_general(currentChar) then
                        cm:set_character_immortality(cm:char_lookup_str(currentChar:command_queue_index()), true) 
                    end
                end
            end
            if cm:get_saved_value("refugee_confed") then cm:set_saved_value("refugee_confed", false) end
        end,
        true
    )
    
    core:add_listener(
        "refugee_ScriptEventConfederationExpired",
        "ScriptEventConfederationExpired",
        function(context)
            local faction_name = context.string
            local faction = cm:get_faction(faction_name)
            return faction:is_human()
        end,
        function(context)
            local faction_name = context.string
            applyDiplomacy(faction_name)
        end,
        true
    )
    --re-enable karl franz lock
    core:remove_listener("2140783388" .. "_listener")
    core:add_listener(
        "2140783388" .. "_listener",
        "FactionJoinsConfederation",
        function(context)
            return context:confederation():name() == "wh_main_emp_empire"
        end,
        function()
            if char_with_forename_has_no_military_force("names_name_2147343849") and not cm:get_saved_value("refugee_confed") then                            
                cm:unlock_starting_general_recruitment("2140783388", "wh_main_emp_empire")
                cm:set_saved_value("2140783388" .. "_unlocked", true)
                core:remove_listener("2140783388" .. "_listener")
            end
        end,
        false
    )
end

function sm0_recruit_defeated()
    -- old version compatibility
    if not not mcm and cm:is_new_game() then
        local recruit_defeated = mcm:register_mod("recruit_defeated", "Recruit Defeated Legendary Lords", "")
        local version = recruit_defeated:add_tweaker("version", "Mod Version", "Choose your prefered mod version.")
        version:add_option("sm0kin", "sm0kin", "")
        version:add_option("scipion", "Scipion", "")
        mcm:add_post_process_callback(
            function()
                local version = cm:get_saved_value("mcm_tweaker_recruit_defeated_version_value")
                if version == "sm0kin" then
                    cm:set_saved_value("sm0_recruit_defeated", true)
                    init()
                else
                    cm:set_saved_value("sm0_recruit_defeated", false)
                end
            end
        )
    else
        local oldscript = false
        if not cm:is_new_game() and not cm:set_saved_value("sm0_recruit_defeated", true) then
            for subtype, faction in pairs(LORDS_FACTIONS) do 
                if subtype ~= "wh2_main_hef_prince_alastar" and cm:get_saved_value("v_" .. subtype .. "_LL_unlocked") then oldscript = true end
            end
        end
        if cm:is_new_game() or not oldscript then
            cm:set_saved_value("sm0_recruit_defeated", true)
            init()
        end
    end
end