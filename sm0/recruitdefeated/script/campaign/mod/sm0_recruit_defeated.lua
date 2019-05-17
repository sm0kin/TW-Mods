--Version 1.21

local v_debug_mode = false

-- ~=

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
    ["wh2_main_skv_clan_mors"] = 777,
    ["wh2_dlc09_skv_clan_rictus"] = 778,
    ["wh2_main_skv_clan_pestilens"] = 778,
    ["wh_dlc05_wef_argwylon"] = 605,
    ["wh_dlc05_wef_wood_elves"] = 605,
    ["wh_dlc08_nor_norsca"] = 800,
    ["wh_dlc08_nor_wintertooth"] = 800,
    ["wh2_dlc11_def_the_blessed_dread"] = 782,
    ["wh2_dlc11_cst_vampire_coast"] = 786,
    ["wh2_dlc11_cst_noctilus"] = 785,
    ["wh2_dlc11_cst_pirates_of_sartosa"] = 783,
    ["wh2_dlc11_cst_the_drowned"] = 784
}

local LORD_FORENAMES = {
	["dlc03_emp_boris_todbringer"] = "names_name_2147343937",	
    ["dlc04_emp_volkmar"] = "names_name_2147358013",
    ["emp_balthasar_gelt"] = "names_name_2147343922",
    ["emp_karl_franz"] = "names_name_2147343849",
    ["dlc04_vmp_helman_ghorst"] = "names_name_2147358044",
    ["dlc04_vmp_vlad_con_carstein"] = "names_name_2147345130",
    ["vie_cst_vmp_vlad_con_carstein"] = "names_name_2147345130",
    ["pro02_vmp_isabella_von_carstein"] = "names_name_2147345124",
    ["vmp_heinrich_kemmler"] = "names_name_2147345320",
    ["vmp_mannfred_von_carstein"] = "names_name_2147343886",
    ["wh_dlc05_vmp_red_duke"] = "names_name_2147359236",
    ["dwf_thorgrim_grudgebearer"] = "names_name_2147343883",
    ["dwf_ungrim_ironfist"] = "names_name_2147344414",
    ["dlc06_dwf_belegar"] = "names_name_2147358029",
    ["pro01_dwf_grombrindal"] = "names_name_2147358917",
    ["dlc06_grn_skarsnik"] = "names_name_2147358016",
    ["grn_azhag_the_slaughterer"] = "names_name_2147345906",
    ["grn_grimgor_ironhide"] = "names_name_2147343863",
    ["dlc06_grn_wurrzag_da_great_prophet"] = "names_name_2147358023",
    ["wh2_dlc09_tmb_arkhan"] = "names_name_1543395740",
    ["wh2_dlc09_tmb_khalida"] = "names_name_29274214",
    ["wh2_dlc09_tmb_khatep"] = "names_name_743554178",
    ["wh2_dlc09_tmb_settra"] = "names_name_1906048114",
    ["brt_louen_leoncouer"] = "names_name_2147343915",
    ["dlc07_brt_alberic"] = "names_name_2147345888",
    ["dlc07_brt_fay_enchantress"] = "names_name_2147358931",
    ["wh2_main_hef_teclis"] = "names_name_2147359256",
	["wh2_main_hef_tyrion"] = "names_name_2147360906",
	["wh2_main_hef_prince_alastar"] = "names_name_2147360555",
    ["wh2_dlc10_hef_alarielle"] = "names_name_898828143",
    ["wh2_dlc10_hef_alith_anar"] = "names_name_1829581114",
    ["wh2_dlc11_def_lokhir"] = "names_name_1748721115",
    ["wh2_main_def_malekith"] = "names_name_2147359265",
    ["wh2_main_def_morathi"] = "names_name_2147359274",
    ["wh2_main_lzd_lord_mazdamundi"] = "names_name_2147359230",
    ["wh2_main_lzd_kroq_gar"] = "names_name_2147359240",
    ["wh2_main_skv_lord_skrolk"] = "names_name_2147359296",
    ["wh2_dlc09_skv_tretch_craventail"] = "names_name_421856293",
    ["wh2_main_skv_queek_headtaker"] = "names_name_2147359300",
    ["dlc05_wef_durthu"] = "names_name_2147352813",
    ["dlc05_wef_orion"] = "names_name_2147352809",
    ["wh_dlc08_nor_throgg"] = "names_name_346878492",
    ["wh_dlc08_nor_wulfrik"] = "names_name_981430255",
    ["wh2_dlc10_def_crone_hellebron"] = "names_name_608740515",
    ["wh2_dlc11_cst_aranessa"] = "names_name_1340289195",
    ["wh2_dlc11_cst_cylostra"] = "names_name_143098456",
    ["wh2_dlc11_cst_harkon"] = "names_name_242277685",
	["wh2_dlc11_cst_noctilus"] = "names_name_227765640",
	--MIXU--
    ["brt_artois"] = "names_name_991000",
    ["brt_bastonne"] = "names_name_991002",
    ["brt_lyonesse"] = "names_name_991004",
    ["brt_parravon"] = "names_name_991006",
    ["dwf_karak_azul"] = "names_name_991010",
    ["dwf_thorek_ironbrow"] = "names_name_997000",
    ["emp_elspeth_von_draken"] = "names_name_991040",
    ["ksl_katarin_the_ice_queen"] = "names_name_991062",
    ["wef_torgovann"] = "names_name_991076",
    ["emp_averland"] = "names_name_2147343941",
    ["emp_hochland"] = "names_name_2147344017",
    ["emp_marienburg"] = "names_name_991028",
    ["emp_nordland"] = "names_name_2147344022",
    ["emp_ostermark"] = "names_name_2147344036",
    ["emp_ostland"] = "names_name_2147344026",
    ["emp_stirland"] = "names_name_2147344039",
    ["emp_markus_wulfhart"] = "names_name_6450683997",
    ["emp_alberich_von_korden"] = "names_name_6450684000",
    ["emp_talabecland"] = "names_name_2147344050",
	--MIXU Part 2--
    ["brt_john_tyreweld"] = "names_name_6450684018",
    ["chs_egrimm_van_horstmann"] = "names_name_6450684033",
    ["def_tullaris_dreadbringer"] = "names_name_6450684013",
    ["dwf_grimm_burloksson"] = "names_name_6450684029",
    ["grn_gorfang_rotgut"] = "names_name_6450684040",
    ["hef_belannaer"] = "names_name_6450684010",
    ["hef_caradryan"] = "names_name_6450684012",
    ["hef_korhil"] = "names_name_6450684017",
    ["hef_prince_imrik"] = "names_name_6450684027",
    ["lzd_gor_rok"] = "names_name_6450684016",
    ["lzd_lord_huinitenuchli"] = "names_name_2147359221",
    ["lzd_oxyotl"] = "names_name_6450684042",
    ["lzd_tetto_eko"] = "names_name_6450684015",
    ["nor_egil_styrbjorn"] = "names_name_6450684038",
    ["tmb_tutankhanut"] = "names_name_6450684045",
    ["wef_naieth_the_prophetess"] = "names_name_6450684035"
}

local LORD_FAMILY_NAMES = {
    ["dlc03_emp_boris_todbringer"] = "names_name_2147343940",
    ["dlc04_emp_volkmar"] = "names_name_2147358014",
    ["emp_balthasar_gelt"] = "names_name_2147343928",
    ["emp_karl_franz"] = "names_name_2147343858",
    ["dlc04_vmp_helman_ghorst"] = "names_name_2147345294",
    ["dlc04_vmp_vlad_con_carstein"] = "names_name_2147343895",
    ["vie_cst_vmp_vlad_con_carstein"] = "names_name_2147343895",
    ["pro02_vmp_isabella_von_carstein"] = "names_name_2147343895",
    ["vmp_heinrich_kemmler"] = "names_name_2147345313",
    ["vmp_mannfred_von_carstein"] = "names_name_2147343895",
    ["wh_dlc05_vmp_red_duke"] = "",
    ["dwf_thorgrim_grudgebearer"] = "names_name_2147343884",
    ["dwf_ungrim_ironfist"] = "names_name_2147344423",
    ["dlc06_dwf_belegar"] = "names_name_2147358036",
    ["pro01_dwf_grombrindal"] = "",
    ["dlc06_grn_skarsnik"] = "",
    ["grn_azhag_the_slaughterer"] = "names_name_2147357356",
    ["grn_grimgor_ironhide"] = "names_name_2147343867",
    ["dlc06_grn_wurrzag_da_great_prophet"] = "",
    ["wh2_dlc09_tmb_arkhan"] = "",
    ["wh2_dlc09_tmb_khalida"] = "",
    ["wh2_dlc09_tmb_khatep"] = "",
    ["wh2_dlc09_tmb_settra"] = "",
    ["brt_louen_leoncouer"] = "names_name_2147343917",
    ["dlc07_brt_alberic"] = "names_name_1529663917",
    ["dlc07_brt_fay_enchantress"] = "",
    ["wh2_main_hef_teclis"] = "",
	["wh2_main_hef_tyrion"] = "",
	["wh2_main_hef_prince_alastar"] = "names_name_2147360560",
    ["wh2_dlc10_hef_alarielle"] = "",
    ["wh2_dlc10_hef_alith_anar"] = "",
    ["wh2_dlc11_def_lokhir"] = "names_name_830390907",
    ["wh2_main_def_malekith"] = "",
    ["wh2_main_def_morathi"] = "",
    ["wh2_main_lzd_lord_mazdamundi"] = "",
    ["wh2_main_lzd_kroq_gar"] = "",
    ["wh2_main_skv_lord_skrolk"] = "",
    ["wh2_dlc09_skv_tretch_craventail"] = "names_name_1843290975",
    ["wh2_main_skv_queek_headtaker"] = "names_name_2147360908",
    ["dlc05_wef_durthu"] = "",
    ["dlc05_wef_orion"] = "",
    ["wh_dlc08_nor_throgg"] = "",
    ["wh_dlc08_nor_wulfrik"] = "names_name_791685155",
    ["wh2_dlc10_def_crone_hellebron"] = "",
    ["wh2_dlc11_cst_aranessa"] = "names_name_250811476",
    ["wh2_dlc11_cst_cylostra"] = "names_name_758220496",
    ["wh2_dlc11_cst_harkon"] = "names_name_1053168049",
    ["wh2_dlc11_cst_noctilus"] = "",
	--MIXU--
    ["brt_artois"] = "names_name_991001",
    ["brt_bastonne"] = "names_name_991003",
    ["brt_lyonesse"] = "names_name_991005",
    ["brt_parravon"] = "names_name_991007",
    ["dwf_karak_azul"] = "names_name_991011",
    ["dwf_thorek_ironbrow"] = "names_name_997001",
    ["emp_elspeth_von_draken"] = "names_name_991041",
    ["ksl_katarin_the_ice_queen"] = "names_name_991063",
    ["wef_torgovann"] = "names_name_991077",
    ["emp_averland"] = "names_name_2147343947",
    ["emp_hochland"] = "names_name_2147344019",
    ["emp_marienburg"] = "names_name_991029",
    ["emp_nordland"] = "names_name_2147344023",
    ["emp_ostermark"] = "names_name_2147344037",
    ["emp_ostland"] = "names_name_2147344030",
    ["emp_markus_wulfhart"] = "names_name_6450683996",
    ["emp_alberich_von_korden"] = "names_name_6450684003",
    ["emp_stirland"] = "names_name_2147344048",
    ["emp_talabecland"] = "names_name_2147344053",
	--MIXU Part 2--
    ["brt_john_tyreweld"] = "names_name_6450684019",
    ["chs_egrimm_van_horstmann"] = "names_name_6450684034",
    ["def_tullaris_dreadbringer"] = "names_name_6450684014",
    ["dwf_grimm_burloksson"] = "names_name_6450684030",
    ["grn_gorfang_rotgut"] = "names_name_6450684041",
    ["hef_belannaer"] = "names_name_6450684011",
    ["hef_caradryan"] = "names_name_2147360506",
    ["hef_korhil"] = "names_name_2147360506",
    ["hef_prince_imrik"] = "names_name_2147360506",
    ["lzd_gor_rok"] = "names_name_2147360514",
    ["lzd_lord_huinitenuchli"] = "names_name_6450684031",
    ["lzd_oxyotl"] = "names_name_2147360514",
    ["lzd_tetto_eko"] = "names_name_2147360514",
    ["nor_egil_styrbjorn"] = "names_name_6450684039",
    ["tmb_tutankhanut"] = "",
    ["wef_naieth_the_prophetess"] = "names_name_6450684036"
}

local ART_SET_ID = {
	["wh2_dlc09_tmb_khatep"] = "wh2_dlc09_art_set_tmb_khatep",
	["wh2_dlc09_tmb_settra"] = "wh2_dlc09_art_set_tmb_settra",
	["wh2_dlc09_tmb_khalida"] = "wh2_dlc09_art_set_tmb_khalida",
	["wh2_dlc09_tmb_arkhan"] = "wh2_dlc09_art_set_tmb_arkhan"
}

local LORDS_FACTION = {
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
    ["wh2_main_skv_lord_skrolk"] = "wh2_main_skv_clan_pestilens",
    ["wh2_dlc09_skv_tretch_craventail"] = "wh2_dlc09_skv_clan_rictus",
    ["wh2_main_skv_queek_headtaker"] = "wh2_main_skv_clan_mors",
    ["dlc05_wef_durthu"] = "wh_dlc05_wef_argwylon",
    ["dlc05_wef_orion"] = "wh_dlc05_wef_wood_elves",
    ["wh_dlc08_nor_throgg"] = "wh_dlc08_nor_wintertooth",
    ["wh_dlc08_nor_wulfrik"] = "wh_dlc08_nor_norsca",
    ["wh2_dlc10_def_crone_hellebron"] = "wh2_main_def_har_ganeth",
    ["wh2_dlc11_cst_aranessa"] = "wh2_dlc11_cst_pirates_of_sartosa",
    ["wh2_dlc11_cst_cylostra"] = "wh2_dlc11_cst_the_drowned",
    ["wh2_dlc11_cst_harkon"] = "wh2_dlc11_cst_vampire_coast",
	["wh2_dlc11_cst_noctilus"] = "wh2_dlc11_cst_noctilus",
	--MIXU--
    ["brt_artois"] = "wh_main_brt_artois",
    ["brt_bastonne"] = "wh_main_brt_bastonne",
    ["brt_lyonesse"] = "wh_main_brt_lyonesse",
    ["brt_parravon"] = "wh_main_brt_parravon",
    ["dwf_karak_azul"] = "wh_main_dwf_karak_azul",
    ["dwf_thorek_ironbrow"] = "wh_main_dwf_karak_azul",
    ["emp_elspeth_von_draken"] = "wh_main_emp_wissenland",
    ["ksl_katarin_the_ice_queen"] = "wh_main_ksl_kislev",
    ["wef_torgovann"] = "wh_dlc05_wef_torgovann",
    ["emp_averland"] = "wh_main_emp_averland",
    ["emp_hochland"] = "wh_main_emp_hochland",
    ["emp_marienburg"] = "wh_main_emp_marienburg",
    ["emp_nordland"] = "wh_main_emp_nordland",
    ["emp_ostermark"] = "wh_main_emp_ostermark",
    ["emp_ostland"] = "wh_main_emp_ostland",
    ["emp_stirland"] = "wh_main_emp_stirland",
    ["emp_talabecland"] = "wh_main_emp_talabecland",
	--MIXU Part 2--
    ["brt_john_tyreweld"] = "wh2_main_brt_knights_of_origo",
    --["chs_egrimm_van_horstmann"] = "wh_main_chs_chaos_separatists",
    --["def_tullaris_dreadbringer"] = "def_tullaris_dreadbringer",
    --["dwf_grimm_burloksson"] = "wh_main_dwf_zhufbar",
    ["grn_gorfang_rotgut"] = "wh_main_grn_red_fangs",
    ["hef_belannaer"] = "wh2_main_hef_saphery",
    --["hef_caradryan"] = "wh2_main_hef_eataine",
    ["hef_korhil"] = "wh2_main_hef_chrace",
    ["hef_prince_imrik"] = "wh2_main_hef_caledor",
    ["lzd_gor_rok"] = "wh2_main_lzd_itza",
    ["lzd_lord_huinitenuchli"] = "wh2_main_lzd_xlanhuapec",
    ["lzd_oxyotl"] = "wh2_main_lzd_tlaqua",
    ["lzd_tetto_eko"] = "wh2_main_lzd_tlaxtlan",
    ["nor_egil_styrbjorn"] = "wh_main_nor_skaeling",
    ["tmb_tutankhanut"] = "wh2_dlc09_tmb_numas",
    ["wef_naieth_the_prophetess"] = "wh_dlc05_wef_wydrioth"
}

local LORDS_ITEM = {
    ["dlc04_vmp_helman_ghorst"] = {"wh_dlc04_anc_arcane_item_the_liber_noctus"},
    ["dlc04_vmp_vlad_con_carstein"] = {"wh_dlc04_anc_talisman_the_carstein_ring","wh_dlc04_anc_weapon_blood_drinker"},
    ["pro02_vmp_isabella_von_carstein"] = {"wh_pro02_anc_enchanted_item_blood_chalice_of_bathori"},
    ["vmp_heinrich_kemmler"] = {"wh_main_anc_weapon_chaos_tomb_blade","wh_main_anc_arcane_item_skull_staff","wh_main_anc_enchanted_item_cloak_of_mists_and_shadows"},
    --["vmp_mannfred_von_carstein"] = {"wh_main_anc_armour_armour_of_templehof","wh_main_anc_weapon_gold_sigil_sword","wh_main_anc_weapon_sword_of_unholy_power"},
    ["vmp_mannfred_von_carstein"] = {"wh_main_anc_armour_armour_of_templehof","wh_main_anc_weapon_sword_of_unholy_power"},
    --["wh_dlc05_vmp_red_duke"] = {"XXXXXX"},
    ["dwf_thorgrim_grudgebearer"] = {"wh_main_anc_armour_the_armour_of_skaldour","wh_main_anc_enchanted_item_the_great_book_of_grudges","wh_main_anc_talisman_the_dragon_crown_of_karaz","wh_main_anc_weapon_the_axe_of_grimnir"},
    ["dwf_ungrim_ironfist"] = {"wh_main_anc_armour_the_slayer_crown","wh_main_anc_talisman_dragon_cloak_of_fyrskar","wh_main_anc_weapon_axe_of_dargo"},
    ["dlc06_dwf_belegar"] = {"wh_dlc06_anc_armour_shield_of_defiance","wh_dlc06_anc_weapon_the_hammer_of_angrund"},
    ["pro01_dwf_grombrindal"] = {"wh_pro01_anc_armour_armour_of_glimril_scales","wh_pro01_anc_enchanted_item_rune_helm_of_zhufbar","wh_pro01_anc_talisman_cloak_of_valaya","wh_pro01_anc_weapon_the_rune_axe_of_grombrindal"},
    ["dlc06_grn_skarsnik"] = {"wh_dlc06_anc_weapon_skarsniks_prodder"},
    ["grn_azhag_the_slaughterer"] = {"wh_main_anc_armour_azhags_ard_armour","wh_main_anc_enchanted_item_the_crown_of_sorcery","wh_main_anc_weapon_slaggas_slashas"},
    --["grn_grimgor_ironhide"] = {"wh_main_anc_armour_blood-forged_armour","wh_main_anc_armour_gamblers_armour","wh_main_anc_weapon_gitsnik"},
    ["grn_grimgor_ironhide"] = {"wh_main_anc_armour_blood-forged_armour","wh_main_anc_weapon_gitsnik"},
    ["dlc06_grn_wurrzag_da_great_prophet"] = {"wh_dlc06_anc_arcane_item_squiggly_beast","wh_dlc06_anc_enchanted_item_baleful_mask","wh_dlc06_anc_weapon_bonewood_staff"},
	["wh2_dlc09_tmb_arkhan"] = {"wh2_dlc09_anc_weapon_the_tomb_blade_of_arkhan","wh2_dlc09_anc_arcane_item_staff_of_nagash"},
	["wh2_dlc09_tmb_khatep"] = {"wh2_dlc09_anc_arcane_item_the_liche_staff"},
	["wh2_dlc09_tmb_khalida"] = {"wh2_dlc09_anc_weapon_the_venom_staff"},
    ["wh2_dlc09_tmb_settra"] = {"wh2_dlc09_anc_enchanted_item_the_crown_of_nehekhara","wh2_dlc09_anc_weapon_the_blessed_blade_of_ptra"},
    ["brt_louen_leoncouer"] = {"wh_main_anc_weapon_the_sword_of_couronne"},
    ["dlc07_brt_alberic"] = {"wh_dlc07_anc_weapon_trident_of_manann"},
    ["dlc07_brt_fay_enchantress"] = {"wh_dlc07_anc_arcane_item_the_chalice_of_potions"},
    ["wh2_main_hef_teclis"] = {"wh2_main_anc_arcane_item_war_crown_of_saphery","wh2_main_anc_weapon_sword_of_teclis"},
	["wh2_main_hef_tyrion"] = {"wh2_main_anc_armour_dragon_armour_of_aenarion","wh2_main_anc_weapon_sunfang"},
	--["wh2_main_hef_prince_alastar"] = {"XXXXXX"},
    ["wh2_dlc10_hef_alarielle"] = {"wh2_dlc10_anc_enchanted_item_star_of_avelorn","wh2_dlc10_anc_talisman_shieldstone_of_isha"},
	["wh2_dlc10_hef_alith_anar"] = {"wh2_dlc10_anc_weapon_moonbow","wh2_dlc10_anc_talisman_stone_of_midnight"},
	["wh2_dlc11_def_lokhir"] = {"wh2_dlc11_anc_weapon_red_blades","wh2_main_anc_armour_helm_of_the_kraken"},
    ["wh2_main_def_malekith"] = {"wh2_main_anc_arcane_item_circlet_of_iron","wh2_main_anc_armour_supreme_spellshield","wh2_main_anc_weapon_destroyer"},
    ["wh2_main_def_morathi"] = {"wh2_main_anc_weapon_heartrender_and_the_darksword"},
    ["wh2_main_lzd_lord_mazdamundi"] = {"wh2_main_anc_magic_standard_sunburst_standard_of_hexoatl","wh2_main_anc_weapon_cobra_mace_of_mazdamundi"},
    ["wh2_main_lzd_kroq_gar"] = {"wh2_main_anc_enchanted_item_hand_of_gods","wh2_main_anc_weapon_revered_spear_of_tlanxla"},
    ["wh2_main_skv_lord_skrolk"] = {"wh2_main_anc_arcane_item_the_liber_bubonicus","wh2_main_anc_weapon_rod_of_corruption"},
    ["wh2_dlc09_skv_tretch_craventail"] = {"wh2_dlc09_anc_enchanted_item_lucky_skullhelm"},
    ["wh2_main_skv_queek_headtaker"] = {"wh2_main_anc_armour_warp_shard_armour","wh2_main_anc_weapon_dwarf_gouger"},
    ["dlc05_wef_durthu"] = {"wh_dlc05_anc_weapon_daiths_sword"},
    ["dlc05_wef_orion"] = {"wh_dlc05_anc_enchanted_item_horn_of_the_wild_hunt","wh_dlc05_anc_talisman_cloak_of_isha","wh_dlc05_anc_weapon_spear_of_kurnous"},
    ["wh_dlc08_nor_throgg"] = {"wh_dlc08_anc_talisman_wintertooth_crown"},
    ["wh_dlc08_nor_wulfrik"] = {"wh_dlc08_anc_weapon_sword_of_torgald"},
    ["wh2_dlc10_def_crone_hellebron"] = {"wh2_dlc10_anc_talisman_amulet_of_dark_fire"},
    ["wh2_dlc11_cst_aranessa"] = {"wh2_dlc11_anc_weapon_krakens_bane"},
    ["wh2_dlc11_cst_cylostra"] = {"wh2_dlc11_anc_arcane_item_the_bordeleaux_flabellum"},
    ["wh2_dlc11_cst_harkon"] = {"wh2_dlc11_anc_enchanted_item_slann_gold"},
	["wh2_dlc11_cst_noctilus"] = {"wh2_dlc11_anc_enchanted_item_captain_roths_moondial"},

	--MIXU--
	["brt_artois"] = {"wh_main_anc_mount_brt_artois_barded_warhorse"},
	["brt_bastonne"] = {"wh_main_anc_mount_brt_bastonne_barded_warhorse"},
	["brt_lyonesse"] = {"wh_main_anc_mount_brt_lyonesse_barded_warhorse"},
	["brt_parravon"] = {"wh_main_anc_mount_brt_parravon_royal_pegasus"},	
	["emp_averland"] = {"wh_anc_marius_leitdorf_mothers_ruin"},
	["emp_hochland"] = {"wh_anc_aldebrand_ludenhof_beast_slayer"},
	["emp_marienburg"] = {"wh_anc_edward_van_der_kraal_sea_bride_standard"},
	["emp_nordland"] = {"wh_anc_theoderic_gausser_crow_feeder"},
	["emp_ostermark"] = {"wh_anc_wolfram_hertwig_troll_cleaver"},
	["emp_ostland"] = {"wh_anc_valmir_von_raukov_brain_wounder"},
	["emp_stirland"] = {"wh_anc_alberich_haupt-anderssen_orc_hewer"},
	["emp_talabecland"] = {"wh_anc_helmut_feuerbach_stone_breaker"}
}

local ITEM_REQ = {

	["wh_dlc04_anc_arcane_item_the_liber_noctus"] = 8,
	["wh_dlc04_anc_talisman_the_carstein_ring"] = 13,
	["wh_dlc04_anc_weapon_blood_drinker"] = 8,
	["wh_pro02_anc_enchanted_item_blood_chalice_of_bathori"] = 9,
	["wh_main_anc_weapon_chaos_tomb_blade"] = 8,
	["wh_main_anc_arcane_item_skull_staff"] = 18,
	["wh_main_anc_enchanted_item_cloak_of_mists_and_shadows"] = 13,
	["wh_main_anc_armour_armour_of_templehof"] = 13,
	["wh_main_anc_weapon_sword_of_unholy_power"] = 8,
	["wh_main_anc_armour_the_armour_of_skaldour"] = 13,
	["wh_main_anc_enchanted_item_the_great_book_of_grudges"] = 23,
	["wh_main_anc_talisman_the_dragon_crown_of_karaz"] = 18,
	["wh_main_anc_weapon_the_axe_of_grimnir"] = 8,
	["wh_main_anc_armour_the_slayer_crown"] = 8,
	["wh_main_anc_talisman_dragon_cloak_of_fyrskar"] = 13,
	["wh_main_anc_weapon_axe_of_dargo"] = 18,
	["wh_dlc06_anc_armour_shield_of_defiance"] = 8,
	["wh_dlc06_anc_weapon_the_hammer_of_angrund"] = 13,
	["wh_pro01_anc_armour_armour_of_glimril_scales"] = 8,
	["wh_pro01_anc_enchanted_item_rune_helm_of_zhufbar"] = 23,
	["wh_pro01_anc_talisman_cloak_of_valaya"] = 18,
	["wh_pro01_anc_weapon_the_rune_axe_of_grombrindal"] = 13,
	["wh_dlc06_anc_weapon_skarsniks_prodder"] = 8,
	["wh_main_anc_armour_azhags_ard_armour"] = 13,
	["wh_main_anc_enchanted_item_the_crown_of_sorcery"] = 8,
	["wh_main_anc_weapon_slaggas_slashas"] = 18,
	["wh_main_anc_armour_blood-forged_armour"] = 13,
	["wh_main_anc_weapon_gitsnik"] = 8,
	["wh_dlc06_anc_arcane_item_squiggly_beast"] = 13,
	["wh_dlc06_anc_enchanted_item_baleful_mask"] = 8,
	["wh_dlc06_anc_weapon_bonewood_staff"] = 18,
	["wh2_dlc09_anc_weapon_the_tomb_blade_of_arkhan"] = 6,
	["wh2_dlc09_anc_arcane_item_staff_of_nagash"] = 10,
	["wh2_dlc09_anc_arcane_item_the_liche_staff"] = 6,
	["wh2_dlc09_anc_weapon_the_venom_staff"] = 12,
	["wh_main_anc_weapon_the_sword_of_couronne"] = 9,
	["wh2_dlc09_anc_enchanted_item_the_crown_of_nehekhara"] = 6,
	["wh2_dlc09_anc_weapon_the_blessed_blade_of_ptra"] = 13,
	["wh_dlc07_anc_weapon_trident_of_manann"] = 3,
	["wh_dlc07_anc_arcane_item_the_chalice_of_potions"] = 9,
	["wh2_main_anc_arcane_item_war_crown_of_saphery"] = 6,
	["wh2_main_anc_weapon_sword_of_teclis"] = 10,
	["wh2_main_anc_armour_dragon_armour_of_aenarion"] = 6,
	["wh2_main_anc_weapon_sunfang"] = 10,
	["wh2_dlc10_anc_enchanted_item_star_of_avelorn"] = 15,
	["wh2_dlc10_anc_talisman_shieldstone_of_isha"] = 2,
	["wh2_dlc10_anc_weapon_moonbow"] = 15,
	["wh2_dlc10_anc_talisman_stone_of_midnight"] = 2,
	["wh2_dlc11_anc_weapon_red_blades"] = 15,
	["wh2_main_anc_armour_helm_of_the_kraken"] = 11,
	["wh2_main_anc_arcane_item_circlet_of_iron"] = 6,
	["wh2_main_anc_armour_supreme_spellshield"] = 14,
	["wh2_main_anc_weapon_destroyer"] = 10,
	["wh2_main_anc_weapon_heartrender_and_the_darksword"] = 6,
	["wh2_main_anc_magic_standard_sunburst_standard_of_hexoatl"] = 6,
	["wh2_main_anc_weapon_cobra_mace_of_mazdamundi"] = 10,
	["wh2_main_anc_enchanted_item_hand_of_gods"] = 10,
	["wh2_main_anc_weapon_revered_spear_of_tlanxla"] = 6,
	["wh2_main_anc_arcane_item_the_liber_bubonicus"] = 6,
	["wh2_main_anc_weapon_rod_of_corruption"] = 10,
	["wh2_dlc09_anc_enchanted_item_lucky_skullhelm"] = 8,
	["wh2_main_anc_armour_warp_shard_armour"] = 6,
	["wh2_main_anc_weapon_dwarf_gouger"] = 10,
	["wh_dlc05_anc_weapon_daiths_sword"] = 8,
	["wh_dlc05_anc_enchanted_item_horn_of_the_wild_hunt"] = 8,
	["wh_dlc05_anc_talisman_cloak_of_isha"] = 13,
	["wh_dlc05_anc_weapon_spear_of_kurnous"] = 18,
	["wh_dlc08_anc_talisman_wintertooth_crown"] = 9,
	["wh_dlc08_anc_weapon_sword_of_torgald"] = 9,
	["wh2_dlc10_anc_talisman_amulet_of_dark_fire"] = 15,
	["wh2_dlc11_anc_weapon_krakens_bane"] = 15,
	["wh2_dlc11_anc_arcane_item_the_bordeleaux_flabellum"] = 9,
	["wh2_dlc11_anc_enchanted_item_slann_gold"] = 15,
	["wh2_dlc11_anc_enchanted_item_captain_roths_moondial"] = 15,

	--MIXU--
	["wh_main_anc_mount_brt_artois_barded_warhorse"] = 1,
	["wh_main_anc_mount_brt_bastonne_barded_warhorse"] = 1,
	["wh_main_anc_mount_brt_lyonesse_barded_warhorse"] = 1,
	["wh_main_anc_mount_brt_parravon_royal_pegasus"] = 1,	
	["wh_anc_marius_leitdorf_mothers_ruin"] = 1,
	["wh_anc_aldebrand_ludenhof_beast_slayer"] = 1,
	["wh_anc_edward_van_der_kraal_sea_bride_standard"] = 1,
	["wh_anc_theoderic_gausser_crow_feeder"] = 1,
	["wh_anc_wolfram_hertwig_troll_cleaver"] = 1,
	["emp_oswh_anc_valmir_von_raukov_brain_woundertland"] = 1,
	["wh_anc_alberich_haupt"] = 1,
	["wh_anc_helmut_feuerbach_stone_breaker"] = 1,

	--HIDDEN ITEM--
	["wh2_main_anc_enchanted_item_heart_of_avelorn"] = 1,
	["wh2_main_anc_arcane_item_scroll_of_hoeth"] = 1,
	["wh2_main_anc_arcane_item_moon_staff_of_lileath"] = 1,
	["wh2_main_anc_armour_armour_of_midnight"] = 1,
	["wh2_main_anc_arcane_item_wand_of_the_kharaidon"] = 1,
	["wh2_main_anc_talisman_amber_amulet"] = 1,
	["wh_main_anc_armour_the_lions_shield"] = 1,
	["wh_main_anc_enchanted_item_the_crown_of_bretonnia"] = 1,
	["wh2_dlc10_anc_enchanted_item_the_shadow_crown"] = 1

}


local LORDS_SKILLS = {
	["dlc04_vmp_vlad_con_carstein"] = "wh_dlc04_skill_innate_vmp_vlad_von_carstein"
}

local LEGENDARY_LORDS = {
	----------------
	---- EMPIRE ----
	----------------
	["wh_main_sc_emp_empire"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh_main_emp_empire"
			}
		},
		lords = {
			"dlc03_emp_boris_todbringer",			
			"dlc04_emp_volkmar",
			"emp_balthasar_gelt",
			"emp_karl_franz"
		},
		mixu_lords = {
			"emp_elspeth_von_draken",
			"emp_averland",
			"emp_hochland",
			"emp_marienburg",
			"emp_nordland",
			"emp_ostermark",
			"emp_ostland",
			"emp_stirland",
			--"emp_markus_wulfhart",
			--"emp_alberich_von_korden",
			"emp_talabecland"
		}
	},
	------------------
	---- VAMPIRES ----
	------------------
	["wh_main_sc_vmp_vampire_counts"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh_main_vmp_vampire_counts",
				"wh_main_vmp_schwartzhafen",
				"wh2_dlc11_vmp_the_barrow_legion"
			}
		},
		lords = {
			"dlc04_vmp_helman_ghorst",
			"dlc04_vmp_vlad_con_carstein",
			"pro02_vmp_isabella_von_carstein",
			"vmp_heinrich_kemmler",
			"vmp_mannfred_von_carstein",
			"wh_dlc05_vmp_red_duke"
		}
	},
	----------------
	---- DWARFS ----
	----------------
	["wh_main_sc_dwf_dwarfs"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh_main_dwf_dwarfs",
				"wh_main_dwf_karak_izor",
				"wh_main_dwf_karak_kadrin"
			}
		},
		lords = {
			"dwf_thorgrim_grudgebearer",
			"dwf_ungrim_ironfist",
			"dlc06_dwf_belegar",
			"pro01_dwf_grombrindal"
		},
		mixu_lords = {
			"dwf_karak_azul",
			"dwf_thorek_ironbrow"
			--"dwf_grimm_burloksson"
		}
	},
	--------------------
	---- GREENSKINS ----
	--------------------
	["wh_main_sc_grn_greenskins"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh_main_grn_greenskins",
				"wh_main_grn_crooked_moon",
				"wh_main_grn_orcs_of_the_bloody_hand"
			}
		},
		lords = {
			"dlc06_grn_skarsnik",
			"grn_azhag_the_slaughterer",
			"grn_grimgor_ironhide",
			"dlc06_grn_wurrzag_da_great_prophet"
		},
		mixu_lords = {
			"grn_gorfang_rotgut"
		}
	},
	--------------------
	---- TOMB KINGS ----
	--------------------
	["wh2_dlc09_sc_tmb_tomb_kings"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh2_dlc09_tmb_khemri",
				"wh2_dlc09_tmb_exiles_of_nehek",
				"wh2_dlc09_tmb_lybaras",
				"wh2_dlc09_tmb_followers_of_nagash"
			},
			["wh2_main_great_vortex"] = {
				"wh2_dlc09_tmb_khemri",
				"wh2_dlc09_tmb_exiles_of_nehek",
				"wh2_dlc09_tmb_lybaras",
				"wh2_dlc09_tmb_followers_of_nagash"
			}
		},
		lords = {
			"wh2_dlc09_tmb_arkhan",
			"wh2_dlc09_tmb_khalida",
			"wh2_dlc09_tmb_khatep",
			"wh2_dlc09_tmb_settra"
		},
		mixu_lords = {
			"tmb_tutankhanut"
		}
	},
	--------------------
	---- BRETONNIA -----
	--------------------
	["wh_main_sc_brt_bretonnia"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh_main_brt_bretonnia",
				"wh_main_brt_bordeleaux",
				"wh_main_brt_carcassonne"
			}
		},
		lords = {
			"brt_louen_leoncouer",
			"dlc07_brt_alberic",
			"dlc07_brt_fay_enchantress",
		},
		mixu_lords = {
			"brt_artois",
			"brt_bastonne",
			"brt_lyonesse",
			"brt_parravon",
			"brt_john_tyreweld"
		}
	},
	--------------------
	---- HIGH ELVES ----
	--------------------
	["wh2_main_sc_hef_high_elves"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh2_main_hef_avelorn",
				"wh2_main_hef_eataine",
				"wh2_main_hef_order_of_loremasters",
				"wh2_main_hef_nagarythe"
			},
			["wh2_main_great_vortex"] = {
				"wh2_main_hef_avelorn",
				"wh2_main_hef_eataine",
				"wh2_main_hef_order_of_loremasters",
				"wh2_main_hef_nagarythe"
			}
		},
		lords = {
			"wh2_main_hef_teclis",
			"wh2_main_hef_tyrion",
			"wh2_dlc10_hef_alarielle",
			"wh2_dlc10_hef_alith_anar",
			"wh2_main_hef_prince_alastar"
		},
		mixu_lords = {
			"hef_belannaer",
			--"hef_caradryan",
			"hef_korhil",
			"hef_prince_imrik"
		}
	},
	--------------------
	---- DARK ELVES ----
	--------------------
	["wh2_main_sc_def_dark_elves"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh2_main_def_naggarond",
				"wh2_main_def_har_ganeth",
				"wh2_main_def_cult_of_pleasure",
				"wh2_dlc11_def_the_blessed_dread"
			},
			["wh2_main_great_vortex"] = {
				"wh2_main_def_naggarond",
				"wh2_main_def_har_ganeth",
				"wh2_main_def_cult_of_pleasure",
				"wh2_dlc11_def_the_blessed_dread"
			}
		},
		lords = {
			"wh2_dlc11_def_lokhir",
			"wh2_dlc10_def_crone_hellebron",
			"wh2_main_def_malekith",
			"wh2_main_def_morathi"
		},
		mixu_lords = {
			"def_tullaris_dreadbringer"
		}
	},
	--------------------
	---- LIZARDMEN -----
	--------------------
	["wh2_main_sc_lzd_lizardmen"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh2_main_lzd_hexoatl",
				"wh2_main_lzd_last_defenders"
			},
			["wh2_main_great_vortex"] = {
				"wh2_main_lzd_hexoatl",
				"wh2_main_lzd_last_defenders"
			}
		},
		lords = {
			"wh2_main_lzd_lord_mazdamundi",
			"wh2_main_lzd_kroq_gar"
		},
		mixu_lords = {
			"lzd_gor_rok",
			"lzd_lord_huinitenuchli",
			"lzd_oxyotl",
			"lzd_tetto_eko"
		}
},
	--------------------
	------ SKAVEN ------
	--------------------
	["wh2_main_sc_skv_skaven"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh2_main_skv_clan_mors",
				"wh2_dlc09_skv_clan_rictus",
				"wh2_main_skv_clan_pestilens"
			},
			["wh2_main_great_vortex"] = {
				"wh2_main_skv_clan_mors",
				"wh2_dlc09_skv_clan_rictus",
				"wh2_main_skv_clan_pestilens"
			}
		},
		lords = {
			"wh2_main_skv_lord_skrolk",
			"wh2_dlc09_skv_tretch_craventail",
			"wh2_main_skv_queek_headtaker"
		}
	},
	--------------------
	---- WOOD ELVES ----
	--------------------
	["wh_dlc05_sc_wef_wood_elves"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh_dlc05_wef_argwylon",
				"wh_dlc05_wef_wood_elves"
			},
			["wh2_main_great_vortex"] = {
				"wh_dlc05_wef_argwylon",
				"wh_dlc05_wef_wood_elves"
			}
		},
		lords = {
			"dlc05_wef_durthu",
			"dlc05_wef_orion"
		},
		mixu_lords = {
			"wef_torgovann",
			"wef_naieth_the_prophetess"
		}
	},
	--------------------
	------ NORSCA ------
	--------------------
	["wh_main_sc_nor_norsca"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh_dlc08_nor_norsca",
				"wh_dlc08_nor_wintertooth"
			},
			["wh2_main_great_vortex"] = {
				"wh_dlc08_nor_norsca",
				"wh_dlc08_nor_wintertooth"
			}
		},
		lords = {
			"wh_dlc08_nor_throgg",
			"wh_dlc08_nor_wulfrik"
		},
		mixu_lords = {
			"nor_egil_styrbjorn"
		}
	},
	-----------------------
	---- VAMPIRE COAST ----
	-----------------------
	["wh2_dlc11_sc_cst_vampire_coast"] = {
		playable_factions = {
			["main_warhammer"] = {
				"wh2_dlc11_cst_noctilus",
				"wh2_dlc11_cst_pirates_of_sartosa",
				"wh2_dlc11_cst_the_drowned",
				"wh2_dlc11_cst_vampire_coast"
			},
			["wh2_main_great_vortex"] = {
				"wh2_dlc11_cst_noctilus",
				"wh2_dlc11_cst_pirates_of_sartosa",
				"wh2_dlc11_cst_the_drowned",
				"wh2_dlc11_cst_vampire_coast"
			}
		},
		lords = {
			"wh2_dlc11_cst_aranessa",
			"wh2_dlc11_cst_cylostra",
			"wh2_dlc11_cst_harkon",
			"wh2_dlc11_cst_noctilus"
		}
	}
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Viemzee's logging tool
-----------------------------------------------------------------------------------------------------------------------------------------------------------

function v_log(text)
	ftext = "UNLOCK_LL"
  	local logText = tostring(text)
  	local logContext = tostring(ftext)
  	local logTimeStamp = os.date("%d, %m %Y %X")
  	local popLog = io.open("Viemzee_Log.txt","a")

  	popLog :write(logContext .. ":  "..logText .. "    : [".. logTimeStamp .. "]\n")
  	popLog :flush()
  	popLog :close()
end

function v_refresh_log()
	local logTimeStamp = os.date("%d, %m %Y %X")
	local popLog = io.open("Viemzee_Log.txt","w")

	popLog :write("NEW LOG ["..logTimeStamp.."] \n")
    popLog :flush()
    popLog :close()
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Viemzee's cheating tool
-----------------------------------------------------------------------------------------------------------------------------------------------------------

function v_give_exp(faction_name)
    current_faction = cm:get_faction(faction_name)

    local char_list = current_faction:character_list()

    for i = 0, char_list:num_items() - 1 do
        local current_char = char_list:item_at(i)
        cm:add_agent_experience(cm:char_lookup_str(current_char:cqi()), 66700)
    end
end

function v_give_money(faction_name)
    cm:treasury_mod(faction_name, 50000)
end

function v_cheat()
    if v_debug_mode then
        local playerFaction = cm:get_faction(cm:get_local_faction(true))
        v_give_exp(playerFaction:name())
        v_give_money(playerFaction:name())
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Viemzee's debug tool
-----------------------------------------------------------------------------------------------------------------------------------------------------------

function v_print_character_list(v_faction)
	local char_list = v_faction:character_list()

	for i = 0, char_list:num_items() - 1 do
        local current_char = char_list:item_at(i)
        v_log("viemzee_char")
        v_log("------------")
		v_log(current_char)
	end
end

function v_print_all_faction()
	local faction_list = cm:model():world():faction_list()
    
    v_log("VIEMZEE v_print_all_faction")
    
	for i = 0, faction_list:num_items() - 1 do
		local faction = faction_list:item_at(i)

        v_log("viemzee_faction")
        v_log("---------------")            
        v_log(faction)

        v_print_character_list(faction)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------


local function v_faction_defeated(current_faction)
	v_log("v_faction_defeated start")

    local current_faction_regions = current_faction:region_list()
    local char_list = current_faction:character_list()

	local faction_regions = current_faction_regions:num_items()
	local faction_chars = char_list:num_items()
	local faction_name = current_faction:name()

    if faction_regions == 0 and faction_chars == 0 then
        v_log("faction defeated : " .. faction_name)
        return true
	else
		v_log("faction not defeated : " .. faction_name)
        return false
    end

	v_log("v_faction_defeated end")
end

local function v_ll_available_for_recruitment(lord_subtype, playerFaction)
    v_log("v_ll_available_for_recruitment start")

    local faction_list = cm:model():world():faction_list()
	
    for i = 0, faction_list:num_items() - 1 do
        local current_faction = faction_list:item_at(i)

		local char_list = current_faction:character_list()
		local current_char
		local char_found = false

		for i = 0, char_list:num_items() - 1 do
			current_char = char_list:item_at(i)
			if current_char:character_subtype_key() == lord_subtype then
				char_found = true
				v_log("char found : " .. lord_subtype)
				v_log(current_char)
				--if v_faction_defeated(current_faction) or v_debug_mode then
				if current_faction:is_dead() or v_debug_mode then
					return true
				else
					return false
				end
			end
		end
	end

	if not char_found then
		if LORDS_FACTION[lord_subtype] ~= playerFaction:name() then
			current_faction = cm:get_faction(LORDS_FACTION[lord_subtype])
			v_log(current_faction)
			if current_faction:is_dead() or v_debug_mode then
				return true
			end
		end
    end
end

local function v_add_skill(lord_subtype)
	v_log("v_add_skill")

	local skill_to_add = LORDS_SKILLS[lord_subtype]
	cm:force_add_skill(lord_subtype, skill_to_add)

	--[[
	for i = 1, #LORDS_SKILLS[lord_subtype] do
		v_log("adding skill : " .. LORDS_SKILLS[lord_subtype][i])
		cm:force_add_skill(lord_subtype, LORDS_SKILLS[lord_subtype][i])
	end
	]]
end

local function v_get_capital(current_faction)
    v_log("v_get_capital")

    local region_list = current_faction:region_list()

    for i = 0, region_list:num_items() - 1 do
		local current_region = region_list:item_at(i)
        if current_region:is_province_capital() then
			return current_region
		end
    end
end

local function v_unlock_ll(lord_subtype, current_faction)
	v_log("v_unlock_ll : " .. lord_subtype)

	local fac_name = current_faction:name()

    if not cm:get_saved_value("v_" .. lord_subtype .. "_LL_unlocked") then 
		local asi

		if ART_SET_ID[lord_subtype] == nil then
			asi = ""
		else
			asi = ART_SET_ID[lord_subtype]
		end

		cm:spawn_character_to_pool(fac_name, LORD_FORENAMES[lord_subtype], LORD_FAMILY_NAMES[lord_subtype], "", "", 50, true, "general", lord_subtype, true, asi)    
		cm:set_saved_value("v_" .. lord_subtype .. "_LL_unlocked", true)
		--cm:spawn_character_to_pool(fac_name, LORD_FORENAMES[lord_subtype], LORD_FAMILY_NAMES[lord_subtype], "", "", 50, true, "general", lord_subtype, true, "")    
		
		--[[
		local current_region = v_get_capital(current_faction)
		local current_settlement = current_region:settlement()
		local current_settlement_pos_x = current_settlement:logical_position_x()
		local current_settlement_pos_y = current_settlement:logical_position_y()
			
		
		if lord_subtype == "wh2_dlc11_cst_cylostra" then
			v_log("attempting to spawn damned paladin")
			cm:create_agent(
				fac_name,
				"spy",
				"wh2_dlc11_cst_ghost_paladin",
				current_settlement_pos_x,
				current_settlement_pos_y,
				true,
				function(cqi)
					ov_logut("damned paladin spawnded")
				end
			)

		end
		]]
	
		--v_add_skill(lord_subtype)
		cm:show_message_event(
			fac_name,
			"event_feed_strings_text_title_event_" .. lord_subtype .. "_LL_unlocked",
			"event_feed_strings_text_title_event_" .. lord_subtype .. "_LL_unlocked",
			"event_feed_strings_text_description_event_" .. lord_subtype .. "_LL_unlocked",
			true,
			EVENT_PICS[fac_name]
			)
    end
end

local function v_give_item(current_faction)
	v_log("v_give_item start")

	local char_list = current_faction:character_list()
	local current_char
	local lord_subtype

	for i = 0, char_list:num_items() - 1 do
		current_char = char_list:item_at(i)
		lord_subtype = current_char:character_subtype_key()
		if LORD_FORENAMES[lord_subtype] ~= nil then
			if cm:get_saved_value("v_" .. lord_subtype .. "_LL_unlocked") then
				if LORDS_ITEM[lord_subtype] ~= nil then
					for j = 1, #LORDS_ITEM[lord_subtype] do
						local item_to_give = LORDS_ITEM[lord_subtype][j]
						
						if not cm:get_saved_value("v_" .. lord_subtype .. item_to_give) then 
							if current_char:rank() >= ITEM_REQ[item_to_give] then
								if current_char:faction() ~= LORDS_FACTION[lord_subtype] then
									cm:set_saved_value("v_" .. lord_subtype .. item_to_give, true)
									v_log("adding item " .. item_to_give .. " to : " .. lord_subtype)
									cm:force_add_and_equip_ancillary(lord_subtype, item_to_give)
								end
							end
						end
					end
				end
			end
		end
	end

	v_log("v_give_item end")
end

local function v_set_chaset_character_immortality(current_faction)
	v_log("v_set_chaset_character_immortality")

	local char_list = current_faction:character_list()
	local current_char
	local lord_subtype

	for i = 0, char_list:num_items() - 1 do
		current_char = char_list:item_at(i)
		lord_subtype = current_char:character_subtype_key()
		if LORD_FORENAMES[lord_subtype] ~= nil then
			v_log("set immortality to : " .. lord_subtype)
			cm:set_character_immortality(lord_subtype, true)
		end
	end
end

local function v_check_available_ll()
    local faction_list = cm:model():world():faction_list()
	v_log("v_check_available_ll")
	
	if v_debug_mode then 
		v_cheat()
	end
	
    for i = 0, faction_list:num_items() - 1 do
        local current_faction = faction_list:item_at(i)
		local fac_subculture = current_faction:subculture()
		local fac_name = current_faction:name()

		if current_faction:is_human() == true then
			v_log("human is found : " .. fac_name)
			v_set_chaset_character_immortality(current_faction)
			v_give_item(current_faction)

			--if cm:get_saved_value("v_meta_unlock") then
			--	v_meta_unlock(fac_name)
			--end

			for subculture, data in pairs(LEGENDARY_LORDS) do
				v_log("subculture loop " .. subculture)
				if fac_subculture == subculture then
					v_log("fac_subculture == subculture")
					if LEGENDARY_LORDS[subculture] ~= nil then
						for j = 1, #LEGENDARY_LORDS[subculture].lords do
							v_log("viemzee_check_recruitable_lords : " .. LEGENDARY_LORDS[subculture].lords[j])
							if v_ll_available_for_recruitment(LEGENDARY_LORDS[subculture].lords[j],current_faction) then
								v_log(LEGENDARY_LORDS[subculture].lords[j] .. " is recruitable")
								v_unlock_ll(LEGENDARY_LORDS[subculture].lords[j],current_faction)
							end
						end
						if cm:get_saved_value("v_unlock_all_mixu") then
							for j = 1, #LEGENDARY_LORDS[subculture].mixu_lords do
								v_log("viemzee_check_recruitable_lords : " .. LEGENDARY_LORDS[subculture].mixu_lords[j])
								if v_ll_available_for_recruitment(LEGENDARY_LORDS[subculture].mixu_lords[j],current_faction) then
									v_log(LEGENDARY_LORDS[subculture].mixu_lords[j] .. " is recruitable")
									v_unlock_ll(LEGENDARY_LORDS[subculture].mixu_lords[j],current_faction)
								end
							end
						end
					end
                end
            end
        end
    end
end

--v function(subcultures_factions_table: map<string, vector<string>>)
local function remove_confed_bundles(subcultures_factions_table)
    out("########## REMOVING PENALTIES ##########")
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

function sm0_recruit_defeated()
    core:add_listener(
		"refugee_FactionTurnStart",
		"FactionTurnStart",
		true,
		function()
			local factionList = context:faction():factions_of_same_subculture()
			for i = 0, factionList:num_items() - 1 do
				local currentFaction = factionList:item_at(i)
				out("sm0/currentFaction = "..currentFaction:name())
				if currentFaction:is_dead() and not cm:get_saved_value("took_refuge_"..currentFaction:name()) then
					-- fire dilemma based on currentFaction:diplomatic_standing_with(context:faction():name()) or context:faction():imperium_level()
						-- ai always takes refugees
						-- player option to take or refuse refugee lords
					-- revive faction
					-- force confed
					-- delete force
					-- remove effectbundle
					-- set saved value
				elseif cm:get_saved_value("took_refuge_"..currentFaction:name()) then
					cm:set_saved_value("took_refuge_"..currentFaction:name(), false)
				end
			end
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