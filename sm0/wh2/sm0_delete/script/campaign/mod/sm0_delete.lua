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
	"wh2_main_def_black_ark_blessed_dread",
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
	"wh2_dlc16_skv_throt_the_unclean",
	"wh2_dlc16_skv_ghoritch",
	"wh2_dlc16_wef_drycha",
	"wh2_dlc16_wef_coeddil",
	"wh2_dlc16_wef_ariel",
	"wh2_dlc16_wef_sisters_of_twilight",
	"wh2_twa03_def_rakarth",
	"wh2_dlc17_bst_taurox",
	"wh2_dlc17_dwf_thorek",
	"wh2_dlc17_lzd_oxyotl",
	"wh2_dlc17_vmp_kevon_lloydstein",
	"wh2_dlc17_dwf_thane_ghost_artifact",
	--mixu1
	"brt_almaric_de_gaudaron",
	"brt_chilfroy",
	"brt_bohemond",
	"brt_adalhard",
	"brt_cassyon",
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
	"cst_bloodline_khoskog"
} --:vector<string>

local enable_value
local blacklisted_value

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
            if uic_child:CurrentState() == "selected" and string.find(uic_child:Id(), "Agent") then
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
local function delete_trash_ui()
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
	for i = 0, list_box:ChildCount() - 1 do
		local character_row = UIComponent(list_box:Find(i))
		local character_row_len = string.len("character_row_")
		local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
		if character_row:Find("checkbox_toggle_"..cqi_string) then 
			local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
			delete_UIC(checkbox_toggle)
			core:remove_listener("sm0_delete_checkbox_toggle_"..cqi_string.."_ComponentLClickUp")
		end
	end
end

--v function()
local function create_trash_ui()
	local player_faction = cm:get_local_faction(true) 
	local icon_delete = effect.get_skinned_image_path("icon_delete.png")	
	local icon_cross = effect.get_skinned_image_path("icon_cross.png")
	local icon_check = effect.get_skinned_image_path("icon_check.png")

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
	trash_bin_button:SetImagePath(icon_delete) 
	local trash_bin_button_X, trash_bin_button_Y = trash_bin_button:Position()
	trash_bin_button:SetState("inactive")
	--trash_bin_button:SetOpacity(50)
	trash_bin_button:SetTooltipText(trash_bin_button_disabled, "", false) 

	--v function()
	local function create_comboboxes()
		for i = 0, list_box:ChildCount() - 1 do
			local character_row = UIComponent(list_box:Find(i))
			local character_row_len = string.len("character_row_")
			local cqi_string = string.sub(character_row:Id(), character_row_len + 1) 
			--sm0_log("sm0/cqi: "..tostring(cqi_string))
			if not character_row:Find("checkbox_toggle_"..cqi_string) then 
				local reference_uic = find_uicomponent(character_row, "indent_parent", "soldiers")
				local reference_uic_W, reference_uic_H = reference_uic:Bounds()
				local reference_uic_X, reference_uic_Y = reference_uic:Position()
				local reference_uic_2 = find_uicomponent(character_row, "indent_parent", "icon_wounded") 
				local reference_uic_2_X, reference_uic_2_Y = reference_uic_2:Position()

				local checkbox_toggle = core:get_or_create_component("checkbox_toggle_"..cqi_string, "ui/templates/checkbox_toggle", character_row)
				character_row:Adopt(checkbox_toggle:Address())
				checkbox_toggle:PropagatePriority(reference_uic:Priority())
				checkbox_toggle:SetCanResizeHeight(true)
				checkbox_toggle:SetCanResizeWidth(true)
				checkbox_toggle:Resize(trash_bin_button_W, trash_bin_button_H)
				local checkbox_toggle_W, checkbox_toggle_H = checkbox_toggle:Bounds()
				checkbox_toggle:MoveTo(reference_uic_X + reference_uic_W / 2 - checkbox_toggle_W / 2 - 5, reference_uic_2_Y + reference_uic_H/2 + 1)
				reference_uic:MoveTo(reference_uic_X, reference_uic_2_Y - reference_uic_H/2 - 1)

				core:remove_listener("sm0_delete_checkbox_toggle_"..cqi_string.."_ComponentLClickUp")
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
								--check_trash_button:SetOpacity(255)
								check_trash_button:SetState("hover")
								check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2, "", false) 
								check_trash_button:SetState("active")
							else
								check_trash_button:SetState("inactive")
								--check_trash_button:SetOpacity(50)
								check_trash_button:SetTooltipText(check_trash_button_disabled, "", false) 
							end
						end
						if units_dropdown:Find("trash_bin_button") then 
							local trash_bin_button = UIComponent(units_dropdown:Find("trash_bin_button"))
							if chars_selected >= 1 then
								--trash_bin_button:SetOpacity(255)
								trash_bin_button:SetState("hover")
								trash_bin_button:SetTooltipText(trash_bin_button_hover_1..chars_selected..trash_bin_button_hover_2, "", false) 
								trash_bin_button:SetState("active")
							else
								trash_bin_button:SetState("inactive")
								--trash_bin_button:SetOpacity(50)
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
				--checkbox_toggle:SetOpacity(255)
				if not blacklisted_value then
					for _, subtype in ipairs(blacklisted_subtypes) do
						if char:character_subtype(subtype) then
							checkbox_toggle:SetState("inactive")
							--checkbox_toggle:SetOpacity(150)
							if cm:char_is_general(char) then 
								checkbox_toggle:SetTooltipText(checkbox_toggle_lord_disabled, "", false) 
							else
								checkbox_toggle:SetTooltipText(checkbox_toggle_hero_disabled, "", false) 
							end
						end
					end
				end
			end
		end
	end

	create_comboboxes()				

	--core:remove_listener("sm0_delete_trash_bin_button_ComponentLClickUp")
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
				cross_trash_button:SetImagePath(icon_cross) 
				cross_trash_button:SetState("hover")
				cross_trash_button:SetTooltipText(cross_trash_button_hover, "", false) 
				cross_trash_button:SetState("active")
				--core:remove_listener("sm0_delete_check_trash_button_ComponentLClickUp")
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
				check_trash_button:SetImagePath(icon_check) 
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
					--check_trash_button:SetOpacity(255)
					check_trash_button:SetState("hover")
					check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2, "", false) 
					check_trash_button:SetState("active")
				else
					check_trash_button:SetState("inactive")
					--check_trash_button:SetOpacity(50)
					check_trash_button:SetTooltipText(check_trash_button_disabled, "", false) 
				end

				--core:remove_listener("sm0_delete_check_trash_button_ComponentLClickUp")
				core:add_listener(
					"sm0_delete_check_trash_button_ComponentLClickUp",
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
								if not blacklisted_value then
									for _, subtype in ipairs(blacklisted_subtypes) do
										if char:character_subtype(subtype) then
											is_blacklisted = true
											break
										end
									end
								end
								if not is_blacklisted then 
									CampaignUI.TriggerCampaignScriptEvent(cqi, "sm0_delete|")
									if character_row:Find("checkbox_toggle_"..cqi_string) then 
										local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
										delete_UIC(checkbox_toggle)
										core:remove_listener("sm0_delete_checkbox_toggle_"..cqi_string.."_ComponentLClickUp")
									end
								end
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

--v function(enable: boolean)
local function init_delete_listeners(enable)
	core:remove_listener("sm0_delete_UITrigger")
	core:remove_listener("sm0_delete_units_dropdown_PanelOpenedCampaign")
	core:remove_listener("sm0_delete_units_dropdown_PanelClosedCampaign")
	core:remove_listener("sm0_delete_units_dropdown_ComponentLClickUp")
	if enable then
		-- multiplayer listener
		core:add_listener(
			"sm0_delete_UITrigger",
			"UITrigger",
			function(context)
				return context:trigger():starts_with("sm0_delete|")
			end,
			function(context)
				local cqi = context:faction_cqi()
				local char_lookup = cm:char_lookup_str(cqi)
				local character = cm:get_character_by_cqi(cqi)
				cm:disable_event_feed_events(true, "", "", "character_ready_for_duty")
				sm0_log("sm0_delete_UITrigger | "..char_lookup)
				core:add_listener(
					"sm0_delete_"..cqi.."_CharacterConvalescedOrKilled",
					"CharacterConvalescedOrKilled",
					function(context)
						return cqi == context:character():command_queue_index()
					end,
					function(context)
						local cqi = context:character():command_queue_index()
						local char_lookup = cm:char_lookup_str(cqi)
						sm0_log("sm0_delete_CharacterConvalescedOrKilled | "..char_lookup)
						cm:stop_character_convalescing(cqi)
						cm:callback(function() cm:disable_event_feed_events(false, "", "", "character_ready_for_duty") end, 10)
					end,
					false
				)
				cm:set_character_immortality(char_lookup, false)
				cm:kill_character(cqi, false, true)
			end,
			true
		)
		core:add_listener(
			"sm0_delete_units_dropdown_PanelOpenedCampaign",
			"PanelOpenedCampaign",
			function(context)		
				return true --appoint_new_general
			end,
			function(context)
				--sm0_log("sm0/PanelOpenedCampaign: "..context.string)
				real_timer.register_singleshot("sm0_PanelOpenedCampaign_next_tick", 0)
                core:add_listener(
                    "sm0_delete_next_tick",
                    "RealTimeTrigger",
                    function(context)
                        return context.string == "sm0_PanelOpenedCampaign_next_tick"
                    end,
                    function(context)
						local tab_units = find_uicomponent(core:get_ui_root(),"layout", "bar_small_top", "TabGroup", "tab_units")
						if tab_units and (tab_units:CurrentState() == "selected" or tab_units:CurrentState() == "selected_hover" or tab_units:CurrentState() == "selected_down" 
						or tab_units:CurrentState() == "down") then 
							--sm0_log("sm0/tab_units|state: "..tostring(tab_units:CurrentState())) 
							create_trash_ui()
						else
							delete_trash_ui()
							--sm0_log("sm0/tab_units|state: disabled")
						end	
                    end,
                    false
                )						
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
				real_timer.register_singleshot("sm0_PanelClosedCampaign_next_tick", 0)
                core:add_listener(
                    "sm0_delete_next_tick",
                    "RealTimeTrigger",
                    function(context)
                        return context.string == "sm0_PanelClosedCampaign_next_tick"
                    end,
                    function(context)
						local tab_units = find_uicomponent(core:get_ui_root(),"layout", "bar_small_top", "TabGroup", "tab_units")
						if tab_units and (tab_units:CurrentState() == "selected" or tab_units:CurrentState() == "selected_hover" or tab_units:CurrentState() == "selected_down"
						or tab_units:CurrentState() == "down") then 
							--sm0_log("sm0/tab_units|state: "..tostring(tab_units:CurrentState())) 
							create_trash_ui()
						else
							delete_trash_ui()
							--sm0_log("sm0/tab_units|state: disabled")
						end	
                    end,
                    false
                )							
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
				real_timer.register_singleshot("sm0_ComponentLClickUp_next_tick", 0)
                core:add_listener(
                    "sm0_delete_next_tick",
                    "RealTimeTrigger",
                    function(context)
                        return context.string == "sm0_ComponentLClickUp_next_tick"
                    end,
                    function(context)
						local tab_units = find_uicomponent(core:get_ui_root(),"layout", "bar_small_top", "TabGroup", "tab_units")
						if tab_units and (tab_units:CurrentState() == "selected" or tab_units:CurrentState() == "selected_hover" or tab_units:CurrentState() == "selected_down") then 
							--sm0_log("sm0/tab_units|state: "..tostring(tab_units:CurrentState())) 
							create_trash_ui()
						else
							delete_trash_ui()
							--sm0_log("sm0/tab_units|state: disabled")
						end	
                    end,
                    false
                )		
			end,
			true
		)
	end
end

core:add_listener(
    "sm0_delete_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        local mct = get_mct()
        local delete_mod = mct:get_mod_by_key("execute")
        local a_enable = delete_mod:get_option_by_key("a_enable")
        enable_value = a_enable:get_finalized_setting()
        local b_blacklisted = delete_mod:get_option_by_key("b_blacklisted")
		blacklisted_value = b_blacklisted:get_finalized_setting()
		
		init_delete_listeners(enable_value)
    end,
    true
)

core:add_listener(
    "sm0_delete_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        local mct = get_mct()
        local delete_mod = mct:get_mod_by_key("execute")
        local settings_table = delete_mod:get_settings() 
        enable_value = settings_table.a_enable
		blacklisted_value = settings_table.b_blacklisted
		
		init_delete_listeners(enable_value)
		if not enable_value then delete_trash_ui() end
    end,
    true
)

--v function()
function sm0_delete()
	if cm:is_new_game() and not cm:get_saved_value("sm0_log_reset") then
		sm0_log_reset()
		cm:set_saved_value("sm0_log_reset", true)
	end
	
	local mct = core:get_static_object("mod_configuration_tool")
	if not mct then 
		blacklisted_value = false
		init_delete_listeners(true) 
	end
end