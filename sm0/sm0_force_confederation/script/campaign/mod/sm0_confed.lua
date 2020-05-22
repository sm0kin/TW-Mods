local playerFaction = nil
--# assume playerFaction: CA_FACTION
local restriction_value
local OccupationOptionID = {
	["1913039130"] = "wh2_sm0_sc_brt_bretonnia_occupation_decision_confederate",
	["1913039131"] = "wh2_sm0_sc_lzd_lizardmen_occupation_decision_confederate",
	["1913039132"] = "wh2_sm0_sc_skv_skaven_occupation_decision_confederate",
	["1913039133"] = "wh2_sm0_sc_def_dark_elves_occupation_decision_confederate",
	["1913039134"] = "wh2_sm0_sc_dwf_dwarfs_occupation_decision_confederate",
	["1913039135"] = "wh2_sm0_sc_emp_empire_occupation_decision_confederate",
	["1913039137"] = "wh2_sm0_sc_hef_high_elves_occupation_decision_confederate",
	["1913039138"] = "wh2_sm0_sc_wef_wood_elves_occupation_decision_confederate",
	["1913039139"] = "wh2_sm0_sc_vmp_vampire_counts_occupation_decision_confederate",
	["1913039140"] = "wh2_sm0_sc_tmb_tomb_kings_occupation_decision_confederate",
	["1913039141"] = "wh2_sm0_sc_teb_teb_occupation_decision_confederate"
} --: map<string, string>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--v function()
local function initMCMconfed()
	local confed_option_tmb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc09_tmb_tomb_kings_value")
	if not confed_option_tmb or confed_option_tmb == "yield" then
		cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
	end
	local confed_option_teb = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh_main_emp_empire") -- no teb / kislev subculture?
	if (not confed_option_tmb or confed_option_tmb == "yield") and not vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then
        cm:force_diplomacy("subculture:wh_main_sc_teb_teb", "subculture:wh_main_sc_teb_teb", "form confederation", false, false, false)
	end
	restriction_value = cm:get_saved_value("mcm_tweaker_force_confederation_restriction_value")
	if restriction_value ~= "unrestricted" then restriction_value = "restricted" end
	local mcm = _G.mcm
	if not not mcm then
		local confed = mcm:register_mod("force_confederation", "Force Confederation", "Adds Force Confederation as occupation option.")
		local restriction = confed:add_tweaker("restriction", "Tomb Kings - Restrictions", "Set your prefered rules for Tomb Kings Force Confederation!")
		restriction:add_option("restricted", "Lorefriendly", "Lore based limitations, e.g. Settra can confederate any Tomb Kings faction aside from The Followers of Nagash and The Sentinels.")
		restriction:add_option("unrestricted", "No restrictions", "Completely unrestricted!")
		mcm:add_new_game_only_callback(
			function()
				restriction_value = cm:get_saved_value("mcm_tweaker_force_confederation_restriction_value")
			end
		)
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--v function()
local function addTkImmortality()
	if playerFaction and playerFaction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
		local characterList = playerFaction:character_list()
		for i = 0, characterList:num_items() - 1 do
			local currentChar = characterList:item_at(i)			
			if currentChar:is_wounded() and cm:char_is_general(currentChar) then
				cm:set_character_immortality(cm:char_lookup_str(currentChar:command_queue_index()), true) 
			end
		end
	end
end

--v function(faction: CA_FACTION)
local function killAllUnits(faction)
	local mfList = faction:military_force_list()
	for i = 0, mfList:num_items() - 1 do
		local mf = mfList:item_at(i)	
		if mf:has_general() then
			cm:kill_character(mf:general_character():command_queue_index(), true, true)
		end
	end
end

--v function(char: CA_CHAR, faction: CA_FACTION)
local function forceConfed(char, faction)
	local winnerFactionName = char:faction():name()
	local loserFaction = faction
	local loserFactionName = loserFaction:name()
	killAllUnits(loserFaction)
	cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_broken", "")
	cm:force_confederation(winnerFactionName, loserFactionName)
	cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_broken", "")
	cm:callback(
		function(context)
			addTkImmortality()
		end, 1, "wait for character list to update"
	)
end

--v function() --init
function sm0_confed()
	playerFaction = cm:get_faction(cm:get_local_faction(true))
	initMCMconfed()
	core:add_listener(
		"force_confederation_expired",
		"ScriptEventConfederationExpired",
		true,
		function(context)
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
				--"wh2_dlc11_sc_cst_vampire_coast"
			} --:vector<string>
			local faction_name = context.string
			local faction = cm:get_faction(faction_name)
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
		end,
		true
	)

	if playerFaction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
		core:add_listener(
			"TKgarrisonAttackedEvent",
			"GarrisonAttackedEvent",
			function(context)
				return cm:is_local_players_turn() and context:garrison_residence():faction():region_list():num_items() == 1
			end,
			function(context)
				FACTION_GARRISON_ATTACKED = context:garrison_residence():faction():name()
				cm:set_saved_value("faction_garrison_attacked", FACTION_GARRISON_ATTACKED)
			end,
			true
		)
	end

	core:add_listener(
		"SettlementCapturedPanelOpened",
		"PanelOpenedCampaign",
		function(context)		
			return context.string == "settlement_captured" 
		end,
		function(context)
			local icon = find_uicomponent(core:get_ui_root(), "settlement_captured", "icon_vassals")
			if icon ~= nil then 
				for currentID, _ in pairs(OccupationOptionID) do
					local frame = find_uicomponent(core:get_ui_root(), "settlement_captured", tostring(currentID))
					if frame then
						icon = find_uicomponent(core:get_ui_root(), "settlement_captured", "button_parent", tostring(currentID), "frame", "icon_parent", "icon_vassals")
						icon:SetImagePath("UI/skins/default/treaty_confederation.png")
						icon:SetTooltipText("Forces the enemy faction to accept Confederation. All their armies will be disbanded and their legendary lords will be forced to serve under your rule.", "", true)
						local button = find_uicomponent(core:get_ui_root(), "settlement_captured", tostring(currentID), "option_button")
						if FACTION_GARRISON_ATTACKED == nil then
							FACTION_GARRISON_ATTACKED = cm:get_saved_value("faction_garrison_attacked")
						end				
						if restriction_value ~= "unrestricted" and playerFaction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
							if FACTION_GARRISON_ATTACKED == "wh2_dlc09_tmb_khemri" then
								button:SetDisabled(true)
								button:SetOpacity(50)
								button:SetTooltipText("SETTRA DOES NOT SERVE!", "", false)
							else
								if playerFaction:name() == "wh2_dlc09_tmb_followers_of_nagash" and FACTION_GARRISON_ATTACKED ~= "wh2_dlc09_tmb_the_sentinels" or playerFaction:name() == "wh2_dlc09_tmb_the_sentinels" and FACTION_GARRISON_ATTACKED ~= "wh2_dlc09_tmb_followers_of_nagash" then
									button:SetDisabled(true)
									button:SetOpacity(50)
									button:SetTooltipText("They would rather disintegrate than follow Nagash!", "", false)
								elseif playerFaction:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and FACTION_GARRISON_ATTACKED == "wh2_dlc09_tmb_the_sentinels" or playerFaction:name() ~= "wh2_dlc09_tmb_the_sentinels" and FACTION_GARRISON_ATTACKED == "wh2_dlc09_tmb_followers_of_nagash" then
									button:SetDisabled(true)
									button:SetOpacity(50)
									button:SetTooltipText("Betraying Khemri must never be forgiven!", "", false)
								end
							end
						end
					end
				end
			end
		end,
		true
	)

	core:add_listener(
		"ForceConfedClick",
		"ComponentLClickUp",
		function(context)
			local occupationPanel = find_uicomponent(core:get_ui_root(), "settlement_captured")
			if occupationPanel then
				local optionButton = UIComponent(context.component)
				if optionButton:Id() == "root" then
					return false
				else
					local optionParent = UIComponent(optionButton:Parent())
					local optionParentId = optionParent:Id()
					local OccupationKey = OccupationOptionID[optionParentId]
					return  OccupationKey ~= nil
				end
			end
		end,
		function(context)
			cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_negotiated", "")
		end,
		true
	)

	core:add_listener(
		"ForceConfedDecision",
		"CharacterPerformsSettlementOccupationDecision",
		function(context)
			local occupationDecision = context:occupation_decision()
			return OccupationOptionID[occupationDecision] ~= nil
		end,
		function(context)
			local occupationDecision = context:occupation_decision()
			cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_negotiated", "")
			forceConfed(context:character(), context:garrison_residence():faction())
		end,
		true
	)
end