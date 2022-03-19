local loc_prefix = "sr_"
local sr = mct:register_mod("sr")
sr:set_title(loc_prefix.."mod_title", true)
sr:set_author("shakyrivers")
sr:set_description(loc_prefix.."mod_desc", true)

local enable = sr:add_new_option("enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."enable_txt", true)
enable:set_tooltip_text(loc_prefix.."enable_tt", true)

sr:add_new_section("sr_options", loc_prefix.."section_options", true) 

local options_list = {
    "vampcolony",
    "worldroots",
    "crusade_plus",
    "delfcolonies",
    "dwarfcolonies",
    "elvencolonies",
    "k8p",
    "lizawaken",
    "norraid",
    "orcwaagh",
    "tombking",
    "vermintide"
} --:vector<string>

for _, option in ipairs(options_list) do
    local option_obj = sr:add_new_option(option, "checkbox")
    option_obj:set_default_value(true)
    option_obj:set_text(loc_prefix..option.."_txt", true)
    option_obj:set_tooltip_text(loc_prefix..option.."_tt", true)
end

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