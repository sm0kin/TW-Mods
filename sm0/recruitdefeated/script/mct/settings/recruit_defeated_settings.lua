local loc_prefix = "mct_recruit_defeated_"
local recruit_defeated = mct:register_mod("recruit_defeated")
recruit_defeated:set_title(loc_prefix.."mod_title", true)
recruit_defeated:set_author("sm0kin")
recruit_defeated:set_description(loc_prefix.."mod_desc", true)

local enable = recruit_defeated:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."a_enable_txt", true)
enable:set_tooltip_text(loc_prefix.."a_enable_tt", true)

local restriction = recruit_defeated:add_new_option("b_restriction", "checkbox")
restriction:set_default_value(true)
restriction:set_text(loc_prefix.."b_restriction_txt", true)
restriction:set_tooltip_text(loc_prefix.."b_restriction_tt", true)

enable:add_option_set_callback(
    function(option) 
        local val = option:get_selected_setting()
        --# assume val: boolean
        local restriction = option:get_mod():get_option_by_key("b_restriction")
        restriction:set_uic_visibility(val)
    end
)

local recruit_defeated = mcm:register_mod("recruit_defeated", "Recruit Defeated Legendary Lords", "")
--if legacy_option then
--    local version = recruit_defeated:add_tweaker("version", "Mod Version", "Choose your prefered mod version.")
--    version:add_option("default", "Default", "This script uses confederation methods to transfer legendary lords from dead factions to the player/ai. Written by sm0kin.")
--    version:add_option("legacy", "Legacy", "DISCONTINUED VERSION!!!\nThis script uses spawn methods to create doppelganger lords and deletes the original legendary lords in case the faction gets revived. Written by Scipion. Originally by scipion, reworked by sm0kin.")
--end
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