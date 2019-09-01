local legacy_option = false

--v function()
local function RDLOG_reset()
	if not __write_output_to_logfile then
		return
	end
	local log_time_stamp = os.date("%d, %m %Y %X")
	--# assume log_time_stamp: string
	local pop_log = io.open("rd_log.txt","w+")
	pop_log :write("NEW LOG ["..log_time_stamp.."] \n")
	pop_log :flush()
	pop_log :close()
end

--v function(text: string | number | boolean | CA_CQI)
local function RDLOG(text)
	if not __write_output_to_logfile then
		return
	end
	local log_text = tostring(text)
	local log_time_stamp = os.date("%d, %m %Y %X")
	local pop_log = io.open("rd_log.txt","a")
	--# assume log_time_stamp: string
	pop_log :write("RD:  [".. log_time_stamp .. "]:  [Turn: ".. tostring(cm:turn_number()) .. "]:  "..log_text .. "  \n")
	pop_log :flush()
	pop_log :close()
end

mcm = _G.mcm

local faction_event_picture = {
    ["wh_main_emp_empire"] = 591,
    ["wh_main_emp_middenland"] = 591,
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
    ["wh2_main_hef_nagarythe"] = 771,
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
    -- ["Spirit of the Jungle"] = 775,
    -- ["Wulfhart’s Hunters"] = 591,
	
	--MIXU Part 1--
	["wh_main_brt_artois"] = 751,
    ["wh_main_brt_bastonne"] = 751,
    ["wh_main_brt_lyonesse"] = 751,
    ["wh_main_brt_parravon"] = 751,
    ["wh_main_dwf_karak_azul"] = 592,
    ["wh_main_emp_wissenland"] = 591,
    ["wh_main_ksl_kislev"] = 591,
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

--backup pictures
local subculture_event_picture = {
    ["wh_dlc03_sc_bst_beastmen"] = 596,
    ["wh_dlc05_sc_wef_wood_elves"] = 605,
    ["wh_main_sc_brt_bretonnia"] = 751,
    --["wh_main_sc_chs_chaos"] = 0,
    ["wh_main_sc_dwf_dwarfs"] = 592,
    ["wh_main_sc_emp_empire"] = 591,
    ["wh_main_sc_grn_greenskins"] = 593,
    ["wh_main_sc_grn_savage_orcs"] = 593,
    ["wh_main_sc_ksl_kislev"] = 591,
    ["wh_main_sc_nor_norsca"] = 800,
    ["wh_main_sc_teb_teb"] = 591,
    ["wh_main_sc_vmp_vampire_counts"] = 594,
    ["wh2_dlc09_sc_tmb_tomb_kings"] = 606,
    ["wh2_dlc11_sc_cst_vampire_coast"] = 785,
    ["wh2_main_sc_def_dark_elves"] = 773,
    ["wh2_main_sc_hef_high_elves"] = 771,
    ["wh2_main_sc_lzd_lizardmen"] = 775,
    ["wh2_main_sc_skv_skaven"] = 778
} --: map<string, number>


local subtype_faction = {
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
    -- ["Markus Wulfhart"] = "Wulfhart’s Hunters",
    -- ["Jorek Grimm"] = "Wulfhart’s Hunters",
    -- ["Rodrik L'Anguille"] = "Wulfhart’s Hunters",
    -- ["Hertwig Van Hal"] = "Wulfhart’s Hunters",
    -- ["Kalara of Wydrioth"] = "Wulfhart’s Hunters",
    -- ["Nakai the Wanderer"] = "Spirit of the Jungle",
    -- ["Gor-Rok"] = "Spirit of the Jungle",
    ["dlc03_bst_khazrak"] = "wh_dlc03_bst_beastmen",
    ["dlc03_bst_malagor"] = "wh_dlc03_bst_beastmen",
    ["dlc05_bst_morghur"] = "wh_dlc03_bst_beastmen"
} --: map<string, string>
    --MIXU Part 1--
local mixu1_subtype_faction = {
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
	--["emp_markus_wulfhart"] = "wh_main_emp_middenland", --dlc
    --["emp_alberich_von_korden"] = "",
    ["emp_luthor_huss"] = "wh_main_emp_empire",
    ["emp_theodore_bruckner"] = "wh_main_emp_wissenland",
    ["emp_vorn_thugenheim"] = "wh_main_emp_middenland",
    ["bst_taurox"] = "wh2_main_bst_manblight",
    ["wef_drycha"] = "wh_dlc05_wef_wydrioth"
} --: map<string, string>
    --MIXU Part 2--
local mixu2_subtype_faction = {
    ["brt_john_tyreweld"] = "wh2_main_brt_knights_of_origo",
    --["chs_egrimm_van_horstmann"] = "", --wh_main_chs_chaos_separatists
    ["def_tullaris_dreadbringer"] = "wh2_main_def_scourge_of_khaine",
    --["dwf_grimm_burloksson"] = "wh_main_dwf_zhufbar",
    ["grn_gorfang_rotgut"] = "wh_main_grn_red_fangs",
    ["hef_belannaer"] = "wh2_main_hef_saphery",
    --["hef_caradryan"] = "wh2_main_hef_eataine",
    ["hef_korhil"] = "wh2_main_hef_chrace",
    ["hef_prince_imrik"] = "wh2_main_hef_caledor",
    ["lzd_gor_rok"] = "wh2_main_lzd_itza", --dlc
    ["lzd_lord_huinitenuchli"] = "wh2_main_lzd_xlanhuapec",
    --["lzd_oxyotl"] = "wh2_main_lzd_tlaqua",
    ["lzd_tetto_eko"] = "wh2_main_lzd_tlaxtlan",
    ["nor_egil_styrbjorn"] = "wh_main_nor_skaeling",
    ["tmb_tutankhanut"] = "wh2_dlc09_tmb_numas",
    ["wef_naieth_the_prophetess"] = "wh_dlc05_wef_wydrioth",
    ["def_kouran_darkhand"] = "wh2_main_def_naggarond",
    ["lzd_chakax"] = "", -- "wh2_main_lzd_hexoatl" -- "wh2_main_lzd_xlanhuapec"
    ["brt_donna_don_domingio"] = "wh2_main_brt_knights_of_origo",
    ["tmb_ramhotep"] = "wh2_dlc09_tmb_numas",
    ["bst_ghorros_warhoof"] = "wh2_main_bst_ripper_horn"
} --: map<string, string>
    --XOUDAD High Elves Expanded--
local xoudad_subtype_faction = {
    ["wh2_main_hef_eltharion"] = "wh2_main_hef_yvresse"
} --: map<string, string>
    --CATAPH TEB--
local teb_subtype_faction = {
    ["teb_borgio_the_besiege"] = "wh_main_teb_tilea",
    ["teb_tilea"] = "wh_main_teb_tilea",
    ["teb_lucrezzia_belladonna"] = "wh_main_teb_tobaro",
    ["teb_gashnag"] = "wh_main_teb_border_princes",
    ["teb_border_princes"] = "wh_main_teb_border_princes",
    ["teb_estalia"] = "wh_main_teb_estalia",
    ["teb_new_world_colonies"] = "wh2_main_emp_new_world_colonies",
    ["teb_colombo"] = "wh2_main_emp_new_world_colonies"
} --: map<string, string>
    --CATAPH Kraka Drak--
local kraka_subtype_faction = {
    ["dwf_kraka_drak"] = "wh_main_dwf_kraka_drak"
} --: map<string, string>
    --Project Resurrection - Parte Legendary Lords--
local parte_subtype_faction = {
    ["def_rakarth"] = "wh2_main_def_karond_kar",
    ["skv_skweel_gnawtooth"] = "wh2_main_skv_clan_moulder",
    ["def_hag_queen_malida"] = "wh2_main_def_blood_hall_coven",
    ["hef_aislinn"] = "wh2_main_hef_cothique",
    ["dwf_byrrnoth_grundadrakk"] = "wh_main_dwf_barak_varr",
    ["dwf_rorek_granitehand"] = "wh_main_dwf_karak_ziflin",
    ["dwf_alrik_ranulfsson"] = "wh_main_dwf_karak_hirn",
    ["grn_gorbad_ironclaw"] = "wh_main_grn_teef_snatchaz"
} --: map<string, string>
    --We'z Speshul--
local speshul_subtype_faction = {
    ["spcha_grn_borgut_facebeater"] = "wh_main_grn_greenskins",
    ["spcha_grn_grokka_goreaxe"] = "wh_main_grn_orcs_of_the_bloody_hand",
    ["spcha_grn_tinitt_foureyes"] = "", -- wh_main_grn_black_venom -- wh2_main_grn_arachnos
    ["spcha_grn_grak_beastbasha"] = "wh2_main_grn_blue_vipers",
    ["spcha_grn_duffskul"] = "wh_main_grn_crooked_moon",
    ["spcha_grn_snagla_grobspit"] = "" -- wh_main_grn_black_venom -- wh2_main_grn_arachnos
} --: map<string, string>
    --Whysofurious' Additional Lords & Heroes--
local wsf_subtype_faction = {
    ["genevieve"] = "wh_main_emp_empire",
    ["helsnicht"] = "wh_main_vmp_vampire_counts",
    ["konrad"] = "wh_main_vmp_schwartzhafen", 
    ["mallobaude"] = "wh_main_vmp_mousillon",
    --["sycamo"] = "", 
    ["zacharias"] = "wh2_main_vmp_necrarch_brotherhood"
} --: map<string, string>
    --Ordo Draconis - Templehof Expanded--
local ordo_subtype_faction = {
    ["abhorash"] = "wh_main_vmp_rival_sylvanian_vamps",
    ["vmp_walach_harkon_hero"] = "wh_main_vmp_rival_sylvanian_vamps",
    ["tib_kael"] = "wh_main_vmp_rival_sylvanian_vamps"
} --: map<string, string>
    --WsF' Vampire Bloodlines: The Strigoi--
local strigoi_subtype_faction = {
    ["ushoran"] = "wh2_main_vmp_strygos_empire",
    ["vorag"] = "wh2_main_vmp_strygos_empire",
    ["str_high_priest"] = "wh2_main_vmp_strygos_empire", 
    ["nanosh"] = "wh2_main_vmp_strygos_empire"
} --: map<string, string>
    --OvN Second Start--
local second_start_subtype_faction = {
    ["sr_grim"] = "wh2_main_hef_yvresse"
} --: map<string, string>
    --OvN Lost Factions - Beta--
local lost_factions_subtype_faction = {
    --["ovn_hlf_ll"] = "",
    --["ovn_araby_ll"] = "",
    --["Sultan_Jaffar"] = "", 
    --["morgan_bernhardt"] = ""
} --: map<string, string>


local alastar_quests = {
    { "wh2_main_anc_armour_lions_pelt", 1}
} --:vector<{string, number}>

local locked_ai_generals = {
    {["id"] = "2140784160",	["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "pro01_dwf_grombrindal"},			             -- Grombrindal
    {["id"] = "2140783606",	["faction"] = "wh_main_grn_greenskins", ["subtype"] = "grn_azhag_the_slaughterer"},		         -- Azhag the Slaughterer
    {["id"] = "2140784146",	["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "dlc04_vmp_helman_ghorst"},	         -- Helman Ghorst
    {["id"] = "2140784202",	["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "pro02_vmp_isabella_von_carstein"},     -- Isabella von Carstein
    {["id"] = "2140783648",	["faction"] = "wh_main_emp_empire", ["subtype"] = "emp_balthasar_gelt"},                         -- Balthasar Gelt
    {["id"] = "2140784136",	["faction"] = "wh_main_emp_empire", ["subtype"] = "dlc04_emp_volkmar"} ,                         -- Volkmar the Grim
    {["id"] = "2140784127",	["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "dlc03_bst_malagor"}, 		                 -- Malagor
    {["id"] = "2140784189",	["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "dlc05_bst_morghur"}			             -- Morghur

} --:vector<map<string, string>> 

--v function(quests: vector<{string, number}>, subtype: string)
local function ancillary_on_rankup(quests, subtype)
	for i = 1, #quests do
		local current_quest= quests[i]
		local ancillary = current_quest[1]
		local rank = current_quest[2]			
        core:add_listener(
            ancillary.."_CharacterTurnStart",
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

--v function(faction: CA_FACTION) --> boolean
local function are_lords_missing(faction)
    local lord_missing = false
	for i = 1, #locked_ai_generals do
        if faction:name() == locked_ai_generals[i].faction and not cm:get_saved_value(locked_ai_generals[i].subtype.."_spawned") then
            local char_list = faction:character_list()
            local char_found = false
            for j = 0, char_list:num_items() - 1 do
                local current_char = char_list:item_at(j)
                if current_char:character_subtype_key() == locked_ai_generals[i].subtype then
                    cm:set_saved_value(locked_ai_generals[i].subtype.."_spawned", faction:name()) 
                    char_found = true
                end
            end
            if not char_found then
                lord_missing = true
                break
            end
        end
    end
    return lord_missing
end

--v function(faction: string, x: number, y: number) --> (number, number)
local function find_valid_spawn_coordinates(faction, x, y)
    -- Witten by Vandy. Full credit goes to him.
    local spawnX, spawnY = cm:find_valid_spawn_location_for_character_from_position(faction, x, y, false)
    local valid = false
    while not valid do
        if spawnX ~= -1 then
            valid = true
            break
        end
        local square = {x - 5, x + 5, y - 5, y + 5}
        spawnX, spawnY = cm:find_valid_spawn_location_for_character_from_position(faction, cm:random_number(square[2], square[1]), cm:random_number(square[4], square[3]), false)
    end
    return spawnX, spawnY
end

--v function(confederator: CA_FACTION, confederated: CA_FACTION)
local function spawn_missing_lords(confederator, confederated)
    local start_region = confederator:region_list():item_at(0)
    if wh_faction_is_horde(confederator) or not start_region then start_region = confederator:military_force_list():item_at(0):general_character():region() end
    local x, y = cm:find_valid_spawn_location_for_character_from_settlement(confederator:name(), start_region:name(), false, false, 9)
    if wh_faction_is_horde(confederator) or not start_region then
        x, y = cm:find_valid_spawn_location_for_character_from_position(confederator:name(), confederator:military_force_list():item_at(0):general_character():logical_position_x() + 1, confederator:military_force_list():item_at(0):general_character():logical_position_y(), false)
    end
    --RDLOG("Trying to revive Faction: "..confederated:name().." | Region: "..start_region:name())
    local char_cqi
    cm:create_force(
        confederated:name(),
        "wh_main_dwf_inf_hammerers",
        start_region:name(),
        x,
        y,
        true,
        function(cqi)
            --RDLOG("spawn_missing_lords | Faction revived: "..confederated:name().." | Region: "..start_region:name())
            char_cqi = cqi
        end
    )
    --spawn lords
    for i = 1, #locked_ai_generals do
        if confederated:name() == locked_ai_generals[i].faction and not cm:get_saved_value(locked_ai_generals[i].subtype.."_spawned") then
            local char_list = confederated:character_list()
            local char_found = false
            for j = 0, char_list:num_items() - 1 do
                local current_char = char_list:item_at(j)
                if current_char:character_subtype_key() == locked_ai_generals[i].subtype then
                    char_found = true
                end
            end
            if not char_found then
                cm:unlock_starting_general_recruitment(locked_ai_generals[i].id, locked_ai_generals[i].faction)
                for n = 1, 10 do
                    if not cm:get_saved_value(locked_ai_generals[i].subtype.."_spawned") then
                        x, y = find_valid_spawn_coordinates(confederated:name(), x, y)
                        cm:create_force(
                            confederated:name(),
                            "wh_main_dwf_inf_hammerers",
                            start_region:name(),
                            x,
                            y,
                            false,
                            function(cqi)
                                local char = cm:get_character_by_cqi(cqi)
                                for k = 1, #locked_ai_generals do
                                    if char:character_subtype(locked_ai_generals[k].subtype) and not cm:get_saved_value(locked_ai_generals[k].subtype.."_spawned") then
                                        --cm:set_character_immortality(cm:char_lookup_str(cqi), true)
                                        RDLOG("["..n..".] spawn_missing_lords: "..char:character_subtype_key().." spawned!")
                                        cm:set_saved_value(locked_ai_generals[k].subtype.."_spawned", confederated:name()) 
                                    end
                                end
                                cm:kill_character(cqi, true, false)
                                --cm:callback(function()
                                    --if char:is_wounded() then cm:stop_character_convalescing(cqi) end
                                --end, 0.5)
                            end
                        )
                    end
                end
            end
        end
    end
    cm:callback(function() 
        --cm:kill_all_armies_for_faction(confederated)
        cm:kill_character(char_cqi, true, false)
    end, 2)
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
        "wh_main_bundle_confederation_wef",
        "wh_dlc03_beastmen_confederation_help"
    } --:vector<string>
    local has_confed_bundle = ""
    for i = 1, #bundles do
        if faction and faction:has_effect_bundle(bundles[i]) then has_confed_bundle = bundles[i] end
    end
    return has_confed_bundle
end

--v function(confederator: string, character: CA_CHAR, subtype_faction: map<string, string>)
local function lord_event(confederator, character, subtype_faction)
    for subtype, faction in pairs(subtype_faction) do
        if subtype == character:character_subtype_key() then
            local picture = faction_event_picture[confederator]
            if not is_number(picture) then picture = subculture_event_picture[cm:get_faction(confederator):subculture()] end
            local char_type = "legendary_lord"
            if cm:char_is_agent(character) then char_type = "legendary_hero" end
            --RDLOG("Faction event picture | Number: "..tostring(picture))
            --RDLOG("Faction event Title 1: "..effect.get_localised_string("event_feed_strings_text_title_event_" .. char_type .. "_available"))
            --RDLOG("Faction event Title 2: "..effect.get_localised_string("event_feed_strings_text_title_event_"..subtype.."_LL_unlocked"))
            --RDLOG("Faction event Description: "..effect.get_localised_string("event_feed_strings_text_description_event_"..subtype.."_LL_unlocked"))
            if picture and effect.get_localised_string("event_feed_strings_text_title_event_" .. subtype .. "_LL_unlocked") 
            and effect.get_localised_string("event_feed_strings_text_description_event_" .. subtype .. "_LL_unlocked") and char_type then
                cm:show_message_event(
                    confederator,
                    "event_feed_strings_text_title_event_" .. char_type .. "_available",
                    "event_feed_strings_text_title_event_" .. subtype .. "_LL_unlocked",
                    "event_feed_strings_text_description_event_" .. subtype .. "_LL_unlocked",
                    true,
                    picture
                )
            end
        end
    end    
end

--v function(faction_name: string)
local function apply_diplomacy(faction_name)
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
        -- 
        "wh2_dlc11_sc_cst_vampire_coast"
    } --:vector<string>
    local faction = cm:get_faction(faction_name)
    if faction then
        local subculture = faction:subculture()
        local culture = faction:culture()
        local confed_option = cm:get_saved_value("mcm_tweaker_confed_tweaks_" .. culture .."_value")
        local option = {}
        if confed_option == "enabled" then
            option.offer = true
            option.accept = true
            option.enable_payment = false
        elseif confed_option == "player_only" then
            if faction:is_human() then
                option.offer = true
                option.accept = true
                option.enable_payment = false
            else
                option.offer = false
                option.accept = true
                option.enable_payment = false	
            end
        elseif confed_option == "disabled" then
            option.offer = false
            option.accept = false
            option.enable_payment = false				
        elseif confed_option == "yield" or confed_option == nil then
            option.offer = true
            option.accept = true
            option.enable_payment = false
            for i, subculture_confed in ipairs(subculture_confed_disabled) do
                if subculture == subculture_confed then
                    option.offer = false
                    option.accept = false
                    option.enable_payment = false
                end
            end	
        elseif (confed_option == "yield" or confed_option == nil) and subculture == "wh_dlc05_sc_wef_wood_elves" then
            option.accept = false
            option.enable_payment = false        	
            oak_region = cm:get_region("wh_main_yn_edri_eternos_the_oak_of_ages")
            if oak_region:building_exists("wh_dlc05_wef_oak_of_ages_3") then
                option.offer = true
            else
                option.offer = false
            end  
        end
        cm:callback(
            function(context)
                cm:force_diplomacy("faction:" .. faction_name, "subculture:" .. subculture, "form confederation", option.offer, option.accept, option.enable_payment)

                if faction:name() == "wh_main_vmp_rival_sylvanian_vamps" then
                    cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps", "faction:wh_main_vmp_vampire_counts", "form confederation", false, false, true)
                    cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps", "faction:wh_main_vmp_schwartzhafen", "form confederation", false, false, true)
                end
                if (confed_option == "yield" or confed_option == nil) and subculture == "wh_main_sc_brt_bretonnia" then
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
                        local has_tech = faction:has_technology(bret_confederation_tech[i].tech);
                        cm:force_diplomacy("faction:"..faction:name(), "faction:"..bret_confederation_tech[i].faction, "form confederation", has_tech, has_tech, true);
                    end
                end
            end, 1, "changeDiplomacyOptions"
        )
    end
end

--v function(confederator: CA_FACTION, confederated: CA_FACTION)
local function confed_revived(confederator, confederated)
    local start_region = confederator:region_list():item_at(0)
    if wh_faction_is_horde(confederator) or not start_region then start_region = confederator:military_force_list():item_at(0):general_character():region() end
    local x, y = cm:find_valid_spawn_location_for_character_from_settlement(confederator:name(), start_region:name(), false, false, 9)
    if wh_faction_is_horde(confederator) or not start_region then
        x, y = cm:find_valid_spawn_location_for_character_from_position(confederator:name(), confederator:military_force_list():item_at(0):general_character():logical_position_x()+1, confederator:military_force_list():item_at(0):general_character():logical_position_y(), false)
    end
    --RDLOG("Trying to revive Faction: "..confederated:name().." | Region: "..start_region:name())
    cm:create_force(
        confederated:name(),
        "wh_main_dwf_inf_hammerers",
        start_region:name(),
        x,
        y,
        true,
        function(cqi)
            --RDLOG("Faction revived: "..confederated:name().." | Region: "..start_region:name())
            local faction_leader_cqi = confederated:faction_leader():command_queue_index()
            local char_list = confederated:character_list()
            for i = 0, char_list:num_items() - 1 do 
                local char = char_list:item_at(i)
                local command_queue_index = char:command_queue_index()
                --if not char:has_military_force() and (cm:char_is_general(char) or cm:char_is_agent(char)) then cm:kill_character(command_queue_index, true, false) end --kill colonels
                if confederator:is_human() then 
                    lord_event(confederator:name(), char, subtype_faction)
                    if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") then lord_event(confederator:name(), char, mixu1_subtype_faction) end
                    if vfs.exists("script/campaign/mod/mixu_darkhand.lua") then lord_event(confederator:name(), char, mixu2_subtype_faction) end
                    if vfs.exists("script/campaign/mod/eltharion_yvresse_add.lua") then lord_event(confederator:name(), char, xoudad_subtype_faction) end
                    if vfs.exists("script/campaign/main_warhammer/mod/cataph_kraka_drak.lua") then lord_event(confederator:name(), char, kraka_subtype_faction) end
                    if vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then lord_event(confederator:name(), char, teb_subtype_faction) end
                    if vfs.exists("script/export_helpers_enforest.lua") then lord_event(confederator:name(), char, parte_subtype_faction) end
                    if vfs.exists("script/campaign/main_warhammer/mod/spcha_live_launch.lua") then lord_event(confederator:name(), char, speshul_subtype_faction) end
                    if vfs.exists("script/export_helpers_why_grudge.lua") then lord_event(confederator:name(), char, wsf_subtype_faction) end
                    if vfs.exists("script/export_helpers_ordo_draconis_why.lua") then lord_event(confederator:name(), char, ordo_subtype_faction) end
                    if vfs.exists("script/export_helpers_why_strigoi_camp.lua") then lord_event(confederator:name(), char, strigoi_subtype_faction) end
                    --if vfs.exists("script/campaign/mod/ovn_rogue.lua") then lord_event(confederator:name(), char, second_start_subtype_faction) end
                    --if vfs.exists("script/campaign/mod/sr_chaos.lua") then lord_event(confederator:name(), char, lost_factions_subtype_faction) end
                    --RDLOG("Faction: "..confederated:name().." | ".."Character | Forename: "..effect.get_localised_string(char:get_forename()).." | Surname: "..effect.get_localised_string(char:get_surname()))
                end
                if command_queue_index ~= cqi and not char:is_faction_leader() then cm:kill_character(command_queue_index, true, false) end
            end
            if confederated:name() == "wh2_main_hef_eataine" and not cm:get_saved_value("v_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked") then
                local char_list = confederated:character_list()
                local char_found = false
                for k = 0, char_list:num_items() - 1 do
                    local current_char = char_list:item_at(k)
                    if current_char:character_subtype_key() == "wh2_main_hef_prince_alastar" then
                        char_found = true
                    end
                end      
                if not char_found then  
                    RDLOG("spawn_missing_lords: ".."wh2_main_hef_prince_alastar".." spawned!")         
                    cm:spawn_character_to_pool(confederator:name(), "names_name_2147360555", "names_name_2147360560", "", "", 18, true, "general", "wh2_main_hef_prince_alastar", true, "")
                    cm:set_saved_value("v_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked", true)
                    ancillary_on_rankup(alastar_quests, "wh2_main_hef_prince_alastar")
                    if confederator:is_human() then
                        cm:show_message_event(
                            confederator:name(),
                            "event_feed_strings_text_title_event_legendary_lord_available",
                            "event_feed_strings_text_title_event_wh2_main_hef_prince_alastar_LL_unlocked",
                            "event_feed_strings_text_description_event_wh2_main_hef_prince_alastar_LL_unlocked",
                            true,
                            faction_event_picture[confederator:name()]
                        )
                    end
                    if cm:model():campaign_name("main_warhammer") then
                        cm:lock_starting_general_recruitment("1065845653", "wh2_main_hef_eataine")
                    else
                        cm:lock_starting_general_recruitment("2140785181", "wh2_main_hef_eataine")
                    end
                end
            end
            --cm:callback(function() 
                cm:force_confederation(confederator:name(), confederated:name()) 
            --end, 1)   
            core:add_listener(
                "confed_revived_FactionJoinsConfederation",
                "FactionJoinsConfederation",
                function(context)
                    return context:confederation():name() == confederator:name() and context:faction():name() == confederated:name()
                end,
                function(context)
                    RDLOG("Faction: "..confederator:name().." :confederated: "..confederated:name())
                    cm:callback(function() 
                        if confed_penalty(confederator) ~= "" then cm:remove_effect_bundle(confed_penalty(confederator), confederator:name()) end 
                    end, 0.5) 
                    if context:confederation():subculture() == "wh2_dlc09_sc_tmb_tomb_kings" or context:confederation():subculture() == "wh2_dlc11_sc_cst_vampire_coast" then
                        local char = cm:get_character_by_cqi(faction_leader_cqi)
                        if char:character_subtype("wh2_dlc09_tmb_arkhan") or char:character_subtype("wh2_dlc09_tmb_khalida") or char:character_subtype("wh2_dlc09_tmb_khatep") or char:character_subtype("wh2_dlc09_tmb_settra")
                        or char:character_subtype("wh2_dlc11_cst_aranessa") or char:character_subtype("wh2_dlc11_cst_cylostra") or char:character_subtype("wh2_dlc11_cst_harkon") or char:character_subtype("wh2_dlc11_cst_noctilus") then
                            cm:set_character_immortality(cm:char_lookup_str(faction_leader_cqi), true) 
                        end
                    end
                    cm:kill_character(cqi, true, false) 
                    cm:kill_character(faction_leader_cqi, true, false)                   
                    apply_diplomacy(confederator:name())            
                end,
                false
            )
        end
    )
end

--v function()
local function init()
    local human_factions = cm:get_human_factions()
    local faction_P1 = cm:get_faction(human_factions[1])
    local faction_P2
    if cm:is_multiplayer() then
        faction_P2 = cm:get_faction(human_factions[2])
    end

    core:add_listener(
        "refugee_FactionTurnEnd",
        "FactionTurnEnd",
        true,
        function(context)
            if cm:model():turn_number() == 1 and context:faction():is_human() then 
                local faction_list = cm:model():world():faction_list()
                for i = 0, faction_list:num_items() - 1 do
                    local current_faction = faction_list:item_at(i)
                    if current_faction:is_dead() then -- delayed spawn?
                            -- faction exceptions
                        if current_faction:subculture() ~= "wh_main_sc_chs_chaos" and not current_faction:name():find("_waaagh") and not current_faction:name():find("_brayherd") 
                        and not current_faction:name():find("_qb") and not current_faction:name():find("_separatists") and not current_faction:name():find("_dil") 
                        and not current_faction:name():find("_blood_voyage") and not current_faction:name():find("_encounters") then --and not current_faction:subculture() == "wh_main_sc_nor_norsca"
                            cm:set_saved_value("delayed_spawn_"..current_faction:name(), true)
                            RDLOG("Faction will spawn delayed: "..current_faction:name())
                        end
                    end
                end
            else
                if cm:get_saved_value("sought_refuge_"..context:faction():name()) then
                    cm:set_saved_value("sought_refuge_"..context:faction():name(), false)
                    RDLOG("Faction respawned: "..context:faction():name())
                end
                if cm:get_saved_value("delayed_spawn_"..context:faction():name()) then
                    cm:set_saved_value("delayed_spawn_"..context:faction():name(), false)
                    RDLOG("Faction spawned delayed: "..context:faction():name())
                end
            end
        end,
        true
    )

    core:add_listener(
        "refugee_FactionTurnStart",
        "FactionTurnStart",
        function(context)
            return cm:model():turn_number() >= 2 and context:faction():is_human() --and (not cm:is_multiplayer() or (cm:is_multiplayer() and (cm:model():turn_number() % 5) == 0))
        end,
        function(context)
            cm:disable_event_feed_events(true, "", "", "faction_joins_confederation")
            cm:disable_event_feed_events(true, "", "", "diplomacy_faction_destroyed")
            cm:disable_event_feed_events(true, "", "", "diplomacy_faction_encountered")
            cm:disable_event_feed_events(true, "", "", "diplomacy_trespassing")
            cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_deaths", "")

            local ai_confederation_count = 1 -- limit:10 (limits turn start lag)
            local player_confederation_count = 1 -- limit:10
            local faction_list = cm:model():world():faction_list() --context:faction():factions_of_same_subculture() --cm:model():world():faction_list()
            for i = 0, faction_list:num_items() - 1 do
                local current_faction = faction_list:item_at(i)            
                -- mcm restrictions
                if (not cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "all" 
                or (cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "lorefriendly" and current_faction:subculture() ~= "wh2_dlc09_sc_tmb_tomb_kings"
                and current_faction:subculture() ~= "wh_main_sc_teb_teb" and current_faction:subculture() ~= "wh_main_sc_grn_savage_orcs" and current_faction:subculture() ~= "wh2_dlc11_sc_cst_vampire_coast") 
                or (cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "lorefriendly" and current_faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings"
                and current_faction:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and current_faction:name() ~= "wh2_dlc09_tmb_khemri" and current_faction:name() ~= "wh2_dlc09_tmb_the_sentinels"))  
                and current_faction:is_dead() and not cm:get_saved_value("sought_refuge_"..current_faction:name()) and not cm:get_saved_value("delayed_spawn_"..current_faction:name()) then 
                    -- faction exceptions
                    if current_faction:subculture() ~= "wh_main_sc_chs_chaos" and not current_faction:name():find("_waaagh") and not current_faction:name():find("_brayherd") 
                    and not current_faction:name():find("_qb") and not current_faction:name():find("_separatists") and not current_faction:name():find("_dil") 
                    and not current_faction:name():find("_blood_voyage") and not current_faction:name():find("_encounters") and not current_faction:name():find("rebel") then --and not current_faction:subculture() == "wh_main_sc_nor_norsca"
                        local ai_remaining
                        if cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "ai" then
                            local subculture_faction_list = current_faction:factions_of_same_subculture()
                            for j = 0, subculture_faction_list:num_items() - 1 do
                                local subculture_faction = subculture_faction_list:item_at(j)
                                if not subculture_faction:is_dead() and not subculture_faction:is_human() then 
                                    ai_remaining = subculture_faction
                                    break
                                end
                            end
                        end
                        local prefered_faction = nil --:CA_FACTION
                        --if cm:get_saved_value("mcm_tweaker_recruit_defeated_diplo_value") ~= "disable" then
                            local saved_standing = nil --:number
                            local subculture_faction_list = current_faction:factions_of_same_subculture()
                            for j = 0, subculture_faction_list:num_items() - 1 do
                                local subculture_faction = subculture_faction_list:item_at(j)
                                if not subculture_faction:is_dead() then 
                                    local standing = current_faction:diplomatic_standing_with(subculture_faction:name())
                                    if not is_number(saved_standing) or standing > saved_standing then
                                        saved_standing = standing
                                        prefered_faction = subculture_faction
                                        --RDLOG("Faction: "..subculture_faction:name().." | Diplomatic Standing: "..tostring(saved_standing))
                                    end
                                end
                            end
                            --if prefered_faction then RDLOG("Faction: "..current_faction:name().." prefers to join Faction: "..prefered_faction:name().." | Diplomatic Standing: "..tostring(saved_standing)) end
                        --end    
                        if not faction_P1:is_dead() and (((not cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "player") 
                        and current_faction:subculture() == faction_P1:subculture()) or (cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "ai" and not ai_remaining) 
                        or (cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "disable" and prefered_faction and prefered_faction:name() == faction_P1:name())) then
                            if not cm:get_saved_value("faction_P1") and confed_penalty(faction_P1) == "" and player_confederation_count <= 10 
                            and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") == "player_ai" 
                            or cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") == "player") and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") 
                            or cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "all" or (cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "lorefriendly" 
                            and faction_P1:name() ~= "wh2_dlc09_tmb_followers_of_nagash")) then
                                if current_faction:name() == "wh_main_emp_empire" then cm:set_saved_value("karl_check_illegit", true) end
                                if are_lords_missing(current_faction) then
                                    RDLOG("["..player_confederation_count.."] Player 1 intents to intents to spawn missing lords for: "..current_faction:name())
                                    spawn_missing_lords(faction_P1, current_faction)
                                else
                                    RDLOG("["..player_confederation_count.."] Player 1 intents to confederated: "..current_faction:name())
                                    confed_revived(faction_P1, current_faction)
                                    if cm:is_multiplayer() and faction_P1:subculture() == faction_P2:subculture() then
                                        cm:set_saved_value("faction_P1", true)
                                        cm:set_saved_value("faction_P2", false)
                                    end
                                end
                                player_confederation_count = player_confederation_count + 1
                            end
                        elseif cm:is_multiplayer() and (((not cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "player") 
                        and current_faction:subculture() == faction_P2:subculture()) or (cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "ai" and not ai_remaining) 
                        or (cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "disable" and prefered_faction and prefered_faction:name() == faction_P2:name())) and not faction_P2:is_dead() then
                            if not cm:get_saved_value("faction_P2") and confed_penalty(faction_P2) == "" and player_confederation_count <= 10
                            and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") == "player_ai" 
                            or cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") == "player") and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") 
                            or cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "all" or (cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "lorefriendly" 
                            and faction_P2:name() ~= "wh2_dlc09_tmb_followers_of_nagash")) then
                                if current_faction:name() == "wh_main_emp_empire" then cm:set_saved_value("karl_check_illegit", true) end
                                if are_lords_missing(current_faction) then
                                    RDLOG("["..player_confederation_count.."] Player 2 intents to intents to spawn missing lords for: "..current_faction:name())
                                    spawn_missing_lords(faction_P2, current_faction)
                                else
                                    RDLOG("["..player_confederation_count.."] Player 2 intents to confederated: "..current_faction:name())
                                    confed_revived(faction_P2, current_faction)
                                    if cm:is_multiplayer() and faction_P1:subculture() == faction_P2:subculture() then
                                        cm:set_saved_value("faction_P2", true)
                                        cm:set_saved_value("faction_P1", false)                                
                                    end
                                end
                                player_confederation_count = player_confederation_count + 1
                            end
                        else --ai
                            if not cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") == "player_ai" 
                            or cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") == "ai" then
                                if ai_confederation_count <= 10 and prefered_faction  and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") 
                                or cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "all" or (cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "lorefriendly" 
                                and prefered_faction:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and prefered_faction:name() ~= "wh2_dlc09_tmb_the_sentinels")) then
                                    if are_lords_missing(current_faction) then
                                        RDLOG("["..ai_confederation_count.."] AI: "..current_faction:name().." intents to spawn missing lords!")
                                        spawn_missing_lords(prefered_faction, current_faction)
                                    else
                                        RDLOG("["..ai_confederation_count.."] AI: "..prefered_faction:name().." intents to confederated: "..current_faction:name())
                                        confed_revived(prefered_faction, current_faction)
                                    end
                                    ai_confederation_count = ai_confederation_count + 1
                                end
                            end
                        end
                    end
                end
            end
            cm:callback(function() 
                cm:disable_event_feed_events(false, "", "", "diplomacy_trespassing")                
                cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_deaths", "")   
                cm:disable_event_feed_events(false, "", "", "diplomacy_faction_destroyed")
                cm:disable_event_feed_events(false, "", "", "faction_joins_confederation")
                cm:disable_event_feed_events(false, "", "", "diplomacy_faction_encountered")             
            end, 3)
        end,
        true
    )

    core:add_listener(
        "confeddilemma_DilemmaChoiceMadeEvent",
        "DilemmaChoiceMadeEvent",
        function(context)
            return not context:dilemma():starts_with("wh2_dlc08_confederate_") and not context:dilemma():starts_with("wh_dlc07_brt_confederation_")
        end,
        function(context)
            cm:disable_event_feed_events(true, "", "", "faction_joins_confederation")
            cm:disable_event_feed_events(true, "", "", "diplomacy_trespassing")
            cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_deaths", "")
            --cm:disable_event_feed_events(true, "", "", "diplomacy_faction_encountered")   
            cm:disable_event_feed_events(true, "", "", "diplomacy_faction_destroyed")  

            cm:callback(function() 
                cm:disable_event_feed_events(false, "", "", "diplomacy_trespassing")                
                cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_deaths", "") 
                cm:disable_event_feed_events(false, "", "", "faction_joins_confederation")    
                --cm:disable_event_feed_events(false, "", "", "diplomacy_faction_encountered")   
                cm:disable_event_feed_events(false, "", "", "diplomacy_faction_destroyed")                     
            end, 3)
        end,
        true
    )

    core:add_listener(
        "refugee_FactionJoinsConfederation",
        "FactionJoinsConfederation",
        true,
        function(context)
            cm:set_saved_value("sought_refuge_"..context:faction():name(), context:confederation():name())
            --if context:confederation():subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
            --    local characterList = context:confederation():character_list()
            --    for i = 0, characterList:num_items() - 1 do
            --        local current_char = characterList:item_at(i)			
            --        if current_char:is_faction_leader() then --cm:char_is_general(current_char)
            --            cm:set_character_immortality(cm:char_lookup_str(current_char:command_queue_index()), true) 
            --        end
            --    end
            --end
            if cm:get_saved_value("karl_check_illegit") then cm:set_saved_value("karl_check_illegit", false) end
        end,
        true
    )
    
    core:add_listener(
        "refugee_ScriptEventConfederationExpired",
        "ScriptEventConfederationExpired",
        true,
        function(context)
            apply_diplomacy(context.string)
        end,
        true
    )
    --re-enable karl franz lock
    if faction_P1:name() == "wh_main_emp_empire" or (cm:is_multiplayer() and faction_P2:name() == "wh_main_emp_empire") then    
        core:remove_listener("2140783388" .. "_listener")
        core:add_listener(
            "2140783388" .. "_listener",
            "FactionJoinsConfederation",
            function(context)
                return context:confederation():name() == "wh_main_emp_empire"
            end,
            function()
                if char_with_forename_has_no_military_force("names_name_2147343849") and not cm:get_saved_value("karl_check_illegit") then                            
                    cm:unlock_starting_general_recruitment("2140783388", "wh_main_emp_empire")
                    cm:set_saved_value("2140783388" .. "_unlocked", true)
                    core:remove_listener("2140783388" .. "_listener")
                end
            end,
            false
        )
    end
end

function sm0_recruit_defeated()
    -- diplomacy
    local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc09_tmb_tomb_kings_value")
    if not confed_option_tmb or confed_option_tmb == "yield" then
        cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
    end
    local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc11_cst_vampire_coast_value")
    if not confed_option_tmb or confed_option_tmb == "yield" then
        cm:force_diplomacy("subculture:wh2_dlc11_sc_cst_vampire_coast", "subculture:wh2_dlc11_sc_cst_vampire_coast", "form confederation", false, false, false)
    end
    local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh_main_emp_empire") -- no teb / kislev subculture?
    if not confed_option_tmb or confed_option_tmb == "yield" then
        cm:force_diplomacy("subculture:wh_main_sc_teb_teb", "subculture:wh_main_sc_teb_teb", "form confederation", false, false, false)
    end
    -- old version compatibility
    local version_number = "1.0" --"vs.code"
    if cm:is_new_game() then 
        RDLOG_reset()
        if not not mcm then
            local recruit_defeated = mcm:register_mod("recruit_defeated", "Recruit Defeated Legendary Lords", "")
            if legacy_option then
                local version = recruit_defeated:add_tweaker("version", "Mod Version", "Choose your prefered mod version.")
                version:add_option("default", "Default", "This script uses confederation methods to transfer legendary lords from dead factions to the player/ai. Written by sm0kin.")
                version:add_option("legacy", "Legacy", "DISCONTINUED VERSION!!!\nThis script uses spawn methods to create doppelganger lords and deletes the original legendary lords in case the faction gets revived. Written by Scipion. Originally by scipion, reworked by sm0kin.")
            end
            local lore_restriction = recruit_defeated:add_tweaker("lore_restriction", "Restriction", "") --mcm_tweaker_recruit_defeated_lore_restriction_value
            lore_restriction:add_option("all", "Gotta Catch 'Em All", "No restrictions.")
            lore_restriction:add_option("lorefriendly", "Lorefriendly", "Restrictions are in place for the following factions:\n*Khemri: no Arkhan\n*Lybaras/Exiles of Nehek/Numas: no Settra, no Arkhan\nRecruit Defeated is disabled for the following cultures/factions:\n*TEB\n*Vampire Coast\n*Savage Orcs\nFollowers of Nagash:")
            local scope = recruit_defeated:add_tweaker("scope", "Available for", "") --mcm_tweaker_recruit_defeated_scope_value
            scope:add_option("player_ai", "Player & AI", "")
            scope:add_option("player", "Player only", "")
            scope:add_option("ai", "AI only", "")
            local preferance = recruit_defeated:add_tweaker("preferance", "Preference", "Should factions prefer to join the ai or the player (supersede diplomatic standing)?") --mcm_tweaker_recruit_defeated_preferance_value
            preferance:add_option("player", "Prefer Player", "")
            preferance:add_option("ai", "Prefer AI", "")
            preferance:add_option("disable", "Disable", "Defeated Lords join the faction they have the best diplomatic relations with.")
            --local diplo = recruit_defeated:add_tweaker("diplo", "Lords join factions based on diplomatic standing", "Defeated Lords join the faction they have the best diplomatic relations with.") --mcm_tweaker_recruit_defeated_diplo_value
            --diplo:add_option("enable", "Enable", "") 
            --diplo:add_option("disable", "Disable", "")
            mcm:add_post_process_callback(
                function()
                    local version = cm:get_saved_value("mcm_tweaker_recruit_defeated_version_value")
                    RDLOG("Mod Version: "..tostring(version).." ("..version_number..")")
                    if version ~= "legacy" then
                        cm:set_saved_value("sm0_recruit_defeated", true)
                        init()
                    else
                        cm:set_saved_value("sm0_recruit_defeated", false)
                    end
                    core:remove_listener("backup_init_trigger")
                end
            )
            --core:add_listener(
			--	"backup_init_trigger",
			--	"FactionAboutToEndTurn",
            --    function(context)
            --        local human_factions = cm:get_human_factions()
            --        local faction_P1 = cm:get_faction(human_factions[1])
			--		return context:faction():name() == faction_P1:name() and cm:turn_number() == 1
			--	end,
			--	function(context)
            --        cm:set_saved_value("sm0_recruit_defeated", true)
            --        RDLOG("Mod Version: default".." ("..version_number..")")
            --        init()
            --    end,
			--	false
			--)
        else
            cm:set_saved_value("sm0_recruit_defeated", true)
            RDLOG("Mod Version: default".." ("..version_number..")")
            init()
        end
    else
        RDLOG("--------------------------- GAME LOADED (post battle or save/load) ---------------------------")
		local version = cm:get_saved_value("mcm_tweaker_recruit_defeated_version_value")
        if version then
			if version ~= "legacy" then
                cm:set_saved_value("sm0_recruit_defeated", true)
                init()
            else
                cm:set_saved_value("sm0_recruit_defeated", false)
            end
        else 
            local old_script = false
            if not cm:get_saved_value("sm0_recruit_defeated") then
                for subtype, faction in pairs(subtype_faction) do 
                    if subtype ~= "wh2_main_hef_prince_alastar" and cm:get_saved_value("v_" .. subtype .. "_LL_unlocked") then old_script = true end
                end
            end
            if not old_script then
                cm:set_saved_value("sm0_recruit_defeated", true)
                init()
            end
		end
    end
end