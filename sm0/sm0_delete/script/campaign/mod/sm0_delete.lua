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
	popLog :write("DEL:  [".. logTimeStamp .. "] [Turn: ".. tostring(cm:model():turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  "..logText .. "  \n")
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
	"wh2_dlc11_vmp_bloodline_blood_dragon",
	"wh2_dlc11_vmp_bloodline_lahmian",
	"wh2_dlc11_vmp_bloodline_necrarch",
	"wh2_dlc11_vmp_bloodline_strigoi",
	"wh2_dlc11_vmp_bloodline_von_carstein",
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
	--"wh2_main_def_black_ark",
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
	"wh2_dlc14_brt_henri_le_massif",
	"wh2_dlc14_brt_repanse",
	"wh2_dlc14_def_malus_darkblade",
	"wh2_dlc14_skv_deathmaster_snikch",
	"wh2_dlc15_hef_imrik",
	"wh2_dlc15_hef_eltharion",
	"wh2_dlc15_grn_grom_the_paunch",
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
	"hef_bloodline_caradryan",
	"def_tullaris_dreadbringer",
	"def_tullaris_hero",
	"lzd_tetto_eko",
	"hef_korhil",
	"brt_donna_don_domingio",
	"brt_john_tyreweld",
	"hef_caradryan_hero",
	"dwf_bloodline_grimm_burloksson",
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
	"chs_aekold_helbrass",
	"chs_azubhor_clawhand",
	--XOUDAD High Elves Expanded--
	--
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
	"AK_aislinn",
	--Mixu's: Vangheist's Revenge
	"cst_vangheist",
	"cst_bloodline_the_white_death",
	"cst_bloodline_tia_drowna",
	"cst_bloodline_dreng_gunddadrak",
	"cst_bloodline_khoskog",
	-- bug fixes
	--"wh2_dlc09_tmb_tomb_king",
	--"tmb_liche_high_priest_death",
	--"tmb_liche_high_priest_light",
	--"tmb_liche_high_priest_nehekhara",
	--"tmb_liche_high_priest_shadow"
} --:vector<string>

local immortal_subtypes = {
	"wh2_main_hef_prince_alastar",
	"wh2_dlc11_vmp_bloodline_blood_dragon",
	"wh2_dlc11_vmp_bloodline_lahmian",
	"wh2_dlc11_vmp_bloodline_necrarch",
	"wh2_dlc11_vmp_bloodline_strigoi",
	"wh2_dlc11_vmp_bloodline_von_carstein",
	--"wh2_dlc09_tmb_tomb_king_alkhazzar_ii",
	--"wh2_dlc09_tmb_tomb_king_lahmizzash",
	--"wh2_dlc09_tmb_tomb_king_rakhash",
	--"wh2_dlc09_tmb_tomb_king_setep",
	--"wh2_dlc09_tmb_tomb_king_thutep",
	--"wh2_dlc09_tmb_tomb_king_wakhaf",
	"wh2_dlc11_cst_admiral_tech_01",
	"wh2_dlc11_cst_admiral_tech_02",
	"wh2_dlc11_cst_admiral_tech_03",
	"wh2_dlc11_cst_admiral_tech_04",
	--Covered by turn 1 listener
	--"dlc06_dwf_master_engineer_ghost",
	--"dlc06_dwf_runesmith_ghost",
	--"dlc06_dwf_thane_ghost_1",
	--"dlc06_dwf_thane_ghost_2",
	--"wh2_dlc11_cst_ghost_paladin",
	--"wh2_dlc09_tmb_tomb_king",
	----mixu
	--"tmb_liche_high_priest_death",
	--"tmb_liche_high_priest_light",
	--"tmb_liche_high_priest_nehekhara",
	--"tmb_liche_high_priest_shadow"
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

--v function() --> CA_CQI
local function get_selected_char_CQI()
    local charCQI = cm:get_campaign_ui_manager():get_char_selected_cqi()
    local char = cm:get_character_by_cqi(charCQI)
    if char:has_military_force() then
        local unitsUIC = find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "units")
        for i = 0, unitsUIC:ChildCount() - 1 do
            local uic_child = UIComponent(unitsUIC:Find(i))
            if uic_child:CurrentState() == "Selected" and string.find(uic_child:Id(), "Agent") then
                local charList = char:military_force():character_list()
                local agentIndex = string.match(uic_child:Id(), "%d")
                local selectedChar = charList:item_at(tonumber(agentIndex))
                charCQI = selectedChar:command_queue_index()
                break
            end     
        end
    end
    return charCQI
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
		core:remove_listener("sm0_delete_trash_bin_button_ComponentLClickUp")
	end
	if units_dropdown:Find("cross_trash_button") then 
		local cross_trash_button = UIComponent(units_dropdown:Find("cross_trash_button"))
		delete_UIC(cross_trash_button)
		core:remove_listener("sm0_delete_cross_trash_button_ComponentLClickUp")
	end
	if units_dropdown:Find("check_trash_button") then 
		local check_trash_button = UIComponent(units_dropdown:Find("check_trash_button"))
		delete_UIC(check_trash_button)
		core:remove_listener("sm0_delete_check_trash_button_ComponentLClickUp")
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
	trash_bin_button:SetTooltipText(trash_bin_button_disabled, "", false) 

	for i = 0, list_box:ChildCount() - 1 do
		local character_row = UIComponent(list_box:Find(i))
		local character_row_len = string.len("character_row_")
		local cqi_string = string.sub(character_row:Id(), character_row_len + 1) 
		--sm0_log("sm0/cqi: "..tostring(cqi_string))
		local reference_uic = find_uicomponent(character_row, "indent_parent", "soldiers")
		local reference_uic_W, reference_uic_H = reference_uic:Bounds()
		local reference_uic_X, reference_uic_Y = reference_uic:Position()
		local reference_uic_2 = find_uicomponent(character_row, "indent_parent", "icon_wounded") 
		local reference_uic_2_X, reference_uic_2_Y = reference_uic_2:Position()

		if character_row:Find("checkbox_toggle_"..cqi_string) then 
			local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
			delete_UIC(checkbox_toggle)
			core:remove_listener("sm0_delete_checkbox_toggle_"..cqi_string.."_ComponentLClickUp")
		end
		character_row:CreateComponent("checkbox_toggle_"..cqi_string, "ui/templates/checkbox_toggle")
		local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
		character_row:Adopt(checkbox_toggle:Address())
		checkbox_toggle:PropagatePriority(reference_uic:Priority())
		checkbox_toggle:SetCanResizeHeight(true)
		checkbox_toggle:SetCanResizeWidth(true)
		checkbox_toggle:Resize(trash_bin_button_W, trash_bin_button_H)
		local checkbox_toggle_W, checkbox_toggle_H = checkbox_toggle:Bounds()
		checkbox_toggle:MoveTo(reference_uic_X + reference_uic_W / 2 - checkbox_toggle_W / 2 - 5, reference_uic_2_Y + reference_uic_H/2 + 1)
		reference_uic:MoveTo(reference_uic_X, reference_uic_2_Y - reference_uic_H/2 - 1)

		core:add_listener(
			"sm0_delete_checkbox_toggle_"..cqi_string.."_ComponentLClickUp",
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
						check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2, "", false) 
						check_trash_button:SetState("active")
					else
						check_trash_button:SetDisabled(true)
						check_trash_button:SetOpacity(50)
						check_trash_button:SetTooltipText(check_trash_button_disabled, "", false) 
					end
				end
				if units_dropdown:Find("trash_bin_button") then 
					local trash_bin_button = UIComponent(units_dropdown:Find("trash_bin_button"))
					if chars_selected >= 1 then
						trash_bin_button:SetDisabled(false)
						trash_bin_button:SetOpacity(255)
						trash_bin_button:SetState("hover")
						trash_bin_button:SetTooltipText(trash_bin_button_hover_1..chars_selected..trash_bin_button_hover_2, "", false) 
						trash_bin_button:SetState("active")
					else
						trash_bin_button:SetDisabled(true)
						trash_bin_button:SetOpacity(50)
						trash_bin_button:SetTooltipText(trash_bin_button_disabled, "", false) 
					end
				end
			end,
			true
		)	
		--#assume cqi_string: CA_CQI
		local char = cm:get_character_by_cqi(cqi_string)
		checkbox_toggle:SetState("hover")
		if cm:char_is_general(char) then 
			checkbox_toggle:SetTooltipText(checkbox_toggle_lord_hover, "", false) 
			checkbox_toggle:SetState("selected_hover")
			checkbox_toggle:SetTooltipText(checkbox_toggle_lord_selected_hover, "", false) 
		else
			checkbox_toggle:SetTooltipText(checkbox_toggle_hero_hover, "", false) 
			checkbox_toggle:SetState("selected_hover")
			checkbox_toggle:SetTooltipText(checkbox_toggle_hero_selected_hover, "", false) 
		end
		checkbox_toggle:SetState("active")
		checkbox_toggle:SetDisabled(false)
		checkbox_toggle:SetOpacity(255)
		for _, subtype in ipairs(blacklisted_subtypes) do
			if char:character_subtype(subtype) then
				checkbox_toggle:SetDisabled(true)
				checkbox_toggle:SetOpacity(150)
				if cm:char_is_general(char) then 
					checkbox_toggle:SetTooltipText(checkbox_toggle_lord_disabled, "", false) 
				else
					checkbox_toggle:SetTooltipText(checkbox_toggle_hero_disabled, "", false) 
				end
			end
		end
	end
	core:add_listener(
		"sm0_delete_trash_bin_button_ComponentLClickUp",
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
				cross_trash_button:SetTooltipText(cross_trash_button_hover, "", false) 
				cross_trash_button:SetState("active")
				core:add_listener(
					"sm0_delete_cross_trash_button_ComponentLClickUp",
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
					check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2, "", false) 
					check_trash_button:SetState("active")
				else
					check_trash_button:SetDisabled(true)
					check_trash_button:SetOpacity(50)
					check_trash_button:SetTooltipText(check_trash_button_disabled, "", false) 
				end

				core:add_listener(
					"sm0_delete_check_trash_button_ComponentLClickUp",
					"ComponentLClickUp",
					function(context)
						return context.string == "check_trash_button"
					end,
					function(context)
						--cm:autosave_at_next_opportunity()
						local delay = 0.1
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
								if not is_blacklisted then 
									cm:callback(function()
										CampaignUI.TriggerCampaignScriptEvent(cqi, "sm0_delete|")
									end, delay)
								end
								delay = delay + 0.1
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
	if cm:is_new_game() and not cm:get_saved_value("sm0_log_reset") then
		sm0_log_reset()
		cm:set_saved_value("sm0_log_reset", true)
	end

	-- TESTCODE: Use CharacterConvalescedOrKilled/stop_character_convalescing bug to delete characters
	-- multiplayer listener
    core:add_listener(
        "sm0_delete_UITriggerScriptEvent",
        "UITriggerScriptEvent",
        function(context)
            return context:trigger():starts_with("sm0_delete|")
        end,
		function(context)
			local cqi = context:faction_cqi()
			local char_lookup = cm:char_lookup_str(cqi)
			local character = cm:get_character_by_cqi(cqi)
			cm:disable_event_feed_events(true, "", "", "character_ready_for_duty")
			sm0_log("sm0_delete_UITriggerScriptEvent | "..char_lookup)
			core:add_listener(
				"sm0_delete_CharacterConvalescedOrKilled",
				"CharacterConvalescedOrKilled",
				function(context)
					return true 
				end,
					function(context)
					sm0_log("sm0_delete_CharacterConvalescedOrKilled | "..char_lookup)
					cm:stop_character_convalescing(cqi)
					cm:callback(function() cm:disable_event_feed_events(false, "", "", "character_ready_for_duty") end, 10)
				end,
				false
			)
			cm:kill_character(cqi, false, true)
        end,
        true
	)
	--TESTCODE: end

	core:add_listener(
		"sm0_delete_units_dropdown_PanelOpenedCampaign",
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
		"sm0_delete_units_dropdown_PanelClosedCampaign",
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
		"sm0_delete_units_dropdown_ComponentLClickUp",
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
	
	--[[
	if not cm:get_saved_value("sm0_immortal_count") then cm:set_saved_value("sm0_immortal_count", 0) end
	-- multiplayer listener
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
			cm:set_saved_value("sm0_immortal_cqi"..context:faction_cqi(), false)
			cm:kill_character(context:faction_cqi(), false, true)
			--cm:kill_character_and_commanded_unit(char_lookup, false, true)
        end,
        true
    )
	-- immortality skill
	core:add_listener(
		"sm0_delete_immortal_CharacterSkillPointAllocated",
		"CharacterSkillPointAllocated",
		function(context)
			return (context:skill_point_spent_on() == "wh2_dlc09_skill_tmb_hidden_king_title"
			or context:skill_point_spent_on() == "mixu_tmb_liche_high_priest_hidden_title"
			or context:skill_point_spent_on() == "wh2_dlc09_skill_tmb_tomb_king_elixir_of_immortality"
			or context:skill_point_spent_on() == "wh2_main_skill_all_immortality_hero"
			or context:skill_point_spent_on() == "wh2_main_skill_all_immortality_lord"
			or context:skill_point_spent_on() == "wh_main_skill_dwf_slayer_self_immortality")
			and not cm:get_saved_value("sm0_immortal_cqi"..context:character():command_queue_index())
		end,
		function(context)
			if not cm:char_is_general(context:character()) then cm:set_character_immortality(cm:char_lookup_str(context:character()), true) end
			cm:set_saved_value("sm0_immortal_cqi"..context:character():command_queue_index(), true)
			cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
			sm0_log("sm0_immortal_CharacterSkillPointAllocated | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key()
			.." | "..context:character():command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
		end,
		true
	)
	core:add_listener(
		"sm0_delete_immortal_skill_CharacterCreated",
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
				if agent_subtype == context:character():character_subtype_key() and not cm:get_saved_value("sm0_immortal_cqi"..context:character():command_queue_index()) then
					--cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
					if not cm:char_is_general(context:character()) then cm:set_character_immortality(cm:char_lookup_str(context:character()), true) end
					--end, 0.5)
					cm:set_saved_value("sm0_immortal_cqi"..context:character():command_queue_index(), true)
					cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
					sm0_log("sm0_immortal_skill_CharacterCreated | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key()
					.." | "..context:character():command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
				end
			end
		end,
		true
	)
	-- turn 1 immortality
	core:add_listener(
		"sm0_delete_immortal_FactionTurnStart",
		"FactionTurnStart",
		function(context)
			local human_factions = cm:get_human_factions()
			return cm:model():turn_number() == 1 and context:faction():is_human() and human_factions[1] == context:faction():name()
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
					or current_char:has_skill("wh_main_skill_dwf_slayer_self_immortality") 
					and not cm:get_saved_value("sm0_immortal_cqi"..current_char:command_queue_index()) then
						if not cm:char_is_general(current_char) then cm:set_character_immortality(cm:char_lookup_str(current_char), true) end
						cm:set_saved_value("sm0_immortal_cqi"..current_char:command_queue_index(), true)
						cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
						sm0_log("sm0_immortal_FactionTurnStart | set_character_immortality = true | "..current_char:faction():name().." | "..current_char:character_subtype_key()
						.." | "..current_char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
					end
				end
			end
		end,
		true
	)
	-- immortality tech
	core:add_listener(
		"sm0_delete_immortal_tech_ResearchCompleted",
		"ResearchCompleted",
		function(context)
			return context:faction():name() == "wh2_dlc13_lzd_spirits_of_the_jungle" or context:faction():subculture() == "wh_main_sc_nor_norsca"
		end,
		function(context)
			if context:technology() == "tech_dlc08_nor_nw_03" or context:technology() == "tech_dlc13_lzd_vassal_2" then	
				local char_list = context:faction():character_list()
				for i = 0, char_list:num_items() - 1 do
					local char = char_list:item_at(i)
					if cm:char_is_agent(char) and not cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
						if not cm:char_is_general(char) then cm:set_character_immortality(cm:char_lookup_str(char), true) end
						cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), true)
						cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1) 	
						sm0_log("sm0_immortal_tech_ResearchCompleted | set_character_immortality = true | "..context:faction():name().." | "..char:character_subtype_key()
						.." | "..char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
					end
				end
			end
			if context:technology() == "tech_dlc08_nor_nw_11" then	
				local char_list = context:faction():character_list()
				for i = 0, char_list:num_items() - 1 do
					local char = char_list:item_at(i)
					if cm:char_is_general(char) and not cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
						if not cm:char_is_general(char) then cm:set_character_immortality(cm:char_lookup_str(char), true) end
						cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), true)
						cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
						sm0_log("sm0_immortal_tech_ResearchCompleted | set_character_immortality = true | "..context:faction():name().." | "..char:character_subtype_key()
						.." | "..char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
					end
				end			
			end
		end,
		true
	)
	core:add_listener(
		"sm0_delete_immortal_tech_CharacterCreated",
		"CharacterCreated",
		function(context)
			return context:character():faction():name() == "wh2_dlc13_lzd_spirits_of_the_jungle" or context:character():faction():subculture() == "wh_main_sc_nor_norsca"
		end,
		function(context)
			if cm:char_is_agent(context:character()) and (context:character():faction():has_technology("tech_dlc08_nor_nw_03") or context:character():faction():has_technology("tech_dlc13_lzd_vassal_2")) and not cm:get_saved_value("sm0_immortal_cqi"..context:character():command_queue_index()) then
				--cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
				cm:set_character_immortality(cm:char_lookup_str(context:character()), true)
				--end, 0.5)
				cm:set_saved_value("sm0_immortal_cqi"..context:character():command_queue_index(), true)
				cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
				sm0_log("sm0_immortal_tech_CharacterCreated | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key()
				.." | "..context:character():command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
			end
			if cm:char_is_general(context:character()) and context:character():faction():has_technology("tech_dlc08_nor_nw_11") and not cm:get_saved_value("sm0_immortal_cqi"..context:character():command_queue_index()) then
				--cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
				--if not cm:char_is_general(context:character()) then cm:set_character_immortality(cm:char_lookup_str(context:character()), true) end
				--end, 0.5)
				cm:set_saved_value("sm0_immortal_cqi"..context:character():command_queue_index(), true)
				cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
				sm0_log("sm0_immortal_tech_CharacterCreated | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key()
				.." | "..context:character():command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
			end
		end,
		true
	)
	core:add_listener(
		"sm0_delete_immortal_tech_FactionJoinsConfederation",
		"FactionJoinsConfederation",
		function(context)
			return context:confederation():name() == "wh2_dlc13_lzd_spirits_of_the_jungle" or context:confederation():subculture() == "wh_main_sc_nor_norsca"
		end,
		function(context)
			if context:confederation():has_technology("tech_dlc08_nor_nw_03") or context:confederation():has_technology("tech_dlc13_lzd_vassal_2") then	
				local char_list = context:confederation():character_list()
				for i = 0, char_list:num_items() - 1 do
					local char = char_list:item_at(i)
					if cm:char_is_agent(char) and not cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
						if not cm:char_is_general(char) then cm:set_character_immortality(cm:char_lookup_str(char), true) end
						cm:set_saved_value("sm0_immortal_cqi"..char():command_queue_index(), true)
						cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
						sm0_log("sm0_immortal_tech_FactionJoinsConfederation | set_character_immortality = true | "..context:confederation():name().." | "..char:character_subtype_key()
						.." | "..char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
					end
				end
			end
			if context:confederation():has_technology("tech_dlc08_nor_nw_11") then	
				local char_list = context:confederation():character_list()
				for i = 0, char_list:num_items() - 1 do
					local char = char_list:item_at(i)
					if cm:char_is_general(char) and not cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
						if not cm:char_is_general(char) then cm:set_character_immortality(cm:char_lookup_str(char), true) end
						cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), true)
						cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
						sm0_log("sm0_immortal_tech_FactionJoinsConfederation | set_character_immortality = true | "..context:confederation():name().." | "..char:character_subtype_key()
						.." | "..char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
					end
				end			
			end
		end,
		true
	)	
	-- immortality vow
	core:add_listener(
		"sm0_delete_immortal_ScriptEventBretonniaGrailVowCompleted",
		"ScriptEventBretonniaGrailVowCompleted",
		true,
		function(context)
			if context:character():faction():is_human() and not cm:get_saved_value("sm0_immortal_cqi"..context:character():command_queue_index()) then	
				if not cm:char_is_general(context:character()) then cm:set_character_immortality(cm:char_lookup_str(context:character()), true) end
				cm:set_saved_value("sm0_immortal_cqi"..context:character():command_queue_index(), true)
				cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
				sm0_log("sm0_immortal_ScriptEventBretonniaGrailVowCompleted | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key()
				.." | "..context:character():command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
			end
		end,
		true
	)	
	core:add_listener(
		"sm0_delete_immortal_character_rank_up_vows_per_level_ai_CharacterRankUp",
		"CharacterRankUp",
		true,
		function(context)
			local character = context:character()
			if not character:faction():is_human() and character:faction():culture() == "wh_main_brt_bretonnia" then
				if character:character_type("general") == true then
					if character:rank() >= 10 and not cm:get_saved_value("sm0_immortal_cqi"..character:command_queue_index()) then
						cm:set_saved_value("sm0_immortal_cqi"..character:command_queue_index(), true)
						cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
						sm0_log("sm0_immortal_character_rank_up_vows_per_level_ai | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key()
						.." | "..character:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
					end
				end
			end
		end,
		true
	)
	core:add_listener(
		"sm0_delete_immortal_character_created_bret_ai_CharacterCreated",
		"CharacterCreated",
		true,
		function(context)
			local character = context:character()
			if not character:faction():is_human() and character:faction():culture() == "wh_main_brt_bretonnia" then
				if character:character_type("general") == true then
					if character:rank() >= 10 and not cm:get_saved_value("sm0_immortal_cqi"..character:command_queue_index()) then
						cm:set_saved_value("sm0_immortal_cqi"..character:command_queue_index(), true)
						cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
						sm0_log("sm0_immortal_character_created_bret_ai | set_character_immortality = true | "..context:character():faction():name().." | "..context:character():character_subtype_key()
						.." | "..context:character():command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
					end
				end
			end
		end,
		true
	)
	-- immortality vow (paladin)
	core:add_listener(
		"sm0_delete_immortal_IncidentOccuredEvent",
		"IncidentOccuredEvent",
		true,
		function(context)
			local incident = context:dilemma()
			if incident == "wh_dlc07_incident_brt_vow_gained" then
				local faction = context:faction()
				local char_list = context:faction():character_list()
				for i = 0, char_list:num_items() - 1 do
					local char = char_list:item_at(i)
					if char:character_subtype("brt_paladin") and not cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) 
					and char:trait_points("wh_dlc07_trait_brt_grail_vow_valour_pledge_agent") == 6 then
						cm:set_character_immortality(cm:char_lookup_str(char), true) 
						cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), true)
						cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
						sm0_log("IncidentOccuredEvent: wh_dlc07_incident_brt_vow_gained | set_character_immortality = true | "..context:faction():name().." | "..char:character_subtype_key()
						.." | "..char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
					end
				end
			end
		end,
		true
	)
	-- ex faction leader after confederation
	--core:add_listener(
	--	"sm0_delete_immortal_FactionLeader_FactionJoinsConfederation",
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


	-- new
	core:add_listener(
		"sm0_delete_immortal_changes_FactionTurnStart",
		"FactionTurnStart",
		true,
		function(context)
			-- previous faction
			local prev_faction_name = cm:get_saved_value("sm0_faction_name")
			cm:set_saved_value("sm0_faction_name", context:faction():name())
			local prev_faction = cm:get_faction(prev_faction_name)
			if is_faction(prev_faction) then
				local character_list = prev_faction:character_list()
				for i = 0, character_list:num_items() - 1 do
					local current_char = character_list:item_at(i)
					if cm:char_is_general(current_char)	and cm:get_saved_value("sm0_immortal_cqi"..current_char:command_queue_index()) then
						cm:set_character_immortality(cm:char_lookup_str(current_char), true)
						--cm:set_saved_value("sm0_immortal_cqi"..current_char:command_queue_index(), true)
						--cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
						--sm0_log("sm0_mortal_FactionTurnStart | set_character_immortality = true | "..current_char:faction():name().." | "..current_char:character_subtype_key()
						--.." | "..current_char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
					end
				end
			end
			-- current faction
			local character_list = context:faction():character_list() --:CA_CHAR_LIST
			for i = 0, character_list:num_items() - 1 do
				local current_char = character_list:item_at(i)
				if cm:char_is_general(current_char)	and cm:get_saved_value("sm0_immortal_cqi"..current_char:command_queue_index()) then
					cm:set_character_immortality(cm:char_lookup_str(current_char), false)
					--cm:set_saved_value("sm0_immortal_cqi"..current_char:command_queue_index(), true)
					--cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
					--sm0_log("sm0_mortal_FactionTurnStart | set_character_immortality = true | "..current_char:faction():name().." | "..current_char:character_subtype_key()
					--.." | "..current_char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
				end
			end
		end,
		true
	)
	-- pre battle: enable immortality if eligible
	core:add_listener(
		"sm0_delete_immortal_changes_PendingBattle",
		"PendingBattle",
		true,
		function(context)
			local pb = context:pending_battle() --:CA_PENDING_BATTLE
			local current_faction_name = cm:whose_turn_is_it()
			local attacker = pb:attacker()
			local defender = pb:defender()
			if attacker:faction():name() == current_faction_name then
				if cm:char_is_general(attacker)	and cm:get_saved_value("sm0_immortal_cqi"..attacker:command_queue_index()) then
					cm:set_character_immortality(cm:char_lookup_str(attacker), true)
					sm0_log("sm0_immortal_changes_PendingBattle | set_character_immortality = true | "..attacker:faction():name().." | "..attacker:character_subtype_key()
						.." | "..attacker:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
				end
			elseif defender:faction():name() == current_faction_name then 
				if cm:char_is_general(defender) and cm:get_saved_value("sm0_immortal_cqi"..defender:command_queue_index()) then
					cm:set_character_immortality(cm:char_lookup_str(defender), true)
					sm0_log("sm0_immortal_changes_PendingBattle | set_character_immortality = true | "..defender:faction():name().." | "..defender:character_subtype_key()
						.." | "..defender:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
				end
			end
			local attackers = pb:secondary_attackers()
			for i = 0, attackers:num_items() - 1 do
				local current_attacker = attackers:item_at(i)
				if is_character(current_attacker) and cm:char_is_general(current_attacker) and current_attacker:faction():name() == current_faction_name 
				and cm:get_saved_value("sm0_immortal_cqi"..current_attacker:command_queue_index()) then
					cm:set_character_immortality(cm:char_lookup_str(current_attacker), true)
					sm0_log("sm0_immortal_changes_PendingBattle | set_character_immortality = true | "..current_attacker:faction():name().." | "..current_attacker:character_subtype_key()
						.." | "..current_attacker:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
				end
			end
			local defenders = pb:secondary_defenders()
			for i = 0, defenders:num_items() - 1 do
				local current_defender = defenders:item_at(i)
				if is_character(current_defender) and cm:char_is_general(current_defender) and current_defender:faction():name() == current_faction_name 
				and cm:get_saved_value("sm0_immortal_cqi"..current_defender:command_queue_index()) then
					cm:set_character_immortality(cm:char_lookup_str(current_defender), true)
					sm0_log("sm0_immortal_changes_PendingBattle | set_character_immortality = true | "..current_defender:faction():name().." | "..current_defender:character_subtype_key()
						.." | "..current_defender:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
				end
			end
		end,
		true
	)
	-- post battle: disable immortality
	core:add_listener(
		"sm0_delete_immortal_changes_BattleCompleted",
		"BattleCompleted",
		true,
		function()			
			local num_attackers = cm:pending_battle_cache_num_attackers()
			local num_defenders = cm:pending_battle_cache_num_defenders()
			for i = 1, num_attackers do
				local current_char_cqi, current_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i)
				local current_char = cm:get_character_by_cqi(current_char_cqi)
				if is_character(current_char) and cm:char_is_general(current_char)	and current_faction_name == current_faction_name and cm:get_saved_value("sm0_immortal_cqi"..current_char_cqi) then
					cm:set_character_immortality(cm:char_lookup_str(current_char_cqi), false)
					sm0_log("sm0_immortal_changes_BattleCompleted | set_character_immortality = false | "..current_char:faction():name().." | "..current_char:character_subtype_key()
						.." | "..current_char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
				end
			end
			for i = 1, num_defenders do
				local current_char_cqi, current_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i)
				local current_char = cm:get_character_by_cqi(current_char_cqi)
				if is_character(current_char) and cm:char_is_general(current_char)	and current_faction_name == current_faction_name and cm:get_saved_value("sm0_immortal_cqi"..current_char_cqi) then
					cm:set_character_immortality(cm:char_lookup_str(current_char_cqi), false)
					sm0_log("sm0_immortal_changes_BattleCompleted | set_character_immortality = false | "..current_char:faction():name().." | "..current_char:character_subtype_key()
						.." | "..current_char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
				end
			end
		end,
		true
	)
	-- skill point reset
	core:add_listener(
		"sm0_delete_skill_reset_ComponentLClickUp",
		"ComponentLClickUp",
		function(context)
			local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
			return context.string == "button_stats_reset" and is_uicomponent(panel)
		end,
		function(context)
			local selected_char_cqi = get_selected_char_CQI()
			local selected_char = cm:get_character_by_cqi(selected_char_cqi)
			cm:callback(function(context)
				if selected_char:has_skill("wh2_dlc09_skill_tmb_hidden_king_title")
				or selected_char:has_skill("wh2_dlc09_skill_tmb_tomb_king_elixir_of_immortality") 
				or selected_char:has_skill("mixu_tmb_liche_high_priest_hidden_title")
				or selected_char:has_skill("wh2_main_skill_all_immortality_hero") 
				or selected_char:has_skill("wh2_main_skill_all_immortality_lord") 
				or selected_char:has_skill("wh_main_skill_dwf_slayer_self_immortality")  then
					if not cm:char_is_general(selected_char) then cm:set_character_immortality(cm:char_lookup_str(selected_char), true) end
					cm:set_saved_value("sm0_immortal_cqi"..selected_char:command_queue_index(), true)
					--cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
					sm0_log("button_stats_reset | set_character_immortality = true | "..selected_char:faction():name().." | "..selected_char:character_subtype_key()
					.." | "..selected_char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
				else
					if not cm:char_is_general(selected_char) then cm:set_character_immortality(cm:char_lookup_str(selected_char), false) end
					cm:set_saved_value("sm0_immortal_cqi"..selected_char:command_queue_index(), false)
					cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") - 1)
					sm0_log("button_stats_reset | set_character_immortality = false | "..selected_char:faction():name().." | "..selected_char:character_subtype_key()
					.." | "..selected_char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
				end
			end, 0.1)
		end,
		true
	)
	core:add_listener(
		"sm0_delete_llrRespec_UITriggerScriptEvent",
		"UITriggerScriptEvent",
		function(context)
			return context:trigger() == "LegendaryLordRespec"
		end,
		function(context)
			local cqi = context:faction_cqi() --: CA_CQI
			local selected_char = cm:get_character_by_cqi(cqi)
			if selected_char:has_skill("wh2_dlc09_skill_tmb_hidden_king_title")
			or selected_char:has_skill("wh2_dlc09_skill_tmb_tomb_king_elixir_of_immortality") 
			or selected_char:has_skill("mixu_tmb_liche_high_priest_hidden_title")
			or selected_char:has_skill("wh2_main_skill_all_immortality_hero") 
			or selected_char:has_skill("wh2_main_skill_all_immortality_lord") 
			or selected_char:has_skill("wh_main_skill_dwf_slayer_self_immortality")  then
				if not cm:char_is_general(selected_char) then cm:set_character_immortality(cm:char_lookup_str(selected_char), true) end
				cm:set_saved_value("sm0_immortal_cqi"..selected_char:command_queue_index(), true)
				--cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") + 1)
				sm0_log("LegendaryLordRespec | set_character_immortality = true | "..selected_char:faction():name().." | "..selected_char:character_subtype_key()
				.." | "..selected_char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
			else
				if not cm:char_is_general(selected_char) then cm:set_character_immortality(cm:char_lookup_str(selected_char), false) end
				cm:set_saved_value("sm0_immortal_cqi"..selected_char:command_queue_index(), false)
				cm:set_saved_value("sm0_immortal_count", cm:get_saved_value("sm0_immortal_count") - 1)
				sm0_log("LegendaryLordRespec | set_character_immortality = false | "..selected_char:faction():name().." | "..selected_char:character_subtype_key()
				.." | "..selected_char:command_queue_index().." | sm0_immortal_count = "..cm:get_saved_value("sm0_immortal_count"))
			end
		end,
		true
	)
	-- rename immortal heroes
	--v function()
	local function enable_rename_button()
		cm:callback(function()
			local selected_char_cqi = get_selected_char_CQI()
			local selected_char = cm:get_character_by_cqi(selected_char_cqi)
			local is_blacklisted = false
			for _, subtype in ipairs(blacklisted_subtypes) do
				if selected_char:character_subtype(subtype) then
					is_blacklisted = true
					break
				end
			end
			if not is_blacklisted and not cm:char_is_general(selected_char) then
				local button_rename = find_uicomponent(core:get_ui_root(), "character_details_panel", "button_rename")
				if button_rename then button_rename:SetState("active") end
			end
		end, 0.1)
	end
	core:add_listener(
		"sm0_delete_rename_immortal_heroes_PanelOpenedCampaign",
		"PanelOpenedCampaign",
		function(context)
			return context.string == "character_details_panel"
		end,
		function()
			enable_rename_button()
		end,
		true
	)
	core:add_listener(
		"sm0_delete_rename_immortal_heroes_ComponentLClickUp",
		"ComponentLClickUp",
		function(context)
			local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
			return (context.string == "button_cycle_right" or context.string == "button_cycle_left") and is_uicomponent(panel)
		end,
		function(context)
			enable_rename_button()		
		end,
		true
	)	
	core:add_listener(
		"sm0_delete_rename_immortal_heroes_ShortcutPressed",
		"ShortcutPressed",
		function(context)
			local panel = find_uicomponent(core:get_ui_root(), "character_details_panel")
			return (context.string == "select_next" or context.string == "select_prev") and is_uicomponent(panel)
		end,
		function(context)
			enable_rename_button()	
		end,
		true
	)
	--]]
end