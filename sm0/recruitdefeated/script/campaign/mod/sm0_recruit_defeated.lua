local mcm --:MCM

local alastar_quests = {
    { "wh2_main_anc_armour_lions_pelt", 1}
} --:vector<{string, number}>

--v function(quests: vector<{string, number}>, subtype: string)
local function ancillaryOnRankUp(quests, subtype)
	for i = 1, #quests do
		local currentQuest= quests[i]
		local ancillary = currentQuest[1]
		local rank = currentQuest[2]			
        core:add_listener(
            ancillary,
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

--v function(faction: string, region: string, x: number, y: number, subtype: string, forename: string, surname: string)
function createNewLord(faction, region, x, y, subtype, forename, surname)
    cm:create_force_with_general(
        faction,
        "wh_main_dwf_inf_hammerers", -- dummy unit
        region,
        x,
        y,
        "general",
        subtype, --subtype
        forename, --forename
        "",
        surname, --surname
        "",
        false,
        function(cqi)
			cm:set_character_immortality(cm:char_lookup_str(cqi), true)
			cm:kill_character(cqi, true, false)
			cm:stop_character_convalescing(cqi)
        end
    )
end

--v function(subtype: string, faction: string)
local function spamLords(subtype, faction)
	local factionCA = cm:get_faction(faction)
    local x, y
    if factionCA:has_home_region() then x, y = cm:find_valid_spawn_location_for_character_from_settlement(faction, factionCA:home_region():name(), false, false, 9) end
    if factionCA:subculture() == "wh2_main_sc_hef_high_elves" and not cm:get_saved_value("v_wh2_main_hef_prince_alastar_LL_unlocked") then
        cm:spawn_character_to_pool(faction, "names_name_2147360555", "names_name_2147360560", "", "", 18, true, "general", "wh2_main_hef_prince_alastar", true, "")
        cm:set_saved_value("v_" .. "wh2_main_hef_prince_alastar" .. "_LL_unlocked", true)
        ancillaryOnRankUp(alastar_quests, "wh2_main_hef_prince_alastar")
    else
        for i = 1, 10 do
            cm:create_force(
                faction,
                "wh_main_dwf_inf_hammerers",
                factionCA:home_region():name(),
                x,
                y,
                false,
                function(cqi)
                    local char = cm:get_character_by_cqi(cqi)
                    if char:character_subtype(subtype) then
                        cm:set_saved_value(subtype.."_spawned", faction) 
                    end
                    cm:kill_character(cqi, true, false)
                    cm:stop_character_convalescing(cqi)
                end
            )
        end
    end
end

--v function(faction: string)
local function spawnMissingLords(faction)
    local ai_starting_generals = {
		{["id"] = "2140784160",	["forename"] = "names_name_2147358917",	["faction"] = "wh_main_dwf_dwarfs", ["subtype"] = "pro01_dwf_grombrindal"},			            -- Grombrindal
		{["id"] = "2140783606",	["forename"] = "names_name_2147345906",	["faction"] = "wh_main_grn_greenskins", ["subtype"] = "grn_azhag_the_slaughterer"},		        -- Azhag the Slaughterer
		{["id"] = "2140784146",	["forename"] = "names_name_2147358044",	["faction"] = "wh_main_vmp_vampire_counts", ["subtype"] = "dlc04_vmp_helman_ghorst"},	        -- Helman Ghorst
        {["id"] = "2140784202",	["forename"] = "names_name_2147345124",	["faction"] = "wh_main_vmp_schwartzhafen", ["subtype"] = "pro02_vmp_isabella_von_carstein"},    -- Isabella von Carstein
        {["id"] = "1065845653",	["forename"] = "",	["faction"] = "wh2_main_hef_eataine", ["subtype"] = "wh2_main_hef_prince_alastar"}                                  -- Alastar
    } --:vector<map<string, string>>
    
	local factionCA = cm:get_faction(faction)
	for i = 1, #ai_starting_generals do
		local aiFaction = cm:get_faction(ai_starting_generals[i].faction)
		
		if aiFaction and not aiFaction:is_human() and aiFaction:subculture() == factionCA:subculture() then
            if ai_starting_generals[i].subtype == "wh2_main_hef_prince_alastar" then 
                if cm:model():campaign_name("main_warhammer") then
                    cm:lock_starting_general_recruitment(ai_starting_generals[i].id, ai_starting_generals[i].faction)
                else
                    cm:lock_starting_general_recruitment("2140785181", ai_starting_generals[i].faction)
                end
            else
                cm:unlock_starting_general_recruitment(ai_starting_generals[i].id, ai_starting_generals[i].faction)
            end
            spamLords(ai_starting_generals[i].subtype, ai_starting_generals[i].faction)
		end
    end
end

--v function(faction: string, regionList: CA_REGION_LIST, x: number, y: number, army: string)
local function reviveFaction(faction, regionList, x, y, army)
    local subculture = cm:get_faction(faction):subculture()
    local startRegion = regionList:item_at(0)
    cm:create_force(
        faction,
        army,
        startRegion:name(),
        x,
        y,
        true,
        function(cqi)
            cm:callback(function()
                for i = 0, regionList:num_items() - 1 do
                    local currentRegion = regionList:item_at(i)
                    cm:transfer_region_to_faction(currentRegion:name(), faction)
                end
                end, 1
            )
        end
    )
end

--v function(subcultures_factions_table: map<string, vector<string>>)
local function remove_confed_penalties(subcultures_factions_table)
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

--v function(faction: string, lord_subtype: string)
local function lordEvent(faction, lord_subtype)
	cm:show_message_event(
		faction,
		"event_feed_strings_text_title_event_legendary_lord_available",
		"event_feed_strings_text_title_event_" .. lord_subtype .. "_LL_unlocked",
		"event_feed_strings_text_description_event_" .. lord_subtype .. "_LL_unlocked",
		true,
		EVENT_PICS[faction]
	)
end

--v function(confederator: CA_FACTION, confederated: CA_FACTION)
local function confed(confederator, confederated)
	reviveFaction(confederated)
	spawnMissingLords(confederated:name())
	cm:disable_event_feed_events(true, "", "wh_event_subcategory_diplomacy_treaty_broken", "")
    cm:force_confederation(confederator, confederated)
    cm:disable_event_feed_events(false, "", "wh_event_subcategory_diplomacy_treaty_broken", "")
    cm:disable_event_feed_events(true, "", "", "")
    deleteForce()
    cm:disable_event_feed_events(true, "", "", "")
	cm:callback(function() remove_confed_penalties(subcultures_factions) end, 1)
    if confederator:is_human() then lordEvent(confederator:name(), lord_subtype) end
end

function sm0_recruit_defeated()
	local human_factions = cm:get_human_factions()
	local factionP1 = cm:get_faction(human_factions[1])
	local factionP2
	if cm:is_multiplayer() then
		factionP2 = cm:get_faction(human_factions[2])
	end

    core:add_listener(
		"refugee_FactionTurnStart",
		"ScriptEventPlayerFactionTurnStart",
		true,
		function(context)
			local factionList = cm:model():world():faction_list()
			for i = 0, factionList:num_items() - 1 do
				local currentFaction = factionList:item_at(i)
				if currentFaction:is_dead() and not cm:get_saved_value("took_refuge_"..currentFaction:name()) then -- confederated?
					if not wh_faction_is_horde(currentFaction) then -- faction exceptions
						if currentFaction:subculture() == factionP1:subculture() and not factionP1:is_dead() then
                            if not cm:get_saved_value("factionP1") then
                                confed(factionP1, currentFaction)
                                if cm:is_multiplayer() and factionP1:subculture() == factionP2:subculture() then
                                    cm:set_saved_value("factionP1", true)
                                    cm:set_saved_value("factionP2", false)
                                end
                            end
                        elseif cm:is_multiplayer() and currentFaction:subculture() == factionP2:subculture() and not factionP2:is_dead() then
                            if not cm:get_saved_value("factionP2") then
                                confed(factionP2, currentFaction)
                                if cm:is_multiplayer() and factionP1:subculture() == factionP2:subculture() then
                                    cm:set_saved_value("factionP2", true)
                                    cm:set_saved_value("factionP1", false)                                
                                end
                            end
						else -- ai
							local subFactionList = currentFaction:factions_of_same_subculture()
							for j = 0, subFactionList:num_items() - 1 do
								local currentSubFaction = subFactionList:item_at(j)
								if not currentSubFaction:is_dead() then -- confederated?
                                    confed(currentSubFaction, currentFaction)
                                    break
								end
							end
						end
					end
				end
			end
		end,
		true
	)

--[[
	local subFactionList = context:faction():factions_of_same_subculture()
				for i = 0, subFactionList:num_items() - 1 do
					local currentSubFaction = subFactionList:item_at(i)
					if currentSubFaction:is_dead() and not cm:get_saved_value("took_refuge_"..currentSubFaction:name()) then -- confederated?
						-- optional mcm: fire dilemma based on currentFaction:diplomatic_standing_with(context:faction():name()) or context:faction():imperium_level()
							-- ai always takes refugees
							-- player option to take or refuse refugee lords
						-- revive faction
						-- force confed
						-- delete force
						-- remove effectbundle
						-- set saved value
					--elseif cm:get_saved_value("took_refuge_"..currentFaction:name()) then -- if mcm option allow for it
					--	cm:set_saved_value("took_refuge_"..currentFaction:name(), false)
					end
				end
--]]
	core:add_listener(
		"refugee_FactionTurnStart",
		"FactionJoinsConfederation",
		true,
		function(context)
			cm:set_saved_value("took_refuge_"..context:faction():name(), context:confederation():name())
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