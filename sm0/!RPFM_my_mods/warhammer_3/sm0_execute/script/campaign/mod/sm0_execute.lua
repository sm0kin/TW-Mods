local function sm0_log_reset()
	if not __write_output_to_logfile then
		return
	end
	local logTimeStamp = os.date("%d, %m %Y %X")
	local popLog = io.open("sm0_log.txt","w+")
	popLog :write("NEW LOG ["..logTimeStamp.."] \n")
	popLog :flush()
	popLog :close()
end

local function sm0_log(text)
	if not __write_output_to_logfile then
		return
	end
	local logText = tostring(text)
	local logTimeStamp = os.date("%d, %m %Y %X")
	local popLog = io.open("sm0_log.txt","a")
	popLog :write("DEL:  [".. logTimeStamp .. "] [Turn: ".. tostring(cm:model():turn_number()) .. "(" .. tostring(cm:whose_turn_is_it_single():name()) .. ")]:  "..logText .. "  \n")
	popLog :flush()
	popLog :close()
end

local blacklisted_subtypes = {
	"wh_pro02_vmp_isabella_von_carstein",
	"wh_pro01_dwf_grombrindal",
	"wh_main_vmp_mannfred_von_carstein",
	"wh_main_vmp_heinrich_kemmler",
	"wh_main_grn_grimgor_ironhide",
	"wh_main_grn_azhag_the_slaughterer",
	"wh_main_emp_karl_franz",
	"wh_main_emp_balthasar_gelt",
	"wh_main_dwf_ungrim_ironfist",
	"wh_main_dwf_thorgrim_grudgebearer",
	"wh_main_chs_archaon",
	"wh_main_brt_louen_leoncouer",
	"wh_dlc08_nor_wulfrik",
	"wh_dlc08_nor_throgg",
	"wh_dlc07_brt_fay_enchantress",
	"wh_dlc07_brt_alberic",
	"wh_dlc06_grn_wurrzag_da_great_prophet",
	"wh_dlc06_grn_skarsnik",
	"wh_dlc06_dwf_belegar",
	"wh_dlc05_wef_orion",
	"wh_dlc05_wef_durthu",
	"wh_dlc05_vmp_red_duke",
	"wh_dlc05_bst_morghur",
	"wh_dlc04_vmp_vlad_con_carstein",
	"wh_dlc04_vmp_helman_ghorst",
	"wh_dlc04_emp_volkmar",
	"wh_dlc03_emp_boris_todbringer",
	"wh_dlc03_bst_malagor",
	"wh_dlc03_bst_khazrak",
	"wh_dlc01_chs_prince_sigvald",
	"wh_dlc01_chs_kholek_suneater",
	"wh3_main_ogr_skrag_the_slaughterer",
	"wh3_main_ogr_greasus_goldtooth",
	"wh2_twa03_def_rakarth",
	"wh2_pro08_neu_gotrek",
	"wh2_main_skv_queek_headtaker",
	"wh2_main_skv_lord_skrolk",
	"wh2_main_lzd_lord_mazdamundi",
	"wh2_main_lzd_kroq_gar",
	"wh2_main_hef_tyrion",
	"wh2_main_hef_teclis",
	"wh2_main_hef_prince_alastar",
	"wh2_main_def_morathi",
	"wh2_main_def_malekith",
	"wh2_dlc17_lzd_oxyotl",
	"wh2_dlc17_dwf_thorek",
	"wh2_dlc17_bst_taurox",
	"wh2_dlc16_wef_sisters_of_twilight",
	"wh2_dlc16_wef_drycha",
	"wh2_dlc16_skv_throt_the_unclean",
	"wh2_dlc15_hef_imrik",
	"wh2_dlc15_hef_eltharion",
	"wh2_dlc15_grn_grom_the_paunch",
	"wh2_dlc14_skv_deathmaster_snikch",
	"wh2_dlc14_def_malus_darkblade_mp",
	"wh2_dlc14_def_malus_darkblade",
	"wh2_dlc14_brt_repanse",
	"wh2_dlc13_lzd_nakai",
	"wh2_dlc13_lzd_gor_rok",
	"wh2_dlc13_emp_cha_markus_wulfhart",
	"wh2_dlc12_skv_ikit_claw",
	"wh2_dlc12_lzd_tiktaqto",
	"wh2_dlc12_lzd_tehenhauin",
	"wh2_dlc11_def_lokhir",
	"wh2_dlc11_cst_noctilus",
	"wh2_dlc11_cst_harkon",
	"wh2_dlc11_cst_cylostra",
	"wh2_dlc11_cst_aranessa",
	"wh2_dlc10_hef_alith_anar",
	"wh2_dlc10_hef_alarielle",
	"wh2_dlc10_def_crone_hellebron",
	"wh2_dlc09_tmb_settra",
	"wh2_dlc09_tmb_khatep",
	"wh2_dlc09_tmb_khalida",
	"wh2_dlc09_tmb_arkhan",
	"wh2_dlc09_skv_tretch_craventail",
	"wh2_dlc17_dwf_thane_ghost_artifact",
	"wh_dlc06_dwf_master_engineer_ghost",
	"wh_dlc06_dwf_runesmith_ghost",
	"wh_dlc06_dwf_thane_ghost_1",
	"wh_dlc06_dwf_thane_ghost_2",
	"wh2_dlc09_tmb_tomb_king_alkhazzar_ii",
	"wh2_dlc09_tmb_tomb_king_lahmizzash",
	"wh2_dlc09_tmb_tomb_king_rakhash",
	"wh2_dlc09_tmb_tomb_king_setep",
	"wh2_dlc09_tmb_tomb_king_thutep",
	"wh2_dlc09_tmb_tomb_king_wakhaf",
	"wh2_dlc11_cst_admiral_tech_01",
	"wh2_dlc11_cst_admiral_tech_02",
	"wh2_dlc11_cst_admiral_tech_03",
	"wh2_dlc11_cst_admiral_tech_04",
	"wh2_dlc11_cst_ghost_paladin",
	"wh2_dlc11_vmp_bloodline_blood_dragon",
	"wh2_dlc11_vmp_bloodline_lahmian",
	"wh2_dlc11_vmp_bloodline_necrarch",
	"wh2_dlc11_vmp_bloodline_strigoi",
	"wh2_dlc11_vmp_bloodline_von_carstein",
	"wh2_dlc12_lzd_lord_kroak",
	"wh2_dlc12_lzd_red_crested_skink_chief_legendary",
	"wh2_dlc13_emp_hunter_doctor_hertwig_van_hal",
	"wh2_dlc13_emp_hunter_jorek_grimm",
	"wh2_dlc13_emp_hunter_kalara_of_wydrioth",
	"wh2_dlc13_emp_hunter_rodrik_l_anguille",
	"wh2_dlc14_brt_henri_le_massif",
	"wh2_dlc17_vmp_kevon_lloydstein",
	"wh2_pro08_neu_felix",
	"wh2_pro08_neu_gotrek",
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
	-- ...
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
} 

local enable_value
local blacklisted_value

local function delete_trash_ui()
	local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
	local dropdown_units = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units")
	if dropdown_units:Find("trash_bin_button") then 
		local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
		trash_bin_button:Destroy()
		core:remove_listener("sm0_execute_trash_bin_button_ComponentLClickUp")
	end
	if dropdown_units:Find("cross_trash_button") then 
		local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
		cross_trash_button:Destroy()
		core:remove_listener("sm0_execute_cross_trash_button_ComponentLClickUp")
	end
	if dropdown_units:Find("check_trash_button") then 
		local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
		check_trash_button:Destroy()
		core:remove_listener("sm0_execute_check_trash_button_ComponentLClickUp")
	end
	for i = 0, list_box:ChildCount() - 1 do
		local character_row = UIComponent(list_box:Find(i))
		local character_row_len = string.len("character_row_")
		local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
		if character_row:Find("checkbox_toggle_"..cqi_string) then 
			local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
			checkbox_toggle:Destroy()
			core:remove_listener("sm0_execute_checkbox_toggle_"..cqi_string.."_ComponentLClickUp")
		end
	end
end

local function create_trash_ui()
	local player_faction = cm:get_local_faction(true) 
	local icon_delete = "ui/skins/default/icon_delete.png" --prev effect.get_skinned_image_path("icon_delete.png")	
	local icon_cross = "ui/skins/default/icon_cross.png" --prev effect.get_skinned_image_path("icon_cross.png")
	local icon_check = "ui/skins/default/icon_check.png" --prev effect.get_skinned_image_path("icon_check.png")

	local trash_bin_button_disabled = common.get_localised_string("trash_bin_button_disabled_"..player_faction:culture()) 
	if trash_bin_button_disabled == "" then trash_bin_button_disabled = "No Lords or Heroes selected for execution." end
	local trash_bin_button_hover_1 = common.get_localised_string("trash_bin_button_hover_1_"..player_faction:culture()) 
	if trash_bin_button_hover_1 == "" then trash_bin_button_hover_1 = "Are you sure you want to execute all (" end
	local trash_bin_button_hover_2 = common.get_localised_string("trash_bin_button_hover_2_"..player_faction:culture()) 
	if trash_bin_button_hover_2 == "" then trash_bin_button_hover_2 = ") selected Lords/Heroes?" end
	local check_trash_button_hover_1 = common.get_localised_string("check_trash_button_hover_1_"..player_faction:culture()) 
	if check_trash_button_hover_1 == "" then check_trash_button_hover_1 = "Execute all (" end
	local check_trash_button_hover_2 = common.get_localised_string("check_trash_button_hover_2_"..player_faction:culture()) 
	if check_trash_button_hover_2 == "" then check_trash_button_hover_2 = ") selected Lords/Heroes!" end
	local check_trash_button_disabled = common.get_localised_string("check_trash_button_disabled_"..player_faction:culture()) 
	if check_trash_button_disabled == "" then check_trash_button_disabled = "No Lords or Heroes selected." end
	local checkbox_toggle_lord_hover = common.get_localised_string("checkbox_toggle_lord_hover_"..player_faction:culture()) 
	if checkbox_toggle_lord_hover == "" then checkbox_toggle_lord_hover = "Select Lord for Execution." end
	local checkbox_toggle_lord_selected_hover = common.get_localised_string("checkbox_toggle_lord_selected_hover_"..player_faction:culture()) 
	if checkbox_toggle_lord_selected_hover == "" then checkbox_toggle_lord_selected_hover = "Lord selected for Execution." end
	local checkbox_toggle_hero_hover = common.get_localised_string("checkbox_toggle_hero_hover_"..player_faction:culture()) 
	if checkbox_toggle_hero_hover == "" then checkbox_toggle_hero_hover = "Select Hero for Execution." end
	local checkbox_toggle_hero_selected_hover = common.get_localised_string("checkbox_toggle_hero_selected_hover_"..player_faction:culture()) 
	if checkbox_toggle_hero_selected_hover == "" then checkbox_toggle_hero_selected_hover = "Hero selected for Execution." end
	local checkbox_toggle_lord_disabled = common.get_localised_string("checkbox_toggle_lord_disabled_"..player_faction:culture()) 
	if checkbox_toggle_lord_disabled == "" then checkbox_toggle_lord_disabled = "This Lord can't be executed." end
	local checkbox_toggle_hero_disabled = common.get_localised_string("checkbox_toggle_hero_disabled_"..player_faction:culture())
	if checkbox_toggle_hero_disabled == "" then checkbox_toggle_hero_disabled = "This Hero can't be executed." end
	local cross_trash_button_hover = common.get_localised_string("cross_trash_button_hover_"..player_faction:culture()) 
	if cross_trash_button_hover == "" then cross_trash_button_hover = "Cancel." end

	local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
	local dropdown_units = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel")
	local reference_title = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "tx_title")
	local sort_type = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "headers", "sort_type")
	local sort_type_W, sort_type_H = sort_type:Bounds()
	local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
	if not dropdown_units:Find("trash_bin_button") then
		trash_bin_button = UIComponent(dropdown_units:CreateComponent("trash_bin_button", "ui/templates/square_medium_button"))
		reference_title:Adopt(trash_bin_button:Address())
		trash_bin_button:SetDockingPoint(4) -- centre left dock
		trash_bin_button:SetCanResizeHeight(true)
		trash_bin_button:SetCanResizeWidth(true)
		trash_bin_button:Resize(sort_type_W * 1.5, sort_type_W * 1.5)
		local trash_bin_button_W, trash_bin_button_H = trash_bin_button:Bounds()
		trash_bin_button:SetDockOffset(trash_bin_button_W * 0.5, 0)
		trash_bin_button:SetImagePath(icon_delete) 
	end
	trash_bin_button:SetState("inactive")
	trash_bin_button:SetTooltipText(trash_bin_button_disabled, "", false) 

	local function create_comboboxes()
		local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
		local trash_bin_button_W, trash_bin_button_H = trash_bin_button:Bounds()
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

				core:remove_listener("sm0_execute_checkbox_toggle_"..cqi_string.."_ComponentLClickUp")
				core:add_listener(
					"sm0_execute_checkbox_toggle_"..cqi_string.."_ComponentLClickUp",
					"ComponentLClickUp",
					function(context)
						return context.string == "checkbox_toggle_"..cqi_string
					end,
					function(context)
						local chars_selected = 0
						local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
						for i = 0, list_box:ChildCount() - 1 do
							local character_row = UIComponent(list_box:Find(i))
							local character_row_len = string.len("character_row_")
							local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
							local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
							if checkbox_toggle:CurrentState() == "selected" or checkbox_toggle:CurrentState() == "selected_hover" or checkbox_toggle:CurrentState() == "down" then	
								chars_selected = chars_selected + 1
							end
						end
						if dropdown_units:Find("check_trash_button") then 
							local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
							if chars_selected >= 1 then
								check_trash_button:SetState("hover")
								check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2, "", false) 
								check_trash_button:SetState("active")
							else
								check_trash_button:SetState("inactive")
								check_trash_button:SetTooltipText(check_trash_button_disabled, "", false) 
							end
						end
						if dropdown_units:Find("trash_bin_button") then 
							local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
							if chars_selected >= 1 then
								trash_bin_button:SetState("hover")
								trash_bin_button:SetTooltipText(trash_bin_button_hover_1..chars_selected..trash_bin_button_hover_2, "", false) 
								trash_bin_button:SetState("active")
							else
								trash_bin_button:SetState("inactive")
								trash_bin_button:SetTooltipText(trash_bin_button_disabled, "", false) 
							end
						end
					end,
					true
				)	
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
				if not blacklisted_value then
					for _, subtype in ipairs(blacklisted_subtypes) do
						if char:character_subtype(subtype) then
							checkbox_toggle:SetState("inactive")
							if cm:char_is_general(char) then 
								checkbox_toggle:SetTooltipText(checkbox_toggle_lord_disabled, "", false) 
							else
								checkbox_toggle:SetTooltipText(checkbox_toggle_hero_disabled, "", false) 
							end
						end
					end
				end
			else
				local checkbox_toggle_ = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
				checkbox_toggle_:SetState("active")
			end
		end
	end

	create_comboboxes()				

	core:remove_listener("sm0_execute_trash_bin_button_ComponentLClickUp")
	core:add_listener(
		"sm0_execute_trash_bin_button_ComponentLClickUp",
		"ComponentLClickUp",
		function(context)
			return context.string == "trash_bin_button"
		end,
		function(context)
			local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
			local trash_bin_button_W, trash_bin_button_H = trash_bin_button:Bounds()
			trash_bin_button:SetVisible(false)
			if not dropdown_units:Find("cross_trash_button") then
				dropdown_units:CreateComponent("cross_trash_button", "ui/templates/square_medium_button")
				local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
				reference_title:Adopt(cross_trash_button:Address())
				cross_trash_button:PropagatePriority(dropdown_units:Priority())
				cross_trash_button:SetDockingPoint(4) -- centre left dock
				cross_trash_button:SetCanResizeHeight(true)
				cross_trash_button:SetCanResizeWidth(true)
				cross_trash_button:Resize(trash_bin_button_W, trash_bin_button_H)
				cross_trash_button:SetDockOffset(trash_bin_button_W * 0.5, 0)
				cross_trash_button:SetImagePath(icon_cross) 
				cross_trash_button:SetState("hover")
				cross_trash_button:SetTooltipText(cross_trash_button_hover, "", false) 
				cross_trash_button:SetState("active")

				core:add_listener(
					"sm0_execute_cross_trash_button_ComponentLClickUp",
					"ComponentLClickUp",
					function(context)
						return context.string == "cross_trash_button"
					end,
					function(context)
						local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
						local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
						local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
						if cross_trash_button then cross_trash_button:SetVisible(false) end
						if check_trash_button then check_trash_button:SetVisible(false) end
						if trash_bin_button then trash_bin_button:SetVisible(true) end
					end,
					true
				)
			end
			if not dropdown_units:Find("check_trash_button") then
				dropdown_units:CreateComponent("check_trash_button", "ui/templates/square_medium_button")
				local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
				reference_title:Adopt(check_trash_button:Address())
				check_trash_button:PropagatePriority(dropdown_units:Priority())
				check_trash_button:SetDockingPoint(4) -- centre left dock
				check_trash_button:SetCanResizeHeight(true)
				check_trash_button:SetCanResizeWidth(true)
				check_trash_button:Resize(trash_bin_button_W, trash_bin_button_H)
				check_trash_button:SetDockOffset(trash_bin_button_W * 1.5, 0)
				check_trash_button:SetImagePath(icon_check) 
				local chars_selected = 0
				local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
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
					check_trash_button:SetState("hover")
					check_trash_button:SetTooltipText(check_trash_button_hover_1..chars_selected..check_trash_button_hover_2, "", false) 
					check_trash_button:SetState("active")
				else
					check_trash_button:SetState("inactive")
					check_trash_button:SetTooltipText(check_trash_button_disabled, "", false) 
				end

				core:add_listener(
					"sm0_execute_check_trash_button_ComponentLClickUp",
					"ComponentLClickUp",
					function(context)
						return context.string == "check_trash_button"
					end,
					function(context)
						--cm:autosave_at_next_opportunity()
						local list_box = find_uicomponent(core:get_ui_root(),"hud_campaign", "radar_things", "dropdown_parent", "dropdown_units", "panel", "panel_clip", "sortable_list_units", "list_clip", "list_box")
						for i = 0, list_box:ChildCount() - 1 do
							local character_row = UIComponent(list_box:Find(i))
							local character_row_len = string.len("character_row_")
							local cqi_string = string.sub(character_row:Id(), character_row_len + 1)
							local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
							if checkbox_toggle:CurrentState() == "selected" then												
								--sm0_log("sm0/cqi: "..cqi_string)
								local cqi = tonumber(cqi_string)
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
									CampaignUI.TriggerCampaignScriptEvent(cqi, "sm0_execute|")
									if character_row:Find("checkbox_toggle_"..cqi_string) then 
										local checkbox_toggle = UIComponent(character_row:Find("checkbox_toggle_"..cqi_string))
										checkbox_toggle:Destroy()
										core:remove_listener("sm0_execute_checkbox_toggle_"..cqi_string.."_ComponentLClickUp")
									end
								end
							end
						end
						local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
						local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
						local trash_bin_button = UIComponent(dropdown_units:Find("trash_bin_button"))
						if cross_trash_button then cross_trash_button:SetVisible(false) end
						if check_trash_button then check_trash_button:SetVisible(false) end
						if trash_bin_button then trash_bin_button:SetVisible(true) end
					end,
					true
				)
			end
			local cross_trash_button = UIComponent(dropdown_units:Find("cross_trash_button"))
			local check_trash_button = UIComponent(dropdown_units:Find("check_trash_button"))
			if cross_trash_button then cross_trash_button:SetVisible(true) end
			if check_trash_button then check_trash_button:SetVisible(true) end
		end,
		true
	)
end

local function init_execute_listeners(enable)
	core:remove_listener("sm0_execute_UITrigger")
	core:remove_listener("sm0_execute_dropdown_units_PanelOpenedCampaign")
	core:remove_listener("sm0_execute_dropdown_units_PanelClosedCampaign")
	core:remove_listener("sm0_execute_dropdown_units_ComponentLClickUp")
	if enable then
		-- multiplayer listener
		core:add_listener(
			"sm0_execute_UITrigger",
			"UITrigger",
			function(context)
				return context:trigger():starts_with("sm0_execute|")
			end,
			function(context)
				local cqi = context:faction_cqi()
				local char_lookup = cm:char_lookup_str(cqi)
				cm:disable_event_feed_events(true, "", "", "character_ready_for_duty")
				--sm0_log("sm0_execute_UITrigger | "..char_lookup)
				core:add_listener(
					"sm0_execute_"..cqi.."_CharacterConvalescedOrKilled",
					"CharacterConvalescedOrKilled",
					function(context)
						return cqi == context:character():command_queue_index()
					end,
					function(context)
						local cqi = context:character():command_queue_index()
						local char_lookup = cm:char_lookup_str(cqi)
						--sm0_log("sm0_execute_CharacterConvalescedOrKilled | "..char_lookup)
						cm:stop_character_convalescing(cqi)
						cm:callback(function() cm:disable_event_feed_events(false, "", "", "character_ready_for_duty") end, 10)
					end,
					false
				)
				cm:set_character_immortality(char_lookup, false)
				cm:kill_character(cqi, false)
			end,
			true
		)
		core:add_listener(
			"sm0_execute_dropdown_units_PanelOpenedCampaign",
			"PanelOpenedCampaign",
			function(context)		
				return true -- appoint_new_general
			end,
			function(context)
				--sm0_log("sm0/PanelOpenedCampaign: "..context.string)
				real_timer.register_singleshot("sm0_PanelOpenedCampaign_next_tick", 0)
                core:add_listener(
                    "sm0_execute_next_tick",
                    "RealTimeTrigger",
                    function(context)
                        return context.string == "sm0_PanelOpenedCampaign_next_tick"
                    end,
                    function(context)
						local tab_units = find_uicomponent(core:get_ui_root(),"hud_campaign", "bar_small_top", "TabGroup", "tab_units")
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
			"sm0_execute_dropdown_units_PanelClosedCampaign",
			"PanelClosedCampaign",
			function(context)		
				return true -- appoint_new_general
			end,
			function(context)
				--sm0_log("sm0/PanelClosedCampaign: "..context.string)
				real_timer.register_singleshot("sm0_PanelClosedCampaign_next_tick", 0)
                core:add_listener(
                    "sm0_execute_next_tick",
                    "RealTimeTrigger",
                    function(context)
                        return context.string == "sm0_PanelClosedCampaign_next_tick"
                    end,
                    function(context)
						local tab_units = find_uicomponent(core:get_ui_root(),"hud_campaign", "bar_small_top", "TabGroup", "tab_units")
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
			"sm0_execute_dropdown_units_ComponentLClickUp",
			"ComponentLClickUp",
			function(context)
				return context.string == "tab_units"
			end,
			function(context)
				--sm0_log("sm0/ComponentLClickUp: "..context.string)
				real_timer.register_singleshot("sm0_ComponentLClickUp_next_tick", 0)
                core:add_listener(
                    "sm0_execute_next_tick",
                    "RealTimeTrigger",
                    function(context)
                        return context.string == "sm0_ComponentLClickUp_next_tick"
                    end,
                    function(context)
						local tab_units = find_uicomponent(core:get_ui_root(),"hud_campaign", "bar_small_top", "TabGroup", "tab_units")
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
    "sm0_execute_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        local mct = get_mct()
        local execute_mod = mct:get_mod_by_key("execute")
        local a_enable = execute_mod:get_option_by_key("a_enable")
        enable_value = a_enable:get_finalized_setting()
        local b_blacklisted = execute_mod:get_option_by_key("b_blacklisted")
		blacklisted_value = b_blacklisted:get_finalized_setting()
		
		init_execute_listeners(enable_value)
    end,
    true
)

core:add_listener(
    "sm0_execute_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        local mct = get_mct()
        local execute_mod = mct:get_mod_by_key("execute")
        local settings_table = execute_mod:get_settings() 
        enable_value = settings_table.a_enable
		blacklisted_value = settings_table.b_blacklisted
		
		init_execute_listeners(enable_value)
		if not enable_value then delete_trash_ui() end
    end,
    true
)

function sm0_execute()
	if cm:is_new_game() and not cm:get_saved_value("sm0_log_reset") then
		sm0_log_reset()
		cm:set_saved_value("sm0_log_reset", true)
	end
	
	local mct = core:get_static_object("mod_configuration_tool")
	if not mct then 
		blacklisted_value = false
		init_execute_listeners(true) 
	end
end