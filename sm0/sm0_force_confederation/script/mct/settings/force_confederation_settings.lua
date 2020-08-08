--# assume mct: MCT
local loc_prefix = "mct_force_confederation_"
local force_confed = mct:register_mod("force_confed")
force_confed:set_title(loc_prefix.."mod_title", true)
force_confed:set_author("sm0kin")
force_confed:set_description(loc_prefix.."mod_desc", true)

local enable = force_confed:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."a_enable_txt", true)
enable:set_tooltip_text(loc_prefix.."a_enable_tt", true)

local restriction = force_confed:add_new_option("b_restriction", "checkbox")
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