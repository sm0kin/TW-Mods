local loc_prefix = "mct_recruit_defeated_"
local recruit_defeated = mct:register_mod("recruit_defeated")
recruit_defeated:set_title(loc_prefix.."mod_title", true)
recruit_defeated:set_author("sm0kin")
recruit_defeated:set_description(loc_prefix.."mod_desc", true)

local enable = recruit_defeated:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."a_enable_txt", true)
enable:set_tooltip_text(loc_prefix.."a_enable_tt", true)

recruit_defeated:add_new_section("restrictions", "Restrictions")

local lore_restriction = recruit_defeated:add_new_option("b_lore_restriction", "checkbox")
lore_restriction:set_default_value(true)
lore_restriction:set_text(loc_prefix.."b_lore_restriction_txt", true)
lore_restriction:set_tooltip_text(loc_prefix.."b_lore_restriction_tt", true)

local scope = recruit_defeated:add_new_option("c_scope", "dropdown")
scope:set_text(loc_prefix.."c_scope_txt", true)
scope:set_tooltip_text(loc_prefix.."c_scope_tt", true)
--scope:add_dropdown_value("player_ai", loc_prefix.."c_scope_player_ai_txt", loc_prefix.."c_scope_player_ai_tt", true)
--scope:add_dropdown_value("player", loc_prefix.."c_scope_player_txt", loc_prefix.."c_scope_player_tt")
--scope:add_dropdown_value("ai", loc_prefix.."c_scope_ai_txt", loc_prefix.."c_scope_ai_tt")
scope:add_dropdown_value("player_ai", "Player & AI", "")
scope:add_dropdown_value("player", "Player only", "")
scope:add_dropdown_value("ai", "AI only", "")

local ai_delay = recruit_defeated:add_new_option("d_ai_delay", "slider")
ai_delay:set_text(loc_prefix.."d_ai_delay_txt", true)
ai_delay:set_tooltip_text(loc_prefix.."d_ai_delay_tt", true)
ai_delay:slider_set_min_max(0, 200)
ai_delay:set_default_value(50)
ai_delay:slider_set_step_size(5)

recruit_defeated:add_new_section("priorities", "Priorities")

local preferance1 = recruit_defeated:add_new_option("a_preferance1", "dropdown")
preferance1:set_text(loc_prefix.."a_preferance1_txt", true)
preferance1:set_tooltip_text(loc_prefix.."a_preferance1_tt", true)
preferance1:add_dropdown_value("disable", "", "")
preferance1:add_dropdown_value("player", "", "")
preferance1:add_dropdown_value("ai", "", "")
preferance1:add_dropdown_value("relation", "", "")
preferance1:add_dropdown_value("major", "", "")
preferance1:add_dropdown_value("minor", "", "")

local preferance2 = recruit_defeated:add_new_option("b_preferance2", "dropdown")
preferance2:set_text(loc_prefix.."b_preferance2_txt", true)
preferance2:set_tooltip_text(loc_prefix.."b_preferance2_tt", true)
preferance2:add_dropdown_value("disable", "", "")
preferance2:add_dropdown_value("player", "", "")
preferance2:add_dropdown_value("ai", "", "")
preferance2:add_dropdown_value("relation", "", "")
preferance2:add_dropdown_value("major", "", "")
preferance2:add_dropdown_value("minor", "", "")

local preferance3 = recruit_defeated:add_new_option("c_preferance3", "dropdown")
preferance3:set_text(loc_prefix.."c_preferance3_txt", true)
preferance3:set_tooltip_text(loc_prefix.."c_preferance3_tt", true)
preferance3:add_dropdown_value("disable", "", "")
preferance3:add_dropdown_value("player", "", "")
preferance3:add_dropdown_value("ai", "", "")
preferance3:add_dropdown_value("relation", "", "")
preferance3:add_dropdown_value("major", "", "")
preferance3:add_dropdown_value("minor", "", "")

local options_list = {
    "b_lore_restriction",
    "c_scope",
    "d_ai_delay",
    "a_preferance1",
    "b_preferance2",
    "c_preferance3"
} --:vector<string>

enable:add_option_set_callback(
    function(option) 
        local val = option:get_selected_setting() 
        --# assume val: boolean
        local options = options_list

        for i = 1, #options do
            local option_obj = option:get_mod():get_option_by_key(options[i])
            option_obj:set_uic_visibility(val)
        end
    end
)

local recruit_defeated = mcm:register_mod("recruit_defeated", "Recruit Defeated Legendary Lords", "")
local lore_restriction = recruit_defeated:add_tweaker("lore_restriction", "Restriction", "Defines whether defeated Lords/Heroes can join any faction of the same subculture or if they are restricted from joining factions that make little to no sense considering their background.") --mcm_tweaker_recruit_defeated_lore_restriction_value
lore_restriction:add_option("all", "Gotta Catch 'Em All", "No restrictions.")
lore_restriction:add_option("lorefriendly", "Lorefriendly", "Restrictions are in place for the following factions:\n*Khemri: no Arkhan\n*Lybaras/Exiles of Nehek/Numas: no Settra, no Arkhan\n\nRecruit Defeated is disabled for the following cultures/factions:\n*Vampire Coast\n*Savage Orcs\n*Followers of Nagash")
local scope = recruit_defeated:add_tweaker("scope", "Available for", "Specifies if defeated Lords/Heroes are allowed to join the player, the ai or both.") --mcm_tweaker_recruit_defeated_scope_value
scope:add_option("player_ai", "Player & AI", "")
scope:add_option("player", "Player only", "")
scope:add_option("ai", "AI only", "")
local preferance = recruit_defeated:add_tweaker("preferance", "Preference (1. Level)", "Should factions prefer to join the ai or the player (supersedes \"Preference (2. Level)\")?") --mcm_tweaker_recruit_defeated_preferance_value
preferance:add_option("player", "Prefer Player", "Defeated Lords/Heroes will always join a player-led faction.")
preferance:add_option("ai", "Prefer AI", "As long as a AI factions is left defeated Lords/Heroes will prefer them over the player.")
preferance:add_option("disable", "Disable", "No AI/Player preferance.")
local preferance2 = recruit_defeated:add_tweaker("preferance2", "Preference (2. Level)", "Which factions defeated lords/heroes prefer to join (superseded by \"Preference (1. Level)\"?") --mcm_tweaker_recruit_defeated_preferance2_value
preferance2:add_option("relation", "Relation based", "Defeated Lords/Heroes join the faction they have the best diplomatic relations with.")
preferance2:add_option("power", "Prefer Major Factions", "Defeated Lords/Heroes will prefer Major Factions.")
--local diplo = recruit_defeated:add_tweaker("diplo", "Lords/Heroes join factions based on diplomatic standing", "Defeated Lords/Heroes join the faction they have the best diplomatic relations with.") --mcm_tweaker_recruit_defeated_diplo_value
--diplo:add_option("enable", "Enable", "") 
--diplo:add_option("disable", "Disable", "")
local ai_delay = recruit_defeated:add_variable("ai_delay", 0, 200, 50, 5, "AI Turn Delay", "Determines at which turn the AI starts to get Lords/Heroes from defeated factions.")