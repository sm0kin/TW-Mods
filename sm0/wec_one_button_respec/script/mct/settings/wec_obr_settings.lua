local loc_prefix = "mct_obr_"
local obr = mct:register_mod("obr")
obr:set_title(loc_prefix.."mod_title", true)
obr:set_author("Drunk Flamingo & sm0kin")
obr:set_description(loc_prefix.."mod_desc", true)

local enable = obr:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."a_enable_txt", true)
enable:set_tooltip_text(loc_prefix.."a_enable_tt", true)

obr:add_new_section("respec_options", loc_prefix.."section_respec_options", true)

local limit = obr:add_new_option("a_limit", "checkbox")
limit:set_default_value(true)
limit:set_text(loc_prefix.."a_limit_txt", true)
limit:set_tooltip_text(loc_prefix.."a_limit_tt", true)

local en_cost = obr:add_new_option("b_en_cost", "dropdown")
en_cost:set_text(loc_prefix.."b_en_cost_txt", true)
en_cost:set_tooltip_text(loc_prefix.."b_en_cost_tt", true)
--en_cost:add_dropdown_value("disabled", loc_prefix.."b_en_cost_disabled_txt", loc_prefix.."b_en_cost_disabled_tt", true)
--en_cost:add_dropdown_value("firstforfree", loc_prefix.."b_en_cost_firstforfree_txt", loc_prefix.."b_en_cost_firstforfree_tt")
--en_cost:add_dropdown_value("enabled", loc_prefix.."b_en_cost_enabled_txt", loc_prefix.."b_en_cost_enabled_tt")
en_cost:add_dropdown_value("disabled", "Disable", "Disable respec cost.", true)
en_cost:add_dropdown_value("firstforfree", "Free 1st Respec", "Respeccing a Character is free the 1st time.")
en_cost:add_dropdown_value("enabled", "Enable", "Respeccing always entails costs.")

local cost = obr:add_new_option("c_cost", "slider")
cost:set_text(loc_prefix.."c_cost_txt", true)
cost:set_tooltip_text(loc_prefix.."c_cost_tt", true)
cost:slider_set_min_max(100, 1000)
cost:set_default_value(500)
cost:slider_set_step_size(100)

local options_list = {
    "a_limit",
    "c_cost",
    "b_en_cost"
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