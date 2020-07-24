local loc_prefix = "mct_lords_of_change_"
local lords_of_change = mct:register_mod("lords_of_change")
lords_of_change:set_title(loc_prefix.."mod_title", true)
lords_of_change:set_author("FrostyDemise & sm0kin")
lords_of_change:set_description(loc_prefix.."mod_desc", true)

local enable = lords_of_change:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."a_enable_txt", true)
enable:set_tooltip_text(loc_prefix.."a_enable_tt", true)

lords_of_change:add_new_section("advanced_options", "Advanced - Options")

local which_bird = lords_of_change:add_new_option("a_which_bird", "dropdown")
which_bird:set_text(loc_prefix.."a_which_bird_txt", true)
which_bird:set_tooltip_text(loc_prefix.."a_which_bird_tt", true)
which_bird:add_dropdown_value("both", "Both", "", true)
which_bird:add_dropdown_value("only_sarthorael", "Sarthorael Only", "")
which_bird:add_dropdown_value("only_azrik", "Azrik Only", "")

local boost = lords_of_change:add_new_option("b_boost", "checkbox")
boost:set_default_value(true)
boost:set_text(loc_prefix.."b_boost_txt", true)
boost:set_tooltip_text(loc_prefix.."b_boost_tt", true)

local when = lords_of_change:add_new_option("c_when", "checkbox")
when:set_default_value(false)
when:set_text(loc_prefix.."c_when_txt", true)
when:set_tooltip_text(loc_prefix.."c_when_tt", true)

local options_list = {
    "a_which_bird",
    "b_boost",
    "c_when"
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
        --option:get_mod():set_section_visibility("respec_options", val)
    end
)