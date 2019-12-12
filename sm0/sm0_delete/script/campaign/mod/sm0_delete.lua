--v function()
local function sm0_log_reset()
	if not __write_output_to_logfile then
		return
	end
	local logTimeStamp = os.date("%d, %m %Y %X")
	--# assume logTimeStamp: string
	local popLog = io.open("sm0_log.txt","w+")
	popLog :write("NEW LOG ["..logTimeStamp.."] \n")
	popLog :flush()
	popLog :close()
end

--v function(text: string | number | boolean | CA_CQI)
local function sm0_log(text)
	if not __write_output_to_logfile then
		return
	end
	local logText = tostring(text)
	local logTimeStamp = os.date("%d, %m %Y %X")
	local popLog = io.open("sm0_log.txt","a")
	--# assume logTimeStamp: string
	popLog :write("DEL:  [".. logTimeStamp .. "] [Turn: ".. tostring(cm:turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  "..logText .. "  \n")
	popLog :flush()
	popLog :close()
end

local blacklisted_subtypes = {
	"brt_louen_leoncouer",
	"chs_archaon",
	"chs_kholek_suneater",
	"chs_lord_of_change",
	"chs_prince_sigvald",
	"dlc03_bst_graktar",
	"dlc03_bst_khazrak",
	"dlc03_bst_malagor",
	"dlc03_emp_boris_todbringer",
	"dlc04_emp_volkmar",
	"dlc04_vmp_helman_ghorst",
	"dlc04_vmp_vlad_con_carstein",
	"dlc05_bst_morghur",
	"dlc05_wef_durthu",
	"dlc05_wef_orion",
	"dlc06_dwf_belegar",
	"dlc06_dwf_master_engineer_ghost",
	"dlc06_dwf_runesmith_ghost",
	"dlc06_dwf_thane_ghost_1",
	"dlc06_dwf_thane_ghost_2",
	"dlc06_grn_skarsnik",
	"dlc06_grn_wurrzag_da_great_prophet",
	"dlc07_brt_alberic",
	"dlc07_brt_fay_enchantress",
	"dlc07_brt_green_knight",
	"dlc08_nor_kihar",
	"dwf_thorgrim_grudgebearer",
	"dwf_ungrim_ironfist",
	"emp_balthasar_gelt",
	"emp_karl_franz",
	"grn_azhag_the_slaughterer",
	"grn_grimgor_ironhide",
	"pro01_dwf_grombrindal",
	"pro02_vmp_isabella_von_carstein",
	"vmp_heinrich_kemmler",
	"vmp_mannfred_von_carstein",
	"wh_dlc05_vmp_red_duke",
	--"wh_dlc08_bst_cygor_boss",
	"wh_dlc08_chs_challenger_khorne",
	"wh_dlc08_chs_challenger_nurgle",
	"wh_dlc08_chs_challenger_slaanesh",
	"wh_dlc08_chs_challenger_tzeentch",
	--"wh_dlc08_chs_dragon_ogre_shaggoth_boss",
	--"wh_dlc08_grn_giant_boss",
	--"wh_dlc08_grn_venom_queen_boss",
	"wh_dlc08_nor_arzik",
	--"wh_dlc08_nor_frost_wyrm_boss",
	"wh_dlc08_nor_throgg",
	"wh_dlc08_nor_wulfrik",
	--"wh_dlc08_vmp_terrorgheist_boss",
	--"wh_dlc08_wef_forest_dragon_boss",
	"wh2_dlc09_skv_tretch_craventail",
	"wh2_dlc09_tmb_arkhan",
	"wh2_dlc09_tmb_khalida",
	"wh2_dlc09_tmb_khatep",
	"wh2_dlc09_tmb_necrotect_ritual",
	"wh2_dlc09_tmb_settra",
	"wh2_dlc09_tmb_tomb_king_alkhazzar_ii",
	"wh2_dlc09_tmb_tomb_king_lahmizzash",
	"wh2_dlc09_tmb_tomb_king_rakhash",
	"wh2_dlc09_tmb_tomb_king_setep",
	"wh2_dlc09_tmb_tomb_king_thutep",
	"wh2_dlc09_tmb_tomb_king_wakhaf",
	"wh2_dlc10_def_crone_hellebron",
	"wh2_dlc10_hef_alarielle",
	"wh2_dlc10_hef_alith_anar",
	--"wh2_dlc10_lzd_mon_carnosaur_boss",
	--"wh2_dlc10_nor_phoenix_flamespyre_boss",
	"wh2_dlc11_cst_admiral_tech_01",
	"wh2_dlc11_cst_admiral_tech_02",
	"wh2_dlc11_cst_admiral_tech_03",
	"wh2_dlc11_cst_admiral_tech_04",
	"wh2_dlc11_cst_aranessa",
	"wh2_dlc11_cst_cylostra",
	"wh2_dlc11_cst_harkon",
	"wh2_dlc11_cst_noctilus",
	"wh2_dlc11_cst_ghost_paladin",
	"wh2_dlc11_def_lokhir",
	--"wh2_dlc11_vmp_bloodline_blood_dragon",
	--"wh2_dlc11_vmp_bloodline_lahmian",
	--"wh2_dlc11_vmp_bloodline_necrarch",
	--"wh2_dlc11_vmp_bloodline_strigoi",
	--"wh2_dlc11_vmp_bloodline_von_carstein",
	"wh2_dlc12_lzd_lord_kroak",
	--"wh2_dlc12_lzd_lord_kroak_boss",
	"wh2_dlc12_lzd_red_crested_skink_chief_legendary",
	"wh2_dlc12_lzd_tehenhauin",
	"wh2_dlc12_lzd_tiktaqto",
	"wh2_dlc12_skv_ikit_claw",
	"wh2_dlc13_emp_cha_markus_wulfhart_0",
	"wh2_dlc13_emp_hunter_doctor_hertwig_van_hal",
	"wh2_dlc13_emp_hunter_jorek_grimm",
	"wh2_dlc13_emp_hunter_kalara_of_wydrioth",
	"wh2_dlc13_emp_hunter_rodrik_l_anguille",
	"wh2_dlc13_lzd_gor_rok",
	"wh2_dlc13_lzd_nakai",
	--"wh2_dlc13_lzd_slann_mage_priest_fire",
	--"wh2_dlc13_lzd_slann_mage_priest_fire_horde",
	--"wh2_dlc13_lzd_slann_mage_priest_high",
	--"wh2_dlc13_lzd_slann_mage_priest_high_horde",
	--"wh2_dlc13_lzd_slann_mage_priest_life",
	--"wh2_dlc13_lzd_slann_mage_priest_life_horde",
	"wh2_main_def_black_ark",
	"wh2_main_def_malekith",
	"wh2_main_def_morathi",
	"wh2_main_hef_prince_alastar",
	"wh2_main_hef_teclis",
	"wh2_main_hef_tyrion",
	"wh2_main_lzd_kroq_gar",
	"wh2_main_lzd_lord_mazdamundi",
	--"wh2_main_lzd_slann_mage_priest",
	--"wh2_main_lzd_slann_mage_priest_horde",
	"wh2_main_skv_lord_skrolk",
	"wh2_main_skv_plague_priest_ritual",
	"wh2_main_skv_queek_headtaker",
	--"wh2_main_skv_warlock_engineer_ritual",
	"wh2_pro08_neu_felix",
	"wh2_pro08_neu_gotrek",
	--mixu1
	"brt_almaric_de_gaudaron",
	"brt_chilfroy",
	"brt_bohemond",
	"brt_adalhard",
	"brt_cassyon",
	"bst_taurox",
	"dwf_kazador_dragonslayer",
	"dwf_thorek_ironbrow",
	"emp_alberich_von_korden",
	"emp_marius_leitdorf",
	"mixu_elspeth_von_draken",
	"emp_aldebrand_ludenhof",
	"emp_luthor_huss",
	"emp_edward_van_der_kraal",
	"emp_theoderic_gausser",
	"emp_wolfram_hertwig",
	"emp_valmir_von_raukov",
	"emp_alberich_haupt_anderssen",
	"emp_helmut_feuerbach",
	"emp_theodore_bruckner",
	"emp_vorn_thugenheim",
	"mixu_katarin_the_ice_queen",
	"wef_drycha",
	"wef_daith",
	"emp_alberich_von_korden_hero",
	--mixu2
	"def_kouran_darkhand",
	"lzd_chakax",
	"hef_belannaer",
	"hef_caradryan",
	"def_tullaris_dreadbringer",
	"lzd_tetto_eko",
	"hef_korhil",
	"brt_donna_don_domingio",
	"brt_john_tyreweld",
	"hef_prince_imrik",
	"hef_caradryan_hero",
	"dwf_grimm_burloksson",
	"lzd_lord_huinitenuchli",
	"def_tullaris_hero",
	"chs_egrimm_van_horstmann",
	"wef_naieth_the_prophetess",
	"nor_egil_styrbjorn",
	"nor_bloodfather_ritual",
	"grn_gorfang_rotgut",
	"lzd_oxyotl",
	"tmb_ramhotep",
	"tmb_tutankhanut",
	"chs_lord_of_change_egrimm",
	"bst_ghorros_warhoof",
	"bst_gorehoof",
	"skv_feskit",
	--XOUDAD High Elves Expanded--
	"wh2_main_hef_eltharion",
	--XOUDAD Valten
	"wax_emp_valten",
    --CATAPH TEB--
    "teb_borgio_the_besiege",
    "teb_tilea",
    "teb_lucrezzia_belladonna",
    "teb_gashnag",
    "teb_border_princes",
    "teb_estalia",
    "teb_new_world_colonies",
    "teb_colombo",
    --CATAPH Kraka Drak--
	"dwf_kraka_drak",
	--CATAPH Hobo--
	"AK_hobo_nameless",
	"AK_hobo_draesca",
	"AK_hobo_priestess",
    --Project Resurrection - Parte Legendary Lords--
    "def_rakarth",
    "skv_skweel_gnawtooth",
    "def_hag_queen_malida",
    "hef_aislinn",
    "dwf_byrrnoth_grundadrakk",
    "dwf_rorek_granitehand",
    "dwf_alrik_ranulfsson",
    --We'z Speshul--
    "spcha_grn_borgut_facebeater",
    "spcha_grn_grokka_goreaxe",
    "spcha_grn_tinitt_foureyes",
    "spcha_grn_grak_beastbasha",
    "spcha_grn_duffskul",
	"spcha_grn_snagla_grobspit",
    --Whysofurious' Additional Lords & Heroes--
    "genevieve",
    "helsnicht",
    "konrad",
    "mallobaude",
    --"sycamo",
    "zacharias",
    --Ordo Draconis - Templehof Expanded--
	"abhorash",
    "vmp_walach_harkon_hero",
    "tib_kael",
    --WsF' Vampire Bloodlines: The Strigoi--
    "ushoran",
    "vorag",
    "str_high_priest",
    "nanosh",
    --OvN Second Start--
    "sr_grim",
    --OvN Lost Factions - Beta--
    "ovn_hlf_ll",
    "ovn_araby_ll",
    "Sultan_Jaffar",
	"morgan_bernhardt",
	--Empire Master Engineer
	"wh_main_emp_jubal_falk",
	--Cataph Sea Patrol
	"AK_aislinn"
} --:vector<string>

local immortal_subtypes = {
	"wh2_main_hef_prince_alastar",
	"wh2_dlc11_vmp_bloodline_blood_dragon",
	"wh2_dlc11_vmp_bloodline_lahmian",
	"wh2_dlc11_vmp_bloodline_necrarch",
	"wh2_dlc11_vmp_bloodline_strigoi",
	"wh2_dlc11_vmp_bloodline_von_carstein",
	"wh2_dlc09_tmb_tomb_king_alkhazzar_ii",
	"wh2_dlc09_tmb_tomb_king_lahmizzash",
	"wh2_dlc09_tmb_tomb_king_rakhash",
	"wh2_dlc09_tmb_tomb_king_setep",
	"wh2_dlc09_tmb_tomb_king_thutep",
	"wh2_dlc09_tmb_tomb_king_wakhaf",
	--"wh2_dlc11_cst_ghost_paladin",
	"wh2_dlc11_cst_admiral_tech_01",
	"wh2_dlc11_cst_admiral_tech_02",
	"wh2_dlc11_cst_admiral_tech_03",
	"wh2_dlc11_cst_admiral_tech_04",
	--"dlc06_dwf_master_engineer_ghost",
	--"dlc06_dwf_runesmith_ghost",
	--"dlc06_dwf_thane_ghost_1",
	--"dlc06_dwf_thane_ghost_2"
} --:vector<string>

--v function(uic: CA_UIC)
local function delete_UIC(uic)
    local root = core:get_ui_root()
    root:CreateComponent("Garbage", "UI/campaign ui/script_dummy")
    local component = root:Find("Garbage")
    local garbage = UIComponent(component)
    garbage:Adopt(uic:Address())
    garbage:DestroyChildren()
end

--v function()
local function create_trash_ui()
	local player_faction = cm:get_faction(cm:get_local_faction(true)) 

	local trash_bin_button_disabled = effect.get_localised_string("trash_bin_button_disabled_"..player_faction:culture()) 
	if not trash_bin_button_disabled then trash_bin_button_disabled = "No Lords or Heroes selected for execution." end
	local trash_bin_button_hover_1 = effect.get_localised_string("trash_bin_button_hover_1_"..player_faction:culture()) 
	if not trash_bin_button_hover_1 then trash_bin_button_hover_1 = "Are you sure you want to execute all (" end
	local trash_bin_button_hover_2 = effect.get_localised_string("trash_bin_button_hover_2_"..player_faction:culture()) 
	if not trash_bin_button_hover_2 then trash_bin_button_hover_2 = ") selected Lords/Heroes?" end
	local check_trash_button_hover_1 = effect.get_localised_string("check_trash_button_hover_1_"..player_faction:culture()) 
	if not check_trash_button_hover_1 then check_trash_button_hover_1 = "Execute all (" end
	local check_trash_button_hover_2 = effect.get_localised_string("check_trash_button_hover_2_"..player_faction:culture()) 
	if not check_trash_button_hover_2 then check_trash_button_hover_2 = ") selected Lords/Heroes!" end
	local check_trash_button_disabled = effect.get_localised_string("check_trash_button_disabled_"..player_faction:culture()) 
	if not check_trash_button_disabled then check_trash_button_disabled = "No Lords or Heroes selected." end
	local checkbox_toggle_lord_hover = effect.get_localised_string("checkbox_toggle_lord_hover_"..player_faction:culture()) 
	if not checkbox_toggle_lord_hover then checkbox_toggle_lord_hover = "Select Lord for Execution." end
	local checkbox_toggle_lord_selected_hover = effect.get_localised_string("checkbox_toggle_lord_selected_hover_"..player_faction:culture()) 
	if not checkbox_toggle_lord_selected_hover then checkbox_toggle_lord_selected_hover = "Lord selected for Execution." end
	local checkbox_toggle_hero_hover = effect.get_localised_string("checkbox_toggle_hero_hover_"..player_faction:culture()) 
	if not checkbox_toggle_hero_hover then checkbox_toggle_hero_hover = "Select Hero for Execution." end
	local checkbox_toggle_hero_selected_hover = effect.get_localised_string("checkbox_toggle_hero_selected_hover_"..player_faction:culture()) 
	if not checkbox_toggle_hero_selected_hover then checkbox_toggle_hero_selected_hover = "Hero selected for Execution." end
	local checkbox_toggle_lord_disabled = effect.get_localised_string("checkbox_toggle_lord_disabled_"..player_faction:culture()) 
	if not checkbox_toggle_lord_disabled then checkbox_toggle_lord_disabled = "This Lord can't be executed." end
	local checkbox_toggle_hero_disabled = effect.get_localised_string("checkbox_toggle_hero_disabled_"..player_faction:culture())
	if not checkbox_toggle_hero_disabled then checkbox_toggle_hero_disabled = "This Hero can't be executed." end
	local cross_trash_button_hover = effect.get_localised_string("cross_trash_button_hover_"..player_faction:culture()) 
	if not cross_trash_button_hover then cross_trash_button_hover = "Cancel." end

	local list_box = find_uicomponent(core:get_ui_root(),"layout", "radar_things", "dropdown_parent", "units_dropdown", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
	local units_dropdown = find_uicomponent(core:get_ui_root(),"layout", "radar_things", "dropdown_parent", "units_dropdown")
	if units_dropdown:Find("trash_bin_button") then 
		local trash_bin_button = UIComponent(units_dropdown:Find("trash_bin_button"))
		delete_UIC(trash_bin_button)
		core:remove_listener("sm0_trash_bin_button")
	end
	if units_dropdown:Find("cross_trash_button") then 
		local cross_trash_button = UIComponent(units_dropdown:Find("cross_trash_button"))
		delete_UIC(cross_trash_button)
		core:remove_listener("sm0_cross_trash_button")
	end
	if units_dropdown:Find("check_trash_button") then 
		local check_trash_button = UIComponent(units_dropdown:Find("check_trash_button"))
		delete_UIC(check_trash_button)
		core:remove_listener("sm0_check_trash_button")
	end
	local reference_title = find_uicomponent(core:get_ui_root(),"layout", "radar_things", "dropdown_parent", "units_dropdown", "panel", "tx_title")
	local sort_type = find_uicomponent(core:get_ui_root(),"layout", "radar_things", "dropdown_parent", "units_dropdown", "panel", "panel_clip", "sortable_list_units", "headers", "sort_type")
	local sort_type_W, sort_type_H = sort_type:Bounds()
	local sort_type_X, sort_type_Y = sort_type:Position()
	units_dropdown:CreateComponent("trash_bin_button", "ui/templates/square_medium_button")
	local trash_bin_button = UIComponent(units_dropdown:Find("trash_bin_button"))
	reference_title:Adopt(trash_bin_button:Address())
	trash_bin_button:PropagatePriority(units_dropdown:Priority())
	trash_bin_button:Resize(sort_type_W * 1.5, sort_type_W * 1.5)
	local trash_bin_button_W, trash_bin_button_H = trash_bin_button:Bounds()
	trash_bin_button:MoveTo(sort_type_X + sort_type_W / 2 - trash_bin_button_W / 2, sort_type_Y + sort_type_H / 2 - trash_bin_button_H - trash_bin_button_H / 2 - 4)
	if string.find(player_faction:culture(), "wh2_") then 
		trash_bin_button:SetImagePath("ui/skins/warhammer2/icon_delete.png") 
	else
		trash_bin_button:SetImagePath("ui/skins/default/icon_delete.png")
	end
	local trash_bin_button_X, trash_bin_button_Y = trash_bin_button:Position()
	--trash_bin_button:SetState("hover")
	--trash_bin_button:SetTooltipText("Execute selected Lords and Heroes.")
	--trash_bin_button:SetState("active")
	trash_bin_button:SetDisabled(true)
	trash_bin_button:SetOpacity(50)
	trash_bin_button:SetTooltipText(trash_bin_button_disabled)

	for i = 0, list_box:ChildCount() - 1 do
		local character_row = UIComponent(list_box:Find(i))
		local character_row_len = string.len("character_row_")
		local cqi_string = string.sub(character_row:Id(), character_row_len + 1) 
		--sm0_log("sm0/cqi: "..tostring(cqi_string))
		local reference_uic = find_uicomponent(character_row, "indent_parent", "icon_wounded")
		local reference_uic_W, reference_uic_H = reference_uic:Bounds()
		local reference_uic_X, reference_uic_Y = reference_uic:Position()
		if character_row:Find("checkbox_toggle_"..cqi_string) then 
			local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
			delete_UIC(checkbox_toggle)
			core:remove_listener("sm0_checkbox_toggle_"..cqi_string)
		end
		character_row:CreateComponent("checkbox_toggle_"..cqi_string, "ui/templates/checkbox_toggle")
		local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
		character_row:Adopt(checkbox_toggle:Address())
		checkbox_toggle:PropagatePriority(reference_uic:Priority())
		checkbox_toggle:SetCanResizeHeight(true)
		checkbox_toggle:SetCanResizeWidth(true)
		checkbox_toggle:Resize(trash_bin_button_W, trash_bin_button_H)
		local checkbox_toggle_W, checkbox_toggle_H = checkbox_toggle:Bounds()
		checkbox_toggle:MoveTo(reference_uic_X - reference_uic_W - 2, reference_uic_Y + reference_uic_H / 2 - checkbox_toggle_H / 2)
		core:add_listener(
			"sm0_checkbox_toggle_"..cqi_string,
			"ComponentLClickUp",
			function(context)
				return context.string == "checkbox_toggle_"..cqi_string
			end,
			function(context)
				local chars_selected = 0
				local list_box = find_uicomponent(core:get_ui_root(),"layout", "radar_things", "dropdown_parent", "units_dropdown", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
				for i = 0, list_box:ChildCount() - 1 do
					local character_row = UIComponent(list_box:Find(i))
					local character_row_len = string.len("character_row_")
					local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
					local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
					if checkbox_toggle:CurrentState() == "selected" or checkbox_toggle:CurrentState() == "selected_hover" or checkbox_toggle:CurrentState() == "down" then	
						chars_selected = chars_selected + 1
					end
				end
				if units_dropdown:Find("check_trash_button") then 
					local check_trash_button = UIComponent(units_dropdown:Find("check_trash_button"))
					if chars_selected >= 1 then
						check_trash_button:SetDisabled(false)
						check_trash_button:SetOpacity(255)
						check_trash_button:SetState("hover")
						check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2)
						check_trash_button:SetState("active")
					else
						check_trash_button:SetDisabled(true)
						check_trash_button:SetOpacity(50)
						check_trash_button:SetTooltipText(check_trash_button_disabled)
					end
				end
				if units_dropdown:Find("trash_bin_button") then 
					local trash_bin_button = UIComponent(units_dropdown:Find("trash_bin_button"))
					if chars_selected >= 1 then
						trash_bin_button:SetDisabled(false)
						trash_bin_button:SetOpacity(255)
						trash_bin_button:SetState("hover")
						trash_bin_button:SetTooltipText(trash_bin_button_hover_1..chars_selected..trash_bin_button_hover_2)
						trash_bin_button:SetState("active")
					else
						trash_bin_button:SetDisabled(true)
						trash_bin_button:SetOpacity(50)
						trash_bin_button:SetTooltipText(trash_bin_button_disabled)
					end
				end
			end,
			true
		)	
		--#assume cqi_string: CA_CQI
		local char = cm:get_character_by_cqi(cqi_string)
		checkbox_toggle:SetState("hover")
		if cm:char_is_general(char) then 
			checkbox_toggle:SetTooltipText(checkbox_toggle_lord_hover) 
			checkbox_toggle:SetState("selected_hover")
			checkbox_toggle:SetTooltipText(checkbox_toggle_lord_selected_hover)
		else
			checkbox_toggle:SetTooltipText(checkbox_toggle_hero_hover) 
			checkbox_toggle:SetState("selected_hover")
			checkbox_toggle:SetTooltipText(checkbox_toggle_hero_selected_hover)
		end
		checkbox_toggle:SetState("active")
		checkbox_toggle:SetDisabled(false)
		checkbox_toggle:SetOpacity(255)
		for _, subtype in ipairs(blacklisted_subtypes) do
			if char:character_subtype(subtype) then
				checkbox_toggle:SetDisabled(true)
				checkbox_toggle:SetOpacity(150)
				if cm:char_is_general(char) then 
					checkbox_toggle:SetTooltipText(checkbox_toggle_lord_disabled)
				else
					checkbox_toggle:SetTooltipText(checkbox_toggle_hero_disabled)
				end
			end
		end
	end
	core:add_listener(
		"sm0_trash_bin_button",
		"ComponentLClickUp",
		function(context)
			return context.string == "trash_bin_button"
		end,
		function(context)
			local trash_bin_button = UIComponent(units_dropdown:Find("trash_bin_button"))
			trash_bin_button:SetVisible(false)
			if not units_dropdown:Find("cross_trash_button") then
				units_dropdown:CreateComponent("cross_trash_button", "ui/templates/square_medium_button")
				local cross_trash_button = UIComponent(units_dropdown:Find("cross_trash_button"))
				reference_title:Adopt(cross_trash_button:Address())
				cross_trash_button:PropagatePriority(units_dropdown:Priority())
				cross_trash_button:Resize(trash_bin_button_W, trash_bin_button_H)
				cross_trash_button:MoveTo(trash_bin_button_X, trash_bin_button_Y)
				if string.find(player_faction:culture(), "wh2_") then 
					cross_trash_button:SetImagePath("ui/skins/warhammer2/icon_cross.png") 
				else
					cross_trash_button:SetImagePath("ui/skins/default/icon_cross.png")
				end
				cross_trash_button:SetState("hover")
				cross_trash_button:SetTooltipText(cross_trash_button_hover)
				cross_trash_button:SetState("active")
				core:add_listener(
					"sm0_cross_trash_button",
					"ComponentLClickUp",
					function(context)
						return context.string == "cross_trash_button"
					end,
					function(context)
						local cross_trash_button = UIComponent(units_dropdown:Find("cross_trash_button"))
						local check_trash_button = UIComponent(units_dropdown:Find("check_trash_button"))
						local trash_bin_button = UIComponent(units_dropdown:Find("trash_bin_button"))
						if cross_trash_button then cross_trash_button:SetVisible(false) end
						if check_trash_button then check_trash_button:SetVisible(false) end
						if trash_bin_button then trash_bin_button:SetVisible(true) end
					end,
					true
				)
			end
			if not units_dropdown:Find("check_trash_button") then
				units_dropdown:CreateComponent("check_trash_button", "ui/templates/square_medium_button")
				local check_trash_button = UIComponent(units_dropdown:Find("check_trash_button"))
				reference_title:Adopt(check_trash_button:Address())
				check_trash_button:PropagatePriority(units_dropdown:Priority())
				check_trash_button:Resize(trash_bin_button_W, trash_bin_button_H)
				local check_trash_button_X, check_trash_button_Y = check_trash_button:Bounds()
				check_trash_button:MoveTo(trash_bin_button_X + trash_bin_button_W + 2, trash_bin_button_Y)
				if string.find(player_faction:culture(), "wh2_") then 
					check_trash_button:SetImagePath("ui/skins/warhammer2/icon_check.png") 
				else
					check_trash_button:SetImagePath("ui/skins/default/icon_check.png")
				end
				local chars_selected = 0
				local list_box = find_uicomponent(core:get_ui_root(),"layout", "radar_things", "dropdown_parent", "units_dropdown", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
				for i = 0, list_box:ChildCount() - 1 do
					local character_row = UIComponent(list_box:Find(i))
					local character_row_len = string.len("character_row_")
					local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
					local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
					if checkbox_toggle:CurrentState() == "selected" or checkbox_toggle:CurrentState() == "selected_hover" or checkbox_toggle:CurrentState() == "down" then	
						chars_selected = chars_selected + 1
					end
				end
				if chars_selected >= 1 then
					check_trash_button:SetDisabled(false)
					check_trash_button:SetOpacity(255)
					check_trash_button:SetState("hover")
					check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2)
					check_trash_button:SetState("active")
				else
					check_trash_button:SetDisabled(true)
					check_trash_button:SetOpacity(50)
					check_trash_button:SetTooltipText(check_trash_button_disabled)
				end

				core:add_listener(
					"sm0_check_trash_button",
					"ComponentLClickUp",
					function(context)
						return context.string == "check_trash_button"
					end,
					function(context)
						--cm:autosave_at_next_opportunity()
						local list_box = find_uicomponent(core:get_ui_root(),"layout", "radar_things", "dropdown_parent", "units_dropdown", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
						for i = 0, list_box:ChildCount() - 1 do
							local character_row = UIComponent(list_box:Find(i))
							local character_row_len = string.len("character_row_")
							local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
							local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
							if checkbox_toggle:CurrentState() == "selected" then												
								--sm0_log("sm0/cqi: "..cqi_string)
								local cqi = tonumber(cqi_string)
								--#assume cqi: CA_CQI
								local char_lookup = cm:char_lookup_str(cqi)
								local char = cm:get_character_by_cqi(cqi)
								local is_blacklisted = false
								for _, subtype in ipairs(blacklisted_subtypes) do
									if char:character_subtype(subtype) then
										is_blacklisted = true
										break
									end
								end
								if not is_blacklisted then CampaignUI.TriggerCampaignScriptEvent(cqi, "sm0_delete|") end
							end
						end
						local cross_trash_button = UIComponent(units_dropdown:Find("cross_trash_button"))
						local check_trash_button = UIComponent(units_dropdown:Find("check_trash_button"))
						local trash_bin_button = UIComponent(units_dropdown:Find("trash_bin_button"))
						if cross_trash_button then cross_trash_button:SetVisible(false) end
						if check_trash_button then check_trash_button:SetVisible(false) end
						if trash_bin_button then trash_bin_button:SetVisible(true) end
					end,
					true
				)
			end
			local cross_trash_button = UIComponent(units_dropdown:Find("cross_trash_button"))
			local check_trash_button = UIComponent(units_dropdown:Find("check_trash_button"))
			if cross_trash_button then cross_trash_button:SetVisible(true) end
			if check_trash_button then check_trash_button:SetVisible(true) end
		end,
		true
	)
end

--v function()
function sm0_delete()
	core:add_listener(
		"units_dropdown_PanelOpenedCampaign",
		"PanelOpenedCampaign",
		function(context)		
			return true --appoint_new_general
		end,
		function(context)
			--sm0_log("sm0/PanelOpenedCampaign: "..context.string)
			cm:callback(function() 
				local tab_units = find_uicomponent(core:get_ui_root(),"layout", "bar_small_top", "TabGroup", "tab_units")
				if tab_units and (tab_units:CurrentState() == "selected" or tab_units:CurrentState() == "selected_hover" or tab_units:CurrentState() == "selected_down" 
				or tab_units:CurrentState() == "down") then 
					--sm0_log("sm0/tab_units|state: "..tostring(tab_units:CurrentState())) 
					create_trash_ui()
				else
					--sm0_log("sm0/tab_units|state: disabled")
				end	
			end, 0.1) 						
		end,
		true
	)
	core:add_listener(
		"units_dropdown_PanelClosedCampaign",
		"PanelClosedCampaign",
		function(context)		
			return true --appoint_new_general
		end,
		function(context)
			--sm0_log("sm0/PanelClosedCampaign: "..context.string)
			cm:callback(function() 
				local tab_units = find_uicomponent(core:get_ui_root(),"layout", "bar_small_top", "TabGroup", "tab_units")
				if tab_units and (tab_units:CurrentState() == "selected" or tab_units:CurrentState() == "selected_hover" or tab_units:CurrentState() == "selected_down"
				or tab_units:CurrentState() == "down") then 
					--sm0_log("sm0/tab_units|state: "..tostring(tab_units:CurrentState())) 
					create_trash_ui()
				else
					--sm0_log("sm0/tab_units|state: disabled")
				end	
			end, 0.1) 						
		end,
		true
	)
	core:add_listener(
		"units_dropdown_ComponentLClickUp",
		"ComponentLClickUp",
		function(context)
			return context.string == "tab_units"
		end,
		function(context)
			--sm0_log("sm0/ComponentLClickUp: "..context.string)
			cm:callback(function() 
				local tab_units = find_uicomponent(core:get_ui_root(),"layout", "bar_small_top", "TabGroup", "tab_units")
				if tab_units and (tab_units:CurrentState() == "selected" or tab_units:CurrentState() == "selected_hover" or tab_units:CurrentState() == "selected_down") then 
					--sm0_log("sm0/tab_units|state: "..tostring(tab_units:CurrentState())) 
					create_trash_ui()
				else
					--sm0_log("sm0/tab_units|state: disabled")
				end	
			end, 0.1) 	
		end,
		true
	)
	-- Multiplayer listener
    core:add_listener(
        "sm0_delete_UITriggerScriptEvent",
        "UITriggerScriptEvent",
        function(context)
            return context:trigger():starts_with("sm0_delete|")
        end,
		function(context)
			local char_lookup = cm:char_lookup_str(context:faction_cqi())
			sm0_log("sm0_delete_UITriggerScriptEvent | set_character_immortality = false | "..char_lookup)
			cm:set_character_immortality(char_lookup, false)
            cm:kill_character(context:faction_cqi(), false, true)
        end,
        true
    )
	-- immortality skill
	core:add_listener(
		"sm0_immortal_CharacterSkillPointAllocated",
		"CharacterSkillPointAllocated",
		function(context)
			return context:skill_point_spent_on() == "wh2_dlc09_skill_tmb_hidden_king_title"
			or context:skill_point_spent_on() == "mixu_tmb_liche_high_priest_hidden_title"
			or context:skill_point_spent_on() == "wh2_dlc09_skill_tmb_tomb_king_elixir_of_immortality"
			or context:skill_point_spent_on() == "wh2_main_skill_all_immortality_hero"
			or context:skill_point_spent_on() == "wh2_main_skill_all_immortality_lord"
			or context:skill_point_spent_on() == "wh_main_skill_dwf_slayer_self_immortality"
		end,
		function(context)
			sm0_log("sm0_immortal_CharacterSkillPointAllocated | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key())
			cm:set_character_immortality(cm:char_lookup_str(context:character()), true)
		end,
		true
	)
	core:add_listener(
		"sm0_immortal_skill_CharacterCreated",
		"CharacterCreated",
		function(context)
			return context:character():has_skill("wh2_dlc09_skill_tmb_hidden_king_title")
			or context:character():has_skill("wh2_dlc09_skill_tmb_tomb_king_elixir_of_immortality") 
			or context:character():has_skill("mixu_tmb_liche_high_priest_hidden_title")
			or context:character():has_skill("wh2_main_skill_all_immortality_hero") 
			or context:character():has_skill("wh2_main_skill_all_immortality_lord") 
			or context:character():has_skill("wh_main_skill_dwf_slayer_self_immortality") 
		end,
		function(context)
			for _, agent_subtype in pairs(immortal_subtypes) do
				if agent_subtype == context:character():character_subtype_key() then
					sm0_log("sm0_immortal_skill_CharacterCreated | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key())
					cm:set_character_immortality(cm:char_lookup_str(context:character()), true)
				end
			end
		end,
		true
	)
	-- turn 1 immortality
	core:add_listener(
		"sm0_immortal_FactionTurnStart",
		"FactionTurnStart",
		function(context)
			local human_factions = cm:get_human_factions()
			return cm:turn_number() == 1 and context:faction():is_human() and human_factions[1] == context:faction():name()
		end,
		function(context)
			local faction_list = cm:model():world():faction_list()
            for i = 0, faction_list:num_items() - 1 do
				local current_faction = faction_list:item_at(i)
				local character_list = current_faction:character_list()
				for j = 0, character_list:num_items() - 1 do
					local current_char = character_list:item_at(j)
					if current_char:has_skill("wh2_dlc09_skill_tmb_hidden_king_title")
					or current_char:has_skill("wh2_dlc09_skill_tmb_tomb_king_elixir_of_immortality") 
					or current_char:has_skill("mixu_tmb_liche_high_priest_hidden_title")
					or current_char:has_skill("wh2_main_skill_all_immortality_hero") 
					or current_char:has_skill("wh2_main_skill_all_immortality_lord") 
					or current_char:has_skill("wh_main_skill_dwf_slayer_self_immortality") then
						sm0_log("sm0_immortal_FactionTurnStart | set_character_immortality = true | "..current_char:faction():name().." | "..current_char:character_subtype_key())
						cm:set_character_immortality(cm:char_lookup_str(current_char), true)
					end
				end
			end
		end,
		true
	)
	-- immortality tech
	core:add_listener(
		"sm0_immortal_tech_ResearchCompleted",
		"ResearchCompleted",
		function(context)
			return context:faction():name() == "wh2_dlc13_lzd_spirits_of_the_jungle" or context:faction():subculture() == "wh_main_sc_nor_norsca"
		end,
		function(context)
			if context:technology() == "tech_dlc08_nor_nw_03" or context:technology() == "tech_dlc13_lzd_vassal_2" then	
				local char_list = context:faction():character_list()
				for i = 0, char_list:num_items() - 1 do
					local char = char_list:item_at(i)
					if cm:char_is_agent(char) then 
						sm0_log("sm0_immortal_tech_ResearchCompleted | set_character_immortality = true | "..context:faction():name().." | "..char:character_subtype_key())
						cm:set_character_immortality(cm:char_lookup_str(char), true) 	
					end
				end
			end
			if context:technology() == "tech_dlc08_nor_nw_11" then	
				local char_list = context:faction():character_list()
				for i = 0, char_list:num_items() - 1 do
					local char = char_list:item_at(i)
					if cm:char_is_general(char) then 
						sm0_log("sm0_immortal_tech_ResearchCompleted | set_character_immortality = true | "..context:faction():name().." | "..char:character_subtype_key())
						cm:set_character_immortality(cm:char_lookup_str(char), true) 
					end
				end			
			end
		end,
		true
	)
	core:add_listener(
		"sm0_immortal_tech_CharacterCreated",
		"CharacterCreated",
		function(context)
			return context:character():faction():name() == "wh2_dlc13_lzd_spirits_of_the_jungle" or context:character():faction():subculture() == "wh_main_sc_nor_norsca"
		end,
		function(context)
			if cm:char_is_agent(context:character()) and (context:character():faction():has_technology("tech_dlc08_nor_nw_03") or context:character():faction():has_technology("tech_dlc13_lzd_vassal_2")) then	
				sm0_log("sm0_immortal_tech_CharacterCreated | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key())
				cm:set_character_immortality(cm:char_lookup_str(context:character()), true)
			end
			if cm:char_is_general(context:character()) and context:character():faction():has_technology("tech_dlc08_nor_nw_11") then	
				sm0_log("sm0_immortal_tech_CharacterCreated | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key())
				cm:set_character_immortality(cm:char_lookup_str(context:character()), true)
			end
		end,
		true
	)
	core:add_listener(
		"sm0_immortal_tech_FactionJoinsConfederation",
		"FactionJoinsConfederation",
		function(context)
			return context:confederation():name() == "wh2_dlc13_lzd_spirits_of_the_jungle" or context:confederation():subculture() == "wh_main_sc_nor_norsca"
		end,
		function(context)
			if context:confederation():has_technology("tech_dlc08_nor_nw_03") or context:confederation():has_technology("tech_dlc13_lzd_vassal_2") then	
				local char_list = context:confederation():character_list()
				for i = 0, char_list:num_items() - 1 do
					local char = char_list:item_at(i)
					if cm:char_is_agent(char) then 
						sm0_log("sm0_immortal_tech_FactionJoinsConfederation | set_character_immortality = true | "..context:confederation():name().." | "..char:character_subtype_key())
						cm:set_character_immortality(cm:char_lookup_str(char), true) 
					end
				end
			end
			if context:confederation():has_technology("tech_dlc08_nor_nw_11") then	
				local char_list = context:confederation():character_list()
				for i = 0, char_list:num_items() - 1 do
					local char = char_list:item_at(i)
					if cm:char_is_general(char) then 
						sm0_log("sm0_immortal_tech_FactionJoinsConfederation | set_character_immortality = true | "..context:confederation():name().." | "..char:character_subtype_key())
						cm:set_character_immortality(cm:char_lookup_str(char), true) 
					end
				end			
			end
		end,
		true
	)	
	-- immortality vow
	core:add_listener(
		"sm0_immortal_ScriptEventBretonniaGrailVowCompleted",
		"ScriptEventBretonniaGrailVowCompleted",
		true,
		function(context)
			if context:character():faction():is_human() then	
				sm0_log("sm0_immortal_ScriptEventBretonniaGrailVowCompleted | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key())
				cm:set_character_immortality(cm:char_lookup_str(context:character()), true)
			end
		end,
		true
	)	
	core:add_listener(
		"sm0_immortal_character_rank_up_vows_per_level_ai",
		"CharacterRankUp",
		true,
		function(context)
			local character = context:character()
			if not character:faction():is_human() and character:faction():culture() == "wh_main_brt_bretonnia" then
				if character:character_type("general") == true then
					if character:rank() >= 10 then
						sm0_log("sm0_immortal_character_rank_up_vows_per_level_ai | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key())
						cm:set_character_immortality(cm:char_lookup_str(character), true)
					end
				end
			end
		end,
		true
	)
	core:add_listener(
		"sm0_immortal_character_created_bret_ai",
		"CharacterCreated",
		true,
		function(context)
			local character = context:character()
			if not character:faction():is_human() and character:faction():culture() == "wh_main_brt_bretonnia" then
				if character:character_type("general") == true then
					if character:rank() >= 10 then
						sm0_log("sm0_immortal_character_created_bret_ai | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key())
						cm:set_character_immortality(cm:char_lookup_str(character), true)
					end
				end
			end
		end,
		true
	)
	-- ex faction leader after confederation
	--core:add_listener(
	--	"sm0_immortal_FactionLeader_FactionJoinsConfederation",
	--	"FactionJoinsConfederation",
	--	true,
	--	function(context)
	--		local char_list = context:confederation():character_list()
	--		for i = 0, char_list:num_items() - 1 do
	--			local char = char_list:item_at(i)
	--			if cm:char_is_agent(char) then cm:set_character_immortality(cm:char_lookup_str(char), true) end
	--		end
	--	end,
	--	true
	--)	
end