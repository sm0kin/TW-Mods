-- NEEDS WORK!!!
-- New multiplayer (up to 8 players)
-- is_faction_exempted function (may need new entries)
-- apply_diplomacy function (maybe)
-- spawn_missing_lords function (needs new spawn coordinates)

--mct variables
local enable_value 
local scope_value 
local ai_delay_value 
local preferance1_value  
local preferance2_value  
local preferance3_value  
local preferance4_value  
local preferance5_value  
local preferance6_value  
local tmb_restriction_value  
local cst_restriction_value  
local wef_restriction_value  
--local savage_restriction_value  

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
	popLog :write("RD:  [".. logTimeStamp .. "] [Turn: ".. tostring(cm:model():turn_number()) .. "(" .. tostring(cm:whose_turn_is_it_single():name()) .. ")]:  "..logText .. "  \n")
	popLog :flush()
	popLog :close()
end

local function RDDEBUG()
	--Vanish's PCaller
	--All credits to vanish
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

	local function pack2(...) return {n=select('#', ...), ...} end
	local function unpack2(t) return unpack(t, 1, t.n) end

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

	local function logFunctionCall(f, name)
		return function(...)
			out("function called: " .. name)
			return f(...)
		end
	end

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
} 

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
    ["wh_dlc08_sc_nor_norsca"] = 800,
    ["wh_main_sc_teb_teb"] = 591,
    ["wh_main_sc_vmp_vampire_counts"] = 594,
    ["wh2_dlc09_sc_tmb_tomb_kings"] = 606,
    ["wh2_dlc11_sc_cst_vampire_coast"] = 785,
    ["wh2_main_sc_def_dark_elves"] = 773,
    ["wh2_main_sc_hef_high_elves"] = 771,
    ["wh2_main_sc_lzd_lizardmen"] = 775,
    ["wh2_main_sc_skv_skaven"] = 778
} 

local wh_agents = {
    {["faction"] = "wh_main_emp_middenland", ["subtype"] = "wh_dlc03_emp_boris_todbringer", ["dlc"] = "TW_WH_BEASTMEN"},
    {["faction"] = "wh_main_emp_empire", ["subtype"] = "wh_dlc04_emp_volkmar", ["dlc"] = "TW_WH_LORDS_AND_UNITS_1"},
    {["faction"] = "wh_main_emp_empire", ["subtype"] = "wh_main_emp_balthasar_gelt"},
    {["faction"] = "wh_main_emp_empire", ["subtype"] = "wh_main_emp_karl_franz"},
    {["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "wh_dlc04_vmp_helman_ghorst", ["dlc"] = "TW_WH_LORDS_AND_UNITS_1"},
    {["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "wh_dlc04_vmp_vlad_con_carstein"},
    {["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "wh_pro02_vmp_isabella_von_carstein"},
    {["faction"] = "wh2_dlc11_vmp_the_barrow_legion", ["subtype"] = "wh_main_vmp_heinrich_kemmler"},
    {["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "wh_main_vmp_mannfred_von_carstein"},
    {["faction"] = "wh_main_vmp_mousillon", ["subtype"] = "wh_dlc05_vmp_red_duke", ["dlc"] = "TW_WH_WOOD_ELVES"},
    {["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "wh_main_dwf_thorgrim_grudgebearer"},
    {["faction"] = "wh_main_dwf_karak_kadrin", ["subtype"] = "wh_main_dwf_ungrim_ironfist"},
    {["faction"] = "wh_main_dwf_karak_izor", ["subtype"] = "wh_dlc06_dwf_belegar", ["dlc"] = "TW_WH_LORDS_AND_UNITS_2"},
    {["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "wh_pro01_dwf_grombrindal"},
    {["faction"] = "wh_main_grn_crooked_moon", ["subtype"] = "wh_dlc06_grn_skarsnik", ["dlc"] = "TW_WH_LORDS_AND_UNITS_2"},
    {["faction"] = "wh_main_grn_greenskins", ["subtype"] = "wh_main_grn_azhag_the_slaughterer"},
    {["faction"] = "wh_main_grn_greenskins", ["subtype"] = "wh_main_grn_grimgor_ironhide"},
    {["faction"] = "wh_main_grn_orcs_of_the_bloody_hand", ["subtype"] = "wh_dlc06_grn_wurrzag_da_great_prophet"},
    {["faction"] = "wh2_dlc09_tmb_followers_of_nagash", ["subtype"] = "wh2_dlc09_tmb_arkhan", ["dlc"] = "TW_WH2_TOMB_KINGS"},
    {["faction"] = "wh2_dlc09_tmb_lybaras", ["subtype"] = "wh2_dlc09_tmb_khalida", ["dlc"] = "TW_WH2_TOMB_KINGS"},
    {["faction"] = "wh2_dlc09_tmb_exiles_of_nehek", ["subtype"] = "wh2_dlc09_tmb_khatep", ["dlc"] = "TW_WH2_TOMB_KINGS"},
    {["faction"] = "wh2_dlc09_tmb_khemri", ["subtype"] = "wh2_dlc09_tmb_settra", ["dlc"] = "TW_WH2_TOMB_KINGS"},
    {["faction"] = "wh_main_brt_bretonnia", ["subtype"] = "wh_main_brt_louen_leoncouer"},
    {["faction"] = "wh_main_brt_bordeleaux", ["subtype"] = "wh_dlc07_brt_alberic"},
    {["faction"] = "wh_main_brt_carcassonne", ["subtype"] = "wh_dlc07_brt_fay_enchantress"},
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
    {["faction"] = "wh_dlc05_wef_argwylon", ["subtype"] = "wh_dlc05_wef_durthu", ["dlc"] = "TW_WH_WOOD_ELVES"},
    {["faction"] = "wh_dlc05_wef_wood_elves", ["subtype"] = "wh_dlc05_wef_orion", ["dlc"] = "TW_WH_WOOD_ELVES"},
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
    {["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "wh_dlc03_bst_khazrak", ["dlc"] = "TW_WH_BEASTMEN"},
    {["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "wh_dlc03_bst_malagor", ["dlc"] = "TW_WH_BEASTMEN"},
    {["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "wh_dlc05_bst_morghur", ["dlc"] = "TW_WH_BEASTMEN"},
    {["faction"] = "wh2_dlc14_brt_chevaliers_de_lyonesse", ["subtype"] = "wh2_dlc14_brt_repanse"},
    {["faction"] = "wh2_dlc14_brt_chevaliers_de_lyonesse", ["subtype"] = "wh2_dlc14_brt_henri_le_massif"},
    {["faction"] = "wh2_main_skv_clan_eshin", ["subtype"] = "wh2_dlc14_skv_deathmaster_snikch", ["dlc"] = "TW_WH2_DLC14_SHADOW"},
    {["faction"] = "wh2_main_def_hag_graef", ["subtype"] = "wh2_dlc14_def_malus_darkblade", ["dlc"] = "TW_WH2_DLC14_SHADOW"},
    {["faction"] = "wh2_dlc15_grn_broken_axe", ["subtype"] = "wh2_dlc15_grn_grom_the_paunch", ["dlc"] = "TW_WH2_DLC15_WARDEN"},
    {["faction"] = "wh2_main_hef_yvresse", ["subtype"] = "wh2_dlc15_hef_eltharion", ["dlc"] = "TW_WH2_DLC15_WARDEN"},
    {["faction"] = "wh2_dlc15_hef_imrik", ["subtype"] = "wh2_dlc15_hef_imrik", ["dlc"] = "TW_WH2_DLC15_IMRIK_FREE"},
    {["faction"] = "wh2_main_skv_clan_moulder", ["subtype"] = "wh2_dlc16_skv_throt_the_unclean", ["dlc"] = "TW_WH2_DLC16_TWILIGHT"},
    {["faction"] = "wh2_main_skv_clan_moulder", ["subtype"] = "wh2_dlc16_skv_ghoritch", ["dlc"] = "TW_WH2_DLC16_TWILIGHT"},
    {["faction"] = "wh2_dlc16_wef_drycha", ["subtype"] = "wh2_dlc16_wef_drycha", ["dlc"] = {"TW_WH_WOOD_ELVES", "TW_WH2_DLC16_TWILIGHT"}},
    {["faction"] = "wh2_dlc16_wef_drycha", ["subtype"] = "wh2_dlc16_wef_coeddil", ["dlc"] = {"TW_WH_WOOD_ELVES", "TW_WH2_DLC16_TWILIGHT"}},
    {["faction"] = "wh2_dlc16_wef_sisters_of_twilight", ["subtype"] = "wh2_dlc16_wef_ariel", ["dlc"] = "TW_WH2_DLC16_TWILIGHT"},
    {["faction"] = "wh2_dlc16_wef_sisters_of_twilight", ["subtype"] = "wh2_dlc16_wef_sisters_of_twilight", ["dlc"] = "TW_WH2_DLC16_TWILIGHT"},
    {["faction"] = "wh2_twa03_def_rakarth", ["subtype"] = "wh2_twa03_def_rakarth", ["dlc"] = "TW_WH_TWA_03_RAKARTH"},
    {["faction"] = "wh2_dlc17_bst_taurox", ["subtype"] = "wh2_dlc17_bst_taurox", ["dlc"] = "TW_WH2_DLC17_SILENCE"},
    {["faction"] = "wh2_dlc17_lzd_oxyotl", ["subtype"] = "wh2_dlc17_lzd_oxyotl", ["dlc"] = "TW_WH2_DLC17_SILENCE"},
    {["faction"] = "wh2_dlc17_dwf_thorek_ironbrow", ["subtype"] = "wh2_dlc17_dwf_thorek", ["dlc"] = "TW_WH2_DLC17_THOREK_FREE"},
    {["faction"] = "wh3_main_cth_the_northern_provinces", ["subtype"] = "wh3_main_cth_miao_ying"},
    {["faction"] = "wh3_main_cth_the_western_provinces", ["subtype"] = "wh3_main_cth_zhao_ming"},
    --{["faction"] = "wh3_main_dae_daemon_prince", ["subtype"] = "wh3_main_dae_daemon_prince"},
    {["faction"] = "wh3_main_kho_exiles_of_khorne", ["subtype"] = "wh3_main_kho_skarbrand"},
    {["faction"] = "wh3_main_ksl_the_great_orthodoxy", ["subtype"] = "wh3_main_ksl_kostaltyn"},
    {["faction"] = "wh3_main_ksl_the_ice_court", ["subtype"] = "wh3_main_ksl_katarin"},
    {["faction"] = "wh3_main_ksl_ursun_revivalists", ["subtype"] = "wh3_main_ksl_boris"},
    {["faction"] = "wh3_main_nur_poxmakers_of_nurgle", ["subtype"] = "wh3_main_nur_kugath"},
    {["faction"] = "wh3_main_ogr_disciples_of_the_maw", ["subtype"] = "wh3_main_ogr_skrag_the_slaughterer"},
    {["faction"] = "wh3_main_ogr_goldtooth", ["subtype"] = "wh3_main_ogr_greasus_goldtooth"},
    {["faction"] = "wh3_main_sla_seducers_of_slaanesh", ["subtype"] = "wh3_main_sla_nkari"},
    {["faction"] = "wh3_main_tze_oracles_of_tzeentch", ["subtype"] = "wh3_main_tze_kairos"}
} 
    --MIXU Part 1--
local mixu1_agents = {
    {["faction"] = "wh_main_brt_artois", ["subtype"] = "brt_chilfroy"},
    {["faction"] = "wh_main_brt_bastonne", ["subtype"] = "brt_bohemond"},
    {["faction"] = "wh_main_brt_lyonesse", ["subtype"] = "brt_adalhard"},
    {["faction"] = "wh_main_brt_parravon", ["subtype"] = "brt_cassyon"},
    {["faction"] = "wh_main_dwf_karak_azul", ["subtype"] = "dwf_kazador_dragonslayer"},
    {["faction"] = "wh_main_dwf_karak_azul", ["subtype"] = "dwf_thorek_ironbrow"},
    {["faction"] = "wh_main_emp_wissenland", ["subtype"] = "mixu_elspeth_von_draken"},
    --{["faction"] = "wh_main_ksl_kislev", ["subtype"] = "ksl_katarin_the_ice_queen"},
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
    --{["faction"] = "wh2_main_bst_manblight", ["subtype"] = "bst_taurox"}, --dlc
    {["faction"] = "wh_dlc05_wef_wydrioth", ["subtype"] = "wef_drycha"}
}
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
} 
    --XOUDAD High Elves Expanded--
local xoudad_agents = {
    --{["faction"] = "wh2_main_hef_yvresse", ["subtype"] = "wh2_main_hef_eltharion"}, --dlc
    {["faction"] = "", ["subtype"] = "wax_emp_valten"}
} 
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
} 
    --CATAPH Kraka Drak--
local kraka_agents = {
    {["faction"] = "wh_main_dwf_kraka_drak", ["subtype"] = "dwf_kraka_drak"}
} 
    --Project Resurrection - Parte Legendary Lords--
local parte_agents = {
    --{["faction"] = "wh2_main_def_karond_kar", ["subtype"] = "def_rakarth"},
    {["faction"] = "wh2_main_skv_clan_moulder", ["subtype"] = "skv_skweel_gnawtooth"},
    {["faction"] = "wh2_main_def_blood_hall_coven", ["subtype"] = "def_hag_queen_malida"},
    {["faction"] = "wh2_main_hef_cothique", ["subtype"] = "hef_aislinn"},
    {["faction"] = "wh_main_dwf_barak_varr", ["subtype"] = "dwf_byrrnoth_grundadrakk"},
    {["faction"] = "wh_main_dwf_karak_ziflin", ["subtype"] = "dwf_rorek_granitehand"},
    {["faction"] = "wh_main_dwf_karak_hirn", ["subtype"] = "dwf_alrik_ranulfsson"}
} 
    --We'z Speshul--
local speshul_agents = {
    {["faction"] = "wh_main_grn_greenskins", ["subtype"] = "spcha_grn_borgut_facebeater"},
    {["faction"] = "wh_main_grn_orcs_of_the_bloody_hand", ["subtype"] = "spcha_grn_grokka_goreaxe"},
    {["faction"] = "", ["subtype"] = "spcha_grn_tinitt_foureyes"}, -- wh_main_grn_black_venom -- wh2_main_grn_arachnos 
    {["faction"] = "wh2_main_grn_blue_vipers", ["subtype"] = "spcha_grn_grak_beastbasha"},
    {["faction"] = "wh_main_grn_crooked_moon", ["subtype"] = "spcha_grn_duffskul"},
    {["faction"] = "", ["subtype"] = "spcha_grn_snagla_grobspit"} -- wh_main_grn_black_venom -- wh2_main_grn_arachnos 
} 
    --Whysofurious' Additional Lords & Heroes--
local wsf_agents = {
    {["faction"] = "wh_main_emp_empire", ["subtype"] = "genevieve"},
    {["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "helsnicht"},
    {["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "konrad"},
    {["faction"] = "wh_main_vmp_mousillon", ["subtype"] = "mallobaude"},
    --{["faction"] = "", ["subtype"] = "sycamo"},
    {["faction"] = "wh2_main_vmp_necrarch_brotherhood", ["subtype"] = "zacharias"}
} 
    --Ordo Draconis - Templehof Expanded--
local ordo_agents = {
    {["faction"] = "wh_main_vmp_rival_sylvanian_vamps", ["subtype"] = "abhorash"},
    {["faction"] = "wh_main_vmp_rival_sylvanian_vamps", ["subtype"] = "vmp_walach_harkon_hero"},
    {["faction"] = "wh_main_vmp_rival_sylvanian_vamps", ["subtype"] = "tib_kael"}
} 
    --WsF' Vampire Bloodlines: The Strigoi--
local strigoi_agents = {
    {["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "ushoran"},
    {["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "vorag"},
    {["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "str_high_priest"},
    {["faction"] = "wh2_main_vmp_strygos_empire", ["subtype"] = "nanosh"}
} 
    --OvN Second Start--
local second_start_agents = {
    --{["faction"] = "wh2_main_hef_yvresse", ["subtype"] = "sr_grim"}
} 
    --OvN Lost Factions - Beta--
local lost_factions_agents = {
    --{["faction"] = "", ["subtype"] = "ovn_hlf_ll"},
    --{["faction"] = "", ["subtype"] = "ovn_araby_ll"},
    --{["faction"] = "", ["subtype"] = "Sultan_Jaffar"},
    --{["faction"] = "", ["subtype"] = "morgan_bernhardt"}
} 
    --Empire Master Engineer
local zf_agents = {
    {["faction"] = "", ["subtype"] = "wh_main_emp_jubal_falk"}
} 
    --Cataph's High Elf Sea Patrol
local seahelm_agents = {
    {["faction"] = "", ["subtype"] = "AK_aislinn"}
} 
--Mixu's: Vangheist's Revenge
local mixu_vangheist = {
    {["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_vangheist", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_the_white_death", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_tia_drowna", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_dreng_gunddadrak", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"},
    {["faction"] = "wh2_main_cst_the_shadewraith", ["subtype"] = "cst_bloodline_khoskog", ["dlc"] = "TW_WH2_DLC11_VAMPIRE_COAST"}
} 

local alastar_quests = {
    { "wh2_main_anc_armour_lions_pelt", 1}
} 

local locked_ai_generals = {
    {["id"] = "2140784160",	["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "wh_pro01_dwf_grombrindal"},                                                             -- Grombrindal
    --{["id"] = "2140783606",	["faction"] = "wh_main_grn_greenskins", ["subtype"] = "wh_main_grn_azhag_the_slaughterer"},                                                   -- Azhag the Slaughterer
    {["id"] = "2140784146",	["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "wh_dlc04_vmp_helman_ghorst", ["dlc"] = "TW_WH_LORDS_AND_UNITS_1"},              -- Helman Ghorst
    {["id"] = "2140784202",	["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "wh_pro02_vmp_isabella_von_carstein"},                                            -- Isabella von Carstein

    --{["id"] = "",	["faction"] = "wh2_main_hef_eataine", ["subtype"] = "wh2_main_hef_prince_alastar"},                                                               -- Alastar
    --{["id"] = "2140784127",	["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "wh_dlc03_bst_malagor"},                                                            -- Malagor
    --{["id"] = "2140784189",	["faction"] = "wh_dlc03_bst_beastmen", ["subtype"] = "wh_dlc05_bst_morghur"},                                                            -- Morghur
    --{["id"] = "2140783648",	["faction"] = "wh2_dlc13_emp_golden_order", ["subtype"] = "wh_main_emp_balthasar_gelt"},                                                      -- Balthasar Gelt
    {["id"] = "2140784136",	["faction"] = "wh_main_emp_empire", ["subtype"] = "wh_dlc04_emp_volkmar", ["dlc"] = "TW_WH_LORDS_AND_UNITS_1"}                             -- Volkmar the Grim
} 

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
    "wh2_dlc15_grn_broken_axe",
    "wh2_main_skv_clan_moulder",
    "wh2_dlc16_wef_drycha",
    "wh2_dlc16_wef_sisters_of_twilight",
    "wh2_twa03_def_rakarth",
    "wh2_dlc17_lzd_oxyotl",
    "wh2_dlc17_dwf_thorek_ironbrow",
    "wh2_dlc17_bst_taurox",
    "wh3_main_cth_the_northern_provinces",
    "wh3_main_cth_the_western_provinces",
    "wh3_main_dae_daemon_prince",
    "wh3_main_kho_exiles_of_khorne",
    "wh3_main_ksl_the_great_orthodoxy",
    "wh3_main_ksl_the_ice_court",
    "wh3_main_ksl_ursun_revivalists",
    "wh3_main_nur_poxmakers_of_nurgle",
    "wh3_main_ogr_disciples_of_the_maw",
    "wh3_main_ogr_goldtooth",
    "wh3_main_sla_seducers_of_slaanesh",
    "wh3_main_tze_oracles_of_tzeentch"
} 

local chs_subtype_anc = {
    ["wh3_main_ksl_katarin"] = {
        {"reward", "wh3_main_anc_weapon_frost_fang", nil, 7},
        {"mission", "wh3_main_anc_armour_the_crystal_cloak", "wh3_main_qb_ksl_katarin_crystal_cloak", 10, nil, "wh3_main_camp_quest_katarin_the_crystal_cloak_001", 245, 291}
    },
    ["wh3_main_ksl_kostaltyn"] = {
        {"mission", "wh3_main_anc_weapon_the_burning_brazier", "wh3_main_qb_ksl_kostaltyn_burning_brazier", 10, nil, "wh3_main_camp_quest_kostaltyn_burning_brazier_001", 153, 162}
    },
    ["wh3_main_ksl_boris"] = {
        {"reward", "wh3_main_anc_weapon_shard_blade", nil, 7},
        {"reward", "wh3_main_anc_armour_armour_of_ursun", nil, 10}
    },
    ["wh3_main_ogr_greasus_goldtooth"] = {
        {"reward", "wh3_main_anc_weapon_sceptre_of_titans", nil, 7},
        {"mission", "wh3_main_anc_talisman_overtyrants_crown", "wh3_main_qb_ogr_greasus_overtyrants_crown", 10, nil, "wh3_main_camp_quest_greasus_overtyrants_crown_001", 591, 240}
    },
    ["wh3_main_ogr_skrag_the_slaughterer"] = {
        {"mission", "wh3_main_anc_enchanted_item_cauldron_of_the_great_maw", "wh3_main_qb_ogr_skrag_cauldron_of_the_great_maw", 10, nil, "wh3_main_camp_quest_skrag_cauldron_of_the_great_maw_001", 515, 238}
    },
    ["wh3_main_kho_skarbrand"] = {
        {"mission", "wh3_main_anc_weapon_slaughter_and_carnage", "wh3_main_qb_kho_skarbrand_slaughter_and_carnage", 10, nil, "wh3_main_camp_quest_skarbrand_slaughter_and_carnage_001", 285, 278}
    },
    ["wh3_main_nur_kugath"] = {
        {"mission", "wh3_main_anc_weapon_necrotic_missiles", "wh3_main_qb_nur_kugath_necrotic_missiles", 10, nil, "wh3_main_camp_quest_kugath_necrotic_missiles_001", 465, 256}
    },
    ["wh3_main_sla_nkari"] = {
        {"mission", "wh3_main_anc_weapon_witstealer_sword", "wh3_main_qb_sla_nkari_witstealer_sword", 10, nil, "wh3_main_camp_quest_nkari_witstealer_sword_001", 30, 431}
    },
    ["wh3_main_tze_kairos"] = {
        {"mission", "wh3_main_anc_arcane_item_staff_of_tomorrow", "wh3_main_qb_tze_kairos_staff_of_tomorrow", 10, nil, "wh3_main_camp_quest_kairos_staff_of_tomorrow_001", 253, 400}
    }
}

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
    ["wh2_twa03_def_rakarth"] = {
		{"mission", "wh2_twa03_anc_weapon_whip_of_agony", "wh2_twa03_great_vortex_def_rakarth_whip_of_agony_stage_1", 2, "wh2_twa03_great_vortex_def_rakarth_whip_of_agony_stage_2_mpc"}
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
    ["wh2_dlc16_skv_throt_the_unclean"] = {
		{"mission", "wh2_dlc16_anc_enchanted_item_whip_of_domination", "wh2_dlc16_skv_throt_vortex_whip_of_domination_stage_1", 5, "wh2_dlc16_skv_throt_vortex_whip_of_domination_stage_4_mpc"},
		{"mission", "wh2_dlc16_anc_weapon_creature_killer", "wh2_dlc16_skv_throt_vortex_creature_killer_stage_1", 3}
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
    ["wh2_dlc16_wef_sisters_of_twilight"] = {
		{"mission", "wh2_dlc16_anc_mount_wef_cha_sisters_of_twilight_forest_dragon", "wh2_dlc16_great_vortex_wef_sisters_dragon_stage_1", 12,"wh2_dlc16_great_vortex_wef_sisters_dragon_stage_4_mpc"}
	},
    ["wh2_dlc17_lzd_oxyotl"] = {
        {"mission", "wh2_dlc17_anc_weapon_the_golden_blowpipe_of_ptoohee", "wh2_dlc17_great_vortex_lzd_oxyotl_the_golden_blowpipe_of_ptoohee_stage_1", 5, "wh2_dlc17_great_vortex_lzd_oxyotl_the_golden_blowpipe_of_ptoohee_stage_4b_mpc"}
    },
    ["wh2_dlc17_bst_taurox"] = {
        {"mission", "wh2_dlc17_anc_weapon_rune_tortured_axes", "wh2_dlc17_great_vortex_bst_taurox_rune_tortured_axes_stage_1", 5,"wh2_dlc17_great_vortex_bst_taurox_rune_tortured_axes_stage_3_mpc"}
    },
    ["wh2_dlc17_dwf_thorek"] = {
        {"mission", "wh2_dlc17_anc_weapon_klad_brakak", "wh2_dlc17_great_vortex_dwf_thorek_klad_brakak_stage_1", 5,"wh2_dlc17_great_vortex_dwf_thorek_klad_brakak_stage_4_mp"},
        {"mission", "wh2_dlc17_anc_armour_thoreks_rune_armour", "wh2_dlc17_great_vortex_dwf_thorek_rune_armour_quest", 3, "wh2_dlc17_great_vortex_dwf_thorek_rune_armour_quest"}
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
    --["mixu_katarin_the_ice_queen"] = {
    --    {"", "mixu_anc_enchanted_item_ksl_katarin_the_ice_queen_crystal_cloak", "", 9},
    --    {"", "mixu_anc_weapon_ksl_katarin_the_ice_queen_fearfrost", "", 15}
    --},
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
    ["wh_dlc03_emp_boris_todbringer"] = {
        {"", "mixu_anc_enchanted_item_emp_boris_todbringer_talisman_of_ulric", "", 15}
    },
    ["emp_vorn_thugenheim"] = {
        {"", "mixu_anc_talisman_emp_vorn_thugenheim_heart_of_middenheim", "", 15},
        {"", "mixu_anc_enchanted_item_emp_vorn_thugenheim_pelt_of_horrors", "", 10}
    },
    --["bst_taurox"] = {
    --    {"", "mixu_anc_weapon_bst_taurox_the_brass_bull_rune_tortured_axes", "", 13}
    --},
    ["emp_wolfram_hertwig"] = {
        {"", "mixu_anc_talisman_emp_wolfram_hertwig_kislevite_icon", "", 14}
    }
} 

local vor_missing_anc = {
    ["wh2_dlc10_hef_alarielle"] = {
        {"", "wh2_dlc10_anc_magic_standard_banner_of_avelorn", "", 1},
        {"", "wh2_dlc10_anc_arcane_item_stave_of_avelorn", "", 1}
    },
    ["wh2_dlc12_skv_ikit_claw"] = {
        {"", "wh2_dlc12_anc_armour_iron_frame", "", 1}
    },
    ["wh_dlc06_grn_skarsnik"] = {
        {"", "wh_dlc06_anc_magic_standard_skarsniks_boyz", "", 1}
    },
    ["wh2_dlc12_lzd_tehenhauin"] = {
        {"", "wh2_dlc12_anc_weapon_blade_of_the_serpents_tongue", "", 1}
    },
    ["wh_main_grn_grimgor_ironhide"] = {
        {"", "wh_main_anc_magic_standard_da_immortulz", "", 1}
    },
    ["wh2_main_hef_prince_alastar"] = {
        {"", "wh2_main_anc_armour_lions_pelt", "", 1}
    },
    ["wh_dlc03_emp_boris_todbringer"] = {
        {"", "wh_main_anc_talisman_the_white_cloak_of_ulric", "", 1}
    },
    ["wh2_dlc10_hef_alith_anar"] = {
        {"", "wh2_dlc10_anc_talisman_stone_of_midnight", "", 1}
    },
    ["wh_main_vmp_heinrich_kemmler"] = {
        {"", "wh2_dlc11_anc_follower_vmp_the_ravenous_dead", "", 1}
    },
    ["wh2_dlc12_lzd_tiktaqto"] = {
        {"", "wh2_dlc12_anc_weapon_the_blade_of_ancient_skies", "", 1}
    },
    ["wh2_dlc11_cst_harkon"] = {
        {"", "wh2_dlc11_anc_follower_captain_drekla", "", 1}
    },
    ["wh2_dlc15_hef_imrik"] = {
        {"", "wh2_dlc15_anc_weapon_star_lance", "", 1}
    },
    ["wh2_twa03_def_rakarth"] = {
        {"", "wh2_twa03_anc_armour_beast_armour_of_karond_kar", "", 1}
    },
    ["wh2_dlc17_dwf_thorek_ironbrow"] = {
        {"", "wh_main_anc_rune_master_rune_of_stoicism", "", 1},
        {"", "wh2_dlc17_anc_follower_dwf_kraggi", "", 1},
        {"", "wh2_dlc17_anc_rune_engineering_rune_of_burning", "", 1}
    },
    ["wh2_dlc17_lzd_oxyotl"] = {
        {"", "wh2_dlc17_anc_banner_lzd_poison_fireblood_toxin", "", 1},
        {"", "wh2_dlc17_anc_banner_lzd_poison_toadskin_essence", "", 1}
    }
} 

local me_subtype_anc = {
    ["wh_main_emp_karl_franz"] = {
        {"mission", "wh2_dlc13_anc_weapon_runefang_drakwald", "wh_main_emp_karl_franz_reikland_runefang_stage_1", 3, "wh_main_emp_karl_franz_reikland_runefang_stage_3a_mpc"},
        {"mission", "wh_main_anc_weapon_ghal_maraz", "wh_main_emp_karl_franz_ghal_maraz_stage_1", 14,"wh_main_emp_karl_franz_ghal_maraz_stage_3.1_mpc"},
        {"mission", "wh_main_anc_talisman_the_silver_seal", "wh_main_emp_karl_franz_silver_seal_stage_1", 8}
    },
    ["wh_main_emp_balthasar_gelt"] = {
        {"mission", "wh_main_anc_enchanted_item_cloak_of_molten_metal", "wh_main_emp_balthasar_gelt_cloak_of_molten_metal_stage_1", 4,"wh_main_emp_balthasar_gelt_cloak_of_molten_metal_stage_5a_mpc"},
        {"mission", "wh_main_anc_talisman_amulet_of_sea_gold", "wh_main_emp_balthasar_gelt_amulet_of_sea_gold_stage_1.1", 8,"wh_main_emp_balthasar_gelt_amulet_of_sea_gold_stage_4.1a_mpc"},
        {"mission", "wh_main_anc_arcane_item_staff_of_volans", "wh_main_emp_balthasar_gelt_staff_of_volans_stage_1", 14,"wh_main_qb_emp_balthasar_gelt_staff_of_volans_stage_3_battle_of_bloodpine_woods_mpc"}
    },
    ["wh_dlc04_emp_volkmar"] = {
        {"mission", "wh_dlc04_anc_talisman_jade_griffon", "wh_dlc04_emp_volkmar_the_grim_jade_griffon_stage_1", 5,"wh_dlc04_emp_volkmar_the_grim_jade_griffon_stage_4_mpc"},
        {"mission", "wh_dlc04_anc_weapon_staff_of_command", "wh_dlc04_emp_volkmar_the_grim_staff_of_command_stage_1", 10,"wh_dlc04_emp_volkmar_the_grim_staff_of_command_stage_5_mpc"}
    },
    ["wh2_dlc13_emp_cha_markus_wulfhart_0"] = {
        {"mission", "wh2_dlc13_anc_weapon_amber_bow", "wh2_dlc13_emp_wulfhart_amber_bow_stage_1", 8,"wh2_dlc13_emp_wulfhart_amber_bow_stage_4"}
    },
    ["wh_main_dwf_thorgrim_grudgebearer"] = {
        {"mission", "wh_main_anc_weapon_the_axe_of_grimnir", "wh_main_dwf_thorgrim_grudgebearer_axe_of_grimnir_stage_1", 8,"wh_main_dwf_thorgrim_grudgebearer_axe_of_grimnir_stage_3a_mpc"},
        {"mission", "wh_main_anc_armour_the_armour_of_skaldour", "wh_main_dwf_thorgrim_grudgebearer_armour_of_skaldour_stage_1", 13,"wh_main_dwf_thorgrim_grudgebearer_armour_of_skaldour_stage_4a_mpc"},
        {"mission", "wh_main_anc_talisman_the_dragon_crown_of_karaz", "wh_main_dwf_thorgrim_grudgebearer_dragon_crown_of_karaz_stage_1", 18,"wh_main_dwf_thorgrim_grudgebearer_dragon_crown_of_karaz_stage_3a_mpc"},
        {"mission", "wh_main_anc_enchanted_item_the_great_book_of_grudges", "wh_main_dwf_thorgrim_grudgebearer_book_of_grudges_stage_1", 23,"wh_main_dwf_thorgrim_grudgebearer_book_of_grudges_stage_2_mpc"}
    },
    ["wh_main_dwf_ungrim_ironfist"] = {
        {"mission", "wh_main_anc_armour_the_slayer_crown", "wh_main_dwf_ungrim_ironfist_slayer_crown_stage_1", 8,"wh_main_dwf_ungrim_ironfist_slayer_crown_stage_4a_mpc"},
        {"mission", "wh_main_anc_talisman_dragon_cloak_of_fyrskar", "wh_main_dwf_ungrim_ironfist_dragon_cloak_of_fyrskar_stage_1", 13,"wh_main_dwf_ungrim_ironfist_dragon_cloak_of_fyrskar_stage_3.2a_mpc"},
        {"mission", "wh_main_anc_weapon_axe_of_dargo", "wh_main_dwf_ungrim_ironfist_axe_of_dargo_stage_1", 18,"wh_main_dwf_ungrim_ironfist_axe_of_dargo_stage_3_mpc"}
    } ,
    ["wh_pro01_dwf_grombrindal"] = {
        {"mission", "wh_pro01_anc_armour_armour_of_glimril_scales", "wh_pro01_dwf_grombrindal_amour_of_glimril_scales_stage_1", 8,"wh_pro01_dwf_grombrindal_amour_of_glimril_scales_stage_3a_b_mpc"},
        {"mission", "wh_pro01_anc_weapon_the_rune_axe_of_grombrindal", "wh_pro01_dwf_grombrindal_rune_axe_of_grombrindal_stage_1", 13,"wh_pro01_dwf_grombrindal_rune_axe_of_grombrindal_stage_3.1_mpc"},
        {"mission", "wh_pro01_anc_talisman_cloak_of_valaya", "wh_pro01_dwf_grombrindal_rune_cloak_of_valaya_stage_1", 18,"wh_pro01_dwf_grombrindal_rune_cloak_of_valaya_stage_5.1_mpc"},
        {"mission", "wh_pro01_anc_enchanted_item_rune_helm_of_zhufbar", "wh_pro01_dwf_grombrindal_rune_helm_of_zhufbar_stage_1", 23,"wh_pro01_dwf_grombrindal_rune_helm_of_zhufbar_stage_4.1_mpc"}
    },
    ["wh_main_grn_grimgor_ironhide"] = {
        {"mission", "wh_main_anc_weapon_gitsnik", "wh_main_grn_grimgor_ironhide_gitsnik_stage_1", 8,"wh_main_grn_grimgor_ironhide_gitsnik_stage_4a_mpc"},
        {"mission", "wh_main_anc_armour_blood-forged_armour", "wh_main_grn_grimgor_ironhide_blood_forged_armour_stage_1.1", 13,"wh_main_grn_grimgor_ironhide_blood_forged_armour_stage_4a_mpc"}
    },
    ["wh_main_grn_azhag_the_slaughterer"] = {
        {"mission", "wh_main_anc_enchanted_item_the_crown_of_sorcery", "wh_main_grn_azhag_the_slaughterer_crown_of_sorcery_stage_1", 8,"wh_main_grn_azhag_the_slaughterer_crown_of_sorcery_stage_3a_mpc"},
        {"mission", "wh_main_anc_armour_azhags_ard_armour", "wh_main_grn_azhag_the_slaughterer_azhags_ard_armour_stage_1.1", 13,"wh_main_grn_azhag_the_slaughterer_azhags_ard_armour_stage_4a_mpc"}, --{"dilemma", "wh_main_anc_armour_azhags_ard_armour", "wh_main_azhag_the_slaughterer_azhags_ard_armour_stage_1", 13,"wh_main_grn_azhag_the_slaughterer_azhags_ard_armour_stage_4a_mpc"},        
        {"mission", "wh_main_anc_weapon_slaggas_slashas", "wh_main_grn_azhag_the_slaughterer_slaggas_slashas_stage_1", 18,"wh_main_grn_azhag_the_slaughterer_slaggas_slashas_stage_4a_mpc"}
    },
    ["wh2_dlc15_grn_grom_the_paunch"] = {
		{"mission", "wh2_dlc15_anc_weapon_axe_of_grom", "wh2_dlc15_main_grn_grom_axe_of_grom_stage_1", 5,"wh2_dlc15_main_grn_grom_axe_of_grom_stage_4_mpc"},
		{"mission", "wh2_dlc15_anc_enchanted_item_lucky_banner", "wh2_dlc15_main_grn_grom_lucky_banner_stage_1", 2}
	},
    ["wh_main_vmp_mannfred_von_carstein"] = {
        {"mission", "wh_main_anc_weapon_sword_of_unholy_power", "wh_main_vmp_mannfred_von_carstein_sword_of_unholy_power_stage_1", 8,"wh_main_vmp_mannfred_von_carstein_sword_of_unholy_power_stage_3_mpc"},
        {"mission", "wh_main_anc_armour_armour_of_templehof", "wh_main_vmp_mannfred_von_carstein_armour_of_templehof_stage_1", 13,"wh_main_vmp_mannfred_von_carstein_armour_of_templehof_stage_4_mpc"}
    },
    ["wh_main_vmp_heinrich_kemmler"] = {
        {"mission", "wh_main_anc_weapon_chaos_tomb_blade", "wh_main_vmp_heinrich_kemmler_chaos_tomb_blade_stage_1", 8,"wh_main_vmp_heinrich_kemmler_chaos_tomb_blade_stage_4a_mpc"},
        {"mission", "wh_main_anc_enchanted_item_cloak_of_mists_and_shadows", "wh_main_vmp_heinrich_kemmler_cloak_of_mists_stage_1", 13,"wh_main_vmp_heinrich_kemmler_cloak_of_mists_stage_2a_mpc"},
        {"mission", "wh_main_anc_arcane_item_skull_staff", "wh_main_vmp_heinrich_kemmler_skull_staff_stage_1.1", 18,"wh_main_vmp_heinrich_kemmler_skull_staff_stage_3a_mpc"}
    },
    ["wh_dlc04_vmp_vlad_con_carstein"] = {
        {"mission", "wh_dlc04_anc_weapon_blood_drinker", "wh_dlc04_vmp_vlad_von_carstein_blood_drinker_stage_1", 8,"wh_dlc04_vmp_vlad_von_carstein_blood_drinker_stage_3_mpc"},
        {"mission", "wh_dlc04_anc_talisman_the_carstein_ring", "wh_dlc04_vmp_vlad_von_carstein_the_carstein_ring_stage_1", 13,"wh_dlc04_vmp_vlad_von_carstein_the_carstein_ring_stage_4_mpc"}
    },
    ["wh_dlc04_vmp_helman_ghorst"] = {
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
    ["wh_dlc03_bst_khazrak"] = {
        {"mission", "wh_dlc03_anc_weapon_scourge", "wh_dlc03_bst_khazrak_one_eye_scourge_stage_1_grandcampaign", 8,"wh_dlc03_bst_khazrak_one_eye_scourge_stage_4a_grandcampaign_mpc"},
        {"mission", "wh_dlc03_anc_armour_the_dark_mail", "wh_dlc03_bst_khazrak_one_eye_the_dark_mail_stage_1_grandcampaign", 13,"wh_dlc03_bst_khazrak_one_eye_the_dark_mail_stage_4_grandcampaign_mpc"}
    },
    ["wh_dlc03_bst_malagor"] = {
        {"mission", "wh_dlc03_anc_talisman_icon_of_vilification", "wh_dlc03_bst_malagor_the_dark_omen_the_icons_of_vilification_stage_1_grandcampaign", 8,"wh_dlc03_bst_malagor_the_dark_omen_the_icons_of_vilification_stage_6a_grandcampaign_mpc"}
    },
    ["wh_dlc05_bst_morghur"] = {
        {"mission", "wh_main_anc_weapon_stave_of_ruinous_corruption", "wh_dlc05_qb_bst_morghur_stave_of_ruinous_corruption_stage_1", 8,"wh_dlc05_qb_bst_morghur_stave_of_ruinous_corruption_stage_4a_mpc"}
    },
    ["wh_dlc06_dwf_belegar"] = {
        {"mission", "wh_dlc06_anc_armour_shield_of_defiance", "wh_dlc06_dwf_belegar_ironhammer_shield_of_defiance_stage_1", 8,"wh_dlc06_dwf_belegar_ironhammer_shield_of_defiance_stage_2a_mpc"},
        {"mission", "wh_dlc06_anc_weapon_the_hammer_of_angrund", "wh_dlc06_dwf_belegar_ironhammer_hammer_of_angrund_stage_1", 13,"wh_dlc06_dwf_belegar_ironhammer_hammer_of_angrund_stage_3a_mpc"}
    },
    ["wh_dlc06_grn_skarsnik"] = {
        {"mission", "wh_dlc06_anc_weapon_skarsniks_prodder", "wh_dlc06_grn_skarsnik_skarsniks_prodder_stage_1", 8,"wh_dlc06_grn_skarsnik_skarsniks_prodder_stage_4a_mpc"}
    },
    ["wh_dlc06_grn_wurrzag_da_great_prophet"] = {
        {"mission", "wh_dlc06_anc_enchanted_item_baleful_mask", "wh_dlc06_grn_wurrzag_da_great_green_prophet_baleful_mask_stage_1", 8,"wh_dlc06_grn_wurrzag_da_great_green_prophet_baleful_mask_stage_4a_mpc"},
        {"mission", "wh_dlc06_anc_arcane_item_squiggly_beast", "wh_dlc06_grn_wurrzag_da_great_green_prophet_squiggly_beast_stage_1", 13,"wh_dlc06_grn_wurrzag_da_great_green_prophet_bonewood_staff_stage_3_mpc"},
        {"mission", "wh_dlc06_anc_weapon_bonewood_staff", "wh_dlc06_grn_wurrzag_da_great_green_prophet_bonewood_staff_stage_1", 18,"wh_dlc06_grn_wurrzag_da_great_green_prophet_squiggly_beast_stage_3a_mpc"}
    },
    ["wh_dlc05_wef_orion"] = {
        {"mission", "wh_dlc05_anc_enchanted_item_horn_of_the_wild_hunt", "wh_dlc05_wef_orion_horn_of_the_wild_stage_1", 8,"wh_dlc05_wef_orion_horn_of_the_wild_stage_3a_mpc"},
        {"mission", "wh_dlc05_anc_talisman_cloak_of_isha", "wh_dlc05_wef_orion_cloak_of_isha_stage_1", 13,"wh_dlc05_wef_orion_cloak_of_isha_stage_3a_mpc"},
        {"mission", "wh_dlc05_anc_weapon_spear_of_kurnous", "wh_dlc05_wef_orion_spear_of_kurnous_stage_1", 18,"wh_dlc05_wef_orion_spear_of_kurnous_stage_3a_mpc"}
    },
    ["wh_dlc05_wef_durthu"] = {
        {"mission", "wh_dlc05_anc_weapon_daiths_sword", "wh_dlc05_wef_durthu_sword_of_daith_stage_1", 8,"wh_dlc05_wef_durthu_sword_of_daith_stage_4a_mpc"}
    },
    ["wh2_dlc16_wef_sisters_of_twilight"] = {
		{"mission", "wh2_dlc16_anc_mount_wef_cha_sisters_of_twilight_forest_dragon", "wh2_dlc16_wef_sisters_dragon_stage_1", 12,"wh2_dlc16_wef_sisters_dragon_stage_4_mpc"}
	},
	["wh2_dlc16_wef_drycha"] = {
		{"mission", "wh2_dlc16_anc_enchanted_item_fang_of_taalroth", "wh2_dlc16_wef_drycha_coeddil_unchained_stage_1", 5,"wh2_dlc16_wef_drycha_coeddil_unchained_stage_4_mpc"}
	},
    ["wh_dlc07_brt_fay_enchantress"] = {
		{"mission", "wh_dlc07_anc_arcane_item_the_chalice_of_potions", "wh_dlc07_qb_brt_fay_enchantress_chalice_of_potions_stage_1", 9, "wh_dlc07_qb_brt_fay_enchantress_chalice_of_potions_stage_6_mpc"},
        {"mission", "wh2_dlc12_anc_arcane_item_brt_morgianas_mirror", "wh2_dlc12_brt_fay_morgianas_mirror", 6}
    },
    ["wh_dlc07_brt_alberic"] = {
		{"incident", "wh_dlc07_anc_weapon_trident_of_manann", "wh_dlc07_qb_brt_alberic_trident_of_bordeleaux_stage_1", 3, "wh_dlc07_qb_brt_alberic_trident_of_bordeleaux_stage_8_estalian_tomb_mpc"},
        {"mission", "wh2_dlc12_anc_enchanted_item_brt_braid_of_bordeleaux", "wh2_dlc12_brt_alberic_braid_of_bordeleaux", 6}
    },
    ["wh_main_brt_louen_leoncouer"] = {
		{"incident", "wh_main_anc_weapon_the_sword_of_couronne", "wh_dlc07_qb_brt_louen_sword_of_couronne_stage_0", 9, "wh_dlc07_qb_brt_louen_sword_of_couronne_stage_4_la_maisontaal_abbey_mpc"},
        {"mission", "wh2_dlc12_anc_armour_brt_armour_of_brilliance", "wh2_dlc12_brt_louen_armour_of_brilliance", 6}
    },
    ["wh2_dlc14_brt_repanse"] = {
		{"mission", "wh2_dlc14_anc_weapon_sword_of_lyonesse", "wh2_dlc14_main_brt_repanse_sword_of_lyonesse_stage_1", 5, "wh2_dlc14_main_brt_repanse_sword_of_lyonesse_stage_4_mpc"}
    },    
    ["wh_pro02_vmp_isabella_von_carstein"] = {
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
    ["wh2_twa03_def_rakarth"] = {
		{"mission", "wh2_twa03_anc_weapon_whip_of_agony", "wh2_twa03_def_rakarth_whip_of_agony_stage_1", 2, "wh2_twa03_def_rakarth_whip_of_agony_stage_2_mpc"}
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
    ["wh2_dlc16_skv_throt_the_unclean"] = {
		{"mission", "wh2_dlc16_anc_enchanted_item_whip_of_domination", "wh2_dlc16_skv_throt_main_whip_of_domination_stage_1", 5, "wh2_dlc16_skv_throt_main_whip_of_domination_stage_4_mpc"},
		{"mission", "wh2_dlc16_anc_weapon_creature_killer", "wh2_dlc16_skv_throt_main_creature_killer_stage_1", 3}
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
    ["wh2_dlc17_lzd_oxyotl"] = {
        {"mission", "wh2_dlc17_anc_weapon_the_golden_blowpipe_of_ptoohee", "wh2_dlc17_lzd_oxyotl_the_golden_blowpipe_of_ptoohee_stage_1", 5, "wh2_dlc17_lzd_oxyotl_the_golden_blowpipe_of_ptoohee_stage_4b_mpc"}
    },
    ["wh2_dlc17_bst_taurox"] = {
        {"mission", "wh2_dlc17_anc_weapon_rune_tortured_axes", "wh2_dlc17_bst_taurox_rune_tortured_axes_stage_1", 5,"wh2_dlc17_bst_taurox_rune_tortured_axes_stage_3_mpc"}
    },
    ["wh2_dlc17_dwf_thorek"] = {
        {"mission", "wh2_dlc17_anc_weapon_klad_brakak", "wh2_dlc17_dwf_thorek_klad_brakak_stage_1", 5,"wh2_dlc17_dwf_thorek_klad_brakak_stage_4_mp"},
        {"mission", "wh2_dlc17_anc_armour_thoreks_rune_armour", "wh2_dlc17_dwf_thorek_rune_armour_quest", 3, "wh2_dlc17_dwf_thorek_rune_armour_quest"}
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
    --["mixu_katarin_the_ice_queen"] = {
    --    {"", "mixu_anc_enchanted_item_ksl_katarin_the_ice_queen_crystal_cloak", "", 9},
    --    {"", "mixu_anc_weapon_ksl_katarin_the_ice_queen_fearfrost", "", 15}
    --},
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
    ["wh_dlc03_emp_boris_todbringer"] = {
        {"", "mixu_anc_enchanted_item_emp_boris_todbringer_talisman_of_ulric", "", 15}
    },
    ["emp_vorn_thugenheim"] = {
        {"", "mixu_anc_talisman_emp_vorn_thugenheim_heart_of_middenheim", "", 15},
        {"", "mixu_anc_enchanted_item_emp_vorn_thugenheim_pelt_of_horrors", "", 10}
    },
    --["bst_taurox"] = {
    --    {"", "mixu_anc_weapon_bst_taurox_the_brass_bull_rune_tortured_axes", "", 13}
    --},
    ["emp_wolfram_hertwig"] = {
        {"", "mixu_anc_talisman_emp_wolfram_hertwig_kislevite_icon", "", 14}
    }
} 

local me_missing_anc = {
    ["wh2_dlc10_hef_alarielle"] = {
        {"", "wh2_dlc10_anc_magic_standard_banner_of_avelorn", "", 1},
        {"", "wh2_dlc10_anc_arcane_item_stave_of_avelorn", "", 1}
    },
    ["wh2_dlc12_skv_ikit_claw"] = {
        {"", "wh2_dlc12_anc_armour_iron_frame", "", 1}
    },
    ["wh_dlc06_grn_skarsnik"] = {
        {"", "wh_dlc06_anc_magic_standard_skarsniks_boyz", "", 1}
    },
    ["wh2_dlc12_lzd_tehenhauin"] = {
        {"", "wh2_dlc12_anc_weapon_blade_of_the_serpents_tongue", "", 1}
    },
    ["wh_main_grn_grimgor_ironhide"] = {
        {"", "wh_main_anc_magic_standard_da_immortulz", "", 1}
    },
    ["wh2_main_hef_prince_alastar"] = {
        {"", "wh2_main_anc_armour_lions_pelt", "", 1}
    },
    ["wh_dlc03_emp_boris_todbringer"] = {
        {"", "wh_main_anc_talisman_the_white_cloak_of_ulric", "", 1}
    },
    ["wh2_dlc10_hef_alith_anar"] = {
        {"", "wh2_dlc10_anc_talisman_stone_of_midnight", "", 1}
    },
    ["wh_main_vmp_heinrich_kemmler"] = {
        {"", "wh2_dlc11_anc_follower_vmp_the_ravenous_dead", "", 1}
    },
    ["wh2_dlc12_lzd_tiktaqto"] = {
        {"", "wh2_dlc12_anc_weapon_the_blade_of_ancient_skies", "", 1}
    },
    ["wh2_dlc11_cst_harkon"] = {
        {"", "wh2_dlc11_anc_follower_captain_drekla", "", 1}
    },
    ["wh2_dlc15_hef_imrik"] = {
        {"", "wh2_dlc15_anc_weapon_star_lance", "", 1}
    },
    ["wh2_twa03_def_rakarth"] = {
        {"", "wh2_twa03_anc_armour_beast_armour_of_karond_kar", "", 1}
    },
    ["wh2_dlc17_dwf_thorek_ironbrow"] = {
        {"", "wh_main_anc_rune_master_rune_of_stoicism", "", 1},
        {"", "wh2_dlc17_anc_follower_dwf_kraggi", "", 1},
        {"", "wh2_dlc17_anc_rune_engineering_rune_of_burning", "", 1}
    },
    ["wh2_dlc17_lzd_oxyotl"] = {
        {"", "wh2_dlc17_anc_banner_lzd_poison_fireblood_toxin", "", 1},
        {"", "wh2_dlc17_anc_banner_lzd_poison_toadskin_essence", "", 1}
    }
} 

local subtype_immortality = {
    --["wh_dlc03_emp_boris_todbringer"] = true,
    --["wh_dlc05_vmp_red_duke"] = true,
    --["wh2_main_hef_prince_alastar"] = true -- no longer needed (the empire undivided update made him immortal)    
    ["wh2_dlc09_tmb_arkhan"] = true,
    ["wh2_dlc09_tmb_khalida"] = true,
    ["wh2_dlc09_tmb_khatep"] = true,
    ["wh2_dlc09_tmb_settra"] = true,
    ["wh2_dlc11_cst_aranessa"] = true,
    ["wh2_dlc11_cst_cylostra"] = true,
    ["wh2_dlc11_cst_harkon"] = true,
    ["wh2_dlc11_cst_noctilus"] = true
} 

local names_of_power_traits = {
    "wh2_main_trait_def_name_of_power_co_01_blackstone",
    "wh2_main_trait_def_name_of_power_co_02_wyrmscale",
    "wh2_main_trait_def_name_of_power_co_03_poisonblade",
    "wh2_main_trait_def_name_of_power_co_04_headreaper",
    "wh2_main_trait_def_name_of_power_co_05_spiteheart",
    "wh2_main_trait_def_name_of_power_co_06_soulblaze",
    "wh2_main_trait_def_name_of_power_co_07_bloodscourge",
    "wh2_main_trait_def_name_of_power_co_08_griefbringer",
    "wh2_main_trait_def_name_of_power_co_09_the_hand_of_wrath",
    "wh2_main_trait_def_name_of_power_co_10_fatedshield",
    "wh2_main_trait_def_name_of_power_co_11_drakecleaver",
    "wh2_main_trait_def_name_of_power_co_12_hydrablood",
    "wh2_main_trait_def_name_of_power_ar_01_lifequencher",
    "wh2_main_trait_def_name_of_power_ar_02_the_tempest_of_talons",
    "wh2_main_trait_def_name_of_power_ar_03_shadowdart",
    "wh2_main_trait_def_name_of_power_ar_04_barbstorm",
    "wh2_main_trait_def_name_of_power_ar_05_beastbinder",
    "wh2_main_trait_def_name_of_power_ar_06_fangshield",
    "wh2_main_trait_def_name_of_power_ar_07_wrathbringer",
    "wh2_main_trait_def_name_of_power_ar_08_moonshadow",
    "wh2_main_trait_def_name_of_power_ar_09_granitestance",
    "wh2_main_trait_def_name_of_power_ar_10_the_grey_vanquisher",
    "wh2_main_trait_def_name_of_power_ar_11_krakenclaw",
    "wh2_main_trait_def_name_of_power_ar_12_grimgaze",
    "wh2_main_trait_def_name_of_power_ca_01_dreadtongue",
    "wh2_main_trait_def_name_of_power_ca_02_darkpath",
    "wh2_main_trait_def_name_of_power_ca_03_khainemarked",
    "wh2_main_trait_def_name_of_power_ca_04_the_black_conqueror",
    "wh2_main_trait_def_name_of_power_ca_05_leviathanrage",
    "wh2_main_trait_def_name_of_power_ca_06_emeraldeye",
    "wh2_main_trait_def_name_of_power_ca_07_barbedlash",
    "wh2_main_trait_def_name_of_power_ca_08_pathguard",
    "wh2_main_trait_def_name_of_power_ca_09_the_dark_marshall",
    "wh2_main_trait_def_name_of_power_ca_10_the_dire_overseer",
    "wh2_main_trait_def_name_of_power_ca_11_gatesmiter",
    "wh2_main_trait_def_name_of_power_ca_12_the_tormentor"
} 

--- wh2 function
--- @function table_contains
--- @desc Returns true if the supplied indexed table contains the supplied object.
--- @p table subject table
--- @p object object
--- @return boolean table contains object
local function table_contains(t, obj)
	for i = 1, #t do
		if t[i] == obj then
			return true
		end
	end
	return false
end

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

local function equip_quest_anc(faction)
    local missing_anc = {} 
    local subtype_anc = {} 
    if cm:get_campaign_name() == "main_warhammer" then 
        missing_anc = me_missing_anc 
        subtype_anc = me_subtype_anc
    elseif cm:get_campaign_name() == "wh2_main_great_vortex" then 
        missing_anc = vor_missing_anc 
        subtype_anc = vor_subtype_anc
    elseif cm:get_campaign_name() == "wh3_main_chaos" then 
        subtype_anc = chs_subtype_anc
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

local function are_lords_missing(faction)
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
                local factions_of_same_subculture = faction:factions_of_same_subculture()
                for j = 0, factions_of_same_subculture:num_items() - 1 do
                    local current_faction = factions_of_same_subculture:item_at(j)
                    local char_list = current_faction:character_list()
                    for k = 0, char_list:num_items() - 1 do
                        local current_char = char_list:item_at(k)

                        if current_char:character_subtype_key() == locked_ai_generals[i].subtype then
                            cm:set_saved_value(locked_ai_generals[i].subtype.."_spawned", current_faction:name()) 
                            char_found = true
                        end
                    end
                end
            end
            return not char_found and (not is_string(locked_ai_generals[i].dlc) or (is_string(locked_ai_generals[i].dlc) and cm:is_dlc_flag_enabled(locked_ai_generals[i].dlc))) 
        end
    end
end

-- pre empire undivided spawn location check
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
-- NEEDS WORK!!!
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
            1000, --x -- NEEDS WORK!!!
            700, --y -- NEEDS WORK!!!
            true,
            function(cqi)
                --sm0_log("spawn_missing_lords | Faction revived: "..confederated:name().." | Region: "..start_region:name().." | CQI: "..cqi)
                char_cqi = cqi
                --local char = cm:get_character_by_cqi(char_cqi)
                --if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and not cm:get_saved_value("sm0_immortal_cqi"..char_cqi) then
                --    cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
				--		cm:set_character_immortality(cm:char_lookup_str(char_cqi), true) 
				--	end, 0.5)                   
                --    cm:set_saved_value("sm0_immortal_cqi"..char_cqi, true)
                --end 

                --spawn lords
                if are_lords_missing(confederated) then 
                    for i = 1, #locked_ai_generals do
                        if confederated:name() == locked_ai_generals[i].faction and not cm:get_saved_value(locked_ai_generals[i].subtype.."_spawned") then                        
                            if locked_ai_generals[i].id ~= "" and not cm:get_saved_value("ci_starting_generals_unlocked_ai") then cm:unlock_starting_general_recruitment(locked_ai_generals[i].id, locked_ai_generals[i].faction) end
                            --sm0_log("spawn_missing_lords | are_lords_missing | char_found = "..tostring(char_found))
                            for n = 1, 10 do
                                if not cm:get_saved_value(locked_ai_generals[i].subtype.."_spawned") then
                                    --sm0_log("spawn_missing_lords | are_lords_missing | cm:get_saved_value(locked_ai_generals[i].subtype..\"_spawned\") = "..tostring(cm:get_saved_value(locked_ai_generals[i].subtype.."_spawned")))
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
                                                --sm0_log("["..n..".] spawn_lord | subtype: "..char:character_subtype_key().." | Forename: "..char:get_forename().." | Surname: "..char:get_surname().." | CQI: "..cqi)
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
            end,
            true
        )
    else
        sm0_log("ERROR: Could not find valid spawn position!")
    end
end

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
        "wh2_main_bundle_confederation_tmb",
        "wh3_main_bundle_confederation_cth",
        "wh3_main_bundle_confederation_dae",
        "wh3_main_bundle_confederation_kho",
        "wh3_main_bundle_confederation_nur",
        "wh3_main_bundle_confederation_ogr",
        "wh3_main_bundle_confederation_sla",
        "wh3_main_bundle_confederation_tze"
    } 
    local has_confed_bundle = ""
    for i = 1, #bundles do
        if faction and faction:has_effect_bundle(bundles[i]) then 
            has_confed_bundle = bundles[i] 
            break
        end
    end
    return has_confed_bundle
end

local function lord_event(confederator, confederated, character, agents)
    for _, agent in ipairs(agents) do
        local subtype = agent.subtype
        local confederator_faction = cm:get_faction(confederator)

        if subtype == character:character_subtype_key() and ((not is_string(agent.dlc) and not is_table(agent.dlc)) or (is_string(agent.dlc) and cm:is_dlc_flag_enabled(agent.dlc))
        or (is_table(agent.dlc) and cm:is_dlc_flag_enabled(agent.dlc[1]) and cm:is_dlc_flag_enabled(agent.dlc[2]))) then
            CampaignUI.TriggerCampaignScriptEvent(confederator_faction:command_queue_index(), "RD|"..tostring(character:command_queue_index())..":"..subtype..";"..tostring(confederated))
        end
    end    
end
-- NEEDS WORK!!!
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
        --ovn
        --"wh_main_sc_emp_araby"
        --"wh_main_sc_nor_fimir"
    } 
    local faction = cm:get_faction(faction_name)
    if faction then
        local subculture = faction:subculture()
        local culture = faction:culture()
        local confed_option_value --= cm:get_saved_value("mcm_tweaker_confed_tweaks_" .. culture .."_value")
        local confederation_options_mod 
        local mct = core:get_static_object("mod_configuration_tool")
        if mct then 
            confederation_options_mod = mct:get_mod_by_key("confederation_options")
            if confederation_options_mod then 
                local confed_option = confederation_options_mod:get_option_by_key(culture)
                if confed_option then 
                    confed_option_value = confed_option:get_finalized_setting()
                else
                    confed_option = confederation_options_mod:get_option_by_key(subculture)
                    confed_option_value = confed_option:get_finalized_setting()
                end
            end
        end
        local option = {}
        option.source = "faction:" .. faction_name        
        option.target = "culture:" .. culture
        if confed_option_value == "free_confed" then
            option.offer = true
            option.accept = true
            option.both_directions = true
        elseif confed_option_value == "player_only" then
            if faction:is_human() then
                option.offer = true
                option.accept = true
                option.both_directions = false
            else
                option.offer = false
                option.accept = true
                option.both_directions = false	
            end
        elseif confed_option_value == "disabled" then
            option.offer = false
            option.accept = false
            option.both_directions = false				
        elseif confed_option_value == "no_tweak" or confed_option_value == nil then
            option.offer = true
            option.accept = true
            option.both_directions = false
            for i, subculture_confed in ipairs(subculture_confed_disabled) do
                if subculture == subculture_confed then
                    option.target = "subculture:" .. subculture
                    option.offer = false
                    option.accept = false
                    option.both_directions = false
                end
            end	
            if vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") and subculture == "wh_main_sc_teb_teb" then
                option.target = "subculture:" .. subculture 
                option.offer = true
                option.accept = true
                option.both_directions = false            
            end
            if faction:pooled_resource_manager():resource("emp_loyalty") == true then
                option.offer = false
                option.accept = false
                option.both_directions = false
            end
            if subculture == "wh_dlc05_sc_wef_wood_elves" then
                option.target = "subculture:" .. subculture
                option.accept = false
                option.both_directions = false        	
                --oak_region = cm:get_region("wh_main_yn_edri_eternos_the_oak_of_ages")
                --if oak_region:building_exists("wh_dlc05_wef_oak_of_ages_3") or oak_region:building_exists("wh_dlc05_wef_oak_of_ages_4") or oak_region:building_exists("wh_dlc05_wef_oak_of_ages_5") then
                --	option.offer = true
                --else
                    option.offer = false
                --end  
            end
        end
        cm:callback(
            function(context)
                if option.offer ~= nil and option.accept ~= nil and option.both_directions ~= nil then
                    cm:force_diplomacy(option.source, option.target, "form confederation", option.offer, option.accept, option.both_directions)
                end
                if confed_option_value == "no_tweak" or confed_option_value == nil then
                    if faction:name() == "wh_main_vmp_rival_sylvanian_vamps" then
                        cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps", "faction:wh_main_vmp_vampire_counts", "form confederation", false, false, true)
                        cm:force_diplomacy("faction:wh_main_vmp_rival_sylvanian_vamps", "faction:wh_main_vmp_schwartzhafen", "form confederation", false, false, true)
                    end
                    if subculture == "wh_main_sc_brt_bretonnia" and faction:is_human() and faction_name ~= "wh2_dlc14_brt_chevaliers_de_lyonesse" then
                        local bret_confederation_tech = {
                            {tech = "tech_dlc07_brt_heraldry_artois", faction = "wh_main_brt_artois"},
                            {tech = "tech_dlc07_brt_heraldry_bastonne", faction = "wh_main_brt_bastonne"},
                            {tech = "tech_dlc07_brt_heraldry_bordeleaux", faction = "wh_main_brt_bordeleaux"},
                            {tech = "tech_dlc07_brt_heraldry_bretonnia", faction = "wh_main_brt_bretonnia"},
                            {tech = "tech_dlc07_brt_heraldry_carcassonne", faction = "wh_main_brt_carcassonne"},
                            {tech = "tech_dlc07_brt_heraldry_lyonesse", faction = "wh_main_brt_lyonesse"},
                            {tech = "tech_dlc07_brt_heraldry_parravon", faction = "wh_main_brt_parravon"}
                        } 
                        for i = 1, #bret_confederation_tech do
                            local has_tech = faction:has_technology(bret_confederation_tech[i].tech)
                            cm:force_diplomacy("faction:"..faction:name(), "faction:"..bret_confederation_tech[i].faction, "form confederation", has_tech, has_tech, true)
                        end
                    end
                    if faction:is_human() and faction:pooled_resource_manager():resource("emp_loyalty") == true then
                        cm:force_diplomacy("faction:"..faction_name, "faction:wh2_dlc13_emp_the_huntmarshals_expedition", "form confederation", true, true, false)
                        cm:force_diplomacy("faction:"..faction_name, "faction:wh2_main_emp_sudenburg", "form confederation", true, true, false)
                    end
                    ---hack fix to stop this re-enabling confederation when it needs to stay disabled
                    ---please let's make this more robust!
                    if subculture == "wh2_main_sc_hef_high_elves" then
                        local grom_faction = cm:get_faction("wh2_dlc15_grn_broken_axe")
                        if grom_faction ~= false and grom_faction:is_human() then
                            cm:force_diplomacy("subculture:wh2_main_sc_hef_high_elves","faction:wh2_main_hef_yvresse","form confederation", false, true, false)
                        end
                    end
                    if vfs.exists("script/campaign/mod/!ovn_me_lost_factions_start.lua") then
                        cm:force_diplomacy("faction:wh2_main_emp_grudgebringers", "all", "form confederation", false, false, false)
                        cm:force_diplomacy("faction:wh2_main_emp_the_moot", "all", "form confederation", false, false, false)
                    end
                    if faction:name() == "wh2_dlc16_wef_drycha" then
                        cm:force_diplomacy("faction:wh2_dlc16_wef_drycha", "culture:wh_dlc05_wef_wood_elves", "form confederation", false, false)
                        cm:force_diplomacy("faction:wh2_dlc16_wef_drycha", "faction:wh_dlc05_wef_argwylon", "form confederation", true, true)
                    end
                        --- only player(s) - excluding Drycha - can confederate
                    if subculture == "wh_dlc05_sc_wef_wood_elves" and faction:name() ~= "wh2_dlc16_wef_drycha" and faction:is_human() then
                        cm:force_diplomacy("culture:wh_dlc05_wef_wood_elves", "culture:wh_dlc05_wef_wood_elves", "form confederation", false, false)
                        cm:force_diplomacy("faction:"..faction:name(),"culture:wh_dlc05_wef_wood_elves","form confederation",true,true)
                    end
                    -- Kislev confederation restriction for follower feature
                    if faction:is_human() and faction_name == "wh3_main_ksl_the_ice_court" or faction:is_human() and faction_name == "wh3_main_ksl_the_great_orthodoxy" then
                        cm:force_diplomacy("faction:wh3_main_ksl_the_ice_court", "faction:wh3_main_ksl_the_great_orthodoxy", "form confederation", false, false, true)
                    end
                end
            end, 1, "changeDiplomacyOptions"
        )
    end
end

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
                --for n = 0, char_list:num_items() - 1 do 
                --    local char = char_list:item_at(n)
                --    local command_queue_index = char:command_queue_index()
                --    if command_queue_index ~= cqi and not char:is_faction_leader() then 
                --        cm:kill_character(command_queue_index, true, false) 
                --    end
                --end
                for i = 0, char_list:num_items() - 1 do 
                    local char = char_list:item_at(i)
                    local command_queue_index = char:command_queue_index()
                    local char_lookup = cm:char_lookup_str(char)
                    if cm:char_is_agent(char) or cm:char_is_general(char) then 
                        cm:force_reset_skills(char_lookup) 
                        for j = 1, #names_of_power_traits do
                            if char:has_trait(names_of_power_traits[j]) then 
                                cm:force_remove_trait(char_lookup, names_of_power_traits[j])
                            end
                        end
                    end
                    --if not char:has_military_force() and (cm:char_is_general(char) or cm:char_is_agent(char)) then cm:kill_character(command_queue_index, true, false) end --kill colonels
                    if confederator:is_human() then 
                        lord_event(confederator:name(), confederated:name(), char, wh_agents)
                        --if vfs.exists("script/campaign/main_warhammer/mod/mixu_le_bruckner.lua") then lord_event(confederator:name(), confederated:name(), char, mixu1_agents) end
                        if vfs.exists("script/campaign/mod/mixu_darkhand.lua") then lord_event(confederator:name(), confederated:name(), char, mixu2_agents) end
                        --if vfs.exists("script/campaign/mod/eltharion_yvresse_add.lua") then lord_event(confederator:name(), confederated:name(), char, xoudad_agents) end
                        if vfs.exists("script/campaign/main_warhammer/mod/cataph_kraka_drak.lua") then lord_event(confederator:name(), confederated:name(), char, kraka_agents) end
                        if vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then lord_event(confederator:name(), confederated:name(), char, teb_agents) end
                        if vfs.exists("script/export_helpers_enforest.lua") then lord_event(confederator:name(), confederated:name(), char, parte_agents) end
                        if vfs.exists("script/campaign/main_warhammer/mod/spcha_live_launch.lua") then lord_event(confederator:name(), confederated:name(), char, speshul_agents) end
                        if vfs.exists("script/export_helpers_why_grudge.lua") then lord_event(confederator:name(), confederated:name(), char, wsf_agents) end
                        if vfs.exists("script/export_helpers_ordo_draconis_why.lua") then lord_event(confederator:name(), confederated:name(), char, ordo_agents) end
                        if vfs.exists("script/export_helpers_why_strigoi_camp.lua") then lord_event(confederator:name(), confederated:name(), char, strigoi_agents) end
                        if vfs.exists("script/campaign/mod/@zf_master_engineer_setup_vandy") then lord_event(confederator:name(), confederated:name(), char, zf_agents) end 
                        if vfs.exists("script/campaign/mod/cataph_aislinn") then lord_event(confederator:name(), confederated:name(), char, seahelm_agents) end
                        if vfs.exists("script/campaign/mod/mixu_shadewraith") then lord_event(confederator:name(), confederated:name(), char, mixu_vangheist) end
                        --if vfs.exists("script/campaign/mod/ovn_rogue.lua") then lord_event(confederator:name(), confederated:name(), char, second_start_agents) end
                        --if vfs.exists("script/campaign/mod/sr_chaos.lua") then lord_event(confederator:name(), confederated:name(), char, lost_factions_agents) end
                        --sm0_log("Faction: "..confederated:name().." | ".."Character | Forename: "..effect.get_localised_string(char:get_forename()).." | Surname: "..effect.get_localised_string(char:get_surname()))
                    end
                    --if (is_surtha_ek(char) or subtype_immortality[char:character_subtype_key()]) and not cm:get_saved_value("sm0_immortal_cqi"..char:command_queue_index()) then
                    --    --cm:callback(function() --wh2_pro08_gotrek_felix inspired wait for spawn
                    --        cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), true) 
                    --    --end, 0.5) 
                    --    cm:set_saved_value("sm0_immortal_cqi"..char:command_queue_index(), true)
                    --end 
                    if char:character_subtype("wh_main_brt_louen_leoncouer") then
                        cm:force_add_ancillary(char, "wh_main_anc_mount_brt_louen_barded_warhorse", true, true)
                    end
                    if is_surtha_ek(char) then
                        cm:force_add_ancillary(char, "wh_dlc10_anc_mount_nor_surtha_ek_marauder_chariot", true, true)
                    end
                    if command_queue_index ~= cqi and not char:is_faction_leader() then 
                        cm:kill_character(command_queue_index, true, false) 
                    end
                end
                -- NEEDS WORK!!!
                --if confederated:name() == "wh2_main_hef_eataine" and not cm:get_saved_value("v_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked") then
                --    local char_found = false
                --    local faction_list = cm:model():world():faction_list()
                --    for i = 0, faction_list:num_items() - 1 do
                --        local current_faction = faction_list:item_at(i)
                --        local char_list = current_faction:character_list()
                --        for j = 0, char_list:num_items() - 1 do
                --            local current_char = char_list:item_at(j)
                --            if current_char:character_subtype_key() == "wh2_main_hef_prince_alastar" then
                --                char_found = true
                --            end
                --        end      
                --    end
                --    if not char_found then  
                --        sm0_log("spawn_missing_lords: ".."wh2_main_hef_prince_alastar".." spawned!")         
                --        cm:spawn_character_to_pool(confederator:name(), "names_name_2147360555", "names_name_2147360560", "", "", 18, true, "general", "wh2_main_hef_prince_alastar", true, "")
                --        cm:set_saved_value("v_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked", true)
                --        ancillary_on_rankup(alastar_quests, "wh2_main_hef_prince_alastar")
                --        if confederator:is_human() then
                --            cm:show_message_event(
                --                confederator:name(),
                --                "event_feed_strings_text_title_event_legendary_lord_available",
                --                "event_feed_strings_text_title_event_wh2_main_hef_prince_alastar_LL_unlocked",
                --                "event_feed_strings_text_description_event_wh2_main_hef_prince_alastar_LL_unlocked",
                --                true,
                --                faction_event_picture[confederator:name()]
                --            )
                --        end
                --        if cm:model():campaign_name("main_warhammer") then
                --            cm:lock_starting_general_recruitment("1065845653", "wh2_main_hef_eataine")
                --        else
                --            cm:lock_starting_general_recruitment("2140785181", "wh2_main_hef_eataine")
                --        end
                --    end
                --end
                cm:set_saved_value("rd_confed", true)
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
                            cm:set_saved_value("rd_confed", false)
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

local function faked_death(faction)
    return not faction:is_dead() and not faction:military_force_list():item_at(0) and not faction:region_list():item_at(0)
end

local function rd_dilemma(confederator, confederated)
    local subculture = confederator:subculture()
    local sc_string_start = string.find(subculture, "sc_")
    core:add_listener(
        "rd_trigger_dilemma"..confederated:name(),
        "DilemmaChoiceMadeEvent",
        function(context)
            return context:dilemma():starts_with("sm0_rd_")
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
        sm0_log("trigger_dilemma_with_targets:".."sm0_rd_"..sc_string.." | confederator:cqi = "..confederator:command_queue_index().." | confederated:cqi = "..confederated:command_queue_index())
        --cm:trigger_dilemma_with_targets(confederator:command_queue_index(), "sm0_rd_"..sc_string, confederated:command_queue_index(), 0, 0, 0, 0, 0, nil, false)
        confed_revived(confederator, confederated)
    elseif string.find(subculture, "_rogue_") then
        --sm0_log("trigger_dilemma_with_targets:".."sm0_rd_rogue")
        --cm:trigger_dilemma_with_targets(confederator:command_queue_index(), "sm0_rd_rogue", confederated:command_queue_index(), 0, 0, 0, 0, 0, nil, false)
        confed_revived(confederator, confederated)
    else  
        sm0_log("ERROR: Subculture string resolving failed! ["..subculture.."]")
        confed_revived(confederator, confederated)   
        core:remove_listener("rd_trigger_dilemma"..confederated:name())                                 
    end
end
-- NEEDS WORK!!!
local function is_faction_exempted(faction)
    local is_exempted = false
    if faction:subculture() == "wh_main_sc_chs_chaos" or faction:subculture() == "wh_dlc03_sc_bst_beastmen"
    or faction:name() == "wh2_dlc13_lzd_defenders_of_the_great_plan" or faction:name() == "wh2_dlc13_lzd_avengers" 
    or faction:name():find("_waaagh") or faction:name():find("_brayherd") or faction:name():find("_unknown") or faction:name():find("_incursion")
    or faction:name():find("_qb") or faction:name():find("_separatists") or faction:name():find("_dil") or faction:name():find("_blood_voyage") 
    or faction:name():find("_encounters") or faction:name():find("rebel") or faction:name():find("_intervention") or faction:name():find("_invasion") 
    or faction:name():find("_rogue_") or faction:name():find("_shanty_")
    -- ovn
    or faction:subculture() == "wh_main_sc_nor_warp" or faction:subculture() == "wh_main_sc_nor_troll" or faction:subculture() == "wh_main_sc_nor_albion"
    or faction:subculture() == "wh_main_sc_lzd_amazon" or faction:subculture() == "wh_main_sc_nor_fimir"
    or (faction:name() == "wh2_dlc11_vmp_the_barrow_legion" and vfs.exists("script/campaign/main_warhammer/mod/liche_init.lua")) --hobo
    or faction:is_quest_battle_faction() then
        is_exempted = true
    else
        is_exempted = false
    end
    return is_exempted
end
-- NEEDS WORK!!! (MP)
local function is_human_and_rejected_faction(faction, refugee)
    local human_factions = cm:get_human_factions()
    local faction_P1 = cm:get_faction(human_factions[1])
    local faction_P2
    if cm:is_multiplayer() then
        faction_P2 = cm:get_faction(human_factions[2])
    end
    return cm:get_saved_value("rd_choice_1_"..refugee:name()) == faction_P1:name() and faction_P1:name() == faction:name()
    or (cm:is_multiplayer() and cm:get_saved_value("rd_choice_1_"..refugee:name()) == faction_P2:name() and faction_P2:name() == faction:name())
end

local function get_prefered_faction_list(faction_list, preferance_type, faction)
    --sm0_log("get_prefered_faction_list | preferance_type: "..tostring(preferance_type).." | faction: "..tostring(faction:name()))
    local prefered_factions = {}
    local factions_of_same_subculture = {}
    local human_factions = cm:get_human_factions()

    if not is_table(faction_list) and not is_factionlist(faction_list) then --and next(faction_list) == nil
        faction_list = faction:factions_of_same_subculture()
    end
    if is_factionlist(faction_list) then
        local argwylon = cm:get_faction("wh_dlc05_wef_argwylon")
        for i = 0, faction_list:num_items() - 1 do
            local faction_current = faction_list:item_at(i)
            if faction_current:subculture() == faction:subculture() and not faction_current:is_dead() and not is_faction_exempted(faction_current) 
            and not is_human_and_rejected_faction(faction_current, faction) and ((faction_current:is_human() and (scope_value == "player" or scope_value == "player_ai")) 
            or (not faction_current:is_human() and (scope_value == "ai" or scope_value == "player_ai"))) 
            --tmb
            and (faction:subculture() ~= "wh2_dlc09_sc_tmb_tomb_kings" or (not tmb_restriction_value and faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings") 
            or (tmb_restriction_value and faction_current:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" 
            and faction:name() ~= "wh2_dlc09_tmb_the_sentinels" and faction:name() ~= "wh2_dlc09_tmb_followers_of_nagash"
            and faction_current:name() ~= "wh2_dlc09_tmb_the_sentinels" and faction_current:name() ~= "wh2_dlc09_tmb_followers_of_nagash")
            or (tmb_restriction_value and faction_current:name() == "wh2_dlc09_tmb_the_sentinels" and faction:name() == "wh2_dlc09_tmb_followers_of_nagash") 
            or (tmb_restriction_value and faction_current:name() == "wh2_dlc09_tmb_followers_of_nagash" and faction:name() == "wh2_dlc09_tmb_the_sentinels"))
            --wef
            and (faction:subculture() ~= "wh_dlc05_sc_wef_wood_elves" or (not wef_restriction_value and faction:subculture() == "wh_dlc05_sc_wef_wood_elves") 
            or (wef_restriction_value and faction:subculture() == "wh_dlc05_sc_wef_wood_elves" and (faction_current:name() == "wh_dlc05_wef_argwylon"
            or (faction_current:name() == "wh2_dlc16_wef_drycha" and faction:name() == "wh_dlc05_wef_argwylon") 
            or (faction_current:name() == "wh2_dlc16_wef_drycha" and (not argwylon or argwylon:is_dead()))
            or (faction_current:name() ~= "wh2_dlc16_wef_drycha" and faction:name() ~= "wh2_dlc16_wef_drycha")))) then 
                table.insert(factions_of_same_subculture, faction_current:name())
            end
            cm:shuffle_table(factions_of_same_subculture)
        end
    elseif is_table(faction_list) then
        factions_of_same_subculture = faction_list
    end
    
    if preferance_type == "met" then
        -- preferance: met
        if is_table(factions_of_same_subculture) then
            for i = 1, #factions_of_same_subculture do
                local faction_current = cm:get_faction(factions_of_same_subculture[i])
                local factions_met_list = faction_current:factions_met()
                for j = 0, factions_met_list:num_items() - 1 do
                    local faction_met = factions_met_list:item_at(j)
                    if faction_met:name() == faction:name() then
                        table.insert(prefered_factions, faction_current:name())
                    end
                end
            end
            for i = 1, #factions_of_same_subculture do
                local faction_current = cm:get_faction(factions_of_same_subculture[i])
                if not table_contains(prefered_factions, faction_current:name()) then
                    table.insert(prefered_factions, faction_current:name())
                end
            end
        else
            sm0_log("preferance: met | something went wrong")
        end
    elseif preferance_type == "relation" then
        -- preferance: relation
        local faction_standings = {}
        if is_table(factions_of_same_subculture) then
            for i = 1, #factions_of_same_subculture do
                local subculture_faction = cm:get_faction(factions_of_same_subculture[i])
                local standing = faction:diplomatic_standing_with(subculture_faction:name())
                --sm0_log("relation | factions_of_same_subculture: "..tostring(factions_of_same_subculture[i]).." | faction: "..tostring(faction:name()).." | standing: "..tostring(standing))
                table.insert(faction_standings, {standing = standing - 0.001 * i, name = subculture_faction:name()})
            end
            -- messes up the previous table order if more than one key has an equal relation number
            table.sort(faction_standings, function(a,b) return tonumber(a.standing) > tonumber(b.standing) end)

            for _, faction in ipairs(faction_standings) do
                table.insert(prefered_factions, faction.name)
                --sm0_log("relation | faction: "..tostring(faction.name).." | saved_standing: "..tostring(faction.standing))
            end
        else
            sm0_log("preferance: relation | something went wrong")
        end
    elseif preferance_type == "major" then
        -- preferance: major
        if is_table(factions_of_same_subculture) then
            for i = 1, #factions_of_same_subculture do
                if table_contains(playable_factions, factions_of_same_subculture[i]) then
                    table.insert(prefered_factions, factions_of_same_subculture[i])
                end
            end
            for i = 1, #factions_of_same_subculture do
                if not table_contains(prefered_factions, factions_of_same_subculture[i]) then
                    table.insert(prefered_factions, factions_of_same_subculture[i])
                end
            end
        else
            sm0_log("preferance: major | something went wrong")
        end
    elseif preferance_type == "minor" then
        -- preferance: minor
        if is_table(factions_of_same_subculture) then
            for i = 1, #factions_of_same_subculture do
                if not table_contains(playable_factions, factions_of_same_subculture[i]) then
                    table.insert(prefered_factions, factions_of_same_subculture[i])
                end
            end
            for i = 1, #factions_of_same_subculture do
                if not table_contains(prefered_factions, factions_of_same_subculture[i]) then
                    table.insert(prefered_factions, factions_of_same_subculture[i])
                end
            end
        else
            sm0_log("preferance: minor | something went wrong")
        end
    elseif preferance_type == "player" then --and (scope_value == "player" or scope_value == "player_ai") then
        -- preferance: player
        if is_table(factions_of_same_subculture) then
            for i = 1, #factions_of_same_subculture do
                --sm0_log("player | factions_of_same_subculture: "..tostring(factions_of_same_subculture[i]))
                local subculture_faction = cm:get_faction(factions_of_same_subculture[i])
                if subculture_faction:is_human() then
                    table.insert(prefered_factions, subculture_faction:name())
                end
            end
            for i = 1, #factions_of_same_subculture do
                local faction_current = cm:get_faction(factions_of_same_subculture[i])
                if not table_contains(prefered_factions, faction_current:name()) then
                    table.insert(prefered_factions, faction_current:name())
                end
            end
        else
            sm0_log("preferance: player | something went wrong")
        end
    elseif preferance_type == "ai" then --and (scope_value == "ai" or scope_value == "player_ai") then
        -- preferance: ai
        if is_table(factions_of_same_subculture) then
            for i = 1, #factions_of_same_subculture do
                local subculture_faction = cm:get_faction(factions_of_same_subculture[i])
                if not subculture_faction:is_human() then
                    table.insert(prefered_factions, subculture_faction:name())
                end
            end
            for i = 1, #factions_of_same_subculture do
                if not table_contains(prefered_factions, factions_of_same_subculture[i]) then
                    table.insert(prefered_factions, factions_of_same_subculture[i])
                end
            end
        else
            sm0_log("preferance: ai | something went wrong")
        end
    elseif preferance_type == "alternate" then
        -- preferance: player alternate (only applies to mp same subculture)
        if is_table(factions_of_same_subculture) then
            -- NEEDS WORK!!! (MP)
            if cm:is_multiplayer() and (cm:get_saved_value("faction_P2") or cm:get_saved_value("faction_P1")) then
                local player1_current_pos
                local player2_current_pos
                for i = 1, #factions_of_same_subculture do
                    local subculture_faction = cm:get_faction(factions_of_same_subculture[i])
                    if subculture_faction:name() == human_factions[1] then
                        player1_current_pos = i
                    elseif subculture_faction:name() == human_factions[2] then
                        player2_current_pos = i
                    end
                end
                prefered_factions = factions_of_same_subculture
                if is_number(player1_current_pos) and is_number(player2_current_pos) then
                    if ((player1_current_pos < player2_current_pos) and cm:get_saved_value("faction_P1")) 
                    or ((player2_current_pos < player1_current_pos) and cm:get_saved_value("faction_P2")) then
                        prefered_factions[player1_current_pos], prefered_factions[player2_current_pos] = prefered_factions[player2_current_pos], prefered_factions[player1_current_pos]
                    end
                end
            else
                prefered_factions = factions_of_same_subculture
            end
        else
            sm0_log("preferance: alternate | something went wrong")
        end
    else
        -- preferance: nil
        if is_table(factions_of_same_subculture) then
            prefered_factions = factions_of_same_subculture
        else
            sm0_log("preferance: nil | something went wrong")
        end
    end
    
    --for i, faction in ipairs(prefered_factions) do
    --    sm0_log("return | "..tostring(preferance_type).." | prefered_factions["..i.."]: "..tostring(faction))
    --end
    return prefered_factions
end

local function init_recruit_defeated_listeners(enable_value)
    local human_factions = cm:get_human_factions()
    -- NEEDS WORK!!! (MP)
    local faction_P1 = cm:get_faction(human_factions[1])
    local faction_P2
    if cm:is_multiplayer() then
        faction_P2 = cm:get_faction(human_factions[2])
    end
    core:remove_listener("recruit_defeated_FactionTurnEnd")
    core:remove_listener("recruit_defeated_FactionTurnStart")
    core:remove_listener("delayed_spawn_listener")
    core:remove_listener("backup_delayed_spawn_listener")
    core:remove_listener("recruit_defeated_DilemmaIssuedEvent")
    core:remove_listener("recruit_defeated_FactionTurnStart")
    core:remove_listener("recruit_defeated_DilemmaChoiceMadeEvent")
    core:remove_listener("recruit_defeated_FactionJoinsConfederation")
    core:remove_listener("recruit_defeated_ScriptEventConfederationExpired")
    core:remove_listener("recruit_defeated_UITrigger")
    core:remove_listener("recruit_defeated_confederation_listener")

	if enable_value then
        core:add_listener(
            "recruit_defeated_FactionTurnEnd",
            "FactionTurnEnd",
            true,
            function(context)
                if not (cm:model():turn_number() == 1 and context:faction():is_human()) then 
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

        core:add_listener(
            "recruit_defeated_FactionTurnStart",
            "FactionTurnStart",
            true,
            function(context)
                if not (cm:model():turn_number() == 1 and context:faction():is_human()) then 
                    if cm:get_saved_value("sought_refuge_"..context:faction():name()) then
                        cm:set_saved_value("sought_refuge_"..context:faction():name(), false)
                        sm0_log("Faction respawned: "..context:faction():name())
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
                            if not is_faction_exempted(current_faction) then
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
                            if not is_faction_exempted(current_faction) then
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
            "recruit_defeated_DilemmaIssuedEvent",
            "DilemmaIssuedEvent",
            function(context) 
                return context:dilemma():starts_with("sm0_rd_")
            end,
            function()
                cm:remove_callback("recruit_defeated_FactionTurnStart_callback")
            end,
            true
        )

        core:add_listener(
            "recruit_defeated_FactionTurnStart",
            "FactionTurnStart",
            function(context)
                return cm:model():turn_number() >= 2 and context:faction():is_human() --and (not cm:is_multiplayer() or (cm:is_multiplayer() and (cm:model():turn_number() % 5) == 0))
            end,
            function(context)
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
                    -- mcm/mct restrictions
                    if ((current_faction:subculture() ~= "wh2_dlc09_sc_tmb_tomb_kings" --and current_faction:subculture() ~= "wh_main_sc_grn_savage_orcs"
                    and current_faction:subculture() ~= "wh2_dlc11_sc_cst_vampire_coast")
                    --or (not savage_restriction_value and current_faction:subculture() == "wh_main_sc_grn_savage_orcs")
                    or (not cst_restriction_value and current_faction:subculture() == "wh2_dlc11_sc_cst_vampire_coast") 
                    or ((not tmb_restriction_value and current_faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings") 
                    or (tmb_restriction_value and current_faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" and current_faction:name() ~= "wh2_dlc09_tmb_khemri" 
                    --and current_faction:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and current_faction:name() ~= "wh2_dlc09_tmb_the_sentinels"
                    ))) 
                    -- others
                    and current_faction:is_dead() and not cm:get_saved_value("sought_refuge_"..current_faction:name()) and not cm:get_saved_value("delayed_spawn_"..current_faction:name()) 
                    and (not cm:get_saved_value("rd_choice_3_"..current_faction:name()) or cm:model():turn_number() >= cm:get_saved_value("rd_choice_3_"..current_faction:name())) 
                    and not cm:get_saved_value("rd_choice_2_"..current_faction:name()) then 
                        -- faction exceptions
                        if not is_faction_exempted(current_faction) then --and not current_faction:subculture() == "wh_dlc08_sc_nor_norsca"
                            local prefered_factions = nil 
                            if preferance6_value and preferance6_value ~= "disabled" then
                                prefered_factions = get_prefered_faction_list(prefered_factions, preferance6_value, current_faction)
                            end
                            if preferance5_value and preferance5_value ~= "disabled" then
                                prefered_factions = get_prefered_faction_list(prefered_factions, preferance5_value, current_faction)
                            end
                            if preferance4_value and preferance4_value ~= "disabled" then
                                prefered_factions = get_prefered_faction_list(prefered_factions, preferance4_value, current_faction)
                            end
                            if preferance3_value and preferance3_value ~= "disabled" then
                                prefered_factions = get_prefered_faction_list(prefered_factions, preferance3_value, current_faction)
                            end
                            if preferance2_value and preferance2_value ~= "disabled" then
                                prefered_factions = get_prefered_faction_list(prefered_factions, preferance2_value, current_faction)
                            end
                            if preferance1_value and preferance1_value ~= "disabled" then
                                prefered_factions = get_prefered_faction_list(prefered_factions, preferance1_value, current_faction)
                            end
                            --old
                            --if preferance1_value == "disabled" and preferance2_value == "disabled" and preferance3_value == "disabled" 
                            --and preferance4_value == "disabled" and preferance5_value == "disabled" and preferance6_value == "disabled" then
                            --    prefered_factions = get_prefered_faction_list(nil, nil, current_faction) -- returns factions_of_same_subculture as vector<string>
                            --end
                            local prefered_faction = nil
                            local prefered_faction_key = prefered_factions[1]
                            --old
                            --if prefered_factions and #prefered_factions >= 1 then
                            --    local rng_index = cm:random_number(#prefered_factions)
                            --    local prefered_faction_key = prefered_factions[rng_index]
                            --    prefered_faction = cm:get_faction(prefered_faction_key)
                            --end
                            if prefered_faction_key then
                                prefered_faction = cm:get_faction(prefered_faction_key)
                            end
                            --sm0_log("recruit_defeated_FactionTurnStart | prefered_faction = "..tostring(prefered_faction_key).." | dead_faction = "..tostring(current_faction:name()))
                            -- NEEDS WORK!!! (MP)
                            if prefered_faction and not faction_P1:is_dead() and current_faction:subculture() == faction_P1:subculture() 
                            and cm:get_saved_value("rd_choice_1_"..current_faction:name()) ~= faction_P1:name() and prefered_faction:name() == faction_P1:name() then
                                if confed_penalty(faction_P1) == "" and player_confederation_count <= player_confederation_limit and (scope_value == "player_ai" or scope_value == "player") 
                                and context:faction():name() == faction_P1:name() then
                                    --if current_faction:name() == "wh_main_emp_empire" then cm:set_saved_value("karl_check_illegit", true) end
                                    if are_lords_missing(current_faction) then
                                        sm0_log("["..player_confederation_count.."] Player 1 intends to spawn missing lords for: "..current_faction:name())
                                        spawn_missing_lords(faction_P1, current_faction)
                                        --making sure there are no further confederations happening during the spawn_missing_lords loop
                                        player_confederation_count = player_confederation_count + player_confederation_limit
                                        ai_confederation_count = ai_confederation_count + ai_confederation_limit                                  
                                    else
                                        sm0_log("["..player_confederation_count.."] Player 1 intends to confederate: "..current_faction:name())
                                        rd_dilemma(faction_P1, current_faction)
                                        if cm:is_multiplayer() and faction_P1:subculture() == faction_P2:subculture() then
                                            cm:set_saved_value("faction_P1", true)
                                            cm:set_saved_value("faction_P2", false)
                                        end
                                        player_confederation_count = player_confederation_count + 1
                                    end
                                end
                            elseif prefered_faction and cm:is_multiplayer() and not faction_P2:is_dead() and current_faction:subculture() == faction_P2:subculture() 
                            and cm:get_saved_value("rd_choice_1_"..current_faction:name()) ~= faction_P2:name() and prefered_faction:name() == faction_P2:name() then
                                if confed_penalty(faction_P2) == "" and player_confederation_count <= player_confederation_limit and (scope_value == "player_ai"  or scope_value == "player") 
                                and context:faction():name() == faction_P2:name() then
                                    --if current_faction:name() == "wh_main_emp_empire" then cm:set_saved_value("karl_check_illegit", true) end
                                    if are_lords_missing(current_faction) then
                                        sm0_log("["..player_confederation_count.."] Player 2 intends to spawn missing lords for: "..current_faction:name())
                                        spawn_missing_lords(faction_P2, current_faction)
                                        --making sure there are no further confederations happening during the spawn_missing_lords loop
                                        player_confederation_count = player_confederation_count + player_confederation_limit
                                        ai_confederation_count = ai_confederation_count + ai_confederation_limit
                                    else
                                        sm0_log("["..player_confederation_count.."] Player 2 intends to confederate: "..current_faction:name())
                                        rd_dilemma(faction_P2, current_faction)
                                        if cm:is_multiplayer() and faction_P1:subculture() == faction_P2:subculture() then
                                            cm:set_saved_value("faction_P2", true)
                                            cm:set_saved_value("faction_P1", false)                                
                                        end
                                        player_confederation_count = player_confederation_count + 1
                                    end
                                end
                            else --ai
                                if scope_value == "player_ai" or scope_value == "ai" then 
                                    if prefered_faction and ai_confederation_count <= ai_confederation_limit 
                                    and prefered_faction:subculture() ~= "wh_dlc03_sc_bst_beastmen" and current_faction:subculture() ~= "wh_main_sc_grn_savage_orcs" then -- disabled for beastmen/savage orcs because they are able to respawn anyways
                                        if not faked_death(prefered_faction) then
                                            if ai_delay_value == 0 or cm:model():turn_number() > ai_delay_value then --if ai_delay == 0 or cm:get_saved_value("sm0_rd_delay_"..current_faction:name()) == 0 then
                                                if are_lords_missing(current_faction) then
                                                    sm0_log("["..ai_confederation_count.."] AI: "..current_faction:name().." intends to spawn missing lords!")
                                                    spawn_missing_lords(prefered_faction, current_faction)
                                                    --making sure there are no further confederations happening during the spawn_missing_lords loop
                                                    player_confederation_count = player_confederation_count + player_confederation_limit
                                                    ai_confederation_count = ai_confederation_count + ai_confederation_limit
                                                else
                                                    sm0_log("["..ai_confederation_count.."] AI: "..prefered_faction:name().." intends to confederate: "..current_faction:name())
                                                    confed_revived(prefered_faction, current_faction)
                                                    ai_confederation_count = ai_confederation_count + 1
                                                end
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
                end, 3, "recruit_defeated_FactionTurnStart_callback")
            end,
            true
        )

        core:add_listener(
            "recruit_defeated_DilemmaChoiceMadeEvent",
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
            "recruit_defeated_FactionJoinsConfederation",
            "FactionJoinsConfederation",
            true,
            function(context)
                cm:set_saved_value("sought_refuge_"..context:faction():name(), context:confederation():name())
                if not cm:get_saved_value("rd_confed") then sm0_log("Diplomatic/Norscan/Greenskin Confederation: "..context:confederation():name().." :confederated: "..context:faction():name()) end
                
                --if context:confederation():subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
                --    local characterList = context:confederation():character_list()
                --    for i = 0, characterList:num_items() - 1 do
                --        local current_char = characterList:item_at(i)			
                --        if current_char:is_faction_leader() then --cm:char_is_general(current_char)
                --            cm:set_character_immortality(cm:char_lookup_str(current_char:command_queue_index()), true) 
                --        end
                --    end
                --end
                --if cm:get_saved_value("karl_check_illegit") then cm:set_saved_value("karl_check_illegit", false) end
            end,
            true
        )
        
        core:add_listener(
            "recruit_defeated_ScriptEventConfederationExpired",
            "ScriptEventConfederationExpired",
            true,
            function(context)
                apply_diplomacy(context.string)
            end,
            true
        )
        --Multiplayer listener
        core:add_listener(
            "recruit_defeated_UITrigger",
            "UITrigger",
            function(context)
                return context:trigger():starts_with("RD|")
            end,
            function(context)
                local faction_cqi = context:faction_cqi()
                local str = context:trigger() 
                local info = string.gsub(str, "RD|", "")
                local char_cqi_end = string.find(info, ":")
                local char_cqi = string.sub(info, 1, char_cqi_end - 1) 
                local subtype_end = string.find(info, ";")
                local subtype = string.sub(info, char_cqi_end + 1, subtype_end - 1) 
                local confederated = string.sub(info, subtype_end + 1)
                local character = cm:get_character_by_cqi(char_cqi)
                local confederator
                local confederated_faction = cm:get_faction(confederated)
                local human_factions = cm:get_human_factions()
                for i = 1, #human_factions do
                    local human_faction = cm:get_faction(human_factions[i])
                    if human_faction:command_queue_index() == faction_cqi then
                        confederator = human_factions[i]
                    end
                end
                if not character and confederated_faction then
                    local character_list = confederated_faction:character_list()
                    for i = 0, character_list:num_items() - 1 do
                        local current_char = character_list:item_at(i)
                        if current_char:character_subtype_key() == subtype then
                            character = current_char
                        end
                    end
                end
                if character then 
                    local picture = faction_event_picture[confederator]
                    if not is_number(picture) then 
                        local confederator_faction = cm:get_faction(confederator)
                        picture = subculture_event_picture[confederator_faction:subculture()] 
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
            end,
            true
        )
        -- variation of vanilla function char_with_forename_has_no_military_force()
        -- in case people rename their legendary lords, e.g. "Karl Franz" to "Imperator Kiwi" >_>
        -- when unlocking starting generals, as a fail safe, ensure that they do not have a military force (are present on the map) before trying to unlock them
        -- otherwise catastrophic failures may occur.
        local function unique_char_subtype_has_no_military_force(character_subtype)
            local faction_list = cm:model():world():faction_list()   
            for i = 0, faction_list:num_items() - 1 do
                local current_faction = faction_list:item_at(i)
                local char_list = current_faction:character_list()
                
                for j = 0, char_list:num_items() - 1 do
                    local current_char = char_list:item_at(j)
                    if current_char:character_subtype_key() == character_subtype and current_char:has_military_force() then
                        --script_error("Tried to unlock legendary lord with character_subtype [" .. character_subtype .. "], but that legendary lord already has a military force (i.e. is on the map) - how can this happen?")
                        return false
                    end
                end
            end
            return true
        end
        --re-enable karl franz lock (data.pack script/campaign/main_campaign/wh_legendary_lords.lua)
        -- NEEDS WORK!!!
        --if (faction_P1:name() == "wh_main_emp_empire" or (cm:is_multiplayer() and faction_P2:name() == "wh_main_emp_empire")) 
        --and not cm:get_saved_value("2140783388" .. "_unlocked") then    
        --    core:remove_listener("2140783388" .. "_listener")
        --    core:add_listener(
        --        "2140783388" .. "_listener",
        --        "FactionJoinsConfederation",
        --        function(context)
        --            return context:confederation():name() == "wh_main_emp_empire"
        --        end,
        --        function()
        --            if unique_char_subtype_has_no_military_force("wh_main_emp_karl_franz") and not cm:get_saved_value("rd_confed") then    --and not cm:get_saved_value("karl_check_illegit") then                       
        --                cm:unlock_starting_general_recruitment("2140783388", "wh_main_emp_empire")
        --                cm:set_saved_value("2140783388" .. "_unlocked", true)
        --                core:remove_listener("2140783388" .. "_listener")
        --            end
        --        end,
        --        true
        --    )
        --end
        -- nakai confed override (data.pack script/campaign/wh_campaign_setup.lua)
        core:remove_listener("confederation_listener")
        core:add_listener(
            "recruit_defeated_confederation_listener",
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
                if faction_subculture ~= "wh_main_sc_emp_empire" and faction_culture ~= "wh_dlc03_bst_beastmen" and faction_culture ~= "wh_main_brt_bretonnia" and faction_subculture ~= "wh_dlc08_sc_nor_norsca" and faction_subculture ~= "wh3_main_sc_ksl_kislev" then
                --if faction_human == false or (faction_subculture ~= "wh_main_sc_emp_empire" and faction_culture ~= "wh_dlc03_bst_beastmen" and (faction_culture ~= "wh_main_brt_bretonnia" or faction_name == "wh2_dlc14_brt_chevaliers_de_lyonesse") and faction_subculture ~= "wh_dlc08_sc_nor_norsca") then
                    --if faction_human == false then
                    --    confederation_timeout = 10
                    --end

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
                            cm:kill_character(current_char:command_queue_index(), true)
                        end
                    end
                elseif faction_culture == "wh2_main_def_dark_elves" and source_faction_name == "wh2_main_def_cult_of_pleasure" then
                    local char_list = faction:character_list()
                    
                    for i = 0, char_list:num_items() - 1 do
                        local current_char = char_list:item_at(i)
                        
                        if current_char:has_skill("wh2_main_skill_all_dummy_agent_actions_def_death_hag_chs") then
                            cm:kill_character(current_char:command_queue_index(), true)
                        end
                    end
                elseif faction_name == "wh2_dlc13_lzd_spirits_of_the_jungle" then
                    local defender_faction = cm:model():world():faction_by_key("wh2_dlc13_lzd_defenders_of_the_great_plan")
                    
                    --cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_broken", "")
                    --cm:disable_event_feed_events(true, "", "", "diplomacy_treaty_negotiated_vassal")

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
                                    cm:kill_character(char_cqi, true)
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
        
                    --cm:callback(function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_broken", "") end, 1)
                    --cm:callback(function() cm:disable_event_feed_events(false, "", "","diplomacy_treaty_negotiated_vassal") end, 1)
                elseif source_faction_name == "wh2_dlc13_lzd_spirits_of_the_jungle" then
                    if not cm:get_saved_value("sm0_rd_wh2_dlc13_lzd_spirits_of_the_jungle") then
                        --cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_broken", "")
                        --cm:disable_event_feed_events(true, "", "", "diplomacy_treaty_negotiated_vassal")
        
                        cm:force_confederation(faction_name, "wh2_dlc13_lzd_defenders_of_the_great_plan")
        
                        --cm:callback(function() cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_broken", "") end, 1)
                        --cm:callback(function() cm:disable_event_feed_events(false, "", "", "diplomacy_treaty_negotiated_vassal") end, 1)
                    else
                        cm:set_saved_value("sm0_rd_wh2_dlc13_lzd_spirits_of_the_jungle", false)
                    end
                end
            end,
            true
        )
    end
end

core:add_listener(
    "recruit_defeated_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        local mct = get_mct()
        local recruit_defeated_mod = mct:get_mod_by_key("recruit_defeated")
        --local settings_table = recruit_defeated_mod:get_settings() 
        --enable_value = settings_table.a_enable
        --scope_value = settings_table.c_scope
        --ai_delay_value = settings_table.d_ai_delay
        --preferance1_value = settings_table.a_preferance1
        --preferance2_value = settings_table.b_preferance2
        --preferance3_value = settings_table.c_preferance3

        local a_enable = recruit_defeated_mod:get_option_by_key("a_enable")
        enable_value = a_enable:get_finalized_setting()
        local c_scope = recruit_defeated_mod:get_option_by_key("c_scope")
        scope_value = c_scope:get_finalized_setting()
        local d_ai_delay = recruit_defeated_mod:get_option_by_key("d_ai_delay")
        ai_delay_value = d_ai_delay:get_finalized_setting()
        local a_preferance1 = recruit_defeated_mod:get_option_by_key("a_preferance1")
        preferance1_value = a_preferance1:get_finalized_setting()
        local b_preferance2 = recruit_defeated_mod:get_option_by_key("b_preferance2")
        preferance2_value = b_preferance2:get_finalized_setting()
        local c_preferance3 = recruit_defeated_mod:get_option_by_key("c_preferance3")
        preferance3_value = c_preferance3:get_finalized_setting()
        local d_preferance4 = recruit_defeated_mod:get_option_by_key("d_preferance4")
        preferance4_value = d_preferance4:get_finalized_setting()
        local e_preferance5 = recruit_defeated_mod:get_option_by_key("e_preferance5")
        preferance5_value = e_preferance5:get_finalized_setting()
        local f_preferance6 = recruit_defeated_mod:get_option_by_key("f_preferance6")
        preferance6_value = f_preferance6:get_finalized_setting()
        local a_tmb_restriction = recruit_defeated_mod:get_option_by_key("a_tmb_restriction")
        tmb_restriction_value = a_tmb_restriction:get_finalized_setting()
        local b_cst_restriction = recruit_defeated_mod:get_option_by_key("b_cst_restriction")
        cst_restriction_value = b_cst_restriction:get_finalized_setting()
        local d_wef_restriction = recruit_defeated_mod:get_option_by_key("d_wef_restriction")
        wef_restriction_value = d_wef_restriction:get_finalized_setting()

        --local c_savage_restriction = recruit_defeated_mod:get_option_by_key("c_savage_restriction")
        --savage_restriction_value = c_savage_restriction:get_finalized_setting()

        --sm0_log("recruit_defeated_MctInitialized/savage_restriction_value = "..tostring(savage_restriction_value))
    end,
    true
)

core:add_listener(
    "recruit_defeated_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        local mct = get_mct()
        local recruit_defeated_mod = mct:get_mod_by_key("recruit_defeated")
        local settings_table = recruit_defeated_mod:get_settings() 
        enable_value = settings_table.a_enable
        scope_value = settings_table.c_scope
        ai_delay_value = settings_table.d_ai_delay
        preferance1_value = settings_table.a_preferance1
        preferance2_value = settings_table.b_preferance2
        preferance3_value = settings_table.c_preferance3
        preferance4_value = settings_table.d_preferance4
        preferance5_value = settings_table.e_preferance5
        preferance6_value = settings_table.f_preferance6
        tmb_restriction_value = settings_table.a_tmb_restriction
        cst_restriction_value = settings_table.b_cst_restriction
        wef_restriction_value = settings_table.d_wef_restriction
        --savage_restriction_value = settings_table.c_savage_restriction
        
        sm0_log("recruit_defeated_MctInitialized/enable_value = "..tostring(enable_value))
        sm0_log("recruit_defeated_MctInitialized/scope_value = "..tostring(scope_value))
        sm0_log("recruit_defeated_MctInitialized/ai_delay_value = "..tostring(ai_delay_value))
        sm0_log("recruit_defeated_MctInitialized/preferance1_value = "..tostring(preferance1_value))
        sm0_log("recruit_defeated_MctInitialized/preferance2_value = "..tostring(preferance2_value))
        sm0_log("recruit_defeated_MctInitialized/preferance3_value = "..tostring(preferance3_value))
        sm0_log("recruit_defeated_MctInitialized/preferance4_value = "..tostring(preferance4_value))
        sm0_log("recruit_defeated_MctInitialized/preferance5_value = "..tostring(preferance5_value))
        sm0_log("recruit_defeated_MctInitialized/preferance6_value = "..tostring(preferance6_value))
        sm0_log("recruit_defeated_MctInitialized/tmb_restriction_value = "..tostring(tmb_restriction_value))
        sm0_log("recruit_defeated_MctInitialized/cst_restriction_value = "..tostring(cst_restriction_value))
        sm0_log("recruit_defeated_MctInitialized/wef_restriction_value = "..tostring(wef_restriction_value))

        init_recruit_defeated_listeners(enable_value)
    end,
    true
)

function sm0_recruit_defeated()
    RDDEBUG()
    --local mcm = _G.mcm
    local mct = core:get_static_object("mod_configuration_tool")

    local version_number = "2.0" --debug: "vs.code" --H&B "1.0" --S&B "1.1" --MCM "2.0"
    if cm:is_new_game() then 
        if not cm:get_saved_value("sm0_log_reset") then
            sm0_log_reset()
            cm:set_saved_value("sm0_log_reset", true)
        end
    end

    if vfs.exists("script/campaign/mod/!ovn_me_lost_factions_start.lua") then
        cm:force_diplomacy("faction:wh2_main_emp_grudgebringers", "all", "form confederation", false, false, false)
        cm:force_diplomacy("faction:wh2_main_emp_the_moot", "all", "form confederation", false, false, false)
    end

    if mct then
        -- MCT new --
        --sm0_log("sm0_confed/mct/enable_value = "..tostring(enable_value))
		--sm0_log("sm0_confed/mct/restriction_value = "..tostring(restriction_value))
		local confederation_options_mod = mct:get_mod_by_key("confederation_options")
		if confederation_options_mod and cm:is_new_game() then
            local tk_option = confederation_options_mod:get_option_by_key("wh2_dlc09_sc_tmb_tomb_kings")
            if tk_option then
                local tk_value = tk_option:get_finalized_setting()
                if tk_value == "no_tweak" then
                    cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
                end
            end
            local cst_option = confederation_options_mod:get_option_by_key("wh2_dlc11_sc_cst_vampire_coast")
            if cst_option then
                local cst_value = cst_option:get_finalized_setting()
                if cst_value == "no_tweak" then
                    cm:force_diplomacy("subculture:wh2_dlc11_sc_cst_vampire_coast", "subculture:wh2_dlc11_sc_cst_vampire_coast", "form confederation", false, false, false)
                end
            end
            local teb_option = confederation_options_mod:get_option_by_key("wh_main_sc_teb_teb")
            if teb_option then
                local teb_value = teb_option:get_finalized_setting()
                if teb_value == "no_tweak" and not vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then
                    cm:force_diplomacy("subculture:wh_main_sc_teb_teb", "subculture:wh_main_sc_teb_teb", "form confederation", false, false, false)
                end
            end
            --local araby_option = confederation_options_mod:get_option_by_key("wh_main_sc_emp_araby")
            --if araby_option then
            --    local araby_value = araby_option:get_finalized_setting() 
            --    if araby_value == "no_tweak" then
            --        cm:force_diplomacy("subculture:wh_main_sc_emp_araby", "subculture:wh_main_sc_emp_araby", "form confederation", false, false, false)
            --    end
            --end
		end
    else
		--local tk_value = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc09_tmb_tomb_kings_value")
		--if not tk_value or tk_value == "yield" then
			cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
        --end
        --local cst_value = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc11_cst_vampire_coast_value")
        --if not cst_value or cst_value == "yield" then
            cm:force_diplomacy("subculture:wh2_dlc11_sc_cst_vampire_coast", "subculture:wh2_dlc11_sc_cst_vampire_coast", "form confederation", false, false, false)
        --end
		--local teb_value = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh_main_emp_empire") 
		--if (not teb_value or teb_value == "yield") and not vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then
			cm:force_diplomacy("subculture:wh_main_sc_teb_teb", "subculture:wh_main_sc_teb_teb", "form confederation", false, false, false)
        --end
        --local araby_value = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh_main_sc_emp_araby") 
		--if (not araby_value or emp_value == "yield") then
		--	cm:force_diplomacy("subculture:wh_main_sc_emp_araby", "subculture:wh_main_sc_emp_araby", "form confederation", false, false, false)
        --end
        
        enable_value = true
        --if cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") ~= "lorefriendly" then
            tmb_restriction_value = false
            cst_restriction_value = false
            wef_restriction_value = false
            --savage_restriction_value = false
        --else
        --    tmb_restriction_value = true
        --    cst_restriction_value = true
        --    wef_restriction_value = true
        --    --savage_restriction_value = true
        --end
        --scope_value = cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") or "player_ai"
        --ai_delay_value = cm:get_saved_value("mcm_variable_recruit_defeated_ai_delay_value") or 50
        --preferance1_value = cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") or "player"
        scope_value = "player_ai"
        ai_delay_value = 1 --50
        preferance1_value = "player"
        preferance2_value = "alternate"
        preferance3_value = "met"
        --if cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance2_value") == "power" then
        --    preferance4_value = "major"
        --else
            preferance4_value = "relation"
        --end
        preferance5_value = "major"
        preferance6_value = "disable"
        --sm0_log("sm0_recruit_defeated | enable_value = "..tostring(enable_value)..
        --" | scope_value = "..tostring(scope_value).." | ai_delay_value = "..tostring(ai_delay_value)..
        --" | preferance1_value = "..tostring(preferance1_value).." | preferance2_value = "..tostring(preferance2_value).." | preferance3_value = "..tostring(preferance3_value))

		--if not not mcm then
        --    local recruit_defeated = mcm:register_mod("recruit_defeated", "Recruit Defeated Legendary Lords", "")
        --    --if legacy_option then
        --    --    local version = recruit_defeated:add_tweaker("version", "Mod Version", "Choose your prefered mod version.")
        --    --    version:add_option("default", "Default", "This script uses confederation methods to transfer legendary lords from dead factions to the player/ai. Written by sm0kin.")
        --    --    version:add_option("legacy", "Legacy", "DISCONTINUED VERSION!!!\nThis script uses spawn methods to create doppelganger lords and deletes the original legendary lords in case the faction gets revived. Written by Scipion. Originally by scipion, reworked by sm0kin.")
        --    --end
        --    local lore_restriction = recruit_defeated:add_tweaker("lore_restriction", "Restriction", "Defines whether defeated Lords/Heroes can join any faction of the same subculture or if they are restricted from joining factions that make little to no sense considering their background.") --mcm_tweaker_recruit_defeated_lore_restriction_value
        --    lore_restriction:add_option("all", "Gotta Catch 'Em All", "No restrictions.")
        --    lore_restriction:add_option("lorefriendly", "Lorefriendly", "Restrictions are in place for the following factions:\n*Khemri: no Arkhan\n*Lybaras/Exiles of Nehek/Numas: no Settra, no Arkhan\n\nRecruit Defeated is disabled for the following cultures/factions:\n*Vampire Coast\n*Followers of Nagash")
        --    local scope = recruit_defeated:add_tweaker("scope", "Available for", "Specifies if defeated Lords/Heroes are allowed to join the player, the ai or both.") --mcm_tweaker_recruit_defeated_scope_value
        --    scope:add_option("player_ai", "Player & AI", "")
        --    scope:add_option("player", "Player only", "")
        --    scope:add_option("ai", "AI only", "")
        --    local preferance = recruit_defeated:add_tweaker("preferance", "Preference (1. Level)", "Should factions prefer to join the ai or the player (supersedes \"Preference (2. Level)\")?") --mcm_tweaker_recruit_defeated_preferance_value
        --    preferance:add_option("player", "Prefer Player", "Defeated Lords/Heroes will always join a player-led faction.")
        --    preferance:add_option("ai", "Prefer AI", "As long as a AI factions is left defeated Lords/Heroes will prefer them over the player.")
        --    preferance:add_option("disable", "Disable", "No AI/Player preferance.")
        --    local preferance2 = recruit_defeated:add_tweaker("preferance2", "Preference (2. Level)", "Determines the criteria used to decide which faction is chosen to receive the refugee dilemma (superseded by \"Preference (1. Level)\"") --mcm_tweaker_recruit_defeated_preferance2_value
        --    preferance2:add_option("relation", "Relation based", "Defeated Lords/Heroes join the faction they have the best diplomatic relations with.")
        --    preferance2:add_option("power", "Prefer Major Factions", "Defeated Lords/Heroes will prefer Major Factions.")
        --    --local diplo = recruit_defeated:add_tweaker("diplo", "Lords/Heroes join factions based on diplomatic standing", "Defeated Lords/Heroes join the faction they have the best diplomatic relations with.") --mcm_tweaker_recruit_defeated_diplo_value
        --    --diplo:add_option("enable", "Enable", "")
        --    --diplo:add_option("disable", "Disable", "")
        --    local ai_delay = recruit_defeated:add_variable("ai_delay", 0, 200, 50, 5, "AI Turn Delay", "Determines at which turn the AI starts to get Lords/Heroes from defeated factions.")
        --    mcm:add_post_process_callback(
        --        function()
        --            sm0_log("Mod Version: default/mcm".." ("..version_number..")")
        --            if cm:get_saved_value("mcm_tweaker_recruit_defeated_lore_restriction_value") ~= "lorefriendly" then
        --                tmb_restriction_value = false
        --                cst_restriction_value = false
        --                wef_restriction_value = false
        --                --savage_restriction_value = false
        --            else
        --                tmb_restriction_value = true
        --                cst_restriction_value = true
        --                wef_restriction_value = true
        --                --savage_restriction_value = true
        --            end
        --            scope_value = cm:get_saved_value("mcm_tweaker_recruit_defeated_scope_value") or "player_ai"
        --            ai_delay_value = cm:get_saved_value("mcm_variable_recruit_defeated_ai_delay_value") or 50
        --            preferance1_value = cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance_value") or "player"
        --            preferance2_value = "alternate"
        --            preferance3_value = "met"
        --            if cm:get_saved_value("mcm_tweaker_recruit_defeated_preferance2_value") == "power" then
        --                preferance4_value = "major"
        --            else
        --                preferance4_value = "relation"
        --            end
        --            preferance5_value = "major"
        --            preferance6_value = "disable"
        --
        --            --sm0_log("sm0_recruit_defeated | enable_value = "..tostring(enable_value)..
        --            --" | scope_value = "..tostring(scope_value).." | ai_delay_value = "..tostring(ai_delay_value)..
        --            --" | preferance1_value = "..tostring(preferance1_value).." | preferance2_value = "..tostring(preferance2_value).." | preferance3_value = "..tostring(preferance3_value))
        --        end
        --    )
        --else
        --    sm0_log("Mod Version: default".." ("..version_number..")")
        --end	
	end
    init_recruit_defeated_listeners(enable_value)
end