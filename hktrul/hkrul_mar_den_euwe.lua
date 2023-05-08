
local deneuwe_faction_key = "ovn_mar_house_den_euwe"
--new and fancy Jaan
local egmond_details = {
    general_faction = deneuwe_faction_key,
    unit_list = "hkrul_mar_inf_boogschutter", -- unit keys from main_units table
    region_key = "",
    type = "general",																				-- Agent type
    subtype = "hkrul_mar_egmond",																	-- Agent subtype
    forename = "names_name_605123616",															-- From local_en names table, Bernhoff the Butcher is now ruler of Reikland
    clanname = "",																					-- From local_en names table
    surname = "names_name_605123615",																-- From local_en names table
    othername = "",																					-- From local_en names table
    is_faction_leader = true																		-- Bool for whether the general being replaced is the new faction leader
}

core:add_listener(
    "hkrul_egmond_CharacterTurnStart",
    "CharacterTurnStart",
    function(context)
        return context:character():character_subtype(egmond_details.subtype)
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

-- Replaces the starting general for a specific faction
local function hkrul_den_euwe()
	if cm:is_new_game() then
        cm:callback(
			function() 
                local deneuwe_faction = cm:get_faction(deneuwe_faction_key)
                if deneuwe_faction:is_null_interface() == false and deneuwe_faction:is_dead() == false then

                    local x, y = 1336, 510
                    --x, y  = cm:find_valid_spawn_location_for_character_from_settlement(deneuwe_faction_key, "wh3_main_combi_region_fu_chow", false, true, 8)

                    -- Shaping starting setup
                    local fu_chow_region = cm:get_region("wh3_main_combi_region_fu_chow")
                    cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "")
                    cm:transfer_region_to_faction("wh3_main_combi_region_fu_chow", deneuwe_faction_key)
                    local fu_chow_cqi = fu_chow_region:cqi()
                    cm:heal_garrison(fu_chow_cqi)
                    local previous_leader_cqi = deneuwe_faction:faction_leader():cqi()
                    -- replace previous leader with new one
                    cm:create_force_with_general(
                        egmond_details.general_faction,
                        egmond_details.unit_list,
                        deneuwe_faction:home_region():name(),
                        x,
                        y,
                        egmond_details.type,
                        egmond_details.subtype,
                        egmond_details.forename,
                        egmond_details.clanname,
                        egmond_details.surname,
                        egmond_details.othername,
                        egmond_details.is_faction_leader,
                        function(cqi)
                            local char_str = cm:char_lookup_str(cqi)
                            cm:set_character_unique(char_str, true)

                            --kill previous leader and dummy force leader
                            cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
                            local previous_leader_str = cm:char_lookup_str(previous_leader_cqi)
                            cm:set_character_immortality(previous_leader_str, false)
                            cm:kill_character(previous_leader_str, true)
                            cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 0.5)
                        end
                    )
                    cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "") end, 0.5)
                end
            end, 0.1 --delay to make sure this runs after wh2_campaign_custom_starts.lua
        )
	end
end


cm:add_first_tick_callback(function() hkrul_den_euwe() end)