local abandon_region = mct:register_mod("abandon_region")
abandon_region:set_title("Abandon Region", false)
abandon_region:set_author("sm0kin & Un Poisson Rouge", false)
abandon_region:set_description("This mod brings back Total War Attila's region abandoning feature.", false)

local enable = abandon_region:add_new_option("a_enable", "checkbox")
enable:set_default_value(true)
enable:set_text("Mod Enable", false)
enable:set_tooltip_text("Enables or disables the mod.", false)
enable:set_read_only(false)

local delay = abandon_region:add_new_option("b_delay", "dropdown")
delay:set_text("Delay until Regions are abandoned", false)
delay:set_tooltip_text("Choose between no delay and single turn delay until Regions are abandoned.", false)
delay:set_read_only(false)
delay:add_dropdown_value("instant", "No delay", "Regions can be abandoned instantly.")
delay:add_dropdown_value("one_turn", "One Turn", "Abandoning a region takes one turn.")
delay:set_default_value("instant")

abandon_region:add_new_section("po_penalty_options", "Public Order - Options")

local penalty = abandon_region:add_new_option("a_penalty", "checkbox")
penalty:set_default_value(true)
penalty:set_text("Penalty Enable", false)
penalty:set_tooltip_text("Enable/Disable the public order penalty for abandoning one of your regions.", false)
penalty:set_read_only(false)

local penalty_scope = abandon_region:add_new_option("c_penalty_scope", "dropdown")
penalty_scope:set_text("Penalty effect scope", false)
penalty_scope:set_tooltip_text("Local/Global public order penalty for abandoning one of your regions.", false)
penalty_scope:set_read_only(false)
penalty_scope:add_dropdown_value("global", "Global", "Global Public Order penalty.")
penalty_scope:add_dropdown_value("local", "Local", "Local Public Order penalty.")
penalty_scope:set_default_value("global")

local penalty_tier = abandon_region:add_new_option("b_penalty_tier", "checkbox")
penalty_tier:set_default_value(true)
penalty_tier:set_text("Penalty settlement tier based", false)
penalty_tier:set_tooltip_text("Public order penalty for abandoning one of your regions based on the settlement tier.".. 
"\nE.g.: Abandoning a tier 4 settlement results in a -4 PO penalty whereas abandoning a tier 1 settlement only results in a -1 PO penalty." , false)
penalty_tier:set_read_only(false)

local options_list = {
    "b_delay",
    "a_penalty",
    "c_penalty_scope",
    "b_penalty_tier"
}

local po_option_list = {
    "c_penalty_scope",
    "b_penalty_tier"
}

enable:add_option_set_callback(
    function(option) 
        local val = option:get_selected_setting()
        local options = options_list

        for i = 1, #options do
            local option_obj = option:get_mod():get_option_by_key(options[i])
            option_obj:set_uic_visibility(val)
        end
    end
)

penalty:add_option_set_callback(
    function(option) 
        local val = option:get_selected_setting()
        local options = po_option_list

        for i = 1, #po_option_list do
            local option_obj = option:get_mod():get_option_by_key(options[i])
            option_obj:set_uic_visibility(val)
        end
    end
)