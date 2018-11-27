--award_experience_level
--add_unit_experience -- invasion


--some code

local event_pics_from_subculture = {
    ["wh2_dlc11_cst_vampire_coast"] = 786,
    ["wh2_dlc11_cst_noctilus"] = 785,
    ["wh2_dlc11_cst_pirates_of_sartosa"] = 783,
    ["wh2_dlc11_cst_the_drowned"] = 784
}

function v_give_exp(faction_name)
    current_faction = cm:get_faction(faction_name);

    local char_list = current_faction:character_list();

    for i = 0, char_list:num_items() - 1 do
        out("viemzee2");
        out(i);
        local current_char = char_list:item_at(i);
        out(current_char);
        out(current_char:cqi());
        out(cm:char_lookup_str(current_char:cqi()));
        cm:add_agent_experience(cm:char_lookup_str(current_char:cqi()), 66700);
    end;
end

function v_faction_defeated(faction_name)
    current_faction = cm:get_faction(faction_name);

    local current_faction_regions = current_faction:region_list();
    local char_list = current_faction:character_list();

    if current_faction_regions:num_items() == 0 and char_list:num_items() == 0 then
        return true;
    else
        return false;
    end;
end

function trigger_check_VC_subculture_state()
    out("viemzee : FUNC trigger_check_VC_subculture_state START");

    local playerFaction = cm:get_faction(cm:get_local_faction(true));
    local world = cm:model():world();

    if not cm:get_saved_value("wh2_dlc11_cst_vampire_coast_LL_unlocked") then 
        if v_faction_defeated("wh2_dlc11_cst_vampire_coast") then
            cm:set_saved_value("wh2_dlc11_cst_vampire_coast_LL_unlocked", true);
            cm:spawn_character_to_pool(playerFaction:name(), "names_name_1270751732", "", "", "", 18, true, "general", "wh2_dlc11_cst_harkon", true, "");    
            cm:show_message_event(
                playerFaction:name(),
                "event_feed_strings_text_title_event_wh2_dlc11_cst_vampire_coast_LL_unlocked",
                "event_feed_strings_text_title_event_wh2_dlc11_cst_vampire_coast_LL_unlocked",
                "event_feed_strings_text_description_event_wh2_dlc11_cst_vampire_coast_LL_unlocked",
                true,
                event_pics_from_subculture[playerFaction:name()]
                );
            out("viemzee : wh2_dlc11_cst_vampire_coast_LL_unlocked");
        end;
    end;

    if not cm:get_saved_value("wh2_dlc11_cst_noctilus_LL_unlocked") then 
        if v_faction_defeated("wh2_dlc11_cst_noctilus") then
            cm:set_saved_value("wh2_dlc11_cst_noctilus_LL_unlocked", true);
            cm:spawn_character_to_pool(playerFaction:name(), "names_name_227765640", "", "", "", 18, true, "general", "wh2_dlc11_cst_noctilus", true, "");    
            cm:show_message_event(
                playerFaction:name(),
                "event_feed_strings_text_title_event_wh2_dlc11_cst_noctilus_LL_unlocked",
                "event_feed_strings_text_title_event_wh2_dlc11_cst_noctilus_LL_unlocked",
                "event_feed_strings_text_description_event_wh2_dlc11_cst_noctilus_LL_unlocked",
                true,
                event_pics_from_subculture[playerFaction:name()]
                );
            out("viemzee : wh2_dlc11_cst_noctilus_LL_unlocked");
        end;
    end;    

    if not cm:get_saved_value("wh2_dlc11_cst_the_drowned_LL_unlocked") then 
        if v_faction_defeated("wh2_dlc11_cst_the_drowned") then
            cm:set_saved_value("wh2_dlc11_cst_the_drowned_LL_unlocked", true);
            cm:spawn_character_to_pool(playerFaction:name(), "names_name_143098456", "names_name_758220496", "", "", 18, true, "general", "wh2_dlc11_cst_cylostra", true, "");    
            cm:show_message_event(
                playerFaction:name(),
                "event_feed_strings_text_title_event_wh2_dlc11_cst_the_drowned_LL_unlocked",
                "event_feed_strings_text_title_event_wh2_dlc11_cst_the_drowned_LL_unlocked",
                "event_feed_strings_text_description_event_wh2_dlc11_cst_the_drowned_LL_unlocked",
                true,
                event_pics_from_subculture[playerFaction:name()]
                );
            out("viemzee : wh2_dlc11_cst_the_drowned_LL_unlocked");
        end;
    end;    

    if not cm:get_saved_value("wh2_dlc11_cst_pirates_of_sartosa_unlocked") then 
        if v_faction_defeated("wh2_dlc11_cst_pirates_of_sartosa") then
            cm:set_saved_value("wh2_dlc11_cst_pirates_of_sartosa_unlocked", true);
            cm:spawn_character_to_pool(playerFaction:name(), "names_name_1340289195", "names_name_250811476", "", "", 18, true, "general", "wh2_dlc11_cst_aranessa", true, "");    
            cm:show_message_event(
                playerFaction:name(),
                "event_feed_strings_text_title_event_wh2_dlc11_cst_pirates_of_sartosa_unlocked",
                "event_feed_strings_text_title_event_wh2_dlc11_cst_pirates_of_sartosa_unlocked",
                "event_feed_strings_text_description_event_wh2_dlc11_cst_pirates_of_sartosa_unlocked",
                true,
                event_pics_from_subculture[playerFaction:name()]
                );
            out("viemzee : wh2_dlc11_cst_pirates_of_sartosa_unlocked");
        end;
    end;    

    out("viemzee : FUNC trigger_check_VC_subculture_state END");
end;

function player_is_VCoast()
    local playerFaction = cm:get_faction(cm:get_local_faction(true));

    out("viemzee : FUNC player_is_VC START");
    out(playerFaction:name());

    if playerFaction:name() == "wh2_dlc11_cst_vampire_coast" or  playerFaction:name() == "wh2_dlc11_cst_noctilus" or playerFaction:name() == "wh2_dlc11_cst_the_drowned" or playerFaction:name() == "wh2_dlc11_cst_pirates_of_sartosa" then
        out(true);
        trigger_check_VC_subculture_state();
    else
        out(false);
    end

    out("viemzee : FUNC player_is_VC END");

end;

function init()
    out("viemzee : init 1128");
    core:add_listener(
		"trigger_player_faction_turn_start_interventions",
		"ScriptEventPlayerFactionTurnStart",
		true,
        function()
            player_is_VCoast();
		end,
		true
	);

end

init();

--Supreme_vauls_anvil
function Supreme_vauls_anvil()	
	local human_factions = cm:get_human_factions();
	for i = 1, #human_factions do
		local current_human_faction = cm:get_faction(human_factions[i]);
		if current_human_faction:culture() == "wh2_main_hef_high_elves" then
			if current_human_faction:name() == "wh2_main_hef_avelorn" or current_human_faction:name() ==  "wh2_main_hef_eataine" or current_human_faction:name() == "wh2_main_hef_nagarythe" or current_human_faction:name() == "wh2_main_hef_order_of_loremasters" then
				supreme_human_hef_faction = true;		
			end;
		end;
	end;
	if supreme_human_hef_faction == true and not cm:get_saved_value("supreme_forge_one") then
        cm:faction_add_pooled_resource("wh2_main_hef_avelorn", "tmb_canopic_jars", "wh2_main_resource_factor_other", 9999);
        cm:faction_add_pooled_resource("wh2_main_hef_eataine", "tmb_canopic_jars", "wh2_main_resource_factor_other", 9999);
        cm:faction_add_pooled_resource("wh2_main_hef_nagarythe", "tmb_canopic_jars", "wh2_main_resource_factor_other", 9999);
        cm:faction_add_pooled_resource("wh2_main_hef_order_of_loremasters", "tmb_canopic_jars", "wh2_main_resource_factor_other", 9999);
		cm:set_saved_value("supreme_forge_one", true);		
	end;
end;

cm.first_tick_callbacks[#cm.first_tick_callbacks+1] = 
function(context) 
	Supreme_vauls_anvil();
	return true;
end;