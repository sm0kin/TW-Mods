local enable_value --:WHATEVER
local restriction_value --:WHATEVER
local occupation_option_id = {
	["1913039130"] = "wh2_sm0_sc_brt_bretonnia_occupation_decision_confederate",
	["1913039131"] = "wh2_sm0_sc_lzd_lizardmen_occupation_decision_confederate",
	["1913039132"] = "wh2_sm0_sc_skv_skaven_occupation_decision_confederate",
	["1913039133"] = "wh2_sm0_sc_def_dark_elves_occupation_decision_confederate",
	["1913039134"] = "wh2_sm0_sc_dwf_dwarfs_occupation_decision_confederate",
	["1913039135"] = "wh2_sm0_sc_emp_empire_occupation_decision_confederate",
	--["1913039136"] = "", -- prev grn
	["1913039137"] = "wh2_sm0_sc_hef_high_elves_occupation_decision_confederate",
	["1913039138"] = "wh2_sm0_sc_wef_wood_elves_occupation_decision_confederate",
	["1913039139"] = "wh2_sm0_sc_vmp_vampire_counts_occupation_decision_confederate",
	["1913039140"] = "wh2_sm0_sc_tmb_tomb_kings_occupation_decision_confederate",
	["1913039141"] = "wh2_sm0_sc_teb_teb_occupation_decision_confederate",
	["1913039142"] = "wh2_sm0_sc_vampire_coast_occupation_decision_confederate"
} --: map<string, string>

local subtype_immortality = { 
    ["wh2_dlc09_tmb_arkhan"] = true,
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
            cm:set_character_immortality(cm:char_lookup_str(char:command_queue_index()), true) 
        end 
    end       
end

--v function(faction: CA_FACTION)
local function kill_all_units(faction)
	local mf_list = faction:military_force_list()
	for i = 0, mf_list:num_items() - 1 do
		local mf = mf_list:item_at(i)	
		if mf:has_general() then
			cm:kill_character(mf:general_character():command_queue_index(), true, true)
		end
	end
end

--v function(char: CA_CHAR, faction: CA_FACTION)
local function force_confed(char, faction)
	local winner_faction_name = char:faction():name()
	local loser_faction = faction
	local loser_faction_name = loser_faction:name()
	kill_all_units(loser_faction)
	cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_broken", "")
	cm:force_confederation(winner_faction_name, loser_faction_name)
	cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_broken", "")
	if char:faction():subculture() == "wh2_dlc09_sc_tmb_tomb_kings" or char:faction():subculture() == "wh2_dlc11_sc_cst_vampire_coast" then
		cm:callback(
			function(context)
				immortality_backup(char:faction())
			end, 1, "wait for character list to update"
		)
	end
end

--v function(enable_value: WHATEVER)
local function init_force_confed_listeners(enable_value)
    core:remove_listener("force_confederation_ScriptEventConfederationExpired")
    core:remove_listener("force_confederation_GarrisonAttackedEvent")
    core:remove_listener("force_confederation_PanelOpenedCampaign")
    core:remove_listener("force_confederation_ComponentLClickUp")
    core:remove_listener("force_confederation_CharacterPerformsSettlementOccupationDecision")

	if enable_value then
		core:add_listener(
			"force_confederation_ScriptEventConfederationExpired",
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
						if faction:has_pooled_resource("emp_loyalty") == true then
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
							end
						end, 1, "changeDiplomacyOptions"
					)
				end
			end,
			true
		)

		core:add_listener(
			"force_confederation_GarrisonAttackedEvent",
			"GarrisonAttackedEvent",
			function(context)
				local garrison_faction = context:garrison_residence():faction()
				local attacker_faction = context:character():faction()
				return attacker_faction:is_human() and attacker_faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" and garrison_faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings"
				and garrison_faction:region_list():num_items() == 1
			end,
			function(context)
				local garrison_faction = context:garrison_residence():faction()
				local attacker_faction = context:character():faction()
				FACTION_GARRISON_ATTACKED = garrison_faction:name()
				cm:set_saved_value("faction_garrison_attacked", FACTION_GARRISON_ATTACKED)
				--out("sm0/force_confederation_GarrisonAttackedEvent/garrison_faction = "..garrison_faction:name())
				--out("sm0/force_confederation_GarrisonAttackedEvent/attacker_faction = "..attacker_faction:name())
			end,
			true
		)

		core:add_listener(
			"force_confederation_PanelOpenedCampaign",
			"PanelOpenedCampaign",
			function(context)		
				return context.string == "settlement_captured" 
			end,
			function(context)
				player_faction = cm:get_local_faction(true) 
				local icon = find_uicomponent(core:get_ui_root(), "settlement_captured", "icon_vassals")
				if icon ~= nil then 
					for current_id, _ in pairs(occupation_option_id) do
						local frame = find_uicomponent(core:get_ui_root(), "settlement_captured", tostring(current_id))
						if frame then
							icon = find_uicomponent(core:get_ui_root(), "settlement_captured", "button_parent", tostring(current_id), "frame", "icon_parent", "icon_vassals")
							icon:SetImagePath("UI/skins/default/treaty_confederation.png")
							icon:SetTooltipText(effect.get_localised_string("mct_force_confederation_tt"), "", true)
							local button = find_uicomponent(core:get_ui_root(), "settlement_captured", tostring(current_id), "option_button")
							if FACTION_GARRISON_ATTACKED == nil then
								FACTION_GARRISON_ATTACKED = cm:get_saved_value("faction_garrison_attacked")
							end				
							if restriction_value and player_faction:subculture() == "wh2_dlc09_sc_tmb_tomb_kings" then
								if FACTION_GARRISON_ATTACKED == "wh2_dlc09_tmb_khemri" then
									button:SetState("inactive")
									--button:SetDisabled(true)
									button:SetOpacity(50)
									button:SetTooltipText(effect.get_localised_string("mct_force_confederation_tt_tk1"), "", false)
								else
									if player_faction:name() == "wh2_dlc09_tmb_followers_of_nagash" and FACTION_GARRISON_ATTACKED ~= "wh2_dlc09_tmb_the_sentinels" or player_faction:name() == "wh2_dlc09_tmb_the_sentinels" and FACTION_GARRISON_ATTACKED ~= "wh2_dlc09_tmb_followers_of_nagash" then
										--button:SetDisabled(true)
										button:SetState("inactive")
										button:SetOpacity(50)
										button:SetTooltipText(effect.get_localised_string("mct_force_confederation_tt_tk2"), "", false)
									elseif player_faction:name() ~= "wh2_dlc09_tmb_followers_of_nagash" and FACTION_GARRISON_ATTACKED == "wh2_dlc09_tmb_the_sentinels" or player_faction:name() ~= "wh2_dlc09_tmb_the_sentinels" and FACTION_GARRISON_ATTACKED == "wh2_dlc09_tmb_followers_of_nagash" then
										--button:SetDisabled(true)
										button:SetState("inactive")
										button:SetOpacity(50)
										button:SetTooltipText(effect.get_localised_string("mct_force_confederation_tt_tk3"), "", false)
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
			"force_confederation_ComponentLClickUp",
			"ComponentLClickUp",
			function(context)
				local occupation_panel = find_uicomponent(core:get_ui_root(), "settlement_captured")
				if occupation_panel then
					local option_button = UIComponent(context.component)
					if option_button:Id() == "root" then
						return false
					else
						local option_parent = UIComponent(option_button:Parent())
						local option_parent_id = option_parent:Id()
						local occupation_key = occupation_option_id[option_parent_id]
						return  occupation_key ~= nil
					end
				end
			end,
			function(context)
				cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_negotiated", "")
			end,
			true
		)

		core:add_listener(
			"force_confederation_CharacterPerformsSettlementOccupationDecision",
			"CharacterPerformsSettlementOccupationDecision",
			function(context)
				local occupation_decision = context:occupation_decision()
				return occupation_option_id[occupation_decision] ~= nil
			end,
			function(context)
				local occupation_decision = context:occupation_decision()
				cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_negotiated", "")
				force_confed(context:character(), context:garrison_residence():faction())
			end,
			true
		)	
	end
end

core:add_listener(
    "force_confederation_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        local mct = get_mct()
        local force_confed_mod = mct:get_mod_by_key("force_confed")
        --local settings_table = force_confed_mod:get_settings() 
        --enable_value = settings_table.a_enable
        --restriction_value = settings_table.b_restriction

        local a_enable = force_confed_mod:get_option_by_key("a_enable")
        enable_value = a_enable:get_finalized_setting()
        local b_restriction = force_confed_mod:get_option_by_key("b_restriction")
        restriction_value = b_restriction:get_finalized_setting()
        
        --out("mct:log/force_confed_MctInitialized/enable_value = "..tostring(enable_value))
		--out("mct:log/force_confed_MctInitialized/restriction_value = "..tostring(restriction_value))

    end,
    true
)

core:add_listener(
    "force_confederation_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        local mct = get_mct()
        local force_confed_mod = mct:get_mod_by_key("force_confed")
        local settings_table = force_confed_mod:get_settings() 
        enable_value = settings_table.a_enable
        restriction_value = settings_table.b_restriction
        
        init_force_confed_listeners(enable_value)
    end,
    true
)

--v function() --init
function sm0_confed()
	local mcm = _G.mcm
    local mct = core:get_static_object("mod_configuration_tool")

    if mct then
        -- MCT new --
        --mct:log("sm0_confed/mct/enable_value = "..tostring(enable_value))
		--mct:log("sm0_confed/mct/restriction_value = "..tostring(restriction_value))
		local confederation_options_mod = mct:get_mod_by_key("confederation_options")
		if confederation_options_mod and cm:is_new_game() then
			local tk_option = confederation_options_mod:get_option_by_key("wh2_dlc09_sc_tmb_tomb_kings")
			tk_value = tk_option:get_finalized_setting()
			if tk_value == "no_tweak" then
				cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
            end
            local cst_option = confederation_options_mod:get_option_by_key("wh2_dlc11_sc_cst_vampire_coast")
			cst_value = cst_option:get_finalized_setting()
			if tk_value == "no_tweak" then
				cm:force_diplomacy("subculture:wh2_dlc11_sc_cst_vampire_coast", "subculture:wh2_dlc11_sc_cst_vampire_coast", "form confederation", false, false, false)
			end
			local emp_option = confederation_options_mod:get_option_by_key("wh_main_sc_teb_teb") --wh_main_sc_emp_empire
			emp_value = emp_option:get_finalized_setting() -- no teb / kislev subculture?
			if emp_value == "no_tweak" and not vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then
				cm:force_diplomacy("subculture:wh_main_sc_teb_teb", "subculture:wh_main_sc_teb_teb", "form confederation", false, false, false)
			end
		end
    else
		local tk_value = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc09_tmb_tomb_kings_value")
		if not tk_value or tk_value == "yield" then
			cm:force_diplomacy("subculture:wh2_dlc09_sc_tmb_tomb_kings", "subculture:wh2_dlc09_sc_tmb_tomb_kings", "form confederation", false, false, false)
        end
        local cst_value = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh2_dlc11_cst_vampire_coast_value")
        if not cst_value or cst_value == "yield" then
            cm:force_diplomacy("subculture:wh2_dlc11_sc_cst_vampire_coast", "subculture:wh2_dlc11_sc_cst_vampire_coast", "form confederation", false, false, false)
        end
		local emp_value = cm:get_saved_value("mcm_tweaker_confed_tweaks_wh_main_emp_empire") -- no teb / kislev subculture?
		if (not emp_value or emp_value == "yield") and not vfs.exists("script/campaign/main_warhammer/mod/cataph_teb_lords.lua") then
			cm:force_diplomacy("subculture:wh_main_sc_teb_teb", "subculture:wh_main_sc_teb_teb", "form confederation", false, false, false)
		end
		enable_value = true
        if cm:get_saved_value("mcm_tweaker_force_confederation_restriction_value") ~= "unrestricted" then
            restriction_value = true
        else
            restriction_value = false
        end	
		if not not mcm then
			local confed = mcm:register_mod("force_confederation", "Force Confederation", "Adds the Force Confederation occupation option.")
			local restriction = confed:add_tweaker("restriction", "Tomb Kings - Restrictions", "Set your prefered rules for Tomb Kings Force Confederation!")
			restriction:add_option("restricted", "Lorefriendly", "Lore based limitations, e.g. Settra can confederate any Tomb Kings faction aside from The Followers of Nagash and The Sentinels.")
			restriction:add_option("unrestricted", "No restrictions", "Completely unrestricted!")
			mcm:add_new_game_only_callback(
				function()
					if cm:get_saved_value("mcm_tweaker_force_confederation_restriction_value") ~= "unrestricted" then
						restriction_value = true
					else
						restriction_value = false
					end	
				end
			)
		end	
	end
	init_force_confed_listeners(enable_value)
end