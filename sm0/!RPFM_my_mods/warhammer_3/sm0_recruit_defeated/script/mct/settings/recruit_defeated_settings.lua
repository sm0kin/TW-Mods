if not get_mct then return end
local mct = get_mct()
local loc_prefix = "mct_recruit_defeated_"
local recruit_defeated = mct:register_mod("recruit_defeated")
recruit_defeated:set_title(loc_prefix.."mod_title", true)
recruit_defeated:set_author("Militus Immortalis & sm0kin")
recruit_defeated:set_description(loc_prefix.."mod_desc", true)

local enable = recruit_defeated:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."a_enable_txt", true)
enable:set_tooltip_text(loc_prefix.."a_enable_tt", true)

recruit_defeated:add_new_section("restrictions", loc_prefix.."section_restrictions", true)

local scope = recruit_defeated:add_new_option("c_scope", "dropdown")
scope:set_text(loc_prefix.."c_scope_txt", true)
scope:set_tooltip_text(loc_prefix.."c_scope_tt", true)
scope:add_dropdown_values({
    {key = "player_ai", text = "Player & AI", tt = "", default = true},
    {key = "player", text = "Player only", tt = "", default = false},
    {key = "ai", text = "AI only", tt = "", default = false},
})
--scope:add_dropdown_value("player_ai", "Player & AI", "")
--scope:add_dropdown_value("player", "Player only", "")
--scope:add_dropdown_value("ai", "AI only", "")

local ai_delay = recruit_defeated:add_new_option("d_ai_delay", "slider")
ai_delay:set_text(loc_prefix.."d_ai_delay_txt", true)
ai_delay:set_tooltip_text(loc_prefix.."d_ai_delay_tt", true)
ai_delay:slider_set_min_max(1, 550)
ai_delay:set_default_value(50)
ai_delay:slider_set_step_size(5)

recruit_defeated:add_new_section("preferences", loc_prefix.."section_preferences", true)

local preferance1 = recruit_defeated:add_new_option("a_preferance1", "dropdown")
preferance1:set_text(loc_prefix.."a_preferance1_txt", true)
preferance1:set_tooltip_text(loc_prefix.."a_preferance1_tt", true)
preferance1:add_dropdown_values({
    {key = "disable", text = "Disable", tt = "Preference Level-1 disabled.", default = false},
    {key = "player", text = "Player", tt = "Factions led by a Player will be prefered over AI factions.", default = false},
    {key = "ai", text = "AI", tt = "Factions led by the AI will be prefered over player-led factions.", default = false},
    {key = "major", text = "Major Factions", tt = "Playable Factions (Major) will be prefered over Minor factions.", default = false},
    {key = "minor", text = "Minor Factions", tt = "Minor Factions will be prefered over playable (Major) factions.", default = false},
    {key = "met", text = "Factions met", tt = "Defeated factions preferably join factions they they met before (discovered factions).", default = false},
    {key = "relation", text = "Relations", tt = "Defeated factions prefer to join factions they they had the best diplomatic relations with.", default = false},
    --{key = "alternate", text = "Dilemma alternates (MP only)", tt = "Dilemma alternates between Players of the same subculture (applies to MP only).", default = false},
    {key = "race", text = "same Race", tt = "Factions of the same race will be prefered over factions of a different race.", default = true},
})
--preferance1:add_dropdown_value("disable", "Disable", "Preference Level-1 disabled.")
--preferance1:add_dropdown_value("player", "Player", "Factions led by a Player will be prefered over AI factions.", true)
--preferance1:add_dropdown_value("ai", "AI", "Factions led by the AI will be prefered over player-led factions.")
--preferance1:add_dropdown_value("major", "Major Factions", "Playable Factions (Major) will be prefered over Minor factions.")
--preferance1:add_dropdown_value("minor", "Minor Factions", "Minor Factions will be prefered over playable (Major) factions")
--preferance1:add_dropdown_value("met", "Factions met", "Defeated factions preferably join factions they they met before (discovered factions).")
--preferance1:add_dropdown_value("relation", "Relations", "Defeated factions prefer to join factions they they had the best diplomatic relations with.")
--preferance1:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)")

local preferance2 = recruit_defeated:add_new_option("b_preferance2", "dropdown")
preferance2:set_text(loc_prefix.."b_preferance2_txt", true)
preferance2:set_tooltip_text(loc_prefix.."b_preferance2_tt", true)
preferance2:add_dropdown_values({
    {key = "disable", text = "Disable", tt = "Preference Level-2 disabled.", default = false},
    {key = "player", text = "Player", tt = "Factions led by a Player will be prefered over AI factions.", default = true},
    {key = "ai", text = "AI", tt = "Factions led by the AI will be prefered over player-led factions.", default = false},
    {key = "major", text = "Major Factions", tt = "Playable Factions (Major) will be prefered over Minor factions.", default = false},
    {key = "minor", text = "Minor Factions", tt = "Minor Factions will be prefered over playable (Major) factions.", default = false},
    {key = "met", text = "Factions met", tt = "Defeated factions preferably join factions they they met before (discovered factions).", default = false},
    {key = "relation", text = "Relations", tt = "Defeated factions prefer to join factions they they had the best diplomatic relations with.", default = false},
    --{key = "alternate", text = "Dilemma alternates (MP only)", tt = "Dilemma alternates between Players of the same subculture (applies to MP only).", default = false},
    {key = "race", text = "same Race", tt = "Factions of the same race will be prefered over factions of a different race.", default = false},
})
--preferance2:add_dropdown_value("disable", "Disable", "Preference Level-2 disabled.")
--preferance2:add_dropdown_value("player", "Player", "Factions led by a Player will be prefered over AI factions.")
--preferance2:add_dropdown_value("ai", "AI", "Factions led by the AI will be prefered over player-led factions.")
--preferance2:add_dropdown_value("major", "Major Factions", "Playable Factions (Major) will be prefered over Minor factions.")
--preferance2:add_dropdown_value("minor", "Minor Factions", "Minor Factions will be prefered over playable (Major) factions.")
--preferance2:add_dropdown_value("met", "Factions met", "Defeated factions preferably join factions they they met before (discovered factions).")
--preferance2:add_dropdown_value("relation", "Relations", "Defeated factions prefer to join factions they they had the best diplomatic relations with.")
--preferance2:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)", true)

local preferance3 = recruit_defeated:add_new_option("c_preferance3", "dropdown")
preferance3:set_text(loc_prefix.."c_preferance3_txt", true)
preferance3:set_tooltip_text(loc_prefix.."c_preferance3_tt", true)
preferance3:add_dropdown_values({
    {key = "disable", text = "Disable", tt = "Preference Level-3 disabled.", default = false},
    {key = "player", text = "Player", tt = "Factions led by a Player will be prefered over AI factions.", default = false},
    {key = "ai", text = "AI", tt = "Factions led by the AI will be prefered over player-led factions.", default = false},
    {key = "major", text = "Major Factions", tt = "Playable Factions (Major) will be prefered over Minor factions.", default = false},
    {key = "minor", text = "Minor Factions", tt = "Minor Factions will be prefered over playable (Major) factions.", default = false},
    {key = "met", text = "Factions met", tt = "Defeated factions preferably join factions they they met before (discovered factions).", default = true},
    {key = "relation", text = "Relations", tt = "Defeated factions prefer to join factions they they had the best diplomatic relations with.", default = false},
    --{key = "alternate", text = "Dilemma alternates (MP only)", tt = "Dilemma alternates between Players of the same subculture (applies to MP only).", default = false},
    {key = "race", text = "same Race", tt = "Factions of the same race will be prefered over factions of a different race.", default = false},
})
--preferance3:add_dropdown_value("disable", "Disable", "Preference Level-3 disabled.")
--preferance3:add_dropdown_value("player", "Player", "Factions led by a Player will be prefered over AI factions.")
--preferance3:add_dropdown_value("ai", "AI", "Factions led by the AI will be prefered over player-led factions.")
--preferance3:add_dropdown_value("major", "Major Factions", "Playable Factions (Major) will be prefered over Minor factions.")
--preferance3:add_dropdown_value("minor", "Minor Factions", "Minor Factions will be prefered over playable (Major) factions")
--preferance3:add_dropdown_value("met", "Factions met", "Defeated factions preferably join factions they they met before (discovered factions).", true)
--preferance3:add_dropdown_value("relation", "Relations", "Defeated factions prefer to join factions they they had the best diplomatic relations with.")
--preferance3:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)")

local preferance4 = recruit_defeated:add_new_option("d_preferance4", "dropdown")
preferance4:set_text(loc_prefix.."d_preferance4_txt", true)
preferance4:set_tooltip_text(loc_prefix.."d_preferance4_tt", true)
preferance4:add_dropdown_values({
    {key = "disable", text = "Disable", tt = "Preference Level-4 disabled.", default = false},
    {key = "player", text = "Player", tt = "Factions led by a Player will be prefered over AI factions.", default = false},
    {key = "ai", text = "AI", tt = "Factions led by the AI will be prefered over player-led factions.", default = false},
    {key = "major", text = "Major Factions", tt = "Playable Factions (Major) will be prefered over Minor factions.", default = false},
    {key = "minor", text = "Minor Factions", tt = "Minor Factions will be prefered over playable (Major) factions.", default = false},
    {key = "met", text = "Factions met", tt = "Defeated factions preferably join factions they they met before (discovered factions).", default = false},
    {key = "relation", text = "Relations", tt = "Defeated factions prefer to join factions they they had the best diplomatic relations with.", default = true},
    --{key = "alternate", text = "Dilemma alternates (MP only)", tt = "Dilemma alternates between Players of the same subculture (applies to MP only).", default = false},
    {key = "race", text = "same Race", tt = "Factions of the same race will be prefered over factions of a different race.", default = false},
})
--preferance4:add_dropdown_value("disable", "Disable", "Preference Level-4 disabled.")
--preferance4:add_dropdown_value("player", "Player", "Factions led by a Player will be prefered over AI factions.")
--preferance4:add_dropdown_value("ai", "AI", "Factions led by the AI will be prefered over player-led factions.")
--preferance4:add_dropdown_value("major", "Major Factions", "Playable Factions (Major) will be prefered over Minor factions.")
--preferance4:add_dropdown_value("minor", "Minor Factions", "Minor Factions will be prefered over playable (Major) factions")
--preferance4:add_dropdown_value("met", "Factions met", "Defeated factions preferably join factions they they met before (discovered factions).")
--preferance4:add_dropdown_value("relation", "Relations", "Defeated factions prefer to join factions they they had the best diplomatic relations with.", true)
--preferance4:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)")

local preferance5 = recruit_defeated:add_new_option("e_preferance5", "dropdown")
preferance5:set_text(loc_prefix.."e_preferance5_txt", true)
preferance5:set_tooltip_text(loc_prefix.."e_preferance5_tt", true)
preferance5:add_dropdown_values({
    {key = "disable", text = "Disable", tt = "Preference Level-5 disabled.", default = false},
    {key = "player", text = "Player", tt = "Factions led by a Player will be prefered over AI factions.", default = false},
    {key = "ai", text = "AI", tt = "Factions led by the AI will be prefered over player-led factions.", default = false},
    {key = "major", text = "Major Factions", tt = "Playable Factions (Major) will be prefered over Minor factions.", default = true},
    {key = "minor", text = "Minor Factions", tt = "Minor Factions will be prefered over playable (Major) factions.", default = false},
    {key = "met", text = "Factions met", tt = "Defeated factions preferably join factions they they met before (discovered factions).", default = false},
    {key = "relation", text = "Relations", tt = "Defeated factions prefer to join factions they they had the best diplomatic relations with.", default = false},
    --{key = "alternate", text = "Dilemma alternates (MP only)", tt = "Dilemma alternates between Players of the same subculture (applies to MP only).", default = false},
    {key = "race", text = "same Race", tt = "Factions of the same race will be prefered over factions of a different race.", default = false},
})
--preferance5:add_dropdown_value("disable", "Disable", "Preference Level-5 disabled.")
--preferance5:add_dropdown_value("player", "Player", "Factions led by a Player will be prefered over AI factions.")
--preferance5:add_dropdown_value("ai", "AI", "Factions led by the AI will be prefered over player-led factions.")
--preferance5:add_dropdown_value("major", "Major Factions", "Playable Factions (Major) will be prefered over Minor factions.", true)
--preferance5:add_dropdown_value("minor", "Minor Factions", "Minor Factions will be prefered over playable (Major) factions")
--preferance5:add_dropdown_value("met", "Factions met", "Defeated factions preferably join factions they they met before (discovered factions).")
--preferance5:add_dropdown_value("relation", "Relations", "Defeated factions prefer to join factions they they had the best diplomatic relations with.")
--preferance5:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)")

local preferance6 = recruit_defeated:add_new_option("f_preferance6", "dropdown")
preferance6:set_text(loc_prefix.."f_preferance6_txt", true)
preferance6:set_tooltip_text(loc_prefix.."f_preferance6_tt", true)
preferance6:add_dropdown_values({
    {key = "disable", text = "Disable", tt = "Preference Level-6 disabled.", default = true},
    {key = "player", text = "Player", tt = "Factions led by a Player will be prefered over AI factions.", default = false},
    {key = "ai", text = "AI", tt = "Factions led by the AI will be prefered over player-led factions.", default = false},
    {key = "major", text = "Major Factions", tt = "Playable Factions (Major) will be prefered over Minor factions.", default = false},
    {key = "minor", text = "Minor Factions", tt = "Minor Factions will be prefered over playable (Major) factions.", default = false},
    {key = "met", text = "Factions met", tt = "Defeated factions preferably join factions they they met before (discovered factions).", default = false},
    {key = "relation", text = "Relations", tt = "Defeated factions prefer to join factions they they had the best diplomatic relations with.", default = false},
    --{key = "alternate", text = "Dilemma alternates (MP only)", tt = "Dilemma alternates between Players of the same subculture (applies to MP only).", default = false},
    {key = "race", text = "same Race", tt = "Factions of the same race will be prefered over factions of a different race.", default = false},
})
--preferance6:add_dropdown_value("disable", "Disable", "Preference Level-6 disabled.", true)
--preferance6:add_dropdown_value("player", "Player", "Factions led by a Player will be prefered over AI factions.")
--preferance6:add_dropdown_value("ai", "AI", "Factions led by the AI will be prefered over player-led factions.")
--preferance6:add_dropdown_value("major", "Major Factions", "Playable Factions (Major) will be prefered over Minor factions.")
--preferance6:add_dropdown_value("minor", "Minor Factions", "Minor Factions will be prefered over playable (Major) factions")
--preferance6:add_dropdown_value("met", "Factions met", "Defeated factions preferably join factions they they met before (discovered factions).")
--preferance6:add_dropdown_value("relation", "Relations", "Defeated factions prefer to join factions they they had the best diplomatic relations with.")
--preferance6:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)")

recruit_defeated:add_new_section("specific_restriction", loc_prefix.."section_specific_restriction", true)

--Defines whether defeated Lords/Heroes can join any faction of the same subculture or if they are restricted from joining factions that make little to no sense considering their background.
--||Restrictions are in place for the following factions: 
--|| - Khemri (no Arkhan) 
--|| - Lybaras/Exiles of Nehek/Numas (no Settra/Arkhan)
--||Recruit Defeated is disabled for the following cultures/factions: 
--|| - Vampire Coast, Savage Orcs, Followers of Nagash

local tmb_restriction = recruit_defeated:add_new_option("a_tmb_restriction", "checkbox")
tmb_restriction:set_default_value(false)
tmb_restriction:set_text(loc_prefix.."a_tmb_restriction_txt", true)
tmb_restriction:set_tooltip_text(loc_prefix.."a_tmb_restriction_tt", true)

local cst_restriction = recruit_defeated:add_new_option("b_cst_restriction", "checkbox")
cst_restriction:set_default_value(false)
cst_restriction:set_text(loc_prefix.."b_cst_restriction_txt", true)
cst_restriction:set_tooltip_text(loc_prefix.."b_cst_restriction_tt", true)

local wef_restriction = recruit_defeated:add_new_option("d_wef_restriction", "checkbox")
wef_restriction:set_default_value(false)
wef_restriction:set_text(loc_prefix.."d_wef_restriction_txt", true)
wef_restriction:set_tooltip_text(loc_prefix.."d_wef_restriction_tt", true)

--local savage_restriction = recruit_defeated:add_new_option("c_savage_restriction", "checkbox")
--savage_restriction:set_default_value(true)
--savage_restriction:set_text(loc_prefix.."c_savage_restriction_txt", true)
--savage_restriction:set_tooltip_text(loc_prefix.."c_savage_restriction_tt", true)

recruit_defeated:add_new_section("beta_options", loc_prefix.."section_beta_options", true)

local playable_faction_only = recruit_defeated:add_new_option("playable_faction_only", "checkbox")
playable_faction_only:set_default_value(false)
playable_faction_only:set_text(loc_prefix.."playable_faction_only_txt", true)
playable_faction_only:set_tooltip_text(loc_prefix.."playable_faction_only_tt", true)

local include_seccessionists = recruit_defeated:add_new_option("include_seccessionists", "checkbox")
include_seccessionists:set_default_value(false)
include_seccessionists:set_text(loc_prefix.."include_seccessionists_txt", true)
include_seccessionists:set_tooltip_text(loc_prefix.."include_seccessionists_tt", true)

local dilemmas_per_turn = recruit_defeated:add_new_option("dilemmas_per_turn", "slider")
dilemmas_per_turn:set_text(loc_prefix.."dilemmas_per_turn_txt", true)
dilemmas_per_turn:set_tooltip_text(loc_prefix.."dilemmas_per_turn_tt", true)
dilemmas_per_turn:slider_set_min_max(1, 20)
dilemmas_per_turn:set_default_value(10)
dilemmas_per_turn:slider_set_step_size(1)

local dilemmas_per_turn_player = recruit_defeated:add_new_option("dilemmas_per_turn_player", "slider")
dilemmas_per_turn_player:set_text(loc_prefix.."dilemmas_per_turn_player_txt", true)
dilemmas_per_turn_player:set_tooltip_text(loc_prefix.."dilemmas_per_turn_player_tt", true)
dilemmas_per_turn_player:slider_set_min_max(1, 10)
dilemmas_per_turn_player:set_default_value(1)
dilemmas_per_turn_player:slider_set_step_size(1)

--local dilemmas_per_turn_per_sc = recruit_defeated:add_new_option("dilemmas_per_turn_per_sc", "slider")
--dilemmas_per_turn_per_sc:set_text(loc_prefix.."dilemmas_per_turn_per_sc_txt", true)
--dilemmas_per_turn_per_sc:set_tooltip_text(loc_prefix.."dilemmas_per_turn_per_sc_tt", true)
--dilemmas_per_turn_per_sc:slider_set_min_max(1, 5)
--dilemmas_per_turn_per_sc:set_default_value(1)
--dilemmas_per_turn_per_sc:slider_set_step_size(1)

local chs_restriction = recruit_defeated:add_new_option("chs_restriction", "dropdown")
chs_restriction:set_text(loc_prefix.."chs_restriction_txt", true)
chs_restriction:set_tooltip_text(loc_prefix.."chs_restriction_tt", true)
chs_restriction:add_dropdown_values({
    {key = "no_restrictions", text = "No Restrictions", tt = "All of the following races can join each other:"
    .."|| - Warriors of Chaos|| - Norsca|| - Daemons of Chaos|| - Khorne|| - Nurgle|| - Slaanesh|| - Tzeentch", default = true},
    {key = "loreful_restrictions", text = "Loreful Restrictions", tt = "The following restrictions will applied:"
    .."|| - Archaon's, Be'lakor's and the Daemon Prince's faction are the only ones that can accept refugees from all other chaos factions except each other."
    .."|| - Mono-god faction can only accept refugees from factions of their respective race and their god's champion (and vice versa)."
    .."|| - Sigvald counts as a champion of Slaanesh."
    .."|| - Kholek can't accept refugees from anyone."
    .."|| - Factions and Races not, e.g. Norsca, can only accept refugees from their respective race."
    , default = false},
    {key = "ca_restrictions", text = "CA's Restrictions", tt = "Only Archaon and Be'lakor can accept refugees and solely from other factions of the \"Warriors of Chaos\" race.", default = false},
    --{key = "disabled", text = "Disabled", tt = "", default = false},
})

local cross_race = recruit_defeated:add_new_option("cross_race", "dropdown")
cross_race:set_text(loc_prefix.."cross_race_txt", true)
cross_race:set_tooltip_text(loc_prefix.."cross_race_tt", true)
cross_race:add_dropdown_values({
    {key = "disable", text = "Disable", tt = "Cross-Race mode disabled.", default = true},
    {key = "player_only", text = "Player only", tt = "Player only Cross-Race mode.", default = false},
    {key = "player_ai", text = "Player & AI", tt = "Player & AI Cross-Race mode.", default = false},
})

local mortals = recruit_defeated:add_new_option("mortals", "dropdown")
mortals:set_text(loc_prefix.."mortals_txt", true)
mortals:set_tooltip_text(loc_prefix.."mortals_tt", true)
mortals:add_dropdown_values({
    {key = "disable", text = "Disable", tt = "Only immortal/legendary Lords/Heroes are transfered.", default = true},
    {key = "faction_leader", text = "Faction Leader", tt = "Faction leaders are also transfered.", default = false},
    {key = "all", text = "All Lords & Heroes", tt = "All Lords/Heroes are being transfered, not only immortal/legendary ones.", default = false},
})

local nakai_vassal = recruit_defeated:add_new_option("nakai_vassal", "dropdown")
nakai_vassal:set_text(loc_prefix.."nakai_vassal_txt", true)
nakai_vassal:set_tooltip_text(loc_prefix.."nakai_vassal_tt", true)
nakai_vassal:add_dropdown_values({
    {key = "do_nothing", text = "Do nothing", tt = "Let the vassal keep its settlements.", default = true},
    {key = "confederate", text = "Transfer", tt = "Transfer the vassal's settlements to the faction nakai joined.", default = false},
    {key = "abandon", text = "Abandon", tt = "Abandon all settlements they occupied.", default = false},
})

--local legendary_confed = recruit_defeated:add_new_option("legendary_confed", "dropdown")
--legendary_confed:set_text(loc_prefix.."legendary_confed_txt", true)
--legendary_confed:set_tooltip_text(loc_prefix.."legendary_confed_tt", true)
--legendary_confed:add_dropdown_values({
--    {key = "disable", text = "Do nothing", tt = "", default = true},
--    --{key = "confederate", text = "Confederate", tt = "Confederates all factions of your race.", default = false},
--    {key = "chars_only", text = "Legendary Lords/Heroes only", tt = "Confederates all factions of your race, but returns armies and territory.", default = false},
--})

recruit_defeated:set_section_sort_function("index_sort")

local options_list = {
    "c_scope",
    "d_ai_delay",
    "a_preferance1",
    "b_preferance2",
    "c_preferance3",
    "d_preferance4",
    "e_preferance5",
    "f_preferance6",
} --:vector<string>

local sections_list = {
    "restrictions",
    "preferences",
    "specific_restriction",
    "beta_options",
} --:vector<string>

enable:add_option_set_callback(
    function(option) 
        local val = option:get_selected_setting() 
        --# assume val: boolean
        local options = options_list
        local sections = sections_list
        local recruit_defeated = option:get_mod()
        --for i = 1, #options do
        --    local option_obj = recruit_defeated:get_option_by_key(options[i])
        --    option_obj:set_uic_visibility(val)
        --end
        for i = 1, #sections do
            local section_obj = recruit_defeated:get_section_by_key(sections[i])
            section_obj:set_visibility (val)
        end
    end
)