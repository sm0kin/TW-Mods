local pirate_factions = {
    "wh2_dlc11_cst_harpoon_the_sunken_land_corsairs",
    "wh2_dlc11_cst_rogue_bleak_coast_buccaneers",
    "wh2_dlc11_cst_rogue_freebooters_of_port_royale",
    "wh2_dlc11_cst_rogue_grey_point_scuttlers",
    "wh2_dlc11_cst_rogue_terrors_of_the_dark_straights",
    "wh2_dlc11_cst_rogue_the_churning_gulf_raiders",
    "wh2_dlc11_cst_rogue_tyrants_of_the_black_ocean",
    "wh2_dlc11_cst_shanty_dragon_spine_privateers",
    "wh2_dlc11_cst_shanty_middle_sea_brigands",
    "wh2_dlc11_cst_shanty_shark_straight_seadogs"
}

local function apply_diplomacy()
    local faction_list = cm:model():world():faction_list()
        for i = 0, faction_list:num_items() - 1 do
            local current_target_faction = faction_list:item_at(i)
            local current_target_faction_culture = current_target_faction:culture()

            if not current_target_faction:is_dead() and not pirate_factions then
                local current_target_faction_name = current_target_faction:name()
                out(" Forcing war between [" .. pirate_factions .. "] and [" .. hates_pirates_cultures .. "]")
                cm:force_declare_war(pirate_factions, hates_pirates_cultures, false, false)
                cm:force_diplomacy(
                    "faction:" .. pirate_factions,
                    "faction:" .. hates_pirates_cultures,
                    "peace",
                    false,
                    false,
                    true
                )
            end
        end
    end
end

function hostile_pirates()
    core:add_listener(
        "sm0_refugee_FactionTurnEnd",
        "FactionTurnEnd",
        function(context)
            local human_faction = cm:get_faction(cm:get_human_factions()[1])
            return table_contains(pirate_factions, context:faction():name()) and not context:faction():at_war_with(human_faction)
        end,
        function(context)
            apply_diplomacy(context:faction())
        end,
        true
    )
    if cm:is_new_game() then
        apply_diplomacy(context:faction())
    end
    

end

cm:get_saved_value("hostile_pirates")
