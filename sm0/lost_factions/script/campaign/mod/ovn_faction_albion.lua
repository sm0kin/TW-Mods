local function setup_diplo()

local ovn_albion_anc_pool = {
"albion_hunting_dog",
"albion_lone_huntress",
"albion_woad_raider",
"albion_tame_raven",
"albion_druid_advisor",
"albion_chief",
"albion_old_warrior",
"albion_scavanger",
"albion_woman",
"fenbeast_follower",
"hearthguard_follower",
"druid_neophyte",
"albion_hardened_warrior",
"albion_scary_banner",
"anc_albion_triskele_banner",
"anc_danu_banner",
"anc_albion_hunter_banner",
"anc_albion_staff_of_light",
"anc_albion_talisman_triskele",
"anc_albion_hammer_giant",
"anc_albion_sun_shield",
"anc_hunter_spear",
"anc_dagger_shadow",
"anc_albion_chainmail",
"anc_albion_helmet_leader",
"anc_albion_talisman_danu",
"anc_albion_talisman_belakor",
"anc_albion_scepter_old_ones",
"anc_albion_staff_of_darkness",
"anc_albion_hound_statue",
"anc_albion_skull_trophies"
}

local random_number = cm:random_number(#ovn_albion_anc_pool, 1)
local anc_key = ovn_albion_anc_pool[random_number]

    core:add_listener(
     "albion_anc_random_drop",
     "CharacterTurnStart", 
     function(context)
    return context:character():faction():name() == "wh2_main_nor_albion" end, 
     function(context) 
        local random_number = cm:random_number(#ovn_albion_anc_pool, 1)
        local anc_key = ovn_albion_anc_pool[random_number]
        local current_char = context:character()
        if not current_char:character_type("colonel") then
        effect.ancillary(anc_key, 5, context)
        end
    end, 
    true)

    core:add_listener(
        "albion_anc_win_battle_drop", 
        "CharacterCompletedBattle", 
            function(context)
                local char = context:character()
                return context:character():faction():name() == "wh2_main_nor_albion" 
                and char:won_battle()  
                and not char:is_wounded()
                and not char:routed_in_battle()
            end,
            function(context)
                     effect.ancillary(anc_key, 8, context) 
                                                                          
            end,			
            true
            );
end

local function albion_init()
    setup_diplo()
end

cm:add_first_tick_callback(
    function()
        albion_init()
    end
)