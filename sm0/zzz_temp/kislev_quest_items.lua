function kislev_quest_items()
    if not vfs.exists("script/campaign/main_warhammer/mod/mixu_le_hertwig.lua") then
        local items = {
            {subtype = "mixu_katarin_the_ice_queen", item_name = "mixu_anc_enchanted_item_ksl_katarin_the_ice_queen_crystal_cloak", required_rank = 9},	
            {subtype = "mixu_katarin_the_ice_queen", item_name = "mixu_anc_weapon_ksl_katarin_the_ice_queen_fearfrost", required_rank = 15}	
        }
        for i = 1, #items do
            local current_subtype = items[i].subtype
            local current_item = items[i].item_name
            local current_rank_req = items[i].required_rank
            if not cm:get_saved_value("mixu_item_gained_"..current_item) then
                core:add_listener(
                    "mixu_item_listeners_"..current_item,
                    "CharacterTurnStart",
                    function(context)
                        local character = context:character()
                        return context:character():character_subtype(current_subtype) and context:character():rank() >= current_rank_req
                    end,
                    function(context)
                        local character = context:character()
                        local char_str = cm:char_lookup_str(character:command_queue_index())	
                        
                        if not cm:get_saved_value("mixu_item_gained_"..current_item) then
                            cm:set_saved_value("mixu_item_gained_"..current_item, true)
                            cm:force_add_ancillary(character, current_item, true, false)
                            cm:add_agent_experience(char_str, 1000)
                            core:remove_listener("mixu_item_listeners_"..current_item)
                            core:remove_listener("mixu_item_listeners_"..current_item.."_CharacterRankUp")
                        end
                    end,
                    true
                )
                core:add_listener(
                    "mixu_item_listeners_"..current_item.."_CharacterRankUp",
                    "CharacterRankUp",
                    function(context)
                        local character = context:character()
                        return context:character():character_subtype(current_subtype) and context:character():rank() >= current_rank_req
                    end,
                    function(context)
                        local character = context:character()
                        local char_str = cm:char_lookup_str(character:command_queue_index())	
                        
                        if not cm:get_saved_value("mixu_item_gained_"..current_item) then
                            cm:set_saved_value("mixu_item_gained_"..current_item, true)
                            cm:force_add_ancillary(character, current_item, true, false)
                            cm:add_agent_experience(char_str, 1000)
                            core:remove_listener("mixu_item_listeners_"..current_item)
                            core:remove_listener("mixu_item_listeners_"..current_item.."_CharacterRankUp")
                        end
                    end,
                    true
                )	
            end
        end
    end
end