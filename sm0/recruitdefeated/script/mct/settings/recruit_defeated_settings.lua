local loc_prefix = "mct_recruit_defeated_"
local recruit_defeated = mct:register_mod("recruit_defeated")
recruit_defeated:set_title(loc_prefix.."mod_title", true)
recruit_defeated:set_author("Militus Immortalis & sm0kin")
recruit_defeated:set_description(loc_prefix.."mod_desc", true)

local enable = recruit_defeated:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."a_enable_txt", true)
enable:set_tooltip_text(loc_prefix.."a_enable_tt", true)

recruit_defeated:add_new_section("restrictions", loc_prefix.."section_restrictions")

local lore_restriction = recruit_defeated:add_new_option("b_lore_restriction", "checkbox")
lore_restriction:set_default_value(false)
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

recruit_defeated:add_new_section("priorities", loc_prefix.."section_priorities")

local preferance1 = recruit_defeated:add_new_option("a_preferance1", "dropdown")
preferance1:set_text(loc_prefix.."a_preferance1_txt", true)
preferance1:set_tooltip_text(loc_prefix.."a_preferance1_tt", true)
preferance1:add_dropdown_value("disable", "Disable", "")
preferance1:add_dropdown_value("player", "Prefer Player", "")
preferance1:add_dropdown_value("ai", "Prefer AI", "")
preferance1:add_dropdown_value("major", "Prefer Major Factions", "")
preferance1:add_dropdown_value("minor", "Prefer Minor Factions", "")
preferance1:add_dropdown_value("met", "Prefer Factions met", "")
preferance1:add_dropdown_value("relation", "Relation based", "")

local preferance2 = recruit_defeated:add_new_option("b_preferance2", "dropdown")
preferance2:set_text(loc_prefix.."b_preferance2_txt", true)
preferance2:set_tooltip_text(loc_prefix.."b_preferance2_tt", true)
preferance2:add_dropdown_value("disable", "Disable", "")
preferance2:add_dropdown_value("player", "Prefer Player", "")
preferance2:add_dropdown_value("ai", "Prefer AI", "")
preferance2:add_dropdown_value("major", "Prefer Major Factions", "")
preferance2:add_dropdown_value("minor", "Prefer Minor Factions", "")
preferance2:add_dropdown_value("met", "Prefer Factions met", "")
preferance2:add_dropdown_value("relation", "Relation based", "")

local preferance3 = recruit_defeated:add_new_option("c_preferance3", "dropdown")
preferance3:set_text(loc_prefix.."c_preferance3_txt", true)
preferance3:set_tooltip_text(loc_prefix.."c_preferance3_tt", true)
preferance3:add_dropdown_value("disable", "Disable", "")
preferance3:add_dropdown_value("player", "Prefer Player", "")
preferance3:add_dropdown_value("ai", "Prefer AI", "")
preferance3:add_dropdown_value("major", "Prefer Major Factions", "")
preferance3:add_dropdown_value("minor", "Prefer Minor Factions", "")
preferance3:add_dropdown_value("met", "Prefer Factions met", "")
preferance3:add_dropdown_value("relation", "Relation based", "")

local options_list = {
    "b_lore_restriction",
    "c_scope",
    "d_ai_delay",
    "a_preferance1",
    "b_preferance2",
    "c_preferance3"
} --:vector<string>

local sections_list = {
    "restrictions",
    "priorities"
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