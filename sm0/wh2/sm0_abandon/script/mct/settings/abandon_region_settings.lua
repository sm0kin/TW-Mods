--# assume mct: MCT
local loc_prefix = "mct_abandon_region_"
local abandon_region = mct:register_mod("abandon_region")
abandon_region:set_title(loc_prefix.."mod_title", true)
abandon_region:set_author("sm0kin & Un Poisson Rouge")
abandon_region:set_description(loc_prefix.."mod_desc", true)

local enable = abandon_region:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."a_enable_txt", true)
enable:set_tooltip_text(loc_prefix.."a_enable_tt", true)

local delay = abandon_region:add_new_option("b_delay", "dropdown")
delay:set_text(loc_prefix.."b_delay_txt", true)
delay:set_tooltip_text(loc_prefix.."b_delay_tt", true)
--delay:add_dropdown_value("instant", loc_prefix.."b_delay_instant_txt", loc_prefix.."b_delay_instant_tt", true)
--delay:add_dropdown_value("one_turn", loc_prefix.."b_delay_one_turn_txt", loc_prefix.."b_delay_one_turn_tt")
delay:add_dropdown_value("instant", "No delay", "Regions can be abandoned instantly.")
delay:add_dropdown_value("one_turn", "One Turn", "Abandoning a region takes one turn.")

abandon_region:add_new_section("po_penalty_options", loc_prefix.."section_po_penalty_options", true)

local penalty = abandon_region:add_new_option("a_penalty", "checkbox")
penalty:set_default_value(true)
penalty:set_text(loc_prefix.."a_penalty_txt", true)
penalty:set_tooltip_text(loc_prefix.."a_penalty_tt", true)

local penalty_scope = abandon_region:add_new_option("c_penalty_scope", "dropdown")
penalty_scope:set_text(loc_prefix.."c_penalty_scope_txt", true)
penalty_scope:set_tooltip_text(loc_prefix.."c_penalty_scope_tt", true)
--penalty_scope:add_dropdown_value("global", loc_prefix.."c_penalty_scope_global_txt", loc_prefix.."c_penalty_scope_global_tt", true)
--penalty_scope:add_dropdown_value("local", loc_prefix.."c_penalty_scope_local_txt", loc_prefix.."c_penalty_scope_local_tt")
penalty_scope:add_dropdown_value("global", "Global", "Global Public Order penalty.")
penalty_scope:add_dropdown_value("local", "Local", "Local Public Order penalty.")

local penalty_tier = abandon_region:add_new_option("b_penalty_tier", "checkbox")
penalty_tier:set_default_value(true)
penalty_tier:set_text(loc_prefix.."b_penalty_tier_txt", true)
penalty_tier:set_tooltip_text(loc_prefix.."b_penalty_tier_tt" , true)

local options_list = {
    "b_delay",
    "a_penalty",
    "c_penalty_scope",
    "b_penalty_tier"
} --:vector<string>

--local po_option_list = {
--    "c_penalty_scope",
--    "b_penalty_tier"
--} --:vector<string>

enable:add_option_set_callback(
    function(option) 
        local val = option:get_selected_setting() 
        --# assume val: boolean
        local options = options_list

        for i = 1, #options do
            local option_obj = option:get_mod():get_option_by_key(options[i])
            option_obj:set_uic_visibility(val)
        end
        --option:get_mod():set_section_visibility("po_penalty_options", val)
    end
)

--penalty:add_option_set_callback(
--    function(option) 
--        local val = option:get_selected_setting()
--        --# assume val: boolean
--        local options = po_option_list
--
--        local enable_obj = option:get_mod():get_option_by_key("a_enable")
--        local enable_val = enable_obj:get_selected_setting()
--        if enable_val then
--            for i = 1, #po_option_list do
--                local option_obj = option:get_mod():get_option_by_key(options[i])
--                option_obj:set_uic_visibility(val)
--            end
--        end
--    end
--)