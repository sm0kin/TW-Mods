mcm = _G.mcm
--local legacy_option = false
--# assume global handover_nakai_region: function()
--v function()
local function sm0_log_reset()
	if not __write_output_to_logfile then
		return
    end
	local log_time_stamp = os.date("%d, %m %Y %X")
	--# assume log_time_stamp: string
	local pop_log = io.open("sm0_log.txt","w+")
	pop_log :write("NEW LOG ["..log_time_stamp.."] \n")
	pop_log :flush()
	pop_log :close()
end

--v function(text: string | number | boolean | CA_CQI)
local function sm0_log(text)
	if not __write_output_to_logfile then
		return
	end
	local log_text = tostring(text)
	local log_time_stamp = os.date("%d, %m %Y %X")
	local pop_log = io.open("sm0_log.txt","a")
	--# assume log_time_stamp: string
	pop_log :write("RD:  [".. log_time_stamp .. "] [Turn: ".. tostring(cm:model():turn_number()) .. "(" .. cm:whose_turn_is_it() .. ")]:  "..log_text .. "  \n")
	pop_log :flush()
	pop_log :close()
end

--v function()
local function RDDEBUG()
	--Vanish's PCaller
	--All credits to vanish
	--v function(func: function) --> any
	local function safeCall(func)
		--out("safeCall start")
		local status, result = pcall(func)
		if not status then
			sm0_log("ERROR")
			sm0_log(tostring(result))
			sm0_log(debug.traceback())
		end
		--out("safeCall end")
		return result
	end

	--local oldTriggerEvent = core.trigger_event

	--v [NO_CHECK] function(...: any)
	local function pack2(...) return {n=select('#', ...), ...} end
	--v [NO_CHECK] function(t: vector<WHATEVER>) --> vector<WHATEVER>
	local function unpack2(t) return unpack(t, 1, t.n) end

	--v [NO_CHECK] function(f: function(), argProcessor: function()) --> function()
	local function wrapFunction(f, argProcessor)
		return function(...)
			--out("start wrap ")
			local someArguments = pack2(...)
			if argProcessor then
				safeCall(function() argProcessor(someArguments) end)
			end
			local result = pack2(safeCall(function() return f(unpack2( someArguments )) end))
			--for k, v in pairs(result) do
			--    out("Result: " .. tostring(k) .. " value: " .. tostring(v))
			--end
			--out("end wrap ")
			return unpack2(result)
			end
	end

	-- function myTriggerEvent(event, ...)
	--     local someArguments = { ... }
	--     safeCall(function() oldTriggerEvent(event, unpack( someArguments )) end)
	-- end

	--v [NO_CHECK] function(fileName: string)
	local function tryRequire(fileName)
		local loaded_file = loadfile(fileName)
		if not loaded_file then
			out("Failed to find mod file with name " .. fileName)
		else
			out("Found mod file with name " .. fileName)
			out("Load start")
			local local_env = getfenv(1)
			setfenv(loaded_file, local_env)
			loaded_file()
			out("Load end")
		end
	end

	--v [NO_CHECK] function(f: function(), name: string)
	local function logFunctionCall(f, name)
		return function(...)
			out("function called: " .. name)
			return f(...)
		end
	end

	--v [NO_CHECK] function(object: any)
	local function logAllObjectCalls(object)
		local metatable = getmetatable(object)
		for name,f in pairs(getmetatable(object)) do
			if is_function(f) then
				out("Found " .. name)
				if name == "Id" or name == "Parent" or name == "Find" or name == "Position" or name == "CurrentState"  or name == "Visible"  or name == "Priority" or "Bounds" then
					--Skip
				else
					metatable[name] = logFunctionCall(f, name)
				end
			end
			if name == "__index" and not is_function(f) then
				for indexname,indexf in pairs(f) do
					out("Found in index " .. indexname)
					if is_function(indexf) then
						f[indexname] = logFunctionCall(indexf, indexname)
					end
				end
				out("Index end")
			end
		end
	end

	-- logAllObjectCalls(core)
	-- logAllObjectCalls(cm)
	-- logAllObjectCalls(game_interface)

	core.trigger_event = wrapFunction(
		core.trigger_event,
		function(ab)
			--out("trigger_event")
			--for i, v in pairs(ab) do
			--    out("i: " .. tostring(i) .. " v: " .. tostring(v))
			--end
			--out("Trigger event: " .. ab[1])
		end
	)

	cm.check_callbacks = wrapFunction(
		cm.check_callbacks,
		function(ab)
			--out("check_callbacks")
			--for i, v in pairs(ab) do
			--    out("i: " .. tostring(i) .. " v: " .. tostring(v))
			--end
		end
	)

	local currentAddListener = core.add_listener
	--v [NO_CHECK] function(core: any, listenerName: any, eventName: any, conditionFunc: (function(context: WHATEVER?) --> boolean) | boolean, listenerFunc: function(context: WHATEVER?), persistent: any)
	local function myAddListener(core, listenerName, eventName, conditionFunc, listenerFunc, persistent)
		local wrappedCondition = nil
		if is_function(conditionFunc) then
			--wrappedCondition =  wrapFunction(conditionFunc, function(arg) out("Callback condition called: " .. listenerName .. ", for event: " .. eventName) end)
			wrappedCondition =  wrapFunction(conditionFunc)
		else
			wrappedCondition = conditionFunc
		end
		currentAddListener(
			core, listenerName, eventName, wrappedCondition, wrapFunction(listenerFunc), persistent
			--core, listenerName, eventName, wrappedCondition, wrapFunction(listenerFunc, function(arg) out("Callback called: " .. listenerName .. ", for event: " .. eventName) end), persistent
		)
	end
	core.add_listener = myAddListener
end

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
    ["wh2_dlc13_lzd_spirits_of_the_jungle"] = 775,
    ["wh2_dlc13_emp_the_huntmarshals_expedition"] = 591,
    ["wh2_dlc14_brt_chevaliers_de_lyonesse"] = 751,
    ["wh2_main_skv_clan_eshin"] = 778,
    ["wh2_main_def_hag_graef"] = 773,
	
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

local subtype_immortality = {
    --["dlc03_emp_boris_todbringer"] = true,
    --["wh_dlc05_vmp_red_duke"] = true,
    --["wh2_dlc09_tmb_arkhan"] = true,
    --["wh2_dlc09_tmb_khalida"] = true,
    --["wh2_dlc09_tmb_khatep"] = true,
    --["wh2_dlc09_tmb_settra"] = true,
    --["wh2_dlc11_cst_aranessa"] = true,
    --["wh2_dlc11_cst_cylostra"] = true,
    --["wh2_dlc11_cst_harkon"] = true,
    --["wh2_dlc11_cst_noctilus"] = true,
    --["wh2_main_hef_prince_alastar"] = true -- no longer needed (the empire undivided update made him immortal)
} --: map<string, boolean>

local wh_agents = {
    {["faction"] = "wh_main_emp_middenland", ["subtype"] = "dlc03_emp_boris_todbringer", ["dlc"] = "TW_WH_BEASTMEN"},
    {["faction"] = "wh_main_emp_empire", ["subtype"] = "dlc04_emp_volkmar", ["dlc"] = "TW_WH_LORDS_AND_UNITS_1"},
    {["faction"] = "wh_main_emp_empire", ["subtype"] = "emp_balthasar_gelt"},
    {["faction"] = "wh_main_emp_empire", ["subtype"] = "emp_karl_franz"},
    {["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "dlc04_vmp_helman_ghorst", ["dlc"] = "TW_WH_LORDS_AND_UNITS_1"},
    {["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "dlc04_vmp_vlad_con_carstein"},
    {["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "pro02_vmp_isabella_von_carstein"},
    {["faction"] = "wh2_dlc11_vmp_the_barrow_legion", ["subtype"] = "vmp_heinrich_kemmler"},
    {["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "vmp_mannfred_von_carstein"},
    {["faction"] = "wh_main_vmp_mousillon", ["subtype"] = "wh_dlc05_vmp_red_duke", ["dlc"] = "TW_WH_WOOD_ELVES"},
    {["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "dwf_thorgrim_grudgebearer"},
    {["faction"] = "wh_main_dwf_karak_kadrin", ["subtype"] = "dwf_ungrim_ironfist"},
    {["faction"] = "wh_main_dwf_karak_izor", ["subtype"] = "dlc06_dwf_belegar", ["dlc"] = "TW_WH_LORDS_AND_UNITS_2"},
    {["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "pro01_dwf_grombrindal"},
    {["faction"] = "wh_main_grn_crooked_moon", ["subtype"] = "dlc06_grn_skarsnik", ["dlc"] = "TW_WH_LORDS_AND_UNITS_2"},
    {["faction"] = "wh_main_grn_greenskins", ["subtype"] = "grn_azhag_the_slaughterer"},
    {["faction"] = "wh_main_grn_greenskins", ["subtype"] = "grn_grimgor_ironhide"},
    {["faction"] = "wh_main_grn_orcs_of_the_bloody_hand", ["subtype"] = "dlc06_grn_wurrzag_da_great_prophet"},
    {["faction"] = "wh2_dlc09_tmb_followers_of_nagash", ["subtype"] = "wh2_dlc09_tmb_arkhan", ["dlc"] = "TW_WH2_TOMB_KINGS"},
    {["faction"] = "wh2_dlc09_tmb_lybaras", ["subtype"] = "wh2_dlc09_tmb_khalida", ["dlc"] = "TW_WH2_TOMB_KINGS"},
    {["faction"] = "wh2_dlc09_tmb_exiles_of_nehek", ["subtype"] = "wh2_dlc09_tmb_khatep", ["dlc"] = "TW_WH2_TOMB_KINGS"},
    {["faction"] = "wh2_dlc09_tmb_khemri", ["subtype"] = "wh2_dlc09_tmb_settra", ["dlc"] = "TW_WH2_TOMB_KINGS"},
    {["faction"] = "wh_main_brt_bretonnia", ["subtype"] = "brt_louen_leoncouer"},
    {["faction"] = "wh_main_brt_bordeleaux", ["subtype"] = "dlc07_brt_alberic"},
    {["faction"] = "wh_main_brt_carcassonne", ["subtype"] = "dlc07_brt_fay_enchantress"},
    {["faction"] = "wh2_main_hef_order_of_loremasters", ["subtype"] = "wh2_main_hef_teclis"},
    {["faction"] = "wh2_main_hef_eataine", ["subtype"] = "wh2_main_hef_tyrion"},
    {["faction"] = "wh2_main_hef_eataine", ["subtype"] = "wh2_main_hef_prince_alastar"},
    {["faction"] = "wh2_main_hef_avelorn", ["subtype"] = "wh2_dlc10_hef_alarielle", ["dlc"] = "TW_WH2_DLC12_PROPHET"},
    {["faction"] = "wh2_main_hef_nagarythe", ["subtype"] = "wh2_dlc10_hef_alith_anar"},
    {["faction"] = "wh2_dlc11_def_the_blessed_dread", ["subtype"] = "wh2_dlc11_def_lokhir"},
    {["faction"] = "wh2_main_def_naggarond", ["subtype"] = "wh2_main_def_malekith"},
    {["faction"] = "wh2_main_def_cult_of_pleasure", ["subtype"] = "wh2_main_def_morathi"},
    {["faction"] = "wh2_main_lzd_hexoatl", ["subtype"] = "wh2_main_lzd_lord_mazdamundi"},
    {["faction"] = "wh2_main_lzd_last_defenders", ["subtype"] = "wh2_main_lzd_kroq_gar"},
    {["faction"] = "wh2_dlc12_lzd_cult_of_sotek", ["subtype"] = "wh2_dlc12_lzd_tehenhauin", ["dlc"] = "TW_WH2_DLC12_PROPHET"},
    {["faction"] = "wh2_main_lzd_tlaqua", ["subtype"] = "wh2_dlc12_lzd_tiktaqto"},
    {["faction"] = "wh2_main_skv_clan_pestilens", ["subtype"] = "wh2_main_skv_lord_skrolk"},
    {["faction"] = "wh2_dlc09_skv_clan_rictus", ["subtype"] = "wh2_dlc09_skv_tretch_craventail"},
    {["faction"] = "wh2_main_skv_clan_mors", ["subtype"] = "wh2_main_skv_queek_headtaker"},
    {["faction"] = "wh2_main_skv_clan_skyre", ["subtype"] = "wh2_dlc12_skv_ikit_claw", ["dlc"] = "TW_WH2_DLC10_QUEEN_CRONE"},
    {["faction"] = "wh_dlc05_wef_argwylon", ["subtype"] = "dlc05_wef_durthu", ["dlc"] = "TW_WH_WOOD_ELVES"},
    {["faction"] = "wh_dlc05_wef_wood_elves", ["subtype"] = "dlc05_wef_orion", ["dlc"] = "TW_WH_WOOD_ELVES"},
    {["faction"] = "wh_dlc08_nor_wintertooth", ["subtype"] = "wh_dlc08_nor_throgg", ["dlc"] = "TW_WH_NORSCA"},
    {["faction"] = "wh_dlc08_nor_norsca", ["subtype"] = "wh_dlc08_nor_wulfrik", ["dlc"] = "TW_WH_NORSCA"},
    {["faction"] = "wh2_main_def_har_ganeth", ["subtype"] = "wh2_dlc10_def_crone_hellebron", ["dlc"] = "TW_WH2_DLC10_QUEEN_CRONE"},
    {["faction"] = "wh2_dlc11_cst_pirates_of_sartosa", ["subtype"] = "wh2_dlc11_cst_aranessa", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_dlc11_cst_the_drowned", ["subtype"] = "wh2_dlc11_cst_cylostra", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_dlc11_cst_vampire_coast", ["subtype"] = "wh2_dlc11_cst_harkon", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_dlc11_cst_noctilus", ["subtype"] = "wh2_dlc11_cst_noctilus", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_dlc13_emp_the_huntmarshals_expedition", ["subtype"] = "wh2_dlc13_emp_cha_markus_wulfhart_0", ["dlc"] = "TW_WH2_DLC13_HUNTER"},
    {["faction"] = "wh2_dlc13_emp_the_huntmarshals_expedition", ["subtype"] = "wh2_dlc13_emp_hunter_jorek_grimm", ["dlc"] = "TW_WH2_DLC13_HUNTER"},
    {["faction"] = "wh2_dlc13_emp_the_huntmarshals_expedition", ["subtype"] = "wh2_dlc13_emp_hunter_rodrik_l_anguille", ["dlc"] = "TW_WH2_DLC13_HUNTER"},
    {["faction"] = "wh2_dlc13_emp_the_huntmarshals_expedition", ["subtype"] = "wh2_dlc13_emp_hunter_doctor_hertwig_van_hal", ["dlc"] = "TW_WH2_DLC13_HUNTER"},
    {["faction"] = "wh2_dlc13_emp_the_huntmarshals_expedition", ["subtype"] = "wh2_dlc13_emp_hunter_kalara_of_wydrioth", ["dlc"] = "TW_WH2_DLC13_HUNTER"},
    {["faction"] = "wh2_dlc13_lzd_spirits_of_the_jungle", ["subtype"] = "wh2_dlc13_lzd_nakai", ["dlc"] = "TW_WH2_DLC13_HUNTER"},
    {["faction"] = "wh2_main_lzd_itza", ["subtype"] = "wh2_dlc13_lzd_gor_rok"},
    {["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "dlc03_bst_khazrak", ["dlc"] = "TW_WH_BEASTMEN"},
    {["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "dlc03_bst_malagor", ["dlc"] = "TW_WH_BEASTMEN"},
    {["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "dlc05_bst_morghur", ["dlc"] = "TW_WH_BEASTMEN"},
    {["faction"] = "wh2_dlc14_brt_chevaliers_de_lyonesse", ["subtype"] = "wh2_dlc14_brt_repanse"},
    {["faction"] = "wh2_dlc14_brt_chevaliers_de_lyonesse", ["subtype"] = "wh2_dlc14_brt_henri_le_massif"},
    {["faction"] = "wh2_main_skv_clan_eshin", ["subtype"] = "wh2_dlc14_skv_deathmaster_snikch", ["dlc"] = "TW_WH2_DLC14_SHADOW"},
    {["faction"] = "wh2_dlc15_grn_broken_axe", ["subtype"] = "wh2_dlc15_grn_grom_the_paunch", ["dlc"] = "TW_WH2_DLC15_WARDEN"},
    {["faction"] = "wh2_main_hef_yvresse", ["subtype"] = "wh2_dlc15_hef_eltharion", ["dlc"] = "TW_WH2_DLC15_WARDEN"},
    {["faction"] = "wh2_dlc15_hef_imrik", ["subtype"] = "wh2_dlc15_hef_imrik", ["dlc"] = "TW_WH2_DLC15_IMRIK_FREE"}
} --:vector<map<string, string>> 
    --MIXU Part 1--
local mixu1_agents = {
    {["faction"] = "wh_main_brt_artois", ["subtype"] = "brt_chilfroy"},
    {["faction"] = "wh_main_brt_bastonne", ["subtype"] = "brt_bohemond"},
    {["faction"] = "wh_main_brt_lyonesse", ["subtype"] = "brt_adalhard"},
    {["faction"] = "wh_main_brt_parravon", ["subtype"] = "brt_cassyon"},
    {["faction"] = "wh_main_dwf_karak_azul", ["subtype"] = "dwf_kazador_dragonslayer"},
    {["faction"] = "wh_main_dwf_karak_azul", ["subtype"] = "dwf_thorek_ironbrow"},
    {["faction"] = "wh_main_emp_wissenland", ["subtype"] = "mixu_elspeth_von_draken"},
    {["faction"] = "wh_main_ksl_kislev", ["subtype"] = "ksl_katarin_the_ice_queen"},
    {["faction"] = "wh_dlc05_wef_torgovann", ["subtype"] = "wef_daith"},
    {["faction"] = "wh_main_emp_averland", ["subtype"] = "emp_marius_leitdorf"},
    {["faction"] = "wh_main_emp_hochland", ["subtype"] = "emp_aldebrand_ludenhof"},
    {["faction"] = "wh_main_emp_marienburg", ["subtype"] = "emp_edward_van_der_kraal"},
    {["faction"] = "wh_main_emp_nordland", ["subtype"] = "emp_theoderic_gausser"},
    {["faction"] = "wh_main_emp_ostermark", ["subtype"] = "emp_wolfram_hertwig"},
    {["faction"] = "wh_main_emp_ostland", ["subtype"] = "emp_valmir_von_raukov"},
    {["faction"] = "wh_main_emp_stirland", ["subtype"] = "emp_alberich_haupt_anderssen"},
    {["faction"] = "wh_main_emp_talabecland", ["subtype"] = "emp_helmut_feuerbach"},
    --{["faction"] = "wh_main_emp_middenland", ["subtype"] = --"emp_markus_wulfhart"}, --dlc
    --{["faction"] = "", ["subtype"] = "emp_alberich_von_korden"}, 
    --{["faction"] = "", ["subtype"] = "emp_alberich_von_korden_hero"}, 
    {["faction"] = "wh_main_emp_empire", ["subtype"] = "emp_luthor_huss"},
    {["faction"] = "wh_main_emp_wissenland", ["subtype"] = "emp_theodore_bruckner"},
    {["faction"] = "wh_main_emp_middenland", ["subtype"] = "emp_vorn_thugenheim"},
    {["faction"] = "wh2_main_bst_manblight", ["subtype"] = "bst_taurox"},
    {["faction"] = "wh_dlc05_wef_wydrioth", ["subtype"] = "wef_drycha"}
} --:vector<map<string, string>> 
    --MIXU Part 2--
local mixu2_agents = {
    {["faction"] = "wh2_main_brt_knights_of_origo", ["subtype"] = "brt_john_tyreweld"},
    --{["faction"] = "", ["subtype"] = chs_egrimm_van_horstmann"}, --player unlock
    {["faction"] = "wh2_main_def_scourge_of_khaine", ["subtype"] = "def_tullaris_dreadbringer"},
    {["faction"] = "wh2_main_def_scourge_of_khaine", ["subtype"] = "def_tullaris_hero"},
    --{["faction"] = "wh_main_dwf_zhufbar", ["subtype"] = "dwf_bloodline_grimm_burloksson"}, --player unlock
    {["faction"] = "wh_main_grn_red_fangs", ["subtype"] = "grn_gorfang_rotgut"},
    {["faction"] = "wh2_main_hef_saphery", ["subtype"] = "hef_belannaer"},
    --{["faction"] = "wh2_main_hef_eataine", ["subtype"] = "hef_bloodline_caradryan"}, --player unlock
    --{["faction"] = "wh2_main_hef_eataine", ["subtype"] = "hef_caradryan_hero"}, --player unlock
    {["faction"] = "wh2_main_hef_chrace", ["subtype"] = "hef_korhil"},
    --{["faction"] = "wh2_main_hef_caledor", ["subtype"] = "hef_prince_imrik"}, --dlc
    --{["faction"] = "wh2_main_lzd_itza", ["subtype"] = "lzd_gor_rok"}, --dlc
    {["faction"] = "wh2_main_lzd_xlanhuapec", ["subtype"] = "lzd_lord_huinitenuchli"},
    --{["faction"] = "wh2_main_lzd_tlaqua", ["subtype"] = "lzd_oxyotl"}, --player unlock
    {["faction"] = "wh2_main_lzd_tlaxtlan", ["subtype"] = "lzd_tetto_eko"},
    {["faction"] = "wh_main_nor_skaeling", ["subtype"] = "nor_egil_styrbjorn"},
    {["faction"] = "wh2_dlc09_tmb_numas", ["subtype"] = "tmb_tutankhanut"},
    {["faction"] = "wh_dlc05_wef_wydrioth", ["subtype"] = "wef_naieth_the_prophetess"},
    {["faction"] = "wh2_main_def_naggarond", ["subtype"] = "def_kouran_darkhand"},
    {["faction"] = "", ["subtype"] = "lzd_chakax"}, -- "wh2_main_lzd_xlanhuapec" "wh2_main_lzd_hexoatl"
    {["faction"] = "wh2_main_brt_knights_of_origo", ["subtype"] = "brt_donna_don_domingio"},
    {["faction"] = "wh2_dlc09_tmb_numas", ["subtype"] = "tmb_ramhotep"},
    {["faction"] = "wh2_main_bst_ripper_horn", ["subtype"] = "bst_ghorros_warhoof"},
    {["faction"] = "", ["subtype"] = "chs_aekold_helbrass"},
    {["faction"] = "", ["subtype"] = "chs_azubhor_clawhand"},  
    {["faction"] = "wh2_main_skv_clan_mordkin", ["subtype"] = "skv_feskit"}
} --:vector<map<string, string>> 
    --XOUDAD High Elves Expanded--
local xoudad_agents = {
    --{["faction"] = "wh2_main_hef_yvresse", ["subtype"] = "wh2_main_hef_eltharion"}, --dlc
    {["faction"] = "", ["subtype"] = "wax_emp_valten"}
} --:vector<map<string, string>> 
    --CATAPH TEB--
local teb_agents = {
    {["faction"] = "wh_main_teb_tilea", ["subtype"] = "teb_borgio_the_besiege"},
    {["faction"] = "wh_main_teb_tilea", ["subtype"] = "teb_tilea"},
    {["faction"] = "wh_main_teb_tobaro", ["subtype"] = "teb_lucrezzia_belladonna"},
    {["faction"] = "wh_main_teb_border_princes", ["subtype"] = "teb_gashnag"},
    {["faction"] = "wh_main_teb_border_princes", ["subtype"] = "teb_border_princes"},
    {["faction"] = "wh_main_teb_estalia", ["subtype"] = "teb_estalia"},
    {["faction"] = "wh2_main_emp_new_world_colonies", ["subtype"] = "teb_new_world_colonies"},
    {["faction"] = "wh2_main_emp_new_world_colonies", ["subtype"] = "teb_colombo"}
} --:vector<map<string, string>> 
    --CATAPH Kraka Drak--
local kraka_agents = {
    {["faction"] = "wh_main_dwf_kraka_drak", ["subtype"] = "dwf_kraka_drak"}
} --:vector<map<string, string>> 
    --Project Resurrection - Parte Legendary Lords--
local parte_agents = {
    {["faction"] = "wh2_main_def_karond_kar", ["subtype"] = "def_rakarth"},
    {["faction"] = "wh2_main_skv_clan_moulder", ["subtype"] = "skv_skweel_gnawtooth"},
    {["faction"] = "wh2_main_def_blood_hall_coven", ["subtype"] = "def_hag_queen_malida"},
    {["faction"] = "wh2_main_hef_cothique", ["subtype"] = "hef_aislinn"},
    {["faction"] = "wh_main_dwf_barak_varr", ["subtype"] = "dwf_byrrnoth_grundadrakk"},
    {["faction"] = "wh_main_dwf_karak_ziflin", ["subtype"] = "dwf_rorek_granitehand"},
    {["faction"] = "wh_main_dwf_karak_hirn", ["subtype"] = "dwf_alrik_ranulfsson"}
} --:vector<map<string, string>> 
    --We'z Speshul--
local speshul_agents = {
    {["faction"] = "wh_main_grn_greenskins", ["subtype"] = "spcha_grn_borgut_facebeater"},
    {["faction"] = "wh_main_grn_orcs_of_the_bloody_hand", ["subtype"] = "spcha_grn_grokka_goreaxe"},
    {["faction"] = "", ["subtype"] = "spcha_grn_tinitt_foureyes"}, -- wh_main_grn_black_venom -- wh2_main_grn_arachnos 
    {["faction"] = "wh2_main_grn_blue_vipers", ["subtype"] = "spcha_grn_grak_beastbasha"},
    {["faction"] = "wh_main_grn_crooked_moon", ["subtype"] = "spcha_grn_duffskul"},
    {["faction"] = "", ["subtype"] = "spcha_grn_snagla_grobspit"} -- wh_main_grn_black_venom -- wh2_main_grn_arachnos 
} --:vector<map<string, string>> 
    --Whysofurious' Additional Lords & Heroes--
local wsf_agents = {
    {["faction"] = "wh_main_emp_empire", ["subtype"] = "genevieve"},
    {["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "helsnicht"},
    {["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "konrad"},
    {["faction"] = "wh_main_vmp_mousillon", ["subtype"] = "mallobaude"},
    --{["faction"] = "", ["subtype"] = "sycamo"},
    {["faction"] = "wh2_main_vmp_necrarch_brotherhood", ["subtype"] = "zacharias"}
} --:vector<map<string, string>> 
    --Ordo Draconis - Templehof Expanded--
local ordo_agents = {
    {["faction"] = "wh_main_vmp_rival_sylvanian_vamps", ["subtype"] = "abhorash"},
    {["faction"] = "wh_main_vmp_rival_sylvanian_vamps", ["subtype"] = "vmp_walach_harkon_hero"},
    {["faction"] = "wh_main_vmp_rival_sylvanian_vamps", ["subtype"] = "tib_kael"}
} --:vector<map<string, string>> 
    --WsF' Vampire Bloodlines: The Strigoi--
local strigoi_agents = {
    {["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "ushoran"},
    {["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "vorag"},
    {["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "str_high_priest"},
    {["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "nanosh"}
} --:vector<map<string, string>> 
    --OvN Second Start--
local second_start_agents = {
    --{["faction"] = "wh2_main_hef_yvresse", ["subtype"] = "sr_grim"}
} --:vector<map<string, string>> 
    --OvN Lost Factions - Beta--
local lost_factions_agents = {
    --{["faction"] = "", ["subtype"] = "ovn_hlf_ll"},
    --{["faction"] = "", ["subtype"] = "ovn_araby_ll"},
    --{["faction"] = "", ["subtype"] = "Sultan_Jaffar"},
    --{["faction"] = "", ["subtype"] = "morgan_bernhardt"}
} --:vector<map<string, string>> 
    --Empire Master Engineer
local zf_agents = {
    {["faction"] = "", ["subtype"] = "wh_main_emp_jubal_falk"}
} --:vector<map<string, string>> 
    --Cataph's High Elf Sea Patrol
local seahelm_agents = {
    {["faction"] = "", ["subtype"] = "AK_aislinn"}
} --:vector<map<string, string>> 
--Mixu's: Vangheist's Revenge
local mixu_vangheist = {
    {["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_vangheist", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_the_white_death", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_tia_drowna", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_dreng_gunddadrak", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_khoskog", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"}
} --:vector<map<string, string>> 

local alastar_quests = {
    { "wh2_main_anc_armour_lions_pelt", 1}
} --:vector<{string, number}>

local locked_ai_generals = {
    {["id"] = "2140784160",	["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "pro01_dwf_grombrindal"},                         -- Grombrindal
    --{["id"] = "2140783606",	["faction"] = "wh_main_grn_greenskins", ["subtype"] = "grn_azhag_the_slaughterer"},             -- Azhag the Slaughterer
    {["id"] = "2140784146",	["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "dlc04_vmp_helman_ghorst"},               -- Helman Ghorst
    {["id"] = "2140784202",	["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "pro02_vmp_isabella_von_carstein"},        -- Isabella von Carstein
    --{["id"] = "2140783648",	["faction"] = "wh2_dlc13_emp_golden_order", ["subtype"] = "emp_balthasar_gelt"},                -- Balthasar Gelt
    {["id"] = "2140784136",	["faction"] = "wh_main_emp_empire", ["subtype"] = "dlc04_emp_volkmar"},                             -- Volkmar the Grim
    --{["id"] = "",	["faction"] = "wh2_main_hef_eataine", ["subtype"] = "wh2_main_hef_prince_alastar"},                         -- Alastar
    {["id"] = "2140784127",	["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "dlc03_bst_malagor"},                          -- Malagor
    {["id"] = "2140784189",	["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "dlc05_bst_morghur"}                           -- Morghur
} --:vector<map<string, string>> 

-- "major" factions
local playable_factions = { 
    "wh2_main_hef_eataine",
    "wh2_main_hef_order_of_loremasters",
    "wh2_main_hef_avelorn",
    "wh2_main_hef_nagarythe",
    "wh2_main_lzd_hexoatl",
    "wh2_main_lzd_last_defenders",
    "wh2_dlc13_lzd_spirits_of_the_jungle",
    "wh2_dlc12_lzd_cult_of_sotek",
    "wh2_main_lzd_itza",
    "wh2_main_lzd_tlaqua",
    "wh2_main_def_naggarond",
    "wh2_main_def_cult_of_pleasure",
    "wh2_main_def_har_ganeth",
    "wh2_dlc11_def_the_blessed_dread",
    "wh2_main_def_hag_graef",
    "wh2_main_skv_clan_mors",
    "wh2_main_skv_clan_pestilens",
    "wh2_dlc09_skv_clan_rictus",
    "wh2_main_skv_clan_skyre",
    "wh2_main_skv_clan_eshin",
    "wh2_dlc11_cst_vampire_coast",
    "wh2_dlc11_cst_noctilus",
    "wh2_dlc11_cst_pirates_of_sartosa",
    "wh2_dlc11_cst_the_drowned",
    "wh2_dlc09_tmb_khemri",
    "wh2_dlc09_tmb_lybaras",
    "wh2_dlc09_tmb_followers_of_nagash",
    "wh2_dlc09_tmb_exiles_of_nehek",
    "wh_main_emp_empire",
    "wh2_dlc13_emp_golden_order",
    "wh2_dlc13_emp_the_huntmarshals_expedition",
    "wh_main_dwf_dwarfs",
    "wh_main_dwf_karak_izor",
    "wh_main_dwf_karak_kadrin",
    "wh_main_grn_greenskins",
    "wh_main_grn_crooked_moon",
    "wh_main_grn_orcs_of_the_bloody_hand",
    "wh_main_vmp_vampire_counts",
    "wh_main_vmp_schwartzhafen",
    "wh2_dlc11_vmp_the_barrow_legion",
    "wh_dlc08_nor_norsca",
    "wh_dlc08_nor_wintertooth",
    "wh_main_brt_bretonnia",
    "wh_main_brt_bordeleaux",
    "wh_main_brt_carcassonne",
    "wh2_dlc14_brt_chevaliers_de_lyonesse",
    "wh_dlc05_wef_wood_elves",
    "wh_dlc05_wef_argwylon",
    "wh_dlc03_bst_beastmen",
    "wh_main_chs_chaos",
    "wh2_dlc15_hef_imrik",
    "wh2_main_hef_yvresse",
    "wh2_dlc15_grn_broken_axe"
} --:vector<string>

local vor_subtype_anc = {
    ["wh2_main_hef_tyrion"] = {
		{"mission", "wh2_main_anc_armour_dragon_armour_of_aenarion", "wh2_main_great_vortex_hef_tyrion_dragon_armour_of_aenarion_stage_1", 6, "wh2_main_great_vortex_hef_tyrion_dragon_armour_of_aenarion_stage_4_mpc", "war.camp.advice.quest.tyrion.dragon_armour_of_aenarion.001"},
		{"mission", "wh2_main_anc_weapon_sunfang", "wh2_main_great_vortex_hef_tyrion_sunfang_stage_1", 10, "wh2_main_great_vortex_hef_tyrion_sunfang_stage_4_mpc", "war.camp.advice.quest.tyrion.sunfang.001"},
        {"mission", "wh2_main_anc_enchanted_item_heart_of_avelorn", "wh2_main_vortex_narrative_hef_the_phoenix_gate", 14}
    },
    ["wh2_main_hef_teclis"] = {
		{"mission", "wh2_main_anc_arcane_item_war_crown_of_saphery", "wh2_main_great_vortex_hef_teclis_war_crown_of_saphery_stage_1", 6, "wh2_main_great_vortex_hef_teclis_war_crown_of_saphery_stage_3_mpc", "war.camp.advice.quest.teclis.war_crown_of_saphery.001"},
		{"mission", "wh2_main_anc_weapon_sword_of_teclis", "wh2_main_great_vortex_hef_teclis_sword_of_teclis_stage_1", 10, "wh2_main_great_vortex_hef_teclis_sword_of_teclis_stage_3_mpc", "war.camp.advice.quest.teclis.sword_of_teclis.001"},
        {"mission", "wh2_main_anc_arcane_item_scroll_of_hoeth", "wh2_main_vortex_narrative_hef_the_lies_of_the_druchii", 14},
        {"mission", "wh2_main_anc_arcane_item_moon_staff_of_lileath", "wh2_main_vortex_narrative_hef_the_vermin_of_hruddithi", 18}
    },
    ["wh2_dlc10_hef_alarielle"] = {
        {"mission", "wh2_dlc10_anc_talisman_shieldstone_of_isha", "wh2_dlc10_vortex_alarielle_shieldstone_of_isha_1", 2},
		{"mission", "wh2_dlc10_anc_enchanted_item_star_of_avelorn", "wh2_dlc10_great_vortex_hef_alarielle_star_of_avelorn_stage_1", 15, "wh2_dlc10_great_vortex_hef_alarielle_star_of_avelorn_stage_5_mpc"}
    },
    ["wh2_dlc10_hef_alith_anar"] = {
        {"mission", "wh2_dlc10_anc_enchanted_item_the_shadow_crown", "wh2_dlc10_great_vortex_hef_alith_anar_the_shadow_crown", 2},
		{"mission", "wh2_dlc10_anc_weapon_moonbow", "wh2_dlc10_great_vortex_hef_alith_anar_the_moonbow_stage_1", 5, "wh2_dlc10_great_vortex_hef_alith_anar_the_moonbow_stage_4_mpc"}
    },
    ["wh2_dlc15_hef_eltharion"] = {
		{"mission","wh2_dlc15_anc_talisman_talisman_of_hoeth","wh2_dlc15_vortex_hef_eltharion_talisman_of_hoeth_stage_1",5,"wh2_dlc15_vortex_hef_eltharion_talisman_of_hoeth_stage_3_mpc"},
		{"mission","wh2_dlc15_anc_armour_helm_of_yvresse","wh2_dlc15_vortex_hef_eltharion_helm_of_yvresse_stage_1",7},
		{"mission","wh2_dlc15_anc_weapon_fangsword_of_eltharion","wh2_dlc15_vortex_hef_eltharion_fangsword_of_eltharion_stage_1",10}
    },
    ["wh2_dlc15_hef_imrik"] = {
        {"mission","wh2_dlc15_anc_armour_armour_of_caledor","wh2_dlc15_vortex_hef_imrik_armour_of_caledor_stage_1",5,"wh2_dlc15_vortex_hef_imrik_armour_of_caledor_stage_3_mpc"},
	},
    ["wh2_main_def_malekith"] = {
		{"mission", "wh2_main_anc_arcane_item_circlet_of_iron", "wh2_main_great_vortex_def_malekith_circlet_of_iron_stage_1", 6, "wh2_main_great_vortex_def_malekith_circlet_of_iron_stage_3_mpc", "war.camp.advice.quest.malekith.circlet_of_iron.001"},
		{"mission", "wh2_main_anc_weapon_destroyer", "wh2_main_great_vortex_def_malekith_destroyer_stage_1", 10, "wh2_main_great_vortex_def_malekith_destroyer_stage_3_mpc", "war.camp.advice.quest.malekith.destroyer.001"},
		{"mission", "wh2_main_anc_armour_supreme_spellshield", "wh2_main_great_vortex_def_malekith_supreme_spellshield_stage_1", 14, "wh2_main_great_vortex_def_malekith_supreme_spellshield_stage_3_mpc", "war.camp.advice.quest.malekith.supreme_spellshield.001"},
        {"mission", "wh2_main_anc_armour_armour_of_midnight", "wh2_main_vortex_narrative_def_hoteks_levy", 18}
    },
    ["wh2_main_def_morathi"] = {
		{"mission", "wh2_main_anc_weapon_heartrender_and_the_darksword", "wh2_main_great_vortex_def_morathi_heartrender_and_the_darksword_stage_1", 6, "wh2_main_great_vortex_def_morathi_heartrender_and_the_darksword_stage_6_mpc", "war.camp.advice.quest.morathi.heartrender_and_the_darksword.001"},
        {"mission", "wh2_main_anc_arcane_item_wand_of_the_kharaidon", "wh2_dlc14_def_wand_of_kharaidon", 4},
        {"mission", "wh2_main_anc_talisman_amber_amulet", "wh2_dlc14_def_amber_amulet", 2}
    },
    ["wh2_dlc10_def_crone_hellebron"] = {
		{"mission", "wh2_dlc10_anc_weapon_deathsword_and_the_cursed_blade", "wh2_dlc10_great_vortex_def_hellebron_deathsword_and_the_cursed_blade_stage_1", 8, "wh2_dlc10_great_vortex_def_hellebron_deathsword_and_the_cursed_blade_stage_4_mpc"},
        {"mission", "wh2_dlc10_anc_talisman_amulet_of_dark_fire", "wh2_dlc10_great_vortex_def_hellebron_amulet_of_dark_fire_stage_1", 2}
    },
    ["wh2_dlc14_def_malus_darkblade"] = {
		{"mission", "wh2_dlc14_anc_weapon_warpsword_of_khaine", "wh2_dlc14_vortex_def_malus_warpsword_of_khaine_stage_1", 5, "wh2_dlc14_vortex_def_malus_warpsword_of_khaine_stage_4_mpc"}
    },
    ["wh2_main_lzd_lord_mazdamundi"] = {
		{"mission", "wh2_main_anc_magic_standard_sunburst_standard_of_hexoatl", "wh2_main_great_vortex_lzd_mazdamundi_sunburst_standard_of_hexoatl_stage_1", 6, "wh2_main_great_vortex_lzd_mazdamundi_sunburst_standard_of_hexoatl_stage_4_mpc", "war.camp.advice.quest.mazdamundi.sunburst_standard_of_hexoatl.001"},
		{"mission", "wh2_main_anc_weapon_cobra_mace_of_mazdamundi", "wh2_main_great_vortex_lzd_mazdamundi_cobra_mace_of_mazdamundi_stage_1", 10, "wh2_main_great_vortex_lzd_mazdamundi_cobra_mace_of_mazdamundi_stage_3_mpc", "war.camp.advice.quest.mazdamundi.cobra_mace_of_mazdamundi.001"}
    },
    ["wh2_main_lzd_kroq_gar"] = {
		{"mission", "wh2_main_anc_weapon_revered_spear_of_tlanxla", "wh2_main_great_vortex_liz_kroq_gar_revered_spear_of_tlanxla_stage_1", 6, "wh2_main_great_vortex_liz_kroq_gar_revered_spear_of_tlanxla_stage_3_mpc", "war.camp.advice.quest.kroqgar.revered_spear_of_tlanxla.001"},
		{"mission", "wh2_main_anc_enchanted_item_hand_of_gods", "wh2_main_great_vortex_liz_kroq_gar_hand_of_gods_stage_1", 10, "wh2_main_great_vortex_liz_kroq_gar_hand_of_gods_stage_3_mpc", "war.camp.advice.quest.kroqgar.hand_of_gods.001"}
    },
    ["wh2_dlc12_lzd_tehenhauin"] = {
        {"mission", "wh2_dlc12_anc_enchanted_item_plaque_of_sotek", "wh2_dlc12_great_vortex_lzd_tehenhauin_plaque_of_sotek_stage_1", 8, "wh2_dlc12_great_vortex_lzd_tehenhauin_plaque_of_sotek_mp"}
    },
    ["wh2_dlc12_lzd_tiktaqto"] = {
        {"mission", "wh2_dlc12_anc_enchanted_item_mask_of_heavens", "wh2_dlc12_great_vortex_lzd_tiktaqto_mask_of_heavens_stage_1", 8, "wh2_dlc12_great_vortex_lzd_tiktaqto_mask_of_heavens_mp"}
    },
    ["wh2_dlc13_lzd_nakai"] = {
		{"mission", "wh2_dlc13_anc_enchanted_item_golden_tributes", "wh2_dlc13_vortex_lzd_nakai_golden_tributes_stage_1", 8, "wh2_dlc13_vortex_lzd_nakai_golden_tributes_stage_3"},
		{"mission", "wh2_dlc13_talisman_the_ogham_shard", "wh2_dlc13_vortex_lzd_nakai_the_ogham_shard_stage_1", 8, "wh2_dlc13_vortex_lzd_nakai_the_ogham_shard_stage_2"}
    },
    ["wh2_dlc13_lzd_gor_rok"] = {
		{"mission", "wh2_dlc13_anc_armour_the_shield_of_aeons", "wh2_dlc13_vortex_gorrok_the_shield_of_aeons_stage_1", 8, "wh2_dlc13_vortex_gorrok_the_shield_of_aeons_stage_3"},
        {"mission", "wh2_dlc13_anc_weapon_mace_of_ulumak", "wh2_dlc14_lzd_the_mace_of_ulumak", 2}
    },
    ["wh2_main_skv_lord_skrolk"] = {
		{"mission", "wh2_main_anc_arcane_item_the_liber_bubonicus", "wh2_main_great_vortex_skv_skrolk_liber_bubonicus_stage_1", 6, "wh2_main_great_vortex_skv_skrolk_liber_bubonicus_stage_3_mpc", "war.camp.advice.quest.skrolk.liber_bubonicus.001"},
		{"mission", "wh2_main_anc_weapon_rod_of_corruption", "wh2_main_great_vortex_skv_skrolk_rod_of_corruption_stage_1", 10, "wh2_main_great_vortex_skv_skrolk_rod_of_corruption_stage_3_mpc", "war.camp.advice.quest.skrolk.rod_of_corruption.001"}
    },
    ["wh2_main_skv_queek_headtaker"] = {
		{"mission", "wh2_main_anc_armour_warp_shard_armour", "wh2_main_great_vortex_skv_queek_headtaker_warp_shard_armour_stage_1", 6, "wh2_main_great_vortex_skv_queek_headtaker_warp_shard_armour_stage_6_mpc", "war.camp.advice.quest.queek.warp_shard_armour.001"},
		{"mission", "wh2_main_anc_weapon_dwarf_gouger", "wh2_main_great_vortex_skv_queek_headtaker_dwarfgouger_stage_1", 10, "wh2_main_great_vortex_skv_queek_headtaker_dwarfgouger_stage_4_mpc", "war.camp.advice.quest.queek.dwarfgouger.001"}
    },
    ["wh2_dlc09_skv_tretch_craventail"] = {
		{"mission", "wh2_dlc09_anc_enchanted_item_lucky_skullhelm", "wh2_dlc09_great_vortex_skv_tretch_lucky_skullhelm_stage_1", 8, "wh2_dlc09_great_vortex_skv_tretch_lucky_skullhelm_stage_5_mpc", "dlc09.camp.advice.quest.tretch.lucky_skullhelm.001"}
    },
    ["wh2_dlc12_skv_ikit_claw"] = {
        {"mission", "wh2_dlc12_anc_weapon_storm_daemon", "wh2_dlc12_great_vortex_ikit_claw_storm_daemon_stage_1", 8, "wh2_dlc12_great_vortex_ikit_claw_storm_daemon_mp"}
    },
    ["wh2_dlc14_skv_deathmaster_snikch"] = {
		{"mission", "wh2_dlc14_anc_armour_the_cloak_of_shadows", "wh2_dlc14_vortex_skv_snikch_the_cloak_of_shadows_stage_1", 5, "wh2_dlc14_vortex_skv_snikch_the_cloak_of_shadows_stage_4_mpc"},
        {"mission", "wh2_dlc14_anc_weapon_whirl_of_weeping_blades", "wh2_dlc14_vortex_skv_snikch_whirl_of_weeping_blades_stage_1", 3}
    },
    ["wh2_dlc09_tmb_settra"] = {
		{"mission", "wh2_dlc09_anc_enchanted_item_the_crown_of_nehekhara", "wh2_dlc09_great_vortex_tmb_settra_the_crown_of_nehekhara_stage_1", 6, "wh2_dlc09_great_vortex_tmb_settra_the_crown_of_nehekhara_stage_5_mpc", "dlc09.camp.advice.quest.settra.the_crown_of_nehekhara.001"},
		{"mission", "wh2_dlc09_anc_weapon_the_blessed_blade_of_ptra", "wh2_dlc09_great_vortex_tmb_settra_the_blessed_blade_of_ptra_stage_1", 13, "wh2_dlc09_great_vortex_tmb_settra_the_blessed_blade_of_ptra_stage_3_mpc", "dlc09.camp.advice.quest.settra.the_blessed_blade_of_ptra.001"}
    },
    ["wh2_dlc09_tmb_arkhan"] = {
		{"mission", "wh2_dlc09_anc_weapon_the_tomb_blade_of_arkhan", "wh2_dlc09_great_vortex_tmb_arkhan_the_tomb_blade_of_arkhan_stage_1", 6, "wh2_dlc09_great_vortex_tmb_arkhan_the_tomb_blade_of_arkhan_stage_4_mpc", "dlc09.camp.advice.quest.arkhan.the_tomb_blade_of_arkhan.001"}
    },
    ["wh2_dlc09_tmb_khatep"] = {
		{"mission", "wh2_dlc09_anc_arcane_item_the_liche_staff", "wh2_dlc09_vortex_tmb_khatep_the_liche_staff_1", 6, "wh2_dlc09_great_vortex_tmb_khatep_the_liche_staff_stage_5_mpc", "dlc09.camp.advice.quest.khatep.the_liche_staff.001"}
    },
    ["wh2_dlc09_tmb_khalida"] = {
		{"mission", "wh2_dlc09_anc_weapon_the_venom_staff", "wh2_dlc09_great_vortex_tmb_khalida_venom_staff_stage_1", 12, "wh2_dlc09_great_vortex_tmb_khalida_venom_staff_stage_3_mpc", "dlc09.camp.advice.quest.khalida.venom_staff.001"}
    },
    ["wh2_dlc11_cst_harkon"] = {
        {"mission", "wh2_dlc11_anc_enchanted_item_slann_gold", "wh2_dlc11_cst_vortex_harkon_quest_for_slann_gold_stage_1", 15, "wh2_dlc11_great_vortex_qb_cst_luthor_harkon_slann_gold_MP", "wh2_dlc11.camp.advice.quest.harkon.001"}
    },
    ["wh2_dlc11_cst_noctilus"] = {
        {"mission", "wh2_dlc11_anc_enchanted_item_captain_roths_moondial", "wh2_dlc11_cst_vortex_noctilus_captain_roths_moondial_stage_1", 15, "wh2_dlc11_great_vortex_qb_cst_noctilus_captain_roths_moondial_MP", "wh2_dlc11.camp.advice.quest.noctilus.001"}
    },
    ["wh2_dlc11_cst_aranessa"] = {
        {"mission", "wh2_dlc11_anc_weapon_krakens_bane", "wh2_dlc11_great_vortex_cst_aranessa_krakens_bane_stage_1", 15, "wh2_dlc11_great_vortex_qb_cst_aranessa_saltspite_krakens_bane_MP", "wh2_dlc11.camp.advice.quest.aranessa.001"}
    },
    ["wh2_dlc11_cst_cylostra"] = {
        {"mission", "wh2_dlc11_anc_arcane_item_the_bordeleaux_flabellum", "wh2_dlc11_great_vortex_cst_cylostra_the_bordeleaux_flabellum_stage_1", 9, "wh2_dlc11_great_vortex_cylostra_the_bordeleaux_flabellum_mp", "wh2_dlc11.camp.advice.quest.cylostra.001"}
    },
    ["wh2_dlc11_def_lokhir"] = {
        {"mission", "wh2_main_anc_armour_helm_of_the_kraken", "wh2_dlc11_great_vortex_lokhir_helm_of_the_kraken_stage_1", 11, "wh2_dlc11_great_vortex_lokhir_fellheart_helm_of_the_kraken_mp", "wh2_dlc11.camp.advice.quest.lokhir.001"},
        {"mission", "wh2_dlc11_anc_weapon_red_blades", "wh2_dlc11_great_vortex_def_lokhir_red_blades_stage_1", 2}
    },
    ["wh2_dlc13_emp_cha_markus_wulfhart_0"] = {
		{"mission", "wh2_dlc13_anc_weapon_amber_bow", "wh2_dlc13_emp_wulfhart_vor_amber_bow_stage_1", 8,"wh2_dlc13_vortex_emp_wulfhart_amber_bow_stage_4"}
    },
    ["wh2_dlc14_brt_repanse"] = {
		{"mission", "wh2_dlc14_anc_weapon_sword_of_lyonesse", "wh2_dlc14_vortex_brt_repanse_sword_of_lyonesse_stage_1", 5, "wh2_dlc14_vortex_brt_repanse_sword_of_lyonesse_stage_4_mpc"}
    },
    ["wh2_dlc15_grn_grom_the_paunch"] = {
		{"mission", "wh2_dlc15_anc_weapon_axe_of_grom", "wh2_dlc15_vortex_grn_grom_axe_of_grom_stage_1", 5,"wh2_dlc15_vortex_grn_grom_axe_of_grom_stage_4_mpc"},
		{"mission", "wh2_dlc15_anc_enchanted_item_lucky_banner", "wh2_dlc15_main_grn_grom_lucky_banner_stage_1", 2}
    },
    --mixu
    ["brt_adalhard"] = {
        {"", "mixu_anc_armour_brt_adalhard_lions_cloak", "", 12}
    },
    ["brt_bohemond"] = {
        {"", "mixu_anc_armour_brt_bohemond_bohemonds_shield", "", 12}
    },
    ["brt_chilfroy"] = {
        {"", "mixu_anc_weapon_brt_chilfroy_lance_of_artois", "", 13},
        {"", "mixu_anc_enchanted_item_brt_chilfroy_antlers_of_the_great_hunt", "", 9}
    },
    ["brt_cassyon"] = {
        {"", "mixu_anc_weapon_brt_cassyon_the_glorfinial", "", 13}
    },
    ["mixu_elspeth_von_draken"] = {
        {"", "mixu_anc_weapon_emp_elspeth_von_draken_the_pale_scythe", "", 17},
        {"", "mixu_anc_arcane_item_emp_elspeth_von_draken_deaths_timekeeper", "", 12}
    },
    ["mixu_katarin_the_ice_queen"] = {
        {"", "mixu_anc_enchanted_item_ksl_katarin_the_ice_queen_crystal_cloak", "", 9},
        {"", "mixu_anc_weapon_ksl_katarin_the_ice_queen_fearfrost", "", 15}
    },
    ["emp_theoderic_gausser"] = {
        {"", "mixu_anc_enchanted_item_emp_theoderic_gausser_sea_dragon_cloak", "", 10}
    },
    ["wef_daith"] = {
        {"", "mixu_anc_armour_wef_daith_the_oaken_armour", "", 15}
    },
    ["dwf_kazador_dragonslayer"] = {
        {"", "mixu_anc_armour_dwf_kazador_dragonslayer_armour_of_karak_azul", "", 9},
        {"", "mixu_anc_weapon_dwf_kazador_dragonslayer_hammer_karak_azul", "", 15}
    },
    ["dwf_thorek_ironbrow"] = {
        {"", "mixu_anc_weapon_dwf_thorek_ironbrow_klad_brakak", "", 15},
        {"", "mixu_anc_armour_dwf_thorek_ironbrow_thoreks_rune_armour", "", 9}
    },
    ["emp_edward_van_der_kraal"] = {
        {"", "mixu_anc_enchanted_item_emp_edward_van_der_kraal_the_cursed_skull", "", 15}
    },
    ["emp_theodore_bruckner"] = {
        {"", "mixu_anc_talisman_emp_theodore_bruckner_baleflame_amulet", "", 5},
        {"", "mixu_anc_weapon_emp_theodore_bruckner_liarsbane", "", 10}
    },
    ["brt_almaric_de_gaudaron"] = {
        {"", "mixu_anc_talisman_brt_almaric_de_gaudaron_the_icon_of_the_lady", "", 10}
    },
    ["dlc03_emp_boris_todbringer"] = {
        {"", "mixu_anc_enchanted_item_emp_boris_todbringer_talisman_of_ulric", "", 15}
    },
    ["emp_vorn_thugenheim"] = {
        {"", "mixu_anc_talisman_emp_vorn_thugenheim_heart_of_middenheim", "", 15},
        {"", "mixu_anc_enchanted_item_emp_vorn_thugenheim_pelt_of_horrors", "", 10}
    },
    ["bst_taurox"] = {
        {"", "mixu_anc_weapon_bst_taurox_the_brass_bull_rune_tortured_axes", "", 13}
    },
    ["emp_wolfram_hertwig"] = {
        {"", "mixu_anc_talisman_emp_wolfram_hertwig_kislevite_icon", "", 14}
    }
} --:map<string, vector<vector<WHATEVER>>>

local vor_missing_anc = {
    ["wh2_dlc10_hef_alarielle"] = {
        {"", "wh2_dlc10_anc_magic_standard_banner_of_avelorn", "", 1},
        {"", "wh2_dlc10_anc_arcane_item_stave_of_avelorn", "", 1}
    },
    ["wh2_dlc12_skv_ikit_claw"] = {
        {"", "wh2_dlc12_anc_armour_iron_frame", "", 1}
    },
    ["dlc06_grn_skarsnik"] = {
        {"", "wh_dlc06_anc_magic_standard_skarsniks_boyz", "", 1}
    },
    ["wh2_dlc12_lzd_tehenhauin"] = {
        {"", "wh2_dlc12_anc_weapon_blade_of_the_serpents_tongue", "", 1}
    },
    ["grn_grimgor_ironhide"] = {
        {"", "wh_main_anc_magic_standard_da_immortulz", "", 1}
    },
    ["wh2_main_hef_prince_alastar"] = {
        {"", "wh2_main_anc_armour_lions_pelt", "", 1}
    },
    ["dlc03_emp_boris_todbringer"] = {
        {"", "wh_main_anc_talisman_the_white_cloak_of_ulric", "", 1}
    },
    ["wh2_dlc10_hef_alith_anar"] = {
        {"", "wh2_dlc10_anc_talisman_stone_of_midnight", "", 1}
    },
    ["vmp_heinrich_kemmler"] = {
        {"", "wh2_dlc11_anc_follower_vmp_the_ravenous_dead", "", 1}
    },
    ["wh2_dlc12_lzd_tiktaqto"] = {
        {"", "wh2_dlc12_anc_weapon_the_blade_of_ancient_skies", "", 1}
    },
    ["wh2_dlc11_cst_harkon"] = {
        {"", "wh2_dlc11_anc_follower_captain_drekla", "", 1},
    },
    ["wh2_dlc15_hef_imrik"] = {
        {"", "wh2_dlc15_anc_weapon_star_lance", "", 1},
    }
} --:map<string, vector<vector<WHATEVER>>>

local me_subtype_anc = {
    ["emp_karl_franz"] = {
        {"mission", "wh2_dlc13_anc_weapon_runefang_drakwald", "wh_main_emp_karl_franz_reikland_runefang_stage_1", 3, "wh_main_emp_karl_franz_reikland_runefang_stage_3a_mpc"},
        {"mission", "wh_main_anc_weapon_ghal_maraz", "wh_main_emp_karl_franz_ghal_maraz_stage_1", 14,"wh_main_emp_karl_franz_ghal_maraz_stage_3.1_mpc"},
        {"mission", "wh_main_anc_talisman_the_silver_seal", "wh_main_emp_karl_franz_silver_seal_stage_1", 8}
    },
    ["emp_balthasar_gelt"] = {
        {"mission", "wh_main_anc_enchanted_item_cloak_of_molten_metal", "wh_main_emp_balthasar_gelt_cloak_of_molten_metal_stage_1", 4,"wh_main_emp_balthasar_gelt_cloak_of_molten_metal_stage_5a_mpc"},
        {"mission", "wh_main_anc_talisman_amulet_of_sea_gold", "wh_main_emp_balthasar_gelt_amulet_of_sea_gold_stage_1.1", 8,"wh_main_emp_balthasar_gelt_amulet_of_sea_gold_stage_4.1a_mpc"},
        {"mission", "wh_main_anc_arcane_item_staff_of_volans", "wh_main_emp_balthasar_gelt_staff_of_volans_stage_1", 14,"wh_main_qb_emp_balthasar_gelt_staff_of_volans_stage_3_battle_of_bloodpine_woods_mpc"}
    },
    ["dlc04_emp_volkmar"] = {
        {"mission", "wh_dlc04_anc_talisman_jade_griffon", "wh_dlc04_emp_volkmar_the_grim_jade_griffon_stage_1", 5,"wh_dlc04_emp_volkmar_the_grim_jade_griffon_stage_4_mpc"},
        {"mission", "wh_dlc04_anc_weapon_staff_of_command", "wh_dlc04_emp_volkmar_the_grim_staff_of_command_stage_1", 10,"wh_dlc04_emp_volkmar_the_grim_staff_of_command_stage_5_mpc"}
    },
    ["wh2_dlc13_emp_cha_markus_wulfhart_0"] = {
        {"mission", "wh2_dlc13_anc_weapon_amber_bow", "wh2_dlc13_emp_wulfhart_amber_bow_stage_1", 8,"wh2_dlc13_emp_wulfhart_amber_bow_stage_4"}
    },
    ["dwf_thorgrim_grudgebearer"] = {
        {"mission", "wh_main_anc_weapon_the_axe_of_grimnir", "wh_main_dwf_thorgrim_grudgebearer_axe_of_grimnir_stage_1", 8,"wh_main_dwf_thorgrim_grudgebearer_axe_of_grimnir_stage_3a_mpc"},
        {"mission", "wh_main_anc_armour_the_armour_of_skaldour", "wh_main_dwf_thorgrim_grudgebearer_armour_of_skaldour_stage_1", 13,"wh_main_dwf_thorgrim_grudgebearer_armour_of_skaldour_stage_4a_mpc"},
        {"mission", "wh_main_anc_talisman_the_dragon_crown_of_karaz", "wh_main_dwf_thorgrim_grudgebearer_dragon_crown_of_karaz_stage_1", 18,"wh_main_dwf_thorgrim_grudgebearer_dragon_crown_of_karaz_stage_3a_mpc"},
        {"mission", "wh_main_anc_enchanted_item_the_great_book_of_grudges", "wh_main_dwf_thorgrim_grudgebearer_book_of_grudges_stage_1", 23,"wh_main_dwf_thorgrim_grudgebearer_book_of_grudges_stage_2_mpc"}
    },
    ["dwf_ungrim_ironfist"] = {
        {"mission", "wh_main_anc_armour_the_slayer_crown", "wh_main_dwf_ungrim_ironfist_slayer_crown_stage_1", 8,"wh_main_dwf_ungrim_ironfist_slayer_crown_stage_4a_mpc"},
        {"mission", "wh_main_anc_talisman_dragon_cloak_of_fyrskar", "wh_main_dwf_ungrim_ironfist_dragon_cloak_of_fyrskar_stage_1", 13,"wh_main_dwf_ungrim_ironfist_dragon_cloak_of_fyrskar_stage_3.2a_mpc"},
        {"mission", "wh_main_anc_weapon_axe_of_dargo", "wh_main_dwf_ungrim_ironfist_axe_of_dargo_stage_1", 18,"wh_main_dwf_ungrim_ironfist_axe_of_dargo_stage_3_mpc"}
    } ,
    ["pro01_dwf_grombrindal"] = {
        {"mission", "wh_pro01_anc_armour_armour_of_glimril_scales", "wh_pro01_dwf_grombrindal_amour_of_glimril_scales_stage_1", 8,"wh_pro01_dwf_grombrindal_amour_of_glimril_scales_stage_3a_b_mpc"},
        {"mission", "wh_pro01_anc_weapon_the_rune_axe_of_grombrindal", "wh_pro01_dwf_grombrindal_rune_axe_of_grombrindal_stage_1", 13,"wh_pro01_dwf_grombrindal_rune_axe_of_grombrindal_stage_3.1_mpc"},
        {"mission", "wh_pro01_anc_talisman_cloak_of_valaya", "wh_pro01_dwf_grombrindal_rune_cloak_of_valaya_stage_1", 18,"wh_pro01_dwf_grombrindal_rune_cloak_of_valaya_stage_5.1_mpc"},
        {"mission", "wh_pro01_anc_enchanted_item_rune_helm_of_zhufbar", "wh_pro01_dwf_grombrindal_rune_helm_of_zhufbar_stage_1", 23,"wh_pro01_dwf_grombrindal_rune_helm_of_zhufbar_stage_4.1_mpc"}
    },
    ["grn_grimgor_ironhide"] = {
        {"mission", "wh_main_anc_weapon_gitsnik", "wh_main_grn_grimgor_ironhide_gitsnik_stage_1", 8,"wh_main_grn_grimgor_ironhide_gitsnik_stage_4a_mpc"},
        {"mission", "wh_main_anc_armour_blood-forged_armour", "wh_main_grn_grimgor_ironhide_blood_forged_armour_stage_1.1", 13,"wh_main_grn_grimgor_ironhide_blood_forged_armour_stage_4a_mpc"}
    },
    ["grn_azhag_the_slaughterer"] = {
        {"mission", "wh_main_anc_enchanted_item_the_crown_of_sorcery", "wh_main_grn_azhag_the_slaughterer_crown_of_sorcery_stage_1", 8,"wh_main_grn_azhag_the_slaughterer_crown_of_sorcery_stage_3a_mpc"},
        {"mission", "wh_main_anc_armour_azhags_ard_armour", "wh_main_grn_azhag_the_slaughterer_azhags_ard_armour_stage_1.1", 13,"wh_main_grn_azhag_the_slaughterer_azhags_ard_armour_stage_4a_mpc"}, --{"dilemma", "wh_main_anc_armour_azhags_ard_armour", "wh_main_azhag_the_slaughterer_azhags_ard_armour_stage_1", 13,"wh_main_grn_azhag_the_slaughterer_azhags_ard_armour_stage_4a_mpc"},        
        {"mission", "wh_main_anc_weapon_slaggas_slashas", "wh_main_grn_azhag_the_slaughterer_slaggas_slashas_stage_1", 18,"wh_main_grn_azhag_the_slaughterer_slaggas_slashas_stage_4a_mpc"}
    },
    ["wh2_dlc15_grn_grom_the_paunch"] = {
		{"mission", "wh2_dlc15_anc_weapon_axe_of_grom", "wh2_dlc15_main_grn_grom_axe_of_grom_stage_1", 5,"wh2_dlc15_main_grn_grom_axe_of_grom_stage_4_mpc"},
		{"mission", "wh2_dlc15_anc_enchanted_item_lucky_banner", "wh2_dlc15_main_grn_grom_lucky_banner_stage_1", 2}
	},
    ["vmp_mannfred_von_carstein"] = {
        {"mission", "wh_main_anc_weapon_sword_of_unholy_power", "wh_main_vmp_mannfred_von_carstein_sword_of_unholy_power_stage_1", 8,"wh_main_vmp_mannfred_von_carstein_sword_of_unholy_power_stage_3_mpc"},
        {"mission", "wh_main_anc_armour_armour_of_templehof", "wh_main_vmp_mannfred_von_carstein_armour_of_templehof_stage_1", 13,"wh_main_vmp_mannfred_von_carstein_armour_of_templehof_stage_4_mpc"}
    },
    ["vmp_heinrich_kemmler"] = {
        {"mission", "wh_main_anc_weapon_chaos_tomb_blade", "wh_main_vmp_heinrich_kemmler_chaos_tomb_blade_stage_1", 8,"wh_main_vmp_heinrich_kemmler_chaos_tomb_blade_stage_4a_mpc"},
        {"mission", "wh_main_anc_enchanted_item_cloak_of_mists_and_shadows", "wh_main_vmp_heinrich_kemmler_cloak_of_mists_stage_1", 13,"wh_main_vmp_heinrich_kemmler_cloak_of_mists_stage_2a_mpc"},
        {"mission", "wh_main_anc_arcane_item_skull_staff", "wh_main_vmp_heinrich_kemmler_skull_staff_stage_1.1", 18,"wh_main_vmp_heinrich_kemmler_skull_staff_stage_3a_mpc"}
    },
    ["dlc04_vmp_vlad_con_carstein"] = {
        {"mission", "wh_dlc04_anc_weapon_blood_drinker", "wh_dlc04_vmp_vlad_von_carstein_blood_drinker_stage_1", 8,"wh_dlc04_vmp_vlad_von_carstein_blood_drinker_stage_3_mpc"},
        {"mission", "wh_dlc04_anc_talisman_the_carstein_ring", "wh_dlc04_vmp_vlad_von_carstein_the_carstein_ring_stage_1", 13,"wh_dlc04_vmp_vlad_von_carstein_the_carstein_ring_stage_4_mpc"}
    },
    ["dlc04_vmp_helman_ghorst"] = {
        {"mission", "wh_dlc04_anc_arcane_item_the_liber_noctus", "wh_dlc04_vmp_helman_ghorst_liber_noctus_stage_1", 8,"wh_dlc04_vmp_helman_ghorst_liber_noctus_stage_5_mpc"}
    },
    ["chs_archaon"] = {
        {"mission", "wh_main_anc_weapon_the_slayer_of_kings", "wh_dlc01_chs_archaon_slayer_of_kings_stage_1", 8,"wh_dlc01_chs_archaon_slayer_of_kings_stage_3a_mpc"},
        {"mission", "wh_main_anc_armour_the_armour_of_morkar", "wh_dlc01_chs_archaon_armour_of_morkar_stage_1", 13,"wh_dlc01_chs_archaon_armour_of_morkar_stage_3a_mpc"},
        {"mission", "wh_main_anc_talisman_the_eye_of_sheerian", "wh_dlc01_chs_archaon_eye_of_sheerian_stage_1", 18,"wh_dlc01_chs_archaon_eye_of_sheerian_stage_2_mpc"},
        {"mission", "wh_main_anc_enchanted_item_the_crown_of_domination", "wh_dlc01_chs_archaon_crown_of_domination_stage_1", 23,"wh_dlc01_chs_archaon_crown_of_domination_stage_2a_mpc"}
    },
    ["chs_prince_sigvald"] = {
        {"mission", "wh_main_anc_weapon_sliverslash", "wh_dlc01_chs_prince_sigvald_sliverslash_stage_1", 8,"wh_dlc01_chs_prince_sigvald_sliverslash_stage_4a_mpc"},
        {"mission", "wh_main_anc_armour_auric_armour", "wh_dlc01_chs_prince_sigvald_auric_armour_stage_1", 13,"wh_dlc01_chs_prince_sigvald_auric_armour_stage_3a_mpc"}
    },
    ["chs_kholek_suneater"] = {
        {"mission", "wh_main_anc_weapon_starcrusher", "wh_dlc01_chs_kholek_suneater_starcrusher_stage_1", 8,"wh_dlc01_chs_kholek_suneater_starcrusher_stage_2_mpc"}
    },
    ["dlc03_bst_khazrak"] = {
        {"mission", "wh_dlc03_anc_weapon_scourge", "wh_dlc03_bst_khazrak_one_eye_scourge_stage_1_grandcampaign", 8,"wh_dlc03_bst_khazrak_one_eye_scourge_stage_4a_grandcampaign_mpc"},
        {"mission", "wh_dlc03_anc_armour_the_dark_mail", "wh_dlc03_bst_khazrak_one_eye_the_dark_mail_stage_1_grandcampaign", 13,"wh_dlc03_bst_khazrak_one_eye_the_dark_mail_stage_4_grandcampaign_mpc"}
    },
    ["dlc03_bst_malagor"] = {
        {"mission", "wh_dlc03_anc_talisman_icon_of_vilification", "wh_dlc03_bst_malagor_the_dark_omen_the_icons_of_vilification_stage_1_grandcampaign", 8,"wh_dlc03_bst_malagor_the_dark_omen_the_icons_of_vilification_stage_6a_grandcampaign_mpc"}
    },
    ["dlc05_bst_morghur"] = {
        {"mission", "wh_main_anc_weapon_stave_of_ruinous_corruption", "wh_dlc05_qb_bst_morghur_stave_of_ruinous_corruption_stage_1", 8,"wh_dlc05_qb_bst_morghur_stave_of_ruinous_corruption_stage_4a_mpc"}
    },
    ["dlc06_dwf_belegar"] = {
        {"mission", "wh_dlc06_anc_armour_shield_of_defiance", "wh_dlc06_dwf_belegar_ironhammer_shield_of_defiance_stage_1", 8,"wh_dlc06_dwf_belegar_ironhammer_shield_of_defiance_stage_2a_mpc"},
        {"mission", "wh_dlc06_anc_weapon_the_hammer_of_angrund", "wh_dlc06_dwf_belegar_ironhammer_hammer_of_angrund_stage_1", 13,"wh_dlc06_dwf_belegar_ironhammer_hammer_of_angrund_stage_3a_mpc"}
    },
    ["dlc06_grn_skarsnik"] = {
        {"mission", "wh_dlc06_anc_weapon_skarsniks_prodder", "wh_dlc06_grn_skarsnik_skarsniks_prodder_stage_1", 8,"wh_dlc06_grn_skarsnik_skarsniks_prodder_stage_4a_mpc"}
    },
    ["dlc06_grn_wurrzag_da_great_prophet"] = {
        {"mission", "wh_dlc06_anc_enchanted_item_baleful_mask", "wh_dlc06_grn_wurrzag_da_great_green_prophet_baleful_mask_stage_1", 8,"wh_dlc06_grn_wurrzag_da_great_green_prophet_baleful_mask_stage_4a_mpc"},
        {"mission", "wh_dlc06_anc_arcane_item_squiggly_beast", "wh_dlc06_grn_wurrzag_da_great_green_prophet_squiggly_beast_stage_1", 13,"wh_dlc06_grn_wurrzag_da_great_green_prophet_bonewood_staff_stage_3_mpc"},
        {"mission", "wh_dlc06_anc_weapon_bonewood_staff", "wh_dlc06_grn_wurrzag_da_great_green_prophet_bonewood_staff_stage_1", 18,"wh_dlc06_grn_wurrzag_da_great_green_prophet_squiggly_beast_stage_3a_mpc"}
    },
    ["dlc05_wef_orion"] = {
        {"mission", "wh_dlc05_anc_enchanted_item_horn_of_the_wild_hunt", "wh_dlc05_wef_orion_horn_of_the_wild_stage_1", 8,"wh_dlc05_wef_orion_horn_of_the_wild_stage_3a_mpc"},
        {"mission", "wh_dlc05_anc_talisman_cloak_of_isha", "wh_dlc05_wef_orion_cloak_of_isha_stage_1", 13,"wh_dlc05_wef_orion_cloak_of_isha_stage_3a_mpc"},
        {"mission", "wh_dlc05_anc_weapon_spear_of_kurnous", "wh_dlc05_wef_orion_spear_of_kurnous_stage_1", 18,"wh_dlc05_wef_orion_spear_of_kurnous_stage_3a_mpc"}
    },
    ["dlc05_wef_durthu"] = {
        {"mission", "wh_dlc05_anc_weapon_daiths_sword", "wh_dlc05_wef_durthu_sword_of_daith_stage_1", 8,"wh_dlc05_wef_durthu_sword_of_daith_stage_4a_mpc"}
    },
    ["dlc07_brt_fay_enchantress"] = {
		{"mission", "wh_dlc07_anc_arcane_item_the_chalice_of_potions", "wh_dlc07_qb_brt_fay_enchantress_chalice_of_potions_stage_1", 9, "wh_dlc07_qb_brt_fay_enchantress_chalice_of_potions_stage_6_mpc"},
        {"mission", "wh2_dlc12_anc_arcane_item_brt_morgianas_mirror", "wh2_dlc12_brt_fay_morgianas_mirror", 6}
    },
    ["dlc07_brt_alberic"] = {
		{"incident", "wh_dlc07_anc_weapon_trident_of_manann", "wh_dlc07_qb_brt_alberic_trident_of_bordeleaux_stage_1", 3, "wh_dlc07_qb_brt_alberic_trident_of_bordeleaux_stage_8_estalian_tomb_mpc"},
        {"mission", "wh2_dlc12_anc_enchanted_item_brt_braid_of_bordeleaux", "wh2_dlc12_brt_alberic_braid_of_bordeleaux", 6}
    },
    ["brt_louen_leoncouer"] = {
		{"incident", "wh_main_anc_weapon_the_sword_of_couronne", "wh_dlc07_qb_brt_louen_sword_of_couronne_stage_0", 9, "wh_dlc07_qb_brt_louen_sword_of_couronne_stage_4_la_maisontaal_abbey_mpc"},
        {"mission", "wh2_dlc12_anc_armour_brt_armour_of_brilliance", "wh2_dlc12_brt_louen_armour_of_brilliance", 6}
    },
    ["wh2_dlc14_brt_repanse"] = {
		{"mission", "wh2_dlc14_anc_weapon_sword_of_lyonesse", "wh2_dlc14_main_brt_repanse_sword_of_lyonesse_stage_1", 5, "wh2_dlc14_main_brt_repanse_sword_of_lyonesse_stage_4_mpc"}
    },    
    ["pro02_vmp_isabella_von_carstein"] = {
		{"mission", "wh_pro02_anc_enchanted_item_blood_chalice_of_bathori", "wh_pro02_qb_vmp_isabella_von_carstein_blood_chalice_of_bathori_stage_1", 9, "wh_pro02_qb_vmp_isabella_von_carstein_blood_chalice_of_bathori_stage_8_mpc"}
    },
    ["wh2_main_hef_tyrion"] = {
		{"mission", "wh2_main_anc_weapon_sunfang", "wh2_main_hef_tyrion_sunfang_stage_1", 10, "wh2_main_hef_tyrion_sunfang_stage_4_mpc"},
		{"mission", "wh2_main_anc_armour_dragon_armour_of_aenarion", "wh2_main_hef_tyrion_dragon_armour_of_aenarion_stage_1", 6, "wh2_main_hef_tyrion_dragon_armour_of_aenarion_stage_4_mpc"},
        {"mission", "wh2_main_anc_enchanted_item_heart_of_avelorn", "wh2_dlc14_hef_me_anc_enchanted_item_heart_of_avelorn", 2}
    },
    ["wh2_main_hef_teclis"] = {
		{"mission", "wh2_main_anc_weapon_sword_of_teclis", "wh2_main_hef_teclis_sword_of_teclis_stage_1", 10, "wh2_main_hef_teclis_sword_of_teclis_stage_3_mpc"},
		{"mission", "wh2_main_anc_arcane_item_war_crown_of_saphery", "wh2_main_hef_teclis_war_crown_of_saphery_stage_1", 6, "wh2_main_hef_teclis_war_crown_of_saphery_stage_3_mpc"},
        {"mission", "wh2_main_anc_arcane_item_scroll_of_hoeth", "wh2_main_vortex_narrative_hef_the_lies_of_the_druchii", 2},
		{"mission", "wh2_main_anc_arcane_item_moon_staff_of_lileath", "wh2_main_vortex_narrative_hef_the_vermin_of_hruddithi", 4}
    },
    ["wh2_dlc10_hef_alarielle"] = {
        {"mission", "wh2_dlc10_anc_talisman_shieldstone_of_isha", "wh2_dlc10_alarielle_shieldstone_of_isha_1", 2},
		{"mission", "wh2_dlc10_anc_enchanted_item_star_of_avelorn", "wh2_dlc10_hef_alarielle_star_of_avelorn_stage_1", 15, "wh2_dlc10_hef_alarielle_star_of_avelorn_stage_5_mpc"}
    },
    ["wh2_dlc10_hef_alith_anar"] = {
        {"mission", "wh2_dlc10_anc_enchanted_item_the_shadow_crown", "wh2_dlc10_hef_alith_anar_the_shadow_crown", 2},
		{"mission", "wh2_dlc10_anc_weapon_moonbow", "wh2_dlc10_hef_alith_anar_the_moonbow_stage_1", 5, "wh2_dlc10_hef_alith_anar_the_moonbow_stage_4_mpc"}
    },
    ["wh2_dlc15_hef_eltharion"] = {
		{"mission","wh2_dlc15_anc_talisman_talisman_of_hoeth","wh2_dlc15_main_hef_eltharion_talisman_of_hoeth_stage_1",5,"wh2_dlc15_main_hef_eltharion_talisman_of_hoeth_stage_3_mpc"},
		{"mission","wh2_dlc15_anc_armour_helm_of_yvresse","wh2_dlc15_vortex_hef_eltharion_helm_of_yvresse_stage_1",7},
		{"mission","wh2_dlc15_anc_weapon_fangsword_of_eltharion","wh2_dlc15_vortex_hef_eltharion_fangsword_of_eltharion_stage_1",10}
    },
    ["wh2_dlc15_hef_imrik"] = {
		{"mission","wh2_dlc15_anc_armour_armour_of_caledor","wh2_dlc15_main_hef_imrik_armour_of_caledor_stage_1",5,"wh2_dlc15_main_hef_imrik_armour_of_caledor_stage_3_mpc"}
	},
    ["wh2_main_def_malekith"] = {
		{"mission", "wh2_main_anc_weapon_destroyer", "wh2_main_def_malekith_destroyer_stage_1", 10, "wh2_main_def_malekith_destroyer_stage_3_mpc"},
		{"mission", "wh2_main_anc_arcane_item_circlet_of_iron", "wh2_main_def_malekith_circlet_of_iron_stage_1", 6, "wh2_main_def_malekith_circlet_of_iron_stage_3_mpc"},
		{"mission", "wh2_main_anc_armour_supreme_spellshield", "wh2_main_def_malekith_supreme_spellshield_stage_1", 14, "wh2_main_def_malekith_supreme_spellshield_stage_3_mpc"},
        {"mission", "wh2_main_anc_armour_armour_of_midnight", "wh2_main_vortex_narrative_def_hoteks_levy", 2}
    },
    ["wh2_main_def_morathi"] = {
		{"mission", "wh2_main_anc_weapon_heartrender_and_the_darksword", "wh2_main_def_morathi_heartrender_and_the_darksword_stage_1", 6, "wh2_main_def_morathi_heartrender_and_the_darksword_stage_6_mpc"},
        {"mission", "wh2_main_anc_arcane_item_wand_of_the_kharaidon", "wh2_dlc14_def_wand_of_kharaidon", 4},
		{"mission", "wh2_main_anc_talisman_amber_amulet", "wh2_dlc14_def_amber_amulet", 2}
    },
    ["wh2_dlc10_def_crone_hellebron"] = {
		{"mission", "wh2_dlc10_anc_weapon_deathsword_and_the_cursed_blade", "wh2_dlc10_def_hellebron_deathsword_and_the_cursed_blade_stage_1", 8, "wh2_dlc10_def_hellebron_deathsword_and_the_cursed_blade_stage_4_mpc"},
        {"mission", "wh2_dlc10_anc_talisman_amulet_of_dark_fire", "wh2_dlc10_def_hellebron_amulet_of_dark_fire_stage_1", 2}
    },
    ["wh2_dlc14_def_malus_darkblade"] = {
		{"mission", "wh2_dlc14_anc_weapon_warpsword_of_khaine", "wh2_dlc14_main_def_malus_warpsword_of_khaine_stage_1", 5, "wh2_dlc14_main_def_malus_warpsword_of_khaine_stage_4_mpc"}
    },
    ["wh2_main_lzd_lord_mazdamundi"] = {
		{"mission", "wh2_main_anc_weapon_cobra_mace_of_mazdamundi", "wh2_main_lzd_mazdamundi_cobra_mace_of_mazdamundi_stage_1", 10, "wh2_main_lzd_mazdamundi_cobra_mace_of_mazdamundi_stage_3_mpc"},
		{"mission", "wh2_main_anc_magic_standard_sunburst_standard_of_hexoatl", "wh2_main_lzd_mazdamundi_sunburst_standard_of_hexoatl_stage_1", 6, "wh2_main_lzd_mazdamundi_sunburst_standard_of_hexoatl_stage_4_mpc"}
    },
    ["wh2_main_lzd_kroq_gar"] = {
		{"mission", "wh2_main_anc_enchanted_item_hand_of_gods", "wh2_main_liz_kroq_gar_hand_of_gods_stage_1", 10, "wh2_main_liz_kroq_gar_hand_of_gods_stage_3_mpc"},
		{"mission", "wh2_main_anc_weapon_revered_spear_of_tlanxla", "wh2_main_liz_kroq_gar_revered_spear_of_tlanxla_stage_1", 6, "wh2_main_liz_kroq_gar_revered_spear_of_tlanxla_stage_3_mpc"}
    },
    ["wh2_dlc12_lzd_tehenhauin"] = {
        {"mission", "wh2_dlc12_anc_enchanted_item_plaque_of_sotek", "wh2_dlc12_lzd_tehenhauin_plaque_of_sotek_stage_1", 8, "wh2_dlc12_lzd_tehenhauin_plaque_of_sotek_mp"}
    },
    ["wh2_dlc12_lzd_tiktaqto"] = {
        {"mission", "wh2_dlc12_anc_enchanted_item_mask_of_heavens", "wh2_dlc12_lzd_tiktaqto_mask_of_heavens_stage_1", 8,"wh2_dlc12_lzd_tiktaqto_mask_of_heavens_mp"}
    },
    ["wh2_dlc13_lzd_nakai"] = {
		{"mission", "wh2_dlc13_anc_enchanted_item_golden_tributes", "wh2_dlc13_lzd_nakai_golden_tributes_stage_1", 8,"wh2_dlc13_lzd_nakai_golden_tributes_stage_3"},
		{"mission", "wh2_dlc13_talisman_the_ogham_shard", "wh2_dlc13_lzd_nakai_the_ogham_shard_stage_1", 8,"wh2_dlc13_lzd_nakai_the_ogham_shard_stage_2"}
    },
    ["wh2_dlc13_lzd_gor_rok"] = {
		{"mission", "wh2_dlc13_anc_armour_the_shield_of_aeons", "wh2_dlc13_gorrok_the_shield_of_aeons_stage_1", 8,"wh2_dlc13_gorrok_the_shield_of_aeons_stage_3"},
        {"mission", "wh2_dlc13_anc_weapon_mace_of_ulumak", "wh2_dlc14_lzd_the_mace_of_ulumak", 2}
    },
    ["wh2_main_skv_lord_skrolk"] = {
		{"mission", "wh2_main_anc_weapon_rod_of_corruption", "wh2_main_skv_skrolk_rod_of_corruption_stage_1", 10, "wh2_main_skv_skrolk_rod_of_corruption_stage_3_mpc"},
		{"mission", "wh2_main_anc_arcane_item_the_liber_bubonicus", "wh2_main_skv_skrolk_liber_bubonicus_stage_1", 6, "wh2_main_skv_skrolk_liber_bubonicus_stage_3_mpc"}
    },
    ["wh2_main_skv_queek_headtaker"] = {
		{"mission", "wh2_main_anc_armour_warp_shard_armour", "wh2_main_skv_queek_headtaker_warp_shard_armour_stage_1", 6, "wh2_main_skv_queek_headtaker_warp_shard_armour_stage_6_mpc"},
		{"mission", "wh2_main_anc_weapon_dwarf_gouger", "wh2_main_skv_queek_headtaker_dwarfgouger_stage_1", 10, "wh2_main_skv_queek_headtaker_dwarfgouger_stage_4_mpc"}
    },
    ["wh2_dlc09_skv_tretch_craventail"] = {
		{"mission", "wh2_dlc09_anc_enchanted_item_lucky_skullhelm", "wh2_dlc09_skv_tretch_lucky_skullhelm_stage_1", 8, "wh2_dlc09_skv_tretch_lucky_skullhelm_stage_5_mpc"}
    },
    ["wh2_dlc12_skv_ikit_claw"] = {
		{"mission", "wh2_dlc12_anc_weapon_storm_daemon", "wh2_dlc12_ikit_claw_storm_daemon_stage_1", 8, "wh2_dlc12_ikit_claw_storm_daemon_mp"}
    },
    ["wh2_dlc14_skv_deathmaster_snikch"] = {
        {"mission", "wh2_dlc14_anc_armour_the_cloak_of_shadows", "wh2_dlc14_main_skv_snikch_the_cloak_of_shadows_stage_1", 5},
        {"mission", "wh2_dlc14_anc_weapon_whirl_of_weeping_blades", "wh2_dlc14_main_skv_snikch_whirl_of_weeping_blades_stage_1", 3}
    },
    ["wh2_dlc09_tmb_settra"] = {
		{"mission", "wh2_dlc09_anc_enchanted_item_the_crown_of_nehekhara", "wh2_dlc09_tmb_settra_the_crown_of_nehekhara_stage_1", 6, "wh2_dlc09_tmb_settra_the_crown_of_nehekhara_stage_5_mpc"},
		{"mission", "wh2_dlc09_anc_weapon_the_blessed_blade_of_ptra", "wh2_dlc09_tmb_settra_the_blessed_blade_of_ptra_stage_1", 13, "wh2_dlc09_tmb_settra_the_blessed_blade_of_ptra_stage_3_mpc"}
    },
    ["wh2_dlc09_tmb_arkhan"] = {
		{"mission", "wh2_dlc09_anc_weapon_the_tomb_blade_of_arkhan", "wh2_dlc09_tmb_arkhan_the_tomb_blade_of_arkhan_stage_1", 6, "wh2_dlc09_tmb_arkhan_the_tomb_blade_of_arkhan_stage_4_mpc"},
		{"mission", "wh2_dlc09_anc_arcane_item_staff_of_nagash", "wh2_dlc09_tmb_arkhan_the_staff_of_nagash_stage_1", 10, "wh2_dlc09_qb_tmb_arkhan_the_staff_of_nagash_stage_5_mpc"}
    },
    ["wh2_dlc09_tmb_khatep"] = {
        {"mission", "wh2_dlc09_anc_arcane_item_the_liche_staff", "wh2_dlc09_mortal_empires_tmb_khatep_the_liche_staff_1", 6}
    },
    ["wh2_dlc09_tmb_khalida"] = {
		{"mission", "wh2_dlc09_anc_weapon_the_venom_staff", "wh2_dlc09_mortal_empires_tmb_khalida_venom_staff_stage_1", 12, "wh2_dlc09_mortal_empires_tmb_khalida_venom_staff_stage_3_mpc"}
    },
    ["wh_dlc08_nor_wulfrik"] = {
        {"mission", "wh_dlc08_anc_weapon_sword_of_torgald", "wh_dlc08_qb_nor_wulfrik_the_wanderer_sword_of_torgald_stage_1", 9,"wh_dlc08_qb_nor_wulfrik_the_wanderer_sword_of_torgald_stage_4a"}
    },
    ["wh_dlc08_nor_throgg"] = {
		{"mission", "wh_dlc08_anc_talisman_wintertooth_crown", "wh_dlc08_qb_nor_throgg_wintertooth_crown_stage_1", 9,"wh_dlc08_qb_nor_throgg_wintertooth_crown_stage_5"}
    },
    ["wh2_dlc11_cst_harkon"] = {
        {"mission", "wh2_dlc11_anc_enchanted_item_slann_gold", "wh2_dlc11_cst_harkon_quest_for_slann_gold_stage_1", 15, "wh2_dlc11_qb_cst_luthor_harkon_slann_gold_MP"}
    },
    ["wh2_dlc11_cst_noctilus"] = {
        {"mission", "wh2_dlc11_anc_enchanted_item_captain_roths_moondial", "wh2_dlc11_cst_noctilus_captain_roths_moondial_stage_1", 15, "wh2_dlc11_qb_cst_noctilus_captain_roths_moondial_MP"}
    },
    ["wh2_dlc11_cst_aranessa"] = {
        {"mission", "wh2_dlc11_anc_weapon_krakens_bane", "wh2_dlc11_cst_aranessa_krakens_bane_stage_1", 15, "wh2_dlc11_qb_cst_aranessa_saltspite_krakens_bane_MP"}
    },
    ["wh2_dlc11_cst_cylostra"] = {
        {"mission", "wh2_dlc11_anc_arcane_item_the_bordeleaux_flabellum", "wh2_dlc11_cst_cylostra_the_bordeleaux_flabellum_stage_1", 9, "wh2_dlc11_cylostra_the_bordeleaux_flabellum_mp"}
    },
    ["wh2_dlc11_def_lokhir"] = {
        {"mission", "wh2_main_anc_armour_helm_of_the_kraken", "wh2_dlc11_lokhir_helm_of_the_kraken_stage_1", 11, "wh2_dlc11_lokhir_fellheart_helm_of_the_kraken_mp"},
        {"mission", "wh2_dlc11_anc_weapon_red_blades", "wh2_dlc11_def_lokhir_red_blades_stage_1", 2}
    },

    --mixu
    ["brt_adalhard"] = {
        {"", "mixu_anc_armour_brt_adalhard_lions_cloak", "", 12}
    },
    ["brt_bohemond"] = {
        {"", "mixu_anc_armour_brt_bohemond_bohemonds_shield", "", 12}
    },
    ["brt_chilfroy"] = {
        {"", "mixu_anc_weapon_brt_chilfroy_lance_of_artois", "", 13},
        {"", "mixu_anc_enchanted_item_brt_chilfroy_antlers_of_the_great_hunt", "", 9}
    },
    ["brt_cassyon"] = {
        {"", "mixu_anc_weapon_brt_cassyon_the_glorfinial", "", 13}
    },
    ["mixu_elspeth_von_draken"] = {
        {"", "mixu_anc_weapon_emp_elspeth_von_draken_the_pale_scythe", "", 17},
        {"", "mixu_anc_arcane_item_emp_elspeth_von_draken_deaths_timekeeper", "", 12}
    },
    ["mixu_katarin_the_ice_queen"] = {
        {"", "mixu_anc_enchanted_item_ksl_katarin_the_ice_queen_crystal_cloak", "", 9},
        {"", "mixu_anc_weapon_ksl_katarin_the_ice_queen_fearfrost", "", 15}
    },
    ["emp_theoderic_gausser"] = {
        {"", "mixu_anc_enchanted_item_emp_theoderic_gausser_sea_dragon_cloak", "", 10}
    },
    ["wef_daith"] = {
        {"", "mixu_anc_armour_wef_daith_the_oaken_armour", "", 15}
    },
    ["dwf_kazador_dragonslayer"] = {
        {"", "mixu_anc_armour_dwf_kazador_dragonslayer_armour_of_karak_azul", "", 9},
        {"", "mixu_anc_weapon_dwf_kazador_dragonslayer_hammer_karak_azul", "", 15}
    },
    ["dwf_thorek_ironbrow"] = {
        {"", "mixu_anc_weapon_dwf_thorek_ironbrow_klad_brakak", "", 15},
        {"", "mixu_anc_armour_dwf_thorek_ironbrow_thoreks_rune_armour", "", 9}
    },
    ["emp_edward_van_der_kraal"] = {
        {"", "mixu_anc_enchanted_item_emp_edward_van_der_kraal_the_cursed_skull", "", 15}
    },
    ["emp_theodore_bruckner"] = {
        {"", "mixu_anc_talisman_emp_theodore_bruckner_baleflame_amulet", "", 5},
        {"", "mixu_anc_weapon_emp_theodore_bruckner_liarsbane", "", 10}
    },
    ["brt_almaric_de_gaudaron"] = {
        {"", "mixu_anc_talisman_brt_almaric_de_gaudaron_the_icon_of_the_lady", "", 10}
    },
    ["dlc03_emp_boris_todbringer"] = {
        {"", "mixu_anc_enchanted_item_emp_boris_todbringer_talisman_of_ulric", "", 15}
    },
    ["emp_vorn_thugenheim"] = {
        {"", "mixu_anc_talisman_emp_vorn_thugenheim_heart_of_middenheim", "", 15},
        {"", "mixu_anc_enchanted_item_emp_vorn_thugenheim_pelt_of_horrors", "", 10}
    },
    ["bst_taurox"] = {
        {"", "mixu_anc_weapon_bst_taurox_the_brass_bull_rune_tortured_axes", "", 13}
    },
    ["emp_wolfram_hertwig"] = {
        {"", "mixu_anc_talisman_emp_wolfram_hertwig_kislevite_icon", "", 14}
    }
} --:map<string, vector<vector<WHATEVER>>>

local me_missing_anc = {
    ["wh2_dlc10_hef_alarielle"] = {
        {"", "wh2_dlc10_anc_magic_standard_banner_of_avelorn", "", 1},
        {"", "wh2_dlc10_anc_arcane_item_stave_of_avelorn", "", 1}
    },
    ["wh2_dlc12_skv_ikit_claw"] = {
        {"", "wh2_dlc12_anc_armour_iron_frame", "", 1}
    },
    ["dlc06_grn_skarsnik"] = {
        {"", "wh_dlc06_anc_magic_standard_skarsniks_boyz", "", 1}
    },
    ["wh2_dlc12_lzd_tehenhauin"] = {
        {"", "wh2_dlc12_anc_weapon_blade_of_the_serpents_tongue", "", 1}
    },
    ["grn_grimgor_ironhide"] = {
        {"", "wh_main_anc_magic_standard_da_immortulz", "", 1}
    },
    ["wh2_main_hef_prince_alastar"] = {
        {"", "wh2_main_anc_armour_lions_pelt", "", 1}
    },
    ["dlc03_emp_boris_todbringer"] = {
        {"", "wh_main_anc_talisman_the_white_cloak_of_ulric", "", 1}
    },
    ["wh2_dlc10_hef_alith_anar"] = {
        {"", "wh2_dlc10_anc_talisman_stone_of_midnight", "", 1}
    },
    ["vmp_heinrich_kemmler"] = {
        {"", "wh2_dlc11_anc_follower_vmp_the_ravenous_dead", "", 1}
    },
    ["wh2_dlc12_lzd_tiktaqto"] = {
        {"", "wh2_dlc12_anc_weapon_the_blade_of_ancient_skies", "", 1}
    },
    ["wh2_dlc11_cst_harkon"] = {
        {"", "wh2_dlc11_anc_follower_captain_drekla", "", 1}
    },
    ["wh2_dlc15_hef_imrik"] = {
        {"", "wh2_dlc15_anc_weapon_star_lance", "", 1},
    }
} --:map<string, vector<vector<WHATEVER>>>

local subtype_immortality = {
    --["dlc03_emp_boris_todbringer"] = true,
    --["wh_dlc05_vmp_red_duke"] = true,
    --["wh2_main_hef_prince_alastar"] = true -- no longer needed (the empire undivided update made him immortal)    --["wh2_dlc09_tmb_arkhan"] = true,
    ["wh2_dlc09_tmb_khalida"] = true,
    ["wh2_dlc09_tmb_khatep"] = true,
    ["wh2_dlc09_tmb_settra"] = true,
    ["wh2_dlc11_cst_aranessa"] = true,
    ["wh2_dlc11_cst_cylostra"] = true,
    ["wh2_dlc11_cst_harkon"] = true,
    ["wh2_dlc11_cst_noctilus"] = true
} --: map<string, boolean>

--v function(faction: CA_FACTION)
local function immortality_backup(faction)
    local char_list = faction:character_list()
    for i = 0, char_list:num_items() - 1 do 
        local char = char_list:item_at(i)
        if subtype_immortality[char:character_subtype_key()] then 
            sm0_log("immortality_backup: "..tostring(char:character_subtype_key()))
            cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), true) 
        end 
    end       
end

--v function(faction: CA_FACTION)
local function equip_quest_anc(faction)
    local missing_anc = {} --:map<string, vector<vector<WHATEVER>>>
    local subtype_anc = {} --:map<string, vector<vector<WHATEVER>>>
    if cm:get_campaign_name() == "main_warhammer" then 
        missing_anc = me_missing_anc 
        subtype_anc = me_subtype_anc
    elseif cm:get_campaign_name() == "wh2_main_great_vortex" then 
        missing_anc = vor_missing_anc 
        subtype_anc = vor_subtype_anc
    end
    local char_list = faction:character_list()
    for i = 0, char_list:num_items() - 1 do
        local current_char = char_list:item_at(i)
        if missing_anc[current_char:character_subtype_key()] then
            local ancillaries = missing_anc[current_char:character_subtype_key()]
            for j = 1, #ancillaries do
                local current_ancillary = ancillaries[j]
                local current_ancillary_key = current_ancillary[2]
                cm:force_add_ancillary(current_char, current_ancillary_key, true, true)
            end
        end
        if subtype_anc[current_char:character_subtype_key()] then
            local quests = subtype_anc[current_char:character_subtype_key()]
            for j = 1, #quests do
                local current_quest_record = quests[j]
                local current_ancillary_key = current_quest_record[2]
                local current_rank_req = current_quest_record[4]
                if current_char:rank() >= current_rank_req and not current_char:has_ancillary(current_ancillary_key) then --and current_char:faction():ancillary_exists(current_ancillary_key)
                    cm:force_add_ancillary(current_char, current_ancillary_key, true, true)
                end
            end
        end
    end
end

--v function(quests: vector<{string, number}>, subtype: string)
local function ancillary_on_rankup(quests, subtype)
	for i = 1, #quests do
		local current_quest= quests[i]
		local ancillary = current_quest[1]
		local rank = current_quest[2]			
        core:add_listener(
            "sm0"..ancillary.."_CharacterTurnStart",
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

-- pre empire undivided spawn location check
--v function(x: number, y: number) --> boolean
local function is_valid_spawn_coordinate(x, y)
    local is_valid = true
    if is_number(x) and is_number(y) and x ~= -1 and y ~= -1 then
        --local faction_list = cm:model():world():faction_list()
        --for i = 0, faction_list:num_items() - 1 do
        --    local current_faction = faction_list:item_at(i)
        --    local char_list = current_faction:character_list()
        --    for j = 0, char_list:num_items() - 1 do
        --        local current_char = char_list:item_at(j)
        --        if current_char:logical_position_x() == x and current_char:logical_position_y() == y then
        --            is_valid = false
        --            --sm0_log("char_list/is_valid: false")
        --            break
        --        end
        --    end
        --    if is_valid then
        --        local region_list = current_faction:region_list()
        --        for j = 0, region_list:num_items() - 1 do
        --            local current_region = region_list:item_at(j)
        --            if current_region:settlement():logical_position_x() == x and current_region:settlement():logical_position_y() == y then
        --                is_valid = false
        --                --sm0_log("current_region/is_valid: false")
        --                break
        --            end
        --        end
        --    end
        --end
    else
        is_valid = false
    end
    return is_valid
end

-- pre empire undivided spawn location search
--v function(faction: string, x: number, y: number) --> (number, number)
local function find_valid_spawn_coordinates(faction, x, y)
    -- Witten by Vandy. Full credit goes to him.
    local spawn_X, spawn_Y = cm:find_valid_spawn_location_for_character_from_position(faction, x, y, true)
    --sm0_log("find_valid_spawn_coordinates: x="..tostring(spawn_X)..", y="..tostring(spawn_Y))
    local valid = false
    while not valid do
        if is_valid_spawn_coordinate(spawn_X, spawn_Y) then
            valid = true
            break
        end
        local square = {x - 10, x + 10, y - 10, y + 10}
        spawn_X, spawn_Y = cm:find_valid_spawn_location_for_character_from_position(faction, cm:random_number(square[2], square[1]), cm:random_number(square[4], square[3]), true)
        --sm0_log("while not valid: x="..tostring(spawn_X)..", y="..tostring(spawn_Y))
    end
    --sm0_log("return: x="..tostring(spawn_X)..", y="..tostring(spawn_Y))
    return spawn_X, spawn_Y
end

--v function(confederator: CA_FACTION, confederated: CA_FACTION)
local function spawn_missing_lords(confederator, confederated)
    local start_region --confederator:region_list():item_at(0)
    local x, y
    --if start_region then sm0_log("spawn_missing_lords 1: "..confederator:name().." | Region: "..start_region:name()) end
    if confederator:has_home_region() then 
        start_region = confederator:home_region()
        --if start_region then sm0_log("spawn_missing_lords 2: "..confederator:name().." | Region: "..start_region:name()) end
        x, y = cm:find_valid_spawn_location_for_character_from_settlement(confederator:name(), start_region:name(), false, true, 9)
        --sm0_log("find_valid_spawn_location_for_character_from_settlement: x="..tostring(x)..", y="..tostring(y))
    else
        if not confederator:military_force_list():item_at(0):general_character():is_at_sea() and confederator:military_force_list():item_at(0):general_character():has_region() then
            start_region = confederator:military_force_list():item_at(0):general_character():region() 
        else
            sm0_log("ERROR: Could not find valid region!")
            return
        end
    end    
    if not is_valid_spawn_coordinate(x, y) or not confederator:has_home_region() then
        --x, y = cm:find_valid_spawn_location_for_character_from_position(confederator:name(), confederator:military_force_list():item_at(0):general_character():logical_position_x() + 1, confederator:military_force_list():item_at(0):general_character():logical_position_y(), true)
        local char_lookup = cm:char_lookup_str(confederator:military_force_list():item_at(0):general_character())
        x, y = cm:find_valid_spawn_location_for_character_from_character(confederator:name(), char_lookup, true, 9)
        --sm0_log("find_valid_spawn_location_for_character_from_position: x="..tostring(x)..", y="..tostring(y))
    end
    if not is_valid_spawn_coordinate(x, y) then 
        -- CA's method did not provide a valid position, try Vandy's method instead
        local spawn_x, spawn_y
        if confederator:has_home_region() then 
            spawn_x = confederator:home_region():settlement():logical_position_x()
            spawn_y = confederator:home_region():settlement():logical_position_y()
        else
            spawn_x = confederator:military_force_list():item_at(0):general_character():logical_position_x()
            spawn_y = confederator:military_force_list():item_at(0):general_character():logical_position_y()
        end
        if is_valid_spawn_coordinate(spawn_x, spawn_y) then x, y = find_valid_spawn_coordinates(confederator:name(), spawn_x, spawn_y) end
        --sm0_log("find_valid_spawn_coordinates: x="..tostring(x)..", y="..tostring(y))
    end
    --sm0_log("Trying to revive Faction: "..confederated:name().." | Region: "..start_region:name())
    if is_valid_spawn_coordinate(x, y) then 
        local char_cqi
        cm:create_force(
            confederated:name(),
            "wh2_main_hef_inf_spearmen_0",
            start_region:name(),
            1000, --x
            700, --y
            true,
            function(cqi)
                --sm0_log("spawn_missing_lords | Faction revived: "..confederated:name().." | Region: "..start_region:name().." | CQI: "..cqi)
                char_cqi = cqi
                local char = cm:get_character_by_cqi(char_cqi)
                --if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and not cm:get_saved_value("sm0_immortal_cqi"..char_cqi) then
                --    cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
				--		cm:set_character_immortality(cm:char_lookup_str(char_cqi), true) 
				--	end, 0.5)                   
                --    cm:set_saved_value("sm0_immortal_cqi"..char_cqi, true)
                --end 
            end,
            true
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
                    if locked_ai_generals[i].id ~= "" then cm:unlock_starting_general_recruitment(locked_ai_generals[i].id, locked_ai_generals[i].faction) end
                    for n = 1, 10 do
                        if not cm:get_saved_value(locked_ai_generals[i].subtype.."_spawned") then
                            x, y = cm:find_valid_spawn_location_for_character_from_position(confederated:name(), x, y, true, 7)
                            -- backup
                            if not is_valid_spawn_coordinate(x, y) then 
                                -- CA's method did not provide a valid position, try Vandy's method instead
                                local spawn_x, spawn_y
                                if confederator:has_home_region() then 
                                    spawn_x = confederator:home_region():settlement():logical_position_x()
                                    spawn_y = confederator:home_region():settlement():logical_position_y()
                                else
                                    spawn_x = confederator:military_force_list():item_at(0):general_character():logical_position_x()
                                    spawn_y = confederator:military_force_list():item_at(0):general_character():logical_position_y()
                                end
                                if is_valid_spawn_coordinate(spawn_x, spawn_y) then x, y = find_valid_spawn_coordinates(confederator:name(), spawn_x, spawn_y) end        
                                --sm0_log("find_valid_spawn_coordinates: x="..tostring(x)..", y="..tostring(y))
                            end
                            if is_valid_spawn_coordinate(x, y) then 
                                cm:create_force(
                                    confederated:name(),
                                    "wh2_main_hef_inf_spearmen_0",
                                    start_region:name(),
                                    1000, --x
                                    700, --y
                                    false,
                                    function(cqi)
                                        local char = cm:get_character_by_cqi(cqi)
                                        --sm0_log("["..n..".] spawn_lord|subtype: "..char:character_subtype_key().." |Forename: "..char:get_forename().." |Surname: "..char:get_surname().." | CQI: "..cqi)
                                        for k = 1, #locked_ai_generals do
                                            if char:character_subtype(locked_ai_generals[k].subtype) and not cm:get_saved_value(locked_ai_generals[k].subtype.."_spawned") then
                                                --cm:set_character_immortality(cm:char_lookup_str(cqi), true)
                                                sm0_log("["..n..".] spawn_missing_lords: "..char:character_subtype_key().." spawned!")
                                                cm:set_saved_value(locked_ai_generals[k].subtype.."_spawned", confederated:name()) 
                                            end
                                        end
                                        --if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and not cm:get_saved_value("sm0_immortal_cqi"..cqi) then                                           
                                        --    cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
                                        --        cm:set_character_immortality(cm:char_lookup_str(cqi), true)
                                        --    end, 0.1)  
                                        --    cm:set_saved_value("sm0_immortal_cqi"..cqi, true)
                                        --end 
                                        cm:kill_character(cqi, true, false)
                                        --cm:kill_character_and_commanded_unit(cm:char_lookup_str(cqi), true, false)                                       
                                        --if is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()] then cm:set_character_immortality(cm:char_lookup_str(cqi), false) end
                                        --cm:callback(function()
                                            --if char:is_wounded() then cm:stop_character_convalescing(cqi) end
                                        --end, 0.5)
                                        if n >= 10 or cm:get_saved_value(locked_ai_generals[i].subtype.."_spawned") then 
                                            if char_cqi and cm:get_character_by_cqi(char_cqi) then cm:kill_character(char_cqi, true, false) end
                                            --cm:kill_character_and_commanded_unit(cm:char_lookup_str(char_cqi), true, false)   
                                        end
                                    end,
                                    false
                                )
                            end
                        end
                    end
                end
            end
        end
        cm:callback(function() 
            kill_faction(confederated:name()) --backup
            --cm:kill_all_armies_for_faction(confederated) --backup
            cm:kill_character(char_cqi, true, false)
            --cm:kill_character_and_commanded_unit(cm:char_lookup_str(char_cqi), true, false)
            local char_list = confederated:character_list()
            for i = 0, char_list:num_items() - 1 do
                local char = char_list:item_at(i)
                --if char then sm0_log("DEAD FACTION char: "..char:character_subtype_key()) end
                cm:kill_character(char:command_queue_index(), true, true)
                --cm:kill_character_and_commanded_unit(cm:char_lookup_str(char:command_queue_index()), true, true)
                --if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
                --    cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), false) 
                --    cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), false)
                --end 
            end   
        end, 2)
    else
        sm0_log("ERROR: Could not find valid spawn position!")
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
        "wh_main_bundle_confederation_wef",
        "wh_dlc03_beastmen_confederation_help",
        "wh2_main_bundle_confederation_tmb"
    } --:vector<string>
    local has_confed_bundle = ""
    for i = 1, #bundles do
        if faction and faction:has_effect_bundle(bundles[i]) then 
            has_confed_bundle = bundles[i] 
            break
        end
    end
    return has_confed_bundle
end

--v function(confederator: string, character: CA_CHAR, agents: vector<map<string, string>>)
local function lord_event(confederator, character, agents)
    for _, agent in ipairs(agents) do
        local subtype = agent.subtype
        if subtype == character:character_subtype_key() and (not is_string(agent.dlc) or (is_string(agent.dlc) and cm:is_dlc_flag_enabled(agent.dlc))) then
            local picture = faction_event_picture[confederator]
            if not is_number(picture) then 
                picture = subculture_event_picture[cm:get_faction(confederator):subculture()] 
            end
            local char_type = "legendary_lord"
            if cm:char_is_agent(character) then char_type = "legendary_hero" end
            --sm0_log("Faction event picture | Number: "..tostring(picture))
            --sm0_log("Faction event Title 1: "..effect.get_localised_string("event_feed_strings_text_title_event_" .. char_type .. "_available"))
            --sm0_log("Faction event Title 2: "..effect.get_localised_string("event_feed_strings_text_title_event_"..subtype.."_LL_unlocked"))
            --sm0_log("Faction event Description: "..effect.get_localised_string("event_feed_strings_text_description_event_"..subtype.."_LL_unlocked"))
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
            if vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") and subculture == "wh_main_sc_teb_teb" then 
                option.offer = true
                option.accept = true
                option.enable_payment = false            
            end
            if faction:has_pooled_resource("emp_loyalty") == true then
                option.offer = false
                option.accept = false
                option.enable_payment = false
            end
            if subculture == "wh_dlc05_sc_wef_wood_elves" then
                option.accept = false
                option.enable_payment = false        	
                oak_region = cm:get_region("wh_main_yn_edri_eternos_the_oak_of_ages")
                if oak_region:building_exists("wh_dlc05_wef_oak_of_ages_3") or oak_region:building_exists("wh_dlc05_wef_oak_of_ages_4") or oak_region:building_exists("wh_dlc05_wef_oak_of_ages_5") then
                    option.offer = true
                else
                    option.offer = false
                end  
            end
        end
        cm:callback(
            function(context)
                cm:force_diplomacy("faction:" .. faction_name, "subculture:" .. subculture, "form confederation", option.offer, option.accept, option.enable_payment)

                if faction:name() == "wh_main_vmp_rival_sylvanian_vamps" then
                    cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps", "faction:wh_main_vmp_vampire_counts", "form confederation", false, false, true)
                    cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps", "faction:wh_main_vmp_schwartzhafen", "form confederation", false, false, true)
                end
                if (confed_option == "yield" or confed_option == nil) and subculture == "wh_main_sc_brt_bretonnia" and cm:get_faction(faction_name):is_human() then
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
            end, 1, "changeDiplomacyOptions"
        )
    end
end

--v function(confederator: CA_FACTION, confederated: CA_FACTION)
local function confed_revived(confederator, confederated)
    local start_region --confederator:region_list():item_at(0)
    local x, y
    --if start_region then sm0_log("spawn_missing_lords 1: "..confederator:name().." | Region: "..start_region:name()) end
    if confederator:has_home_region() then 
        start_region = confederator:home_region()
        --if start_region then sm0_log("spawn_missing_lords 2: "..confederator:name().." | Region: "..start_region:name()) end
        x, y = cm:find_valid_spawn_location_for_character_from_settlement(confederator:name(), start_region:name(), false, true, 9)
        --sm0_log("find_valid_spawn_location_for_character_from_settlement: x="..tostring(x)..", y="..tostring(y))
    else
        if not confederator:military_force_list():item_at(0):general_character():is_at_sea() and confederator:military_force_list():item_at(0):general_character():has_region() then
            start_region = confederator:military_force_list():item_at(0):general_character():region() 
        else
            sm0_log("ERROR: Could not find valid region!")
            return
        end
    end    
    if not is_valid_spawn_coordinate(x, y) or not confederator:has_home_region() then
        --x, y = cm:find_valid_spawn_location_for_character_from_position(confederator:name(), confederator:military_force_list():item_at(0):general_character():logical_position_x() + 1, confederator:military_force_list():item_at(0):general_character():logical_position_y(), true)
        local char_lookup = cm:char_lookup_str(confederator:military_force_list():item_at(0):general_character())
        x, y = cm:find_valid_spawn_location_for_character_from_character(confederator:name(), char_lookup, true, 9)
        --sm0_log("find_valid_spawn_location_for_character_from_position: x="..tostring(x)..", y="..tostring(y))
    end
    -- backup
    if not is_valid_spawn_coordinate(x, y) then 
        -- CA's method did not provide a valid position, try Vandy's method instead
        local spawn_x, spawn_y
        if confederator:has_home_region() then 
            spawn_x = confederator:home_region():settlement():logical_position_x()
            spawn_y = confederator:home_region():settlement():logical_position_y()
        else
            spawn_x = confederator:military_force_list():item_at(0):general_character():logical_position_x()
            spawn_y = confederator:military_force_list():item_at(0):general_character():logical_position_y()
        end
        if is_valid_spawn_coordinate(spawn_x, spawn_y) then x, y = find_valid_spawn_coordinates(confederator:name(), spawn_x, spawn_y) end        
        --sm0_log("find_valid_spawn_coordinates: x="..tostring(x)..", y="..tostring(y))
    end
    --sm0_log("Trying to revive Faction: "..confederated:name().." | Region: "..start_region:name())
    --sm0_log("confed_revived: x="..tostring(x)..", y="..tostring(y))
    if is_valid_spawn_coordinate(x, y) and start_region then 
        cm:create_force(
            confederated:name(),
            "wh2_main_hef_inf_spearmen_0",
            start_region:name(),
            x,
            y,
            true,
            function(cqi)
                --sm0_log("Faction revived: "..confederated:name().." | Region: "..start_region:name().." | CQI: "..cqi)
                equip_quest_anc(confederated)
                local faction_leader_cqi = confederated:faction_leader():command_queue_index()
                local char_list = confederated:character_list()
                for i = 0, char_list:num_items() - 1 do 
                    local char = char_list:item_at(i)
                    local command_queue_index = char:command_queue_index()
                    local char_lookup = cm:char_lookup_str(char)
                    if cm:char_is_agent(char) or cm:char_is_general(char) then cm:force_reset_skills(char_lookup) end
                    --if not char:has_military_force() and (cm:char_is_general(char) or cm:char_is_agent(char)) then cm:kill_character(command_queue_index, true, false) end --kill colonels
                    if confederator:is_human() then 
                        lord_event(confederator:name(), char, wh_agents)
                        if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") then lord_event(confederator:name(), char, mixu1_agents) end
                        if vfs.exists("script/campaign/mod/mixu_darkhand.lua") then lord_event(confederator:name(), char, mixu2_agents) end
                        if vfs.exists("script/campaign/mod/eltharion_yvresse_add.lua") then lord_event(confederator:name(), char, xoudad_agents) end
                        if vfs.exists("script/campaign/main_warhammer/mod/cataph_kraka_drak.lua") then lord_event(confederator:name(), char, kraka_agents) end
                        if vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then lord_event(confederator:name(), char, teb_agents) end
                        if vfs.exists("script/export_helpers_enforest.lua") then lord_event(confederator:name(), char, parte_agents) end
                        if vfs.exists("script/campaign/main_warhammer/mod/spcha_live_launch.lua") then lord_event(confederator:name(), char, speshul_agents) end
                        if vfs.exists("script/export_helpers_why_grudge.lua") then lord_event(confederator:name(), char, wsf_agents) end
                        if vfs.exists("script/export_helpers_ordo_draconis_why.lua") then lord_event(confederator:name(), char, ordo_agents) end
                        if vfs.exists("script/export_helpers_why_strigoi_camp.lua") then lord_event(confederator:name(), char, strigoi_agents) end
                        if vfs.exists("script/campaign/mod/@zf_master_engineer_setup_vandy") then lord_event(confederator:name(), char, zf_agents) end 
                        if vfs.exists("script/campaign/mod/cataph_aislinn") then lord_event(confederator:name(), char, seahelm_agents) end
                        if vfs.exists("script/campaign/mod/mixu_shadewraith") then lord_event(confederator:name(), char, mixu_vangheist) end
                        --if vfs.exists("script/campaign/mod/ovn_rogue.lua") then lord_event(confederator:name(), char, second_start_agents) end
                        --if vfs.exists("script/campaign/mod/sr_chaos.lua") then lord_event(confederator:name(), char, lost_factions_agents) end
                        --sm0_log("Faction: "..confederated:name().." | ".."Character | Forename: "..effect.get_localised_string(char:get_forename()).." | Surname: "..effect.get_localised_string(char:get_surname()))
                    end
                    --if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and not cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
                    --    --cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
                    --        cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), true) 
                    --    --end, 0.5) 
                    --    cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), true)
                    --end 
                    if char:character_subtype("brt_louen_leoncouer") then
                        cm:force_add_ancillary(char, "wh_main_anc_mount_brt_louen_barded_warhorse", true, true)
                    end
                    if is_surtha_ek(char) then
                        cm:force_add_ancillary(char, "wh_dlc10_anc_mount_nor_surtha_ek_marauder_chariot", true, true)
                    end
                    if command_queue_index ~= cqi and not char:is_faction_leader() then 
                        cm:kill_character(command_queue_index, true, false) 
                        --cm:kill_character_and_commanded_unit(cm:char_lookup_str(char:command_queue_index(), true, false) 
                    end
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
                        sm0_log("spawn_missing_lords: ".."wh2_main_hef_prince_alastar".." spawned!")         
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
                core:add_listener(
                    "sm0_confed_revived_FactionJoinsConfederation",
                    "FactionJoinsConfederation",
                    function(context)
                        return context:confederation():name() == confederator:name() and context:faction():name() == confederated:name()
                    end,
                    function(context)
                        sm0_log("Faction: "..confederator:name().." :confederated: "..confederated:name().." | CQI: "..cqi)
                        cm:callback(function() 
                            if confed_penalty(confederator) ~= "" then cm:remove_effect_bundle(confed_penalty(confederator), confederator:name()) end 
                        end, 0.5)
                        -- some faction leaders need a immortality reset after confederation
                        immortality_backup(context:confederation())
                        -- execute useless mod compatibility
                        if cm:get_saved_value("sm0_immortal_cqi"..cqi) then cm:set_character_immortality(cm:char_lookup_str(cqi), true) end
                        if cm:get_saved_value("sm0_immortal_cqi"..faction_leader_cqi) then cm:set_character_immortality(cm:char_lookup_str(faction_leader_cqi), true) end
                        -- kill command doesn't work reliably...
                        cm:kill_character(cqi, true, false) 
                        if cqi and cm:get_character_by_cqi(cqi) then cm:kill_character(cqi, true, false) end
                        cm:callback(function() 
                            cm:kill_character(faction_leader_cqi, true, false)  
                        end, 0.5)  
                        --cm:kill_character_and_commanded_unit(cm:char_lookup_str(cqi), true, false)    
                        --cm:kill_character_and_commanded_unit(cm:char_lookup_str(faction_leader_cqi), true, false)  
                        apply_diplomacy(confederator:name())
                        --local char_list = context:confederation():character_list()
                        --for i = 0, char_list:num_items() - 1 do 
                        --    local char = char_list:item_at(i)
                        --    if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
                        --        cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), false) 
                        --        cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), false)
                        --    end 
                        --end           
                    end,
                    false
                )
                if confederated:name() == "wh2_dlc13_lzd_spirits_of_the_jungle" then cm:set_saved_value("sm0_rd_wh2_dlc13_lzd_spirits_of_the_jungle", true) end
                --cm:callback(function() 
                    cm:force_confederation(confederator:name(), confederated:name()) 
                --end, 0.5)   
            end,
            true
        )
    else
        sm0_log("ERROR: Could not find valid spawn position! ["..confederator:name().."]")
    end
end

--v function(faction: CA_FACTION) --> bool -- obsolete if colonels are dealt with
local function faked_death(faction)
    return not faction:is_dead() and not faction:military_force_list():item_at(0) and not faction:region_list():item_at(0)
end

--v function(confederator: CA_FACTION, confederated: CA_FACTION)
local function rd_dilemma(confederator, confederated)
    local subculture = confederator:subculture()
    local sc_string_start = string.find(subculture, "sc_")
    core:add_listener(
        "rd_trigger_dilemma"..confederated:name(),
        "DilemmaChoiceMadeEvent",
        function(context)
            return context:dilemma():starts_with("wh2_sm0_rd_")
        end,
        function(context)
            local choice = context:choice()
            if choice == 0 then
                sm0_log("Accept refugees: "..confederated:name())
                confed_revived(confederator, confederated)            						
            elseif choice == 1 then	
                sm0_log("Reject refugees: "..confederated:name())	
                cm:set_saved_value("rd_choice_1_"..confederated:name(), confederator:name())
            elseif choice == 2 then	
                sm0_log("Kill refugees: "..confederated:name())
                cm:set_saved_value("rd_choice_2_"..confederated:name(), true)
            else -- choice == 3
                sm0_log("Delay your decision: "..confederated:name())
                cm:set_saved_value("rd_choice_3_"..confederated:name(), cm:model():turn_number() + 25)
            end
            cm:callback(function() 
                cm:disable_event_feed_events(false, "", "", "diplomacy_trespassing")                
                cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_deaths", "")   
                cm:disable_event_feed_events(false, "", "", "diplomacy_faction_destroyed")
                cm:disable_event_feed_events(false, "", "", "faction_joins_confederation")
                cm:disable_event_feed_events(false, "", "", "diplomacy_faction_encountered")
                if cm:model():difficulty_level() == -3 then 
                    cm:disable_saving_game(false) 
                    cm:autosave_at_next_opportunity()
                end             
            end, 3)  
        end,
        false
    )
    if is_number(sc_string_start) then
        local sc_string = string.sub(subculture, sc_string_start, sc_string_start + 5) -- e.g.: "sc_emp"
        --sm0_log("trigger_dilemma_with_targets:".."wh2_sm0_rd_"..sc_string)
        cm:trigger_dilemma_with_targets(confederator:command_queue_index(), "wh2_sm0_rd_"..sc_string, confederated:command_queue_index())
    elseif string.find(subculture, "_rogue_") then
        --sm0_log("trigger_dilemma_with_targets:".."wh2_sm0_rd_rogue")
        cm:trigger_dilemma_with_targets(confederator:command_queue_index(), "wh2_sm0_rd_rogue", confederated:command_queue_index())
    else  
        sm0_log("ERROR: Subculture string resolving failed! ["..subculture.."]")
        confed_revived(confederator, confederated)   
        core:remove_listener("rd_trigger_dilemma"..confederated:name())                                 
    end
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
        "sm0_refugee_FactionTurnEnd",
        "FactionTurnEnd",
        true,
        function(context)
            if not (cm:model():turn_number() == 1 and context:faction():is_human()) then 
                if cm:get_saved_value("sought_refuge_"..context:faction():name()) then
                    cm:set_saved_value("sought_refuge_"..context:faction():name(), false)
                    sm0_log("Faction respawned: "..context:faction():name())
                end
                if cm:get_saved_value("rd_choice_1_"..context:faction():name()) then 
                    cm:set_saved_value("rd_choice_1_"..context:faction():name(), false)
                end
                if cm:get_saved_value("rd_choice_2_"..context:faction():name()) then 
                    cm:set_saved_value("rd_choice_2_"..context:faction():name(), false)
                end
                if cm:get_saved_value("delayed_spawn_"..context:faction():name()) then
                    cm:set_saved_value("delayed_spawn_"..context:faction():name(), false)
                    sm0_log("Faction spawned delayed: "..context:faction():name())
                end
            end
        end,
        true
    )

    if not cm:get_saved_value("delayed_spawn_listener") then
        core:add_listener(
            "delayed_spawn_listener",
            "PanelOpenedCampaign", 
            function(context) 
                return context.string == "popup_pre_battle" and cm:model():turn_number() == 1
            end,
            function(context)
                local faction_list = cm:model():world():faction_list()
                for i = 0, faction_list:num_items() - 1 do
                    local current_faction = faction_list:item_at(i)
                    if current_faction:is_dead() then -- delayed spawn?
                        -- faction exceptions
                        if current_faction:subculture() ~= "wh_main_sc_chs_chaos" and current_faction:name() ~= "wh2_dlc13_lzd_defenders_of_the_great_plan" and current_faction:name() ~= "wh2_dlc13_lzd_avengers" 
                        and not current_faction:name():find("_waaagh") and not current_faction:name():find("_brayherd") 
                        and not current_faction:name():find("_unknown") and not current_faction:name():find("_incursion")
                        and not current_faction:is_quest_battle_faction() and not current_faction:name():find("_qb") and not current_faction:name():find("_separatists") and not current_faction:name():find("_dil") 
                        and not current_faction:name():find("_blood_voyage") and not current_faction:name():find("_encounters") and not current_faction:name():find("rebel") 
                        and not current_faction:name():find("_intervention") and not current_faction:name():find("_invasion") then
                            cm:set_saved_value("delayed_spawn_"..current_faction:name(), true)
                            sm0_log("Faction will spawn delayed: "..current_faction:name())
                        end
                    end
                end
                cm:set_saved_value("delayed_spawn_listener", true)
                core:remove_listener("backup_delayed_spawn_listener")
                --core:remove_listener("delayed_spawn_listener")
            end,
            false
        )
        core:add_listener(
            "backup_delayed_spawn_listener",
            "FactionAboutToEndTurn",
            function(context)
                return context:faction():name() == faction_P1:name() and cm:model():turn_number() == 1
            end,
            function(context)
                local faction_list = cm:model():world():faction_list()
                for i = 0, faction_list:num_items() - 1 do
                    local current_faction = faction_list:item_at(i)
                    if current_faction:is_dead() then -- delayed spawn?
                        -- faction exceptions
                        if current_faction:subculture() ~= "wh_main_sc_chs_chaos" and current_faction:name() ~= "wh2_dlc13_lzd_defenders_of_the_great_plan" and current_faction:name() ~= "wh2_dlc13_lzd_avengers" 
                        and not current_faction:name():find("_waaagh") and not current_faction:name():find("_brayherd") 
                        and not current_faction:name():find("_unknown") and not current_faction:name():find("_incursion")
                        and not current_faction:is_quest_battle_faction() and not current_faction:name():find("_qb") and not current_faction:name():find("_separatists") and not current_faction:name():find("_dil") 
                        and not current_faction:name():find("_blood_voyage") and not current_faction:name():find("_encounters") and not current_faction:name():find("rebel") 
                        and not current_faction:name():find("_intervention") and not current_faction:name():find("_invasion") then
                            cm:set_saved_value("delayed_spawn_"..current_faction:name(), true)
                            sm0_log("Faction will spawn delayed: "..current_faction:name())
                        end
                    end
                end
                cm:set_saved_value("delayed_spawn_listener", true)
                --core:remove_listener("backup_delayed_spawn_listener")
                core:remove_listener("delayed_spawn_listener")
            end,
            false
        )
    end

    core:add_listener(
        "sm0_rd_DilemmaIssuedEvent",
        "DilemmaIssuedEvent",
        function(context) 
            return context:dilemma():starts_with("wh2_sm0_rd_")
        end,
        function()
            cm:remove_callback("sm0_refugee_FactionTurnStart_callback")
        end,
        true
    )

    core:add_listener(
        "sm0_refugee_FactionTurnStart",
        "FactionTurnStart",
        function(context)
            return cm:model():turn_number() >= 2 and context:faction():is_human() --and (not cm:is_multiplayer() or (cm:is_multiplayer() and (cm:model():turn_number() % 5) == 0))
        end,
        function(context)
            local ai_delay = 50
            if cm:get_saved_value("mcm_variable_recruit_defeated_ai_delay_value") then ai_delay = cm:get_saved_value("mcm_variable_recruit_defeated_ai_delay_value") end
            if cm:model():difficulty_level() == -3 then cm:disable_saving_game(true) end
            cm:disable_event_feed_events(true, "", "", "faction_joins_confederation")
            cm:disable_event_feed_events(true, "", "", "diplomacy_faction_destroyed")
            cm:disable_event_feed_events(true, "", "", "diplomacy_faction_encountered")
            cm:disable_event_feed_events(true, "", "", "diplomacy_trespassing")
            cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_deaths", "")

            local ai_confederation_limit = 10
            local player_confederation_limit = 1 
            local ai_confederation_count = 1 
            local player_confederation_count = 1 
            local faction_list = cm:model():world():faction_list() --context:faction():factions_of_same_subculture() --cm:model():world():faction_list()
            for i = 0, faction_list:num_items() - 1 do
                local current_faction = faction_list:item_at(i)            
                --if current_faction:is_dead() then sm0_log("DEAD Faction: "..current_faction:name()) end
                if faked_death(current_faction) then -- kill colonels and kill_character remnants
                    local char_list = current_faction:character_list()
					for i = 0, char_list:num_items() - 1 do
						local current_char = char_list:item_at(i)
						cm:kill_character(current_char:command_queue_index(), true, false)
					end
                end
                -- mcm restrictions
                if (not cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "all" 
                or (cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "lorefriendly" and current_faction:subculture() ~= "wh2_dlc09_sc_tmb_tomb_kings"
                and current_faction:subculture() ~= "wh_main_sc_grn_savage_orcs" and current_faction:subculture() ~= "wh2_dlc11_sc_cst_vampire_coast") 
                or (cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "lorefriendly" and current_faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings"
                and current_faction:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and current_faction:name() ~= "wh2_dlc09_tmb_khemri" and current_faction:name() ~= "wh2_dlc09_tmb_the_sentinels"))  
                and current_faction:is_dead() and not cm:get_saved_value("sought_refuge_"..current_faction:name()) and not cm:get_saved_value("delayed_spawn_"..current_faction:name()) 
                and (not cm:get_saved_value("rd_choice_3_"..current_faction:name()) or cm:model():turn_number() >= cm:get_saved_value("rd_choice_3_"..current_faction:name())) 
                and not cm:get_saved_value("rd_choice_2_"..current_faction:name()) then 
                    -- faction exceptions
                    if current_faction:subculture() ~= "wh_main_sc_chs_chaos" and current_faction:name() ~= "wh2_dlc13_lzd_defenders_of_the_great_plan" and current_faction:name() ~= "wh2_dlc13_lzd_avengers" 
                    and not current_faction:name():find("_waaagh") and not current_faction:name():find("_brayherd") 
                    and not current_faction:name():find("_unknown") and not current_faction:name():find("_incursion")
                    and not current_faction:is_quest_battle_faction() and not current_faction:name():find("_qb") and not current_faction:name():find("_separatists") and not current_faction:name():find("_dil") 
                    and not current_faction:name():find("_blood_voyage") and not current_faction:name():find("_encounters") and not current_faction:name():find("rebel") 
                    and not current_faction:name():find("_intervention") and not current_faction:name():find("_invasion") then --and not current_faction:subculture() == "wh_main_sc_nor_norsca"
                        local ai_remaining
                        if cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "ai" then
                            local subculture_faction_list = current_faction:factions_of_same_subculture()
                            for j = 0, subculture_faction_list:num_items() - 1 do
                                local subculture_faction = subculture_faction_list:item_at(j)
                                if not subculture_faction:is_dead() and not subculture_faction:is_human() and subculture_faction:name() ~= "wh2_dlc13_lzd_defenders_of_the_great_plan" and subculture_faction:name() ~= "wh2_dlc13_lzd_avengers"
                                and not subculture_faction:name():find("_waaagh") and not subculture_faction:name():find("_brayherd") 
                                and not subculture_faction:name():find("_unknown") and not subculture_faction:name():find("_incursion")
                                and not subculture_faction:is_quest_battle_faction() and not subculture_faction:name():find("_qb") and not subculture_faction:name():find("_separatists") and not subculture_faction:name():find("_dil") 
                                and not subculture_faction:name():find("_blood_voyage") and not subculture_faction:name():find("_encounters") and not subculture_faction:name():find("rebel") 
                                and not subculture_faction:name():find("_intervention") and not subculture_faction:name():find("_invasion") then 
                                    ai_remaining = subculture_faction
                                    break
                                end
                            end
                        end
                        local prefered_faction = nil --:CA_FACTION
                        if cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance2_value") ~= "power" then
                            local saved_standing = nil --:number
                            local factions_met_list = current_faction:factions_met()
                            for j = 0, factions_met_list:num_items() - 1 do
                                local faction_met = factions_met_list:item_at(j)
                                if not faction_met:is_dead() and faction_met:subculture() == current_faction:subculture() and faction_met:name() ~= "wh2_dlc13_lzd_defenders_of_the_great_plan" and faction_met:name() ~= "wh2_dlc13_lzd_avengers"
                                and not faction_met:name():find("_waaagh") and not faction_met:name():find("_brayherd") 
                                and not faction_met:name():find("_unknown") and not faction_met:name():find("_incursion")
                                and not faction_met:is_quest_battle_faction() and not faction_met:name():find("_qb") and not faction_met:name():find("_separatists") and not faction_met:name():find("_dil") 
                                and not faction_met:name():find("_blood_voyage") and not faction_met:name():find("_encounters") and not faction_met:name():find("rebel") 
                                and not faction_met:name():find("_intervention") and not faction_met:name():find("_invasion") then 
                                    local standing = current_faction:diplomatic_standing_with(faction_met:name())
                                    if not is_number(saved_standing) or standing > saved_standing 
                                    and not (cm:get_saved_value("rd_choice_1_"..current_faction:name()) == faction_P1:name() and faction_P1:name() == faction_met:name())
                                    and not (cm:is_multiplayer() and cm:get_saved_value("rd_choice_1_"..current_faction:name()) == faction_P2:name() and faction_P2:name() == faction_met:name()) then
                                        saved_standing = standing
                                        prefered_faction = faction_met
                                        --sm0_log("factions_met_list|Faction: "..prefered_faction:name().." | Diplomatic Standing: "..tostring(saved_standing))
                                    end
                                end
                            end
                            if not prefered_faction then
                                local subculture_faction_list = current_faction:factions_of_same_subculture()
                                for j = 0, subculture_faction_list:num_items() - 1 do
                                    local subculture_faction = subculture_faction_list:item_at(j)
                                    if not subculture_faction:is_dead() and subculture_faction:name() ~= "wh2_dlc13_lzd_defenders_of_the_great_plan" and subculture_faction:name() ~= "wh2_dlc13_lzd_avengers"
                                    and not subculture_faction:name():find("_waaagh") and not subculture_faction:name():find("_brayherd") 
                                    and not subculture_faction:name():find("_unknown") and not subculture_faction:name():find("_incursion") 
                                    and not subculture_faction:is_quest_battle_faction() and not subculture_faction:name():find("_qb") and not subculture_faction:name():find("_separatists") and not subculture_faction:name():find("_dil") 
                                    and not subculture_faction:name():find("_blood_voyage") and not subculture_faction:name():find("_encounters") and not subculture_faction:name():find("rebel") 
                                    and not subculture_faction:name():find("_intervention") and not subculture_faction:name():find("_invasion") then 
                                        local standing = current_faction:diplomatic_standing_with(subculture_faction:name())
                                        if not is_number(saved_standing) or standing > saved_standing 
                                        and not (cm:get_saved_value("rd_choice_1_"..current_faction:name()) == faction_P1:name() and faction_P1:name() == subculture_faction:name())
                                        and not (cm:is_multiplayer() and cm:get_saved_value("rd_choice_1_"..current_faction:name()) == faction_P2:name() and faction_P2:name() == subculture_faction:name()) then
                                            saved_standing = standing
                                            prefered_faction = subculture_faction
                                            --sm0_log("factions_met_list/factions_of_same_subculture|Faction: "..prefered_faction:name().." | Diplomatic Standing: "..tostring(saved_standing))
                                        end
                                    end
                                end
                            end
                            --if prefered_faction then sm0_log("Faction: "..current_faction:name().." prefers to join Faction: "..prefered_faction:name().." | Diplomatic Standing: "..tostring(saved_standing)) end
                        else
                            for j = 1, #playable_factions do
                                local playable_faction = cm:get_faction(playable_factions[j])
                                if playable_faction and not playable_faction:is_dead() and playable_faction:subculture() == current_faction:subculture()  and current_faction:name() ~= "wh2_dlc13_lzd_defenders_of_the_great_plan" and current_faction:name() ~= "wh2_dlc13_lzd_avengers"
                                and not playable_faction:name():find("_waaagh") and not playable_faction:name():find("_brayherd") 
                                and not playable_faction:name():find("_unknown") and not playable_faction:name():find("_incursion")
                                and not playable_faction:is_quest_battle_faction() and not playable_faction:name():find("_qb") and not playable_faction:name():find("_separatists") and not playable_faction:name():find("_dil") 
                                and not playable_faction:name():find("_blood_voyage") and not playable_faction:name():find("_encounters") and not playable_faction:name():find("rebel") 
                                and not playable_faction:name():find("_intervention") and not playable_faction:name():find("_invasion") then 
                                    prefered_faction = playable_faction
                                    --sm0_log("playable_factions|Faction: "..prefered_faction:name())
                                    break
                                end
                            end
                            if not prefered_faction then -- backup for when all major factions of a subculture are dead
                                local subculture_faction_list = current_faction:factions_of_same_subculture()
                                for j = 0, subculture_faction_list:num_items() - 1 do
                                    local subculture_faction = subculture_faction_list:item_at(j)
                                    if not subculture_faction:is_dead() and subculture_faction:name() ~= "wh2_dlc13_lzd_defenders_of_the_great_plan" and subculture_faction:name() ~= "wh2_dlc13_lzd_avengers"
                                    and not subculture_faction:name():find("_waaagh") and not subculture_faction:name():find("_brayherd") 
                                    and not subculture_faction:name():find("_unknown") and not subculture_faction:name():find("_incursion")
                                    and not subculture_faction:is_quest_battle_faction() and not subculture_faction:name():find("_qb") and not subculture_faction:name():find("_separatists") and not subculture_faction:name():find("_dil") 
                                    and not subculture_faction:name():find("_blood_voyage") and not subculture_faction:name():find("_encounters") and not subculture_faction:name():find("rebel") 
                                    and not subculture_faction:name():find("_intervention") and not subculture_faction:name():find("_invasion") then 
                                        prefered_faction = subculture_faction
                                        --sm0_log("playable_factions/factions_of_same_subculture|Faction: "..prefered_faction:name())
                                        break
                                    end
                                end
                            end
                        end   
                        if not faction_P1:is_dead() and current_faction:subculture() == faction_P1:subculture() and cm:get_saved_value("rd_choice_1_"..current_faction:name()) ~= faction_P1:name()
                        and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "player"
                        or (cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "ai" and not ai_remaining) 
                        or (cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "disable" and prefered_faction and prefered_faction:name() == faction_P1:name())) then
                            if not cm:get_saved_value("faction_P1") and confed_penalty(faction_P1) == "" and player_confederation_count <= player_confederation_limit
                            and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") == "player_ai" 
                            or cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") == "player") and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") 
                            or cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "all" or (cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "lorefriendly" 
                            and faction_P1:name() ~= "wh2_dlc09_tmb_followers_of_nagash")) then
                                if current_faction:name() == "wh_main_emp_empire" then cm:set_saved_value("karl_check_illegit", true) end
                                if are_lords_missing(current_faction) then
                                    sm0_log("["..player_confederation_count.."] Player 1 intends to intends to spawn missing lords for: "..current_faction:name())
                                    spawn_missing_lords(faction_P1, current_faction)
                                    --making sure there are no further confederations happening during the spawn_missing_lords loop
                                    player_confederation_count = player_confederation_count + player_confederation_limit
                                    --ai_confederation_count = ai_confederation_count + ai_confederation_limit                                  
                                else
                                    sm0_log("["..player_confederation_count.."] Player 1 intends to confederate: "..current_faction:name())
                                    rd_dilemma(faction_P1, current_faction)
                                    if cm:is_multiplayer() and faction_P1:subculture() == faction_P2:subculture() then
                                        cm:set_saved_value("faction_P1", true)
                                        cm:set_saved_value("faction_P2", false)
                                    end
                                end
                                player_confederation_count = player_confederation_count + 1
                            end
                        elseif cm:is_multiplayer() and not faction_P2:is_dead() and current_faction:subculture() == faction_P2:subculture() and cm:get_saved_value("rd_choice_1_"..current_faction:name()) ~= faction_P2:name()
                            and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "player" 
                            or (cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "ai" and not ai_remaining) 
                            or (cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") == "disable" and prefered_faction and prefered_faction:name() == faction_P2:name())) then
                            if not cm:get_saved_value("faction_P2") and confed_penalty(faction_P2) == "" and player_confederation_count <= player_confederation_limit
                            and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") or cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") == "player_ai" 
                            or cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") == "player") and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") 
                            or cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "all" or (cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "lorefriendly" 
                            and faction_P2:name() ~= "wh2_dlc09_tmb_followers_of_nagash")) then
                                if current_faction:name() == "wh_main_emp_empire" then cm:set_saved_value("karl_check_illegit", true) end
                                if are_lords_missing(current_faction) then
                                    sm0_log("["..player_confederation_count.."] Player 2 intends to intends to spawn missing lords for: "..current_faction:name())
                                    spawn_missing_lords(faction_P2, current_faction)
                                    --making sure there are no further confederations happening during the spawn_missing_lords loop
                                    player_confederation_count = player_confederation_count + player_confederation_limit
                                    --ai_confederation_count = ai_confederation_count + ai_confederation_limit
                                else
                                    sm0_log("["..player_confederation_count.."] Player 2 intends to confederate: "..current_faction:name())
                                    rd_dilemma(faction_P2, current_faction)
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
                                if ai_confederation_count <= ai_confederation_limit and prefered_faction and (not cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") 
                                or cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "all" or (cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") == "lorefriendly" 
                                and prefered_faction:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and prefered_faction:name() ~= "wh2_dlc09_tmb_the_sentinels")) 
                                and prefered_faction:subculture() ~= "wh_dlc03_sc_bst_beastmen" and current_faction:subculture() ~= "wh_main_sc_grn_savage_orcs" then -- disabled for beastmen/savage orcs because they are able to respawn anyways
                                    if not faked_death(prefered_faction) then
                                        if ai_delay == 0 or cm:model():turn_number() > ai_delay then --if ai_delay == 0 or cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) == 0 then
                                            if are_lords_missing(current_faction) then
                                                sm0_log("["..ai_confederation_count.."] AI: "..current_faction:name().." intends to spawn missing lords!")
                                                spawn_missing_lords(prefered_faction, current_faction)
                                                --making sure there are no further confederations happening during the spawn_missing_lords loop
                                                --player_confederation_count = player_confederation_count + player_confederation_limit
                                                ai_confederation_count = ai_confederation_count + ai_confederation_limit
                                            else
                                                sm0_log("["..ai_confederation_count.."] AI: "..prefered_faction:name().." intends to confederate: "..current_faction:name())
                                                confed_revived(prefered_faction, current_faction)
                                            end
                                            ai_confederation_count = ai_confederation_count + 1
                                        --else
                                        --    if not cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) then --if not cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) then 
                                        --        cm:set_saved_value("sm0_rd_delay_"..current_faction:name(), ai_delay - 1) --cm:set_saved_value("sm0_rd_delay_"..current_faction:name(), ai_delay - 1)
                                        --    else
                                        --        local turns_delay = cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) - 1 --local turns_delay = cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) - 1
                                        --        cm:set_saved_value("sm0_rd_delay_"..current_faction:name(), turns_delay) --cm:set_saved_value("sm0_rd_delay_"..current_faction:name(), turns_delay)
                                        --    end
                                        end
                                    end
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
                if cm:model():difficulty_level() == -3 then 
                    cm:disable_saving_game(false) 
                    cm:autosave_at_next_opportunity()
                end           
            end, 3, "sm0_refugee_FactionTurnStart_callback")
        end,
        true
    )

    core:add_listener(
        "sm0_confed_dilemma_DilemmaChoiceMadeEvent",
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
        "sm0_refugee_FactionJoinsConfederation",
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
        "sm0_refugee_ScriptEventConfederationExpired",
        "ScriptEventConfederationExpired",
        true,
        function(context)
            apply_diplomacy(context.string)
        end,
        true
    )
    --Multiplayer listener
    core:add_listener(
        "sm0_rd_UITriggerScriptEvent",
        "UITriggerScriptEvent",
        function(context)
            return context:trigger():starts_with("RD|")
        end,
        function(context)
            local str = context:trigger() --:string
            local info = string.gsub(str, "RD|", "")
            local cqi_end = string.find(info, ":")
            local cqi = string.sub(info, 1, cqi_end - 1) 
            local anc = string.sub(info, cqi_end + 1)
            --# assume cqi: CA_CQI
            local character = cm:get_character_by_cqi(cqi)
            cm:disable_event_feed_events(true, "", "", "character_ancillary_gained")
            cm:force_add_ancillary(character, anc, true, false) 
            cm:disable_event_feed_events(false, "", "", "character_ancillary_gained")
        end,
        true
    )
    --re-enable karl franz lock (data.pack script/campaign/main_campaign/wh_legendary_lords.lua)
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
    -- nakai confed override (data.pack script/campaign/wh_campaign_setup.lua)
    core:remove_listener("confederation_listener")
	core:add_listener(
		"confederation_listener",
		"FactionJoinsConfederation",
		true,
		function(context)
			local faction = context:confederation()
			local faction_name = faction:name()
			local faction_culture = faction:culture()
			local faction_subculture = faction:subculture()
			local faction_human = faction:is_human()
			local confederation_timeout = 5
			
			-- exclude Empire, Beastmen, Norsca and Bretonnia - they can confederate as often as they like but only if they aren't AI
			if faction_human == false or (faction_subculture ~= "wh_main_sc_emp_empire" and faction_culture ~= "wh_dlc03_bst_beastmen" and (faction_culture ~= "wh_main_brt_bretonnia" or faction_name == "wh2_dlc14_brt_chevaliers_de_lyonesse") and faction_subculture ~= "wh_main_sc_nor_norsca") then
				if faction_human == false then
					confederation_timeout = 10
				end

				out("Restricting confederation between [faction:" .. faction_name .. "] and [subculture:" .. faction_subculture .. "]")
				cm:force_diplomacy("faction:" .. faction_name, "subculture:" .. faction_subculture, "form confederation", false, true, false)
				cm:add_turn_countdown_event(faction_name, confederation_timeout, "ScriptEventConfederationExpired", faction_name)
			end
			
			local source_faction = context:faction()
			local source_faction_name = source_faction:name()
			
			-- remove deathhag after confederating/being confedrated with cult of pleasure
			if source_faction:culture() == "wh2_main_def_dark_elves" and faction_name == "wh2_main_def_cult_of_pleasure" then
				local char_list = faction:character_list()
				
				for i = 0, char_list:num_items() - 1 do
					local current_char = char_list:item_at(i)
					
					if current_char:has_skill("wh2_main_skill_all_dummy_agent_actions_def_death_hag") then
						cm:kill_character(current_char:command_queue_index(), true, true)
					end
				end
			elseif faction_culture == "wh2_main_def_dark_elves" and source_faction_name == "wh2_main_def_cult_of_pleasure" then
				local char_list = faction:character_list()
				
				for i = 0, char_list:num_items() - 1 do
					local current_char = char_list:item_at(i)
					
					if current_char:has_skill("wh2_main_skill_all_dummy_agent_actions_def_death_hag_chs") then
						cm:kill_character(current_char:command_queue_index(), true, true)
					end
				end
			elseif faction_name == "wh2_dlc13_lzd_spirits_of_the_jungle" then
				local defender_faction = cm:model():world():faction_by_key("wh2_dlc13_lzd_defenders_of_the_great_plan")
				
				cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_broken", "")
				cm:disable_event_feed_events(true, "", "", "diplomacy_treaty_negotiated_vassal");

				if defender_faction:is_null_interface() == false then
					if defender_faction:is_dead() == true and faction:has_home_region() == true then
						local home_region = faction:home_region():name()

						local x, y = cm:find_valid_spawn_location_for_character_from_settlement(
							"wh2_dlc13_lzd_defenders_of_the_great_plan",
							home_region,
							false,
							true
						)

						cm:create_force(
							"wh2_dlc13_lzd_defenders_of_the_great_plan",
							"wh2_main_lzd_inf_skink_cohort_0",
							home_region,
							x, y,
							true,
							function(char_cqi, force_cqi)
								handover_nakai_region()
                                cm:kill_character(char_cqi, true, true)
							end
						)
					else
						handover_nakai_region()
					end
					
					if defender_faction:is_vassal() == false then
						cm:force_make_vassal("wh2_dlc13_lzd_spirits_of_the_jungle", "wh2_dlc13_lzd_defenders_of_the_great_plan")
						cm:force_diplomacy("faction:wh2_dlc13_lzd_defenders_of_the_great_plan", "all", "all", false, false, false)
						cm:force_diplomacy("faction:wh2_dlc13_lzd_spirits_of_the_jungle", "faction:wh2_dlc13_lzd_defenders_of_the_great_plan", "war", false, false, true)
						cm:force_diplomacy("faction:wh2_dlc13_lzd_spirits_of_the_jungle", "faction:wh2_dlc13_lzd_defenders_of_the_great_plan", "break vassal", false, false, true)
						cm:force_diplomacy("faction:wh2_dlc13_lzd_defenders_of_the_great_plan", "all", "war", false, true, false)
						cm:force_diplomacy("faction:wh2_dlc13_lzd_defenders_of_the_great_plan", "all", "peace", false, true, false)
					end
				end
	
				cm:callback(function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_broken", "") end, 1)
				cm:callback(function() cm:disable_event_feed_events(false, "", "","diplomacy_treaty_negotiated_vassal") end, 1);
            elseif source_faction_name == "wh2_dlc13_lzd_spirits_of_the_jungle" then
                if not cm:get_saved_value("sm0_rd_wh2_dlc13_lzd_spirits_of_the_jungle") then
                    cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_broken", "")
                    cm:disable_event_feed_events(true, "", "", "diplomacy_treaty_negotiated_vassal");
    
                    cm:force_confederation(faction_name, "wh2_dlc13_lzd_defenders_of_the_great_plan")
    
                    cm:callback(function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_broken", "") end, 1)
                    cm:callback(function() cm:disable_event_feed_events(false, "", "", "diplomacy_treaty_negotiated_vassal") end, 1);
                else
                    cm:set_saved_value("sm0_rd_wh2_dlc13_lzd_spirits_of_the_jungle", false)
                end
			end
		end,
		true
	)
end

function sm0_recruit_defeated()
    RDDEBUG()
    -- diplomacy
    local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc09_tmb_tomb_kings_value")
    if not confed_option_tmb or confed_option_tmb == "yield" then
        cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
    end
    local confed_option_cst = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc11_cst_vampire_coast_value")
    if not confed_option_tmb or confed_option_tmb == "yield" then
        cm:force_diplomacy("subculture:wh2_dlc11_sc_cst_vampire_coast", "subculture:wh2_dlc11_sc_cst_vampire_coast", "form confederation", false, false, false)
    end
    local confed_option_teb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh_main_emp_empire") -- no teb / kislev subculture?
    if (not confed_option_tmb or confed_option_tmb == "yield") and not vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then
        cm:force_diplomacy("subculture:wh_main_sc_teb_teb", "subculture:wh_main_sc_teb_teb", "form confederation", false, false, false)
    end
    -- old version compatibility
    local version_number = "1.1" --debug: "vs.code" --H&B "1.0" --S&B "1.1"
    if cm:is_new_game() then 
        if not cm:get_saved_value("sm0_log_reset") then
            sm0_log_reset()
            cm:set_saved_value("sm0_log_reset", true)
        end
        if not not mcm then
            local recruit_defeated = mcm:register_mod("recruit_defeated", "Recruit Defeated Legendary Lords", "")
            --if legacy_option then
            --    local version = recruit_defeated:add_tweaker("version", "Mod Version", "Choose your prefered mod version.")
            --    version:add_option("default", "Default", "This script uses confederation methods to transfer legendary lords from dead factions to the player/ai. Written by sm0kin.")
            --    version:add_option("legacy", "Legacy", "DISCONTINUED VERSION!!!\nThis script uses spawn methods to create doppelganger lords and deletes the original legendary lords in case the faction gets revived. Written by Scipion. Originally by scipion, reworked by sm0kin.")
            --end
            local lore_restriction = recruit_defeated:add_tweaker("lore_restriction", "Restriction", "Defines whether defeated Lords/Heroes can join any faction of the same subculture or if they are restricted from joining factions that make little to no sense considering their background.") --mcm_tweaker_recruit_defeated_lore_restriction_value
            lore_restriction:add_option("all", "Gotta Catch 'Em All", "No restrictions.")
            lore_restriction:add_option("lorefriendly", "Lorefriendly", "Restrictions are in place for the following factions:\n*Khemri: no Arkhan\n*Lybaras/Exiles of Nehek/Numas: no Settra, no Arkhan\n\nRecruit Defeated is disabled for the following cultures/factions:\n*Vampire Coast\n*Savage Orcs\n*Followers of Nagash")
            local scope = recruit_defeated:add_tweaker("scope", "Available for", "Specifies if defeated Lords/Heroes are allowed to join the player, the ai or both.") --mcm_tweaker_recruit_defeated_scope_value
            scope:add_option("player_ai", "Player & AI", "")
            scope:add_option("player", "Player only", "")
            scope:add_option("ai", "AI only", "")
            local preferance = recruit_defeated:add_tweaker("preferance", "Preference (1. Level)", "Should factions prefer to join the ai or the player (supersedes \"Preference (2. Level)\")?") --mcm_tweaker_recruit_defeated_preferance_value
            preferance:add_option("player", "Prefer Player", "Defeated Lords/Heroes will always join a player-led faction.")
            preferance:add_option("ai", "Prefer AI", "As long as a AI factions is left defeated Lords/Heroes will prefer them over the player.")
            preferance:add_option("disable", "Disable", "No AI/Player preferance.")
            local preferance2 = recruit_defeated:add_tweaker("preferance2", "Preference (2. Level)", "Which factions defeated lords/heroes prefer to join (superseded by \"Preference (1. Level)\"?") --mcm_tweaker_recruit_defeated_preferance2_value
            preferance2:add_option("relation", "Relation based", "Defeated Lords/Heroes join the faction they have the best diplomatic relations with.")
            preferance2:add_option("power", "Prefer Major Factions", "Defeated Lords/Heroes will prefer Major Factions.")
            --local diplo = recruit_defeated:add_tweaker("diplo", "Lords/Heroes join factions based on diplomatic standing", "Defeated Lords/Heroes join the faction they have the best diplomatic relations with.") --mcm_tweaker_recruit_defeated_diplo_value
            --diplo:add_option("enable", "Enable", "") 
            --diplo:add_option("disable", "Disable", "")
            local ai_delay = recruit_defeated:add_variable("ai_delay", 0, 200, 50, 5, "AI Turn Delay", "Determines at which turn the AI starts to get Lords/Heroes from defeated factions.")
            mcm:add_post_process_callback(
                function()
                    --local version = cm:get_saved_value("mcm_tweaker_recruit_defeated_version_value")                    
                    --if version ~= "legacy" then
                    --    cm:set_saved_value("sm0_recruit_defeated", true)
                        sm0_log("Mod Version: default/mcm".." ("..version_number..")")
                        init()
                    --else
                    --    cm:set_saved_value("sm0_recruit_defeated", false)
                    --    sm0_log("Mod Version: legacy".." ("..version_number..")")
                    --end
                    --core:remove_listener("backup_init_trigger")
                end
            )
            --core:add_listener(
			--	"backup_init_trigger",
			--	"FactionAboutToEndTurn",
            --    function(context)
            --        local human_factions = cm:get_human_factions()
            --        local faction_P1 = cm:get_faction(human_factions[1])
			--		return context:faction():name() == faction_P1:name() and cm:model():turn_number() == 1
			--	end,
			--	function(context)
            --        cm:set_saved_value("sm0_recruit_defeated", true)
            --        sm0_log("Mod Version: default".." ("..version_number..")")
            --        init()
            --    end,
			--	false
			--)
        else
            --cm:set_saved_value("sm0_recruit_defeated", true)
            sm0_log("Mod Version: default".." ("..version_number..")")
            init()
        end
    else
        sm0_log("--------------------------- GAME LOADED (post battle or save/load) ---------------------------")
		--local version = cm:get_saved_value("mcm_tweaker_recruit_defeated_version_value")
        --if version then
		--	if version ~= "legacy" then
        --        cm:set_saved_value("sm0_recruit_defeated", true)
        --        init()
        --    else
        --        cm:set_saved_value("sm0_recruit_defeated", false)
        --    end
        --else 
        --    local old_script = false
        --    if not cm:get_saved_value("sm0_recruit_defeated") then
        --        for _, agent in ipairs(wh_agents) do 
        --            local subtype = agent.subtype
        --            if subtype ~= "wh2_main_hef_prince_alastar" and cm:get_saved_value("v_" .. subtype .. "_LL_unlocked") then old_script = true end
        --        end
        --    end
        --    if not old_script then
        --        cm:set_saved_value("sm0_recruit_defeated", true)
                init()
        --    end
		--end
    end
end