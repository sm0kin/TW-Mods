--[[
--# assume mct: MCT
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

recruit_defeated:add_new_section("preferences", loc_prefix.."section_preferences", true)

local preferance1 = recruit_defeated:add_new_option("a_preferance1", "dropdown")
preferance1:set_text(loc_prefix.."a_preferance1_txt", true)
preferance1:set_tooltip_text(loc_prefix.."a_preferance1_tt", true)
preferance1:add_dropdown_value("disable", "Disable", "Preference Level-1 disabled.")
preferance1:add_dropdown_value("player", "Prefer Player", "Factions led by a Player will be prefered over AI factions.", true)
preferance1:add_dropdown_value("ai", "Prefer AI", "Factions led by the AI will be prefered over player-led factions.")
preferance1:add_dropdown_value("major", "Prefer Major Factions", "Playable Factions (Major) will be prefered over Minor factions.")
preferance1:add_dropdown_value("minor", "Prefer Minor Factions", "Minor Factions will be prefered over playable (Major) factions")
preferance1:add_dropdown_value("met", "Prefer Factions met", "Defeated factions preferably join factions they they met before (discovered factions).")
preferance1:add_dropdown_value("relation", "Relation based", "Defeated factions prefer to join factions they they had the best diplomatic relations with.")
preferance1:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)")

local preferance2 = recruit_defeated:add_new_option("b_preferance2", "dropdown")
preferance2:set_text(loc_prefix.."b_preferance2_txt", true)
preferance2:set_tooltip_text(loc_prefix.."b_preferance2_tt", true)
preferance2:add_dropdown_value("disable", "Disable", "Preference Level-2 disabled.")
preferance2:add_dropdown_value("player", "Prefer Player", "Factions led by a Player will be prefered over AI factions.")
preferance2:add_dropdown_value("ai", "Prefer AI", "Factions led by the AI will be prefered over player-led factions.")
preferance2:add_dropdown_value("major", "Prefer Major Factions", "Playable Factions (Major) will be prefered over Minor factions.")
preferance2:add_dropdown_value("minor", "Prefer Minor Factions", "Minor Factions will be prefered over playable (Major) factions.")
preferance2:add_dropdown_value("met", "Prefer Factions met", "Defeated factions preferably join factions they they met before (discovered factions).")
preferance2:add_dropdown_value("relation", "Relation based", "Defeated factions prefer to join factions they they had the best diplomatic relations with.")
preferance2:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)", true)

local preferance3 = recruit_defeated:add_new_option("c_preferance3", "dropdown")
preferance3:set_text(loc_prefix.."c_preferance3_txt", true)
preferance3:set_tooltip_text(loc_prefix.."c_preferance3_tt", true)
preferance3:add_dropdown_value("disable", "Disable", "Preference Level-3 disabled.")
preferance3:add_dropdown_value("player", "Prefer Player", "Factions led by a Player will be prefered over AI factions.")
preferance3:add_dropdown_value("ai", "Prefer AI", "Factions led by the AI will be prefered over player-led factions.")
preferance3:add_dropdown_value("major", "Prefer Major Factions", "Playable Factions (Major) will be prefered over Minor factions.")
preferance3:add_dropdown_value("minor", "Prefer Minor Factions", "Minor Factions will be prefered over playable (Major) factions")
preferance3:add_dropdown_value("met", "Prefer Factions met", "Defeated factions preferably join factions they they met before (discovered factions).", true)
preferance3:add_dropdown_value("relation", "Relation based", "Defeated factions prefer to join factions they they had the best diplomatic relations with.")
preferance3:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)")

local preferance4 = recruit_defeated:add_new_option("d_preferance4", "dropdown")
preferance4:set_text(loc_prefix.."d_preferance4_txt", true)
preferance4:set_tooltip_text(loc_prefix.."d_preferance4_tt", true)
preferance4:add_dropdown_value("disable", "Disable", "Preference Level-4 disabled.")
preferance4:add_dropdown_value("player", "Prefer Player", "Factions led by a Player will be prefered over AI factions.")
preferance4:add_dropdown_value("ai", "Prefer AI", "Factions led by the AI will be prefered over player-led factions.")
preferance4:add_dropdown_value("major", "Prefer Major Factions", "Playable Factions (Major) will be prefered over Minor factions.")
preferance4:add_dropdown_value("minor", "Prefer Minor Factions", "Minor Factions will be prefered over playable (Major) factions")
preferance4:add_dropdown_value("met", "Prefer Factions met", "Defeated factions preferably join factions they they met before (discovered factions).")
preferance4:add_dropdown_value("relation", "Relation based", "Defeated factions prefer to join factions they they had the best diplomatic relations with.", true)
preferance4:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)")

local preferance5 = recruit_defeated:add_new_option("e_preferance5", "dropdown")
preferance5:set_text(loc_prefix.."e_preferance5_txt", true)
preferance5:set_tooltip_text(loc_prefix.."e_preferance5_tt", true)
preferance5:add_dropdown_value("disable", "Disable", "Preference Level-5 disabled.")
preferance5:add_dropdown_value("player", "Prefer Player", "Factions led by a Player will be prefered over AI factions.")
preferance5:add_dropdown_value("ai", "Prefer AI", "Factions led by the AI will be prefered over player-led factions.")
preferance5:add_dropdown_value("major", "Prefer Major Factions", "Playable Factions (Major) will be prefered over Minor factions.", true)
preferance5:add_dropdown_value("minor", "Prefer Minor Factions", "Minor Factions will be prefered over playable (Major) factions")
preferance5:add_dropdown_value("met", "Prefer Factions met", "Defeated factions preferably join factions they they met before (discovered factions).")
preferance5:add_dropdown_value("relation", "Relation based", "Defeated factions prefer to join factions they they had the best diplomatic relations with.")
preferance5:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)")

local preferance6 = recruit_defeated:add_new_option("f_preferance6", "dropdown")
preferance6:set_text(loc_prefix.."f_preferance6_txt", true)
preferance6:set_tooltip_text(loc_prefix.."f_preferance6_tt", true)
preferance6:add_dropdown_value("disable", "Disable", "Preference Level-6 disabled.", true)
preferance6:add_dropdown_value("player", "Prefer Player", "Factions led by a Player will be prefered over AI factions.")
preferance6:add_dropdown_value("ai", "Prefer AI", "Factions led by the AI will be prefered over player-led factions.")
preferance6:add_dropdown_value("major", "Prefer Major Factions", "Playable Factions (Major) will be prefered over Minor factions.")
preferance6:add_dropdown_value("minor", "Prefer Minor Factions", "Minor Factions will be prefered over playable (Major) factions")
preferance6:add_dropdown_value("met", "Prefer Factions met", "Defeated factions preferably join factions they they met before (discovered factions).")
preferance6:add_dropdown_value("relation", "Relation based", "Defeated factions prefer to join factions they they had the best diplomatic relations with.")
preferance6:add_dropdown_value("alternate", "Dilemma alternates (MP only)", "Dilemma alternates between Players of the same subculture (applies to MP only)")

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

local options_list = {
    "c_scope",
    "d_ai_delay",
    "a_preferance1",
    "b_preferance2",
    "c_preferance3",
    "d_preferance4",
    "e_preferance5",
    "f_preferance6"
} --:vector<string>

local sections_list = {
    "restrictions",
    "priorities",
    "specific_restriction"
} --:vector<string>

enable:add_option_set_callback(
    function(option) 
        local val = option:get_selected_setting() 
        --# assume val: boolean
        local options = options_list
        local sections = sections_list
        for i = 1, #options do
            local option_obj = option:get_mod():get_option_by_key(options[i])
            option_obj:set_uic_visibility(val)
        end
        --for i = 1, #sections do
        --    option:get_mod():set_section_visibility(sections[i], val)
        --end
    end
)
--]]