local dilemma_key = "hkrul_emp_sec_dil"
local separatist_faction_key = "wh_main_emp_empire_separatists"
local reikland_faction_key = "wh_main_emp_empire"
local middenland_faction_key = "wh_main_emp_middenland"

--new and fancy Hans
local hans_details = {
    general_faction = separatist_faction_key,
    unit_list = "wh_main_emp_art_mortar,hkrul_emp_sec_halberd,wh_main_emp_inf_halberdiers,wh_main_emp_inf_halberdiers,wh_main_emp_inf_swordsmen,hkrul_mackensens_marauders,wh2_dlc13_emp_inf_archers_0,wh2_dlc13_emp_inf_archers_0,wh_main_emp_cav_outriders_0", -- unit keys from main_units table
    region_key = "",
    type = "general",																				-- Agent type
    subtype = "hkrul_emp_sec_hans",																	-- Agent subtype
    forename = "names_name_19051994006",															-- From local_en names table, Bernhoff the Butcher is now ruler of Reikland
    clanname = "",																					-- From local_en names table
    surname = "names_name_19051994005",																-- From local_en names table
    othername = "",																					-- From local_en names table
    is_faction_leader = true																		-- Bool for whether the general being replaced is the new faction leader
}

-- make hans "unique" once recruited by a faction other than the separatists
core:add_listener(
    "hkrul_CharacterCreated",
    "CharacterCreated",
    function(context)
        return context:character():character_subtype(hans_details.subtype)
    end,
    function(context)
        local character = context:character()
        local char_lookup_str = cm:char_lookup_str(character)     
        cm:callback(
            function()
                if not character:character_details():is_unique() then
                    cm:set_character_unique(char_lookup_str, true) --makes Hans a undisbandable "Legendary Lord"
                end
                --cm:set_character_immortality(char_lookup_str, true) --not needed since immortality is enabled in db
            end,
            0.1
        )
    end,
    true
)

-- make sure hans doesn't have the "wh3_main_bundle_character_restrict_experience_gain" EB
core:add_listener(
    "hkrul_CharacterTurnStart",
    "CharacterTurnStart",
    function(context)
        return context:character():character_subtype(hans_details.subtype)
    end,
    function(context)    
        local character = context:character()
        cm:callback(
            function()
                if character:has_effect_bundle("wh3_main_bundle_character_restrict_experience_gain") then
                    cm:remove_effect_bundle_from_character("wh3_main_bundle_character_restrict_experience_gain", character)
                end
            end,
            0.1
        )
    end,
    true
)

local function spawn_hans_to_pool(faction_key)
    --backup for when hans vanishes for whatever god-forsaken reason
    local faction = cm:get_faction(faction_key)
    local char_list = faction:character_list()
    local hans_found = false
    for i = 0, char_list:num_items() - 1 do 
        local char = char_list:item_at(i)
        out("char:character_subtype_key() : "..char:character_subtype_key())
        if char:character_subtype_key() == "hkrul_emp_sec_hans" then 
            out("hkrul_emp_sec_hans found!")
            hans_found = true
        end
    end
    if not hans_found then
        cm:spawn_character_to_pool(
            faction:name(),
            hans_details.forename,
            hans_details.surname,
            hans_details.clanname,
            hans_details.othername,
            30,
            true,
            hans_details.type,
            hans_details.subtype,
            true,
            ""
        )
    end
end

local function process_dilemma_choice(choice)
    -- delay decision by 15 turns
    if choice == 2 then
        cm:set_saved_value("hkrul_emp_sec_dilemma_delay", cm:model():turn_number() + 15)
        return
    end

    core:remove_listener("hkrul_emp_sec_DilemmaChoiceMadeEvent")
    core:remove_listener("hkrul_emp_sec_FactionTurnStart")

    cm:set_saved_value("hkrul_emp_sec_dilemma_finished", true)
    -- disable legendary difficulty autosave (not sure this is still needed in wh3)
    --if cm:model():difficulty_level() == -3 then cm:disable_saving_game(true) end
    -- hide event messages and 
    cm:disable_event_feed_events(true, "", "", "faction_joins_confederation")
    cm:disable_event_feed_events(true, "", "", "diplomacy_faction_destroyed")
    cm:disable_event_feed_events(true, "", "", "diplomacy_faction_encountered")
    cm:disable_event_feed_events(true, "", "", "diplomacy_trespassing")
    cm:disable_event_feed_events(true, "", "wh_event_subcategory_character_deaths", "")

    local separatist_faction = cm:get_faction(separatist_faction_key)
    if separatist_faction and separatist_faction:was_confederated() then
        out("ERROR: Separatists have already been confederated!")
        return
    end

    if choice == 1 then	
        -- confederate with reikland
        --out("force_confederation: "..reikland_faction_key.." | "..separatist_faction_key)
        --cm:force_confederation(reikland_faction_key, separatist_faction_key)
        out("spawn_hans: "..reikland_faction_key)
        spawn_hans_to_pool(reikland_faction_key) 
    elseif choice == 3 then
        -- confederate with middenland
        local middenland_faction = cm:get_faction(middenland_faction_key)
        if middenland_faction and not middenland_faction:is_dead() then
            --out("force_confederation: "..middenland_faction_key.." | "..separatist_faction_key)
            --cm:force_confederation(middenland_faction_key, separatist_faction_key) 
            out("spawn_hans_to_pool: "..middenland_faction_key)
            spawn_hans_to_pool(middenland_faction_key)
        else
            -- find the faction Hans is most likely to join if middenland is dead(the faction will the worst relations with reikland)
            local empire_factions_by_standing = {}
            local empire_faction_list = reikland_faction:factions_of_same_subculture()
            for i = 0, empire_faction_list:num_items() - 1 do
                local empire_faction = empire_faction_list:item_at(i)
                if empire_faction and not empire_faction:is_dead() then
                    local standing = reikland_faction:diplomatic_standing_with(empire_faction:name())
                    table.insert(empire_factions_by_standing, {standing = standing + 0.001 * i, name = empire_faction:name()})
                end
            end
            -- messes up the previous table order if more than one key has an equal relation number
            table.sort(empire_factions_by_standing, function(a,b) return tonumber(a.standing) < tonumber(b.standing) end)
            if #empire_factions_by_standing > 0 then
                --out("force_confederation: "..empire_factions_by_standing[1].." | "..separatist_faction_key)
                --cm:force_confederation(empire_factions_by_standing[1], separatist_faction_key) 
                out("spawn_hans_to_pool: "..empire_factions_by_standing[1])
                spawn_hans_to_pool(empire_factions_by_standing[1])
            end
        end
    end

    ---- let's stop using confederations to
    ---- revive separatists (for future confederation)
    --local reikland_faction =  cm:get_faction(reikland_faction_key)
    --local start_region
    --local x, y
    --if reikland_faction:has_home_region() then 
    --    start_region = reikland_faction:home_region()
    --    x, y = cm:find_valid_spawn_location_for_character_from_settlement(reikland_faction_key, start_region:name(), false, true, 9)
    --else
    --    -- backup in case reikland has no settlements left
    --    if not reikland_faction:military_force_list():item_at(0):general_character():is_at_sea() and reikland_faction:military_force_list():item_at(0):general_character():has_region() then
    --        start_region = reikland_faction:military_force_list():item_at(0):general_character():region() 
    --    else
    --        out("ERROR: Could not find valid region!")
    --        return
    --    end
    --end
    ---- backup in case no valid spawn location found  
    --if not (is_number(x) and is_number(y) and x ~= -1 and y ~= -1) or not reikland_faction:has_home_region() then
    --    local char_lookup = cm:char_lookup_str(reikland_faction:military_force_list():item_at(0):general_character())
    --    x, y = cm:find_valid_spawn_location_for_character_from_character(reikland_faction:name(), char_lookup, true, 9)
    --end
    --if (is_number(x) and is_number(y) and x ~= -1 and y ~= -1) and start_region then 
    --    cm:create_force_with_general( --create_force_with_general instead of create_force, because the latter sometimes doesn't work for no apparent reason
    --        separatist_faction:name(), 
    --        "wh2_main_hef_inf_spearmen_0", 
    --        start_region:name(), 
    --        x, 
    --        y, 
    --        "general", 
    --        "wh3_prologue_general_test", 
    --        "dummy_forename", 
    --        "", 
    --        "", 
    --        "", 
    --        false, 
    --        function(cqi)
    --            local faction_leader_cqi = separatist_faction:faction_leader():command_queue_index()
    --            local char_list = separatist_faction:character_list()
    --            for i = 0, char_list:num_items() - 1 do 
    --                local char = char_list:item_at(i)
    --                local command_queue_index = char:command_queue_index()
    --                -- "Kill the Secessionist General" choice: kill all characters besides the dummy general
    --                if choice == 0 and command_queue_index ~= cqi and (char:is_agent() or char:is_general()) then 
    --                    cm:kill_character(command_queue_index, true) 
    --                end
    --                if char:character_subtype_key() == "hkrul_emp_sec_hans" then out("hkrul_emp_sec_hans found!") end
    --            end
    --            if choice == 0 then
    --                if cqi and cm:get_character_by_cqi(cqi) then 
    --                    cm:callback(function() 
    --                        cm:kill_character(cqi, true) 
    --                    end, 0.1) --let's add a bit of delay to make sure the faction isn't deleted before the last character is killed
    --                end
    --            end
    --            if choice == 1 or choice == 3 then
    --                core:add_listener(
    --                    "hkrul_process_dilemma_choice_FactionJoinsConfederation",
    --                    "FactionJoinsConfederation",
    --                    function(context)
    --                        return context:faction():name() == separatist_faction:name()
    --                    end,
    --                    function(context)
    --                        local confederation_faction = context:confederation()
    --                        -- remove confederation penalty
    --                        cm:callback(function() 
    --                            if confederation_faction:has_effect_bundle("wh_main_bundle_confederation_emp") then 
    --                                cm:remove_effect_bundle("wh_main_bundle_confederation_emp", confederation_faction:name()) 
    --                            end 
    --                        end, 0.1)
    --                        -- some faction leaders need a immortality reset after confederation (not sure Hans needs it, but better safe than sorry)
    --                        --cm:set_character_immortality(cm:char_lookup_str(faction_leader_cqi), true) 
    --                        -- kill dummy lord
    --                        if cqi and cm:get_character_by_cqi(cqi) then cm:kill_character(cqi, true) end
    --                        --prolly not needed for empire factions
    --                        --cm:force_diplomacy(confederation_faction:name(), "culture:"..confederation_faction:culture(), "form confederation", false, false, false, false)
--
    --                        --backup for when hans vanishes for whatever god-forsaken reason
    --                        local char_list = confederation_faction:character_list()
    --                        local hans_found = false
    --                        for i = 0, char_list:num_items() - 1 do 
    --                            local char = char_list:item_at(i)
    --                            out("char:character_subtype_key() : "..char:character_subtype_key())
    --                            if char:character_subtype_key() == "hkrul_emp_sec_hans" then 
    --                                out("hkrul_emp_sec_hans found!")
    --                                hans_found = true
    --                            end
    --                        end
    --                        if not hans_found then
    --                            cm:spawn_character_to_pool(
    --                                confederation_faction:name(),
    --                                hans_details.forename,
    --                                hans_details.surname,
    --                                hans_details.clanname,
    --                                hans_details.othername,
    --                                30,
    --                                true,
    --                                hans_details.type,
    --                                hans_details.subtype,
    --                                true,
    --                                ""
    --                            )
    --                        end
    --                    end,
    --                    false
    --                )
    --                if choice == 1 then	
    --                    -- confederate with reikland
    --                    out("force_confederation: "..reikland_faction_key.." | "..separatist_faction_key)
    --                    cm:force_confederation(reikland_faction_key, separatist_faction_key) 
    --                elseif choice == 3 then
    --                    -- confederate with middenland
    --                    local middenland_faction = cm:get_faction(middenland_faction_key)
    --                    if middenland_faction and not middenland_faction:is_dead() then
    --                        out("force_confederation: "..middenland_faction_key.." | "..separatist_faction_key)
    --                        cm:force_confederation(middenland_faction_key, separatist_faction_key) 
    --                    else
    --                        -- find the faction Hans is most likely to join if middenland is dead(the faction will the worst relations with reikland)
    --                        local empire_factions_by_standing = {}
    --                        local empire_faction_list = reikland_faction:factions_of_same_subculture()
    --                        for i = 0, empire_faction_list:num_items() - 1 do
    --                            local empire_faction = empire_faction_list:item_at(i)
    --                            if empire_faction and not empire_faction:is_dead() then
    --                                local standing = reikland_faction:diplomatic_standing_with(empire_faction:name())
    --                                table.insert(empire_factions_by_standing, {standing = standing + 0.001 * i, name = empire_faction:name()})
    --                            end
    --                        end
    --                        -- messes up the previous table order if more than one key has an equal relation number
    --                        table.sort(empire_factions_by_standing, function(a,b) return tonumber(a.standing) < tonumber(b.standing) end)
    --                        if #empire_factions_by_standing > 0 then
    --                            out("force_confederation: "..empire_factions_by_standing[1].." | "..separatist_faction_key)
    --                            cm:force_confederation(empire_factions_by_standing[1], separatist_faction_key) 
    --                        end
    --                    end
    --                end
    --            end
    --        end,
    --        false
    --    )    
    --end
    --cm:callback(function() 
    --    --re-enable event messages
    --    cm:disable_event_feed_events(false, "", "", "diplomacy_trespassing")                
    --    cm:disable_event_feed_events(false, "", "wh_event_subcategory_character_deaths", "")   
    --    cm:disable_event_feed_events(false, "", "", "diplomacy_faction_destroyed")
    --    cm:disable_event_feed_events(false, "", "", "faction_joins_confederation")
    --    cm:disable_event_feed_events(false, "", "", "diplomacy_faction_encountered")
    --    --force an autosave and re-enable legendary difficulty autosaves (gotta test if this is still needed)
    --    --if cm:model():difficulty_level() == -3 then 
    --    --    cm:disable_saving_game(false) 
    --    --    cm:autosave_at_next_opportunity()
    --    --end 
    --end, 3)
end


local function hkrul_emp_sec()
	local reikland_faction =  cm:get_faction(reikland_faction_key)
    local separatist_faction = cm:get_faction(separatist_faction_key)

	if reikland_faction and reikland_faction:is_human() and not cm:get_saved_value("hkrul_emp_sec_dilemma_finished") then
		core:add_listener(
			"hkrul_emp_sec_FactionTurnStart",
			"FactionTurnStart",
			function(context)
				return cm:model():turn_number() >= 2 and context:faction():name() == reikland_faction_key and separatist_faction and separatist_faction:is_dead()
                and (not cm:get_saved_value("hkrul_emp_sec_dilemma_delay") or cm:model():turn_number() >= cm:get_saved_value("hkrul_emp_sec_dilemma_delay"))
			end,
			function(context)
				--trigger dilemma
				cm:trigger_dilemma(reikland_faction_key, dilemma_key)
			end,
			true
		)
		core:add_listener(
			"hkrul_emp_sec_DilemmaChoiceMadeEvent",
			"DilemmaChoiceMadeEvent",
			function(context)
				return context:dilemma() == dilemma_key
			end,
			function(context)
                process_dilemma_choice(context:choice())
			end,
			true
		)
	end

	-- Script by Aexrael Dex
	-- Replaces the starting general for a specific faction
	if cm:is_new_game() then
        cm:callback(
			function() 
                if separatist_faction:is_null_interface() == false and separatist_faction:is_dead() == false then
                    local general_x_pos, general_y_pos = cm:find_valid_spawn_location_for_character_from_settlement(hans_details.general_faction, separatist_faction:home_region():name(), false, true, 8)
                    out(separatist_faction_key .. " home region name is " .. hans_details.region_key)

                    -- Creating replacement for old (generic) Hans with new and fancy Hans
                    cm:create_force_with_general(
                        hans_details.general_faction,
                        hans_details.unit_list,
                        separatist_faction:home_region():name(),
                        general_x_pos,
                        general_y_pos,
                        hans_details.type,
                        hans_details.subtype,
                        hans_details.forename,
                        hans_details.clanname,
                        hans_details.surname,
                        hans_details.othername,
                        hans_details.is_faction_leader,
                        function(cqi)
                            local char_str = cm:char_lookup_str(cqi)
                            cm:set_character_unique(char_str, true) --makes Hans a undisbandable "Legendary Lord"
                            --cm:set_character_immortality(char_str, true) --not needed since immortality is enabled in db
                        end
                    )
                    out("Created replacement Lord " .. hans_details.forename .. " for " .. separatist_faction_key)

                    -- Killing old (generic) Hans permanently
                    local char_list = separatist_faction:character_list()
                    local char_subtype = "wh_main_emp_lord" -- old (generic) Hans's agent subtype
                    local char_forename = "names_name_2147344121" -- old (generic) Hans's forename

                    for i = 0, char_list:num_items() - 1 do
                        local current_char = char_list:item_at(i)
                        local char_str = cm:char_lookup_str(current_char)

                        if current_char:is_null_interface() == false and current_char:character_subtype_key() == char_subtype and current_char:get_forename() == char_forename and current_char:has_military_force() == true then
                            cm:set_character_immortality(char_str, false)
                            cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
                            cm:kill_character(current_char:command_queue_index(), true, true)
                            cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 0.5)
                            out("Killing original " .. char_subtype .. " with forename " .. char_forename .. " for " .. separatist_faction_key .. " permanently")
                        end
                    end
                end
            end, 0.1 --delay to make sure this runs after wh2_campaign_custom_starts.lua
        )
	end
end

cm:add_first_tick_callback(function() hkrul_emp_sec() end)

local function add_custom_ror()
    -- Easy data table for faction info and unit info

    local ror_table = { -- A table of many RoR's ---- BEGIN REWRITE
        { -- This is the first RoR we wish to spawn
            faction_key = "wh_main_vmp_schwartzhafen", -- The faction we're adding this RoR to; from `factions`
            unit_key = "wh2_dlc11_cst_inf_zombie_deckhands_mob_ror_0", -- The unit key; from `main_units`
            merc_pool = "renown", -- The mercenary pool we're adding this RoR to; from `recruitment_sources`
            merc_group = "wh2_dlc11_cst_inf_zombie_deckhands_mob_ror_0", -- The mercenary pool group this unit belongs to; in `mercenary_unit_groups`
            count = 1, -- The number of RoRs we're adding; this will be 1 by default, only put this line if you're seeking to change the number added
        }, -- and you can make a new table for each other RoR you're seeking to add!
    } -- Closing out the ror_table variable!

    ---- END REWRITE.

    -- List of default values to shove into the function before; shouldn't need to be changed, usecase may vary.
    local defaults = {
        replen_chance = 100,
        max = 1,
        max_per_turn = 0.1,
        xp_level = 0,
        faction_restriction = "", 
        subculture_restriction = "",
        tech_restriction = "",
        partial_replenishment = true,
    }

    for i, ror in pairs(ror_table) do
        local faction_key, unit_key = ror.faction_key, ror.unit_key
        local merc_pool, merc_group = ror.merc_pool, ror.merc_group
        local count = ror.count or 1 -- if ror.count is undefined, we'll just use the default of 1!

        local faction = cm:get_faction(faction_key)
        if faction then
            cm:add_unit_to_faction_mercenary_pool(
                faction,
                unit_key,
                merc_pool,
                count,
                defaults.replen_chance,
                defaults.max,
                defaults.max_per_turn,
                defaults.faction_restriction,
                defaults.subculture_restriction,
                defaults.tech_restriction,
                defaults.partial_replenishment,
                merc_group
            )
        end
    end
end

cm:add_first_tick_callback(function()
    core:call_once(
        "my_custom_function", -- RENAME this to a unique string; this is what the game uses to determine if the below code has been run before, must be unique per instance!
        add_custom_ror -- Run the above function, rename if you've changed the name of the function above!
    ) 
end);