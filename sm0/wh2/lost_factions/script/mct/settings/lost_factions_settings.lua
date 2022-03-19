--# assume mct: MCT
local loc_prefix = "mct_lost_factions_"
local lost_factions = mct:register_mod("lost_factions")
lost_factions:set_title(loc_prefix.."mod_title", true)
lost_factions:set_author("shakyrivers")
lost_factions:set_description(loc_prefix.."mod_desc", true)

local enable = lost_factions:add_new_option("enable", "checkbox")
enable:set_default_value(true)
enable:set_text(loc_prefix.."enable_txt", true)
enable:set_tooltip_text(loc_prefix.."enable_tt", true)

lost_factions:add_new_section("lost_factions_options", loc_prefix.."section_options", true) 

local options_list = {
    "amazon",
    "araby",
    "blood_dragon",
    "citadel",
    "halflings",
    "trollz",
    "treeblood",
    "albion",
    "fimir",
    "grudgebringers",
    "dreadking",
    "rotblood"
} --:vector<string>

for _, option in ipairs(options_list) do
    local option_obj = lost_factions:add_new_option(option, "checkbox")
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